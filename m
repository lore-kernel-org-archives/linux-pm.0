Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795030266;
	b=QV67dr4YfNEKHp7L93+z2nVPsU/juPqF0m1aFbieZ4oSvcMnNGMzzLEEPw6jwhI9DuYQ
	 seTY9XoFRA71hbwJWKp7SibT6JjBp1H62EZM3irj2UonoJvP+L/twEJAdtrxf4rndh/ci
	 fqX++lXcl75Ea/sxGYvxsoA7WV97NJslaPyh5+rry574u5O19NCJN6bH56NcTD3FKNg8c
	 fYE4+lVjPao7phBX0UOczIzC0n8jKOC5XV2kaLmsdAE8Li5IUsxpWu6fhCjPDv72dsxDx
	 kpo8j3pjFdz0kpmbIhWR+uw3uxRfl0mdl80LLb/gv/vV4XwX33kuH/nb1qb/WqF70+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
	b=hy7I2AWcRFmMI+iQQ2Uvd7K9HIArj8od6z9mEP3vTpKg9WfIFU5twOfoi6qtRy8dAYlY
	 Mq9RNBwaBJ81Dh6Y7g0mAC7dBi0Yu+Heb3B5sDxreS3oBzGUnccfLV+JY5aO98eBAaboX
	 bTmj8xZlFI1Jm9XcspskPaw+D5xc6UVsFZr/h/PBGlTzagk7PSA44RgAOPU5UyTF0pZPx
	 NpyQ/SJ5GJZd8G3/c521TaEuQYeKL8dsxNS9IX+tlw4LUUaqpgsjyZtjMdAJ8HqbD4FW4
	 /FkRLp7zIYSiz5MiUJuT1RzjXemRy/ipaH62vGr8nHNRQvP2CXPxmMXAc7ASF/rOsaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YYTxxlax;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD30606F537
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 19:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD30606F537
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YYTxxlax
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so238666466b.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 11:31:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795030264; cv=none;
        d=google.com; s=arc-20260327;
        b=HXdvjAOMIXj7yjXpQr7U4nMI62ocNLcQzZgl5d+wwBkOw81oPE+pdR6fKBOkMw4u1+
         nz+VOqD6CnGUcwHrfqqSCSKtoKiBGoIzbT1ILbrhAJq+EUhkkoKFRh/sht91FfP5Q7gj
         hjbQzt/8jRtqqrmMjSkY4VI8PYwB8TZVd6I+IIOm//d71uVnIP7hzE16Qr4ki+gyJdom
         8Omc0+XREBtJb0EKDAL8GHKJtlvLkIBEsn1T51tuJXebWsQGWHrAO8D5U5gBLWtXZmdJ
         fLCd5Fg2Z0eAPjQYfH3HKY+pgUCVCckwMLHz3/niv58OihQYEogAqRIu5vUUowqbT+tg
         bx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
        fh=WNFW5ShDUCxEB+lWPDfXosw7wo/2I3lIOopcjKHovCw=;
        b=W5oYy52raJdPySwPYkCAcOWM5T+4513FHB79IE+wTD9iz2Qh3QZ6bA4sLGh2LW+wRZ
         mt1EW8BUzurVsDZkxZZuwFlIOys9hILVQTRGiL28xkBvYVASnxOyRJ/sD0W/pEdYxAQP
         bXqH0ufofkNlMRm5mOtipmWfBqRIgYl8PN/rLN45mE/IQmzrLWlc6tUZS3fNdWUkDc5L
         vEGW7G3krhdmh02pElC+BKIAsMSqnne4GDSSKosAt+3V7400GrhV0c+1/pwtOsPP4Gpx
         vGRH5hVX3s2xvUeaGI8KOIMI8J0JQuR3BCfVIrhnl8vnoorDkAb6ulldypP0sGG4cip2
         1feg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795030264; x=1795635064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
        b=YYTxxlaxQ2WfhHso/oEI2r56Wf/FngEvX4IGgjBf48e9sct9kQaN5+W9clSYP5LlZW
         9lGoVnhGTEg9+TUbmq/jjF0sC+rmU+Buy7VOy6sH/tPxGdqjjnXGgl2MbLOCk/+k9Rho
         IZJxpHNo6bOT5jZstLoYdAJHZylRxqvtOwCldTOD8whfdnvEhqKJXAdU83+/L7lRIx9v
         fzcCiYcUTwNu01GC9OfJiH6YaqiVEysh0kMaSWmSU8YUIYlmG2BvarbXEefoJFvoMsw5
         PH5l2eEIFL9NtYcZ9lHXeSizazga9SFSOqqZtZ+ipAiyUSM6RiF73meQ1GDoIrwk7+Wd
         OScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030264; x=1795635064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
        b=ZVL12xB0D92syjBQrulm+tscOwEuvL418HoVnK6vLQ33m+pUy81wrEnS1SbrjtCgxd
         PXXjfv3HTi6WkwaZIbjUObu75fiZp0m+0f3hw/jPH1I+yUZY/KzuWocUNvNZnwDABNTb
         0QMYZJwSVXcBQ4TWdyNwEPmDy6S3fL19mQ4FF9hxYMrW/EZ+V4UTQ3AuCG6bZLZar2CE
         VMamtkyJY0f+g7NkbUGyseUbjG1DrrlweeEubXTB+hz2nOSxj6DGAbFGD9HDnAyTy6fm
         lUMgglhORg2YVJ89zZTLSuqEA3AtXw4znmsPgwK41QegoFNGnG/P/Dm4J2AXurw33kTR
         T+wQ==
