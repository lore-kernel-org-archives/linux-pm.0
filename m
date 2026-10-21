Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792566389;
	b=4KyzXWKfmvjYZDv4tYs+P6GGdoT1yh8K4weJBd7jMroCOJaSwH97lB1sP4y+xbytQ+1E
	 eO+wfJKExd/+yLOg7+REC1UkG5fyuRJLfGyLWoOpUku3Xuo2ayUTdYyLGS6AduJ3es32t
	 VpcCE1xARVa+X+poGx3+cgFP5DwBeFUyvP8gnErYgfT0t4uTuiA7S72U0Emc6t5BGUIRX
	 i0CYLNUm1futXs9wt/wA/IBiJw/Lx6KZ68z9/JP8OBwNn5BdbxW2jrtubgIVDz7i1zOT0
	 LZ3C22lTJK8+mjbqhn6gD20dV/8PDR27DCeEJ00Cj5od6ZBa+y6N804RO0vB91qm+dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
	b=KlnzNqpXlM/nyziB04VDOiVNCf82lxM2CcLLb/AvsX9gIT2c2wMAhiXwCBMLBfPNGz/p
	 2RtjvyYZXx0AAn99YE0DjS3zgRk1D6rLmnDew7JUJCQLJdcJPN0UIJZD8nDuNo3iSCzMj
	 LsEFCBaTMYJkZU5ZGTtSN0M2Z0W+ADiLyvJuvzMYqRelib6WhBZhi2WiZxCP19BCsltnU
	 +YoAThWhp+GgaVEXzimTggnUYNa3nCXGzQT9tW81Q+WsHO30Dpv3pfnNsJvnit4DYW1gj
	 tXQEMjhljM4BWKAO1xjpjkC9YCA41IeVd+UisiwVw8slDO+hRpo6BXNvS8jpPgN8qhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C2aW6AfO;
	arc=fail smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BF606A31C
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 07:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B70BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C2aW6AfO
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso538416a12.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 00:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792566387; cv=none;
        d=google.com; s=arc-20260327;
        b=Sib/Tzt8+aY4lmGLUXJhYVQCW9nVSwI/Thmq3qJIDPfoZO++lejekyPIaC5DXL7bS5
         tP2cFogNXm13P2w27oU/a9B58syIcTT1Z5DUAlFWLKluvhAks+FKmYZg2OCJV5f6MQAJ
         X4+rMZZWSYlMTbzaBSQIwUSDcqjrQC0JVFp0IvW3uPumCwU7TXtfndIhI/hVi60marDO
         0Ejj8TyWRk5fOTSIvtSzKytA4I33w69GArFoNSqEfnVnJdSTRvImwgjrddiampQC9yem
         ghrbXCkMF+RjJW4jEE1DguwEVwBBRCGaDEm//zF4eZvnR+RUnEkbgUE2bwhGto1WIiqr
         364w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
        fh=0BCRNupJulijGT3QsFBa75BAqDo3lAhAwga4WDKIlWs=;
        b=nJfFPJkNPmoxFeXU08gSd9YhJzu2nM+vcHu8Y2I49SFFwogBHdRGfHvL6ahKJCqM64
         Cctq0WAEolzlmDFx8KcTQU4FfAy125iOFlegQA1qO1S6skAYdGbL9Djuf62dWXkCztjB
         VPphiHCz9QmqM0GBCWCIzysxuubxVVdEqyG5pdmHWYA2meq2uefoTJfRqtKzzkOTR/ub
         tBy/UuUZ8wbMjopYoxstHE+JXX/rlbz4g0b8VEMzKgiRY4Z6FG09rqfmgIctvxAtpdsN
         yhyUduLXVrtkANRPKsAr0nBw3x92ubvCdK68s4VnWrRhh5XDWpi3RogobRZuVmBT2uVX
         kvMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566387; x=1793171187; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
        b=C2aW6AfO2tXqS0Oxlx14bTBMVNZFQOYYIP++4Zjy0XAUzXRNiZIyd/we1pVq076aHi
         iVYIhUPzTRpHWbk8TgjZRClfvVa/ZIrYZGMbZO3DJMSCV5UIvg3fS/yC6mcleMkr5AZl
         CDc9kVye1E9N/IkJg93m7mi7sqO0whCAZMX9QcPqw07cX41RvUCWYBX2Ni2g9I4qZnBc
         vQc5Edq7qEPfSyUtvQ+/172O9D4MiKBbq1sWvU7Tk2+K4adLUinXmEHtrQ6sATHMl6NQ
         saHvu7vFC0jl/+EFXD61TpmMKJksXH1W78BY/OXH4ikoNly2no/97ZmvjpXcLfZRBf40
         7B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566387; x=1793171187;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
        b=0cuP9LgAkm16xfI6FuoLeA9l0ud/GgHllce0+RsUDBWNdBTkZXXdk19LZqGBKYbD3T
         XW4N0kP9IS0cjZVm+Cf26O7lNluKwZPjxRFmI/ZnECx/6NqZlrtASur8VCt4/A7fXl09
         ze/K7Xyj9mDGaUPnWFCkkm2gcKGkiSKvCqyd79m+aR9nqXB3uWhLVQ+75IDd5waHZbWR
         lQPEypOyvkOzxEjtp+iOuCp+nkH8Dmr6i5HZgpnetNXOcpQQm2snssD85Hvwop6guTFF
         Z2JwAqhAZlaZN9OBuqcQvA+UIlAio8iMdAd2VOt7jATflkCU6GTNAyevmp8TEYjeN+gr
         Y79A==
