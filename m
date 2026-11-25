Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611675;
	b=tVFcfZriquA2kcFWrMezM6Q189tiDRlSeY10dQ+VyZ0h5SHaLebokeHYbVuw61NyT5fV
	 xObYl4TLotx798m4aEcyGa8x/YjFHPMb4O+jDVxQscCx1ONj15jOu0SLzn78UQjJY0WVN
	 PF3RmX4jiyFc88szEY3vT353wDs0143WbZIGDR2UzH3v5C59uM6WwuHideWCcOSJMp2cH
	 86eHZLvzjvevT8Ay8eYcLaqTT3VeqYJtwQUVtj9WhkhQvr6of0gM4F6OQtyxj2yMXPAcu
	 M1koW10PjqaUxrRB1OxNxCxeJs00UGixS6TQEMyUAMJZtvWLOTgp1oz8rzCioayqc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611675;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s4z1Ffojaf9vgBuZCxjV4xyWv+c033IP30jHE3CryFk=;
	b=qYlBpSht13JqQKxB6pCkE89bIzwONChP1SGt0pluIovawMjSyR/1TDcIXfInZ3LG9tfI
	 SK9m5A4ef6B/6zn4MMLrsptgaiYhpperI90sSBfwaAzW1TAyufZL9+/54jLdVsQljQwm4
	 zN6j6sG0b1FDeoTCdaSS7CfQy+XlLtOyDosyouLis4l6dGVO7xXvST+XvdVw7pqd8MOaX
	 b/pNebrXALC/RhEne67u6co9L8XKmkZ4RgvMM9QGN0sZLpVcLmA118W6nfObW3KMbYqfe
	 D6E5ZM0Kmy8h8T6JAxk9/spwvsOjqbMh3yB+ew/wKg79dQ4wSLwTDRs3gn/UdubBHxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lc/+uN6s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95D606A329
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lc/+uN6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F41F000C0
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611674;
	bh=s4z1Ffojaf9vgBuZCxjV4xyWv+c033IP30jHE3CryFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lc/+uN6sdaJAztDQ6dflMRjZiXg9z0yld8QIcoO7NIFGXYyrtsgVAnPhDAC50HHPm
	 0ISsvsuzooCRBUk4hBIaYsLwIBChJge2sj1K3Ss97LIX4wA758v/rubQ4vv40F8z1r
	 lcVIcte98qO7AHB33jP6aPCzArvXYd2UnJKdcFP/u4jHwuawVkpJXx3QGYvGTymlo0
	 6cr0szoyDfCDKMHcowWRqTrQg5L6GngTQRYACbSEA9qyYGLEkehlvqbzxDfgwYqvbV
	 N7EjWE25J0pWfuAYNz97bJ29wU0PHJs6m1tR556wQRPnbjye9maXNws8Vb8yXFyATO
	 L0SAwTEdKz8rQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c1b8120565so3531265e87.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 05:01:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFT9F3SEJqinQSFyMRIR6JYgT6dkbcAiZ7phSIDcklRzvkiRqnhA+7cUwgdmKoBQZYSOisH47U9Jg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9RXet5DuSFdiJUdraC23bTdc1ckNoMienJpsvCAPPf/Sp9Qxif
	j+RsHIFitLNF3b6E9doS/s4m9gi5pLebGQpOnG/1SXmB51nhv8psAe5NdzXJOmYdMUVmSWLMxVc
	ynvclJxLntA+JuNtdYVlILye34yY3wxU=
X-Received: by 2002:a05:6512:10cd:b0:5c1:ae60:9b12 with SMTP id
 2adb3069b0e04-5c1bc89ee76mr4870782e87.60.1795611673387; Wed, 25 Nov 2026
 05:01:13 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org> <20261123-pm-runtime-summary-v3-2-81a966953a81@kernel.org>
