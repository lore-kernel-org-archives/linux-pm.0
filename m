From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 20:08:24 +0530
Message-ID: <CAKohponZEBquNW21wEraJ0RqsTb3=XChOgN0S6vpYpuPQ0L-4A@mail.gmail.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
	<7573578.UE8ufgjWuX@vostro.rjw.lan>
	<CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
	<002f01d0186b$2700b730$75022590$%brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:61162 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbaLOOiY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 09:38:24 -0500
Received: by mail-oi0-f42.google.com with SMTP id v63so8097734oia.15
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 06:38:24 -0800 (PST)
In-Reply-To: <002f01d0186b$2700b730$75022590$%brar@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yadwinder Singh Brar <yadi.brar@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On 15 December 2014 at 18:58, Yadwinder Singh Brar
<yadi.brar@samsung.com> wrote:
> Unfortunately, I didn=E2=80=99t get any such warning though I tested
> patch enabling CONFIG_PROVE_LOCKING before posting. It seems

Even I couldn't reproduce it :)

> Anyways, after analyzing log and code,I think problem is not
> in cpufreq_thermal_notifier which was modified in patch as
> stated above. Actual problem is in __cpufreq_cooling_register
> which is unnecessarily calling cpufreq_register_notifier()
> inside section protected by cooling_cpufreq_lock.

Agreed, and I was looking to reproduce first before writing
some crazy code.

> Because cpufreq_policy_notifier_list).rwsem is already held
> by store_scaling_governor when __cpufreq_cooling_register is
> trying to cpufreq_policy_notifier_list while holding cooling_cpufreq_=
lock.

Correct.

> So I think following can fix the problem:
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cool=
ing.c
> index ad09e51..622ea40 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -484,15 +484,15 @@ __cpufreq_cooling_register(struct device_node *=
np,
>         cpufreq_dev->cpufreq_state =3D 0;
>         mutex_lock(&cooling_cpufreq_lock);
>
> -       /* Register the notifier for first cpufreq cooling device */
> -       if (cpufreq_dev_count =3D=3D 0)
> -               cpufreq_register_notifier(&thermal_cpufreq_notifier_b=
lock,
> -                                         CPUFREQ_POLICY_NOTIFIER);
>         cpufreq_dev_count++;
>         list_add(&cpufreq_dev->node, &cpufreq_dev_list);
>
>         mutex_unlock(&cooling_cpufreq_lock);
>
> +       /* Register the notifier for first cpufreq cooling device */
> +       if (cpufreq_dev_count =3D=3D 0)

This will always fail :), over that we need to access cpufreq_dev_count
from within the lock.

> +               cpufreq_register_notifier(&thermal_cpufreq_notifier_b=
lock,
> +                                         CPUFREQ_POLICY_NOTIFIER);
>         return cool_dev;
>  }
