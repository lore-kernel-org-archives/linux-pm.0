From: Don Zickus <dzickus@redhat.com>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 10:20:37 -0400
Message-ID: <20150518142037.GK184517@redhat.com>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <20150518093150.GC21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbbEROV3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 May 2015 10:21:29 -0400
Content-Disposition: inline
In-Reply-To: <20150518093150.GC21418@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, Ulrich Obergfell <uobergfe@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, May 18, 2015 at 11:31:50AM +0200, Peter Zijlstra wrote:
> On Mon, May 18, 2015 at 11:03:37AM +0200, Michal Hocko wrote:
> > This doesn't hang anymore. I've just had to move the mutex definition
> > up to make it compile. So feel free to add my
> 
> I've also fixed a lock leak, see goto unlock :-)
> 
> > Reported-and-tested-by: Michal Hocko <mhocko@suse.cz>
> 
> *blink* that actually fixed it..
> 
> That somewhat leaves me at a loss explaining how s2r was failing.
> 
> ---
> Subject: watchdog: Fix merge 'conflict'
> 
> Two watchdog changes that came through different trees had a non
> conflicting conflict, that is, one changed the semantics of a variable
> but no actual code conflict happened. So the merge appeared fine, but
> the resulting code did not behave as expected.
> 
> Commit 195daf665a62 ("watchdog: enable the new user interface of the
> watchdog mechanism") changes the semantics of watchdog_user_enabled,
> which thereafter is only used by the functions introduced by
> b3738d293233 ("watchdog: Add watchdog enable/disable all functions").
> 
> There further appears to be a distinct lack of serialization between
> setting and using watchdog_enabled, so perhaps we should wrap the
> {en,dis}able_all() things in watchdog_proc_mutex.
> 
> This patch fixes a s2r failure reported by Michal; which I cannot
> readily explain. But this does make the code internally consistent
> again.

I agree with Peter's locking approach.  We need to do better locking the
variables here.  Poking around the code I see too many variables being
exposed sadly.

Thanks Peter!

Andrew, this patch can replace 'watchdog-fix-watchdog_nmi_enable_all.patch'
on your queue.

Acked-by: Don Zickus <dzickus@redhat.com>
> 
> Reported-and-tested-by: Michal Hocko <mhocko@suse.cz>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/watchdog.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 2316f50..506edcc5 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -41,6 +41,8 @@
>  #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
>  #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
>  
> +static DEFINE_MUTEX(watchdog_proc_mutex);
> +
>  #ifdef CONFIG_HARDLOCKUP_DETECTOR
>  static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
>  #else
> @@ -608,26 +610,36 @@ void watchdog_nmi_enable_all(void)
>  {
>  	int cpu;
>  
> -	if (!watchdog_user_enabled)
> -		return;
> +	mutex_lock(&watchdog_proc_mutex);
> +
> +	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
> +		goto unlock;
>  
>  	get_online_cpus();
>  	for_each_online_cpu(cpu)
>  		watchdog_nmi_enable(cpu);
>  	put_online_cpus();
> +
> +unlock:
> +	mutex_lock(&watchdog_proc_mutex);
>  }
>  
>  void watchdog_nmi_disable_all(void)
>  {
>  	int cpu;
>  
> +	mutex_lock(&watchdog_proc_mutex);
> +
>  	if (!watchdog_running)
> -		return;
> +		goto unlock;
>  
>  	get_online_cpus();
>  	for_each_online_cpu(cpu)
>  		watchdog_nmi_disable(cpu);
>  	put_online_cpus();
> +
> +unlock:
> +	mutex_unlock(&watchdog_proc_mutex);
>  }
>  #else
>  static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
> @@ -744,8 +756,6 @@ static int proc_watchdog_update(void)
>  
>  }
>  
> -static DEFINE_MUTEX(watchdog_proc_mutex);
> -
>  /*
>   * common function for watchdog, nmi_watchdog and soft_watchdog parameter
>   *
