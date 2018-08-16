From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] console: Add console=auto option
Date: Thu, 16 Aug 2018 13:23:26 -0400
Message-ID: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
References: <20180816141055.451-1-prarit@redhat.com>
 <20180816150948.GA10648@kroah.com>
 <4335912e-dab7-c516-d71e-47ed479c638a@redhat.com>
 <20180816113311.676971d0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180816113311.676971d0@gandalf.local.home>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 08/16/2018 11:33 AM, Steven Rostedt wrote:
> On Thu, 16 Aug 2018 11:28:24 -0400
> Prarit Bhargava <prarit@redhat.com> wrote:
> 
>> On 08/16/2018 11:09 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Aug 16, 2018 at 10:10:55AM -0400, Prarit Bhargava wrote:  
>>>> ACPI may contain an SPCR table that defines a default system console.
>>>> On ARM if the table is present then the SPCR console is enabled by default.
>>>> On x86 the SPCR console is used if 'earlycon' (no parameters) is
>>>> specified as a kernel parameter and is used only as the early console.
>>>> To use the SPCR data as a console a user must boot with 'earlycon',
>>>> grep logs & specify a console= kernel parameter, and then reboot again.
>>>>
>>>> Add 'console=auto' that enables a firmware or hardware console, and on
>>>> x86 enable the SPCR console if 'console=auto' is specified.
>>>>
>>>> Tested on systems with and without an ACPI SPCR.  The following kernel
>>>> parameters were also tested:
>>>>
>>>> console=ttyS0,115200    		works
>>>> earlycon                		works (early console only)
>>>> console=auto            		works (full console as expected)
>>>> no console or earlycon arguments	works (no output as expected)
>>>>
>>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>>> Cc: Mark Salter <msalter@redhat.com>
>>>> Cc: Al Stone <ahs3@redhat.com>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Cc: Len Brown <len.brown@intel.com>
>>>> Cc: Pavel Machek <pavel@ucw.cz>
>>>> Cc: x86@kernel.org
>>>> Cc: Petr Mladek <pmladek@suse.com>
>>>> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-pm@vger.kernel.org
>>>> ---
>>>>  Documentation/admin-guide/kernel-parameters.txt |  1 +
>>>>  arch/x86/kernel/acpi/boot.c                     |  5 +++++
>>>>  include/linux/console.h                         |  1 +
>>>>  kernel/printk/printk.c                          | 10 ++++++++++
>>>>  4 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index a32f2a126791..dd057224f33b 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -635,6 +635,7 @@
>>>>  
>>>>  		hvc<n>	Use the hypervisor console device <n>. This is for
>>>>  			both Xen and PowerPC hypervisors.
>>>> +		auto	[X86] Enable ACPI SPCR console
>>>>  
>>>>  		If the device connected to the port is not a TTY but a braille
>>>>  		device, prepend "brl," before the device type, for instance
>>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>>> index 3b20607d581b..fb2616ba3b21 100644
>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>> @@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>>>>  	e820__range_add(addr, size, E820_TYPE_ACPI);
>>>>  	e820__update_table_print();
>>>>  }
>>>> +
>>>> +void __init arch_console_setup(void)
>>>> +{
>>>> +	acpi_parse_spcr(false, true);
>>>> +}  
>>>
>>> <snip>
>>>   
>>>> +int arch_console_setup(void);  
>>>
>>> Function does not match its prototype :(
>>>
>>> How did you build this successfully?  
>>
>> Weird, it compiles on my system?
> 
> Are you compiling with ACPI enabled?
> 

Yes, CONFIG_ACPI is enabled.

> It would still compile without it and use the properly prototyped
> "weak" function.

I did this:

1.  git co linux.git
2.  git am 0001-console-Add-console-auto-option.patch
3.  make -j224

and I have a clean compile with no warnings or errors.  My config is the
standard Fedora .config so it has CONFIG_ACPI enabled and CONFIG_ACPI_SPCR_TABLE
enabled.

IMO the compile should have warned or error'd out.  Is there a possibility that
some subtlety of weak functions that causes this to not be an error?

In any case, I've changed the prototype and other functions to void and am
finishing up retesting.

P.

> 
> -- Steve
> 
>>
>> I'll fix it though.
>>
