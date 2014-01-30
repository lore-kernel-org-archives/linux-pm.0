From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 1/3] cpuidle: split cpuidle_idle_call main function
 into functions
Date: Thu, 30 Jan 2014 14:39:49 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1401301433320.1652@knanqh.ubzr>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:46745 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaA3Tjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2014 14:39:52 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so5644392qcq.18
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2014 11:39:51 -0800 (PST)
In-Reply-To: <1391090962-15032-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On Thu, 30 Jan 2014, Daniel Lezcano wrote:

>  /**
> + * cpuidle_select - ask the cpuidle framework to choose an idle state
> + *
> + * @drv: the cpuidle driver
> + * @dev: the cpuidle device
> + *
> + * Returns the index of the idle state. On error it returns:
> + * -NODEV : the cpuidle framework is available

s/available/not available/

> + * -EBUSY : the cpuidle framework is not initialized
> + */
> +int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +	if (off || !initialized)
> +		return -ENODEV;
> +
> +	if (!drv || !dev || !dev->enabled)
> +		return -EBUSY;
> +
> +	return cpuidle_curr_governor->select(drv, dev);
> +}
> +EXPORT_SYMBOL(cpuidle_select);

Peterz comment notwithstanding, is there actually a need to export those 
symbols? No modules should ever need to use this given this is going to 
be called by the scheduler code.

Ditto for the other symbols.


Nicolas
