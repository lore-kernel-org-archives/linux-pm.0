Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A042D7812
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488088; cv=none; b=lHIWL5DE/RTD/OrgQlGX52owFUkd9uGci9cbgTVEkXT9WEIi9udot/SLQVx2KS/DtmjE07gCdoOkTPEbnjBdDuzX07V89HwEkrc7tyAV2fuQ3U3Y62sTgrFPlF9DN1+nzKzZ7uNYJNOoK3BUahtkyaM3soW8oFsHV5CQjbq5gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488088; c=relaxed/simple;
	bh=CD+jESrnzHkoZXekioftTJlstAf6jY+GMe33WQr+cD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNmvJHKiIRZ4I1pcNPzAKZKEqkQy9wX4RWppoM7reTxCHqDON3TjiEsh/Z6Ol9ZQyVx1yom/IOnK+Iv9O99N5e+n/3pMJhzHZaslr1PMpPIPCbAAaGlx58PI5GyCcUff+MRadzd8ulizq2cT8jjN7+g62xaKDFNso1KBcqFgvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs0olNLN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs0olNLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB324C2BCB3
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775488087;
	bh=CD+jESrnzHkoZXekioftTJlstAf6jY+GMe33WQr+cD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cs0olNLNx84M1UkuglnCRf+hNlQPI58MmoDXL9aljs8FzRkYlYxEfkfVf4osSuVOG
	 joANF4CaBU+E9PvYF+C5tPthIS7CoMAUfcnJWulHHNtEDLwLko+JJAQfdbPWRtnMD4
	 rETGlYKQvO2Km2baphKIabBOZ/vNh6s5hoCJM/D2l8X5P8waNbWWt22kZYqoy/wRR4
	 sYmbRPgtb4KYdOP1NdGuEnh04PhF5qmePYI6FILhNyFa0+lCtQ077YfOigjmg8JQoZ
	 B5SRgTFNKAaZrNBggoYf93RYfOgym2n47/GWBffQ8fV5ShulS0WnZ5vQr5grrRF7wR
	 qGTeWUXREbwXg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4670676ba03so1319363b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 08:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTfXtj9e3bGqWULjb1X4VikRqljaU+WtzX/34nDOHyvfIMD4321NM8cRLTRzza3jeQybHmucKZKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52EcNpbFhfdzneOx7REF1vqKrJcbpRJkRS75PQscSekFKfqsk
	01qMiAcFXJhTXpOvPFdaDp4bDpHSgf8UJC/38md2yGnd9REw7dB8tX5KYi51X0gPHMzFYvx1kpU
	PUFg004lUk81f+iEXn/EuHxVNwuu7GVM=
X-Received: by 2002:a05:6808:c238:b0:467:1462:a9b2 with SMTP id
 5614622812f47-46ef7e17ab6mr6954241b6e.43.1775488086951; Mon, 06 Apr 2026
 08:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
In-Reply-To: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 17:07:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
X-Gm-Features: AQROBzAv10DkRk52tWM9zkIAZbjmfMH9FwlztdkQQi-OxcQXJzJYqtM97_cM7SY
Message-ID: <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 6:08=E2=80=AFAM Maulik Shah <maulik.shah@oss.qualcom=
m.com> wrote:
>
> CPU can get IPI interrupt from another CPU while it is executing
> cpuidle_select() or about to execute same. The selection do not account
> for pending interrupts and may continue to enter selected idle state only
> to exit immediately.
>
> Example trace collected when there is cross CPU IPI.
>
>  [000] 154.892148: sched_waking: comm=3Dsugov:4 pid=3D491 prio=3D-1 targe=
t_cpu=3D007
>  [000] 154.892148: ipi_raise: target_mask=3D00000000,00000080 (Function c=
all interrupts)
>  [007] 154.892162: cpu_idle: state=3D2 cpu_id=3D7
>  [007] 154.892208: cpu_idle: state=3D4294967295 cpu_id=3D7
>  [007] 154.892211: irq_handler_entry: irq=3D2 name=3DIPI
>  [007] 154.892211: ipi_entry: (Function call interrupts)
>  [007] 154.892213: sched_wakeup: comm=3Dsugov:4 pid=3D491 prio=3D-1 targe=
t_cpu=3D007
>  [007] 154.892214: ipi_exit: (Function call interrupts)
>
> This impacts performance and the above count increments.
>
> commit ccde6525183c ("smp: Introduce a helper function to check for pendi=
ng
> IPIs") already introduced a helper function to check the pending IPIs and
> it is used in pmdomain governor to deny the cluster level idle state when
> there is a pending IPI on any of cluster CPUs.
>
> This however does not stop CPU to enter CPU level idle state. Make use of
> same at CPUidle to deny the idle entry when there is already IPI pending.
>
> With change observing glmark2 [1] off screen scores improving in the rang=
e
> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having tw=
o
> clusters each with 4 CPUs.
>
> [1] https://github.com/glmark2/glmark2
>
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fix cpumask argument of cpus_peek_for_pending_ipi() to take single cpu
> - Link to v1: https://lore.kernel.org/r/20260316-cpuidle_ipi-v1-1-d0ff635=
0f4e2@oss.qualcomm.com
> ---
>  drivers/cpuidle/cpuidle.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c01e57df64ca5af8c28da3d97=
1500b3f38306cdf 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>         bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TIMER_ST=
OP);
>         ktime_t time_start, time_end;
>
> +       if (cpus_peek_for_pending_ipi(cpumask_of(dev->cpu)))
> +               return -EBUSY;
> +

Why do you want to check it here and not in cpuidle_idle_call(), for exampl=
e?

In principle, this check may be useful in the default idle path too.

>         instrumentation_begin();
>
>         /*
>
> ---
