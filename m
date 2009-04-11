From: "Rafael J. Wysocki" <rjw@suse.com>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
	(minor but annoying) audio problem
Date: Sat, 11 Apr 2009 02:06:32 +0200
Message-ID: <200904110206.33525.rjw__34877.5510945872$1239408659$gmane$org@suse.com>
References: <200904100057.43827.rjw@sisk.pl> <200904102058.36018.rjw@sisk.pl>
	<alpine.LFD.2.00.0904101204350.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904101204350.4583@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

[Sorry for having to switch the From address, my MTA has just decided to break.]

On Friday 10 April 2009, Linus Torvalds wrote:
> 
> On Fri, 10 Apr 2009, Rafael J. Wysocki wrote:
> > 
> > I've just verified that the resume-after-hibernation issue goes away after
> > reverting commit 9710794383ee5008d67f1a6613a4717bf6de47bc
> > (async: remove the temporary (2.6.29) "async is off by default" code) , so it
> > is async-related.
> 
> Arjan? Clearly all the necessary fixes weren't found..
> 
> There _is_ a module loading problem wrt initmem - I think you found that 
> and we added a hack for it for the ACPI battery driver. I wonder if we're 
> hitting a similar issue now with module discovery: modules that use 
> "async_schedule()" to do their discovery asynchronously are now not 
> necessarily fully "done" when the module is loaded. 
> 
> And so, anything that expected the devices to be available after module 
> load (like they used to) would be screwed.
> 
> IOW, maybe something like the totally untested patch appended here (that 
> should also allow us to make the ACPI battery code to go back to using 
> __init).

I tested it and it worked.

> As usual, I'm not using modules, so what do I know.
> 
> > The audio issue still remains after the revert, so it is really different.
> 
> Ok, probably something from Takashi..

This one is only reproducible in one out of three attempts on the average.
I tried to bisect, but it went to nowhere.

Thanks,
Rafael

 
> ---
>  kernel/module.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 05f014e..e797812 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2388,6 +2388,9 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_LIVE, mod);
>  
> +	/* We need to finish all async code before the module init sequence is done */
> +	async_synchronize_full();
> +
>  	mutex_lock(&module_mutex);
>  	/* Drop initial reference. */
>  	module_put(mod);
> 
