From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Fri, 30 Jun 2017 01:00:58 +0200
Message-ID: <6613228.WfFrGvAy1X@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net> <20170623010837.11199-1-f.fainelli@gmail.com> <20170623010837.11199-2-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45214 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751333AbdF2XI1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 19:08:27 -0400
In-Reply-To: <20170623010837.11199-2-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thursday, June 22, 2017 06:08:36 PM Florian Fainelli wrote:
> Add an optional platform_suspend_ops callback: target_state, and a
> helper function globally visible to get this called:
> platform_suspend_target_state().
> 
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
> 
> Although this callback is optional and documented as such, it requires
> a platform_suspend_ops::begin callback to be implemented in order to
> provide an accurate suspend/resume state within the driver that
> implements this platform_suspend_ops.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/linux/suspend.h | 12 ++++++++++++
>  kernel/power/suspend.c  | 15 +++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index d9718378a8be..d998a04a90a2 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -172,6 +172,15 @@ static inline void dpm_save_failed_step(enum suspend_stat_step step)
>   *	Called by the PM core if the suspending of devices fails.
>   *	This callback is optional and should only be implemented by platforms
>   *	which require special recovery actions in that situation.
> + *
> + * @target_state: Returns the suspend state the suspend_ops will be entering.
> + * 	Called by device drivers that need to know the platform specific suspend
> + * 	state the system is about to enter.
> + * 	This callback is optional and should only be implemented by platforms
> + * 	which require special handling of power management states within
> + * 	drivers. It does require @begin to be implemented to provide the suspend
> + * 	state. Return value is platform_suspend_ops specific, and may be a 1:1
> + * 	mapping to suspend_state_t when relevant.
>   */
>  struct platform_suspend_ops {
>  	int (*valid)(suspend_state_t state);
> @@ -184,6 +193,7 @@ struct platform_suspend_ops {
>  	bool (*suspend_again)(void);
>  	void (*end)(void);
>  	void (*recover)(void);
> +	int (*target_state)(void);

I would use unsigned int (the sign should not matter).

>  };

That's almost what I was thinking about except that the values returned by
->target_state should be unique, so it would be good to do something to
ensure that.

The concern is as follows.

Say you have a driver develped for platform X where ->target_state returns
A for "mem" and B for "standby".  Then, the same IP is re-used on platform Y
returning B for "mem" and C for "standby" and now the driver cannot
distinguish between them.

Moreover, even if they both returned A for "mem" there might be differences
in how "mem" was defined by each of them and therefore in what the driver was
expected to do to handle "mem" on X and Y.

Thanks,
Rafael
