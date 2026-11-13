Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794556255;
	b=3PHzUL5AI1y10bhtWw5QJkK4oSMnuyWch841/riYjbLGx+Oy9SMTmrwEFdAuBVioAolB
	 yDLpfUgv0ZbZr8cFXv6UnJFEnoRtDk3yoM8/4VbUAjSQ/zbzYkW701NZIyU2xsHhw7g/w
	 +W77wdG4pldLbcJo632hvHlYKABj5/i86amqOFaWPB3TbJxkKssHaGRsJvUS8wVJBqlhX
	 bXnw2z7CN4J0SWMgLQXWgG2yTmVFtoDcRBHJk+TyG7V3lmv0nD5zYRC0EwpBGtAu73Tjc
	 NEbWo36rFLLuLn55R33dyLXoLdx0zj3vozMaewbskSc+652mW8HAdbFT2TjNgNKNVOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=06mx7f1gORAe7RxT0Hl/EBeglXXoMbIOZN2VJUQnHLc=;
	b=Gj+QLFqhoIeNljEWKYyrqG8Hwweq+7OAEO2eDlGuaZUtehhnUtsiynljtPMUgYV9YcTJ
	 QfoTJGIWMU/JVX5UxVvKWQ9UqpGPasnwzOYZfc8u4izdTCIBZitipZj/6mc03m4q5/DmL
	 5TJvy3+6aT8qPH43KmJk6sTzWXRhurAVeilbKV8LAURL+lukssVz8Db8DzmaYDqMCFSMc
	 z+VPxozW+Q5EoTvarvlHa5b5AXpokJOE5FPeApRdyHZDwPxwG4OicPBqOGULbul1067dY
	 SAsnpBKxmznMauHMKOkVWazsfwNTN95T2IkonbRWve3+AbGJPJ8HgoN+461o8BCpurg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bxzdj2of;
	arc=fail smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE79606A335
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE79606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bxzdj2of
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c09e2ed679so59846e87.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 23:50:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794556253; cv=none;
        d=google.com; s=arc-20260327;
        b=K119JSTLIWLZYSJa8Ww95/D/vzPdSsHE2yvVRMSLvJIjcC4Q5KuA9D+gla1+HogNU3
         Y/lB9NFGAiaUr9xu2Lg9gHW42vkow07Sinkhra1pNUZFmheeX0n9jBuEVZfZVgdmCwmz
         F1lC19YMQqF/L1Sj/e5osEw0LF2jcnzI/3/PEIHwxWfkDPhZKggdnjs/A/kTCCZXZTgN
         ZTkQhvXjmmevOCk76wfxu4xc7sBZXVLm6u2L1gLJr8ZiDmXETRCIg4jvXXnedtkqnYV9
         NFpEf37K/xWgSKM4YeE2FDpRlhu668NsxmtKxmVMim0MRgdDSN2vhWBfQzgwahTWFuef
         6P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=06mx7f1gORAe7RxT0Hl/EBeglXXoMbIOZN2VJUQnHLc=;
        fh=cg2xv4YAW7Q6ojUNutc8Pxsupj5gyVXCzjGV6YHHnQE=;
        b=jzp7SVEDJuBhuf/68/4BQaAecqdnLj7ZV2Xx0AVnx7jRYTr0aiF7hU7mdYIJ8jZCW6
         TX8cDZVDSymXF1OsNpniuavHrtaK0Fs4sFNUxjm9I6RKTXlVugYyzeepjmX2at2dUezT
         4Kn2ZT9vxqeGLKtiyhaQDukrraxzuBGmOchfectoJ4y/te9AbiPcQqR73j7+T+4dUbde
         aNbmDU+1iHfKrcHGr745aD1z/GcZomCaobgtwdmOtfHffq/jgXpNnVKRWwd/O/fWoRbk
         RtaDlbvI9bsqrlnocMUEeufLtGfMIABvfMx97ASzdxjmXRuXrlm0pUN/uhbrTZ3C00Kt
         3/Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794556253; x=1795161053; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06mx7f1gORAe7RxT0Hl/EBeglXXoMbIOZN2VJUQnHLc=;
        b=Bxzdj2ofHlGnUK13pjII1xHYgPeDBcuJZLaE1pCSruf0dTjzNRkG6Vo3KFt8VsKHD6
         CMzbihA0WU9PqEj9uz+fysbtsq1vcdx1RGos10FAPvJUhswu2dNaKH3fa6YeLWdPPPEQ
         UKG0lBn4WPPl2N4UKRh11NROBG0PjN+FaEY7241idVRPmPQ07OD7aqhjZhzR0j0y6Fyv
         jOzlvl0rOFo795Tg8CH5QFhwQHgf5lL6o3lDwrp+SzOev+D2UDCo+Z1uo78DGndi3i0T
         DxEkF/qr+9nHffplcoIruv+CkV0fB+NvHsMPSntuw3P9pjBXKqdoHntobUqQ4XVry5sH
         CCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556253; x=1795161053;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=06mx7f1gORAe7RxT0Hl/EBeglXXoMbIOZN2VJUQnHLc=;
        b=FRyR+ajgYeDaokTBtL4s3KGpvxXZVhF1Za9N46rMHstO+qS3i0LzE+BwkIOwQby4g6
         Zl/ywkeSLE6c1284S+TH/nJ3R5I2xNmjbJwH/eFW5v9oVQaxhxCCNhpqdfgJTzSnP25f
         a35bt6z7CQLXhOX+4biAK6oLGtpfgWJkQtSVjNvirpoewYg6RYIvZZjQaXcM/itE2mGv
         R+ND7maSWbW6Vz1cj8NMQNE5f3O8HTvJLGdGFFSzc3nuwYSBBaLRVNHbt1QacgZMEklz
         Ri0Hz1MqTzY++P6TtFBtrJhRUeNstndKS8iIMwSuzGt3zGOcoLDaVcvalRNY816JkXoY
         9pOA==
