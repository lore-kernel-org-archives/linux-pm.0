Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783060;
	b=Z9cT02ZH6pXpZypgVq0J8Wk3pAOPyaFP4YCtUHqLrGtBzxhDLlIIVUMkuoFutvypJqxk
	 IuNnOOza2t8JDI8XO5yTH5MFd9kbWMNVLzfD6TDDAQHN7Yzj2F/JiqsjIy+yMtvm8oOvi
	 c21jojChZRhevIIu8pswhXd2ZLGRRiBtu9eIDPHZdMJzA+voB8RO0kCLJuxjmEHAGXWx4
	 dIfzo5YxX4Au9AehDS8Hqx3662afmsiEzH92udRjC3M8YVncUc0E/ubbkn5mVQWUq+yUb
	 0Yu87bbjbUUqH9sAVojNGjiIhteiwpfOPQ9/X+Lxjewz4VfVghBkNILvYqZS7otmYvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=e2NL43u+2YfXFaE0ljD3Rd6MzpHrPYH8D7UaHAQ7IMM=;
	b=rJ3GVO8g/0i9YEZO1426DvZFJYlIq39rorfcT4QVARililBX7OxBtlnX9tXHwLIiOudU
	 94XET6P1916p5wkpg6GLozzf7M6adAtKEgGAsB8As2CDF1oq2+UwbnGfcf/ptaj8kfZnw
	 bNTR2V20L4sd1JYoZh6lrWXJAJWNO1UnufasdcYl9LigQwCyFrvkx0Ps5pd/Tkc/+o3F2
	 tU3CUvMrW0hFJIeo5VwgDPSYG/RqQnkF3+oSb0naarwQ1xr/g1tsjuyC3k7SpHShC939m
	 TDBSqMXJ1FyWB5czwNAiJbs2IkmaDHbuF4dJxkWvdiSN3tAqW4wRYQMX0v5hOa31l7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MUwwu4LC;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF27606A31F
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 22:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF27606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MUwwu4LC
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14394530ec6so3280030c88.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 14:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794783059; x=1795387859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2NL43u+2YfXFaE0ljD3Rd6MzpHrPYH8D7UaHAQ7IMM=;
        b=MUwwu4LCGCe9vTkprlk+Kb43zd708+kIujxKr4CzP6TE6Urv8RJI/YUAbaP9eAzbT5
         cxiAnJfabJXnzm59+G6rOVsxKj6dx9wonjHuglyc/Ra7Dp5oYxqcCI0zBbnY0SGyQilT
         qR9+8CVFEF2Y9TWcGZLIi65GOyVyM6KqrhGN2y4Td8PtunbrcwWXcaxNRssm4B3cS07/
         71iR2dtSKRuD37bmrlu2K3ke9t8FkMk7lCfc9PGVOWu3nG32PC/t/tXThgHo0c6YFJJj
         l0omDTctJqeWe5OAQy7tdFUjlQLkzW76snQ96pewA7pCB+m2WFXAfxj8emWW2atJ1l2A
         axSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794783059; x=1795387859;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2NL43u+2YfXFaE0ljD3Rd6MzpHrPYH8D7UaHAQ7IMM=;
        b=V4uYYyRquiW5LRARfy8pgUgEX+i282ZYeB21N4p0Kc5WbqAunu+UW17TYF7kbEYWxz
         mVn7+kQU5t53KBwyQWv/7IiXxYeVM8CU9x1EErfNcMVk5HB+XOVkLgSFn8xWHFqCZfJj
         4XUBCmV0+oj45yIv6yFAz9u+DLumSaQdRsn8z+Molvz8eVqubAQNt/s1S0gnHbChUX9f
         i4Kw2ChlK64smWYkwqmmwXH/RS0m9+uzE3WMRCe/VHAzYUbJIG1PV+9vDC0/SN0Fgbsq
         JBDvdFogYekZLq9wUzvglKWQnJwilKQn2xK80/yEWaqDrh4gIAUmrIuqsyjW7OBFQk/r
         yS/Q==
X-Forwarded-Encrypted: i=1; AL+hErEyawBrS57ypmHUIRgSRV8w6DwoMmyrb4jMIgS8mD3pKLCPzLjOhaZ2/6CqlMmqSRlHgs9DQyOi1Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8w9E1q2CSf2y+F3r4M/FHX++MCvhqG87TTSCPIAnyCayRdOW/D
	y0Tm2b/Po6z9J/cN16jPgErVdbjX8vylLS16A4MPwcXwJfqCRlm+3Ppw
