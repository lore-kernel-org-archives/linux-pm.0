Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB430F526
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781546; cv=none; b=YXtflhP0Mz4RefkRgMlMfld4l6Zqm9If7ku6EhhZ3DvCZngOtIVAIidYCr5ylrZY1035oPokfuBWAr3tsMZgfeHPnnJky6ymlkF7FZY04ZJJZd8Na2Ha8BPSKDzdWqkPcY9TxeuRpwn3MEU18uYtKkh+UHDImz+EWVS0xcWCtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781546; c=relaxed/simple;
	bh=qB2XYjGj60iW7URffgCn7dX+4S/gyULRetO7qyDA24s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUcLTJXzxlGHDudU0A7N582WVhC16GNCxf4i96tAPKX1B0SOOCJ18e/EIwyXdCFz7aJUpbmBdHJmA/5rNmM94urG6c1WZb7ebc8fKukhagkxYveoliRbEvHqSNHr61sWehspAaW/qeLmYf2sURjwD5CuUVdy2xUlrYg/Bt1hsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NgZQHoJY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NgZQHoJY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d6d28aa26cso10670535ad.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787781543; x=1788386343; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWfPZEMYmXjEOVTtuUiqR7EFAvZfcV1y1MLY6LFEEyw=;
        b=NgZQHoJYJmN7FLqCxvtgqLR56drY6tQXAy1XwQEAdz9zqtnDKo54vA/epd/VFz1iK4
         jop7fRHwTYOGMQOUHyt2VXsYvvMnoi0dN3zKBzOXcDuXk94wFL9ifm0dGXBSV7khQckR
         ZHST1VpnCp8sVKnGlkkPvSiJIzsym0iREo8zrHeF6u/eQHMQZOsK1uWctQYIMnfM8Pgw
         GMcKip/raFqr7aYiwzxpFRDEFkUekn7cSGOb6qnCv9PufzSz1m/DmKp8IrIHgFCXe9Y3
         3FCjNIfJtwFJVoamFIZ7j9oB9JWZ09KF9nkwTEoTd7Pwo/ZibXE4gbh46D/rCTP8AKeM
         HiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781543; x=1788386343;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZWfPZEMYmXjEOVTtuUiqR7EFAvZfcV1y1MLY6LFEEyw=;
        b=HARVuNDay3unV/07HMj6qpJe1YFAhgjWvAc/WLo2HvfQ2CDEyvScSnlIiT7bCz8nd4
         vQ4O6z2J7akpOj+AyLkJG8hrGZPwhbR+qrQGAI7s/B4RshykZ6RdZAs9AFRWOgOBagWl
         Kj6qEXl77RiE5l3z0ORNgtDZ32oXc1NrPXLb2uQSCr88t3x3vOQjkY9kkA61geB5USHx
         dSYO88pJVl2caBTE3+UzLLlIM/H/EVdju58eaUBNZYt3DDwl6HoH18DkX1BGgFK3uPO4
         FqCMpKcvNJUhb5YKUHLazaULZBpdBlEkpUiguUiWkOTHsNV84W1nKm8sSwhChXwZhOMq
         G8tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd3Ygy9bpw7RGdLfxhGhp+SpyUlSp1fDdxePdcr5LNIqucqRuD00khCC9xfn2EueOQOsNZTU2XyA==@vger.kernel.org
X-Gm-Message-State: AFuF++n6YrRvqNJcVodkBLlxpEgPcciirePgS76BmMPY//bdMoO2xpmr
	iU4z2x/NoKFOLmiLO83G3UlWBKyqImCT7KVCdiyivAVi5eECVUnnt9th7zs1EE/Ps+4=
X-Gm-Gg: AR+sD11IEzsKNZOY4WpxP65yG0whJ0w9YsefWaG3o/zoDlAHDyyw45NulvcbxxNzrbK
	HfDFZJElDySaMmNT3bfYS2fx8ns+zoe6VnTAXaxVyeQZK3QttDYJ2kzVaQTPklo5DiltM+AATzv
	INv0TYt5LNLuOZQ6aLZK4qsIVaP9QRManwxZzMB9871/RR/4vbH7xTPgDS6hP/XaAE02rLfxTja
	Q1/GxViQJff58pZc+MgH20bG3kUAtvlLo8tJhCzoslBl7s0uiz+3qPIDaU/Z891ZC/PyoodOQLo
	9GCTLppEgYr6ZrRPjEJDUWAf5in8yxobf+osoy5KwsG/wuJg3VoR/G7+R3cbsd5DZ+Cg+BZCLVz
	1jQpkWvjNQET+zN+yitRhkUtQrj16XmGzcP8JeWMvSLcH64MatTortvJzk14snpdf+ciIHGV2/4
	Fv4dCbq2IacJQiFJqwM9WyQT1ojQkCheemBtcz8mC6im3Chk3Btq0WJczraIac4OvA7Wx9
