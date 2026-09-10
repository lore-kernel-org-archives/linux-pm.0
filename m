Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC243C09F9
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065124; cv=none; b=oMR48Pc0s/RNF6vtO9mN0TQetMxnPULN/x7jPpxqNvVO1GRzhx0sk7eCbUZRMB/GX5nlAmPdGNNAjV1GkgoLAaKIj0KD71N2ZwYRoRfML1Lu4JGH5jUMHjeTkuPQ+WqMK5e3gplPZLcAFMrkEs/yCoF+okBXhIUdqXdEMyj4ROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065124; c=relaxed/simple;
	bh=mwyTAGdH+Ov8iD7EKCzH5yrB7NRBjRfqh4/zpwO5kZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgkLgBrp2Lb/nOASCa5FgEmxnDDuh9eqzLALTyTTGhgS1tpVImTTFYO4eLByOisY2ffn+9CEVUsrxVQAgcEvzblUbHvQ3i1Z9UbTW3k6pUDSyMDYUA24yY7Gh2uy0HS9U7ljPsPxNZl/Io8edVud+q00FlYxJx6CZIsHnumPPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg95pJBU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg95pJBU"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79fbso13484095ad.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065117; x=1789669917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuzz1+vtL6q9IVKTuSaFdZbMIP54D/fr9Bx9hPkbwhk=;
        b=hg95pJBUC+JEM9k4cWIyIRm5TrPQFBmnBhn3qfxFNPlC/OG0HB9EfmjZZ179kBPK+C
         Ie/Oh79poADs9/TnCQw0gP0/nGFqJpVXmIKqBEhqsLnMwvYpzRw3cHbnw3RAF/myXfCR
         pWkfM/vaFjKbb4S0ByqAaXHvMiQ1g9omXJ1Jv+j7yXnFCTQ7foCMNzcoQJw02H/K96WX
         b2aZaBIX4KLsqj6NEj3/1HNmN7LbQM0ZCAutHngEIWvQZSIefxNZQp/czYxRFnqkb7+d
         AizFl5iK4f2lP5zZrbsO1n5FQBwOelZ4f9wZmC8G6kelJg/KphPo5yxWpCeXoPP0zcO9
         YYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065117; x=1789669917;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuzz1+vtL6q9IVKTuSaFdZbMIP54D/fr9Bx9hPkbwhk=;
        b=tFl1X4/oOFWdHOOv7Z+GcXW+ZddmQmg0koz6ZMm/hfFgJSxk9SNjIBspKLS0LsKrq9
         jNtslb/eLvs4i905bG4zJTRDyTgMs00di4qpSCgPoyZOm4gd4Svrof522fIPsvyATreG
         Acz9yp5DZWU4F8tnZa1CjAB1ff92yaPrzuJGvJT0+se04I0Jarni8TljAni+BsUrF52L
         6Ea/mSyUhGdAg8pRNjcbSSQiZywsxn1gI1qJs4LcZpgyFUdIlr3m3bGCvF1W917wELtV
         cLjmA0WTz/zWRPdrYaRSOkTrS5P9JgYZ8LC+nxvhO332PdsbACsyr7tEoha6wIkdnAAL
         kTWg==
X-Forwarded-Encrypted: i=1; AKwUvBzJZ7HjUHGgMPIo16CHWOnPQQo0iaic5Qxt4IQVN58D+ahyAwRDustJk14VZvOz9v+v41utYB8ECg==@vger.kernel.org
X-Gm-Message-State: AFuF++nonF2wkhclUhPuATXPne7NsvVIqqgfDdciNcVxaXogT6AmSfp4
	e0HugFJ3zxCuZrPN7NXYJDoHpE/7qcstsECZ3TUqH0OdjENuYcwmB1sM
