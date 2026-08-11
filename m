Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8D13B5B3
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413748; cv=pass; b=pclKnYzAH2kHzoZB/THbPK4YHLaiy8YkxG0FpQaseozFriV6loXDVQgGsL2jAz3WMewzSMGCfOXTnN4sCoFceTV6yp1D3R/GHkhsZntgRGGObfxi2PKIC/NF+Fn8aZWNwi+Rc26Lo3+M98MrwMBbAxYeWH2lbGbS8MNny/pdZBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413748; c=relaxed/simple;
	bh=y3aVQsDghQY2kqVVbN7I258OZu2z/52XifB3SugTRdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQPyMnn1zvGdxqVb3SFQ2xWKavJHzSHW7nBpu3bL+vKdaThVqHwai/CSkS7klG1/+2pGGzMK7oeXXI+/a3pUUee3aCmvFqalOx/SQTcq6lxiW6FU+JX5Ozf8YWnW2n90ri6uuAkKOIBFWr1ih9dNhf6zStVKsQCebsDdO0TpRfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3mfgHk1; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3mfgHk1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceaf8a1265so39480685ad.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 19:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786413747; cv=none;
        d=google.com; s=arc-20260327;
        b=j3/qJGtglHERqlAjDU5bS/bHllyXl/TQixTtZZSqUCHFZIQBnHFXD+aosMKqu4v7a5
         S0gUcTehzC9H1/U1CAzGQlg1y/Wr5+p4ot3rHbVmTsi2mvWcn8H2pQmF5MtT5NuCm7Ef
         Xuowv8LNoz9+FeiFplEIokDbvkTlcNz/52EMpTG8L8Vg+zai3y9wyRP8bBOJ7H1mmpVa
         cxEC03lg9EXJBTNd/y3KzxlbPDATfcd5ZsbtxLZ+KLEq80Xzqtejcg6vxnHs3o/vEfEp
         fvLc+eyiV6Yz60wtPfkf+oiGpm0SSOr24Z/0TR05BmMhcyp/PhXKLtP8tyHfiII4M+CD
         7waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J2ie5zT76vulUOKxlmSFoYHsSNdJQnoxvireTA5JYWQ=;
        fh=pJxoa9M6OPf4tD46wJSgV5uYQTrYg3leBow+D8unOIY=;
        b=kn1Va1qtvN7uOndlc8dT/W8T+FHoEAjCekSxzd9XM0kAMF1ZZtzXBCbnE4fCQmhyBE
         QtjJeBZv/8/wx0UJmUy2XL/XhrIggaG1W7rA5mtXYV0W+JCh8X4GHeTkerqEc+WXHQhI
         Bx9dWdyHRlqwtihY0coJ0M4RM03uQMhC0LtuIwaFlaYuXU53vyg3UIxy8ZDNq7rFJrgI
         UYkz6aBZsar21Ec3QQeMiI2ubivu0OStxKAIS9dn2jfc9UxGDiJmz1krkZgNdnuuD4eK
         cfOImxuj7bPZ70nyj53CaByhdB1KmS4kGCmkNrVhmIUE8y7J6zsCUvbnhSAUP9jyJPtC
         ocSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786413747; x=1787018547; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2ie5zT76vulUOKxlmSFoYHsSNdJQnoxvireTA5JYWQ=;
        b=H3mfgHk1kgvpefkMHqf4k0LnFohv7CSurXLeguDo834vFao2sTp7B/NPAqY171A8jY
         A/A4qF6cmhzBRAKjDF2RQlF24cPdkY+pagC6M1DdUrT+FcPFbGsYe9c8HY23mN/FeAFN
         F6UHQtYqmCE1G3NIQ+gM2B7DC8a7N5Jrh3LiFlkzEJhaJ2SpDPR0VUSHhtgPqgwS0Esx
         CVZrc27x8GbqV36D5n0QtowHYaaH7JhDUCv72cmmo7lub+hlaAee6K4cLVwGdD+e5KqK
         r+DM2/sg9BrE3aSoM+gdHsnwbeSAWV11y+OFtkdobdOP82R9QM+njUuY+qvZxE0oc2D9
         Pdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786413747; x=1787018547;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J2ie5zT76vulUOKxlmSFoYHsSNdJQnoxvireTA5JYWQ=;
        b=SaJTSuJuyk6/xZc/uP6FPgGRtHZ/U7g6NQRYe664No38H3wSyZrzYRlbHaIIVYOjmm
         oe9fHfapG8zQP576UeG4WsG3WGHoWMD1I86nbMkVas+ZqqYB+bBhsSOCoqqxgG2wox/p
         aLu2krlftMLV8nCweeoUyBW0N5YML/f18UqpZozx+ZPSvYmdSpo1CTXuEOfuMylrE6xS
         SOYm3sTqBx51fRSm7fuZXw++qrRZrIOvPHHw/1tek+QoVillrpuUF21IfBfVu3pv+YKB
         MFuyub1aolvyYrOTLvItyFx7qr/cvES4bCxNFqzpaq0tqlxX2h5QV6MmOvl0zZndlY/K
         aLgQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEcfKIZRs3NuUg2fNqR3MzxLwkXoJFuE+i9bY/BmJ1Xd6On760NxYAis/rZF+FHbs50QOVqh1NBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyydTkVXdohkLfFx7r9Rjb7M55D9oTy/JoIGJ/ykMWpuRuXHBcx
	WvF1CN1/8yIeLreUyTlgqxyl0EJ5d70WD2ZZDBdmCsnTs9xzbZC0UFduKIrExChqfEwjfv8ignh
	kc1DSaobP34YrLRkleysg7bj+O2z7Xfk=
