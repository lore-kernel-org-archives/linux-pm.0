Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1559438493
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447523; cv=pass; b=TOIWdWgEwc8wgbj8XsJVfRXFyklvPROcNMMY2a/v7Kuh8jz3xuFkaUuTgk2HODY9DUDPNRehkQ/ieT+1qvM+9C6f7G45aVAJi7T+niLCRneB+7mM7G1HQz7tGWhurutoa+zbMvio7aUN3KLYIyWPS1AZfTdASeT+bcyyWNkzS7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447523; c=relaxed/simple;
	bh=1fCyBztB56Mbm6pG1VzHl6tMEqvrCbAMMCDlWGNMGAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIKlblm7dPP26ysTuLGmpErcK7NTdp2Stk9kIESwZn9N13iyynZBCVIuX+6H5Flw++Mx2eG+Pogf/SrTgPNfe6NP+G60BEx4sbnncRMXPAmL1a4KTaA8ZLbLT9e9A0gnwuQ8V6VdPS1x9t0DQweIdSl5hhT3WnIHZiNhI71h2Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmCAew7o; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmCAew7o"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so659725966b.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 21:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447520; cv=none;
        d=google.com; s=arc-20260327;
        b=aPhJb04oJIULgCEXAn2YomwDualcUtBFP5wcYnqrxKQd2NSAz8nOghCdEkRGjVg6EQ
         Z4T27Fl5si37uKQicNzXV01DbjC6ElLZkMaj4GwOuzjafLBJMZQTBirMm3GuJvb3mZ6w
         UOV21Zcfs3MIXyYqmlLUgmJ8wd1MGZgpXKMOgzN2u4RVgyRFyHUBqLc4wiu/uCsidXOv
         lY6UH5iW+WEOzupgZNTC4XqarFPX29CXhpoF79/WBh9Qli7onentSFrfVx5JAGWfIIw0
         NmxVwTDXyvpFZmKDe59xk9k3j1ouP2CUspXijRlYARld3llIcGhK7s2Bm/V9Aa7PeIEE
         JyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1fCyBztB56Mbm6pG1VzHl6tMEqvrCbAMMCDlWGNMGAw=;
        fh=+gviOUp868w5bjKhphjrKNYo2gNPkV1Zs8EXJLoiNyI=;
        b=kxbMj7D1gpiXgDZgCAsk05pOq4m2/v9cgSSBEYVkRi5Vg8jVpRoOpQSstkBO9X3zIY
         NKNJY0ZV5ZeIQ8fXVe3hdi54km2tsnSL/wYR06x3/HsIWj+6a4OyYopU7slUjwAbng/d
         pxMlUSv+q2Qb/SdcRJAFrSKr7vD9tAqTQEdws8RSjbZ+KkTbo6rODgfT3f/BzsJRuEPj
         KF8QLh77KGSjw/vHyrOZDjuBoyXc4glh09gUuMsWBsKvES9TfWAixzyhaVC/6aFtBljs
         yAprIeatbtkQaQ/ZQcLUAg035UBIC1CeikJglzINjXIf0UU2owTHKb1+J2MawHBfQQSm
         iHkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447520; x=1790052320; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fCyBztB56Mbm6pG1VzHl6tMEqvrCbAMMCDlWGNMGAw=;
        b=CmCAew7oGSIiROxNY4a4SIyUoXgYoX64btMSKyEAlSAD1OWObKj3xwLX/lEEpSrg/Q
         A0OUZ/Cu/2gvLy1i4OGAPEeuBjSTS8qYGQ80vO8P3btG0ZjmrI3OBf3bD8c85WkWTIkn
         owXGWJcUfYJ2VmHEUZd3FkEnw2yLdXi1gs26PJgrqoq1I9JYqO0Hmc1AV21zyuvNT1gQ
         bwrWTyPvE7LVw+4YZ+3MhHHC48G2vA+09ePw6XMZEmdArvrVjqDHvV+qUL/nBx4oC2XU
         Sg+0rx5P2WMVVcASS8hWRR8934LZGLlN+iq9W0qD1t6XWV/BoBPfx8gTujCCTTEdTGv4
         C8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447520; x=1790052320;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1fCyBztB56Mbm6pG1VzHl6tMEqvrCbAMMCDlWGNMGAw=;
        b=Svg96yMj22kvrfvltyG/CNxMG5JaaKzMcAMf6Vb8DbotVeL1MgV4cwY7kI2sljGatq
         ygLJOgvzR7uOQglFq2ovG8VebInIEgRBfGoRTrFxnJhIv4Rc17KxhDaa4f5WL30hSt/X
         x2sBMdSpPl8QkpvT2gM6f8yZgzBf20mz/mTmLRlgTh7tJL5Etayc7GrEVT6NvQ4a8usQ
         dyCHKuuRnWFVrQSnSnPBE3jKT/zb/99kNsYc6a8ZXHn0ukR5Alz5U8PYDyvLif2riGV3
         O0eQMxyhwTpZLN1el87dTG1GtjG7Luhg/kUhwMbCZOjHDLlAYF6mi0tQw3WLw/H39UWt
         b6MA==
