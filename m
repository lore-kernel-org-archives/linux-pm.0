From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2] console: Add console=auto option
Date: Fri, 17 Aug 2018 06:36:10 -0400
Message-ID: <a530a430-70ce-c1e1-ccba-bf5df107c5ad@redhat.com>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
 <20180817093828.GA10337@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817093828.GA10337@jagdpanzerIV>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 08/17/2018 05:38 AM, Sergey Senozhatsky wrote:
> On (08/16/18 13:39), Prarit Bhargava wrote:
>>
>> +		auto	[X86] Enable ACPI SPCR console
> 			^^^^
> 			And arm64?

Hi Sergey, on arm64 if an SPCR is present the early console and console are
initialized by default.  IOW no kernel parameter is necessary to initialize the
console in that case.

> 
> 
> Any chance we can rename param to "spcr" or something more clear?
> To explicitly state what exactly it's going to do. `auto' sounds
> too general and doesn't tell me that much. I'm probably the only
> here who can't see a connection between "auto" and "SPCR", but
> still.

I came up with "auto" because I think it is generic.  I also thought about
"console=fw", or just "console".  If in the future another arch wants to
optionally bring up a firmware or hardware defined console then they could use
auto too.

> 
> One more thing, as far as I can tell, acpi_parse_spcr() can fail
> and return an error. arch_console_setup() hides all errors and
> returns void. Should it return error code?
> 
> 	int arch_console_setup(void)
> 	{
> 		return acpi_parse_spcr(false, true);
> 	}
> 
> Or maybe
> 
> 	void arch_console_setup(void)
> 	{
> 		if (acpi_parse_spcr(false, true))
> 			pr_err(.........);
> 	}
> 
> There can be other consoles in the system, logging an error is not
> such a useless thing.

I can make the second change.  The problem (IIRC) with returning an error in an
setup fn is that the rest of the setup functions will not execute.  I don't want
to fail the setup callbacks because of an incorrect SPCR table.

Like I mentioned to Petr, I'd like to know if you (or anyone else) has strong
feelings about changing the behaviour of earlycon on x86?  I could make it so
that specifying just earlycon would also initialize the console.

P.

> 
> 	-ss
> 
