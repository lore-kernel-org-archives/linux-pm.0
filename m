Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD14315D3B
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663841; cv=none; b=Xn2cLTciY+SPvwQJD8STFVuapWPgFh3NFfMjrCYUIG6r0K/kCyug/YnpI+iMikEY7bcmVIxx7t40GmYAB85dOY/JltW4wInRSqimOFRC+e5JBwou4bwClLWEafSarOBgFBATYsfsYcPWf3ozOXT7uqz6EU2y91Uk3ck1PgqSibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663841; c=relaxed/simple;
	bh=i09tBevPbS/+tbR7YjMib0XsfoD7rLQFtuhVVaknBrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH4y9L0qh0zS18GED6B1g8l2ow4obwjvKl1GXgpkm7t6Fusvrj4RveS8g8yO/hsk5Fyf19sQPXw0TWzla1lXXCsWE82Ha7nsEAoxcT4Vk6Wd245QE6LrhBcgdWrrHnfJMEB5DaNspti9Pfbw+sDL/LPckkpo5fP71JhNSCxQURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoaLiPGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoaLiPGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E0BC4AF09
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663841;
	bh=i09tBevPbS/+tbR7YjMib0XsfoD7rLQFtuhVVaknBrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZoaLiPGF1w3ca29/cLOQsnqiHHn26QyL7ytrs7zdqkJKeG3b8aAyZtuMbrxX7SKOc
	 iKvxg3INQwlGtTC1Nd6CAA6W8pOAaPNferKC8fa/e/h5VJDCY8HENdmv7HOF8VY/r5
	 ai4RXN9oYmN1Kp+zmnUC+uslHmtTbKN0MU1cTpDq0IFRpuXNaPPl8f9GqqTYzPhyxl
	 i9cYclVBTNaOfQYg0/GPM1+x3s+A1H+NAlOdhBZtxkVZDDOD5Icq1T9VizX1IRFI5e
	 IcB9mf0KzKhEsSZSid7aX+UogrV2yybjX1ejtxPq4sQ2Ozkh2bhm86cBPvPuEb+1Sp
	 /D6NT9/9Mtm3g==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbff06e4a6so1383740a34.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 08:57:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWafwm2JS+CXZUuxCqo0Vfe0eK49se9s1wbyl0BfmZyaxwjm3rXJBgkVV2mQz/Ijix6t9GRI/0Y7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxhSzR6c283mr795pZmPO5h+XFJNYd4WK5nSboibaQv5l9kar
	H5OuLvHiJh63GrAGgUMNt4avNUx4YCwWO4RsddunoffdERnUqGAcb0RW5e9JR8Urgb8/acI4bqe
	QU70BlGYf2EGkN68t7nimpV1DjdXR0XY=
X-Received: by 2002:a05:6820:3081:b0:686:d107:2865 with SMTP id
 006d021491bc7-686d1073828mr6123296eaf.59.1775663840158; Wed, 08 Apr 2026
 08:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402022742.17738-1-liujiajia@kylinos.cn> <2432224.ElGaqSPkdT@rafael.j.wysocki>
 <ebdbe040-d673-47b9-a6c9-f0fefc0b771b@roeck-us.net> <CAJZ5v0jZPXC5g3KY+trwmV=nXJu74y=0LaQTHaQ_MnqcfPVAGQ@mail.gmail.com>
 <ec16fc75-c5fa-4ff9-bc6b-91464e9c26cc@roeck-us.net> <CAJZ5v0g83UQKRcZ+u5EM13gwzktMXAxLqqcCoT8+CQLzOnChiw@mail.gmail.com>
 <e5638cf8-88ee-4b61-b032-6cf324b7c642@roeck-us.net> <CAJZ5v0jfi_gXPVq9E2eJe_0MG4vVojyDo6=ABv4fNFK=Q_qpug@mail.gmail.com>
 <e2e9c203-608b-4c96-b034-ba95eec61ac5@roeck-us.net>
