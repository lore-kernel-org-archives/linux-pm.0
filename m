From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: fix fallback mechanism for suspend to idle in absence of enter_freeze
Date: Fri, 22 Jan 2016 02:15:33 +0100
Message-ID: <14264394.1r9YeUMTui@vostro.rjw.lan>
References: <1453375169-14768-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64941 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751007AbcAVBOs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 20:14:48 -0500
In-Reply-To: <1453375169-14768-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Thursday, January 21, 2016 11:19:29 AM Sudeep Holla wrote:
> Commit 51164251f5c3 ("sched / idle: Drop default_idle_call() fallback
> from call_cpuidle()") made find_deepest_state() return non-negative
> value and check all the states with index > 0. Also a result,
> find_deepest_state() returns 0 even when enter_freeze callbacks are not
> implemented and enter_freeze_proper is called which ends up crashing
> the kernel.
> 
> This patch updates the check for index > 0 in cpuidle_enter_freeze and
> cpuidle_idle_call(when idle_should_freeze is true) to restore the
> suspend-to-idle functionality in absence of enter_freeze callback.
> 
> Fixes: 51164251f5c3 ("sched / idle: Drop default_idle_call() fallback from call_cpuidle()")
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpuidle/cpuidle.c | 2 +-
>  kernel/sched/idle.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Hi Rafael,

Hi,

Sorry for the breakage.

> I assume you prefer to retain find_deepest_state return non-negative
> values, so I took this approach for fixing the bug. Do you think we
> need to support enter_freeze_proper for index 0 ?

Zero is a special case on x86, so supporting enter_freeze_proper() for it
is not necessary.

If you think we can also make 0 a special case on ARM, the others should
not object to that either.

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 046423b0c5ca..f996efc56605 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -153,7 +153,7 @@ int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 * be frozen safely.
>  	 */
>  	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
> -	if (index >= 0)
> +	if (index > 0)
>  		enter_freeze_proper(drv, dev, index);
> 
>  	return index;
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index de0e786b2667..544a7133cbd1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -162,7 +162,7 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (idle_should_freeze()) {
>  		entered_state = cpuidle_enter_freeze(drv, dev);
> -		if (entered_state >= 0) {
> +		if (entered_state > 0) {
>  			local_irq_enable();
>  			goto exit_idle;
>  		}
> --
> 1.9.1
> 

Thanks,
Rafael

