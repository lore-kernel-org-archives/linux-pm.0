Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD54362154;
	Sat, 17 Oct 2026 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261796; cv=pass; b=Q56H2dAZ6+YwKHldAziddCIQoBzICdLtoWoeZh9ysclSvCZjpZqw5CJZtPn7NB8TgUUX6evn7hTKBHls38pc+N2lpqFiK6+zdlYNTKFCGyIpF0s3Yj5dDoNGAU5aNwMILS0p6Nv1qWhTM7YEu9YOzQG/2uKM99w/kVEoMGjW0Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261796; c=relaxed/simple;
	bh=49Y3TWwT6jzURnREaPoE86F9UtFvuQ4XzPRvFHCmZFE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RaI3VwmQV55PBWmnIerbjOA7HHw6DECas5zlft+l7JwR4e2PyKt0lNXFeEisyXctpbHDT3Bsw0XU9FSTvCTPRqREg5soz+D8j72NvmMAbDKb1s76F6dWAVSzHPxsmLI8gNZ9lus2HZcR6eqtnveOQxLUIhuMZhE4XxetTsmS00M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=SSddNJ8O; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="SSddNJ8O"
ARC-Seal: i=1; a=rsa-sha256; t=1792261760; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k7Ox22qBO8gmNsbzWTL9E210GjMKlGBLi12Un/zckWdANCfnWjMT0cTr+5+f1dk5VX9sg2VMnXh5AIMneOdjiRA50uG8xMdsZ2TW8Y9J7cWHQloeEBLYaRddevTupcy89w/vWs5XDi2uKknEkbVi4nQsiqgfd6Uc5JxYxUTRQNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792261760; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NbLgjZCbwJNl+PL3kYhc1bvwnDPQCgz9nTMZiJVd3eI=; 
	b=lnn79/eeLp0uPmNpLf3u7cPKYpYEbdtTobOX8oFqnFvkFg18AddAyvyWnu1vS6NQg7OlgCvKX2Iv/UY9AbOM2CRY/MtD76aaim085PRDOQH6DgEWuuKug8cOyvrx5YR1uE/uJGjkN7zwfhTEH2i3ExmcwBpjK0CtoAGAAjNHqWo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792261760;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=NbLgjZCbwJNl+PL3kYhc1bvwnDPQCgz9nTMZiJVd3eI=;
	b=SSddNJ8Osk/9ZlFE+NVH5+ILPZWiUbcSV3tvPVIfHlmv196dQJoYvlS7kiF3G0pd
	Hj9D8eTAXflaqwViDrLhtBXLwp7eJQCk5YGhrA0Stx7irsdo5ZpLwTy/a+6mE5z4KZu
	cxyJtoEQUaSCstLLxteVmXYiS9ihRmJ7/E9S/Lm73mbOFXoKhvQivkfrjYSW1UQcdRq
	Fv4JTg2A9FV6SXYluhPyqpw38Fvp9jUAeCrJP/dr9CQfLS/S9Lukb0VuKSVIZYdoDwu
	R4BSNYirHDzrJ37Y6Lun53M/SFOIFxHQUzYtAhrNqJVG7FEbFhbsyQqc+2paWMk3JhE
	KHiOXC3EBQ==
Received: by smtp.zohomail.com with SMTPS id 1792261759316393.94545613618743;
	Sat, 17 Oct 2026 11:29:19 -0700 (PDT)
Message-ID: <9fbc5d0f232f231102437b3682ead619cac30f64.camel@rong.moe>
Subject: Re: [PATCH v2 0/4] ACPI: Serialize battery, INT3403 _TMP and
 ideapad methods
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, Len Brown
 <lenb@kernel.org>,  Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Ike Panhc
 <ikepanhc@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf	 <W_Armin@gmx.de>, Charis
 Stratakis <c.stratakis@proton.me>, Avraham Hollander	
 <anhollander516@gmail.com>, Jeffrey =?ISO-8859-1?Q?W=E4lti?=	
 <jeffrey@waelti.dev>, Rick <rickk1166@gmail.com>,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <d0da648567bc15ccac06d9429b46142e241df1a8.camel@rong.moe>
References: <20261017130652.318778-1-aliamemis@disroot.org>
	 <d0da648567bc15ccac06d9429b46142e241df1a8.camel@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:24:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

On Sun, 2026-10-18 at 02:06 +0800, Rong Zhang wrote:
> Hi Ali,
>=20
> On Sat, 2026-10-17 at 16:06 +0300, Ali Ahmet Memi=C5=9F wrote:
> > On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> > without taking the mutex the battery methods use.  On some Lenovo
> > IdeaPad and Yoga models, the battery _BIX and the ideapad GBMD take the
> > EC mutex and a serialized method in opposite order and deadlock until
> > an AML mutex times out.
> >=20
> > As discussed in [1], add exclusive variants of the AML evaluation
> > helpers and use them for the battery, INT3403 _TMP=C2=A0
> >=20
>=20
> int3403_add() seems to be another call site of INT3403 _TMP, but PATCH 3
> didn't touch it. Is it intended?

If the device is probed through PCI, proc_thermal_add() may be relevant,
too.

Thanks,
Rong

>=20
> > and ideapad methods.
> > Patches 2-4 depend on patch 1.
> >=20
> > Changes in v2:
> > - Merge the follow-up series [2] and drop its EC query and UCSI patches
> >   until they are shown to help
> > - Add acpi_execute_simple_method_exclusive() for _BTP and ideapad
> > - Make the helpers wrappers that take the lock around the existing ones
>=20
> You dropped Hans' R-b from PATCH 1 due to the massive change. The next
> time you do the similar, please add a note to the changelog.
>=20
> > - Join lines up to 100 columns, add a Link: for Suggested-by:
> >=20
> > Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=3DVW4Wi2y1-s+k23b=
pzmX9aAZ0Rsv4z9Q@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/all/20261014190544.150093-1-aliamemis@dis=
root.org/ [2]
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> > v1: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroo=
t.org/
>=20
> The series is now neat to me.
>=20
> With int3403_add() fixed (or explained), for the series:
>=20
>    Reviewed-by: Rong Zhang <i@rong.moe>
>=20
> Thanks,
> Rong
>=20
> >=20
> > Ali Ahmet Memi=C5=9F (4):
> >   ACPI: utils: Add exclusive AML evaluation helpers
> >   ACPI: battery: Evaluate battery methods exclusively
> >   thermal: intel: int340x: Evaluate _TMP exclusively
> >   platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
> >=20
> >  drivers/acpi/battery.c                        | 12 +++---
> >  drivers/acpi/utils.c                          | 41 +++++++++++++++++++
> >  drivers/platform/x86/lenovo/ideapad-laptop.c  | 12 ++++--
> >  .../int340x_thermal/int340x_thermal_zone.c    |  6 ++-
> >  include/acpi/acpi_bus.h                       |  7 ++++
> >  5 files changed, 66 insertions(+), 12 deletions(-)
> >=20
> >=20
> > base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
