Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5338333C
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613951; cv=none; b=Du6NGNHNfnD7qjAzI0ayDquusrDVu8Xl0kPLSO9padax2VBFMxe7vqBD//6XMPu7YHOEPdlcNrgVKuaFVdepV2r8GwCn2pO2uUjXRNzE8RWTT3mrfdHaK3UR1tyVGYoElq694thC6O79z+B2IzX27D3OD9IsVYRK2DjHfuFTrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613951; c=relaxed/simple;
	bh=erA00MWL5kTeYyzoTkdxuGpD4oQdijXGNkrzVRhZRx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSXCHyvZDdOANJyrk2vd3Kaxtwo1+nYb/YK3cL385A45Md6ts5tOAzrd6Vi+ck8hjJCwd37Eapb8vEH407UHVTXd4mKl/d7klnknZEah5S7uQHKQgkhEuQD7IB8UTR/R6yrRpqIfaOtBoN4xMT6c7mgvaESMFnI+t/zK5WjhmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ72Zh6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ72Zh6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA66C2BCF6
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613950;
	bh=erA00MWL5kTeYyzoTkdxuGpD4oQdijXGNkrzVRhZRx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lZ72Zh6X34vKCv+57JtWW9VwjHpA98GKm8dj0aLtDnE9gxVDJEKDcskzeskHkhPC2
	 r6TDArQStiFJNzsZZjjp5j1a6EPEv0Hc0OBwCab2aKk158fb3TlCKHzr1MXzggZcql
	 kTjtYzwPp9teku+4GWqElYmobWzqcjDJM8DD0H7ILPPryccJlxYhBL+kNsthu1Zdv4
	 ui6IYQ1wmci0VCb8vjG1BikOy2X3YXAMKptPruGfi24gtI/4YdnBqMouDA1BvT1l3j
	 Q80MvFogyHfGw+U9c1tDWqfNHU+ALqdODmi78vLAhDpzc2lLuudvR8kzHJ7OKjaWkU
	 25yVJeEA9aI6w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso7721079e87.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:25:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9OBioc+ZTmKIAVLgIYG+NKRptKiH1B8ujrLZUXQRrXcFzliR70TMfR3+f2/rcj0+5HY8BXZEWJ0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cA66knqn3qm1Z5wzEDhbezBclicvGZh4cIH5NlhFa1h/8v7s
	UhNkgG1PXxwAlYWBvL77/7cXPBmlDs/+3eHvQNX9PuxP6s7CodwkEW0xm6+Cqqzs+1388CAlUKm
	VNxhYMICN28olh1d5gTnFZPYcsQQi1ro=
X-Received: by 2002:a05:6512:33c5:b0:5a4:1918:20e with SMTP id
 2adb3069b0e04-5a8ef99c093mr99052e87.30.1778613949135; Tue, 12 May 2026
 12:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509092707.3426533-1-xujiakai24@mails.ucas.ac.cn>
In-Reply-To: <20260509092707.3426533-1-xujiakai24@mails.ucas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 21:25:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0MdJCS-0xeP3gZi30gYV4DMJxPceodRexksMcL=b5PA@mail.gmail.com>
X-Gm-Features: AVHnY4JNkLjqw8Tb9wOYTn34zcqwbBvDwGdKMyY3vEj2AMJHNg3AP9vYF_t60lo
Message-ID: <CAJZ5v0i0MdJCS-0xeP3gZi30gYV4DMJxPceodRexksMcL=b5PA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Use complete() instead of complete_all() in device_pm_sleep_init()
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Colin Cross <ccross@android.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 11:27=E2=80=AFAM Jiakai Xu <xujiakai24@mails.ucas.ac=
.cn> wrote:
>
> device_pm_sleep_init() is called during device initialization via
> device_initialize(), where no threads can be waiting on
> dev->power.completion. Using complete_all() here triggers a false-positiv=
e
> WARNING from lockdep_assert_RT_in_threaded_ctx() when
> CONFIG_PROVE_RAW_LOCK_NESTING is enabled, because holding a raw_spinlock
> elsewhere in the call chain makes lockdep_hardirq_context() appear non-ze=
ro.
>
> Replace complete_all() with complete(), which is semantically equivalent
> when no waiters exist (sets done to 1 instead of UINT_MAX). The completio=
n
> is always reinitialized via reinit_completion() in dpm_clear_async_state(=
)
> before each suspend/resume phase, so this initialization value has no
> effect on later suspend operations.
>
> Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
> Fixes: 152e1d592071c ("PM: Prevent waiting forever on asynchronous resume=
 after failing suspend")
> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e1b550664bab..7a948dd134df 100644
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
> --

sashiko.dev complains about this one:

https://sashiko.dev/#/patchset/20260509092707.3426533-1-xujiakai24%40mails.=
ucas.ac.cn

and I think that it has a point.

Before this change, dpm_wait() needs to be updated to skip devices
with no PM support.
