Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B04AD4CD
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277242; cv=none; b=EA57azjje/wXYT3MMfUSVFVbJVlpA2v7jTKSThjQ1+5Gx8Pcwf46fT8vDiO4yYMNRQHN1K09tHvyCggK/h6klDVcvQuOLIJEvoCgMbJI89WFeeOH6FJBc1WO+pCUrgVoak6HzMxh5pMCRKU/iIpAicHA5vO8Kcm6y8d0fGVU4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277242; c=relaxed/simple;
	bh=tey29UewwiZagl2viBjDQeferNNKc9zQ3gy8ftfL4Ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dC7rBap4rKTZCXpuR7vT6xrBkZMl6ib1XcnSRHkPxdo2g+SPdXS+KqEY4u6nxsKcOOLhXumkVLox+gzGeQBBB2EGW9sYO07aVLIvAhVvSOziW+qqrCQQ+euJ8EqEsLwiRqoT5P4Go1ZmG+C62L2bTBwuyEbKjC9hFnoRwpIuluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eQCm2wUV; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eQCm2wUV"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-398cb5615deso186547a91.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790277238; x=1790882038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvnf1ghRh8D9V9XevJAw+7YNx2ihEAZAcBmwrerr6hI=;
        b=eQCm2wUVLkLrXPozVJse6COtqjhYxNVrac0jOjWcdJcF+gJ6snJenkLozwQ5vOD9yB
         IzBQklETEZZYVi4EF4WQkOPnGuDDFCYOlI2Rbwc/u/YDOUAINHTcwk9A5rFUu6gqdt5o
         QNXy7ijvQbokuaVnmDM+6V1zcjXscKjkxgI56wkOQ++asP7hp3uZPsOn99SuXjrGp7kk
         QfLtYH/fciAof/nddLnN7HtYA2bGsDSxY4IGg/O3g066ORvaOtvmpKyo6T7095bkN6f3
         e57jAzCfmYBFvOGodaTGeh5c0ckJmDPkgJbfQTAGbG361mpPSUZn8l4REAieuF1YOW4m
         N3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277238; x=1790882038;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvnf1ghRh8D9V9XevJAw+7YNx2ihEAZAcBmwrerr6hI=;
        b=qzxTbZQlxbNagUQvCjIgC/HP0IgWxB8wYYyakH7Kn1HhIKTGXw4r75SkpOvWiXuvzE
         FCBWHSNGhT7lSUwIakKn4kt+Uais/OE4ElgPaO1VyEpiehv8eZ6KruvoV0PQuxohaXZC
         z0Zl0xD4qZd6rqLsQd5iHFE4EG9YQwrQmHVr30jILJ/u7ezvwyIdZkQioVNrJ3hCACah
         wLZCnIqsngkK61Qrjx7EcYkAHV1FLanvx6I06o4ERfsO7uxA5HalBxWJpMmsa+rg5MTj
         79bZhEjjjjA4O9BaKB+80dPL39hhnJXkbcnQcl74lmpHaT7k//1aPnPHIXUYmHtgL3GS
         ql/A==
X-Forwarded-Encrypted: i=1; AKwUvBwKKJVkGu4s1snbxDg+mosrA+Q5ysTpP4NUyX6uk+m2jBGiBVJoltWLILbiykIPeIUyyRk9uilL8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l1LJ0ue5RU1tT9ohjZ4PsC7DrXDqHCW5FZl5G/PJUDSELVoExK
	18D978FQ53QItC8FOfHR/dpm4c619haqjjpOJcsB8Qe/HLV9I531XkWA5RFjWk6X4V8=
X-Gm-Gg: AYBFou2aAQC0ofs6FQClfe3ODcvUAp3o9I3FejcPpWRoIYfdwEBgGhZPNLfuuqzZkaJ
	seHJlTsabCAFDPAIkmhl1wF4diFu6Uf3QPBPxOUQs9t5xFqVQCXODxszFQHUOJhNOZv2mk7xCJc
	T5rbTx9fxcCVYfWEL1Bn3Yqcwj3q/I59ebhqBB+7x+MwPc5pjsA3pODJNU8I+gk/Z/JXQrygyg3
	HTiSDnRwrJQ4PlrQ5PwHnphAaxyMG22zq6pfzby0kyFAg2NwbW53qrrTjT89arLyCU/o1FZj6L9
	uSAqoGSdsIEnD/zMcMsl1sYUv3oH1pit5NZOMzOt8t3D/btltk0YH8VWQ3l0y5Gd3tXdMnh0nSP
	rD1crA27B/ZUQ0fSNxO5TzQCS4UlgrcalKwqg8YzaY5icCrNX34vvBqFSKJDrat9RV4i7dUqRff
	JoJGdygHUyHhJgMZautbQd86E/aX4KX6OtVzi7hJEoPuBVuEgwdNz9CA6TaxJHsy1DIBMV
X-Received: by 2002:a17:90b:3852:b0:39d:f024:c7ec with SMTP id 98e67ed59e1d1-3a098d883b8mr3513768a91.16.1790277238027;
        Thu, 24 Sep 2026 12:13:58 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a0976ca5f9sm6528651a91.14.2026.09.24.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:13:57 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Ulf
 Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, Abel Vesa
 <abel.vesa@oss.qualcomm.com>, Kendall Willis <k-willis@ti.com>
