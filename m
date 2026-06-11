Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C797348C74
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206425; cv=none; b=NjJqLvBofoKOTSkjA1AMphdB3U330AL40MQ1O2cwGNYg08LOaxe1y0pk4Q3MtmNZNN+m8JHiV+w+fQwsOcUqav9j8vIBvSwSx8fBVv71QXgCOsCaCHsgl3VzgZ5joFYXALtKvdl1HpK7UjnXQ4zxEgOzgePhwCqLnT3O8UD9YIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206425; c=relaxed/simple;
	bh=j2tVtu5wHDHndIUHO2IwR5Uecq6De3dwqEjLMAlWDGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7ovU2rhtIvmX3919xWjpgTDq95HrsMVeEjn++QnR3/oHbWBNTRaYszShND2FAnaYLfLPij++SD8CBnEpYpS5vjNlfTRfwj/fmh5X51uh87WeOF1MkRJj+hiGhTuaghU7Zo2d5sVfFNrLuh88U9NOXXNANCE0ORyA0OVohh+Y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=P4hz9DA3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="P4hz9DA3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c379e8ffso2008235ad.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781206423; x=1781811223; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVsJ8++utKin3mieaJdECv9juBLFJR0FTwftyuevdnI=;
        b=P4hz9DA3yP37qWsRBz+VdgBxw6DhfxBnlesTSCp5CV5FZ7ep5b4ZxWEsfGmjEtYU8o
         tjaiRTs9Y2jb7rcKj5thhLGto5iNY8FVclm1idJNHPRK2J0XyOS8q5WtYSd9glpsDNm3
         vRFb1QaZczSmGMte0DhwE2l0t5MvK3Yg14t1DO6D+CMOxHUj2G7m/zNvHT0aEeARNLKX
         lWctadtRcNMq5v6qaiO7k9gg6RW+jc3N0WsvedaY2e4yiq0IHkm36JOQRslp0vNX26XM
         0neZlQEC71bGoYYgSoqkIls+u0MGeMfKYOui/D7zgiuIs3QoGOfXTa19OJxg4jUtYtZj
         VevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206423; x=1781811223;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVsJ8++utKin3mieaJdECv9juBLFJR0FTwftyuevdnI=;
        b=ARyZXxuYvKqn0o8sSXGuectqhrPtERQx3pGpx3o8BDPyc5QO8NQEEpUhN1J9cbi+My
         HsijU++nUHyW0O+2DIkwVrgIOgmWHC++sziUbxj/oURbzThOkNhb4piNVvuzrX+ynfnA
         eYfkznsUzntFisJezGfp43q+tTAAU2mjFE9WFZ7uEeF5lrfpPmQfU5tpQqCDzhRgjlTm
         QlP2zDEQCRIK/CpV1hlyVSzyD3kI0PE6iOVIoIYqkFlkhXIQWs0qUOdiJts2rKojG4Qc
         Sncxi66FG3N2cUykiboOKDYOEDDh+OhPobFRp3CfB5l2aZlhxqjfCAwEtuVdaZnnCyOS
         0LYw==
X-Forwarded-Encrypted: i=1; AFNElJ+MCllWCVmLGEjcEldnYIf/S7S+WKhFjlXULrRr9GOF4teAF1iUb3F0s2aVfaMq+1QGWTg1+TLyEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmWvVHkGYEdD/NoTn337ztu63IKiUGk3juna/iYZVMUoD/5Bd
	g0TbdiZvm+6SAt7fSI/APKJhABaNibeWr2VP240CDdK12Kzihd2fJX53/A+dIq86oNM=
