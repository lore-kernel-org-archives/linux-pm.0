Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A544103D
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623977; cv=pass; b=r0HWHHlONiJrTPo1mqIMPH1mt4sb2cOaBqM5cTSAyIfPMG4zKGIsOtaIu0/XU55cuHspzgKFPI9CVyn0xX30mC2Mt88VPuIvrfrEvIaq9LDVZGMJsWDEaYXwxAABme2+Nh4MVdf2GJSKz1ITvB8clE3nmNTnEgz1XHOHlReeifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623977; c=relaxed/simple;
	bh=9ryEeEKN34qoxZ5iOwtkmdOLrQqqwl0md2Lu6yLAkww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuvRuqqpxDvzpxnECpy1DrFhGR+Mul5gIP87mo3HhLBCpknLQ2vV8FafqDRXj6BNZq1vxO9DfqSBKVwJqbM0EyVSegBhPvDZjjXjVbUJXzKAXLRyh1ZlnVz0P31UFa5iC3wBEv16XLk/ZZR7b7DLcF8reW4G2c2o6UoqT/3O604=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onak4tcL; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onak4tcL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so8003849a12.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 08:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623975; cv=none;
        d=google.com; s=arc-20240605;
        b=OZEulXx/edHgvsB+ugGzsT7TXTB+nvG9o/Dd4gCRKKohCc1S/03abmIecpI45+s4dT
         MT6inRF/9YEzZXG6vZRELp+Pa4z/EDRr9E1Lktn3Wx9hjX3enyqxGf/kO6mbDSQ93dRx
         daI317yUMwVgWSZ2rZp1OdhkU4EXmKpOmqpkZaLXn2k0GuQFaCMDBkDKtITejMQUedP0
         UgA2MHrDzx25hPn9M771uTh8yh5j3Q1JmHIqaG4E4/6Q6nF7RhXFMUwVpkoQufCf+TLM
         juPAD2DiM7vlOgL2bNqSu3FHfD2/WZzrI9MwYgiV4vxLCL1E8ZAyKAkuwtN77H6JiNsx
         QDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfw1ICkm7+kbiLyNwGHlM24bHrY+azb4TocUjKCxBR0=;
        fh=vWEV8F6ydIhMDH3iQUtDb3lobe3DxWq0evgRKjzCEfY=;
        b=GYFTWf1lHwzfoBncyGT6zUx7jH4TgZW88DaddgR0QFi5KtmxQtXqByRhisDqiR4P4P
         g02Dl+KXqhpumfz4LL0Xlz5wvdEG9EZcgKxuEYACqDl7i8H4XGMB1bX7tobrfApflaz8
         0HeCHo4l76rqkxsIz3Ilt7I2u1QLiryRFNXvpDWmJs0aIOktMUdWBDv5A7vOM4+R4za/
         Ojc4NyMbUzBXY9ilKlLRAh2ragzfUiU0/atZAzWPDKcVndrJmYbhV7wInEyovhPOfpTJ
         1wduIkTrMGWBarvCiefR9ou4iHURwBu5Cv1Sl+WiR1uHkLLP8Nsr7soiec7LxrsloHFK
         /VGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623975; x=1782228775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfw1ICkm7+kbiLyNwGHlM24bHrY+azb4TocUjKCxBR0=;
        b=Onak4tcL5vSFVX9zbAMb5EL2enSwZMolN7dPWdBSvZ1YfGpRrRAmfSvARvhFef6wof
         cC1Y57VJB8c+fnIbL1ggRxC/ShwE7AfDkiBBgip58TToDiFW3fA3wUAG661aMIgBZy5E
         SvYJygCDWsbciA7gnkRjAf0+6qbp5J+oDrUfJJ5CuV89vaDeClKgzEYShVIN39M5na9F
         MtV6ZOalGVHYMCzSzsjn8b7nV/wOPpSRMDIDsiqHMOOnPd5gw80xGoQ7oxiDqIn59UeP
         HaACvImgUJGUu0jZ1c9ookZx7k8MQ1W9qy14X226sVAmTI1chWtEuNtxtyZhbUXP+Wvc
         exyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623975; x=1782228775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfw1ICkm7+kbiLyNwGHlM24bHrY+azb4TocUjKCxBR0=;
        b=rS+Hv+Bt5UJTRBOiCRD/FPbC8p4zcvKZH+T82OpM2GW35c4tKYfZvH5UVn9QAuuHQH
         0CHsN5OzdLWzZtVR5F1w3DBHvYyQGnq+Qb597m9MdiMTqxd5wgLYXJJ7D2pgqoBORY8r
         s6M/SFqdQxbvyV8I4/ol43rNpBzTa7UdjrfCw7qx1xRnhycU701foU8WROdxabxGYubG
         /I/EPOZ1Pr4KAUGgCexxIy9dkOvGjtKfNmyt4Udg1to6oI+n032qHp9LOeqml8CJzEU7
         gFAaNHgo5A0ygY6oke5ehXKGSNjEinQzOPZ6NDlmJhajNDoa2OgXf3f+nf5T3KZajJFx
         jwyA==