X-Gm-Gg: AR+sD13Q2/R/3hVaFaR3QA0hwXHEP97Urog71ZexIWMDAyioPPHCLTIFjUR7jsO4Z4e
	IEbyHB9JUgXrrQZf6msxf8makqsNvZwylFICDVuLPPn0msxLaZxSzGA1ZTiU5jwNnMbQEU1AJ4N
	EQKlnPQ790SI3fgRmeEzMNAZcrf0fb8iX3uVH39y/D0c4/MzOHulzg62mM+LvPZSMUhmTaoTXce
	MfGM6D+hWWgnOlAMnipG18Q9lAx+/V5YU1KG80aPcQNdUXiwgMGQ/A9haBRsVjs+6nJ8PxRXYeu
	gzg0f8SGx1FurrecMheIZhk5e6cclE1cAh5EV/OcuKoLVW10Vsd+4GYVDHttjr1ez8rdM5zruWI
	KjjY64Z2gRMT0R+T6pj+mMcz9Qnvzs8P7Gr2BVtxDf01qC2i/USYzHU4m
X-Received: by 2002:a17:903:3201:b0:2ca:481:de45 with SMTP id
 d9443c01a7336-2d3177d887fmr819395ad.6.1786413746763; Mon, 10 Aug 2026
 19:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810111841.77898-1-phucduc.bui@gmail.com> <20260810121914.GA2757863@ragnatech.se>
In-Reply-To: <20260810121914.GA2757863@ragnatech.se>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 11 Aug 2026 09:02:15 +0700
X-Gm-Features: AUfX_mx0gm4Mq6CMcIZ_Ee9wYl18KOH9W6eWXEblgpbB3dv-eRX3URinfX2ag78
Message-ID: <CAABR9nFkFyhzQO7UGsaiSDcZ8km9=nv-2+4xWo40EG6c555Lbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

Thank you for your feedback.

> > -     if (rcar_gen3_thermal_request_irqs(priv, pdev))
> > +     ret = rcar_gen3_thermal_request_irqs(priv, pdev);
> > +     if (ret == -ENXIO)
> >               priv->ops.set_trips = NULL;
> > +     else if (ret)
> > +             return ret;
>
> I'm not sure I like this.
>
> The old behavior is that for any reason we can't get the optional IRQ
> the driver still works, but without hardware trip points.
>

Regarding the old behavior, it was handled like this:
------------------------------
irq = platform_get_irq_optional(pdev, i);
        if (irq < 0)
                return irq;
------------------------------
As I understand it, this is essentially the behavior of
platform_get_irq() itself:

https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/base/platform.c#L301

This could be understood as rcar-gen3 not actually supporting an optional IRQ.
If you still want to keep the old behavior, then I think we should switch to
platform_get_irq() instead of platform_get_irq_optional(), since using
the latter
could give a misleading impression that rcar-gen3 supports an optional IRQ.

Incidentally, I also don't quite understand why rcar-gen2 supports an
optional IRQ
while rcar-gen3 does not. Is there a hardware limitation on rcar-gen3
that requires
the IRQ to be present, or is this just a difference in the driver
implementation?

https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/thermal/renesas/rcar_thermal.c#L422

> While the new behavior is that if *something* other then the IRQ not
> being available we fail probe. What is the gain here? What benefit is
> there from the driver not providing thermal readouts if say for example
> getting the optional IRQ would return -EINVAL ?
>

Regarding the benefit of the new behavior:

If rcar-gen3 actually supports an optional IRQ, I think the benefit is
that it reflects
the actual state of the system. It allows the developer to know that
something went
wrong and investigate or fix the underlying issue. In the case of
`-EPROBE_DEFER`,
the benefit is even clearer, as it allows the kernel to defer the
probe and retry it later
when the dependency becomes available.

If we silently ignore the error as we do currently, the driver may
still be able to provide
thermal information as you mentioned. However, can we still guarantee
the correctness
and safety of the system?

Best regards,
Phuc