X-Received: by 2002:a17:90b:1d47:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-3966d458714mr20922013a91.14.1787781543124;
        Wed, 26 Aug 2026 14:59:03 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3965547159asm8327576a91.12.2026.08.26.14.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:59:02 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Ulf
 Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pmdomain: core: add genpd_for_each_child() helper
In-Reply-To: <ii3gxwilznalii332hlaztbevzyegoeqfq4nugpuzs6gqyq3ms@rv4x3qdlj6i7>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
 <20260819-topic-lpm-pmdomain-device-constraints-v4-3-7ceb095f5474@baylibre.com>
 <ii3gxwilznalii332hlaztbevzyegoeqfq4nugpuzs6gqyq3ms@rv4x3qdlj6i7>
Date: Wed, 26 Aug 2026 14:59:02 -0700
Message-ID: <7h33w08rx5.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abel Vesa <abel.vesa@oss.qualcomm.com> writes:

> On 26-08-19 10:08:38, Kevin Hilman (TI) wrote:
>> Add a new internal helper function genpd_for_each_child() that recursively
>> iterates over all devices in a PM domain and its child domains (subdomains).
>> This helper is useful for governors and other core PM domain code that needs
>> to examine or apply operations to all devices within a domain hierarchy.
>> 
>> The function takes a callback that is invoked for each device, and supports
>> early termination if the callback returns a non-zero value.
>> 
>> The helper is defined in a new internal header drivers/pmdomain/core.h and
>> implemented in drivers/pmdomain/core.c, making it available to other PM
>> domain subsystem components.
>> 
>> The first user of this helper is the cpu_system_power_down_ok() governor
>> function, which uses it to check device QoS latency constraints across the
>> entire domain hierarchy.
>> 
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/core.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pmdomain/core.h | 17 +++++++++++++++++
>>  2 files changed, 62 insertions(+)
>> 
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 842c4169e290..ff27369d9a97 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -24,6 +24,8 @@
>>  #include <linux/cpu.h>
>>  #include <linux/debugfs.h>
>>  
>> +#include "core.h"
>> +
>>  /* Provides a unique ID for each genpd device */
>>  static DEFINE_IDA(genpd_ida);
>>  
>> @@ -276,6 +278,49 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>>  	smp_mb__after_atomic();
>>  }
>>  
>> +/**
>> + * genpd_for_each_child - Recursively iterate over all devices
>> + *                        in a PM domain and its subdomains.
>> + * @genpd: PM domain to iterate over.
>> + * @fn: Callback function to invoke for each device.
>> + * @data: Data to pass to the callback function.
>> + *
>> + * This function recursively walks through all devices in the given PM domain
>> + * and all devices in its child PM domains (subdomains). For each device found,
>> + * the callback function @fn is invoked with the device and @data as arguments.
>> + *
>> + * Note: this function is inteded for use by the core and governors,
>> + * not for pmdomain providers.
>> + *
>> + * Returns: 0 on success, or the first non-zero value returned by @fn.
>> + */
>> +int genpd_for_each_child(struct generic_pm_domain *genpd,
>> +			 int (*fn)(struct device *dev, void *data),
>> +			 void *data)
>> +{
>> +	struct pm_domain_data *pdd;
>> +	struct gpd_link *link;
>> +	int ret;
>> +
>> +	/* First, iterate over all devices in this domain */
>> +	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>> +		ret = fn(pdd->dev, data);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Then, recursively iterate over all child domains (subdomains) */
>> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
>> +		struct generic_pm_domain *child_pd = link->child;
>> +
>> +		ret = genpd_for_each_child(child_pd, fn, data);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>
> This is usefull, I like it.

Thanks for the review & feedback.

>> +
>>  #ifdef CONFIG_DEBUG_FS
>>  static struct dentry *genpd_debugfs_dir;
>>  
>> diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
>> new file mode 100644
>> index 000000000000..7061891d31fb
>> --- /dev/null
>> +++ b/drivers/pmdomain/core.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Internal header for PM domain core
>> + *
>> + * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
>> + */
>
> Year and author are wrong.

Oops, copy/paste.

> With this addressed:
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Thanks,

Kevin
