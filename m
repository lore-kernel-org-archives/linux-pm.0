Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA139DBD3
	for <linux-pm@vger.kernel.org>; Sat, 27 Jun 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782560780; cv=pass; b=GEVo0oUvk8W+SgyXI/W7G8uQL7JqO0a8UDbnEGe5C34+38jaTtY1IsXQQTXKngAru69e+d2lHeUHvW2xN8QdISRrifQlOShHFZiAvJGBj9nnMLCbd1C9D8x1KfVPi/XzxSXIzVefPiqjnhiUoMMnBjMektTULmeYrmE6DQxgyqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782560780; c=relaxed/simple;
	bh=8En6EBLgZ/7Y9RpK8TSKSbvJhwFJjH5l3CmH25wjlz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=elugkp2WyFHqhpiiwQAUERlNDB4Sb0PQ3Dw8d+XgbqjAwxLPwa+qWAxx/TrxncG613d4KmNPx11p4Lsn5Q4y9CMG3ACEEd4yVCF0yjIzv8JYEfD1+h5U/PG38qqab/0ICW9ZukAt8hBRZaZjYrb/1fZTRGgz5Jl19Tdh5c5vzro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxcvuWdJ; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxcvuWdJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517dc520840so20705821cf.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jun 2026 04:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782560778; cv=none;
        d=google.com; s=arc-20260327;
        b=anZ3FO0eY2AIbVApS1Gzykz8nyQOQqc3MOyQZt4deNxVqUKGworJ93JiUVFerRfg++
         R/mX1d6h/ihQLTojl2WY9yBHdZUVN5o98e46J95/NlHt3ZfC6s4R2AVlwvIyL5c2oBbJ
         XAkgvR2AdGM8EA95d1REAkY8b4WfOwpUGjrT+NmwdPvPrm2uoKqAVh2CrRl27a0FcaM0
         lWMYnu+t/60pmFicbIxseOozgKILi2dAA1H9CcaVDl4fVZ4NCnwyfdUK8jFCCWeuZaMf
         5XR3NbgWMvOa+a4ucDwSB1DK6rrpET9osSm+FLX2hpMQNA88mEl2iJUrEAEj7JMLE2tb
         xtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=MwgmP+AIkwRVqsKscXw1JvJ/gpEoo8Dz+/YrGyTigaI=;
        fh=HvvMgQ+djKYSugo52SvrIMSrlgxOh0vBXD1fJpJyfmo=;
        b=EDUNn6nUDKKoavJHoe9mv5J5/Jv5UqNihrrDhawIOlNOdemaZ2LpghZOnqeapMyZZa
         zVFi9nJD9PbK3U9JhoPIoPPbAXvc75vF+9DLjWVwazUGlZKn0AlVaCiKV2f4YGeplAEO
         cdGQ2rDe0FSJsKNjkV2hLAbOYXEW1PYQrnkcVFxg9yG6FXyHE24hAgInjAg0NyD4ZoGe
         tJzhpao8XPL3xozhSlcRyBTxP+ByMZ1ukeIKW2xOtIrX6yoPb9OjnzSLHw6S3/2ymGV4
         MsZSUfuNPEUai+6BizUbuexVwF+m88KuD2ucOhSkPSWVTZebYrdMz1fIc2faGq2jgRCm
         8s4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782560778; x=1783165578; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwgmP+AIkwRVqsKscXw1JvJ/gpEoo8Dz+/YrGyTigaI=;
        b=JxcvuWdJwbH60EE0DX+qlY1haRVHiUaE3g7jNcU2S3O5Im0stTOFu3wEmH6kZea8Az
         pXsu8ZPzWsjcqEM0QXIkpIn2kTaF+ujdokGlWZ95wp8xwJ2h8GTLcIgT+bgbVqlYQjv8
         ogWVBN7Je8XOnk5gnCdvyD0OMX86Fc9Q+m7syncRkruK2gMI0oxz/0ZhbpSff4LTWdz7
         u7o8cMNWL3+DFI+QtuE9J0s07tgTl9oEDIyFy2kZTXsbBXfIQ6uxmiWLr3WMCD28gug4
         DjdrA4qtfgtFJUP+nkyp4tBgRJ/wUW9s8UOQURxT/rnyK/Amgjr4D41jLzuwAkDcpxM8
         XAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782560778; x=1783165578;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwgmP+AIkwRVqsKscXw1JvJ/gpEoo8Dz+/YrGyTigaI=;
        b=EV3k6k1/2Kr2Xkpvozb9KcJK1kEpVjX92z55WKNNOwYVZ6nCXYWW8xV0/+vGCcQeqy
         WAXYiRVRQ7op1mlGhrRj+U11N1bv6EpzMYGEFLy4CVb7sC5mJOWNGo939Cb0OCzq2guO
         zArn57L2J1iOz3TrrsAw2GSYv3TaD4+ILD+vv5Zyt3XDX5qlA9Yi4dCjwLiKaMCRtdNn
         Ez56gEngx2/wTHEiqZxwjoGk1BP+N7Wp8NRBEOwV5WiTD54TUqB4qOWFQX1IqVzurzzg
         UskkkHxtJeBySJrItNsxpflRP6UJksiJdLAsn7I4LgYH3o0arh4mJOztOZWGEEYjlOoA
         0lxg==
