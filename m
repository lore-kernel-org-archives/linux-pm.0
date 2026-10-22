Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792638269;
	b=TVmb+jsCL7hW/Da0ovECDcwNfsYdL+kC16pPg7yvV5FrJgw+Xb2iroal3um68fw5iLa+
	 dxMgvyYCWrnxbNHNiwV2Gq12HYHwz/gTo2m3QbRhSRylnOz6zJD6Q9R78Mn4c7/oI27CZ
	 6pqzseicH7PcJoPBmtneQnzjoBUxGyag8bBlD7tFmAC5RTGEVX5gyp1sZUII5HX212rad
	 iW1DvDbv2lyS5moflpTEv65EFk3O3PsuJiqnoAOQTQDAcbQRW6ipAEufuGfNUFUymagQ6
	 5a0vcMM58qOUq/xDzgsB+O7mwyTgWMYuSxbMANw3MJpzzh1uEb2y5BxFpJ4rgcRyrgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SGQyhFT+2bVUEMq+UKAq2bulBZGeiIByCybjssa5muk=;
	b=zsArSqi1abCmEwpW/gqAtGyXL2bYuC1uKVae6oGu7cb+WHLBk5afN7XJQVIeFwnEk0Ww
	 LdkabHRf6ZGIjhESXlLICzDh+265YLluno73pBi2HOLcG0lbY3VUOkGEMptnvYDuzZPO/
	 +l1gVwF8ciL0hyetwASfyxBkkA7i/gwLsrm52dGY42p7muyoA6Y/q/6+eEmQVlEidVeKD
	 f52iF5QGJI8kS2RKaOGOjJfb9GX9/HFRPj9dEGBUFYpE8uUsbCSWEqoCmBtpYxu5+RFKj
	 vLzXtInkn6K8UcI+lVsIl1tGlFEmUBa/1TZEKhA3/FtqLMrPfyXHS5xn1U5ICvsARAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pGhDqs17;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E7606A31B
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 03:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 155E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pGhDqs17
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c40b9a88a5dso52011766b.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 20:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792638266; cv=none;
        d=google.com; s=arc-20260327;
        b=ERZyce5vmNgIfFKILKVwgTPawi9lufM+OGspSj8p0eDn4AYN9ZLkkhK6neQTL6Ns+d
         RBixXvGyprUlH3DvVtY01mfVqng58onrcHPs5AD9a9dP8H7NAzY+rCStV/myiXtAY9s7
         xQNVjQBUWiZcLgbwv9PX5q6cAyAF7D6bi8vIn2+x19N0XWb898m6o8hczu3+tWFR7V+p
         dtMxMlgN7HJTVMfFna6CSYVHlQmMvCYYvEGBR+PpPdpAKxccrJ1ngJgxM1zuzpdzeEsf
         1DDK5XHMopzJGVC7MMrHKL/uulVe9dus1h5icr4o9OTx9arZDFBbIa4zB7lMEPmKcuPM
         MBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGQyhFT+2bVUEMq+UKAq2bulBZGeiIByCybjssa5muk=;
        fh=xMnzjVsq4zpWPcgRXhmtK96z1zVRcSvkYonuIM1WWU0=;
        b=OmR6hwwi5JWOKX/OH0YMsMg8Co/1VbtRHLbznpWPpyanEbgCrGrKmBaq1+w9wDtNy8
         dEACaEmGLYRI8cGiBdl0Zq6caVPxvlSNBv1NZSKCRajIT7vtdW8dszezYC4CRWAy1tIG
         WZW3oCJo76l2vspPJAqSWDvw4z/Sy4nA2xnlGl1ovtWpI0WAEEPwCnn6iZmCSAx7d32L
         Xo9xjj0U6ngi49wgS9LXF1uyjLBUJJ0199LQ0UJwvzUP9UkjmOE7NdtfAPrYLz17gvDE
         fOQ71b3fgx7Zg93Fdw855rtva5XGoB/72We//kUVmKVltDYyRGeW+LM3FHuL3rW6Xcnk
         m4JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792638266; x=1793243066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SGQyhFT+2bVUEMq+UKAq2bulBZGeiIByCybjssa5muk=;
        b=pGhDqs17YyutJ0+vUrBt/NtkAuagconfNCFI4qfR3kW/ZxrLgzrKVBPf4YzzqOP51s
         D6UB+FxOsPPrDSulVI9h34YSLO03eRuJQmYOYh0qNGOUz5nS43xMcAih9Wvu7967N151
         f1unKzznZ4NJnBAOJlcijaxfMAkuK0cTz1bUt58eRUDqi55PW55R3dgyB1SEFWwWMlK7
         C7Y0UpfRHgOdBTCqgnKesB+86XMNBR9JX84IGbalGRE5x5SA77NKYyYloX9lIdiTVcj0
         Rx0f07MK+ePUekKWyEhrkW/3VpeUeu8ojdFB1Kpimxging53gkN0daY7cvpCqIF4C3oM
         bQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792638266; x=1793243066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGQyhFT+2bVUEMq+UKAq2bulBZGeiIByCybjssa5muk=;
        b=RsnqmQiuP1OEIna35S3GF38W4gCJIl6mQJ9TCcN/eU0C/wYEQmTVeJXDxT03Bj9qaH
         9sH4kJ9XN5rhW3zPMFAga0RQj1oFx0jrWm3FfivSjEj5SrgJcCiDBRMeY7tNT+xAkqiB
         ZuSMat8U7rRaAZsD6Fa2LnmUBRcOIW2gItJ3GAxqEKYByys613QJIDEBcv5wskoLOkxJ
         pbDPUMg25m4mUpfxCWEPpRW0gb4muUqcqio6/yvccmPc589i+YKF+O+jH1Js8+p5z4r+
         lz4Z4lp7BLhtWx7tFlP+grd2jMD5KAJ5JjRLiGJlo+cMEQiFgowXVC7UdtX3W0Wu0MDw
         3mNg==
