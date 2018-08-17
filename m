From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] console: Add console=auto option
Date: Fri, 17 Aug 2018 14:57:14 +0200
Message-ID: <20180817125714.yekdxxqflmgajf2s@pathway.suse.cz>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
 <20180817093828.GA10337@jagdpanzerIV>
 <a530a430-70ce-c1e1-ccba-bf5df107c5ad@redhat.com>
 <20180817105046.GB10337@jagdpanzerIV>
 <9d164aa0-bc61-1bbf-f888-a24aeaf7dec0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9d164aa0-bc61-1bbf-f888-a24aeaf7dec0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2018-08-17 07:06:56, Prarit Bhargava wrote:
> On 08/17/2018 06:50 AM, Sergey Senozhatsky wrote:
> >> Like I mentioned to Petr, I'd like to know if you (or anyone else) has strong
> >> feelings about changing the behaviour of earlycon on x86?  I could make it so
> >> that specifying just earlycon would also initialize the console.
> > 
> > x86 people and/or scheduler people might have strong opinions on this.
> > I Cc-ed Peter Zijlstra; he represents both groups and is known to be
> > a hardcore earlycon user.
> 
> Thanks, I'm a user of earlycon too, but only moderately.
> 
> peterz, to give you an overview:  Currently on x86, the SPCR information is only
> interpreted by the early console code, and can be enabled with kernel parameter
> "earlycon" (no arguments).  In this patch I'm proposing adding "console=auto"
> that would enable the console based on the SPCR data.
> 
> There are two options on the table.  One, we could go with this patch which
> would make users do "earlycon console=auto" or, I could just change the
> behaviour of earlycon (no arguments) to also bring up the console.  In the
> second case the kernel parameter would just be "earlycon".  There is precedent
> for the second option as arm64 enables both the earlycon and console by default
> if SPCR is present.  However, on x86, I know many users do not want the console
> enabled by default so we should keep it on demand.
> 
> tl;dr: Pick one
> 
> Option 1: earlycon enables both the early console and console.

I am afraid that this is not acceptable. Users are sensitive
when a new kernel suddenly enables different consoles. For example,
see:

+ commit dac8bbbae1d0ccba9 ("Revert "printk: fix double printing with
  earlycon")

+ commit c6c7d83b9c9e6a8b3 ("Revert "console: don't prefer first
  registered if DT specifies stdout-path")


By other words, the new behavior must depend on a new option.


> Option 2: earlycon only enables the early console, and console=auto enables the
> console.

I suggest:

Option 3: "earlycon" enables early console defined by SPCR
	  "console" enables console defined by SPCR

I mean that "console" without extra options would enable the console
defined by ACPI SPCR. It would work the same as "earlycon" without
extra options for early consoles.

If you would want to make it explicit than I agree with Sergey
and would prefer "console=spcr" instead of "console=auto".

Note kernel tries to enable some consoles automatically even
when "console" parameter is not defined at all. Therefore "auto"
is somehow misleading.

Best Regards,
Petr

PS: JFYI, I have vacation the following week...
