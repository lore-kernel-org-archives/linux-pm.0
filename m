Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6F41DE08
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097518; cv=pass; b=FXfBfUob+xid/7qEvah54oXdHcsNPaCzLtJVokFZF5hAnJpJKtvIJKjnC742bI1+Eu1yD7WJRRKvbk77+QUMK0lvSyXmJNPsuo3yFWEKsgstVL4cEewyPL5beWDTYkCBZQuEcTGATAs/6PH8ZQ5ORefnUHhRIniU+b6L5aniGGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097518; c=relaxed/simple;
	bh=LYtR3cATtrhaKdCXad9h6EF4UUKN0gTzzGTF5dGZBeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FK1sVx+0oZvoBUyDZvTlv3NHjW/3T8vRaC4+PWcVQR4DMAVRGx742pDKXyzbCGoqDBrPwscTFnm1+jbPeOjV09FYWlkwrD1J4NtXs7h8eiGHCKT1m1lIuf/sttR+NTiya1VIiT3njEj+nUXIVgrbdHykJ/QSu7W7mvBSE8jCN8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHl09hA6; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHl09hA6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceaf8a1265so46888835ad.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 03:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786097516; cv=none;
        d=google.com; s=arc-20260327;
        b=SA9K1CFHdstOrIewT6/0v9AnN9ogiDPMIZ4p6pqbRUaZ6f2sAuvTAsKU6N9GwVwVOw
         VMK0u0aEKy5zpd3l44i9vsmHVbMDFhUDcDWH0uskSnzYDPG9ORzDSW7egpTxXlkmeZww
         IanLI1CubxyBJxHw5IOrYjE4ALJRErg7Va6nkfXsfiOVgc+daPIH887hbWVXhZkQz0IP
         yQsMm3dFwF8uBOXYDqKEb5E1JII/QJwOuTwzlM4CTl9ADFTFLw/ib2W9GKz4NmbTP7c4
         THBhXf9e+v7fExj0QviFxwEZc1MA0KvAKGODWsVsaBiW0LM3Ub8Es+IEcWobhS2BQQvr
         s4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gRsC4nvT6Z/jvHUPDRb5W5WWvK9c6aIP6vBj3rnYfTc=;
        fh=rBrzSaiuMKU9DOlr/3+wPBDCX23VG/WQXun5qvNlJdE=;
        b=YkG9nHHy6DONtFbNDEPQPgGJ6SIAQdPacH/TkzjU6vO3cRJaPmHtBxHVpp55dvas5Y
         E19yqoy7zbdZFWR4AoWYPwg0xXiZTpBnSu7YonECur+k5hMUnA6HrDnoL3stFxwg+qRD
         3oliYQj1yb2B43eLVIeKXnBnsFlVnXb0688zmtCNHM2Cz426s61s4Sn1SzmEqIrlFdSt
         LIriNfmFAv9vDKH9RCBNZ5mpLHuz6auSYlfdfuP2rUNQ5byuEkvrfnNIFGez0rsQ6sKh
         j9QoWEU+PTiEpuAgaQKPZp8C5Tctl2ynupd2370pkqyjedCYhAqLnh47mgU3tsxN4Jq3
         P1bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097516; x=1786702316; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRsC4nvT6Z/jvHUPDRb5W5WWvK9c6aIP6vBj3rnYfTc=;
        b=kHl09hA69BOi9OCrx5SGLQ6HCDhoe8SpT/RknkyCHZbZyiS2BhTHk6yKLBehEj6h+8
         JJLPh4XXibIL6KwpqQdFEqrjgVf3sBsqXiL8toR7T7n1AtbQnH7HbS33d48No9dkVqV9
         zKe2qNM9FUsK1lnRAHdu34GobxYiesHeo4wDnDVpc0o+jqF4ttIIKrkQz05J1YD39gYS
         AGwBqRPegwDnEivMAZYnZv5+mjP/3/IdfANq/Rc/jr6/orfxt6StB4CKgGw9HTWKz9aq
         CCUDXhTc1ejcTBireY/yY08UBXxZjpl7xh89/lHSanaDwoJt6qZG/Cp+ypzdDsdPZ05x
         e+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097516; x=1786702316;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gRsC4nvT6Z/jvHUPDRb5W5WWvK9c6aIP6vBj3rnYfTc=;
        b=EC48Y7z3lCgNCxcHVzkKclPIKT2IJ9FB4k7/H/ochnsOIB7fC3CodZnO8cKRjT7F8X
         Qk3MoMOpbZJD/bC1mZ0wvG16BLhRMX106+XrMY81TboG3MTvjkGaCn0qhOX98ayBp+x0
         1r4NDmSKKR7eXPyTCfRdfi5NLvEeTeMMYPY0lG612sQdJKn0IxxCF5Ce+8NYhvExnswB
         rJOprxTnT9SLojyJyO/yTps5by9y0AaAaNvVeakkskoFt4L5yKCbfXGLbDT4ydc4W0s8
         1f5sngHE7TsdY0rZgAHBjd11muICTNzh1vZXfCQ5ge5ffyT3zwyr8a7KlEPAA+LsNGQc
         mZnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqD92IymKRGrGyNG/GK6wNrXO1jWyzCyCrfB0OeMcB3z/b59gTXLjOjBtE27q5BGNobi8RIphbZlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpipyuYv/htOQZy9TO/kzoXVgwIH3hHouH1fiUu5ZXvnxLVWH
	dYHLAMID8xlLCQ4YRSvre2iGCtjbHWHo4HEaW51TCwvK9kbgyLMHRmD0QjYbD9KtpX9g6UJdugR
	Y2bYyomq+yHGJtICw0zc0aRGu4vLaFC9V4sh6