X-Gm-Gg: AYBFou2INc3ANPvX32Iw4kkTTz94k4WnF92TuqpUoK5IoJJogw+T86is5wXlXyORWyt
	QmINIvPqrk9VHrp0c/gYVS3IIVPlcteGK2omIdiLtDQPXUizfeGoxx/yHr6d48vy9ssfzcdeugD
	OJzZUzgABE33gY7s3ghaxHILeu7EGf8cqKw5mRc5p3L/DSYyckv/b25IDE/JbINAGlYTm5WThsz
	Y/qTT2BRUJ33AqPGMUVGf4lWWunF4kMEoxtWbViQJ/15nR+7CnSUlw3DeR3ms1LF9NPi8gfu8LI
	LZv5ocfzmKExEu8U+BpGrOlkIIw0CiHKz7w8DLEY+f45NlzJUyVnoRFpdo7PXD7wAbhtJgde66Q
	3z9RobfIUndQ5bNutQIW1/G+qUG/Uu0xoKgLmB6Hc8Etu4rrGdPpEharZQuoi4AsZBqGqmPy2nY
	BIrF19rg9NK9lweIvqP8U6u5OWs3x3SgbkpsidGrqVKvXhyRBRAiTBCV9IYw0GVNrwi5S6JILS8
	az470mOJ9ckKUn3mvlODXQFq/xFqh9o66twiNWR0QN3/2X3PZWhZA==