X-Gm-Gg: AYBFou2gkuRBbWtKLMZGecxYmkQ2BQD3AwsGq0Q/XjD/mqt9A64kmF9kxgghkJ3dKpE
	0Qr8SbGJzSKmSVqWncjs01NaNbI+sG2g3BN+h7+JqPABXDuXpq7tSgUVJtRHlO8TF49/EuVemC7
	oj6X9i9lcDPWo/K5WIsZQoYONxBkyZez8VDy6HQ/+A4wh4WJKQ7zxCDIs/Ou856u/QsiHaGV8t9
	sN/VrkZbhQWbVChWZQhqbMTjfIFX/XsW+VonU4RNjn3JyOnhxDD53DJITAMRK4eJmze/U6B22bQ
	4wZcNpcgJeCT29r63Kkm+39DSzxaO8daCOhePwWM3k4YhdC7BI1fy4bugiWa2kMJLNwMjuRzE6B
	DEaa23sDp4j9DPFPqeQE/jVhUWzOgWsFDwz58nkRzjbLf1zXKcslVRUq8ru8GIqG4c/iRPXyNeA
	JpEK0PSvGHajJdx9dY/FAwh4eGpOoiO9rTRfkSJvq72wibcHReW6RQECxkaHkufEvfQKbWTAtAn
	04qSqdiLXnsqlTuBePPF+xCHRMXiPFT00D0/AKDTSHn4CmKejHTkG7nlxf8px8KLEIHBD7Lh+9I
	sMED0qSEhaMdKjPTtJ5DJnvf7ifsQlirCPRoBSQACvThYO29kepqiLn16Tja7DFTBX2b
X-Received: by 2002:a05:693c:894f:20b0:36d:5102:9974 with SMTP id 5a478bee46e88-379636607famr8547200eec.2.1794783059212;
        Sun, 15 Nov 2026 14:50:59 -0800 (PST)
Received: from [192.168.35.214] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm46704105eec.25.2026.11.15.14.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 14:50:58 -0800 (PST)
Message-ID: <1e3c14c2-4ad8-479d-a896-952fdfeac708@gmail.com>
Date: Mon, 16 Nov 2026 07:50:55 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v4 4/4] devfreq: Refcount governor modules while in use
Content-Language: ko
To: Jie Zhan <zhanjie9@hisilicon.com>, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com, tianyaxiong@kylinos.cn, zhenglifeng1@huawei.com,
 zhangpengjie2@huawei.com, lihuisong@huawei.com, prime.zeng@hisilicon.com
References: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
 <20260729102348.3857779-5-zhanjie9@hisilicon.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20260729102348.3857779-5-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 7:23 PM, Jie Zhan wrote:
> A governor module can be inserted or removed dynamically when built as a
> kernel module.  'devfreq->governor' would become NULL if the governor
> module is removed when it's in use.
> 
> Add a refcount mechanism for governor modules to prevent the governor
> module from being removed (except for force unload):
> 1. Add an optional 'owner' member to struct devfreq_governor so the devfreq
>    core can identify the module that holds the governor code.
> 2. Get and put a refcount of the governor module when starting and stopping
>    the governor.
> 
> The new 'owner' field is optional:
> - Common governor modules (performance, powersave, simple_ondemand,
>   userspace, passive) set 'owner' to THIS_MODULE.
> - Governors that are bundled into a device driver module must leave 'owner'
>   NULL.  The device's lifetime already pins that module, and setting
>   'owner' would create a self-reference that blocks the driver from being
>   unloaded.
> 
> As a result, a non-forced rmmod of an in-use stand-alone governor now
> fails with -EBUSY, e.g.:
> 
>   $ cat governor
>   performance
>   $ rmmod governor_performance
>   rmmod: ERROR: Module governor_performance is in use
> 
> Force unloads (rmmod -f, if configured) can't be blocked.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/devfreq/devfreq.c                 | 17 ++++++++++++++++-
>  drivers/devfreq/governor_passive.c        |  1 +
>  drivers/devfreq/governor_performance.c    |  1 +
>  drivers/devfreq/governor_powersave.c      |  1 +
>  drivers/devfreq/governor_simpleondemand.c |  1 +
>  drivers/devfreq/governor_userspace.c      |  1 +
>  include/linux/devfreq-governor.h          | 11 +++++++++++
>  7 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 959f0b08ed36..4a01dad21c16 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -345,24 +345,37 @@ static int devfreq_set_governor(struct devfreq *df,
>  				 __func__, df->governor->name, ret);
>  			return ret;
>  		}
> +		module_put(old_gov->owner);
>  	}
>  
>  	/* Start the new governor */
> +	if (!try_module_get(new_gov->owner)) {
> +		df->governor = NULL;
> +		return -EINVAL;
> +	}
> +
>  	df->governor = new_gov;
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>  			 __func__, df->governor->name, ret);
> +		module_put(new_gov->owner);
>  
>  		/* Restore previous governor */
>  		df->governor = old_gov;
>  		if (!df->governor)
>  			return ret;
>  
> +		if (!try_module_get(old_gov->owner)) {
> +			df->governor = NULL;
> +			return -EINVAL;
> +		}
> +
>  		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>  		if (ret) {
>  			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
>  				__func__, df->governor->name, ret);
> +			module_put(old_gov->owner);
>  			df->governor = NULL;
>  			return ret;
>  		}
> @@ -1051,9 +1064,11 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  
>  	devfreq_cooling_unregister(devfreq->cdev);
>  
> -	if (devfreq->governor)
> +	if (devfreq->governor) {
>  		devfreq->governor->event_handler(devfreq,
>  						 DEVFREQ_GOV_STOP, NULL);
> +		module_put(devfreq->governor->owner);
> +	}
>  	device_unregister(&devfreq->dev);
>  
>  	return 0;
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index d7feecd900f1..3e63dd200a04 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -449,6 +449,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  static struct devfreq_governor devfreq_passive = {
>  	.name = DEVFREQ_GOV_PASSIVE,
>  	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE,
> +	.owner = THIS_MODULE,
>  	.get_target_freq = devfreq_passive_get_target_freq,
>  	.event_handler = devfreq_passive_event_handler,
>  };
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index fdb22bf512cf..0a08b067ea6b 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -37,6 +37,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
>  
>  static struct devfreq_governor devfreq_performance = {
>  	.name = DEVFREQ_GOV_PERFORMANCE,
> +	.owner = THIS_MODULE,
>  	.get_target_freq = devfreq_performance_func,
>  	.event_handler = devfreq_performance_handler,
>  };
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
> index ee2d6ec8a512..3ae296d55e3e 100644
> --- a/drivers/devfreq/governor_powersave.c
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -37,6 +37,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
>  
>  static struct devfreq_governor devfreq_powersave = {
>  	.name = DEVFREQ_GOV_POWERSAVE,
> +	.owner = THIS_MODULE,
>  	.get_target_freq = devfreq_powersave_func,
>  	.event_handler = devfreq_powersave_handler,
>  };
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index ac9c5e9e51a4..46287b279ded 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -119,6 +119,7 @@ static struct devfreq_governor devfreq_simple_ondemand = {
>  	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
>  	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
>  		| DEVFREQ_GOV_ATTR_TIMER,
> +	.owner = THIS_MODULE,
>  	.get_target_freq = devfreq_simple_ondemand_func,
>  	.event_handler = devfreq_simple_ondemand_handler,
>  };
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 3906ebedbae8..b1acccc79f7f 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -135,6 +135,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
>  
>  static struct devfreq_governor devfreq_userspace = {
>  	.name = DEVFREQ_GOV_USERSPACE,
> +	.owner = THIS_MODULE,
>  	.get_target_freq = devfreq_userspace_func,
>  	.event_handler = devfreq_userspace_handler,
>  };
> diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
> index dfdd0160a29f..ae1721e58401 100644
> --- a/include/linux/devfreq-governor.h
> +++ b/include/linux/devfreq-governor.h
> @@ -12,6 +12,7 @@
>  #define __LINUX_DEVFREQ_DEVFREQ_H__
>  
>  #include <linux/devfreq.h>
> +struct module;
>  
>  #define DEVFREQ_NAME_LEN			16
>  
> @@ -53,6 +54,15 @@
>   * @name:		Governor's name
>   * @attrs:		Governor's sysfs attribute flags
>   * @flags:		Governor's feature flags
> + * @owner:		Optional, module that owns this governor.
> + *			When set (typically to THIS_MODULE), the devfreq core
> + *			takes a reference on @owner while this governor is in
> + *			use so that the governor module cannot be removed,
> + *			except by a forced unload. Governors that are bundled
> + *			into a device driver module must leave @owner NULL: the
> + *			device's lifetime already pins that module, and setting
> + *			@owner would create a self-reference that prevents the
> + *			driver from being unloaded.
>   * @get_target_freq:	Returns desired operating frequency for the device.
>   *			Basically, get_target_freq will run
>   *			devfreq_dev_profile.get_dev_status() to get the
> @@ -70,6 +80,7 @@ struct devfreq_governor {
>  	const char name[DEVFREQ_NAME_LEN];
>  	const u64 attrs;
>  	const u64 flags;
> +	struct module *owner;
>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>  	int (*event_handler)(struct devfreq *devfreq,
>  				unsigned int event, void *data);

I agree this suggestion. But this patch is based on patch1/2/3.
After resolving the patch1,2,3, we better to review this patch.

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