X-Forwarded-Encrypted: i=1; AKwUvBxE7rXOmZU71Fm65wEPA2m/R6CeRzsX4JVwrv/yWSctg6femghgApxPtR5HeAsDcNDN0bSWGkkdVg==@vger.kernel.org
X-Gm-Message-State: AFq9FYImsLMGPFKMmx2obeuDFEpmiTZBjONc4wRNOpxLRvw4SFtBHoki
	NY1uBtQTSvq96qWDisyqDqyj1CuRhWWL69SliidffncS0ezl2QoEMOG+kflwjginQ6Ps6XexoUw
	b7hOgLUz6fcamjlHDPx6R5fBo3TkRDjQ=
X-Gm-Gg: AYBFou2HD/903ruDsIHo4S3dKtkwEdO8+vR4o8Sff9Mdic2PvVMkGdxb61VoaY8i/5D
	aes6I88nFLOJFqVYin94tVRv84QYWwuWRxYP88JlmAPkktKFhwvPXwneX9zZTCxaa4OgppR+Yd3
	M7giPTXp5ohu6U2Vmncrs4OO4pOiyufHs3hSKtnSPt05gnD1btz3TMnvZP7ohe1O9DxHWgl8C/+
	aQFD/RlW8MqP1+aHqM8Xfo+LFYW+3eU4ipYxShvn7pVqb9caNGu54i+n2xBd1kQNnHvL+dVRyNx
	TMlkodlzcz0dEZYYg9cDAeMhL+mqHIislo0fan1a+UvW+C4oUBddaqsa3E8UG104XGRPxHwUZHo
	DG/SBrff5TgVjdOMLOBJgFxRE8JpUVA+2mOvI2eS6
X-Received: by 2002:a17:906:7954:b0:c2e:3f49:df04 with SMTP id
 a640c23a62f3a-c46791a9854mr357604066b.1.1792638266169; Wed, 21 Oct 2026
 20:04:26 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925041751.495818-1-coiaprant@gmail.com> <382B43FA-B225-41C5-80B6-944D9D2802CF@gmail.com>
In-Reply-To: <382B43FA-B225-41C5-80B6-944D9D2802CF@gmail.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 22 Oct 2026 11:04:13 +0800
X-Gm-Features: AclHuK-x9tgKioE3zW95rXaMi6_YZtM8cmcvfk6VmaCJ91IvPzsI4d9vJZ8M2Yw
Message-ID: <CALj3r0jMLFbz+oa_z6kySDg-3aLaFWtFoKv9VB_qHhQZDpemfw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: mark PD_PIPE as active wakeup on RK3568
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Coia Prant <coiaprant@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C 07:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On September 25, 2026 12:17:51 PM GMT+08:00, Coia Prant <coiaprant@gmail.=
com> wrote:
> >The PD_PIPE power domain on RK3568 hosts the XPCS, the PCIe
> >controllers and the SATA controllers.  All of them can act as
> >wakeup sources for the system:
> >
> >  - the XPCS for MAC WoL, through the SGMII link
> >  - the PCIe controllers for PME#
> >  - the SATA controllers for hotplug wake
> >
> >The domain is registered with active_wakeup =3D false, so genpd powers
> >it down during system suspend even when a consumer is on the wakeup
> >path.  That kills the XPCS and the SerDes, which breaks MAC WoL on
> >RK3568 SGMII boards, and it also powers down the PCIe and SATA
> >controllers while their drivers still expect the link to be alive.
> >
> >Mark PD_PIPE as active_wakeup so that genpd honours the wakeup path
> >of its consumers.  Consumers that call device_set_wakeup_path() keep
> >the domain powered; consumers that do not mark themselves as wakeup
> >sources are unaffected and the domain is still powered down when
> >nothing needs it.
> >
> >Several other Rockchip SoCs already mark their PCIe and USB power
> >domains as active wakeup, for example RK3588's pcie and usb domains
> >and RK3576's usb domain.  PD_PIPE hosts the same kind of
> >wakeup-capable controllers on RK3568, so this follows the same
> >pattern.
> >
> >Signed-off-by: Coia Prant <coiaprant@gmail.com>

Hi Ulf,

Gentle ping on this patch. It was sent on Sep 25 and Patchwork shows it
as "Handled Elsewhere", but I can't find it merged in linux-pm,
linux-rockchip, linux-next or mainline, and I haven't received any
review feedback.

Since then, the XPCS driver and DTS that depend on PD_PIPE staying
powered across suspend have been merged and sent upstream:

- XPCS driver in net-next: https://git.kernel.org/netdev/net-next/c/5e91edf=
b0e45

Could you let me know which tree this should go through, or whether it
was already picked somewhere? If it needs to be routed differently, I'm
happy to resend it.

Thanks,
Coia
