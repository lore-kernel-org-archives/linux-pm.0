Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D653A6F14
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213159; cv=none; b=hRk94vpmuJjvCzQCtHhE4c1REWB0w1NaRfCluuvmLEtmriAU5FzamkYQTevWqImWHOg56FDumV9d1trhDO+Y52qb0C5p7Jr0DEA+Dp6pd2RLmcUIFvdC3LNl1FHEICAPotFqaJdrAzpEJ80hualH8mRHR+uxG7oCEoZ9NG3F9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213159; c=relaxed/simple;
	bh=0o84pYdxTQQzYs6glMpMj/UUvehhD/P8bC+lS8pjvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDfZPGjOxtff00bdOKeGyiJit53GWN373DIReyrOLz1P3hwEkBv66KTUXZbmOcjq2vwE6Vtvkx6SyzouusNNNxGlgp35ON8A2Zhr1ngRYaJwqadAbzwgTU8uOrQ8JwENp7jvbQ/86XdYlhS7Cg/dXj5RkUvTrGP/+0AFVq3tvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chq1h7bQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chq1h7bQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6897C4CEF7
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775213158;
	bh=0o84pYdxTQQzYs6glMpMj/UUvehhD/P8bC+lS8pjvkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Chq1h7bQyYnJ1usc+d7kA5zr/GL4tnW3cPC9ClzhIMSMf9xFCS1Z9LQ1b+6gqDXO7
	 unbipXDtuYwFJIkbcmAV/84E0ietPCSag8k5YNBIbPBVYp4iMWfU4FsJ87+bd6awNj
	 Boa3d+pw5boyF8qaKkgiKOZHZWdr6OLTXCY4XleUkOcnhcv6gQayfos0ibRBCJ97NZ
	 RuPaHc2i9wmj5nyHIVrD9gf4KgI0bw++jIqp4e45XR0c/HW9Ia5ypW9f7h1m3OQdk8
	 bpNTYuVmkbDe936kyMo3+XdP26XU5+Btl84X2UsMla4B6ubL1OoFa2F/VfMlxlUZb0
	 AoeXYWoXOoT/g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-417c34b0509so1372554fac.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 03:45:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVR9HRkiY3JdWPBLK16aZ7itE4LO4HVAHHl1WSnCJrW03vAsn2eBp8CeuHvk5XFQOe3OsfuHS+5cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64S+RQItyuP3IVhopgHvSFI0FT1baU834JJwErPM9Hwn85d08
	m0208tlrPIKa2B4yDB7aZoeVXKHIQK1qgWqKH4DSmdsA78qyxUizOk1YeARnC8YXXF8qhh8jm9V
	CM1+8TckD6fS0Z6q5O1QiG0fz+OAlkJw=
X-Received: by 2002:a05:6871:7bc7:b0:404:42e:92f with SMTP id
 586e51a60fabf-4230fe43eacmr1298230fac.5.1775213158066; Fri, 03 Apr 2026
 03:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fe1b679-ab28-4505-b0db-14e7ac3ba749@gmail.com>
 <CAJZ5v0iMfiqjkkvOMU6jWEZ+nBvcRtWNwjvBW0pEva1G_owFcg@mail.gmail.com>
 <744440a6-e1cb-4792-a848-57755de0686b@gmail.com> <CAJZ5v0i5dSuQ7f8Okb-Ch5igzNn=L_Fj5d3H4pftvxoEVBaDUw@mail.gmail.com>
 <0758441c-e88d-475a-80ef-061b227ae7fc@gmail.com>
In-Reply-To: <0758441c-e88d-475a-80ef-061b227ae7fc@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 3 Apr 2026 12:45:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTTdJDPDk3ACVpjP=S5nrA-vddfKBnFRyWSbHCuWWKQQ@mail.gmail.com>
X-Gm-Features: AQROBzDMajT-PTryobqCCYVLkZW11PnyntEq6PmPGmp9K46vmX4cNThO38lcrbw
Message-ID: <CAJZ5v0jTTdJDPDk3ACVpjP=S5nrA-vddfKBnFRyWSbHCuWWKQQ@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Allocate class wakeup_class statically
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 3:05=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 01.04.2026 19:32, Rafael J. Wysocki wrote:
> > On Wed, Apr 1, 2026 at 5:45=E2=80=AFPM Heiner Kallweit <hkallweit1@gmai=
l.com> wrote:
> >>
> >> On 01.04.2026 16:19, Rafael J. Wysocki wrote:
> >>> On Sun, Mar 29, 2026 at 6:14=E2=80=AFPM Heiner Kallweit <hkallweit1@g=
mail.com> wrote:
> >>>>
> >>>> Allocating wakeup_class statically avoids a little runtime overhead.
> >>>> Define groups and device release function as part of the class, so t=
hat
> >>>> we don't have to repeat this for each class device.
> >>>> Whilst at it, constify wakeup_source_attrs[].
> >>>>
> >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>
> >>> Can you please have a look at this and let me know what you think:
> >>>
> >>> https://sashiko.dev/#/patchset/0fe1b679-ab28-4505-b0db-14e7ac3ba749%4=
0gmail.com
> >>>
> >> Interesting finding! I think the diagnosis is right.
> >>
> >> But: I would say the current behavior isn't a nice solution as well:
> >
> > It is not fantastic, but it doesn't have this issue.
> >
> >> wakeup_source_device_create() does: dev->class =3D wakeup_class;
> >> I think no reader will expect that wakeup_class may be NULL here due t=
o
> >> initcall ordering. In addition this behavior results in such early
> >> wakeup sources not being shown in sysfs.
> >
> > They are registered too early to show up in sysfs, but they can work re=
gardless.
> >
> > I think that it's just pointless to call device_register() for a given
> > wakeup source if wakeup_class has not been registered yet.
> >
> >> But I'm not sure whether registering class "wakeup" (and registering
> >> classes in general) would be possible early enough (core_initcall,
> >> or even pure_initcall).
> >
> > driver_init() is called before do_initcalls() is do_basic_setup(), so
> > class registration should work for all initcall levels AFAICS.
> >
> When testing the current code on my system, autosleep is the first wakeup
> source, registered in a core_initcall, and it's not shown in sysfs.
> Same result when class wakeup is registered in a core_initcall
> (instead of postcore_initcall). Registering class wakeup in a pure_initca=
ll
> works and fixes the issue. So, would this be an acceptable solution for t=
he
> discussed issue?

I don't see why not.
