Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FB3E95B5
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138272; cv=pass; b=kbYhpiEdC+uRiN/7wUJl6qj6Qa2XWkkuUqZfY4h7Zxvlzn0iNAkePG0Nb/MgZATnjwx94tSBarYEhXF1fv6036uhwDZIcafAQCNawHOC0dFlGyp+nrSZAMMq1JPQoCubH3MlzyA258dGkdRkJKVJzaRPeKb03aB1jqs2bioiyiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138272; c=relaxed/simple;
	bh=kxcf5k2UPOtdvkx5dEPnf/zj1AkufIDZchYslyDiVLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTkYqDxZLP1F1OXOy31GwgcfB/fqa0bkAORLT0yspNOBJvIGMTV/TyhjILEPRBwsZdJ+VjnW4rUdM0gKbuBgzBtCsjWm7f0gprTKBM+yS3cjSA55GxXycyJjzls8UEUI5JEgcUOj5GnlBd93QIHvsQOVUAYfYChWYJG77ohmS9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vHGTcnMz; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHGTcnMz"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a12f88d839so6486212e87.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773138269; cv=none;
        d=google.com; s=arc-20240605;
        b=AUGSLG69joqm1Uy3wYn2Mf34HvtBX9uO2l9nCgf/LaA6yd6GePHwCGS7Mq9QDr4ao0
         /DyjPWrDxcwvVMP33qaRMF0E9JBfXsSkzVTXBJBZI/34h8P4iF3hVOfcPWdAoFeN3sMY
         A4ulXATkHtP91cMZgXjUbw8aS9zcWe9sPyzcp0SEU+ibWliguGfeNrKQU1ZTX0UJTbGj
         2oPbjA7nP6RnAeKtzFV69L5omZ3BsQC+H3ITc0/FqseZYTonClEeq03aOiXMqEGwkQBc
         2YD2NhUcTFBRo9uyrzBfo7zuuKQ4frp34VYBciYbZljRVvBwou9v7KtJaqRENc+vN147
         +HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0YFvAt7Z2RB6Pm1r5SCiMRwR6pxWZQ53tO3Go8igZuc=;
        fh=v65OMNpajEtUhzMliKbl2hDIiTrjQGAddBzScwPU5J0=;
        b=iGZHLOittcXKzatSpLLoFHmRvnO4u//wSmVeshp+dah8jxvaV1GSHtFQN8g16/bIY4
         gid7F3+kWtXecVWVUOb3G36wlL+SsBriAG259JlFPeB5deB1iUOjxqd6tJKAj3+eblJL
         LsqY5GTYVL+SRIAwEXiRDaJcfR7W4JtSPIXcm3ojd+/aKVnXDwGGBVQbJj6oD3wlbB/J
         UazCoOr10VBB1fxwLcOANFTBhhpXKRMbtFo5fXvrwPUuaVaRvyYV/edUFXq8Z4+icoEz
         UTgT7OP2apPAdG1EMzFiKKC0cm6EvmbETQ0S+BOfxDM9tUL8uAaN9aLqoLNdj5wO2Nz5
         K0oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773138269; x=1773743069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YFvAt7Z2RB6Pm1r5SCiMRwR6pxWZQ53tO3Go8igZuc=;
        b=vHGTcnMz3pary1vNfOHUd2kWi0vawPA546qZfRHQNP3KCyR41U1AF9j3cJhnZrQky7
         lPBWTrI9rt1hk5QsREnt9EPsrX0BPJh4mM7QeOGBxrl6OtmMkOshozTCKsuJAa13gVGJ
         nHLAtBznKxHr6VX8ow65vhqXFghFb5xRc6b28JI7qfh3qrO//hjqVFSzakmwZ4EMsRt8
         jo8+DyZCjfDDo5ZuZQIwHfORnxX7Us5veQ7b4PQkfb4OpB3vrsWgJGQ5CoLYNb7MA2Ty
         ssDTAH1SaiyZNvi35rF9pzjYSIkKm3zcP2NmXoHjljFBbK6B4ztxY6RJ6dSs7xpR4bNn
         Ctlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138269; x=1773743069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YFvAt7Z2RB6Pm1r5SCiMRwR6pxWZQ53tO3Go8igZuc=;
        b=gU2j6qC4FBxz0Cbw/1ERiANYB4OAC2PK9QQuQ8MoOOf4+KlNKtYjqUTIC3bDYwMTLt
         v3S5qel4PSvoLE/ZJwqt0P0WCH8EJFRVXTiO2yyyk+1vurq3bILC0WJyqlDCRCSFSIoq
         /6TjaCTiXI61yOwlBQR63MVKTGUGiTBd+G6MNfncjVM5c9ybRyksIX+DiOTRs384i5L4
         btyD4rN26lZgon4ZHH2JFjV/lqq6FOLPc50QYco9rTuuCIU1jc11mW7NkG4/RQhlua+m
         n+VgF1gLOL3lF9NmVt1TOA3yy/a/6862ZMQv483SoSymYirB42VAA36rkoWIXjE0NPMx
         0QxA==