X-Gm-Gg: Acq92OENQFgiDq6fv+CTe+OhyR5YxLgUs2QA+iEbxk8QpFiTfXT1JHhs1aGhJX8PHpN
	P3ntrucf+BGCwxR5cXz/IcGfy1FXZlzaAMcdvvBg/C+LnHPQJvXDQNyNohAlDg0k27M/ZAjNuLp
	5WJghPHudtZrvHeM2QSYQEFqbSJ7iTEbmlTYoWqdqFRQj2kswm6iivhW8sXFfx5BBAwZBQbmf/C
	2sMpOsly00YSkDJe8CWO22ygE4lnWV0JWjXsFmGQs4ktHz4SF2ln5Qyrr2aO9UW+uJMmf1wHjW2
	FmxXW+fUSKy1YS8Wpl9MMN67GGkQetYzL6I0ixuO1FLYfwZFPIXv3NX+Bbce1fQ/6stMM71hkFN
	lof+pUGukeswhUFXH+JC3z+S7KPj45xispDjYnsYw9oEEBdt0ixN+clB3CzpR6RggZgkjhQTF0Q
	+e16gHQtKVYy9gzDtq8gkVZLTY9gBu52I=
X-Received: by 2002:a17:903:1663:b0:2c0:d99a:2fc with SMTP id d9443c01a7336-2c2f18e291cmr55173755ad.2.1781206422730;
        Thu, 11 Jun 2026 12:33:42 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2c1664ad172sm289256475ad.83.2026.06.11.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:33:42 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pmdommain: add support system-wide resume
 latency constraints
In-Reply-To: <CAPDyKFrqT6DPUk5yWBDfnebHKTm4rGZp-8ZBRdcvp4r5Vu-PoA@mail.gmail.com>
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
 <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
 <CAPDyKFrqT6DPUk5yWBDfnebHKTm4rGZp-8ZBRdcvp4r5Vu-PoA@mail.gmail.com>
Date: Thu, 11 Jun 2026 12:33:41 -0700
Message-ID: <7hy0gklvmy.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Fri, 6 Feb 2026 at 01:30, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>>
>> In addition to checking for CPU latency constraints when checking if
>> OK to power down a domain, also check for QoS latency constraints in
>> all devices of a domain and use that in determining the final latency
>> constraint to use for the domain.
>>
>> Since cpu_system_power_down_ok() is used for system-wide suspend, the
>> per-device constratints are only relevant if the LATENCY_SYS QoS flag
>> is set.
>>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
>> index 96737abbb496..bbf59b93c8b6 100644
>> --- a/drivers/pmdomain/governor.c
>> +++ b/drivers/pmdomain/governor.c
>> @@ -13,6 +13,8 @@
>>  #include <linux/cpumask.h>
>>  #include <linux/ktime.h>
>>
>> +#include "core.h"
>> +
>>  static int dev_update_qos_constraint(struct device *dev, void *data)
>>  {
>>         s64 *constraint_ns_p = data;
>> @@ -425,17 +427,60 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>         return true;
>>  }
>>
>> +/**
>> + * check_device_qos_latency - Callback to check device QoS latency constraints
>> + * @dev: Device to check
>> + * @data: Pointer to s32 variable holding minimum latency found so far
>> + *
>> + * This callback checks if the device has a system-wide resume latency QoS
>> + * constraint and updates the minimum latency if this device has a stricter
>> + * constraint.
>> + *
>> + * Returns: 0 to continue iteration.
>> + */
>> +static int check_device_qos_latency(struct device *dev, void *data)
>> +{
>> +       s32 *min_dev_latency = data;
>> +       enum pm_qos_flags_status flag_status;
>> +       s32 dev_latency;
>> +
>> +       dev_latency = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>
> ->cpu_system_power_down_ok() executes in atomic context on a
> PREEMPT_RT configured system.

Oh, right.  Good point.  Thanks for pointing that out!

> dev_pm_qos_read_value() uses spinlocks, which sleep in that configuration.
>
> I don't know the best approach to fix this. Perhaps add a specific
> dev_pm_qos interface that can be used here? Or re-work the code so it
> only applies for !PREEMPT_RT?

There's already a "raw" lockless helper to read the resume latench
(dev_pm_qos_raw_resume_latency), so I'll use that, as well as add a
similar lockless read for the flags.

Thanks for the review,

Kevin
