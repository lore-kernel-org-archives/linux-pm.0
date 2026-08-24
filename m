Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFE4611EE
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588365; cv=none; b=EurAQ3vGE/p4I5otI1BZgNZzRJLcEgBuMJYtDIGciruJd4J1Xl3Ya1SPHkl50bcZ/1QuwE7gf2S8j29X4b+yAbxENTrVT4Szp8pMogBo6KEKQ1L9NW2prfDEb48eaCWQz88b8Mu/P9dUfZB5hS6be044maxk7XEVZBAuUI++Guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588365; c=relaxed/simple;
	bh=rNdDtFDU2axzuWfQoyDcTdmbEp2bNS83R5Xa4ajWivY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVkuqJUekj77y2LhgrZ9633igfwnZC2njhFC/cWydbiPBdOT+IhNPobcaQIifm3NX17MvQ8GJzhI5waVRrahKVbBtGZ7uwdAf2ufhJtq/wZUR1earrrVAXaz9RJ80+y8WSilHuPO8l6gPhW+SbIMyv6CnaROyp61hR3w1WVNy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2zx3Q+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2zx3Q+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350C1F00ACF
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588362;
	bh=8lJZ+v1tQE+7fXGv9gG2/kR5WGSGWGubrkKIdBQfjbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e2zx3Q+DaSkTKQzibxEcudcXsl5ipdlSV+bIEg6UXND2/I0uEFHbnBB6iwQfKU0WB
	 M+T27rCEJhOr0vHHt+3LbEDUe3aVyTEoWNaSnQTtGnDBJkLJh+vljtQ+xMRted2fm2
	 mUnQ3ft56/wO426SMGDX7BK6/6o3NT+yZRWcyS5JEGmpVXpZ4sD2yOSYzX7quX6+IA
	 QmjSXGB1xKkOguoL6DW+TiGgYnnBKxQ9exXoPyoVic9VNro61PLSUKt32xDg6wdsty
	 MuYofxM79HiaDFwYuwuzRhvek2/1pVV8DFbU5mDu26TljRrFRoUJNsclHUpefZvn/Q
	 RU+84vR0H7HYg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a12ffc112cso501151fa.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:19:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrpH6ss1QXflWdMXmIHxmPEk5ctXmcWiwUTUtJSh9gl9ZIfCgfI/muZ3YdvEqYNQ0iJJdb6EV5kuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m8Q3cs+qQrdHCLdu4uoal0KFRhaJ2NMZ+fCalGdfX+xkuVFkxv
	B7Gqm1wdVtS9f2gDI8YfveIJAJiew6yFOvAos2grVcXgpSANVx4Y/38eilLthDXBu53nuRRtuuU
	hzK/Vp52hyela6BF1CPOBxyrPD/dqW5M=
X-Received: by 2002:a2e:be2b:0:b0:3a1:749:3031 with SMTP id
 38308e7fff4ca-3a1ed8e6121mr897261fa.0.1787588360914; Mon, 24 Aug 2026
 09:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810100452.426320-1-nagendra.golla@amd.com> <20260810100452.426320-3-nagendra.golla@amd.com>
In-Reply-To: <20260810100452.426320-3-nagendra.golla@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 24 Aug 2026 18:18:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKwxBp=Ajm5_iJEP0GTY5J7SJnHJGCQjfKYgmOHqE0xg@mail.gmail.com>
X-Gm-Features: AcwNN1Vm_R3byA4Vsfe3EkAk1m9zCfndN3eNtueRTEDziUufHrE5YCmoodKHCrI
Message-ID: <CAJZ5v0gKwxBp=Ajm5_iJEP0GTY5J7SJnHJGCQjfKYgmOHqE0xg@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] PM: runtime: Add pm_runtime_if_active guard and
 conditional variant
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org, 
	git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:11=E2=80=AFPM Golla Nagendra <nagendra.golla@amd=
.com> wrote:
>
> Add a pm_runtime_if_active base guard and its _try conditional variant
> to pm_runtime.h for drivers that need to conditionally acquire a runtime
> PM reference only when the device is already active.
>
> The base guard must not be used directly via guard()/scoped_guard()
> because pm_runtime_get_if_active() only acquires a reference when it
> returns 1; the destructor unconditionally calls pm_runtime_put(), which
> would underflow usage_count on a suspended or RPM-disabled device. The
> base guard exists solely to back the DEFINE_GUARD_COND _try variant.

Which is not nice and confusing IMV.

Is there anything like that anywhere else in the kernel?

> The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) checks the
> return value and only runs the destructor when the reference was
> actually acquired. This is useful in interrupt handlers where the
> device may be runtime-suspended and MMIO accesses must be avoided.
>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
> Changes in V3:
> - New patch: add PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard and backing
>   infrastructure to pm_runtime.h so that drivers
>   can use a structured guard instead of an open-coded
>   pm_runtime_get_if_active()/pm_runtime_put() pair
> ---
>  include/linux/pm_runtime.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 64921b10ac74..bc6de97e6111 100644
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
> @@ -624,6 +631,8 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
>                   pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET =3D=3D=
 0)
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>                   pm_runtime_resume_and_get(_T), _RET =3D=3D 0)
> +DEFINE_GUARD_COND(pm_runtime_if_active, _try,
> +                 pm_runtime_get_if_active(_T) ?: -EAGAIN, _RET =3D=3D 1)
>
>  /* ACQUIRE() wrapper macros for the guards defined above. */
>
> @@ -639,6 +648,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enable=
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
> --
> 2.43.7
>
