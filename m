Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738C3B3895
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242143; cv=none; b=YFHIIHwbhu9O45IVBk6b/yKNcUFJA+y9ydI8yyl3obNce5KCPMvR2Mp2JEOej/w3ZNOHT8YOQRL7l0RSAdVZvYIYlOuexJjyNquQblxc6sxPSY+Zjx1qkZR9UEHDafWexRlxvOu5gKgqKG3ttdsYihjluTYYz5roeXfOTRcHbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242143; c=relaxed/simple;
	bh=RWsbmWVNoYgzzQVhhTmrzHuMEP3lfjt0jYpXh4yj8Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h17nbRr2D5lowg5fM3mAssC8OlExL9vTZLul/lfikAtBMAmwo280xBP99WQq95Rbd74IPO46ElmnNN+HIVIwpmBA1jMiOH+oL5Mu9BzBALr6kQ1LxYJ5uFvsFWIZFEle+xN1o9Uslkgx2HqLTHOfEJHuJBbCWtn8azzkgyvK+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRe62hes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRe62hes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14703C2BCB8
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778242143;
	bh=RWsbmWVNoYgzzQVhhTmrzHuMEP3lfjt0jYpXh4yj8Ok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DRe62hesLxEuHkIUGF8Vkntxhn2lhsAvTfCGFJ8MJl8YKkYFFryU3ZOmTNfDQGS8L
	 kMjTPVhOLxwiXHDq6wmPP38m2+bSFyHpleon52Q6vcMfgwmXcCKIpHef1slg7gdmY0
	 ByL67RSQYPZET6YEjH4bXmJLswcK/MXpvgH1gSKzRl6ry1DwOA8mInzlATDGQdViSd
	 EE5L5iS5uO1TlqQ6wB+X7dLguGNt/RqTA+sOAGT6cs+abmNOcF8SyMJXpcfDWu2fOe
	 oZSVOaKeino//BdUjdpSUwd/4UUP08dw7MemHBHMoM4BdCu8PbZC6H7mbFWsOjCf8q
	 JqJSUfJTRVnQw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso2789820e87.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:09:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/FSm3Euwdx9C359cvkiH+t59kKNY2Gw+3Bpx10n+pwfEp3OgW13OgFoGgWHxoQzBb5rds21mFVEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8yZAajqNhJErmnzLaCnY7ppBTMmliD9YQEFAJ3DMKQkA0HeE
	5yWojuZzFlHbFkyjWByrNx+a+2z/L+/YKgwa6ZzREQ6QRQwuEAPbyKdYmhZdWEUWz4SDTz7rLzm
	6hXX7OpTM22GCJzgO10ue9Zr2wrNeYPg=
X-Received: by 2002:a05:6512:3d17:b0:5a8:638f:7fe2 with SMTP id
 2adb3069b0e04-5a887add823mr4139649e87.2.1778242141478; Fri, 08 May 2026
 05:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
 <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com> <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
 <70f2b2b4-6066-4c48-8834-b907b5146a08@arm.com> <b120e546-2a41-4efd-b0c6-8a63eb5bbd93@oss.qualcomm.com>
In-Reply-To: <b120e546-2a41-4efd-b0c6-8a63eb5bbd93@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 14:08:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0je8SEjpWALrMcF8pFSZtb8uu9x9VMqvqwys0_Cv01Kaw@mail.gmail.com>
X-Gm-Features: AVHnY4Jh9FInmkbnABJ9YblJAHmE8bnZ1G1HyHKw_sU0WcytLwLORVFiJm2PrJI
Message-ID: <CAJZ5v0je8SEjpWALrMcF8pFSZtb8uu9x9VMqvqwys0_Cv01Kaw@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:25=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 5/8/26 12:35, Lukasz Luba wrote:
> >
> >
> > On 5/7/26 19:26, Daniel Lezcano wrote:
> >> On 5/7/26 12:02, Lukasz Luba wrote:
>
> [ ... ]
>
> > I would call them explicitly in case of 'if(ret)'
> > error from dev_set_name()...
> > Then the rest could end in case of error with that new
> > 'put_device()' logic at the bottom.
> > Would you agree?
> >
> > A different option would be to refactor thermal_release()
> > and somehow recognize the cooling device not based on name.
>
> This mechanism is not adequate.
>
> thermal_release should not be used this way, neither it should be needed.
>
> We should have:
>
>         thermal_class =3D class_create("thermal");
>         if (IS_ERR(thermal_class))
>                 ...
>
> No thermal_release needed.
>
>
> But,
>
> static void cooling_dev_release(struct device *dev)
> {
>         thermal_cooling_device *cdev;
>
>         cdev =3D to_cooling_device(dev);
>         thermal_cooling_device_destroy_sysfs(cdev);
>         kfree_const(cdev->type);
>         ida_free(&thermal_cdev_ida, cdev->id);
>         kfree(cdev);
> }
>
> static void tz_dev_release(struct device *dev)
> {
>         thermal_zone_device *tz;
>
>         tz =3D to_thermal_zone(dev);
>         thermal_zone_destroy_device_groups(tz);
>         thermal_set_governor(tz, NULL);
>         ida_destroy(&tz->ida);
>         mutex_destroy(&tz->lock);
>         complete(&tz->removal);
> }
>
> In thermal_cooling_device_add()
> {
>         ...
>         cdev->device.release =3D cooling_dev_release
>         ...
> }
>
>
> In thermal_zone_device_register_with_trips()
> {
>         ...
>         tz->device.release =3D tz_dev_release
>         ...
> }

Right, so why don't we clean that up to start with?
