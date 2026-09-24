Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E44BA1D7
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275876; cv=none; b=BGkHpmJaENpt8Q7rk4kNtX7YcjaCDZxjgvIVxBdKuWGnh7SY8CECbcNR2g8nt6BVwRDwZ43ePLze3OJf6yZuyUttjpoVYnimMGJUi+nP1NchyDQKhIBbOXlC3VWwM60vZFnZlJTUeXLg/fSNY7+DDmNfE9BPi6NWJXmyqt4ngfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275876; c=relaxed/simple;
	bh=xIBkTD5g8oWaR6/5h59ukLX3DRjDG/lsJCYvT3JpSYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nnbXLHiG+K/rvXCfbmTgmBQf4VvWh+El0BZHz+BLVf/wh0vbGqaRB4pXzArQmECWk/LN30fPAwraI3zSH0LnfECi1olNbk+zfEcggqwf14tuOkpvLGagbPkFWtPvSuRgmykD98VUo5B+1MOSs9gtqWkrJXOxJEkpcykc0rrf7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Be1tQSh2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Be1tQSh2"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so223128b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790275867; x=1790880667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+9gOXv28s7LpFRTXptC9SC7mTsay3dhZbC8CfxfBQo=;
        b=Be1tQSh26TB15AP4mKPTatXPXxuBHovlUdvsijd5gB9F5Dky//diIO3y8hiem0wMSQ
         trv6290UseaYFcrrS86aMHOmGwLfYhpd1x4IGHgKDtxgLGjshQmZRI1G7aaMmxNuMZBO
         eQFT7yXi+B4w/CJqGWDRaljlxMcH3cGwf0m0Y52K9nJJr2p0lIp2ycOflSIwIuB/Rq6z
         E9KeGrz7NUF+CpYqOqTmuZyQgFfLss8tR4+gtGDQegRQdcACa5hewlkVGI6uAy8fFQOi
         Cc4jxsyMW7IJPkgvFE6gBHpPDJZ1aZLU0jdyBnTRdRhpM86NpZYpVgM9tiy3QOQ8WoUN
         lH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790275867; x=1790880667;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O+9gOXv28s7LpFRTXptC9SC7mTsay3dhZbC8CfxfBQo=;
        b=Quv2hXijKALmFPCJzIg4ARhmTd3yi8mUjgJwMF8vlFdbAbZhkJubSdK3odf+8ZiyrP
         J2x4jx94fXkfyRP83MmXO+lh0gfvseriFwNIP9OX+vxquGklJlfIzOZnyK2RV/3Bl8ph
         GhGzoDojxDUpg8FaD3n9vW114HHgrZvGI+ULvuLEYeeY9zvyr2KaknqMs6yE+Qhct2uP
         YvSoS8FwdLdlfEQ8/Prr/txvd7PIkMEwBiLvcojLTs+Z5EssFpo97bl1eBncpbmdEZhb
         UfoOibp8vAbct69AZBVexjPWnRAl5t4hfiat6bux1MgtjtPqQQUErtCyCtIwPvo4/y3J
         R5+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcu9mI0zeQGiissAmVjwepE1Dq2clUeHZyM+HP6xkhtjqx7tpZRoYejnErhLlqRmLsJSNKny3ZJA==@vger.kernel.org
X-Gm-Message-State: AFuF++k4tbcXY2TpLw6SJGlxP8OeW2BdTubufq3W6Mtd63s1pYbvm0mE
	Mvpd5c3iS8wZ7uZA80sWT3anmTY9NeGgxZKIE7jM7zlD/fwFguqNQ0PHHaDaTRG6svg=
X-Gm-Gg: AYBFou2icbeWVneQn+WUsb+6+ZSLXkYDlbtDiM7KkawTc/o7zRUGWxWtBexoUxYrPpl
	tqKPXoLnIJuUaS9jQiadgKsCDK9WrF4c+qywqJwjpWFBZ739Cj1vabOSITzBUaZIYSCkDw1owam
	9jwO7pR9Vprh1lbxJprPnHK8NHB3+KtqSgA/JO2P89jDrntielC7Df8v1/l03hqY0DvIprbhfE4
	YOJkwh/aO6T9t/S3ek95N4hAUOLeHMzRPBsXLDemukTG6/ggeG3On2ag9XLcxK5PGl4SDrogtPq
	fX2jwJQi/91KG5h2XiEpJaUd73JwrpPWeTKdDo1SsbbpsunH0+ai1p/sDGWU0mDpy6cxoks+XsD
	r9gzdXCrjWq9nGtciHlpvnojS7m/Kxud8uVctY4Ejpc1FEulNa4B2SOb53k7dR/LOAIkHZdLwx7
	fRehto6PDZIXhe7IqruCucFJHcBOCkxkOlPdzcAUgWy4TJnrfROZtIItgAQJVPEJ87s8g=
