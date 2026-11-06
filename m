Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984282;
	b=meQqcOozngw8C6M2erYePcPyz8P8GaJsQGASzJePx2wA4CDun87roayhE/+Elsd+1aNG
	 oGWjnW4mkHuZT/jy+hT7aOauHmnPfqW9Nuw+dh5IWDjb8jSXl71RC8ujMFNAasYNlJRiU
	 OjLns8giyS5OHZ8sTqRYnxh25Vk6f/27qhKyUwlq8feYOo1hxT1khxnyKYlNgvJ9elz1N
	 jVvj8B4iXJ8AXFjIAt3umyCHo6k387uY2MykwjUdGb2iOSDR05oUKzEfGEE42w3xs+6Px
	 DPqvlkAFWVdWPJVY3O1N0pHoyOTn059HyunsPluDYLrm/00R17a5XlJDHRFSL6E3tag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984282;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aapcxwLu2g1WrQp7s+HjqvVRyAq/ZI+SBlLC9jFvL6k=;
	b=y7V9BispboZiAs2hEIiz/SBkdb97G1NTmtOUBACL8is8f+2jnnXBpMoGMrI/O7DjYSSu
	 4eEB3a7HA3FVgJr/ViLBY8i5mmF1J9+q+oJtWWfqkeEvdCsKlRRij66XCqlpGY4mUCyWg
	 QGJiuBXlJZ4Ye2KTXG8n3PuCHoTo1dPu8k5bNsH0oTSc57wGXKQTaJ1AQcET7JkniNshQ
	 tIaAVOmQXq3a5hyC511Vhh2VKGeZwmbG4zpUqSC7PwZfejBqaHWiFkfkgycNOz9ZBoCNd
	 a4QakbBszVfnONkoo80VyPQyjnxtLZe6F/y6LvTgKhss7xKjxrsS6juHORUP1m5RPJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cz29no5d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73954606A326
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cz29no5d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454801F00901
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984282;
	bh=aapcxwLu2g1WrQp7s+HjqvVRyAq/ZI+SBlLC9jFvL6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cz29no5dD8JqRMxH+gjr48QKoSbORUNivGHRgf2jb3ac0pYoJTIbrM0CQk4JsIZfr
	 WZBUybCsFHPjz8qKOxMis9cn9Y6RSBnbzdjB3aqLkXlttBBvPXXz+VH2F0lqhR46DL
	 Y+n32Fu9LzeM1ET3+uhSR6eHeKnJQRESALqnqLt3HDOZhp39Om+OpJk4EdYp/XZCkp
	 EgawQfKfYNQaJLLHvQyaEzydAbwArJWSroM61WJ2E03/4tdQ9Espwy5ViJTq3zWzI0
	 rimulrD/pAhWFfQvgpG7OEnupITH2coIZJtHK+UPmINMMvoZycVPcc8dtcex3BuFKm
	 TDhyFEPwVyu+w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso791337e87.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG3M24Z15WIkmiE1/audJZy17rw6/41FhkljcOh37tOmmJq8XZm5GWZhENRZo5cdeFLwVN1NxIbow==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dxiGGBjhRL1TcLwCm6p/lAkEBvdonOdmX47odXEcwifdoOAnS
	WKnaX03FdLqMyMOA7aPsGtYVpgngG+sSoQJU+AG3i+IRUTtr/5K9wddiYCaRrRiiL7RmXXpzJ0w
	OrPZPx9qJgpKlszCAunvmWgrQeq74y28=
X-Received: by 2002:a05:6512:12d6:b0:5bf:ddd7:8897 with SMTP id
 2adb3069b0e04-5c003ac9e96mr980574e87.23.1793984280585; Fri, 06 Nov 2026
 08:58:00 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
