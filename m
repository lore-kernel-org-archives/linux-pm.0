Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792564989;
	b=HW0SBH83/oqTqSki4cvxLIt9jPXGT/uid8x7dUQxkM/0JIsmmpFNTiZ2wpiNJM7IE4Ow
	 RAQRWFwW1Muxr+j4FNKOM6u4gLd1SiSpyHp3WyQdBJxn1fX0Kpp/W3imz13DCbwWTHUxn
	 PkzLWs/rGjVsCeFc3tlW7Lnp9lR/1JDMfNANEOsjSCEOhMRr0pImtzY4cDZGcTy8QiXBQ
	 rrXDOn+t/OeHwIJBoyHVf1HaCO78ttENf56zn7aEjnFWFQ6T/1C2lyAgZlf59i8N7FKsG
	 3i13SkFIUAHBP/tFp2vnjwrpjfMUMNm3GkaINVbUYZvrVS9zRhDpz8RYsvwyHkuzV4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
	b=RmkPuhx0l9DvjE3MBwZAvwNekCkElSFolZnB1GaZm1hENUwtMlj4sGu0dADauEjFpwdj
	 h4V47PgbNT57DqXtKxpYF0hDyHXxQDgJENjeK7QIzPoD/Po5Lnm6/2hed7ctyPWv//hGh
	 vQ7lJqqiDfQI+N0k6F5IyRPBr1t9Jjlt5vVxQPbGK0JlvWETIYirQzb5aXtNjBSPDNMmy
	 PMyeiX5CnQxN3GFPoyJj8pskRqNp8lSlbSnaTY09siMrJIEJJjoXcif1pJGfPq7lF+Snm
	 T9CLx7XQ9e86D8mzOUjSPYlBCghKsEH9aOmAsaneUCC3Cpw9FuzYDKeAfWmAhFWRvpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W/GZzHF2";
	arc=fail smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF1606A31C
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AAF1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W/GZzHF2
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-676804a3a22so313554d50.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 23:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792564988; cv=none;
        d=google.com; s=arc-20260327;
        b=mnuJEQ5yIbwI4/0dA9+7XaP0MlSBhWk1rIKRjOj5gyIVUayiNeMXclmPQBJiaJiGLS
         1ic3Qc/219AmseJQdBQA8eaBuKkhUwIy76OY0q8xbKegoIAEyuEW7TLyM592A8BTb1VV
         6w7flXYS3SCBMOyN6ibpkqt/iMpHQYLaeFvpsB4pcZc7D4LZ6x9Hc3bgOjn9HdAI7z8N
         pVnji1/i8H1SQV+jVnrkGpXKU77QsRcbEkLMT4ArTOQ9MEiv3cmfIc6VFcuB+YaYWYm4
         P4yckka+liqUalQwdFX7c3/6VB8tQeltm1WA5hsQ9YGe6hM2lylZJRl1KKW6NoE5vDjt
         AUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
        fh=JGcPBtMZLyMS51O1ZNtWGOGMPJaYFtH55taLZ97rzLg=;
        b=KUuIy6yUABcwmxV68hIcw1OD8jX4DUggMaCzzWCSZWGOci9QwLOhPQe6lNq7Drb6Uo
         Pu2nefUBkeyaA/42XXx2QA/RgyTTv2OOa7GldSwl1b7ngNwdhYVIjqEcxY41MQ/KVmbs
         r7u4F8R0N79nSjDLDrsPHsZlBZIgxns5f7aU1S1G9EG2+e7/5XBGP7dorfrylrUfjvYA
         RUNWrka6Cdn+ZBGsu33wUK4l74DWmS1zXGKO/p7bKuyezW/35XL5sAf5oewnqNjqVdM5
         i+xhHHUoci1UZUJtLH6+uaqPLncyUM7JNTkoAREqAvRIOygwv+QGqk5rN6hCZI1PnAXT
         dqVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564988; x=1793169788; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
        b=W/GZzHF2NY06v+oXZlgyivPlfoDTpJKe9CZuhEPaTuP3Qidpu3yorDYA41xB4bcPSC
         /M1QCIYeBX3/6FCyGJwl0TF8pFqTe88oUv3XwwvX1E5VlPp1911HfPcH3d5saDWQgsVU
         Nsll9UVTXZZuBMTm2Nwc2f03wOSjF5w+FPenbmn78a8sK+qlNzx+w1Y60DCOuAWUn1OR
         UDv5dhCVm0SZxFlLUR/YUHiWZCrrR8+FOmbCrNDyDDz8KnODQNNH/R7qPMfSPlYd8n0k
         Jxr2ymTOX88uWC8p/jyO/uN1fBbx888FwDve3IgT2GsonRNMcqXLmqB0eWi26eXiw5YH
         ZjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564988; x=1793169788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75HaQkKBv/s4TtNxkrkKWGdW1y+fNkvn+Rmd7D3S10U=;
        b=nMwF0uOZXvc81TTJRD6508VuigR2AyTgHWEwuX+6z/6eCInN6eigeNYV5u2w+q4lvN
         DkPuw61MUdgJWBYt+bMl8r8+nLPizPpZtNf2FedKqWfQg4uWxHoUDhzBIDKUcg6bHBJW
         I/Gz4xrcGEc//iVbgJQO1DPOIomBdfQGANBSds1ZXEBGPleS6XDSQXo3SvYDVlXfcVHy
         khQXtMKoKzzNGkZwMRBEJ/oj1ffhLZvibDYUu6VfGfh1mbAC/8L5xtZzU+l0OyFwKIqs
         p/krEdqaFbbRIkEQF+lzYHXT7knuPWm5op4IuXDxfMgTKmxA/aUl197XHEKh4WNBFAOh
         RUIw==
