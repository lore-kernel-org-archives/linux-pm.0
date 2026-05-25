Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E33F411D
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722998; cv=none; b=Yy+SYnsloogojMgF4FXaochHSXBkvZe9veBdVu1zGPwqV2owzWS03c2pGP2mgwqBrlchnpsOoPw2bTlmKp1dTYtFk3VlNG+c58FzbCUH2OVieLwq35nIeZOF32jr1vhQsIedS9uvQPOEs9IrgX/dYDnFYiVESyuxmsOiOX1yU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722998; c=relaxed/simple;
	bh=fPkQIEmj6VrjrijBdi7xKoGlcbU2Bv3nGMs8nyWKCKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx/UMQsIDx9+vhkmmjw9YfPlWvM5fM8HkfXbr7UHpn/KckPwUXl8oxfcf3kXoP9ubbpDpYqHwX7bVaaLtWmfufL+EcoMgws6UsL2tHdcthwXEuLbx7c2/Oguxm/L5wOtPT7de+hrOBG9alArNgsJevGJikI4rLHZxfX79FQSFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jElZwGfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jElZwGfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E121F00A3C
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722997;
	bh=ZQmHtUZxZ/grpyJwLjs1LsZuBDtnoarxBRcJP8aIjUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jElZwGfKH6l79KgC9g5ISml7JaKQFiUSW3XWV7YHIBgr8/ENeyAK9m8mFYmyH3ufF
	 D/OVau5NygnCw+fp2JhlFk3o8aPDkCbaE2vgSnHxhRmUMcDw7hPo7puE2x6aZHQR4h
	 BhHCkOryEK7Jz8+ibHM1SYrayRjheUzqpz3Lq+YgKITxIdittiIGeS8QjnlTOwZlcd
	 KU67rrhZYlxb3aUnipYpHqWo0tfTzoeGbjzaWq/SYycKWViC18G5xynS6JG8Jz0tmd
	 BOQDM1x/MrrrHMxYV9lfPImHTIA6y/Ou4d5hkA/ep/AGoSejSajappIyaYiN/+sUb2
	 UTPjGFHJWY0ew==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a62f43b76aso11782854e87.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 08:29:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ZmvRVb5NID+H1BN8HvYftDigF4Ur1W4hLT8MLSXZxpVnxhRM+uYdVw/6ujdJp46Ga5/cy2i2PpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ38kKzGvffXUsgdmvOZ0ilu31r+44D7iz7sUyzUA658UkWEmT
	MzlJVAygUIVM/eWhmdSIxa+BuF8M6wFK+8Ep0+22/nL3o0qw0cTQezk5DZ2Tjyr6QCknTZ3h7fO
	0ztg6vEZdpglpi5InQxT/gI7dwh/FbDg=
X-Received: by 2002:a05:6512:3ca7:b0:5a8:f6fd:f201 with SMTP id
 2adb3069b0e04-5aa3235ec9emr4618460e87.15.1779722995621; Mon, 25 May 2026
 08:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525151609.2826121-2-daniel.lezcano@kernel.org>
In-Reply-To: <20260525151609.2826121-2-daniel.lezcano@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 May 2026 17:29:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jjn0CtQPztw8+drroOvDy8fWFCVAi22s1Um5gkDYX8rA@mail.gmail.com>
X-Gm-Features: AVHnY4JEO95ZASGH5Gn_uhAYANplSDc0awXB8eJMuLntx2f2YetPT0ygbmxFWbc
Message-ID: <CAJZ5v0jjn0CtQPztw8+drroOvDy8fWFCVAi22s1Um5gkDYX8rA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Fix double device initialization
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:16=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@kernel.org> wrote:
>
> In the previous change splitting the cooling device register function,
> the device initialization was mistakenly added in the move.
>
> This change is wrong because the device is registered with the
> function device_register() which does device_initialize() and then
> device_add(). That results in a double initialization and a message in
> logs:
>
> [    1.531290] kobject: kobject (0000000053ba73b2): tried to init an init=
ialized object, something is seriously wrong.
> [    1.531293] CPU: 9 UID: 0 PID: 420 Comm: kworker/u50:3 Not tainted 7.1=
.0-rc1+ #48 PREEMPT(lazy)
> [    1.531294] Hardware name: LENOVO 21N10007UK/21N10007UK, BIOS N42ET38W=
 (1.12 ) 05/29/2024
> [    1.531295] Workqueue: events_unbound deferred_probe_work_func
> [    1.531298] Call trace:
> [    1.531298]  show_stack+0x24/0x50 (C)
> [    1.531301]  dump_stack_lvl+0x80/0xc0
> [    1.531303]  kobject_init+0xc0/0xd8
> [    1.531305]  device_initialize+0x3c/0x140
> [    1.531308]  device_register+0x20/0x48
> [    1.531310]  thermal_cooling_device_add+0xe0/0x208
> [    1.531311]  thermal_of_cooling_device_register+0x54/0xa0
> [    1.531313]  __cpufreq_cooling_register+0x1e0/0x368
> [    1.531315]  of_cpufreq_cooling_register+0x64/0xe0
> [    1.531316]  cpufreq_online+0xa6c/0xef0
> [    1.531317]  cpufreq_add_dev+0x108/0x180
> [    1.531318]  subsys_interface_register+0x138/0x168
> [    1.531320]  cpufreq_register_driver+0x1b8/0x390
>
> Fix by just removing the added line.
>
> Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_regist=
er() into two functions")

In this commit, the device_register() has been replaced with
device_add(), so the problem above should not trigger.

Which kernel have you tested?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> ---
>  drivers/thermal/thermal_core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9b9fa51067bd..3cf305ceaf41 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1012,7 +1012,6 @@ static int thermal_cooling_device_add(struct therma=
l_cooling_device *cdev, void
>         cdev->updated =3D false;
>         cdev->device.class =3D thermal_class;
>         cdev->device.release =3D thermal_cdev_release;
> -       device_initialize(&cdev->device);
>         cdev->devdata =3D devdata;
>
>         ret =3D dev_set_name(&cdev->device, "cooling_device%d", cdev->id)=
;
> --
