Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756973A75A5
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660744; cv=none; b=LJYDNxsYJjGJAwR0xZ94SWVXiD7QX9cy9xf8E7A0YkLXVUHVfMeBc6LiGF//PqnUfyPEDoegxIpbqSGCLYsY+WE2oKrL9Znuezv7DSzFszMZL57DRDhUXKJom7NN69IJJdHrfIf1uStYgaggNNBQJ+TZ69+1aaSIgwtDfr2pSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660744; c=relaxed/simple;
	bh=/aaCYkDaYX4qikE45y/muOUa4ER586LfCIXJYav+Ti8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJm9/0gh/v3rE3hsR0LBmT3tqF4FPoN79Y9rEEH3TuQkguCA1roopu89Yt1xsR/yPIhP53NU8fhM7HJ6Qtg2q4sDeY6JXS4hbHTTipLtUL1wTAneTUMp77cvV0IUwMBsXrGecxFxzmBOrEMutS5HsUYW8uDoxfYg+uJMTqg3IAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtVlvu3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtVlvu3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17304C4AF09
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775660744;
	bh=/aaCYkDaYX4qikE45y/muOUa4ER586LfCIXJYav+Ti8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NtVlvu3JEqC5nGVDsTsFCp5UlvyqmM1lSlQ+7Nrrzhk08gcMtp3M0eVBfkvSGYioe
	 rjbEFxqUBLCn3iHoRxof5ejQ/S8k5qYOIa3o/b2ZYN6i/GrylKfU6IZgsj5AQjmMGh
	 8HuEw4bWvYhbCTH2KovPuW0KrDEFP9fyq7EBAEKyOSokSlo1i4rOogdXAvaIJLQloM
	 H9TmG7Nbl8cYY+AZ5w4RkZLyeOi7ieB0jorHC4a32ctMZsivnjC/lQqkPlWttCnKeE
	 xmfmR9/C5II6Xm9StryJLgEojPhid8PiM/6wZppKmE0Q5S4SGhUzAXCRnL4NeTfAIu
	 FO04mOzDZMskQ==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-464ba2bb3aeso729236b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 08:05:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5poOgJ95FHjgG6oTOzj3GzrNVKr+8yXmrnHBxY3Hf/AdyR2e4HQyXgEchlvjax9nK2zBlVV6Fjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iWY6Bj3sbNx5xx1NlB9TIeGMTIc4EZAjKpZFqkKv9xaQeNCS
	WwPX52ChaXoL6qOtaLN5GkvwCDHVsGw6dMXvs+fQiSFwar7Kr4O8pDlEm1AALsPD+yC4uRTvcnJ
	D1qHtv9IAEVJ7ZPcNRmVIXMjjBLQYGmM=
X-Received: by 2002:a05:6808:1a21:b0:467:8b7:4a46 with SMTP id
 5614622812f47-46f01343bc3mr9995949b6e.9.1775660743091; Wed, 08 Apr 2026
 08:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402022742.17738-1-liujiajia@kylinos.cn> <2432224.ElGaqSPkdT@rafael.j.wysocki>
 <ebdbe040-d673-47b9-a6c9-f0fefc0b771b@roeck-us.net> <CAJZ5v0jZPXC5g3KY+trwmV=nXJu74y=0LaQTHaQ_MnqcfPVAGQ@mail.gmail.com>
 <ec16fc75-c5fa-4ff9-bc6b-91464e9c26cc@roeck-us.net> <CAJZ5v0g83UQKRcZ+u5EM13gwzktMXAxLqqcCoT8+CQLzOnChiw@mail.gmail.com>
 <e5638cf8-88ee-4b61-b032-6cf324b7c642@roeck-us.net>
In-Reply-To: <e5638cf8-88ee-4b61-b032-6cf324b7c642@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Apr 2026 17:05:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfi_gXPVq9E2eJe_0MG4vVojyDo6=ABv4fNFK=Q_qpug@mail.gmail.com>
X-Gm-Features: AQROBzC_07BRcP-W6n6s96C2T1a5ipDQBp7oSMuADrU9c4_JVk9YowzV6lirmMY
Message-ID: <CAJZ5v0jfi_gXPVq9E2eJe_0MG4vVojyDo6=ABv4fNFK=Q_qpug@mail.gmail.com>
Subject: Re: [PATCH RESEND v1] thermal: core: fix blocking in unregistering zone
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiajia Liu <liujiajia@kylinos.cn>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Armin Wolf <w_armin@gmx.de>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 5:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 4/4/26 10:38, Rafael J. Wysocki wrote:
> > On Sat, Apr 4, 2026 at 4:02=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> >>
> >> On 4/4/26 05:58, Rafael J. Wysocki wrote:
> >>> On Fri, Apr 3, 2026 at 4:20=E2=80=AFPM Guenter Roeck <linux@roeck-us.=
net> wrote:
> >>>>
> >>>> On 4/3/26 05:52, Rafael J. Wysocki wrote:
> >>>> .[ ... ]
> >>>>> It appears to work for me, but I'm not sure if having multiple hwmo=
n class
> >>>>> devices with the same value in the name attribute is fine.
> >>>>
> >>>> Like this ?
> >>>>
> >>>> $ cd /sys/class/hwmon
> >>>> $ grep . */name
> >>>> hwmon0/name:r8169_0_c00:00
> >>>> hwmon1/name:nvme
> >>>> hwmon2/name:nvme
> >>>> hwmon3/name:nct6687
> >>>> hwmon4/name:k10temp
> >>>> hwmon5/name:spd5118
> >>>> hwmon6/name:spd5118
> >>>> hwmon7/name:spd5118
> >>>> hwmon8/name:spd5118
> >>>> hwmon9/name:mt7921_phy0
> >>>
> >>> Yes.
> >>>
> >>>> Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually overki=
ll
> >>>> since the "sensors" command makes it
> >>>>
> >>>> r8169_0_c00:00-mdio-0
> >>>> Adapter: MDIO adapter
> >>>> temp1:        +36.0=C2=B0C  (high =3D +120.0=C2=B0C)
> >>>>
> >>>> mt7921_phy0-pci-0d00
> >>>> Adapter: PCI adapter
> >>>> temp1:        +30.0=C2=B0C
> >>>>
> >>>> essentially duplicating the device index.
> >>>
> >>> Well, with the patch posted by me, the output of sensors from a test
> >>> system looks like this:
> >>>
> >>> acpitz-acpi-0
> >>> Adapter: ACPI interface
> >>> temp1:        +16.8=C2=B0C
> >>>
> >>> pch_cannonlake-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:        +33.0=C2=B0C
> >>>
> >>> acpitz-acpi-0
> >>> Adapter: ACPI interface
> >>> temp1:        +27.8=C2=B0C
> >>>
> >>> (some further data excluded), which is kind of confusing (note the
> >>> duplicate acpitz-acpi-0 entries with different values of temp1).
> >>>
> >>
> >> Yes, agreed, that is confusing. I would have expected the second one
> >> to be identified as "acpitz-acpi-1". Do they both have the same parent=
 ?
