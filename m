Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071E3EC2FF
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938617; cv=pass; b=Xqn2wZrWjapOogCry6D99I5dgLEuitMptmozE3+1NjBKhePKgfRWhppw3yf33thsxbwAFyLAeAw6aqGIeLDG+TNqVtVscFFpL7AiMN1dMF0pXxrUCkHccv2qXJli2LEZ/UEhOSm1HkiSjoZggO5040tLV3dgncVXFfXUcJtJELo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938617; c=relaxed/simple;
	bh=l0eU5c0HgKDSlNJCITX3MHjJtcSK/SPj94MpY96kAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuUy8JkfZl17ioX1J1bbFBzwuJMmU0PsQNaRQLub080BdzdbtS19rcojZ0/i777RTGF/TRbo9SNC0mVx7tLJi9GG5rOAcmGlcxB7cDglWyJK++AXOIMQbTd42M3tOACTGhG9JqbwCtKyqdp8O6czQGGfrvn86PDOB26gmrBAPO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbGhuo/r; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbGhuo/r"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3878de20527so8793571fa.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773938609; cv=none;
        d=google.com; s=arc-20240605;
        b=TrD0+ezp+zpvlYuHVi6LCls+iIqDsjlsq6c1+dQwq0Y0qsxYW8SkMMyUolSfSdOoMR
         D+RwwwuvjOGDoNs41mvBDg07l2LwxL3gaHtVi5CrkTh74r2xWazyu6+ehEaNqrv33ful
         dlNv6l+McENePi9tpRfWflHUZVqRsR2N2P4+t17hz1W/ssLHpLV7ZNR3T5RSpsK0XuJu
         GCoBJsSsen/lPGaprQaygz5M/iBVC+jIwetwzQG37gMLJZUGyorqdxUFd18WoDCOu6e0
         58EruMQ4BvHRWWFBkhz9NRJlrvOq+rKfNPuAhcjJJmgkCv6U08JegdWNcSyP0kZVeiWF
         A6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0eU5c0HgKDSlNJCITX3MHjJtcSK/SPj94MpY96kAVk=;
        fh=iuPWaKv8uAlk4SWGGSGRvo6g7+b0o2iadtptQmDuOMc=;
        b=dByPFo+oKJjac/Ci94RzEJlrt7q9sJpCkG+SmOpMNWNRJ+a9R84eiKNCXyKJ+SawRf
         MgwYmRcZGOeA9swuxV1qXNU4rE4P8PYc/Euaf5myeVbFZylq64LxYNIGOb7SlPbIlM6O
         J//sH2j3kPwbGv3ovXQ0NhLr4T7a0yMcriOxxaqdpR6C1+4pKc7BH+jIDSAy9K1TjvL1
         ZeNcDqY0CPE+d/RLcV3RyDCmUPT6Viy1L0hrPGT3AM2ujA+PgMSfudBvsUdXUvS4utzi
         zqiT/u7pfmD/j6mC69HMmz92AtdtE5F8GH5da61DEl44MrX/KFjoGvY1pZJyXCYHS5IW
         PIdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773938609; x=1774543409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0eU5c0HgKDSlNJCITX3MHjJtcSK/SPj94MpY96kAVk=;
        b=gbGhuo/rG1KM01mbmrI/+n1PIhq6yLZERMlC49+Hvy5VWBMsywIYe1BtX10hy6z3NN
         Wq7WOe5trpwgbz9VXuddO7NeUPzPLCKRqvlYHwRXlj2ypsQt1s7F/4l+uoVfHhs9la5S
         Y1bb4CQexfezFo5JZPV7ZJ8PE4PVUdw+vPyAj7YcQz7nvo8Am1XPpTyUfE6iUY2pCk1M
         HU/eH4nTrEPb3S2WVOyONRbuBE8iJsJnubWqzp64+/xrtra6Ih4tNuFaUE7vczLQZSKv
         zEuHALM0AbYRZ6mkwWYUNcpM0yeSegF2olmHzpb55wWbrwOaqo0XM/X7RFlbmOUIQQj6
         fKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938609; x=1774543409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0eU5c0HgKDSlNJCITX3MHjJtcSK/SPj94MpY96kAVk=;
        b=FLHm1qxnnG58ms7632EWxMQChOpDE3m+Y2Rn4k/fM976DXTvqNcITQB2Lih8nEBMXr
         GkEKSV2MN0Y1XnGuZIHJwJDzzH4nPjLpYHChxpw+HIaYm3o/xN2psuH4Y3UQZqwNIuxE
         sQ9S9Xvn1kIoNIoxp8AeIaqgU+dG3wAH6c7cFBDobJcd3uY9OMU/vjum8OV0FS984Z1V
         2fONNcOoTQfLoZc8PgMK0MI8251MJ0vZxideWoGL7cbpPuM0+KQGlHGIo0ComdB3iJTA
         YIrCgLzzu6TwZZuaXSgczPjxiD8gPBOyF1wqzh1rfMnp9a5uruGrgrJDaCZn4uZJTLKn
         PZyA==