X-Forwarded-Encrypted: i=1; AKwUvBzEdD+NFUCIO1nSlNbS+iI4W0CbmTv9Iq166szttrPhck0Y9Bu7fRiT+ccEL1yRdo6AWY+Sr3Lx9w==@vger.kernel.org
X-Gm-Message-State: AFuF++nlJcAhwVHUU2naM108Fly3FLqK8DUZlgZkwDj9RFt/SGlfZ//U
	1D/7ivR2yIijUwZ3fN7uxBPA8Bzl7DaeNJTVxJYiVU+vc3n/wOnv/MCk7ATvxg+6BJANOkeGM14
	v/9gri9Cp6Xccax9KqT+KjMBwTbYqXJo=
X-Gm-Gg: AYBFou1/6fWzEprXTzAfGNaWEIIbMUvLg1qUZ4Dryc4FBLnnQKNbNhYWUNmduiQmdOj
	E0Is1QCsfz1jGv1rnWHtv74YQts4DHKKO+D1dGNmF0NF/KLKfbZcKTRTSV8w164dssfecD2KEjr
	TsNK6+s0cAHTV4Pt+dPRdEKCKlDVU03di8vtSkDpA4jAJtIyhurcn/zbiS1AyYJS/+YfYfLDSo5
	Uhe/CMrM81L+rhw7HfoTXc2n2RPC2o1m0To+biybcrTFmOeGu+CkoodE4h9L+3j0uO0eJ/5bws9
	h1O410DfT96GhPjvcUzZYtQqep05p1OIYJbs2N62cSXuPuLEofVwhg==
X-Received: by 2002:a17:907:7b85:b0:c26:36c4:858e with SMTP id
 a640c23a62f3a-c29b8726f8fmr326120966b.25.1789447519950; Mon, 14 Sep 2026
 21:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145905.9404-1-linux.amoon@gmail.com> <20260913145905.9404-4-linux.amoon@gmail.com>
 <a835cdf1-b0b5-4719-8b5e-226fee78b856@kernel.org>
In-Reply-To: <a835cdf1-b0b5-4719-8b5e-226fee78b856@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 15 Sep 2026 10:15:03 +0530
X-Gm-Features: AcwNN1X6uQRHhT6qwboNgDZri63s8FVYRlQvpJVAgezJWpeLkP8LX7XyBkGQ7dE
Message-ID: <CANAwSgRETNrPmwGvv2z8Q8EF--W19u6iB1goNZHUzKp64s3_Fg@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] thermal/drivers/exynos: Handle optional triminfo
 clock correctly
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your review comments.
On Mon, 14 Sept 2026 at 12:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13/09/2026 16:58, Anand Moon wrote:
> > The triminfo clock is obtained using devm_clk_get_optional_prepared(),
>
> No, it is not. It is devm_clk_get().
>
The data->clk_sec checks were changed to handle the NULL return
 from devm_clk_get_optional_prepared() its only used by Exynos5420.
> Order your patches correctly or do not introduce bugs in patch #1 which
> you then fixup in next patch.
>
I will reorder / fix the series so that the clock API conversion and
the error NULL
handling are introduced together.
>
> Best regards,
> Krzysztof
Thanks
-Anand
