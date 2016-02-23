From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 23 Feb 2016 15:36:48 +0530
Message-ID: <56CC2F38.5070507@linux.vnet.ibm.com>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org> <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:51134 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbcBWKID (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 05:08:03 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Tue, 23 Feb 2016 20:08:01 +1000
In-Reply-To: <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org



On 02/16/2016 09:13 PM, Daniel Lezcano wrote:
[...]
> +	if (index < 0) {
> +		/*
> +		 * No idle callbacks fulfilled the constraints, jump
> +		 * to the default function like there wasn't any
> +		 * cpuidle driver.
> +		 */
> +		goto default_idle;
> +	} else {
> +		/*
> +		 * Enter the idle state previously returned by the
> +		 * governor decision.  This function will block until
> +		 * an interrupt occurs and will take care of
> +		 * re-enabling the local interrupts
> +		 */
> +		return cpuidle_enter(drv, dev, index);

Minor point. You are not calling rcu_idle_exit() in else block. This
should probably be
		ret = cpuidle_enter(drv, dev, index);
                goto out;

> +	}
> +
> +default_idle:
> +	default_idle_call();
> +out:
> +	rcu_idle_exit();
> +	return ret;
> +}
> 

Thanks,
Shreyas

