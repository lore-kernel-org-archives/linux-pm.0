From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2] console: Add console=auto option
Date: Fri, 17 Aug 2018 07:06:56 -0400
Message-ID: <9d164aa0-bc61-1bbf-f888-a24aeaf7dec0@redhat.com>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
 <20180817093828.GA10337@jagdpanzerIV>
 <a530a430-70ce-c1e1-ccba-bf5df107c5ad@redhat.com>
 <20180817105046.GB10337@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817105046.GB10337@jagdpanzerIV>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org



On 08/17/2018 06:50 AM, Sergey Senozhatsky wrote:
> Hello,
> 
> Cc-ing Peter Zijlstra
> 
>   lkml.kernel.org/r/728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com
>   lkml.kernel.org/r/20180817081947.m425gok2ugt7tglp@pathway.suse.cz
>   lkml.kernel.org/r/00c60dca-60bc-8568-eaa3-d4b0c326cab4@redhat.com
> 
> On (08/17/18 06:36), Prarit Bhargava wrote:
>> On 08/17/2018 05:38 AM, Sergey Senozhatsky wrote:
>>> On (08/16/18 13:39), Prarit Bhargava wrote:
>>>>
>>>> +		auto	[X86] Enable ACPI SPCR console
>>> 			^^^^
>>> 			And arm64?
>>
>> Hi Sergey, on arm64 if an SPCR is present the early console and console are
>> initialized by default.  IOW no kernel parameter is necessary to initialize the
>> console in that case.
> 
> OK, thanks.
> 
>>> Any chance we can rename param to "spcr" or something more clear?
>>> To explicitly state what exactly it's going to do. `auto' sounds
>>> too general and doesn't tell me that much. I'm probably the only
>>> here who can't see a connection between "auto" and "SPCR", but
>>> still.
>>
>> I came up with "auto" because I think it is generic.  I also thought about
>> "console=fw", or just "console".  If in the future another arch wants to
>> optionally bring up a firmware or hardware defined console then they could use
>> auto too.
> 
> Hmm, I see your point.
> My [sort of a] problem with "auto" is that it tells me as much as "magic"
> [and "magic" tells me almost nothing]. By the way, would be fun if we had
> "magic" instead of "auto" all over the kernel
> 
> 	echo "magic" > /sys/bus/usb/...../power/control
> 
>>> 	void arch_console_setup(void)
>>> 	{
>>> 		if (acpi_parse_spcr(false, true))
>>> 			pr_err(.........);
>>> 	}
>>>
>>> There can be other consoles in the system, logging an error is not
>>> such a useless thing.
>>
>> I can make the second change.  The problem (IIRC) with returning an error in an
>> setup fn is that the rest of the setup functions will not execute.  I don't want
>> to fail the setup callbacks because of an incorrect SPCR table.
> 
> OK, fair enough.
> Letting users know that SPCR is incorrect also makes sense, so option #2
> I guess is what we want after all.
> 
>> Like I mentioned to Petr, I'd like to know if you (or anyone else) has strong
>> feelings about changing the behaviour of earlycon on x86?  I could make it so
>> that specifying just earlycon would also initialize the console.
> 
> x86 people and/or scheduler people might have strong opinions on this.
> I Cc-ed Peter Zijlstra; he represents both groups and is known to be
> a hardcore earlycon user.

Thanks, I'm a user of earlycon too, but only moderately.

peterz, to give you an overview:  Currently on x86, the SPCR information is only
interpreted by the early console code, and can be enabled with kernel parameter
"earlycon" (no arguments).  In this patch I'm proposing adding "console=auto"
that would enable the console based on the SPCR data.

There are two options on the table.  One, we could go with this patch which
would make users do "earlycon console=auto" or, I could just change the
behaviour of earlycon (no arguments) to also bring up the console.  In the
second case the kernel parameter would just be "earlycon".  There is precedent
for the second option as arm64 enables both the earlycon and console by default
if SPCR is present.  However, on x86, I know many users do not want the console
enabled by default so we should keep it on demand.

tl;dr: Pick one

Option 1: earlycon enables both the early console and console.
Option 2: earlycon only enables the early console, and console=auto enables the
console.

P.

> 
> 	-ss
> 