In-Reply-To: <20261123-pm-runtime-summary-v3-2-81a966953a81@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 14:01:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJ2ytkT2-JJTONCvYx3s-kOOtxopFkdbtGzHNQWOwJgg@mail.gmail.com>
X-Gm-Features: Aa3M54rBrqs5vJZYDvCdW7zNfFxUBVdg8rbR2V3HBHj6z7GBr6vpKn8rCF1Z5qc
Message-ID: <CAJZ5v0iJ2ytkT2-JJTONCvYx3s-kOOtxopFkdbtGzHNQWOwJgg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: add debugfs entry for pm_runtime_summary
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Samuel Wu <wusamuel@google.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:07=E2=80=AFAM Joshua Crofts <crofts@kernel.org> =
wrote:
>
> Add a debugfs entry for showing the runtime statistics for devices with
> PM runtime enabled.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/base/power/runtime.c | 86 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 17aee68366cf..cf657251633e 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -14,6 +14,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_wakeirq.h>
>  #include <linux/rculist.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
>  #include <trace/events/rpm.h>
>
>  #include "../base.h"
> @@ -2223,3 +2225,87 @@ bool pm_runtime_need_not_resume(struct device *dev=
)
>  }
>
>  #endif /* CONFIG_PM_SLEEP */
> +
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_PM_SLEEP)

Why do you want to make it depend on CONFIG_PM_SLEEP?

There's nothing related to system sleep in it AFAICS.

> +static void rpm_summary_show_dev(struct device *dev, void *data)
> +{
> +       struct seq_file *s =3D data;
> +       unsigned long flags;
> +       u64 active_time, suspended_time;
> +       u64 last_sleep, min_sleep, max_sleep;
> +       u64 resumes, suspends;
> +       const char *status_str;
> +       bool enabled;
> +
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +
> +       enabled =3D pm_runtime_enabled(dev);
> +       if (!enabled && !dev->power.resume_count && !dev->power.suspend_c=
ount) {
> +               spin_unlock_irqrestore(&dev->power.lock, flags);
> +               return;
> +       }
> +
> +       update_pm_runtime_accounting(dev);
> +
> +       switch (dev->power.runtime_status) {
> +       case RPM_ACTIVE:
> +               status_str =3D "active";
> +               break;
> +       case RPM_SUSPENDED:
> +               status_str =3D "suspended";
> +               break;
> +       case RPM_SUSPENDING:
> +               status_str =3D "suspending";
> +               break;
> +       case RPM_RESUMING:
> +               status_str =3D "resuming";
> +               break;
> +       default:
> +               status_str =3D "unknown";
> +               break;
> +       }
> +
> +       active_time =3D dev->power.active_time;
> +       suspended_time =3D dev->power.suspended_time;
> +       resumes =3D dev->power.resume_count;
> +       suspends =3D dev->power.suspend_count;
> +       last_sleep =3D dev->power.last_suspended_time;
> +       min_sleep =3D dev->power.min_suspended_time;
> +       max_sleep =3D dev->power.max_suspended_time;
> +
> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       do_div(active_time, NSEC_PER_MSEC);
> +       do_div(suspended_time, NSEC_PER_MSEC);
> +       do_div(last_sleep, NSEC_PER_MSEC);
> +       do_div(min_sleep, NSEC_PER_MSEC);
> +       do_div(max_sleep, NSEC_PER_MSEC);
> +
> +       seq_printf(s, "%-32s %-12s %8llu %8llu %12llu %12llu %10llu %10ll=
u %10llu\n",
> +                  dev_name(dev), enabled ? status_str : "disabled",
> +                  resumes, suspends, active_time, suspended_time,
> +                  last_sleep, min_sleep, max_sleep);
> +}
> +
> +static int pm_runtime_summary_show(struct seq_file *s, void *unused)
> +{
> +       seq_printf(s, "%-32s %-12s %8s %8s %12s %12s %10s %10s %10s\n",
> +                  "Device", "Status", "Resumes", "Suspends",
> +                  "Active(ms)", "Suspend(ms)", "Last(ms)", "Min(ms)", "M=
ax(ms)");
> +       seq_puts(s, "----------------------------------------------------=
----------------------------------------------------------------------\n");
> +
> +       dpm_for_each_dev(s, rpm_summary_show_dev);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pm_runtime_summary);
> +
> +static int __init pm_runtime_debugfs_init(void)
> +{
> +       debugfs_create_file("pm_runtime_summary", 0444, NULL, NULL,
> +                           &pm_runtime_summary_fops);
> +
> +       return 0;
> +}
> +late_initcall(pm_runtime_debugfs_init);
> +#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_PM_SLEEP) */
>
> --
> 2.47.3
>