X-Forwarded-Encrypted: i=1; AKwUvBzIXUl3oZPa7m+G5mrqOiSwwd8fwYBTpfir/daR6sskUI3FTvrJrSgaL2IuzdHLGfLHq/aO68cO/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKMPeGZz9HrqSRwuo2M54en/gecW1pEJIxB6lgS6esSerTraK4F
	EknWoyOk3GpnAEe+/HN+X6YJ+UEkcmM2LS6upUxmKtOzNsjNHSSlj7i/pCfsjDdIHhpqSdxFC1d
	XWmrUNFJZR3Pr4PZPVzGfO2FD76ribZ4=
X-Gm-Gg: AYBFou2SZlgr0ab+/HgTAmv6C1FIOmQOsRpePGGe9Cb7lxnlPfqOh7vJonepqprMmQK
	vDYTWRwAundk+G/4rPYaZNvDk4GGntn5kB0fSZ3I6kXfFYHVhnEp1JFG7mYorukpG0ZYnxI+Mj3
	SuvapQas6ATa3GOljcCd8Wx9308R6Q6UECrnf6+iA+fLZM6vXVCCN9HRh1IxKVEoWht2sRMo0Ps
	yD8zh7VAV0Uw/lPsU8Acif0JLOCJPnFTWuY2JqwMBOlUK0th230T0KY88raJttGiKS2ZP1QXn6m
	bBzcibbEGkp84xk5j2+ZlTzVP7CbzCMd9MKBmDY2S21SFDNjoOimn8Wp0pQIgnvfISomKhQZ/ZR
	52h6FJSf/GHwDemVkLvgP/aG+xWxj/aGqGuA=
X-Received: by 2002:a05:6402:1585:b0:6b1:cea1:a011 with SMTP id
 4fb4d7f45d1cf-6b40893d0e9mr633902a12.0.1792566386899; Wed, 21 Oct 2026
 00:06:26 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020173556.632798-1-l.scorcia@gmail.com> <20261020173556.632798-2-l.scorcia@gmail.com>
 <43b58ad7-5934-4895-b48d-5b5a7b92e253@kernel.org> <CAORyz2JaJ40+F1oyrvY_0WdqH=fritbPuuQaZ98sXagVayZPLA@mail.gmail.com>
 <2426ffdd-9438-4166-a67b-96620650a59b@kernel.org>
In-Reply-To: <2426ffdd-9438-4166-a67b-96620650a59b@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 21 Oct 2026 09:06:15 +0200
X-Gm-Features: AclHuK9050nRGHSTN9753pi8bjuF0vHRU3cnUbJida-ygLIdS4pPdAAtcMwmgKA
Message-ID: <CAORyz2KsozjmcDCd+KVfvLokuxs-YAP0E5yJawHECu9pbPQmKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The dependency of this patch. This one uses compatibles defined in other
> patch.
>
> Just apply it yourself and run full testing - you will see notice about
> undocumented compatibles.

Thank you, now I get it. I had already removed the example from my
testing branch and removing the example also removed the dependency.
I'll run another round of dt tests to be sure and resubmit without the example.