X-Forwarded-Encrypted: i=1; AJvYcCW2HGRuAcip0IbLZA4WkPuQH4Gy0Rzit1bGWadDk8Sec32N9Ly0QHp1pf0c1Jccbx9RS+J3ezn1jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAbXHEu9QihYg1vT1qIyCiysuBX7x0krPw/eCwaxpmbpm/rVn
	EsB+ryhjuElYLbuoYGAwT7jL8wD9rC3bmJgpPSj6DCqYfruLrYe5JNbyYQWqyHNdTIwd/PVdYoc
	5ieG2FgG+ELmsnLAdIVF5WqzK/mqG99yg1op7jioC6Q==
X-Gm-Gg: ATEYQzwydTisRY1dRM2UNUj/uiEQRIOxcylvJRZsZhN0Dbch/doFCVzLAs6E77/l78W
	7TN2awAstFGC04eNxk6vmk97yrXMox09NzWd82VuMD4+9vPEMaRRJGvEdLIQxrYY4mPaLM6Gj4H
	Ba5+iGFr+d6UcdNOMxwqb/efmRcYAaKDWqYcjZm9jPycpbu7dKCVGf956vxm99kFJVuyrLnjoks
	UjhOWS7kYZznXc8m3/VEnuyvXpqdtkX1DJSVq/KGOGDjrkqNVxqJdMvLbIyPJrISM1s+twPDCmb
	Y9HjUzT+
X-Received: by 2002:a05:651c:324d:b0:38b:f0aa:36e7 with SMTP id
 38308e7fff4ca-38bf96ddf40mr439181fa.31.1773938608940; Thu, 19 Mar 2026
 09:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <20260318-gs101-pd-v8-5-241523460b10@linaro.org> <CGME20260319101424eucas1p2d5dca06240e8760046fb40507ffb3bba@eucas1p2.samsung.com>
 <CAPDyKFrprMSLOBMB_BHbi=j6UXV4dXBn-H8M1BsqDWNSCJwvuA@mail.gmail.com>
 <c5ba58fb-50f1-4067-a099-97169ea81f68@samsung.com> <ae31c62c940e99077d44e1935465dce7db0e4c06.camel@linaro.org>
 <4809918d-fdf1-48c0-bc10-fcf75837cb81@samsung.com>
In-Reply-To: <4809918d-fdf1-48c0-bc10-fcf75837cb81@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Mar 2026 17:42:52 +0100
X-Gm-Features: AaiRm53oqCm_eJUl4m-8pk5SCQoZ-_Pm5z0ieeorC9RntVzrStWwABAEThg9uu0
Message-ID: <CAPDyKFp8zsbgRA746Sds+1y4C0FvyohF7AFVsEghVkhukGZafg@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] pmdomain: samsung: convert to using regmap
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Juan Yescas <jyescas@google.com>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Mar 2026 at 16:57, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> On 19.03.2026 12:58, Andr=C3=A9 Draszik wrote:
> > On Thu, 2026-03-19 at 11:29 +0100, Marek Szyprowski wrote:
> >> On 19.03.2026 11:13, Ulf Hansson wrote:
> >>> As a follow-up patch on top, please consider converting the open-code=
d
> >>> polling loop above into a readx_poll_timeout_atomic().
> >> This has been tried and it doesn't work in all cases required for powe=
r
> >> domain driver:
> >>
> >> https://lore.kernel.org/all/5c19e4ef-c4fd-4bf5-88b3-46c86751b14e@samsu=
ng.com/
> >>
> >> Probably a comment about that could be added directly to this code to
> >> avoid such conversion and breakage in the future.
> > I am planning to revisit this in the future and am hoping that we can
> > figure out what goes wrong when using regmap_read_poll_timeout().
> >
> > Hopefully such a comment would only be short-lived, so maybe not really
> > worth it? I can add it, though, if you prefer.
>
> Well, I think I've already pointed what goes wrong with
> regmap_read_poll_timeout() in the above mentioned thread. You would need
> to use regmap_read_poll_timeout_atomic() and modify it the same way as
> commit 7349a69cf312 did for read_poll_timeout_atomic().

Thanks a lot for bringing this to our attention!

To me, it looks like the regmap helpers should really use
readx_poll_timeout_atomic, rather than open-coding the loop from the
regular iopoll helpers.

Kind regards
Uffe
