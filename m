Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6DC43030C
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229095; cv=pass; b=sm9poYGA0xkELRnF1K+CFI0tPU4kIS4T5hUOx8WbK6Mn86QNQLuNzBqJH7mftom9ncQoOLJnAN1ct+bVofHzH3wi0OYtpAefpHJ4YsPocSkxUnTXsAfP8UQ/YznSFOavBG7P4kY7whNofjrrlyNGeOTUBPyk0Pr2Fn8mM+5svs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229095; c=relaxed/simple;
	bh=4VapZJRDmF3WSIyi79B97xpzHYfeRA3NKNF4cn5+wm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV4Ml4N6dax+T0nCQgSL4le2wOlNPWL3vM/uaHWC44HP2MSvd2DIkhfjNDzqvglwKzL6A7dcRODPU+dSoyNx1UjpZpaugzx9vyyEY7/wrX2AxfolcGCDcD+FhUaiZ9Aebe8bANBdTXcFFoz8TLGtduCreE6JMm4tMr2+rHQzHew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZ9MERHg; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZ9MERHg"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so5151a12.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784229092; cv=none;
        d=google.com; s=arc-20260327;
        b=kzNxupxHGeOypeFiZVqDnIWSA0YPLggrakKEK0l6LGYcHsdOAtXEQ2OpNZ8nCNTDtn
         7pNMbuhvZhEZshKapAr5wyVBHcgN2VcJLL13qcNQdsrUp62fCK4h1NJ/XYcPUaXHyNBs
         wq2lAc6GHQdDL99MlVSJTPLAU+RPn+8Na69XTqh/cPdFhTF5mMXr43PfQWKpsDr3EYF6
         MihhAxgI5PcSNcsw08RJVymzXzivlvSYdaMM2zZLcfa4tP1mIp9bsjbpAk2DRS7Y9BQ3
         geOUZlyxCirw8Avnhy0kTvCREvNaGOIEeqdsBcmZqorrJKLX+AU8NTD6ASeH9Xl5Bjxx
         JSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=66IJRi/rauwLRinBZlzo5PXKwTqAJj2LwQRJbCuIN6c=;
        fh=hFxZfXCTWw/hTi9jH6isfFAfogetbxrzyls3khaA4qk=;
        b=Pq15nE0+/l2z/jqoa5AoSDeVc5P+SwyIa5p0B/4wkGwKa5P0uYzPNveF+HRjSozMNb
         Rm4cZ1CqK06gxfpcx24w2O6SMsjnDqwi4LbxkmD109linI7yomFl2CeU0bxqnagDO1hT
         1tytwmizirJwaNQqq12fdDVgO5TZN+u11/O5KIvLxDWMqa5r5BDQWZWwMZbVQ3FbGMFD
         BE/dJLz8MAqnhW9vrpfVUw+w0L6MZ87d+jwcgg/R97sYH/5egT6UO/qPYJDOB9eL8RpX
         9mZREBJGW7H3oZSUvXgrBzVLxnSgBAKjqNdgWLf/YoHlUOJFopiiw0BXds6ryersmcY2
         CpVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784229092; x=1784833892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=66IJRi/rauwLRinBZlzo5PXKwTqAJj2LwQRJbCuIN6c=;
        b=kZ9MERHgoYSbFBo/HgoYlOKUFJtd6gTSodTJuyMbhgId0zQZenLLTMGVfDjx9bwg18
         OP3vaQ/NIYlvHiicME0Pex/w1QMieyVA7ZAlZ7rA4aJyzQczP5pw9PY5N2eE52chdOVz
         t28Ts8o8rCQ+I8wRCXZ3uKUzLXpbN1f8AelS8KOPyV/qcyBW4V+6/oGCrekd6hAFj9re
         vXw5HE0/Oxk+Vu6WIVCf/g8VKaIr8QeOWB0ePvH88aYu54WIEc1ID2VqKJw3QnU3nw/9
         vPYALxoifCMHIEEKKAt1CDbhAqddXRPscoPyB4hey6pXnsugkToo+YUGEZlS93qlpUOo
         HvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229092; x=1784833892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66IJRi/rauwLRinBZlzo5PXKwTqAJj2LwQRJbCuIN6c=;
        b=fUZJl0dEV7xGT7KZwODU7/n14Icg+OVJFvsLX8bkTwUcNieLg6BjQ0UjYLNSIVBpV4
         IGdDLXUaRPguUD/pnyxtmBsNZ6eGvfkQYEMC19MZTTk6/cVg9DquS9H73R2kJ9kEYmVs
         /1r+ihDwX+RkNxi2FZckFzqhWHXsu/AvI48UkZQmu5aV3cthgdu+A+cjp7pTffo2ldGy
         B3O8rBBeTlZNAkzCS87qNYyUyQYV7lF7AeviuU4khLbDnD3ut0IvpYhisabXyXmglVmO
         ihZDzXACNuYqYpk8NaZcFkytXHy73MYSqC+zh4liH9QcOnpKSgufSU5dflOpaVR93FgF
         zCSA==
