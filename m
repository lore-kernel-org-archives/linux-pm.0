Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794895390;
	b=BWsXlbAZS1MkPqksJ0teoc7C4/SigxUik71eMdN/uh+Dx6N/ZFRhUnxIPzLcvi8gJ3Db
	 OIuH3BiKGeJcEi5379VOcdfOpYMgLEP16vZgJxNLq7IQhJFsKtyG6iu86aPMEatkrvmTt
	 ohNqGaRwvdmjUGRzuJ93z8wj/sGFME+ZbeK/N8HQzZS23T5y5wmbgmLx/5lLJDxyYu2/W
	 k+HIsZaNqLPSU5IMapgUeZuf+qQFI0TNMHy/LqTECV+cGZ9fcFxxi61rNtbUwLmoOf7Cy
	 yY7/M4/GSEzMZMufkUFc6ONnyO4nMmdjQSfIJ2MVO3Aw3Hzs3zBwqC/xOsnlLl/hIkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rtMskDO3xi7yMmOKnTt+SllqsYFoqqAzPkEoXmAxvXU=;
	b=f3aACBxbQJPjIiVjWuUgIiO1AkhKGEUoD8kg42baUJjHk9FupXH6OTi3uguLF0z6He3Q
	 PbkE1c31DLYNFzhoerP8RgLGe02hx1Ta80b8O/g9JgZ9JUI+Nj8ey7Q9Jk0U5wlbmCYJ5
	 9Z2YmOz2Az1hY6weJVMVAa8IzNRJXCJV4FeMq13kM4y4NV/67i2wS84/yWnec8jYuMmyX
	 xcIU7SseGkZD2Xm82eLkISem9jJmxPAQeslHMBwOuhkWiLi9uH0nLt4cRF31dQoTP2OtX
	 QbjQTbODwjm6e2RjdtL7qZ1AUxLFri/0bRbBzLVbgrIN+hBaYGJrAXc+MLCY9PdY7mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxu+q6fg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036A606A335
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A036A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxu+q6fg
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37198ed3727so670024eec.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:03:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794895389; cv=none;
        d=google.com; s=arc-20260327;
        b=OClTKmy8xAV2gxFiutZOJcNVXjCLr19EbVkHXgkO06hAo9RngpIVaGxpd15e4Z1V+r
         hKbsR1V/a+P6a3ib/7c8o3ps1yrzLV+sdjLdh7r/PMH1cwA2IBx8mD/ae2Qsw3Vy4/a/
         qxmLf0Y74N0VGGXx3riKob1e/ZQZXzKTiWG6tzAkhzSDIREX1m662QUJYMNUhyWHNV5Z
         iHmfGT9w8NFcWiXLx95bLtnt2I1SrwEToVlvpgYMb3HXam+C3ahY7mrKcLLQh/0ONifN
         HULwrSwCIi3M/xgny0cxK1ASiMJYRKBJe8oWrSksA5x4vGNIEitXfp8MeR27WjkI5fvj
         c8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rtMskDO3xi7yMmOKnTt+SllqsYFoqqAzPkEoXmAxvXU=;
        fh=vuv/rEXzaU/+mD9c0Fyjgi9rtCnB8yT1AJHY+rSOoCY=;
        b=jpV7m+h8/WCm0FYMrsV9IUtsIm0ljSRweDPEc0294gIonTCACI722888NvAqh70kex
         93DbCO3KX/Gk/ga0OnoYge8RdoNtzwn/JOMkNNYirkfsNDATrmk95nPy/c/jykd+xp/+
         ZtQUhmPpPnq3mXAQ1Ls3L0gvhTTQ+0VB3fLp3yb/bkWCCycKbL7gNIyLKE1FHaDdrV2Y
         CW6e81FfOB9XWiwBNXeO6T48PvEkzBL3e5rIGhvbTDcLFASczgx8+cxJ/OidCzUWhIMB
         2gt70w+eHnm5S5tlNGGCXPuOw83EQcIB9koYqQXI0PHcG9Vc6Za5lDuaCxu25O5uGQg9
         Iu0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895389; x=1795500189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rtMskDO3xi7yMmOKnTt+SllqsYFoqqAzPkEoXmAxvXU=;
        b=oxu+q6fgYWKxtHBHw8FvEpHrsqniQ8qJPoMRxryaL1MyrshMDryi758XSD277qDFDE
         6kQJ62qwIpdHfvwgQr8spoC/AFhwSMpfV9+iai3aUx0ROe87N+mIP3itcLpT80NDIawR
         jOjqE9ASRmOMDoROtB6AtMQBEIMtUDZIF0lpBpu1/MewronKUFiRIT3diqzTzylgYFC9
         pSHDQiLA9c/GONdGiNyXINVd26D3Bf2nK3FWnLoFMIjF+MR7LT8lMGuXmknfD8WCi9fR
         CygUu8XtbTumvS3Bvez5qc4mmqosPXuR8SsKIcokDd/8fXeaslqx7tFkFeBvjhRh4cvA
         AX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895389; x=1795500189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtMskDO3xi7yMmOKnTt+SllqsYFoqqAzPkEoXmAxvXU=;
        b=dJY85QCLNXgvCqki4sZ0kdd/MNGm2umuxDV+ZN24nE1T04YD0xV9NocP7u+MbZxKbU
         MrZ8eadsvq2kCXLuaGD3Kjn4t7JW3STM1KPR0d6ifjnNMelQ88wMxn99h3jon/53YKwb
         K6zE5+JC0XRvhQrYdK1wCTWF+a3T0ID5C2Z6GHW9TIrjJ+VbmxFEglRr47N6uCbBhP1V
         St0UN0D2hG4qX1oM9L8r1g8D6xwGtJN58/lCjeE1lgDOH9UP5/xLv7rj7tpIzNXviWKi
         CWtEuqEwsck/wLgg0n6/Nr7jRfhvi8McWIU8kzGUMPdgdu0Ld4o0wSR6HGbHI72TP5tV
         8Ojg==
