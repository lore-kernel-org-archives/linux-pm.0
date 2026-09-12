Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C747A0AB
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220167; cv=none; b=NeCQStJYZNqgET6OP0KrdqqJxW6CUe75BSX+/Z+Fy9WagNqSy9l07gZoTmdniqjEBABTa7CpVSCkfDltMIQ/CSyAgk+mHtd9ZQ8ens8hCtaa+YitCNr5N1baYjdHe2SAJqVtnkHJRnoZF7ZvSikSDYc9bl190vLFOUy074R6GlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220167; c=relaxed/simple;
	bh=jDJyxuQSJq7yMmcZQK0ZnQpYDqlPQN9BTFZbhDw07n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f03OzqJW309cFm1teOLJTrma1YNWfJkSrm50lU3bUZN0MpudQKXe40jw9/vy2UIHkKiKAWGNw4WZa+Ll86xj4A/jaL1i9NzBwiN8w23Fq/hongG1RTekbhrE0HCywQKNsi23ME+J1Byz0LVyncrt+QsNAXbd2VEsRINy4gwYNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqsiSjTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqsiSjTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237C91F00899
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789220166;
	bh=VIOMCRGrgf499RUPLB6ulTo6LJeLoQVad4u4CeQkZ10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EqsiSjTlJhtLWKCveTl9m96RwH2jOXg3RVcoDhG9wC9OpZZ363RaF3Ju72aBLbLNT
	 b5yYGyGiw5rQDxHf0iB4sgRiUO3qc1jT/twqCbbn/utSeW85XTO04m3H2aqonPPtd2
	 OBg4oVQ1CVi6tgFEJFxGD00vln2I0B3w/utnSWPNLj2Nhz065y+7k4KZCn/IXcArG4
	 oubxtcccZvLt/K/UodEtH0AdYEnBfS8J2jQdxcG0NXvGCOqql9u9Zn3C5QfF5OToYM
	 /3a9Ue+5VfSDs2j116UKffP0t3Xxb4kTc9GT3rcKCvLae7Z+4b4MqgPBZxleaAa4Hm
	 HaqdjEruthwIg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a318299b93so3823761fa.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 06:36:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLZDWDOsrDhpDrTEWbFp9MbHF2kM2EqNZQuvnzZjNAFSicJDZYP+7K/kMZCuuhfAt//ceBSA6Ndg==@vger.kernel.org
X-Gm-Message-State: AFuF++mHdrbWIPO0Js2+K4HzFhqz4TclZR5OyiJnSp8RfHXVO3LOYZCH
	AV+rEOshaBnbztFaxiI0EtIo5jLeX3YWvGS8X0DGO0NkIv0p4xzSPMFtvdm3m9S48e+IOdOsL6z
	XmPMCKqcNq5y0faqIWegDEF/LFYN/Th4=
X-Received: by 2002:a05:6512:3d0e:b0:5b7:6733:a216 with SMTP id
 2adb3069b0e04-5b8a8ebe48amr537213e87.10.1789220164432; Sat, 12 Sep 2026
 06:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <951189ad-71b6-4776-8484-a207f1efe415@gmx.de>
In-Reply-To: <951189ad-71b6-4776-8484-a207f1efe415@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sat, 12 Sep 2026 15:34:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gLWT4x44Vbruaf0cKWp0jPTkLuh0pLQ29_O5vfNC4q_A@mail.gmail.com>
X-Gm-Features: AcwNN1XLJyxVvs6LDrF1qngxz3f1oAUIQeurZ_7Ko4NDINm0cOQRh3m_J7CRT5Q
Message-ID: <CAJZ5v0gLWT4x44Vbruaf0cKWp0jPTkLuh0pLQ29_O5vfNC4q_A@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] ACPI: thermal: Register thermal class cooling
 devices under parents
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:35=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 11.09.26 um 15:00 schrieb Rafael J. Wysocki:
>
> > Hi All,
> >
> > This series generally changes the way in which thermal class cooling de=
vices
> > are used by ACPI device drivers registering them (ACPI processor, ACPI =
fan,
> > and ACPI video) and by the ACPI thermal zone device driver.
> >
> > First, it causes the thermal class cooling devices to be registered und=
er
> > parents in specific locations within the device hierarchy which allows
> > their relationships with other devices to be recognized more easily.  I=
t
> > also drops custom sysfs attributes registered by the users of the therm=
al
> > class cooling devices because they are not particularly useful any more
> > when those devices get proper parents.
> >
> > Second, it modifies the ACPI thermal zone device driver to use thermal =
class
> > cooling device parent information for binding cooling devices to trip p=
oints
> > in thermal zones, which was previously done with the help of the devdat=
a
> > pointers of the cooling devices and effectively prevented drivers from =
using
> > the devdata pointers for their own purposes as originally intended.
> >
> > Finally, it updates the ACPI processor and ACPI fan drivers to use the
> > devdata pointers of thermal class cooling devices in a bit more efficie=
nt
> > way.
> >
> > The first two patches in the series are preliminary fixes preventing
> > Sashiko from reporting "pre-existing issues" in the subsequent patches.
> >
> > The third patch is a thermal core update allowing thermal class cooling
> > devices to be registered under proper parents.
> >
> > The other patches update the ACPI processor, ACPI video, and ACPI fan
> > drivers as per the above.
> >
> > The details are covered by individual patch changelogs.
> >
> > Thanks!
>
> Nice patch series, it looks mostly good to me.

Thanks!

> Do you plan something similar for thermal zones?

I do overall, but that is a bit harder due to the hwmon involvement.