X-Received: by 2002:a17:902:cccd:b0:2d8:d4d3:da50 with SMTP id d9443c01a7336-2dd2a471a7fmr16602305ad.20.1789065116855;
        Thu, 10 Sep 2026 11:31:56 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:432:91:952a:b76f? ([2406:7400:56:e503:432:91:952a:b76f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33b95282a73sm5942038eec.31.2026.09.10.11.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 11:31:56 -0700 (PDT)
Message-ID: <02b29827-3ca3-414b-9377-972f3d46eb03@gmail.com>
Date: Fri, 11 Sep 2026 00:01:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] pmdomain: core: Allow a non-CPU device in a CPU PM
 domain to do power on
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
 <20260907111659.263324-3-ulf.hansson@oss.qualcomm.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260907111659.263324-3-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07-09-2026 16:46, Ulf Hansson wrote:
> A driver for a non-CPU device that is attached to a CPU PM domain (the
> genpd has the GENPD_FLAG_CPU_DOMAIN configuration set), is currently not
> able to power on the PM domain. More precisely, to power on a CPU PM domain
> one of its corresponding CPUs needs to be woken up if they are idle.
> 
> The current support for a non-CPU device is that its driver can only
> prevent an already powered on CPU PM domain from being powered off. This
> leads to problems for a driver while probing its device or when it needs to
> call pm_runtime_get_sync() to turn on the power for it. From the driver
> point of view it looks like it all works fine, but when accessing the
> device it may end up with various errors as the device may not be fully
> powered on.
> 
> To fix the behavior for these types of devices, let's adjust the behaviour
> in genpd_power_on() to wake up an idle CPU that belongs to it, in cases
> when it's needed.
> 
> Link: https://lore.kernel.org/all/CAPx+jO-sCierYj8jnoKQHckJG16dOBxnNrsZVYO=38R2cLV8nw@mail.gmail.com/
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> ---
> 
> Changes in v3:
> 	- Moved to atomic polling, pointed out by Dhruva.

Thanks, but even in v3 we still have potential issues.
It does not fully address the consequences of polling for five seconds in that context,
nor the parent-lock nesting issue.

This seems to have been pointed out by this corresponding sashiko review as well [1]

[1] https://sashiko.dev/#/patchset/20260907111659.263324-1-ulf.hansson%40oss.qualcomm.com

> 
> Changes in v2:
> 	- Rename a function according to Abel's suggestion.
> ---
>  drivers/pmdomain/core.c | 80 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 6abe8b198949..b62d4e544bc5 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> @@ -19,11 +20,14 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
> +#include <linux/smp.h>
>  #include <linux/suspend.h>
>  #include <linux/export.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  
> +#include <trace/events/ipi.h>
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>  
> @@ -32,7 +36,9 @@ static const struct bus_type genpd_provider_bus_type = {
>  	.name		= "genpd_provider",
>  };
>  
> -#define GENPD_RETRY_MAX_MS	250		/* Approximate */
> +#define GENPD_RETRY_MAX_MS		250		/* Approximate */
> +#define GENPD_CPU_ON_POLL_PERIOD_US	100		/* 100us */
> +#define GENPD_CPU_ON_TIMEOUT_US		5000000		/* 5s */
>  
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
>  ({								\
> @@ -1026,15 +1032,75 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>  	}
>  }
>  
> +static bool genpd_status_on(struct generic_pm_domain *genpd)
> +{
> +	bool is_on;
> +
> +	genpd_lock(genpd);
> +	is_on = genpd_status_on_unlocked(genpd);
> +	genpd_unlock(genpd);
> +
> +	return is_on;
> +}
> +
> +static int genpd_wakeup_cpu(struct generic_pm_domain *genpd)
> +{
> +	unsigned int cpu;
> +	bool is_on;
> +	int ret;
> +
> +	/* Find the first online CPU in the genpd's cpumask. */
> +	cpu = cpumask_first_and(genpd->cpus, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids)
> +		return -EAGAIN;
> +
> +	genpd_unlock(genpd);
> +
> +	/* Send a IPI to wakeup the selected CPU. */
> +	smp_send_reschedule(cpu);
> +
> +	/* Poll to wait for it to complete the power on sequence. */
> +	ret = readx_poll_timeout_atomic(genpd_status_on, genpd, is_on, is_on,
> +					GENPD_CPU_ON_POLL_PERIOD_US,
> +					GENPD_CPU_ON_TIMEOUT_US);
> +
> +	genpd_lock(genpd);
> +
> +	/* Re-check the status as we have released the lock in between. */
> +	if (ret || !genpd_status_on_unlocked(genpd))
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static bool genpd_need_alive_cpu(struct generic_pm_domain *genpd,
> +				 struct device *dev)
> +{
> +	if (!genpd_is_cpu_domain(genpd))
> +		return false;
> +
> +	/* This is not for CPU devices as those are managed differently. */
> +	if (to_gpd_data(dev->power.subsys_data->domain_data)->cpu >= 0)
> +		return false;
> +
> +	/*
> +	 * If the current CPU doesn't belong to the genpd's cpumask, we need to
> +	 * wake up one of those idle CPUs to power on the CPU domain correctly.
> +	 */
> +	return !cpumask_test_cpu(smp_processor_id(), genpd->cpus);
> +}
> +
>  /**
>   * genpd_power_on - Restore power to a given PM domain and its parents.
>   * @genpd: PM domain to power up.
> + * @dev: The device that needs the PM domain to power on.
>   * @depth: nesting count for lockdep.
>   *
>   * Restore power to @genpd and all of its parents so that it is possible to
>   * resume a device belonging to it.
>   */
> -static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
> +static int genpd_power_on(struct generic_pm_domain *genpd, struct device *dev,
> +			  unsigned int depth)
>  {
>  	struct gpd_link *link;
>  	int ret = 0;
> @@ -1042,6 +1108,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>  	if (genpd_status_on_unlocked(genpd))
>  		return 0;
>  
> +	/* Special case for a device attached to a CPU domain. */
> +	if (genpd_need_alive_cpu(genpd, dev))
> +		return genpd_wakeup_cpu(genpd);
> +
>  	/* Reflect over the entered idle-states residency for debugfs. */
>  	genpd_reflect_residency(genpd);
>  
> @@ -1056,7 +1126,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>  		genpd_sd_counter_inc(parent);
>  
>  		genpd_lock_nested(parent, depth + 1);
> -		ret = genpd_power_on(parent, depth + 1);
> +		ret = genpd_power_on(parent, dev, depth + 1);
>  		genpd_unlock(parent);
>  
>  		if (ret) {
> @@ -1306,7 +1376,7 @@ static int genpd_runtime_resume(struct device *dev)
>  
>  	genpd_lock(genpd);
>  	genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> -	ret = genpd_power_on(genpd, 0);
> +	ret = genpd_power_on(genpd, dev, 0);
>  	genpd_unlock(genpd);
>  
>  	if (ret)
> @@ -3410,7 +3480,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  
>  	if (power_on) {
>  		genpd_lock(pd);
> -		ret = genpd_power_on(pd, 0);
> +		ret = genpd_power_on(pd, dev, 0);
>  		genpd_unlock(pd);
>  	}
>  

