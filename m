Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A547ECCC
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469994; cv=none; b=XvSSy0WLIeuWZGQdjMQlLG9BOacmNlg/fR80xR6WUVrCZ3fiCWNC49j5in4ozVRj/jGIOrGmZ7p/1aVFviMYRofKaepNFi1NjoREADls1e6WvUlcrgBntDiTcpOKaQkOmzMIsGJ1erWU1KBHRaXKOYyYWi3soJNAQNR8bnUtbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469994; c=relaxed/simple;
	bh=FBtqtZ+OGsSDUCF8aQUZiCNmfunonDazZz9nCM0fy/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9ix8e5d+Lvc0aZO78+MiuMIQmvHPBh9RGfLL64jHF8cnfymR6twAhqSjoa+OvrliN3gu5k2Qo4keNf1xYzO/joigBhogMzgCnUiXTK1+IWEwCgGlVs/3+mV49dSqkiTPTQ5VU4q+0b5jl4As4Z0z7ssQ/N3lLdvPNPNkFLi/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bODrURXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bODrURXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37EA1F00A3D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469991;
	bh=wceNQshwbv7PscY+f3GGNuUzltqVf1da6LsI6J0w/g8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bODrURXKCG4zH4R72eN1IrCzrsuF+b1ASgd8r4ZGyDd7374EOtrEjm+e58XyKGwp2
	 sh8Nx9IOxBRa1Zqv2rlbw8Re/b1/MOelsgVq0UpYbYqOPtEnO1JmuHnr5e2lbh+dIJ
	 5HO2vfYZNOuS6NBxmivj9HDKX7M09ucrwtdlpllTVKsqhBmFJtcaVRta/ku0uavZYd
	 mC96zUhLJOTjm4BtbM2uGIk/HM71NIZsusKzeWs46QE1dMU7dx9Wk4tDSA4v/iYoSQ
	 feDcNzAzZEWeSfiJzfxPr7J4UOpOYEKKUUOIj+WYOKngPz9+2TsPbtx9JYwFUqasHg
	 4rL6xXVedVeFw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2807291e87.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 10:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ENxRXhyaPi+L/8XtK0TbElr5U+Ets92PeTSl4oXal85VvGUYCh225Oy4uEcFLEiVmJW5uuOT4xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvJGeQqrSr1PuMZOIEF0A59S0Nz/PdcFBweW3RP5fuAUcI5Pi
	ra2FjKYqd9fA3fGsVgEIb+z7sea3YdPm9jLaWYawvOmG5IGeIYoLB0n+VHKExnfdku2Fr3RyVhf
	q6TDGKqiW5FhjoYnZ91apXtPVntpYjuw=
X-Received: by 2002:a05:6512:3404:b0:5a8:99fe:59eb with SMTP id
 2adb3069b0e04-5aa323bffbemr1330433e87.41.1779469990138; Fri, 22 May 2026
 10:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513021509.483108-1-xujiakai24@mails.ucas.ac.cn>
In-Reply-To: <20260513021509.483108-1-xujiakai24@mails.ucas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 19:12:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9fFR7Et-p76jm8C-PGjQ3b+CZFqi_Ch2ixZDB0dEFtQ@mail.gmail.com>
X-Gm-Features: AVHnY4I2XRSOBWgmbe9zX8Zq9xNPjVtj6P29UymhpxdLD0GjG90XuWteBkU7W34
Message-ID: <CAJZ5v0j9fFR7Et-p76jm8C-PGjQ3b+CZFqi_Ch2ixZDB0dEFtQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: Use complete() in device_pm_sleep_init()
 and skip no_pm devices in dpm_wait()
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Colin Cross <ccross@android.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 4:15=E2=80=AFAM Jiakai Xu <xujiakai24@mails.ucas.ac=
.cn> wrote:
>
> Replace complete_all() with complete() in device_pm_sleep_init() to avoid
> a false-positive WARNING from lockdep_assert_RT_in_threaded_ctx() when
> CONFIG_PROVE_RAW_LOCK_NESTING is enabled. The WARNING triggers because
> complete_all() may be called in atomic context (e.g., from
> device_pm_remove() during network namespace cleanup which holds a
> raw_spinlock).
>
> complete_all() sets the completion count to UINT_MAX/2 (permanently
> signaled), while complete() sets it to 1. Since no threads can be waiting
> during device initialization, both are equivalent at that point. The
> completion is always reinitialized via reinit_completion() in
> dpm_clear_async_state() before each suspend/resume phase.
>
> However, changing to complete() introduces a potential deadlock for
> devices with no PM support (dev->power.no_pm =3D true). Such devices are
> never added to the dpm_list and do not go through dpm_clear_async_state()=
,
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

Please see the sashiko.dev feedback on this:

https://sashiko.dev/#/patchset/20260513021509.483108-1-xujiakai24%40mails.u=
cas.ac.cn

AFAICS, it has a point in the first comment (not so much in the second one)=
.

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
> 2.34.1
>