X-Forwarded-Encrypted: i=1; AL+hErEKrQDvkiXX3Vvc0xwJWUgyTSdl4iPz3YxSGjbgFkPZcIA29N1tgnbTyVGHErV67pfzft7jGEmJcw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ecZIHF41talM46xBjK7MvexTe6zqn6i8tX1fKVe4t6Z9e2g3l
	5otAxBULmIlDIgZHDaXM/YtnJU9CbNlt8yg5/sMiJq3n/1gaMkMvP6pUuYhJGVP3RTpj7zNtkrP
	srzXGCWQ8VBrIdGbQUbNw+xSItHosaPo=
X-Gm-Gg: AYBFou2jDlc4D9GQ8cIzjZcAGAa6nGx6nqRZlOKHC6q8kQgL4ANHKqumdGMlQeHzw8B
	C0tRIujZJlufKlHLuTWzReKBbbz1vlVloe99Iy9N9wFyQc48mmZw9P6zY5Fu/QVM7xTDXelNwFX
	HBxEsiy+0Puja9zTnptzwL6I93aj+FM6sWw7KiMKDNRUhLl5app3bZez0fOILZWSXwmKUFNgH6t
	IIV3XmxqJWOd+wtOXs53npntBenL2sPjqncgdvNtDiBU4gHEY9p3qbK9iqlQQ5O4Ly6eqLo8uCG
	V61xq9oGzxIihPIJk9UF+fo7ReTY3si5B4mKXKSo240nX6l9IQhAi4IRFU21Joj5c/OBy03SURl
	nwX+OaMEXGfbHozyus2/AmJ6e1hPzxSn3fwaK0G8=
X-Received: by 2002:a05:701b:4586:20b0:1ab:cbd0:1c96 with SMTP id
 a92af1059eb24-1b53a429876mr1337313c88.4.1794895388323; Mon, 16 Nov 2026
 22:03:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-2-9ce2133c5659@gmail.com> <CAPx+jO-qPAuOGnGfCyGnSYym8PBOaqUJptZh8duYJKZN4HARaw@mail.gmail.com>
In-Reply-To: <CAPx+jO-qPAuOGnGfCyGnSYym8PBOaqUJptZh8duYJKZN4HARaw@mail.gmail.com>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Tue, 17 Nov 2026 13:02:52 +0700
X-Gm-Features: AclHuK9yy_ki_wzibjw_yQRrzFByvuyKJxJWKjlXJNrv02S4I5fFrI_oRWpsa90
Message-ID: <CAAq9HC6kCspxX8DyDXp2RuhFSXmU=1p0s6xdOmjhGZ9gZgmj=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] cpuidle: psci: Allow skipping the suspend mode switch
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:14=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Thu, Oct 22, 2026 at 11:41=E2=80=AFAM Reza Kurniawan <imkyufie@gmail.c=
om> wrote:
> >
> > From: Alejandro Tafalla <atafalla@dnyon.com>
> >
> > On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI reports that OSI
> > mode is supported but rejects any PSCI_SET_SUSPEND_MODE call with
> > NOT_SUPPORTED. psci_set_osi_mode() then fails with -EOPNOTSUPP and the
> > probe is aborted:
> >
> >   psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain faile=
d
> >   with error -95
> >
> > Add support for the "skip-suspend-mode-switch" property. When present,
> > do not call psci_set_osi_mode() and continue with the topology that was
> > already built.
> >
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > [Reza Kurniawan: split out the patch, added log message for skip case, =
renamed
> >  the property, added property check at PSCI initialization]
> > Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
> > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 16 ++++++++++------
> >  drivers/firmware/psci/psci.c          |  6 ++++--
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cp=
uidle-psci-domain.c
> > index 5722365b94..cc9f14769b 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -159,13 +159,17 @@ static int psci_cpuidle_domain_probe(struct platf=
orm_device *pdev)
> >         if (ret)
> >                 goto remove_pd;
> >
> > -       /* let's try to enable OSI. */
> > -       ret =3D psci_set_osi_mode(use_osi);
> > -       if (ret)
> > -               goto remove_pd;
> > +       if (of_property_read_bool(np, "skip-suspend-mode-switch")) {
>
> Rather than reading this property here and in the psci fw driver, I
> suggest we just do this in the fw driver.
>
> In other words, let's make psci_set_osi_mode() to succeed when
> "skip-suspend-mode-switch" is set.

Right, that makes a lot more sense. Thank you.

Best regards,
Reza