X-Forwarded-Encrypted: i=1; AL+hErEPTXqvdTcgM0jAei3eqqoCghP28o6lCwOzcQVvw75TXEY/UhGw5onGwvkQyZIYSa9x8NDWRCdElw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HQO5ZNYCKfH2AMCrqGSULoqSNGfW07D/8B4v9slyl/H9O94+B
	KOYyuSvDm+hPx9lqApF2EzgN749zya5vaYDc6wXgy5XwDm1kMhkOMGb6hGoCk4LCp6Mi/AD2hr2
	idcbv/ix6cXe+nrBBZG/kcDXQPsBIrNc=
X-Gm-Gg: AYBFou1i+B9ULkTFpQitewkmENNKqFBlknGWuc8vDhIQrecS2ns3X4ha789uHCti/3B
	XuCo+IoWBNdCoqLDQBaYrhlcN4zOw3SV+duwqdlbVuNV1e3d7aJ6+qYRzVDqpJewc6U7J4Db4VA
	Xej+KRUoHIcfyMtt/E4Ko0NMajeKLDANbDsm4sqZ49BBjlmU3W3Qjzt617FZRW51+Y0da/b7IRK
	0//ogzWJQGKsR0NjQCXbT89zHpfF6C6rtHo9TySVl8gvmX6hfRBJSpa2V0hwKqdgvhihqHROzwx
	9eDDyKVBG/orKrkXbZBjbvWm2EMLPjIiZMjkl4mghhtWBYwc+Xol62KSYKA0NMiPwgcU6alLv+k
	H74H8qPM9MLD4ZJmrgSimuWeJd/i+Xb6J3Qo=
X-Received: by 2002:a17:907:f816:b0:c2e:317e:d711 with SMTP id
 a640c23a62f3a-c510e398889mr303013866b.27.1795030263845; Wed, 18 Nov 2026
 11:31:03 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105194426.1113050-1-l.scorcia@gmail.com> <20261118152346.GC98456@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261118152346.GC98456@joneslee-macbookpro.roam.internal>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 18 Nov 2026 20:30:52 +0100
X-Gm-Features: AclHuK-Q_ZR_eSDZWgs8r4i-RTkFZUMV5FI3ZV4LgWAQGQjLtUrjcLbEIObtllI
Message-ID: <CAORyz2+7q3BTeW3NsaiwN9riAbHV0Q_tCm6bBV7RoiDeAbcLrg@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> MFD looks okay now.  How many more Acks do you need?
Still need the regulator Ack. Mark Brown provided an Ack for the first
version (almost a year ago) of the regulator patch [1], but it was
substantially modified in later revisions so I dropped that Ack.
I'll move Mark Brown from Cc to To tag in this email for a gentle
ping, I hope that's not against the ML etiquette.

> NB: This patch-set looks split in two in my inbox?
Now that you mention it, I see the split too. Weird, I sent it using
git send-email as always. I can resend it if it's an issue.

Thank you

[1] https://lore.kernel.org/linux-mediatek/20261105195206.3440-5-l.scorcia@gmail.com/

--
Luca Leonardo Scorcia
l.scorcia@gmail.com