X-Forwarded-Encrypted: i=1; AFNElJ+VPIIiAat9yo09x2EoFIj1cben2aG6ZVT4bAFtHYJpms/yHIKQoYkSLN504OelKjA8LL8rqaw1/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvy+R8hdKKQXkIkC9Ozje4LL/d9yY9ulIgTcDDJ72fwXznZVO0
	Os3jcZlqEuG2uSgTBZl+iGoUtGXn+iKegilYX6aRDclWxFl1lLuKqE/huwjInF6ybZqOv1nQL5R
	MveefLW/H8GSTtgLrJoNySi+NwmFh48E=
X-Gm-Gg: AfdE7cmU5/VPTCbzzgGHRNBSn64CCBRtBu5nCtfC4Vb9suMLeB5DspxAh/USG1K3xBh
	eedW9XHee8e1cZqveH3ya+yCVreJ7QOyYJ79iS9d2WzgrxzMqpAhfUu2h4aAwe43muu2yL09ekL
	cX+teED3G/SMBHpU7gjkzDjM3Rg8KJlBJZzgHEh5RlJfRbbPqBnp2r7lB7o/BNgoI6WsFqy247K
	Y8DgMySVq69AOQbnBgT77lSAC5++XjqZyyiRGoUDGmqlnml58x38QqHxnLyzmhVSp4ekAw=
X-Received: by 2002:a05:622a:15d3:b0:517:6804:3732 with SMTP id
 d75a77b69052e-51a727f36e7mr140180601cf.55.1782560778293; Sat, 27 Jun 2026
 04:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
In-Reply-To: <20260520155525.22239-1-ansuelsmth@gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Sat, 27 Jun 2026 13:46:05 +0200
X-Gm-Features: AVVi8Cf_0TYEuahTO65ACteREkW6yB49hgA0BclLT9szcFa1Y79hU8GGc7i-Jso
Message-ID: <CA+_ehUy0tbLR+dt2QQAj94AYCnSvmUgY7OEV9a+ums7WrGe5pA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] thermal/drivers: airoha: Add support for AN7583
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 20 mag 2026 alle ore 17:55 Christian Marangi
<ansuelsmth@gmail.com> ha scritto:
>
> This small series implement all the required changes to
> support Airoha AN7583 Thermal Sensor.
>
> The SoC dropped the Monitor subsystem and only provide
> temperature reading. Some generalization was required
> to at least save the common code with also the help of
> reg field API.
>
> Changes v5:
> - Fix alpabetical order in Documentation patch
> - Address suggested change by AI Bot
> Changes v4:
> - Rebase on top of linux-next
> Changes v3:
> - Property use chip-scu for thermal sensor
> Changes v2:
> - Update DT schema patch to implement dedicated schema
>
> Christian Marangi (7):
>   thermal/drivers: airoha: fix copy paste error on clamp_t low temp
>   thermal/drivers: airoha: fix copy paste error for sen internal
>   thermal/drivers: airoha: Convert to regmap API
>   thermal/drivers: airoha: Generalize probe function
>   thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
>     function
>   dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
>   thermal/drivers: airoha: Add support for AN7583 Thermal Sensor
>
>  .../bindings/arm/airoha,en7581-chip-scu.yaml  |  14 +
>  drivers/thermal/airoha_thermal.c              | 380 +++++++++++++++---
>  2 files changed, 327 insertions(+), 67 deletions(-)
>

Any news for this series? Can someone check it? Every patch have
a tag.
