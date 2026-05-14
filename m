Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF53E5A09
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766797; cv=none; b=tJixcph+5cvoDPG/Tm+VIPWZ974Dqs8shqoe3TH92zUUA8fLu/7nu57VIZdWVR+zNTkN4QM2nR7BK3QlQlEzHkeMXRBoCwnzfOz+d1H93sKo22xTfS38l2xONYScBqkF4ghYxG+WH1PvMfBK5Zv5YEaRy+UQA/7ZN7Es+bj4WUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766797; c=relaxed/simple;
	bh=av3eSpj1tW2rVplRcN9wVd0AxBK0pxj5cQR1eI0GEug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACVFEyUqVFJwfe0TbIC6VXtc+8QQdb6hfNC4CNGlYCbZmEp7hPBamYubd6t3XXLhy5VyDSeHil9850pT3gU8Y7DW12Qn6Pe1xzw4bshixwSg9jqeq+eU+BKDaWa1hhfE1XJCktrUaIwrY6tdStlbNbWElFiVWPvThzwfHd6PnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7N+1txQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7N+1txQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B14AC2BCF5
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766797;
	bh=av3eSpj1tW2rVplRcN9wVd0AxBK0pxj5cQR1eI0GEug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u7N+1txQhP35omH3QMQQoCxoDqizpNVhPhfvcgUJCe0vXuJFYnCnKuf0qc4r8MpNC
	 F4M7ZDhc4WTnFeJVzcKUdP9Wmc8gHwXORSBYy/dvuoaJ+q4PiqlC9Ag4lvvvOsXj+W
	 K4om+kHe7rzBrQ5wFZC/23cvRDk49mss3IPE0/OjLEKc1tGacaJhy3zGRS4F4icV9C
	 nJcV6Wq7cnkMVQn/cHYh40RBOWpyOu7ZkEZryXxOJRzhyosn1/6mX79wNFv6x7kkOg
	 Z9SZ2iQKkZzY+9AaGaMgJZKLIZ2XumDgfeFCpykLqVLk+hIX4ugZTN1/6r4ehN2vdD
	 KI3rB/uUnIqZA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so7243700e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:53:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9NIYHkKSV/6pkqIHGPdSmJzkgZ3GeWOMZn6z6dAzUivLf0gV4v1Z3mJaobkOnD5VjhZwBgrX5lyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPDij0olxULuiu3dLfxDhXoVJqN1XbIXkkH6HCgK6NCOndqJA
	2m+bZDMRgMTjQmkcjUzysMb/QOIlPan6JAVGZ94FaqwjOIgGMwni5vTvl2QM13BIMEckcfRHUpU
	X3w7oxlTXKPML7FqIMkCC+0tFrozVRCI=
X-Received: by 2002:a05:6512:124a:b0:5a8:73c3:f270 with SMTP id
 2adb3069b0e04-5a8f37bb270mr2442952e87.8.1778766795597; Thu, 14 May 2026
 06:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514132901.275477-1-marco.crivellari@suse.com>
In-Reply-To: <20260514132901.275477-1-marco.crivellari@suse.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 May 2026 15:53:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGyceLJfNtiS+Asi2BRVP8SPjJDxKJrDK+gi9Bov3P5w@mail.gmail.com>
X-Gm-Features: AVHnY4IqI59pmBwE8-GHHm-fR4KBUs0gZ76vZV-e9WdzKhN31p0vCcwKoRdkEXo
Message-ID: <CAJZ5v0gGyceLJfNtiS+Asi2BRVP8SPjJDxKJrDK+gi9Bov3P5w@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 3:29=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
>
> In order to keep alloc_workqueue() behavior identical, explicitly request
> WQ_PERCPU.
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2f4e2dc46b8f..691c5e749c3e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1889,7 +1889,8 @@ static int __init thermal_init(void)
>         if (result)
>                 goto error;
>
> -       thermal_wq =3D alloc_workqueue("thermal_events", WQ_POWER_EFFICIE=
NT, 0);
> +       thermal_wq =3D alloc_workqueue("thermal_events",
> +                                    WQ_POWER_EFFICIENT | WQ_PERCPU, 0);

No, we actually don't want that here.  See

26fd03effa94 thermal: core: Adjust thermal_wq allocation flags

>         if (!thermal_wq) {
>                 result =3D -ENOMEM;
>                 goto unregister_netlink;
> --