In-Reply-To: <e2e9c203-608b-4c96-b034-ba95eec61ac5@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Apr 2026 17:57:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4=qaw3NB5FwLe5QvXpky02cTmRrJTiaFhfYChu5rA0Q@mail.gmail.com>
X-Gm-Features: AQROBzD_keZ5t-sHC7dNyQasZoKGO3oZfznZGc-OHOi6Pd1OwEadC7IzUPEec3s
Message-ID: <CAJZ5v0h4=qaw3NB5FwLe5QvXpky02cTmRrJTiaFhfYChu5rA0Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v1] thermal: core: fix blocking in unregistering zone
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiajia Liu <liujiajia@kylinos.cn>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Armin Wolf <w_armin@gmx.de>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:32=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 4/8/26 08:05, Rafael J. Wysocki wrote:
> > On Sun, Apr 5, 2026 at 5:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> >>
> >> On 4/4/26 10:38, Rafael J. Wysocki wrote:
> >>> On Sat, Apr 4, 2026 at 4:02=E2=80=AFPM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>>>
> >>>> On 4/4/26 05:58, Rafael J. Wysocki wrote:
> >>>>> On Fri, Apr 3, 2026 at 4:20=E2=80=AFPM Guenter Roeck <linux@roeck-u=
s.net> wrote:
> >>>>>>
> >>>>>> On 4/3/26 05:52, Rafael J. Wysocki wrote:
> >>>>>> .[ ... ]
> >>>>>>> It appears to work for me, but I'm not sure if having multiple hw=
mon class
> >>>>>>> devices with the same value in the name attribute is fine.
> >>>>>>
> >>>>>> Like this ?
> >>>>>>
> >>>>>> $ cd /sys/class/hwmon
> >>>>>> $ grep . */name
> >>>>>> hwmon0/name:r8169_0_c00:00
> >>>>>> hwmon1/name:nvme
> >>>>>> hwmon2/name:nvme
> >>>>>> hwmon3/name:nct6687
> >>>>>> hwmon4/name:k10temp
> >>>>>> hwmon5/name:spd5118
> >>>>>> hwmon6/name:spd5118
> >>>>>> hwmon7/name:spd5118
> >>>>>> hwmon8/name:spd5118
> >>>>>> hwmon9/name:mt7921_phy0
> >>>>>
> >>>>> Yes.
> >>>>>
> >>>>>> Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually over=
kill
> >>>>>> since the "sensors" command makes it
> >>>>>>
> >>>>>> r8169_0_c00:00-mdio-0
> >>>>>> Adapter: MDIO adapter
> >>>>>> temp1:        +36.0=C2=B0C  (high =3D +120.0=C2=B0C)
> >>>>>>
> >>>>>> mt7921_phy0-pci-0d00
> >>>>>> Adapter: PCI adapter
> >>>>>> temp1:        +30.0=C2=B0C
> >>>>>>
> >>>>>> essentially duplicating the device index.
> >>>>>
> >>>>> Well, with the patch posted by me, the output of sensors from a tes=
t
> >>>>> system looks like this:
> >>>>>
> >>>>> acpitz-acpi-0
> >>>>> Adapter: ACPI interface
> >>>>> temp1:        +16.8=C2=B0C
> >>>>>
> >>>>> pch_cannonlake-virtual-0
> >>>>> Adapter: Virtual device
> >>>>> temp1:        +33.0=C2=B0C
> >>>>>
> >>>>> acpitz-acpi-0
> >>>>> Adapter: ACPI interface
> >>>>> temp1:        +27.8=C2=B0C
> >>>>>
> >>>>> (some further data excluded), which is kind of confusing (note the
> >>>>> duplicate acpitz-acpi-0 entries with different values of temp1).
> >>>>>
> >>>>
> >>>> Yes, agreed, that is confusing. I would have expected the second one
> >>>> to be identified as "acpitz-acpi-1". Do they both have the same pare=
nt ?
> >>>
> >>> No, they don't.
> >>>
> >>> The parent of each of them is a thermal zone device and both parents
> >>> have the same "type" value.
> >>>
> >>>>> That could be disambiguated by concatenating the thermal zone ID
> >>>>> (possibly after a '_') to the name.  Or the "temp*" things for ther=
mal
> >>>>> zones of the same type could carry different numbers.
> >>>>>
> >>>>> A less attractive alternative would be to register a special virtua=
l
> >>>>> device serving as a parent for all hwmon interfaces registered
> >>>>> automatically for thermal zones.
> >>>>
> >>>> If they all have the same parent, technically it should be a single
> >>>> hwmon device with multiple sensors, as in:
> >>>>
> >>>> acpitz-acpi-0
> >>>> Adapter: ACPI interface
> >>>> temp1:        +16.8=C2=B0C
> >>>> temp2:        +27.8=C2=B0C
> >>>
> >>> So somebody tried to make it look like that by registering hwmon
> >>> interfaces for all of the thermal zones of the same type under one of
> >>> them, but that (quite obviously) doesn't work.
> >>
> >> Not sure I understand why that doesn't work or why that is obvious,
> >> but I'll take you by your word (I would agree that the current
> >> _implementation_ looks problematic).
> >
> > For example, say that there are two ACPI thermal zones on a system
> >
> > /sys/devices/virtual/thermal/thermal_zone0/
> > /sys/devices/virtual/thermal/thermal_zone1/
> >
> > The current mainline code registers a hwmon class device for thermal_zo=
ne0 only:
> >
> > /sys/devices/virtual/thermal/thermal_zone0/hwmon0/
> >
> > because the type is "acpitz" for both of them, but it adds a sysfs
> > attribute that belongs to thermal_zone1 under it:
> >
> > /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp2_input
> >
> > There is also
> >
> > /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp1_input
> >
> > but it belongs to thermal_zone0.
> >
> > Interesting things happen when thermal_zone0 is removed, for example
> > because the ACPI thermal driver is unbound from the underlying
> > platform device.  Namely, the removal code skips the removal of hwmon0
> > because of the temp2_input attribute belonging to thermal_zone1 which
> > effectively prevents thermal_zone0 removal from making progress.
> >
> > AFAICS, nothing particularly smart can be done to address this issue
> > while retaining the current design of the code.  Reparenting hwmon0 to
> > thermal_zone1 may confuse user space as well as removing hwmon0 along
> > with temp2_input.  That's why I think that this is a design issue.
> >
>
> The ACPI power meter driver has pretty much the same problem. A clear
> solution would require making hwmon sysfs attributes dynamic in nature
> (i.e., by adding the ability to change the visibility of attributes in
> runtime). I have started working on that, but did not have time to
> complete the work. The ACPI power meter driver uses a kludge around that:
> It unregisters the hwmon device whenever it gets a METER_NOTIFY_CONFIG
> event and re-registers it.
>
> Anyway, registering separate hwmon devices, one per thermal zone,
> is perfectly fine with me.

OK, I'll do that and see how it goes.

Thanks for the feedback!
