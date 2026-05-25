Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DC29BD8C
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723197; cv=none; b=ZGoSCQVEfrLFpiNq6p2tHTRdqVuo7FIHAwQN6YAzkSzdYf9EL+4bfPlD7Dtle3NZK5/8d0W/dLC/TXKg8DSmsqxAhXkYzsDt4QqWK032gpPyQsm65ZtpOKT2K8Ibhw6jq2r1SzW2V3l9rAFyiOLUFY/Rm3bKpSia/9bgUo2DS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723197; c=relaxed/simple;
	bh=f3ZSHVGzVnfGCctKVQctsBugEKiOESDM08mbo8cG47o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwF0ydfzIBLepR6EvJERFUTgA/EbmqXshj4vDGOZs17z2TVDLsFxjhv7kqBJsLnPeH/CHLVN2Rw5nN6uOHY3LrwdRJuvDrPbUbbXdcpvq5LuwwnMnI6aKzfMEqFrKC0I3h85u3OP6Or6fCiPS5i3MKOLU0CktLDKTUAcydXTY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myHTRoVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myHTRoVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35ED1F00A3C
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723195;
	bh=xoiUVG8ssRO4P22NhkwZBq9t5BH5rnkBZ9LZc7NJ0eE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=myHTRoVNQDEytVvYgGiLqO30EAutNUVajwtpg1wXoY4d6BQmL5vHogtQq505P9IDT
	 1iMYZsnXWTZXEQz22HbjaBKBaYaaHhBbcpPYw9r9oXu6W8CZq81otQfnW4T3dq4Gnl
	 r7K1VReBGgFuPP+/3/WJo0of8a+kqhl0UPYX+gMIP+IbhrMCDXNOszZEpp1Kq7eW2V
	 E2WvkacVJn0m1ISZ+NLugvJWHyaARgWsFN0XjSj4bzwWJGjQjVZqhOmm7sfhTlfEof
	 X+sWONe3A3xM1bI2xsp2jIbg5T8CIuo0tRYsj7wrwKqAgXP1GIs0hXNSh7I4HYRr6B
	 V2Au/CCFfINtQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so9936703e87.2
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 08:33:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YyECl9Qr/RFrB0Ulzp7jhBvukljVwexYdkS1MbPG9FzmwcLz6OM
	jUN3jyFM6AO6yhl7rG4ruxTUseXZjHBFpxzTpm6t/X7CfmfirNuv2DE//PvRS9ibMd6+XUROYKz
	u8/g2js5JFF2eLoSXjX+H2Iwz2ISaqiM=
X-Received: by 2002:a05:6512:2555:b0:5a8:750c:2f79 with SMTP id
 2adb3069b0e04-5aa3232c5e2mr4065159e87.3.1779723194231; Mon, 25 May 2026
 08:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525151609.2826121-2-daniel.lezcano@kernel.org> <CAJZ5v0jjn0CtQPztw8+drroOvDy8fWFCVAi22s1Um5gkDYX8rA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jjn0CtQPztw8+drroOvDy8fWFCVAi22s1Um5gkDYX8rA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 May 2026 17:33:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gk4HDeXvsEQK5v7i=-=iBnCE8=6YBXndCz4ApMTGLDTw@mail.gmail.com>
X-Gm-Features: AVHnY4KPoLXXe2ZgoHkh9vgG7iJfEy5ap9zD9XBXi9pDbAwfHZkl89xd9ycmB4U
Message-ID: <CAJZ5v0gk4HDeXvsEQK5v7i=-=iBnCE8=6YBXndCz4ApMTGLDTw@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Fix double device initialization
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:29=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, May 25, 2026 at 5:16=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@kernel.org> wrote:
> >
> > In the previous change splitting the cooling device register function,
> > the device initialization was mistakenly added in the move.
> >
> > This change is wrong because the device is registered with the
> > function device_register() which does device_initialize() and then
> > device_add(). That results in a double initialization and a message in
> > logs:
> >
> > [    1.531290] kobject: kobject (0000000053ba73b2): tried to init an in=
itialized object, something is seriously wrong.
> > [    1.531293] CPU: 9 UID: 0 PID: 420 Comm: kworker/u50:3 Not tainted 7=
.1.0-rc1+ #48 PREEMPT(lazy)
> > [    1.531294] Hardware name: LENOVO 21N10007UK/21N10007UK, BIOS N42ET3=
8W (1.12 ) 05/29/2024
> > [    1.531295] Workqueue: events_unbound deferred_probe_work_func
> > [    1.531298] Call trace:
> > [    1.531298]  show_stack+0x24/0x50 (C)
> > [    1.531301]  dump_stack_lvl+0x80/0xc0
> > [    1.531303]  kobject_init+0xc0/0xd8
> > [    1.531305]  device_initialize+0x3c/0x140
> > [    1.531308]  device_register+0x20/0x48
> > [    1.531310]  thermal_cooling_device_add+0xe0/0x208
> > [    1.531311]  thermal_of_cooling_device_register+0x54/0xa0
> > [    1.531313]  __cpufreq_cooling_register+0x1e0/0x368
> > [    1.531315]  of_cpufreq_cooling_register+0x64/0xe0
> > [    1.531316]  cpufreq_online+0xa6c/0xef0
> > [    1.531317]  cpufreq_add_dev+0x108/0x180
> > [    1.531318]  subsys_interface_register+0x138/0x168
> > [    1.531320]  cpufreq_register_driver+0x1b8/0x390
> >
> > Fix by just removing the added line.
> >
> > Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_regi=
ster() into two functions")
>
> In this commit, the device_register() has been replaced with
> device_add(), so the problem above should not trigger.
>
> Which kernel have you tested?

Moreover, note that removing device_initialize() would break the
cleanup path which relies on the device's kobject to be initialized
AFAICS.

> > Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> > ---
> >  drivers/thermal/thermal_core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 9b9fa51067bd..3cf305ceaf41 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1012,7 +1012,6 @@ static int thermal_cooling_device_add(struct ther=
mal_cooling_device *cdev, void
> >         cdev->updated =3D false;
> >         cdev->device.class =3D thermal_class;
> >         cdev->device.release =3D thermal_cdev_release;
> > -       device_initialize(&cdev->device);
> >         cdev->devdata =3D devdata;
> >
> >         ret =3D dev_set_name(&cdev->device, "cooling_device%d", cdev->i=
d);
> > --
