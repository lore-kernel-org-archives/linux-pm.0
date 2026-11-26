Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697471;
	b=RmzUWJc351/ZC9L5cwRWUcp/Ew7JQX0Zd+9zYlr7qyV23rJd1fjZxRwKmRMhlZM2JogF
	 10C96lktrjTs/YlVUE/Td2YrCEcxRpIqdwrFxVuYK9vGBcKSYcImRqs+WeHpas56Ap5Ve
	 prl+qI2TFGQGpRtN0m4iuz2Eb4C6JcvVEz49FIBj8EWiLQZwnjwJbdhyPr+RhyKvalemj
	 dgj+RiRgk95kXWtqzXY1TXcv8rmmB5Kq6RKzBHP95ziPFJunSg8MLGQIDoyJut3E1ERYb
	 0VCiTo/t9GqWWBEVhlSFi94RAGg7JXRnUyTuRGy6AXJ2vJgfdOQGQte+Cq0JuniDr1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697471;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q16GF0njlSdP7LoxbGpcMFaYQri5fmeNaCUnRRlaTx0=;
	b=VyRE2zCuAMbs42Ak3qJIPWHtGrLxDGY2VDAY7ChG3mlFr4UJqZU+TNtfIKfQ5H6yup+g
	 RKRP7hufBa4DpidP+oMRFTRUj9ZC0h8kF/Fgi26x5gdml4TqVSVTtRpDWm4mnqq4/NV54
	 XG1raSvs4b5Qdp4NFpYeAtq3dbt4gnOg/QDVPR98lQCuKD5rfQin/cNsEwCBLqozqGX+g
	 hCHE08hXJz4sj9vfBnQj/IHaU6b7uxoskIOh44Ej9eB1YmcNS/tGzrmkfiYfxkq/2zptp
	 aDjjZejh8SLei2HVmOgKtj1CGtxA4YwPMMfRfmytMYiq8Jlc1cGkJvnmKhwbW4dVgAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sf07nrF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F506606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sf07nrF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85661F000CA
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697470;
	bh=q16GF0njlSdP7LoxbGpcMFaYQri5fmeNaCUnRRlaTx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Sf07nrF2xWhUc6/ro+F5zlX/4rWpQr7AgTNcqgvpIBrhMlhX/VFPqNqD872/JMT5B
	 A0cEsvG6GrKVwzVNZeM6SqHrVqyWPvLFzs6fpNVTfisgh1z7k0Ir816Adb4F/pYW9s
	 rpKHNSc2PsW9o3F8+XwLNhSXUR3WCLRmVu69N/e95/HpcrR8gOh/TaC149ZKqJonVh
	 mivmQWLII4jBk6Zc4oi8z5qKbcxTvPX92PyLkteALTGnur1bvDah81MTdwlGdNEOyo
	 U7buw1ql74qZVhXttd7qEoDO4vpj/IhmfVCxWyx8ys2S/+bKw68xk8ucX/Td1SzQ4u
	 3xMuEXbOmlECw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso4751594e87.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:51:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGwHW5vnfS9h+reMuKPuQgHmZNa1LEMfOR0WomkSZoJmWLr0OhBQVRdcoO86/ORr+hV22DRm3v8xg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EubJfGDjPcPFCPbIrAFXm+44FDQZ+mR9FYKLhp/qIv94dnu0w
	CGZYV4erEyLiyTNXDqV6GJcRgIQlG8Xy1Mm+5vmaWhPZvFCcNS2q3OZfu6xRNvQiOcM7rNSuiEu
	r2Nl2IYu39+sG5kYX7ZJeGMvpyiWjoWU=
X-Received: by 2002:a05:6512:3d29:b0:5c1:47d6:8258 with SMTP id
 2adb3069b0e04-5c1bc80120bmr6196876e87.41.1795697469357; Thu, 26 Nov 2026
 04:51:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4779892.LvFx2qVVIh@rafael.j.wysocki> <CAPx+jO8d-25kLQw9X0wW4i3YV4Jn+2Zr7_ZOT9rE10D99kPU_Q@mail.gmail.com>