X-Gm-Gg: AR+sD11Y++hT/luvfdo9TpJREgbAUut5ChjYnUbreDxKv2q8LAdT9+KH7BmSfWPJusj
	6S3bw0TPmNgsEOVjcABp5tqJmJHLCk9Ly+xm/4cdi8+pJkC7ye6nfZMzMbmBVHotkxLXM8rwX3q
	hsmKwbCpk8iQ0Og/tnb8dvpQ4nyd2Wh53XEoejnd63G0ySLDE3b3bZ7aM1+ATFCislLxUPAK+PL
	5BKRd8fFi9KhpndnOc2zb9ygTMyWfl6OUCxtOOWvczqxDif+gA9+/L7yuP0ngixQxdUNXN/ATnE
	sBQee48GoVyRzHWYjaD+2RxK1wSjTLzuZnnij4m2xymV0Y4L/x2Qof8EY3Kvwjc1Tx32YmDdUu6
	4Rkbltinwt03PvdfughgTWTswfVWwapUQFi+VqZUXgeOIpTYSg8BB/+tc
X-Received: by 2002:a17:903:2290:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2d0ca78d505mr240111405ad.16.1786097516111; Fri, 07 Aug 2026
 03:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807093058.42840-1-phucduc.bui@gmail.com> <CAMuHMdWJ3W2JKmxaKaa-A-Zk633cf4UwbESi+F1_h4tX1AhRng@mail.gmail.com>
In-Reply-To: <CAMuHMdWJ3W2JKmxaKaa-A-Zk633cf4UwbESi+F1_h4tX1AhRng@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 7 Aug 2026 17:11:44 +0700
X-Gm-Features: AUfX_mxB2Z6rKGI0C552xtBhSaQUfWGeTqpz5g_xI9L885nyvRhIV34A4nRBpYo
Message-ID: <CAABR9nF7sAT4C+W_qE8GVKhrtTjdm=DcpJH548RzFaYLuED+3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	niklas.soderlund@ragnatech.se, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Geert,

Thank you for your feedback.

> >                 irq = platform_get_irq_optional(pdev, i);
> > -               if (irq < 0)
> > +               if (irq < 0 && irq != -ENXIO)
> >                         return irq;
> >
>
> So the code may continue using -ENXIO as an interrupt number (and fail)?
>

Yes, you are right. We should probably handle it similarly to:
https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/thermal/renesas/rcar_thermal.c#L422
and only assign the IRQ when the return value is positive:
if (ret > 0)
   irq = ret;

> Why is this change needed at all?
> The caller of rcar_gen3_thermal_request_irqs() knows how to handle
> failures, as IRQs are optional.
>

Regarding the caller, I only found rcar_gen3_thermal_request_irqs()
being called here:
https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/thermal/renesas/rcar_gen3_thermal.c#L530
It does not appear to handle the error return there, so I don't think
the caller currently handles these failures explicitly.

Best regards,
Phuc