In-Reply-To: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 17:57:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i07G06GDGX76f3-ppumfNUFD0nTB-Wz8k4PS=Ra13CsA@mail.gmail.com>
X-Gm-Features: AclHuK-nGOJX3yYmWbdI-i74p7cGw89wKvjKOaX_tvZvRUMd-zE7Ztxg-_gdiaU
Message-ID: <CAJZ5v0i07G06GDGX76f3-ppumfNUFD0nTB-Wz8k4PS=Ra13CsA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use hibernate callbacks when shutting down the system
To: Mario Limonciello <superm1@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Denis Benato <benato.denis96@gmail.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, Eric Naim <dnaim@cachyos.org>, 
	Bartu Alev <bartualev@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Driver Core Devel <driver-core@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:54=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> OEM systems that ship with Linux preloaded need to go through energy
> certifications that match regulatory bodies in the regions that they
> will ship.
>
> If any of those certifications don't pass then OEMs might not be able
> to ship systems preloaded in applicable regions.
>
> Multiple models of systems are reported to fail in Linux but pass
> for Windows on the exact same hardware.
>
> By looking at a breakdown of power consumption across devices the
> issue is that some devices aren't turned off when user puts the
> system into S5 (shutdown).
>
> A few years ago when I first root caused this I submitted patches
> to PCI core to change the PCI policy at shutdown [1].
>
> But through various iterations I've come up with a better approach.
> Instead of changing policy in each subsystem we can instead
> change our shutdown command to run hibernate callbacks for all hardware.
>
> In order to accomplish that the last 17 kernel cycles I've been slowly
> drippping changes into the hibernate code paths of all subsystems to make
> sure they behave as intended.
>
> Those are all merged as of kernel 7.4-rc1, and thus I am now ready to
> start using the hibernate codepath at shutdown. This series adds that
> support.
>
> I'm not na=C3=AFve; there is definitely risk involved with this change as=
 it
> will essentially affect anything running Linux that gets turned off.
>
> To that I will say that I have been running, rebasing and iterating this
> series on my personal development tree ever since December 2023.
> Various rolling distro community members have also been testing iteration=
s
> of these patches in their hardware and distros.
>
> I've also put a few guard rails in place:
>
> 1. Don't mandate hibernate support. If not compiled with it, just use
>    previous shutdown paths.
> 2. If hibernate callback fail, emit a `pr_emerg()` message but fallback
>    to previous shutdown paths.
> 3. Offer a kernel command line option `shutdown=3Dlegacy` that any affect=
ed
>    user could use to roll back to previous behavior while we root cause
>    any issues.
>
> I did split out the kernel command line option to a second commit.  If we
> later decide that we want to keep this behavior but drop the rollback kno=
b
> we can revert that commit.
>
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limon=
ciello@amd.com/#t

I have a couple of concerns regarding this, after looking at the patches.

First off, dpm_suspend_start() seems to be called during shutdown
while user space is running.  That is risky because at least some
things in the power-off code path assume that user space has been
frozen.  I think that freezing tasks, along the lines of what system
suspend does, before running dpm_suspend_start(), is requisite or you
will get into trouble with people who run fuzzers across shutdown or
similar.

The other concern is that the "legacy" shutdown should be the default
or people will get confused.  Arguably, it is not even necessary to
try to change that in many cases.

Of course, this means that the new shutdown arrangement will not be
used to start with, so there needs to be a plan to migrate users to
this new order and I would start with the systems where it actually is
an improvement.

I would try to add the shutdown=3D option upfront in the first patch and
make it take one of two options, "classic" (the regular shutdown
callbacks) or "pm-aware" (hibernation callbacks etc) with the first
one being the default at least to start with.

Then, you can add a DMI quirk table or similar with a list of systems
where "pm-aware" works better than "classic" and expand its use going
forward.  My expectation would be that, at one point in time, the
majority of x86 platforms using ACPI would be better off with
"pm-aware" than with "classic", but I'm not sure that this point in
time is today.  Beyond that, it is really hard to say how cards will
fall.
