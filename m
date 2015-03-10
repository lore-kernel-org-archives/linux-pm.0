From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v15 01/11] ARM: cpuidle: Register per cpuidle device
Date: Tue, 10 Mar 2015 10:37:34 +0000
Message-ID: <20150310103734.GK8656@n2100.arm.linux.org.uk>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35002 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbCJKhp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 06:37:45 -0400
Content-Disposition: inline
In-Reply-To: <1425914206-22295-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com

On Mon, Mar 09, 2015 at 09:16:36AM -0600, Lina Iyer wrote:
> @@ -105,18 +109,46 @@ static int __init arm_idle_init(void)
>  	if (ret <= 0)
>  		return ret ? : -ENODEV;
>  
> +

A bit better formatting would be nice - you don't need the extra blank
line here.

> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		pr_err("Failed to register cpuidle driver\n");
> +		return ret;
> +	}
> +
>  	/*
>  	 * Call arch CPU operations in order to initialize
>  	 * idle states suspend back-end specific data
>  	 */
>  	for_each_possible_cpu(cpu) {
> +

This blank line is not necessary either.

>  		ret = arm_cpuidle_init(cpu);

However, a blank line here would be a good thing.

> +		/*
> +		 * This cpu does not support any idle states
> +		 */

Also, formatting this as /* This cpu does not support any idle states */ is
acceptable too, and doesn't waste as many lines.

> +		if (ret == -ENOSYS)
> +			continue;
> +
>  		if (ret) {
>  			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>  			return ret;
>  		}
> +
> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +		if (!dev)
> +			return -ENOMEM;
> +
> +		dev->cpu = cpu;
> +		ret = cpuidle_register_device(dev);
> +		if (ret) {
> +			pr_err("Failed to register cpuidle device for CPU %d\n",
> +			       cpu);
> +			return ret;

It looks like we leak the 'dev' allocation here.

Also, other error paths, it looks like we leave the previously registered
cpuidle devices in place.  That may be acceptable if the intention is to
initialise as many CPUs as possible - but we then miss the
cpuidle_register() call below, which seems to make the registered devices
useless.  It's a little inconsistent.

Also, it's useful to report why something fails - printing the error code
can help debugging if it isn't already printed elsewhere.

> +		}
> +
> +		per_cpu(cpuidle_arm_dev, cpu) = dev;
>  	}
>  
> -	return cpuidle_register(drv, NULL);
> +	return 0;
>  }
>  device_initcall(arm_idle_init);

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
