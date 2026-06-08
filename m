Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9F3D4135
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928578; cv=none; b=mDnG3BPekf6XGHX+Ec7A7cxVpVsGub8giIvBDK3z7g5VQ4vrMUP5u0/duIF0tshr/4+MMB2EHU3xpKO5lVk9PdMbkkt0wdVyF7DlOHH4cL5iSM+BY+poX6N4DUW0NMB3mKGXkwbyd++hpoxKbHfpYgnfTjEE9594VKm4npQpCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928578; c=relaxed/simple;
	bh=VuB9xCUPG5CPdshkBpreNadVER9e5F8P16Kq7nsXLLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0gv7JbIS5ZnWc1r2A/CDsn6okfZCbTrYj8Yzhq198BJ3Qyhhl/9D89znSFSv5kvCtR0gC7xQbbDHKmapq9ZhxBd02NhmH7WC2Xo30acAzX8JU3HIvTbnrc0eisYTahGU2QD4hlzRbTfgHm8gozJpUy9LZygMxjp20S9h3b47fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiAoJxMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiAoJxMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF741F00A02
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928576;
	bh=H+mBsB5jor7WTQVPkKZI+SdiyFIv/mhsg/57Abzj2VU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hiAoJxMYV7sPhK9RrLF3qNIQDo2wu8lwwWLX2mRmh4fzd9njzCvF5WXMnZXbTydwA
	 Sgrn+e+aCfIWwsCwALwj2Oq5Bk9+rU4W35mvI41pAyezquKdRsjsWpVTlf8TAVBpEE
	 NZqm2ELIO+D1gbqKjllDusFN1aIjAMGcC3EJ+pg10x9rtplSqirGiJ0FkC1xdY3PmY
	 qUGdZ0a5V0/5DJpkQ/Kaxt74l5iTb/8jdVmeiDIy6WgvEZzK3vAZh1OBUITdrYPKo9
	 QjHOUHwy1CIIhGGtIY+xYQzEp396Dg4nUBF/BIdjKYga/nPEniy4XIxA1lGqbhx0/I
	 +UlH0hLsEx9Rg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68e66128so4451285e87.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 07:22:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ95LAYi1qCUCL4a9HUBsrLS//y8iWdmYNf6bEy3U5YgEeOFeaKNEb3+N5bu7S26WbqgNOwa7WV3jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQy52vgXDyX0aHYCIf7w/Hx5Rn1coG8xJdkkm7InMTaC58qAw
	WCsPkYkHk0JxZfYIuSzxunbLJsK3E4QLRmRrBoq84T1ZcyKP3ZInhBFpsH++Hw2CY1oMaVIF/rT
	oauwzLHQTjIy8lpkdoYb4uMYOmGwNgX8=
X-Received: by 2002:a05:6512:140d:b0:5aa:7779:803b with SMTP id
 2adb3069b0e04-5aa87b8a6b6mr4500005e87.5.1780928574579; Mon, 08 Jun 2026
 07:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608021526.1023248-1-tzungbi@kernel.org> <20260608021526.1023248-4-tzungbi@kernel.org>