X-Forwarded-Encrypted: i=1; AFNElJ8gVNCZu9wPyuf/9p+58nyWhaM5ajiF0VhVGLpjnoSw2GVpvZG4tG26YUKqsajaw+DABN7M+pwyCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTadxVZwyEUob3Iz4dCcVh0VOvaak16GSWfpBWWKf7bF2PlysF
	cN2MXfSBlm8nLQarKGGX9UIdgLbb0JcTJ5wQHBU2b7ZoZnMxObW/6z5eGsgKNsAMSDL7JwPsaY7
	hB8PDMt4c7kdp2jhoRDlrPMq9sIw8DNM=
X-Gm-Gg: Acq92OE28/V6zXZxGegXig17OFGylMSkQ0ogkN09p/u7b2WGyIbFJO3jm+woMqDAGsO
	ejrFTxNFYztfSMuTApeGjYQVLn1AhF0XiWg12Phibhbk+Joquq7Dq9uh5uOnfsrsxgnbGgnQjf+
	f/mMokGHGtaZID6GATdnr7s+vDyZRcATe4oIOy4qz2L7BQU3ntvUWzzGBgEZHa9O+0sLgS6mNP5
	A89D9UnzeB1rwAw6x1TO6aMDM9Vl7AvFNXaca6ykiXL/bBq/efQG4RU8Ph50T6DUQaFhrXO3Lpd
	8ScIWg==
X-Received: by 2002:a05:6402:3488:b0:68a:c8c8:bf70 with SMTP id
 4fb4d7f45d1cf-6950875d069mr2423072a12.26.1781623973864; Tue, 16 Jun 2026
 08:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615071836.362883-1-l.scorcia@gmail.com> <20260615071836.362883-10-l.scorcia@gmail.com>
 <20260616133918.GA2335264-robh@kernel.org>
In-Reply-To: <20260616133918.GA2335264-robh@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 16 Jun 2026 17:32:43 +0200
X-Gm-Features: AVVi8CcxGgSJDcwyWDi8AM7eUTYUD6802ufCx2_1yb4EtV-skFio6HexhMd5f18
Message-ID: <CAORyz2LiMHnaTK6QnsLxJDtw0fZ_N9LELw0iCorOZwHuWXus0g@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
To: Rob Herring <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 75 ++++++++++++++++++++++++
>
> Nothing is using this so it is a dead file that doesn't get tested.

Hi, it's not referenced as the dtsi inclusion was removed in the
original patch from 2019 for an easier merging of support for mt8516
pumpkin boards [1][2].
If you prefer in the next revision I can add another patch to readd it
to the existing pumpkin board.

I am working on a few boards with MT8167 (Xiaomi Mi Smart Clock,
Lenovo Smart Clock 2, Sony Playstation Classic) that reference it and
these have been used to test it locally too.

[1] https://lore.kernel.org/linux-mediatek/20190323211612.860-25-fparent@baylibre.com/
[2] https://lore.kernel.org/linux-mediatek/20200229170401.1287324-2-fparent@baylibre.com/

Thank you
Luca
