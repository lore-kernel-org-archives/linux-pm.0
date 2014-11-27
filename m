From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH V2 3/4] cpufreq: Introduce ->ready() callback for cpufreq
 drivers
Date: Thu, 27 Nov 2014 12:00:42 +0100
Message-ID: <20141127120042.7f34e60e@amdc2363>
References: <cover.1417048449.git.viresh.kumar@linaro.org>
 <8291de0dd69c731f1fc259acee190e26481f9f77.1417048449.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28413 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaK0LAt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 06:00:49 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NFP0028T2LBRA80@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 27 Nov 2014 20:00:47 +0900 (KST)
In-reply-to: <8291de0dd69c731f1fc259acee190e26481f9f77.1417048449.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Viresh,

> Currently there is no callback for cpufreq drivers which is called
> once the policy is ready to be used. There are some requirements
> where such a callback is required.
> 
> One of them is registering a cooling device with the help of
> of_cpufreq_cooling_register(). This routine tries to get 'struct
> cpufreq_policy' for CPUs which isn't yet initialed at the time
> ->init() is called and so we face issues while registering the
> cooling device.
> 
> Because we can't register cooling device from ->init(), we need a
> callback that is called after the policy is ready to be used and
> hence we introduce ->ready() callback.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
> Tested-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++++
>  include/linux/cpufreq.h   | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index de2c3e1..a09a29c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1285,8 +1285,13 @@ static int __cpufreq_add_dev(struct device
> *dev, struct subsys_interface *sif) up_write(&policy->rwsem);
>  
>  	kobject_uevent(&policy->kobj, KOBJ_ADD);
> +

Is this blank line intentional? 

>  	up_read(&cpufreq_rwsem);
>  
> +	/* Callback for handling stuff after policy is ready */
> +	if (cpufreq_driver->ready)
> +		cpufreq_driver->ready(policy);
> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index db3c130..4d078ce 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -267,6 +267,10 @@ struct cpufreq_driver {
>  	void		(*stop_cpu)(struct cpufreq_policy
> *policy); int		(*suspend)(struct cpufreq_policy
> *policy); int		(*resume)(struct cpufreq_policy *policy);
> +
> +	/* Will be called after the driver is fully initialized */
> +	void		(*ready)(struct cpufreq_policy *policy);
> +
>  	struct freq_attr **attr;
>  
>  	/* platform specific boost support code */

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
