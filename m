Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E43A6F11
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830770; cv=none; b=eKdWsprZnwfTIOPfq1Ho0tKAKCkaGYHYiWAZZgmzQ5rGSWyowIOM2iwszPS/ztzfxAaJc00qGc/MbvKQ6ao8//Tm0kOU3J+Q41vdalPNWHgot+gSI39via12WSLtNLqy7VIozTlsW5/zOvfYuyxH2xAKEoVeNYxvRcMvks5UfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830770; c=relaxed/simple;
	bh=wJbzi3CjEWYRW6F8QGjB5MCTpn7eSajB29LpxYDyDmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWBSszUqtOQX6YUjX+lI6BhMlzL4AwanUOMxW3DhWKAcLf5SsOcIM6/TzSJc9YZid+DEfEhveRlqLPelaosBCtddpnXP6KbrqEoqhG8zQSWniZIjr01HCjj4nXQ5b6ckkgVwmLZkK5k+gC2zy7yjdReMMVOc4G5k/y6tZI4o+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhNT1XW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhNT1XW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903FD1F008A4
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830765;
	bh=/MEr9TnYRLEADPm5dzJuPJHXku6tQFEe33VUaq9byuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fhNT1XW5NUlRnPw2Fivx9Ih549qwrcSW7eJTooUp25OG4U85bx6y89U9yu2QZezoY
	 VYoo4RGdZ6fSJH/oRLNPTdWosFIZecXQLfy/s3P+kr0gaMAqFeFRxOoYDDZSWPIo8r
	 PMoE4XuJwzcX0Jip3GzH1i69yARx2MqavXPoGexxo6Uffc9PqLsd4/JVyJOx/1BqTH
	 fxi5he5vJ0kwD+zUpA8Qwdh1Ydjtz0rPtA4GQEUQx2yljoU19u8sKkcNSiWzb42gJL
	 mpWT8s5HfHE0EKb/II9Ec0U82pY4wU0wLeCLlEZpHuPn47kcbwAb24z9OEwjntz2wU
	 O6jKN4SiBHveg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bccc96684dso380921e87.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 11:46:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwq7efa5tP226x6j7LhnvGHjgdeUwEu77xjWlVVc7Eup/tPOj0aP1cw41eqv8JSR/k7neIh/pC/9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKvEMH3H1QPrQi9iOVYsqngu6GU7S69QpmkecB6uMx2lrAXqPzU
	QvQaYCXcV2qdTFcRmShTYmY9HEz2wFGUTSfM86XqqIZdu/48DiEs4f5d9tIIqi3tepvHtgLuxD2
	VPxtNdQtJyVRtrLVa7XFqeYx0JibC1PM=
X-Received: by 2002:a05:6512:3a92:b0:5b8:eb3a:759b with SMTP id
 2adb3069b0e04-5bcde8bdabdmr3719119e87.42.1791830763879; Mon, 12 Oct 2026
 11:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-2-55f5fe409c55@amd.com>
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-2-55f5fe409c55@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:44:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLOJ49Zn_vPbpbqhPQ_F3W5PCpFN1VnxOzoxL7Y4PN+A@mail.gmail.com>
X-Gm-Features: AclHuK_xrLBr4L5nslTfPR7n5tDlLGvjFUHFyA86wwCkbsTjUQQ1gKk2AD2PTHM
Message-ID: <CAJZ5v0iLOJ49Zn_vPbpbqhPQ_F3W5PCpFN1VnxOzoxL7Y4PN+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] PM: runtime: Add pm_runtime_if_active guard and
 conditional variant
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Tretter <m.tretter@pengutronix.de>, Harini Katakam <harini.katakam@amd.com>, 
	Shyam Pandey <radhey.shyam.pandey@amd.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 6:00=E2=80=AFAM Golla Nagendra <nagendra.golla@amd.c=
om> wrote:
>
> Add a pm_runtime_if_active base guard and its _try conditional variant
> to pm_runtime.h for drivers that need to conditionally acquire a runtime
> PM reference only when the device is already active.
>
> The base guard must not be used directly via guard()/scoped_guard()
> because pm_runtime_get_if_active() only acquires a reference when it
> returns 1; the destructor unconditionally calls pm_runtime_put(), which
> would underflow usage_count on a suspended device. The base guard
> exists solely to back the DEFINE_GUARD_COND _try variant.
>
> The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) satisfies the
> _try API contract that guards must not produce an error when runtime PM
> is disabled for the device. When pm_runtime_get_if_active() returns
> -EINVAL (runtime PM disabled), the expression calls
> pm_runtime_get_noresume() to pre-balance the destructor's unconditional
> pm_runtime_put(), then returns 1 so the guard condition succeeds
> (bypass). This mirrors the behaviour of pm_runtime_active_try which
> uses RPM_TRANSPARENT for the same purpose. When the device is genuinely
> runtime-suspended (return value 0), the guard condition fails and
> ACQUIRE_ERR returns true, allowing callers such as interrupt handlers to
> skip MMIO accesses.
>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
>  include/linux/pm_runtime.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 64921b10ac74..ae2a8740ffb3 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -609,6 +609,13 @@ DEFINE_GUARD(pm_runtime_active, struct device *,
>              pm_runtime_get_sync(_T), pm_runtime_put(_T));
>  DEFINE_GUARD(pm_runtime_active_auto, struct device *,
>              pm_runtime_get_sync(_T), pm_runtime_put_autosuspend(_T));
> +/*
> + * Do not use directly -- the destructor calls pm_runtime_put()
> + * unconditionally, which underflows if no reference was acquired.
> + * Use only via the _try variant below.
> + */
> +DEFINE_GUARD(pm_runtime_if_active, struct device *,
> +            pm_runtime_get_if_active(_T), pm_runtime_put(_T));
>  /*
>   * Use the following guards with ACQUIRE()/ACQUIRE_ERR().
>   *
> @@ -624,6 +631,23 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
>                   pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET =3D=3D=
 0)
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>                   pm_runtime_resume_and_get(_T), _RET =3D=3D 0)
> +/*
> + * The _try contract is that no error is produced when runtime PM is dis=
abled,
> + * so bypass the guard when pm_runtime_get_if_active() returns -EINVAL: =
take a
> + * reference with pm_runtime_get_noresume() to pre-balance the destructo=
r's
> + * pm_runtime_put() and return 1 so the guard condition succeeds. Interr=
upt
> + * handlers then keep servicing interrupts when runtime PM is disabled f=
or the
> + * device or CONFIG_PM is not enabled.
> + */
> +DEFINE_GUARD_COND(pm_runtime_if_active, _try,
> +                 ({
> +                       int _r =3D pm_runtime_get_if_active(_T);
> +
> +                       if (_r =3D=3D -EINVAL)
> +                               pm_runtime_get_noresume(_T);
> +                       _r =3D=3D -EINVAL ? 1 : (_r ?: -EAGAIN);
> +                 }),
> +                 _RET =3D=3D 1)
>
>  /* ACQUIRE() wrapper macros for the guards defined above. */
>
> @@ -639,6 +663,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enable=
d,
>  #define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)  \
>         ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
>
> +#define PM_RUNTIME_ACQUIRE_IF_ACTIVE(_dev, _var)       \
> +       ACQUIRE(pm_runtime_if_active_try, _var)(_dev)
> +
>  /*
>   * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
>   *
>
> --

For the record, I'm still unconvinced about the guard definitions above.

Please try to reimplement the series without them for the time being.

Thanks!
