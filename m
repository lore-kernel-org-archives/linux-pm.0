Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207755;
	b=1ovZ2dxLAUlfN+ZDMP7VU1N8A46NskQ2iicq1uk4z7LoC84cisOPmQRNBDJ02ScUiQ/X
	 cC2tVKy0oBCW+A6lSHf+UXlWMV/uvPjzKaae0Rgf6R17i/O68PrYCrtowPhpKGQYyUVxX
	 nQzZBqzAnMGtSFQAcTJpD0H+I8rVmLKCal7ZiFBMjZuZ+kU+xs3JEJuxvrcrDDsrFA4pX
	 KDQhMcxRUJW+/SfnOkT9e7lOsSZpv2/lPrK0ntfmg4+C+4yNxbb6k7f+/btWDQTQHlBM1
	 3r5IYVqdKV5Qn0JOjPFOV/kUlZga6WJ6dPLOSHEPRdRp2DSomIfeNiILTfkjgUSOYmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207755;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xSQEaCRwDlS7lJupGsL7gebQF9lCdCLNYFha7Gh39oI=;
	b=1Logu4W+90gc4hDFx4+huZXRdFag9XePK8v32CDQNY8brPxw1qJ0jznjKfievy+4NIEz
	 BuEtuzOn8kPGRR1uInRIbNhuQ3YjJYYXifpDi8VGYCY5ueLoAU0VnC3RyU3uup8kwMrLo
	 dwieCdl7abCUE/XuK1sSJiPP4kTy5vUEt84zmakLMx1v4s9U7V+iuwxapVvSy/ZHha2Pd
	 W3DVsX0osej+DpnzU5d35Npw5o7Fc5Wss09w8dGkrg63y8euElcTgYDBN4xR4wvtwp4O5
	 3eeK3KK7nTlfS6dwbY2H0N/y7W393XVIoxg50evz0aGpG2mYkneplzuO4WcppKv581w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+xP10JQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962ED606A688
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+xP10JQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F53C1F000D1
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207755;
	bh=xSQEaCRwDlS7lJupGsL7gebQF9lCdCLNYFha7Gh39oI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E+xP10JQP3qkuWZO1fXExfi+Xo3QPvCjkFNBByGy9ogY3soevatqYdE6BZk1FSnEv
	 Nhbh0gGB09Vfd9HyEaMgV9c1zkMkoxF7x4j58m8Re5KXASSP2nYOH+B4dsHGEn6i7i
	 xKD2C4VSqsy1Z1gX6UrGi1VDWkY2bmdIENEsoH3pGsT+lxiDMjmJX8iJ1Cz3VDnPgt
	 duV5BOXSFVgmqp87j/7gaxvl82c6sUsziWi2MEfao8nsrNI2vNEWc+uEWMvqPGhVig
	 QqgJJ3iUm+e1sjdcXF0FyaV7swHykwT3MX+J4at7BgVHbZ24GqjOA46G4JaSh/1lQK
	 Wq3VJBONioRJg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be416e603cso992723e87.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 12:49:15 -0800 (PST)
X-Gm-Message-State: APuU4Z++ap2L0CFldGayn6+Vb4Mg8J6ukqufTVpQOnqowMqWjTSFDeZd
	By4bkankitrnuUKcsjD1GDgI0LLtKektd400srNWCIVliI5NcgwpNoHhwByM5kPO4CtXTGBbYis
	Gctr28VkYHlgkGu+VCtcsJUWW8O2n9Aw=
X-Received: by 2002:a05:6512:104f:b0:5bf:a12b:9ba8 with SMTP id
 2adb3069b0e04-5c1bc866a15mr1323284e87.65.1795207753500; Fri, 20 Nov 2026
 12:49:13 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120153039.33744-1-contact@sebastien-wald.fr> <cf4dd030efaa05939904042d211af7b564881ba8.camel@linux.intel.com>