In-Reply-To: <CAPx+jO8d-25kLQw9X0wW4i3YV4Jn+2Zr7_ZOT9rE10D99kPU_Q@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 26 Nov 2026 13:50:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5M7fax8_XP1G4oENykq6vg-hgiW4JPaqf=AvRiY-xFA@mail.gmail.com>
X-Gm-Features: Aa3M54rqPc231r6BvV4IGlb68jllf8ooObFsk4opHGBD8naBN0eygsdnIo8Ab08
Message-ID: <CAJZ5v0j5M7fax8_XP1G4oENykq6vg-hgiW4JPaqf=AvRiY-xFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: runtime: Fix issues related to autosuspend
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 12:51=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Tue, Nov 24, 2026 at 4:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > Hi All,
> >
> > This is a follow-up series for
> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
/commit/?h=3Dlinux-next&id=3D26236a3e8803f7e1ace104020d7f006edb220116
> >
> > which is in linux-next and it replaces
> >
> > https://lore.kernel.org/linux-pm/3076901.e9J7NaK4W3@rafael.j.wysocki/
> >
> > (hence v2).
> >
> > First of all, there is a potential issue with respecting autosuspend de=
lays
> > in pm_runtime_put_autosuspend() and pm_runtime_put_sync_autosuspend() t=
hat
> > existed before the above commit, which is addressed in the first patch,
> > and that fix is relevant for the other patches in the series.
> >
> > Second, the commit above overlooked some cases in which a running autos=
uspend
> > timer may trigger between dropping a runtime PM reference to a device a=
nd
> > updating its last_busy timestamp, which may cause the device to suspend
> > without respecting its autosuspend delay.  Those cases are addressed by
> > the second patch.
> >
> > Next, I was mistaken when I wrote this in the changelog of the above co=
mmit:
> >
> >  Updating the last_busy timestamp when rpm_idle() returns an error
> >  without calling rpm_suspend() is not useful because the device is then
> >  going to remain active for an unknown amount of time and its autosuspe=
nd
> >  delay needs to take effect later.
> >
> > There actually is a reason for doing this which is that an autosuspend =
timer
> > (left behind by an intermediate runtime resume) may be running when rpm=
_idle()
> > runs and that autosuspend timer needs to be prevented from using a soon=
-to-be-stale
> > last_busy timestamp value.  That is addressed by the 3rd patch.
> >
> > Finally, the last patch updates a kerneldoc comment that has become out=
dated after
> > the commit above.
> >
> > For details, please see the patch changelogs.
> >
> > Thanks!
> >
> >
> >
>
> Again, thanks for working on this! For the series, please add:
>
> Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Thank you!

> As somewhat also proven by the subject $series, there are some churns
> that we need to deal with in regards to the intermediate rpm_idle()
> phase. I am wondering if it perhaps may be the time to consider
> removing it altogether, unless we still think it's useful of course.

I don't think that the rpm_idle() phase is super-useful.

Of course, eliminating it would require getting rid of the runtime
idle callbacks in the first place, but we all seem to agree that this
should be doable and probably worth doing.

> In the past we have discussed introducing support for *multiple* (a
> dynamical amount based on what the device supports) low power states
> to runtime PM. When I started looking into how to implement it, I
> stumbled over the rpm_idle() thing, which kind of prevented me from
> moving forward at that point.
>
> What do you think?

Here I have some doubts.

I'm not sure if there is a single model covering multiple idle states
that can be applied to every device in every system.

There are different semantics and different requirements.  For
example, you may consider "clock gate" and "power gate" states for
some devices, such that a device needs to go to "clock gate" first and
then to "power gate".  On the way back, it would need to go to "clock
gate" before reaching full power.  However, this is not how PCI or
ACPI PM works: There you can go from shallower to deeper, but to go
the other way around you need to transition straight to full power.
