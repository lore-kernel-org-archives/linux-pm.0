Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76905223DEA
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775307494; cv=none; b=LrjPD+l0a5P2po7I3mOYwouCLdFXPyrdEMzdxeyLFYnwmuduRsU/sTJSj7Tu7nVzU7RBbuqfnFD5K+HK1EPC9IwEUHhPCRm+IYk/LGKBe+XQy9LxMCujIN5iSRPiunU6MT1K7YFhNo62ecnhM9TJbtsgwM5cBuBc4GfhP7GrpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775307494; c=relaxed/simple;
	bh=qb1B9RSIsZRmgOpwl7sR/AL2txSg76hVfb8PVrg+874=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzuDj35Y7wEYb+UtNRo0ARYrew7anvyiHvpE8XmmTwtDnaswaMYdrdMad/BknsFVoimBndEGFj33HYZP/EcaSHYD3zcDVJbQ0f6NqcAIRaEhWNSSx5LOVGqnl59wDAJwypltPgR/wF/xsi8Ctmu5dcErYAV2tih1IDLsi0eESok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP+WulpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP+WulpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C39C2BCAF
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775307494;
	bh=qb1B9RSIsZRmgOpwl7sR/AL2txSg76hVfb8PVrg+874=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OP+WulpT3U8xK2FkGxyelHxEs89m+NqaemctAZHlHQe1bUmdwx+YstEDKWxw6z6uN
	 J7GDbHWJm1Ivbz+DjRTIrrshS5aUPUAakemDhIpBWf3y8KFlLpjYElVBzRiSPNWTPr
	 XPZ/lydYLWQd12mrcapLbbUKt7aPC23iDrBMfUrpSWMb+dQE8DN0OzwoXkk2G3ma7F
	 CQFUpURVJW9PE1nXulKm1ifZzvulh1deS/EXO9WjSF8Y5G3JPaHTpPN0nAM32z0xgK
	 WyzzrIGBkAUgtd0eBTJlp972IbT6h32CDoIJaMBtJ9WxtjuaHO0050OLqkO48rdZ0a
	 FMc+Cx07Z0D/A==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6843666b2a4so139779eaf.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 05:58:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU5H5tqYvF0nHoMaTYwUaAgygrO9evXQwhvmAJEKIYbDnTZCnPV8dEN0fX9yaGeBU1psL7mfs0pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxffXEefqC9gmdZhbsm0xxXgQ/HQ0I9gmZjmKLp4rAYy0mt3yEG
	0BB2BLW17MEeCt/5ckf8PsreAk3ycMEU03oGYT5K15r570zzTKHJSW6HbVvVTX6P5/51ISsiMK4
	UyRWIl+O3UUp7tf80pAWZVj5vwQFJOoQ=
X-Received: by 2002:a05:6820:4c0b:b0:67a:1eaf:a912 with SMTP id
 006d021491bc7-6821d747f37mr4840489eaf.2.1775307493175; Sat, 04 Apr 2026
 05:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402022742.17738-1-liujiajia@kylinos.cn> <2432224.ElGaqSPkdT@rafael.j.wysocki>
 <ebdbe040-d673-47b9-a6c9-f0fefc0b771b@roeck-us.net>
In-Reply-To: <ebdbe040-d673-47b9-a6c9-f0fefc0b771b@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 14:58:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZPXC5g3KY+trwmV=nXJu74y=0LaQTHaQ_MnqcfPVAGQ@mail.gmail.com>
X-Gm-Features: AQROBzBRM8xfaBHE3NlZR84-vCS8mGy2S-fIF5qBFgp5h_jRvwXg1DpsNdiWjsc
Message-ID: <CAJZ5v0jZPXC5g3KY+trwmV=nXJu74y=0LaQTHaQ_MnqcfPVAGQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v1] thermal: core: fix blocking in unregistering zone
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiajia Liu <liujiajia@kylinos.cn>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Armin Wolf <w_armin@gmx.de>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 4:20=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 4/3/26 05:52, Rafael J. Wysocki wrote:
> .[ ... ]
> > It appears to work for me, but I'm not sure if having multiple hwmon cl=
ass
> > devices with the same value in the name attribute is fine.
>
> Like this ?
>
> $ cd /sys/class/hwmon
> $ grep . */name
> hwmon0/name:r8169_0_c00:00
> hwmon1/name:nvme
> hwmon2/name:nvme
> hwmon3/name:nct6687
> hwmon4/name:k10temp
> hwmon5/name:spd5118
> hwmon6/name:spd5118
> hwmon7/name:spd5118
> hwmon8/name:spd5118
> hwmon9/name:mt7921_phy0

Yes.

> Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually overkill
> since the "sensors" command makes it
>
> r8169_0_c00:00-mdio-0
> Adapter: MDIO adapter
> temp1:        +36.0=C2=B0C  (high =3D +120.0=C2=B0C)
>
> mt7921_phy0-pci-0d00
> Adapter: PCI adapter
> temp1:        +30.0=C2=B0C
>
> essentially duplicating the device index.

Well, with the patch posted by me, the output of sensors from a test
system looks like this:

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +16.8=C2=B0C

pch_cannonlake-virtual-0
Adapter: Virtual device
temp1:        +33.0=C2=B0C

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +27.8=C2=B0C

(some further data excluded), which is kind of confusing (note the
duplicate acpitz-acpi-0 entries with different values of temp1).

That could be disambiguated by concatenating the thermal zone ID
(possibly after a '_') to the name.  Or the "temp*" things for thermal
zones of the same type could carry different numbers.

A less attractive alternative would be to register a special virtual
device serving as a parent for all hwmon interfaces registered
automatically for thermal zones.
