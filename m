From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Thu, 5 Nov 2015 14:12:14 +0530
Message-ID: <20151105084214.GC3773@ubuntu>
References: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
 <20151030170604.GD19782@codeaurora.org>
 <20151031021409.GT3716@ubuntu>
 <20151102191435.GN19782@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151102191435.GN19782@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, mturquette@baylibre.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 02-11-15, 11:14, Stephen Boyd wrote:
> On 10/31, Viresh Kumar wrote:
> > I don't know what is wrong (or right) with my exynos 5250 board, but I
> > didn't got any splat here even with the right config options (yes I
> > should have mentioned that earlier). I have seen this at other times
> > as well, while we were running after some cpufreq traces..
> > 
> > But, the case in hand is pretty straight forward and Mike T. did get a
> > splat as that's what he told me. We are calling a sleep-able function
> > from rcu_lock and that's obviously wrong.
> 
> That's slightly concerning. Given that the bug is so straight
> forward but we can't reproduce it doesn't instill a lot of
> confidence that the patch is correct.

Good that I spent some time debugging why I wasn't able to hit the
lockdep. And that's because by default CONFIG_PREEMPT_RCU was
selected on exynos and so the dummy function was getting enabled, and
so no WARN.

#if defined(CONFIG_PROVE_RCU) && !defined(CONFIG_PREEMPT_RCU)
static inline void rcu_preempt_sleep_check(void)
{
	RCU_LOCKDEP_WARN(lock_is_held(&rcu_lock_map),
			 "Illegal context switch in RCU read-side critical section");
}
#else /* #ifdef CONFIG_PROVE_RCU */
static inline void rcu_preempt_sleep_check(void)
{
}
#endif /* #else #ifdef CONFIG_PROVE_RCU */

Whereas for omap, that's not the case :)

So, with some config changes, I was able to hit the lockdep :)

And just to confirm, they got fixed by the $Subject patch :)

-- 
viresh