X-Forwarded-Encrypted: i=1; AKwUvByUDWkN/uu99PY/uq0O6yESjV82/g6Zr41DeZjF/G79XZWwarX9ao/sJyETWJdlkrgvZAJk1DJJ/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJUDDpptp4i2qJDrmwEQE0+3s/U+iwSkWjokyYCG/96KXlPQYrM
	dRdBARqkjYol8grPe8b82/G8RmaLGqg0aXcUjJMnxQsJHBJfKbD1dSaIyEmlCMAzpH9bgE+f2E3
	R7nSSq2Y6fpu+qJ5s7FGXol8LU0tz6AY=
X-Gm-Gg: AYBFou3BtrsL9IK7hSxl9Pmxm2ScjJXy0Sf2yUmiwTMimRijtBuJsVkj2czDRTTD7jV
	3lsxDu6hAbPHMS85P/b0ARnnvlfHesyubxPCEqEG1mp8Im/cascRNkaCtwutDgzAQY1ZIiandqm
	J4EnjxFLCTKQTMjSNJWWc441YSfn2aGGCqUcYPk3qh1QsOIgo/BltPF8HmYvAu4j14W5C5sLm5z
	YM/Bt4I106IUgPs1gunzKpYlMlkXVTmOdoCabBhsAMfYpdJsP8osEq5LRNxWOlISHvNLdt9z2ft
	eoz95HPcFTqbqGnQJPt1ds6vRJm531T8m6mOrqGUcxnqjI5WYf3jr80G93LNtbzeF1DcleQMfFg
	VqvjtPlNIJSPCKPOVLPCnOL2VwllE4hOf6MI=
X-Received: by 2002:a05:690e:b48:b0:677:db69:cc1a with SMTP id
 956f58d0204a3-67a0e02fb85mr644184d50.7.1792564987934; Tue, 20 Oct 2026
 23:43:07 -0700 (PDT)
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
 <43b58ad7-5934-4895-b48d-5b5a7b92e253@kernel.org>
In-Reply-To: <43b58ad7-5934-4895-b48d-5b5a7b92e253@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 21 Oct 2026 08:42:54 +0200
X-Gm-Features: AclHuK9RBvE_tu1JJML2kndZnV_iY7Vg0PVQd2A9ECqRfA0-uzrQqgVwLULojEo
Message-ID: <CAORyz2JaJ40+F1oyrvY_0WdqH=fritbPuuQaZ98sXagVayZPLA@mail.gmail.com>
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

> And here you write clear note about dependency, once you fixed
> bisectability.

Just to confirm, would the same text I put in the cover email be ok:

"Please note that patch 0006 and 0008 depend on patch 0005 as they need the
registers.h file, but belong to different driver areas. Patch 0009
also depends on
patch 0003 because of mt6392-regulator.h."

or did I misunderstand which dependency you are referring to?

Thank you