In-Reply-To: <cf4dd030efaa05939904042d211af7b564881ba8.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 21:49:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hh8vfnrXSTVQLMsHJOkeO0zFQMT+cisy8YwArvbyDmgA@mail.gmail.com>
X-Gm-Features: Aa3M54q3YWeTn62T3ciUx6q_mGxa1uQU2GIFnDPscRX-hVh-XSvU2nnkBtkLDu8
Message-ID: <CAJZ5v0hh8vfnrXSTVQLMsHJOkeO0zFQMT+cisy8YwArvbyDmgA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Restore power limits after hibernation
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Sebastien WALD <contact@sebastien-wald.fr>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:36=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2026-11-20 at 16:30 +0100, Sebastien WALD wrote:
> > rapl_pm_callback() saves the package power limits on
> > PM_SUSPEND_PREPARE
> > and restores them on PM_POST_SUSPEND, but does nothing for
> > hibernation.
> >
> > When the system resumes from hibernation, the boot that loads the
> > image
> > goes through the firmware again, which reprograms its default power
> > limits. The values set from user space before hibernating are lost.
> >
> > On an MSI GS76 Stealth 11UH (Core i9-11900H), thermald sets PL1/PL2
> > to
> > 45 W/64 W. After resume from hibernation, PL2 reads 120 W, the
> > firmware
> > default, and stays there; thermald does not re-apply an unchanged
> > target. Suspend-to-RAM is not affected, because of the existing
> > save/restore.
> >
> > Handle PM_HIBERNATION_PREPARE and PM_POST_HIBERNATION in the same way
> > as
> > their suspend counterparts. The saved values live in kernel memory,
> > so
> > they are part of the hibernation image and available when
> > PM_POST_HIBERNATION is delivered after the image has been restored.
> >
> > The problem was analysed, and this change written, with the help of
> > an
> > AI coding assistant (Claude); the analysis was checked against the
> > driver source and against the behaviour of the machine above.
> >
> > Fixes: 52b3672c1354 ("powercap: add suspend and resume mechanism for
> > SOC power limit")
> > Signed-off-by: Sebastien WALD <contact@sebastien-wald.fr>
>
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 7.5 material, thanks!

> > ---
> > Notes (not for the changelog):
> >
> > Reported first to thermald, where Srinivas asked to take it to the
> > kernel:
> > https://github.com/intel/thermal_daemon/issues/621
> >
> > Testing, on 7.3.5 (CachyOS build, clang/ThinLTO):
> >
> > - Without the patch, PL2 of intel-rapl:0 reads 120 W after resume
> > from
> >   hibernation instead of 64 W (observed with thermald running; it
> > does
> >   not re-apply an unchanged target).
> > - With the patch applied to the 7.3.5 driver, built out of tree (no
> >   warnings with W=3D1) and loaded in place of the stock module,
> > thermald
> >   stopped and the limits written by hand:
> >     before hibernation: intel-rapl:0 PL1=3D45 W PL2=3D64 W
> >     after resume:       intel-rapl:0 PL1=3D45 W PL2=3D64 W
> >   The intel-rapl-mmio:0 limits were also unchanged across the cycle.
> > - I have not run a control with the stock module and thermald
> > stopped;
> >   the "without" case above comes from the original thermald report.
> > - checkpatch.pl reports no problem (apart from an unknown commit id,
> >   since it was run outside a kernel tree).
> >
> > The machine runs an ACPI SSDT override for an unrelated firmware bug
> > (\_SB.IETM._OSC references an undefined \_TZ.ETMD) and the out-of-
> > tree
> > nvidia and msi-ec modules, so the kernel is tainted (A, O, E). None
> > of
> > these touches the RAPL MSRs as far as I can tell.
> >
> >  drivers/powercap/intel_rapl_common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index f58649f..eb8c02a 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1878,9 +1878,11 @@ static int rapl_pm_callback(struct
> > notifier_block *nb,
> >  {
> >       switch (mode) {
> >       case PM_SUSPEND_PREPARE:
> > +     case PM_HIBERNATION_PREPARE:
> >               power_limit_state_save();
> >               break;
> >       case PM_POST_SUSPEND:
> > +     case PM_POST_HIBERNATION:
> >               power_limit_state_restore();
> >               break;
> >       }
>
