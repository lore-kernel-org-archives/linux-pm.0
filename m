From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpuidle: fix broadcast control when broadcast can not
 be entered
Date: Fri, 1 Sep 2017 09:44:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709010944490.1857@nanos>
References: <20170901042956.29594-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35972 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbdIAHo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 03:44:58 -0400
In-Reply-To: <20170901042956.29594-1-npiggin@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 1 Sep 2017, Nicholas Piggin wrote:

> When failing to enter broadcast timer mode for an idle state that
> requires it, a new state is selected that does not require broadcast,
> but the broadcast variable remains set. This causes
> tick_broadcast_exit to be called despite not having entered broadcast
> mode.
> 
> This causes the WARN_ON_ONCE(!irqs_disabled()) to trigger in some
> cases. It does not appear to cause problems for code today, but seems
> to violate the interface so should be fixed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  drivers/cpuidle/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 60bb64f4329d..4453e27f855e 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -208,6 +208,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  			return -EBUSY;
>  		}
>  		target_state = &drv->states[index];
> +		broadcast = false;
>  	}
>  
>  	/* Take note of the planned idle state. */
> -- 
> 2.13.3
> 
> 
