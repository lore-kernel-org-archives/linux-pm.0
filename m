Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78338837E
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483128; cv=none; b=M/UejXMBijx06WaNZPNC34INrZ1sCJTgQ56iO/SL1BCduW2tYT18kxFglY3GJc1awM34YNRaTuDpU25TCXUIfoz0Im61JsqvNzNzWtiv7SF56tUrLryxirOefdUv/Y3b1IW3Ky51dTg4Blmwl5FljmK4SZrdeSom8yMSAGkoxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483128; c=relaxed/simple;
	bh=YX0a0jpNYBmGFxakN2CbC25kVRva7yDB8L+NCVPEiTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qTRnNGZMemXTYSvLj7GxF6xQ/SHDCwhOcTABBeFME0eA6JV21fBbvju6ga4Hno/CdAuqfz495TzjIYQXQseHnoIJY4MGBKRSqOZRDXuBTrS0s1H5HxqTHJndvxNXtMxd/4FHclaPZheezLnUsVk5ZehylVb0NF73LCiJbGttooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7fuJLMl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7fuJLMl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so94471015e9.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780483126; x=1781087926; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX0a0jpNYBmGFxakN2CbC25kVRva7yDB8L+NCVPEiTs=;
        b=X7fuJLMlz5MZvCjERHFhiUkSQVtVz1UwmlO2tR6qmQwMpruc3xYG8d1mdSH7PlD1/w
         FGAV6s2h1blkjop1RpCfU82ihIUhR9/b1XSYu5O8RK1IN4FzJ2691Y+m873fex1q6kmd
         /iBN634tKFusQqkiKEHUH4At8ekulsLsMFekWmQ1oD5/3oeCgMlsZ5Mq1m+9HBGlP7ls
         ksfAME0e5o02tIxJnbCCp4lMPjv1SNHO6u26bkAJDA43j2YwJVt3+LiA0vICgXBIw0ZE
         6DuL1c0IPiKg+LYEQu2h5Tu7bbMivO8Y7zq4PEwtWD8VnWLydTMb/Tjqpt3ofv200bZa
         28SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483126; x=1781087926;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YX0a0jpNYBmGFxakN2CbC25kVRva7yDB8L+NCVPEiTs=;
        b=QLIYgXEhAF+IWckZO4pT7ccK//nkRe0fD3PjvwBYME18oGVx2Do8L69L3xMRRB4K0U
         jOkKJhXA/sNh/SC4q0JjzE8zWHGf5x2QPPdhevIz77YFkghj/zEOvsYYglt95vr/rmxO
         lM+s1xEMQ9021zxFbp/vAp/meeNxDKNeYmKy88oFU7hUGM0bbdaG2hgUwgqp5m69Ltfj
         x1hmg2eqWHpWR3Wglj27139346njMdKpYz/SW5ERTDCP/KsFKVFskRytflI3s0U/Djy0
         ESBVZmx1xL7/Pw+GDm+GBOcw/zNg+1OtmF8/MZY6Pq2PNtZ89ca5cr59U7hTNQc1npMX
         PHCA==
X-Forwarded-Encrypted: i=1; AFNElJ+B+SPYKSfB3kiRRAdRT4Q28nuZmxfDbKXlTSpAIzd4c1yh/4n/DyvO019hed00h3I+p3OLT/C/TA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1DcaITyB0jJEe+ckGyihUWwG9cSbr7mpI0zr1eeKqOjOOVGO
	pjXRdCkEwZRdKLys5qFN5Zcab1smxJ0D82DM/NQ1A5HF0UaQulSdTQvKbrZKJY9y2Co=
X-Gm-Gg: Acq92OHFtMxhQ+CU/xWse+tB1pwl2d04I1iktNYFIl8x1KXntF1fZkrCZz5VUmZpRxZ
	ZPzQcOcjYBv1JwysGZPTOrgEjK0R/1AhdQeTx8t7qiF/aVArm7Eul/xM+bY8VtMMfTDs1bBvu7Y
	KYlG/LHhbicCNEVFnBq0P/2YUYLaG3DaWS887VU/V1NReybuekisEvLcaaniRYFw1sr7x9FPoIW
	ZSrfuj7dFcUoyya045iaOZIsEL/gt6s/1NdtazGwDJLiy8um+qDGWvFyftfNWaLfv+u3ccCH8Ex
	hv8PGGQ5h4Fby++8cPH3ObCyiFP20sj84/lDpSmvtv6o874Icxe2r4Ijmzhoo+DRSD9rNi5Anec
	B8L4Fv+QNeTweRXhpOdIf9sh7oRy3tM20unsEj2xAP3BfoJDYhaAA/AOiYXFe5A/Tpt+Wmnk/F4
	28vIihzQ4yc6EBgjvsIIggKPasWKuzkCNmwlUR/VAcuzMLKEz9uF5KVuEnWCqlt2ClNT387eSTo
	nhHRPadDDquv0P0rwV5brz5CHzL
X-Received: by 2002:a05:600c:3596:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490b5edd71amr48759235e9.24.1780483125952;
        Wed, 03 Jun 2026 03:38:45 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:9b1c:c9e0:4645:9af0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b616d6a9sm49891265e9.7.2026.06.03.03.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 03:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 11:38:43 +0100
Message-Id: <DIZCLBAOV4ZM.9SJGGMZONFB7@linaro.org>
Subject: Re: [PATCH v7 2/5] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter
 Griffin" <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: <jyescas@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: aerc 0.20.0
References: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
 <20260602-acpm-tmu-v7-2-8047dd54b0e9@linaro.org>
 <DIYTOGU8I2DV.1GKZ59F7AJWTE@linaro.org>
 <c76c8f9b-bdd1-4006-aa28-735254f0409a@linaro.org>
In-Reply-To: <c76c8f9b-bdd1-4006-aa28-735254f0409a@linaro.org>

On Wed Jun 3, 2026 at 10:26 AM BST, Tudor Ambarus wrote:
>
>
> On 6/2/26 10:49 PM, Alexey Klimov wrote:
>> On Tue Jun 2, 2026 at 6:00 PM BST, Tudor Ambarus wrote:
>>> Add driver for the Thermal Management Unit (TMU) managed via the Alive
>>> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
>>> Google GS101 (and Exynos850, autov920, etc.).
>>>
>>> The TMU on utilizes a hybrid management model shared between the

You might also want to correct this "The TMU on utilizes..". On
gs101-based I guess?

>>> Application Processor (AP) and the ACPM firmware. The driver maintains
>>> direct memory-mapped access to the TMU interrupt pending registers to
>>> identify thermal events, while delegating functional tasks - such as
>>> sensor initialization, threshold configuration, and temperature
>>> acquisition - to the ACPM firmware via the ACPM IPC protocol.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>> ---

Thanks,
Alexey