X-Forwarded-Encrypted: i=1; AJvYcCWPNbsCWg14StEWi9bSaHU8kud+bmmJtuzr3Tv2eVUZGul2oJHLoIval1p98lxGuscEoy7cKHT6UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2R5S/XRD6vZVdADeLL/ywuM53lHadSoNcoxf9FkiT2+0GisAG
	b5aWaAXxXIZbc8rO5IdnCqiMNJXUSlNpDiNNcgTloNR5ZJKZudRRc60SGcUdlASPsTvOucDSqbO
	XX1x6m6x+SR19IR80/fpw9jLjWJGDTehf+uiz0vJzpg==
X-Gm-Gg: ATEYQzyt2LJUDeETEmgXafvk9D8oAb1iVHEphZreAKnxTsbCO461i8O2ekVKmxHwHdm
	5hIXp8aKL37ZlQvVIOog7Aa9QyUemqmpn02fSr7xfzmLIU1MNiocPJwFo7j75RKpCSBIpyXFTCV
	4ICxyw6GQoZkXjke0jXO6E8Xdc5kQ7uZKE6MYDS3nLWHlhFAI+K0jl6Diz+owIhQIq9h5KWjwiH
	LBiXGxrEBCb7wyjaUCFeltyAEhOV0v+mXja49ey2CKLfunIbagSusO+t8B7af7tRK4as0fx1J5l
	4ni+6KRQ
X-Received: by 2002:a05:6512:1293:b0:5a1:37ab:312b with SMTP id
 2adb3069b0e04-5a13ccaf17cmr4959508e87.15.1773138268907; Tue, 10 Mar 2026
 03:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
 <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Mar 2026 11:23:52 +0100
X-Gm-Features: AaiRm51k87gddlwmdO0AtQLWgkQM9kFWeDjJvf7zu2IU1Yln-eq9vl4G5akKC2A
Message-ID: <CAPDyKFrqT6DPUk5yWBDfnebHKTm4rGZp-8ZBRdcvp4r5Vu-PoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pmdommain: add support system-wide resume latency constraints
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 01:30, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
>
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index 96737abbb496..bbf59b93c8b6 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -13,6 +13,8 @@
>  #include <linux/cpumask.h>
>  #include <linux/ktime.h>
>
> +#include "core.h"
> +
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
>         s64 *constraint_ns_p = data;
> @@ -425,17 +427,60 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         return true;
>  }
>
> +/**
> + * check_device_qos_latency - Callback to check device QoS latency constraints
> + * @dev: Device to check
> + * @data: Pointer to s32 variable holding minimum latency found so far
> + *
> + * This callback checks if the device has a system-wide resume latency QoS
> + * constraint and updates the minimum latency if this device has a stricter
> + * constraint.
> + *
> + * Returns: 0 to continue iteration.
> + */
> +static int check_device_qos_latency(struct device *dev, void *data)
> +{
> +       s32 *min_dev_latency = data;
> +       enum pm_qos_flags_status flag_status;
> +       s32 dev_latency;
> +
> +       dev_latency = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);

->cpu_system_power_down_ok() executes in atomic context on a
PREEMPT_RT configured system.

dev_pm_qos_read_value() uses spinlocks, which sleep in that configuration.

I don't know the best approach to fix this. Perhaps add a specific
dev_pm_qos interface that can be used here? Or re-work the code so it
only applies for !PREEMPT_RT?

> +       flag_status = dev_pm_qos_flags(dev, PM_QOS_FLAG_LATENCY_SYS);
> +       if ((dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
> +           (flag_status == PM_QOS_FLAGS_ALL)) {
> +               dev_dbg(dev,
> +                       "has QoS system-wide resume latency=%d\n",
> +                       dev_latency);
> +               if (dev_latency < *min_dev_latency)
> +                       *min_dev_latency = dev_latency;
> +       }
> +
> +       return 0;
> +}
> +
>  static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
>  {
>         s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>         int state_idx = genpd->state_count - 1;
> +       s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +       s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>
>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
>                 genpd->state_idx = state_idx;
>                 return true;
>         }
>
> +       genpd_for_each_child(genpd, check_device_qos_latency,
> +                            &min_dev_latency);
> +
> +       /* If device latency < CPU wakeup latency, use it instead */
> +       if (min_dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +               min_dev_latency_ns = min_dev_latency * NSEC_PER_USEC;
> +               if (min_dev_latency_ns < constraint_ns)
> +                       constraint_ns = min_dev_latency_ns;
> +       }
> +
>         /* Find the deepest state for the latency constraint. */
>         while (state_idx >= 0) {
>                 s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +
>
> --
> 2.51.0
>

Kind regards
Uffe
