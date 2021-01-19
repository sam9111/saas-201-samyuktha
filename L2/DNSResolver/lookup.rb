def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts 'Usage: ruby lookup.rb <domain>'
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines('zone')
# function to parse file and build a hash
def parse_dns(dns_raw)
  dns_records = {}
  dns_raw.each do |line|
    line = line.strip
    # skipping comments and blank lines
    if line == '' || line[0] == '#'
      next
    else
      line = line.split(', ')
      if line.length == 1
        # only domain name is available and entered in hash
        dns_records[line[0].to_sym] = { :type => nil }
        next
      elsif line.length == 2
        # alias does not exist
        dns_records[line[1].to_sym] = { :type => line[0] }
        next
      else
        dns_records[line[1].to_sym] = {}
      end

      if line[0] == 'A'
        # value for A records have only the type and the IP address of the domain
        dns_records[line[1].to_sym] = { :type => line[0], :IP => line[2] }
        
      elsif line[0] == 'CNAME'
        # value for CNAME records have only the type and the alias of the domain
        dns_records[line[1].to_sym] = { :type => line[0], :alias => line[2].to_sym }
      end
    end
  end
  dns_records
end

def resolve(dns_records, lookup_chain, domain)
  record = dns_records[domain.to_sym]
  #no key with given domain name
  if record == nil
    return lookup_chain.push("Error: record not found for #{domain}")
  end
  if record[:type] == nil #unknown type of record
    lookup_chain.push("Error: record type is unknown for #{domain}")
  elsif record[:type] == 'CNAME'
    if record[:alias] #unknown alias
      lookup_chain.push(record[:alias])
      resolve(dns_records, lookup_chain, record[:alias]) #recusive call
    else
      lookup_chain.push("Error: alias not found for #{domain}")
    end
  elsif record[:type] == 'A'
    lookup_chain.push(record[:IP])
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(' => ')