In-Reply-To: <20260608021526.1023248-4-tzungbi@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 16:22:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=Uey90jN-TiUkx+FEPKtNUWhDGrfhxke65Em_ycbc+w@mail.gmail.com>
X-Gm-Features: AVVi8CekT83yVQauQvXIw2JTKFETj3NWRq4IFI_tZjKdEJQmv1ylGzWwl8d1-MA
Message-ID: <CAJZ5v0j=Uey90jN-TiUkx+FEPKtNUWhDGrfhxke65Em_ycbc+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PM: dpm_watchdog: Add sysctl interface for DPM
 watchdog timeouts
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, tfiga@chromium.org, 
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 4:16=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> Introduce sysctl knobs to allow configuring DPM watchdog timeouts at
> runtime.
>
> Currently, these timeouts are fixed at compile time via
> CONFIG_DPM_WATCHDOG_TIMEOUT and CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT.
> This limits flexibility if the timeouts need to be adjusted for
> different testing scenarios or hardware behaviors without rebuilding
> the kernel.
>
> Add the following sysctl files under /proc/sys/kernel/:
> - dpm_watchdog_timeout_secs: The total timeout before panic. The
>   maximum value is capped at CONFIG_DPM_WATCHDOG_TIMEOUT to prevent
>   unreasonably large timeouts.
> - dpm_watchdog_warning_timeout_secs: The warning timeout. The maximum
>   value is capped at the current dpm_watchdog_timeout_secs.
> Both sysctls have a minimum value of 1.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> v3:
> - No changes.
>
> v2: https://lore.kernel.org/all/20260604090756.2884671-4-tzungbi@kernel.o=
rg
> - New to the series.
>
> v1: Doesn't exist.
>
>  drivers/base/power/main.c | 61 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 7822c29b7c8d..c1a4b30fafb2 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -28,6 +28,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sysctl.h>
>  #include <linux/async.h>
>  #include <linux/suspend.h>
>  #include <trace/events/power.h>
> @@ -539,6 +540,58 @@ static bool __read_mostly dpm_watchdog_enabled =3D
>  module_param(dpm_watchdog_enabled, bool, 0644);
>  MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
>
> +static unsigned int __read_mostly dpm_watchdog_timeout =3D CONFIG_DPM_WA=
TCHDOG_TIMEOUT;
> +static unsigned int __read_mostly dpm_watchdog_warning_timeout =3D
> +                                               CONFIG_DPM_WATCHDOG_WARNI=
NG_TIMEOUT;
> +static const unsigned int dpm_watchdog_timeout_max =3D CONFIG_DPM_WATCHD=
OG_TIMEOUT;
> +
> +static int proc_dodpm_watchdog_timeout_secs(const struct ctl_table *tabl=
e,
> +                                           int write, void *buffer,
> +                                           size_t *lenp, loff_t *ppos)
> +{
> +       struct ctl_table ctl =3D *table;
> +       unsigned int val =3D dpm_watchdog_timeout;
> +       int ret;
> +
> +       ctl.data =3D &val;
> +       ret =3D proc_douintvec_minmax(&ctl, write, buffer, lenp, ppos);
> +       if (ret || !write)
> +               return ret;
> +
> +       if (val < dpm_watchdog_warning_timeout)
> +               dpm_watchdog_warning_timeout =3D val;
> +       dpm_watchdog_timeout =3D val;
> +
> +       return 0;
> +}
> +
> +static const struct ctl_table dpm_watchdog_sysctls[] =3D {
> +       {
> +               .procname       =3D "dpm_watchdog_timeout_secs",
> +               .maxlen         =3D sizeof(unsigned int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dodpm_watchdog_timeout_secs,
> +               .extra1         =3D SYSCTL_ONE,
> +               .extra2         =3D (void *)&dpm_watchdog_timeout_max,
> +       },
> +       {
> +               .procname       =3D "dpm_watchdog_warning_timeout_secs",
> +               .data           =3D &dpm_watchdog_warning_timeout,
> +               .maxlen         =3D sizeof(unsigned int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_douintvec_minmax,
> +               .extra1         =3D SYSCTL_ONE,
> +               .extra2         =3D (void *)&dpm_watchdog_timeout,
> +       },
> +};
> +
> +static int __init dpm_watchdog_sysctl_init(void)
> +{
> +       register_sysctl_init("kernel", dpm_watchdog_sysctls);
> +       return 0;
> +}
> +subsys_initcall(dpm_watchdog_sysctl_init);
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -564,9 +617,9 @@ static void dpm_watchdog_handler(struct timer_list *t=
)
>                         dev_driver_string(wd->dev), dev_name(wd->dev));
>         }
>
> -       time_left =3D CONFIG_DPM_WATCHDOG_TIMEOUT - CONFIG_DPM_WATCHDOG_W=
ARNING_TIMEOUT;
> +       time_left =3D dpm_watchdog_timeout - dpm_watchdog_warning_timeout=
;
>         dev_warn(wd->dev, "**** DPM device timeout after %u seconds; %u s=
econds until panic ****\n",
> -                CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT, time_left);
> +                dpm_watchdog_warning_timeout, time_left);
>         show_stack(wd->tsk, NULL, KERN_WARNING);
>
>         wd->fatal =3D true;
> @@ -587,11 +640,11 @@ static void dpm_watchdog_set(struct dpm_watchdog *w=
d, struct device *dev)
>
>         wd->dev =3D dev;
>         wd->tsk =3D current;
> -       wd->fatal =3D CONFIG_DPM_WATCHDOG_TIMEOUT =3D=3D CONFIG_DPM_WATCH=
DOG_WARNING_TIMEOUT;
> +       wd->fatal =3D dpm_watchdog_timeout =3D=3D dpm_watchdog_warning_ti=
meout;
>
>         timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
>         /* use same timeout value for both suspend and resume */
> -       timer->expires =3D jiffies + HZ * CONFIG_DPM_WATCHDOG_WARNING_TIM=
EOUT;
> +       timer->expires =3D jiffies + HZ * dpm_watchdog_warning_timeout;
>         add_timer(timer);
>  }
>
> --

I think that this can be applied without the other two patches in the
series, so please let me know if you want me to apply it separately.

Thanks!