Subject: Re: [PATCH v5 4/4] pmdomain: add support system-wide resume latency
 constraints
In-Reply-To: <CAPx+jO8UWa37s0XSZN2gGjcBrYOR9i_YMyZ8QWqkHoXrqVkorQ@mail.gmail.com>
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
 <20260826-topic-lpm-pmdomain-device-constraints-v5-4-28cbf43f7e38@baylibre.com>
 <CAPx+jO8UWa37s0XSZN2gGjcBrYOR9i_YMyZ8QWqkHoXrqVkorQ@mail.gmail.com>
Date: Thu, 24 Sep 2026 12:13:56 -0700
Message-ID: <7hmrt6bgy3.fsf@baylibre.com>
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
>> In addition to checking for CPU latency constraints when checking if
>> OK to power down a domain, also check for QoS latency constraints in
>> all devices of a domain and use that in determining the final latency
>> constraint to use for the domain.
>>
>> Since cpu_system_power_down_ok() is used for system-wide suspend, the
>> per-device constratints are only relevant if the LATENCY_SYS QoS flag
>> is set.
>
> cpu_system_power_down_ok() is especially used for genpd's that have
> the GENPD_FLAG_CPU_DOMAIN bit set (cpuidle-psci-domain and
> cpuidle-riscv-sbi).
>
> In other words, this has no effect on other types of PM domains that
> are managed by genpd. Are you planning on adding that on top or this
> is sufficient for your use cases?

This is sufficient for my use cases.

>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Reviewed-by: Kendall Willis <k-willis@ti.com>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/governor.c | 56 ++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
>> index 96737abbb496..1a85fd375db9 100644
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
>>         s64 *constraint_ns_p =3D data;
>> @@ -425,17 +427,71 @@ static bool cpu_power_down_ok(struct dev_pm_domain=
 *pd)
>>         return true;
>>  }
>>
>> +/**
>> + * check_device_qos_latency - Callback to check device QoS latency cons=
traints
>> + * @dev: Device to check
>> + * @data: Pointer to s32 variable holding minimum latency found so far
>> + *
>> + * This callback checks if the device has a system-wide resume latency =
QoS
>> + * constraint and updates the minimum latency if this device has a stri=
cter
>> + * constraint.
>> + *
>> + * This runs in atomic context: for a CPU domain the genpd lock is a raw
>> + * spinlock and the s2idle path runs in the syscore suspend window with
>> + * interrupts disabled.  The lockless dev_pm_qos_raw_*() accessors must
>> + * therefore be used here; the locked dev_pm_qos_read_value() /
>> + * dev_pm_qos_flags() would take dev->power.lock, which is a sleeping l=
ock
>> + * on PREEMPT_RT and must not be acquired in this context.  The values =
read
>> + * are best-effort, which matches the sibling cpu_power_down_ok() gover=
nor.
>
> This is a bit too much in my opinion, please leave out the parts
> concerning the syscore/atomic/lockless parts.
> If we want that information to be described (I guess it would make
> sense), I suggest we add that along with cpu_system_power_down_ok()
> instead as it better belongs there.

OK, sounds good.  I'll move it.

>> + *
>> + * The system-wide flag is checked first so that devices that have not =
opted
>> + * in only incur a single lockless read.
>> + *
>> + * Returns: 0 to continue iteration.
>> + */
>> +static int check_device_qos_latency(struct device *dev, void *data)
>> +{
>> +       s32 *min_dev_latency =3D data;
>> +       s32 dev_latency;
>> +
>> +       if (!(dev_pm_qos_raw_flags(dev) & PM_QOS_FLAG_LATENCY_SYS))
>> +               return 0;
>> +
>> +       dev_latency =3D dev_pm_qos_raw_resume_latency(dev);
>> +       if (dev_latency !=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
>> +               dev_dbg(dev,
>> +                       "has QoS system-wide resume latency=3D%d\n",
>> +                       dev_latency);
>
> Do we really need a dev_dbg() here? Leftover from debugging?

Not needed, debug leftover.

>> +               if (dev_latency < *min_dev_latency)
>> +                       *min_dev_latency =3D dev_latency;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
>>  {
>>         s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NSEC_PER_=
USEC;
>>         struct generic_pm_domain *genpd =3D pd_to_genpd(pd);
>>         int state_idx =3D genpd->state_count - 1;
>> +       s32 min_dev_latency =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> +       s64 min_dev_latency_ns =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_N=
S;
>
> We don't need to assign a default value for min_dev_latency_ns.

OK.

>>
>>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
>>                 genpd->state_idx =3D state_idx;
>>                 return true;
>>         }
>>
>> +       genpd_for_each_child(genpd, check_device_qos_latency,
>> +                            &min_dev_latency);
>> +
>> +       /* If device latency < CPU wakeup latency, use it instead */
>> +       if (min_dev_latency !=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
>> +               min_dev_latency_ns =3D min_dev_latency * NSEC_PER_USEC;
>> +               if (min_dev_latency_ns < constraint_ns)
>> +                       constraint_ns =3D min_dev_latency_ns;
>> +       }
>> +
>>         /* Find the deepest state for the latency constraint. */
>>         while (state_idx >=3D 0) {
>>                 s64 latency_ns =3D genpd->states[state_idx].power_off_la=
tency_ns +
>>
>> --
>> 2.47.3
>>

Kevin
