Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFC3DBD6F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793422; cv=none; b=oHh6yn9XleqCDCjiB5Lk0jjDliUc4WNnZbgacwIlf3ySQ2ep7rY1rx0oisomAoLFl9c3Q/JWpMrUonJDIF725QwuuXfGjjz3Giswex6Czm6S4c2x6YZa1ZU/S459OsSqVpTRQBJam3dKSCMluGz4Zupgw91CJbFn6yG6zgxU1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793422; c=relaxed/simple;
	bh=3qQWWSjHm+6tSeRK2ZfNaVQKjvsxAs9kOILID8cxBFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emGaxzK2h9RU8pcR86WWILfoem9LdDC7HJzwN7Q7KfEpIzPhoFmM4LTM1RcMXQ1fbt4H5on/rPBl8TxABcOazslYpGXOIEh9PuSqpyVXdy9KUYVbgtXfT8N+tNMesN1nGv6ecMsqFdmZeMdRPywVBKJytjpvkCpRTFq4tEXMFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGb05wmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGb05wmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF26D1F00A3A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779793419;
	bh=yorxY6Oyrg096lrnTQEnLkW7wpn3SkcvrJpahV5hpP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aGb05wmLjn1HCel8hxCnpTLEUyZCzVeJqDdsCDzKMeJURUUDeUcUodmwh2G3BQN7U
	 Ejtr5w+YrIJYWygeTSlhHCo2XDYyHKkpTMevtr7MxvOCClex7BIAiZfML5R9OW/0dZ
	 utkqMJtp7HJpefMk9leYSTQ8GWx5v8SIhRi98Z4yNTGEvI3wrUkYgOIzUYag/rDwXI
	 oOB5Q4/pug3Gl6l0IeaHQf89OqlJ/tqXf5kSi/FpLtxzJdSm+Wj8ye15QObwyRHFv9
	 Q4CoDtvyByEXTgayVgaNF2LnmrYula/WOGais8LMkv/5axku7ZWUTIrSpo/IEdxJtS
	 7znibM1a0t6tA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8721851e2so11649224e87.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:03:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9JbTjJtkhSp9zAVePPOblNKo4lwr69R26/gq2aUu3XqKIS4K7yWrnoF5CAgWaCWCrCqWFwqLZeJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhejmMMkXCLTp756V8sPfez20FpbfGvzDuN8k6GeBrWzIpucW
	lhuE2cI/AIThxFwbf6JXd1BZ+/GiQ1i6pxujaQoeqKBI/Zmz5iTsBfCDIHsV4VfTVfaWlc0+oYy
	1EFXw83XdRxRH64ujeZSxBahMpn5Svhk=
X-Received: by 2002:ac2:4541:0:b0:5a2:c1b5:f70d with SMTP id
 2adb3069b0e04-5aa3231bb51mr3357080e87.6.1779793418087; Tue, 26 May 2026
 04:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523022314.2657232-1-xujiakai24@mails.ucas.ac.cn>
In-Reply-To: <20260523022314.2657232-1-xujiakai24@mails.ucas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:03:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjHPWj26KP4WoznL9VTyDMZqOOzEsNbPtKso16p7-Lfg@mail.gmail.com>
X-Gm-Features: AVHnY4KfN8N7_d1CekAJsFvTACV8CSDf3lRQwgvYcEcEJ9kZ61V1WOYEzFq5wPw
Message-ID: <CAJZ5v0gjHPWj26KP4WoznL9VTyDMZqOOzEsNbPtKso16p7-Lfg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: Use complete() in device_pm_sleep_init()
 and skip no_pm devices in dpm_wait()
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Colin Cross <ccross@android.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 4:23=E2=80=AFAM Jiakai Xu <xujiakai24@mails.ucas.ac=
.cn> wrote:
>
> Replace complete_all() with complete() in device_pm_sleep_init() to allow
> it to be called in atomic contexts without triggering a false-positive
> WARNING from lockdep_assert_RT_in_threaded_ctx() when
> CONFIG_PROVE_RAW_LOCK_NESTING is enabled.
>
> device_pm_sleep_init() may be called during device initialization while
> holding a raw_spinlock (e.g., from within device_initialize()), and
> complete_all() is unsafe in atomic contexts on PREEMPT_RT kernels.
> complete(), which is safe to call from any context, is sufficient here.
>
> complete_all() sets the completion count to UINT_MAX/2 (permanently
> signaled), while complete() increments it by 1. Since no threads can be
> waiting during device initialization, both are functionally equivalent.
> The completion is always reinitialized via reinit_completion() in
> dpm_clear_async_state() before each suspend/resume cycle.
>
> However, changing to complete() introduces a potential deadlock for
> devices with no PM support (dev->power.no_pm =3D true). Such devices are
> never added to the dpm_list and never go through dpm_clear_async_state(),
> so their completion is never reinitialized. A parent device waiting on a
> no_pm child across multiple suspend phases would consume the single-use
> token in the first phase and block forever in the second.
>
> Fix this by adding an early return in dpm_wait() when dev->power.no_pm is
> set, since no_pm devices do not participate in system suspend/resume.
>
> Fixes: 152e1d592071 ("PM: Prevent waiting forever on asynchronous resume =
after failing suspend")
> Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
> ---
> V1 -> V2:
> - Updated dpm_wait() to skip devices with no PM support,
>   as suggested by Rafael J. Wysocki.
>
> V2 -> V3:
> - Revised commit message to clarify that the lockdep warning originates
>   from device_pm_sleep_init() called in atomic context, not from
>   device_pm_remove().  No code changes relative to v2.
> ---
>  drivers/base/power/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e1b550664bab..ed48c292f575 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -115,7 +115,7 @@ void device_pm_sleep_init(struct device *dev)
>         dev->power.is_noirq_suspended =3D false;
>         dev->power.is_late_suspended =3D false;
>         init_completion(&dev->power.completion);
> -       complete_all(&dev->power.completion);
> +       complete(&dev->power.completion);
>         dev->power.wakeup =3D NULL;
>         INIT_LIST_HEAD(&dev->power.entry);
>  }
> @@ -252,6 +252,10 @@ static void dpm_wait(struct device *dev, bool async)
>         if (!dev)
>                 return;
>
> +       /* Devices with no PM support don't use the completion. */
> +       if (dev->power.no_pm)
> +               return;
> +
>         if (async || (pm_async_enabled && dev->power.async_suspend))
>                 wait_for_completion(&dev->power.completion);
>  }
> --

Applied as 7.2 material, thanks!