X-Forwarded-Encrypted: i=1; AL+hErEwDl7J5WbHiYFRJOC+FivW/ZalbMqMGoTD/r2D0ZlCI+KWPQG3Jwt+jPy3NtAj7PbTM94t0/7udQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4DSSVcaIEm+FN5scG1uPFN561lNrzkaJ1t24s26hDg7n/i5qc
	AMeboGM+tXomSeJwLH1AJEjK/MxLFSxmridB230Yb2FOpsTTl7hY+wEVTkr+fmpo6+bLXq5zWhT
	/rPcs/vUPRZ0i7kGOK4S82+1kI+r3lL4=
X-Gm-Gg: AYBFou0lUgrcC7ZXsd/bysaTO6m4Ol/LrIznrkUOYeHpFauHZdIKLaE1O6bMIlL4ZV1
	MbpcHd7N+fhRSAo8LmvELkLXnBTbB0Qyc1AtWyxopkyuuUk5ptMrbJyaHG9fBocJXbpA377+UiG
	RTK26Fl7ykINCR16mP3edjARmWW69f5gGIpgAnwzWR9QQY0for8+c3n0+0OL4SKmLOGJkf3Il5c
	INGi7udLQxmM7ZaUlXcOUs3zgEicyBgC4ijWG4cFyMISVp7oRhPX0JMf/Ec4N9neuywoQJsNsIX
	lzK8Nhk0ppuQgakSr+XAgizfundqLslPkPOAaPWCn1N9bRAKj4YA/LXDM9/Zii7r3mDQ37AuY01
	DCOd3itoFIphuyy5xVl/DH2sifqse6OzyBFIDaYkD0kAolZdNiONMP416rZ664uNvjhTQyDk=
X-Received: by 2002:a05:6512:ba4:b0:5c0:da9:407b with SMTP id
 2adb3069b0e04-5c1709e32a4mr633075e87.5.1794556252985; Thu, 12 Nov 2026
 23:50:52 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-pmdomain-rockchip-v2-0-5cd942a23df7@gmail.com>
 <20261112-pmdomain-rockchip-v2-2-5cd942a23df7@gmail.com> <avWae91pfLv9vyUv@pie>
In-Reply-To: <avWae91pfLv9vyUv@pie>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 23:50:41 -0800
X-Gm-Features: AclHuK9R5vFq7A0lmUNr9gzLMEUVHuewMGfBUZJVlzYHcBuFsoRJP4Ryjr6ab8U
Message-ID: <CAEy9hNW0sZBBdRz-LmydcnvnAwcn0TY+DmpsNaRamPY1mVpdBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pmdomain: rockchip: report domain errors once,
 with dev_err_probe()
To: Yao Zi <me@ziyao.cc>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Lin <shawn.lin@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Kevin Hilman <khilman@linaro.org>, 
	Caesar Wang <wxt@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Igor Pecovnik <igor@armbian.com>
Content-Type: text/plain; charset="UTF-8"

> These look like code clean-up instead of fixes, thus should be split
> into a separate patch, especially when we probably want to backport the
> real fixes. This applies for many places below.

v3 will split it into the fix (quiet probe deferral, the pm_qos regmap
error keeps its own code) and a separate clean-up with the remaining
dev_err_probe() conversions, on top of your 1/2.

> I'll drop the second patch in my series and use yours instead. But
> please search before sending patches next time to avoid duplicated work.

Thanks. Sorry I missed your series before sending v1, I'll search
first next time.

Arun