X-Received: by 2002:a05:6a00:300d:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-87e9cb2196cmr2826556b3a.13.1790275866641;
        Thu, 24 Sep 2026 11:51:06 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-87feb980a0dsm86615b3a.55.2026.09.24.11.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:51:06 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Ulf
 Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, Abel Vesa
 <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/4] pmdomain: core: add genpd_for_each_child() helper
In-Reply-To: <CAPx+jO98X6dr20r3o7iHUq7zrjsDy+6YDM=FiO6MOkpCJFfhEA@mail.gmail.com>
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
 <20260826-topic-lpm-pmdomain-device-constraints-v5-3-28cbf43f7e38@baylibre.com>
 <CAPx+jO98X6dr20r3o7iHUq7zrjsDy+6YDM=FiO6MOkpCJFfhEA@mail.gmail.com>
Date: Thu, 24 Sep 2026 11:51:05 -0700
Message-ID: <7hwlsabi06.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ulf Hansson <ulf.hansson@oss.qualcomm.com> writes:

> On Thu, Aug 27, 2026 at 12:23=E2=80=AFAM Kevin Hilman (TI) <khilman@bayli=
bre.com> wrote:
>>
>> Add a new internal helper function genpd_for_each_child() that recursive=
ly
>> iterates over all devices in a PM domain and its child domains (subdomai=
ns).
>> This helper is useful for governors and other core PM domain code that n=
eeds
>> to examine or apply operations to all devices within a domain hierarchy.
>>
>> The function takes a callback that is invoked for each device, and suppo=
rts
>> early termination if the callback returns a non-zero value.
>>
>> The helper is defined in a new internal header drivers/pmdomain/core.h a=
nd
>> implemented in drivers/pmdomain/core.c, making it available to other PM
>> domain subsystem components.
>>
>> The first user of this helper is the cpu_system_power_down_ok() governor
>> function, which uses it to check device QoS latency constraints across t=
he
>> entire domain hierarchy.
>>
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/core.c | 45 ++++++++++++++++++++++++++++++++++++++++++=
+++
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
>> @@ -276,6 +278,49 @@ static void genpd_sd_counter_inc(struct generic_pm_=
domain *genpd)
>>         smp_mb__after_atomic();
>>  }
>>
>> +/**
>> + * genpd_for_each_child - Recursively iterate over all devices
>> + *                        in a PM domain and its subdomains.
>> + * @genpd: PM domain to iterate over.
>> + * @fn: Callback function to invoke for each device.
>> + * @data: Data to pass to the callback function.
>> + *
>> + * This function recursively walks through all devices in the given PM =
domain
>> + * and all devices in its child PM domains (subdomains). For each devic=
e found,
>> + * the callback function @fn is invoked with the device and @data as ar=
guments.
>> + *
>> + * Note: this function is inteded for use by the core and governors,
>> + * not for pmdomain providers.
>> + *
>> + * Returns: 0 on success, or the first non-zero value returned by @fn.
>> + */
>> +int genpd_for_each_child(struct generic_pm_domain *genpd,
>> +                        int (*fn)(struct device *dev, void *data),
>> +                        void *data)
>> +{
>> +       struct pm_domain_data *pdd;
>> +       struct gpd_link *link;
>> +       int ret;
>> +
>> +       /* First, iterate over all devices in this domain */
>> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>> +               ret =3D fn(pdd->dev, data);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       /* Then, recursively iterate over all child domains (subdomains)=
 */
>> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
>> +               struct generic_pm_domain *child_pd =3D link->child;
>> +
>> +               ret =3D genpd_for_each_child(child_pd, fn, data);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  #ifdef CONFIG_DEBUG_FS
>>  static struct dentry *genpd_debugfs_dir;
>>
>> diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
>> new file mode 100644
>> index 000000000000..a296134d4005
>> --- /dev/null
>> +++ b/drivers/pmdomain/core.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Internal header for PM domain core
>> + *
>> + * Copyright (C) 2026 Kevin Hilman <khilman@baylibre.com>, Texas Instru=
ments
>> + */
>> +
>> +#ifndef __PM_DOMAIN_CORE_H__
>> +#define __PM_DOMAIN_CORE_H__
>> +
>> +#include <linux/pm_domain.h>
>
> I don't think this is needed. Instead please make forward declaration
> of the structs we need. Like:
>
> struct device;
> struct generic_pm_domain;

OK.

Kevin
