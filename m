From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Date: Tue, 10 Apr 2018 14:39:50 -0700
Message-ID: <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
        <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
        <20180410123305.GF4082@hirez.programming.kicks-ass.net>
        <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
        <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Apr 2018 11:19:54 -0700 Joe Perches <joe@perches.com> wrote:

> A struct with a bool member can have different sizes on various
> architectures because neither bool size nor alignment is standardized.
> 
> So emit a message on the use of bool in structs only in .h files and
> not .c files.
> 
> There is the real possibility that this test could have a false positive
> when a bool is declared as an automatic, so limit the test to .h files
> where the only false positive is for declarations in static inline functions.

What's wrong with bools in structs?  The changelog should be
self-contained, please.  At least add a link in the changelog (of the
lkml.kernel.org/r/MSGID variety), but a link in the changelog is risky
because the reader may be offline or the server may be down.

> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6257,6 +6257,13 @@ sub process {
>  			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned int or u<8|16|32>\n" . $herecurr);
>  		}
>  
> +# check for bool use in .h files
> +		if ($realfile =~ /\.h$/ &&
> +		    $sline =~ /^.\s+bool\s*$Ident\s*(?::\s*d+\s*)?;/) {
> +			CHK("BOOL_MEMBER",
> +			    "Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384\n" . $herecurr);

And... the server is down.  Am unable to understand or review this patch!

> +		}
> +
>  # check for semaphores initialized locked
>  		if ($line =~ /^.\s*sema_init.+,\W?0\W?\)/) {
>  			WARN("CONSIDER_COMPLETION",