> >
> > No, they don't.
> >
> > The parent of each of them is a thermal zone device and both parents
> > have the same "type" value.
> >
> >>> That could be disambiguated by concatenating the thermal zone ID
> >>> (possibly after a '_') to the name.  Or the "temp*" things for therma=
l
> >>> zones of the same type could carry different numbers.
> >>>
> >>> A less attractive alternative would be to register a special virtual
> >>> device serving as a parent for all hwmon interfaces registered
> >>> automatically for thermal zones.
> >>
> >> If they all have the same parent, technically it should be a single
> >> hwmon device with multiple sensors, as in:
> >>
> >> acpitz-acpi-0
> >> Adapter: ACPI interface
> >> temp1:        +16.8=C2=B0C
> >> temp2:        +27.8=C2=B0C
> >
> > So somebody tried to make it look like that by registering hwmon
> > interfaces for all of the thermal zones of the same type under one of
> > them, but that (quite obviously) doesn't work.
>
> Not sure I understand why that doesn't work or why that is obvious,
> but I'll take you by your word (I would agree that the current
> _implementation_ looks problematic).

For example, say that there are two ACPI thermal zones on a system

/sys/devices/virtual/thermal/thermal_zone0/
/sys/devices/virtual/thermal/thermal_zone1/

The current mainline code registers a hwmon class device for thermal_zone0 =
only:

/sys/devices/virtual/thermal/thermal_zone0/hwmon0/

because the type is "acpitz" for both of them, but it adds a sysfs
attribute that belongs to thermal_zone1 under it:

/sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp2_input

There is also

/sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp1_input

but it belongs to thermal_zone0.

Interesting things happen when thermal_zone0 is removed, for example
because the ACPI thermal driver is unbound from the underlying
platform device.  Namely, the removal code skips the removal of hwmon0
because of the temp2_input attribute belonging to thermal_zone1 which
effectively prevents thermal_zone0 removal from making progress.

AFAICS, nothing particularly smart can be done to address this issue
while retaining the current design of the code.  Reparenting hwmon0 to
thermal_zone1 may confuse user space as well as removing hwmon0 along
with temp2_input.  That's why I think that this is a design issue.

> I looked into the source code of the "sensors" command. It indeed does
> not index ACPI devices (nor virtual devices, for that matter) but
> assumes that such devices are unique. My apologies for not realizing
> this earlier.
>
> So your only option is indeed to index the chip name if you want/need
> more than one hwmon device with the same base name (here: acpitz)
> instantiated from the thermal subsystem.
>
> One comment to one of your earlier e-mails:
>
> "However, it is more of a design issue IMV because putting temperature
>   attributes for all of the (possibly unrelated) thermal zones of the
>   same type under one hwmon interface is not particularly useful"
>
> A single hardware monitoring device, by design, serves multiple
> thermal zones. Anything else would not make sense for multi-channel
> hardware monitoring chips. The hardware monitoring subsystem groups
> sensors by chip, not by thermal zones.
>
> Having said this: This discussion is not new. Certain subsystems
> advocate for having one hardware monitoring device per sensor,
> not per chip. One submitter went as far as telling me that I am
> clueless. We don't need to repeat the exercise. I have my opinion,
> you have yours, and all we can do is to agree to disagree.

I'm not sure if this has anything to do with hardware monitoring chips
because hwmon_device_register_for_thermal() sets the chip argument of
__hwmon_device_register() to NULL, so the chip information is missing
in this particular case.  The underlying hardware may or may not be a
multi-channel hardware monitoring chip, that is hard to tell in
general.

In the particular case of ACPI thermal zones, they each correspond to
a different platform device and regarding those as different channels
of the same hardware monitoring chip is kind of a stretch IMV (they
may even be located at different places in the device hierarchy).

Regardless, it should be possible to remove each of them cleanly
because they are handled by the driver independently.