X-Forwarded-Encrypted: i=1; AHgh+RqIFkRbFZh9Z6tgeHUfSWSDjDaWbABoABkIaQH0ibYhY83rEbtp0reDc9zWP9mwR56CBMEDWEbouA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCegnlQbV21Ausrei9wtQ9JavoEOOltIboDUr0KSzQHaJZxIfz
	fAh2tjKRnT1aB32FPeoqQF8xX2/HbbZBzf5xSUAOpHbWA2V+5qQ11MEmLszjCJDwk9OtjQXds6U
	hvKXih0AuI7osf9Z3EKWzg4DUtJklh2LMlFxKmiIO
X-Gm-Gg: AfdE7cms8THTvWztNq1/VjWicpTmLi4P6nmG4fjm75OUD0F0s92GWXtH9fCymn+E2Rx
	93oykUnXVPoncw/JrMT8hAtr/3XRMIVMp9Fa1P7vTfxcUEegqt4GxdPwjA5++GdDo8tFL/TejWn
	dpII6Vfv8UuS0xD4SrHGZLSJ3vyCleXwOgNHktbURXAeDyGT0ZguiyL+JcmTlVwBFBCpODNI1OR
	YhybiusBkN+C23+ICYAq+xfqIfh9Fjk+Io9hPuyJsu887JwdL/G6a39GdLHUQ==
X-Received: by 2002:a05:6402:1210:b0:697:be5e:3c26 with SMTP id
 4fb4d7f45d1cf-69e601882c7mr5404a12.7.1784229091383; Thu, 16 Jul 2026 12:11:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com> <20260618224527.1506419-4-jmattson@google.com>
 <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
 <a962064f-fcd5-4ad2-bc7d-4249ec8fa495@oss.qualcomm.com> <CAJZ5v0iJ=gLpjX2ZGhH7v0QQKROkoOto6R6-pOk=76ADrNWySw@mail.gmail.com>
 <d05b97f9-140d-4937-8c83-de688e392d6e@oss.qualcomm.com>
In-Reply-To: <d05b97f9-140d-4937-8c83-de688e392d6e@oss.qualcomm.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 16 Jul 2026 12:11:18 -0700
X-Gm-Features: AUfX_mzO4GTg9LCXqc0-audqW_vY4qoqUo27A3yIEj39gttfZUq-Y0wrGQJ65AI
Message-ID: <CALMp9eR1_ud8-qi+iHHRmCYtrwU2vKE5PkQDPDS=7Rja5eKnQw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in cpufreq_boost_down_prep()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bp@alien8.de, tglx@kernel.org, x86@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 8:50=E2=80=AFAM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:

> Hi Rafael,
> Thanks for the clarification.
>
> I agree. Just for discussion, two possible approaches come to mind:
>
> Option 1 (structurally clean):
> Introduce an optional per-CPU cpufreq_driver->set_boost_cpu(cpu, enable)
> hook and call it from __cpufreq_offline() before cpumask_clear_cpu(),
> but only on the unbind path (not on plain CPU hotplug-offline - clearing
> it there maybe wrongly re-enable boost on a still-online sibling on
> shared-scope HW). Roughly (rough sketch only):
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 21639d9ac753..5f298fbb0d8c 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -525,13 +525,10 @@ static void free_acpi_perf_data(void)
>          free_percpu(acpi_perf_data);
>   }
>
> -static int cpufreq_boost_down_prep(unsigned int cpu)
> +static void acpi_cpufreq_set_boost_cpu(unsigned int cpu, bool enable)
>   {
> -       /*
> -        * Clear the boost-disable bit on the CPU_DOWN path so that
> -        * this cpu cannot block the remaining ones from boosting.
> -        */
> -       return boost_set_msr(1);
> +       smp_call_function_single(cpu, boost_set_msr_each,
> +                                (void *)(long)enable, 1);
>   }
>
>   /*
> @@ -951,7 +948,6 @@ static void acpi_cpufreq_cpu_exit(struct
> cpufreq_policy *policy)
>
>          pr_debug("%s\n", __func__);
>
> -       cpufreq_boost_down_prep(policy->cpu);
>          policy->fast_switch_possible =3D false;
>          policy->driver_data =3D NULL;
>          acpi_processor_unregister_performance(data->acpi_perf_cpu);
> @@ -986,6 +982,7 @@ static struct cpufreq_driver acpi_cpufreq_driver =3D =
{
>          .bios_limit     =3D acpi_processor_get_bios_limit,
>          .init           =3D acpi_cpufreq_cpu_init,
>          .exit           =3D acpi_cpufreq_cpu_exit,
> +       .set_boost_cpu  =3D acpi_cpufreq_set_boost_cpu,
>          .resume         =3D acpi_cpufreq_resume,
>          .name           =3D "acpi-cpufreq",
>          .attr           =3D acpi_cpufreq_attr,
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 507224c9ecd3..c4952ca3e8a5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1669,13 +1669,18 @@ static int cpufreq_add_dev(struct device *dev,
> struct subsys_interface *sif)
>          return 0;
>   }
>
> -static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy
> *policy)
> +static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy
> *policy,
> +                             bool unbinding)
>   {
>          int ret;
>
>          if (has_target())
>                  cpufreq_stop_governor(policy);
>
> +       if (unbinding && cpufreq_driver->set_boost_cpu &&
> +           policy->boost_supported)
> +               cpufreq_driver->set_boost_cpu(cpu, true);
> +
>          cpumask_clear_cpu(cpu, policy->cpus);
>
>          if (!policy_is_inactive(policy)) {
> @@ -1730,7 +1735,7 @@ static int cpufreq_offline(unsigned int cpu)
>
>          guard(cpufreq_policy_write)(policy);
>
> -       __cpufreq_offline(cpu, policy);
> +       __cpufreq_offline(cpu, policy, false);
>
>          return 0;
>   }
> @@ -1750,7 +1755,7 @@ static void cpufreq_remove_dev(struct device *dev,
> struct subsys_interface *sif)
>
>          scoped_guard(cpufreq_policy_write, policy) {
>                  if (cpu_online(cpu))
> -                       __cpufreq_offline(cpu, policy);
> +                       __cpufreq_offline(cpu, policy, true);
>
>                  remove_cpu_dev_symlink(policy, cpu, dev);
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ae9d1ce4f49c..c174b013dd76 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -413,6 +413,8 @@ struct cpufreq_driver {
>          int             (*online)(struct cpufreq_policy *policy);
>          int             (*offline)(struct cpufreq_policy *policy);
>          void            (*exit)(struct cpufreq_policy *policy);
> +       /* Optional */
> +       void            (*set_boost_cpu)(unsigned int cpu, bool enable);
>          int             (*suspend)(struct cpufreq_policy *policy);
>          int             (*resume)(struct cpufreq_policy *policy);
>
>
>
> Option 2 (lighter, but it is at odds with the direction discussed
> above): stay in acpi-cpufreq's ->exit() and restore over
> policy->related_cpus instead.
>
>
>
>
> --
> Thx and BRs,
> Zhongqiu Han

While you negotiate the cleanup, should I remove this change from the serie=
s?
