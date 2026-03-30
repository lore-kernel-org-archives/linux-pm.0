Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9A3B4E9F
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863369; cv=pass; b=D6MWJeLMPyNsvJK2BSmpLHiqWIDjNoMDAt8/6CUC3CoMHznsQwSF/783fGWEpilsbRR9DWNCp3GpvDc7ePqbWoLoqMWHdQnkFiRoLDptCm1SD/S83jMMrlk8tQrm0Q84tMfuupruBi+4yqRsaYYqH1EAkq2OwtcBCpmRKUxWB24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863369; c=relaxed/simple;
	bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZU5gPI8cb6t2kGSM55G0X/4EpvHSwgjK8K+NKG6VYfb+9yhxly7doBdG6BJhDRJcgaZzLtUMgqcN7qnOgBoZXyUdfaHPOAktl2RF5roD88WyFcpM189T4RbmGfHagm6R9z4Tgw0SZLzcYOmpWSOlX8ZmYU0iKqvVWDQaj/pxb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRSi/7ZD; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRSi/7ZD"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a142464316so4541972e87.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 02:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774863366; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWsk1g/5FInCyPpPPbtk70fxCLUq+zycZ2Qc9VDiE0b7qLb+DUa/fyI8eE3nhsjkc8
         Cr4qVCE9iRzevtWYZ37S0kWlF+P2PLomHS2/umleXqYcejWkTdIBlYe8p6nAfM9QPpgn
         6helDG1fSu+L1XI9d8lK9x/DKJvTJST0u1s/tjLBv+9WN5Ol4li6lN5KigRyRBP0Ehkq
         19A5svza77wNqGVcDeyBSvIxwRmYYabp32mZtTT/LoLjvF3bVh+1/q826uCBcr/uHPnh
         6ml/OMsMad6lWj8dv52CR63dALKnOD4VxlyROEbshPy/G5g0m31IQU8xxJTROkOTrIFP
         L9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
        fh=1uYFIqB4kAfEimLiZS1mSrlnrt6FvHB5NEMOUM8RbkY=;
        b=Sgfu9vp3so7Kl1bzaq/zYGktR6PHKUgq8IzOzRdByVs4rORDr+7dj1NvlZyTHA9/z3
         sURYnwVckMgazVrB7qeM+c3fLixdmPdjJTcqcCDU1vqV71uY2Db2+vmfqSmk4WjwRHgL
         KsewA9xAlk8kpu7xbXZmj7/1oWqOO6znirSDIQmWHmuhozAtWEbT+aubr4aibhC9wckP
         KlH8ll84csnDr/s/0eYcXwK6ReUHjCJhUojP9wttRfW0vYdBJS65FNGmHrlRdXfapvyg
         FIeNjMwG1pneIgTtlA9z8YNbjbk/x/X5j2ymFLqURB8jpr9/dNBTL03Q1kxzA3XtecKe
         Dlqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774863366; x=1775468166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
        b=CRSi/7ZDuKWXilmc3FY+3Bnk1VRP9QLydDioAxl0zVSANh9b3dNbIkgLYE7FI68ATx
         yQvP0+gZtynI/Q1XoCp3oQqWbcR6MGRFHYdRrIz3J7iFqtFI7xxpTZ61l66YqDHcplnG
         SfBkf0byTHORQQ5Ym3pTSE+56AiX4bTMlrk9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863366; x=1775468166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONNvpnHIrrlZOFnwwhyENzcT4/Pw+OdMUWkbXsdiH4Y=;
        b=FdDH5Ey/8UHZAtTBu2/P6UHWdQ2iu0AmPZZkxby9EM51u/Absclb6mFQwZ/3Fs/p9C
         y1Poh7ipEoD2HJZWvkmN+6ou9HgNr+6QkbEVWrMq/66UXKjhdUSS7pwRosP/wniqs1a0
         tpyrA22ls6XbrJShNFJ9vOY+EWKb7Y8hfkkeANeYUThRgcTFWQqKbhFOABCCX4C8mOhe
         2sMfSY3oqwTwDhlRPXHRy6K9OHWNMroLRwgULgJ0uEoksxvsQVep9akfURBbJI/ncHb6
         c9zN9VjjixWNZEN/2Q9EToBFMiWZwMOF82bwo2l31ECcG2XFlagKPc5LJTIkLdGvKp6S
         UdNA==
X-Forwarded-Encrypted: i=1; AJvYcCWp97vbnrSoKNgO3ssWyLHLheX3B1p26MrgxngNdeCCWpnqhyUcMFK0wLPHmGpVwqc4hJVd1NM4Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oG+fLPW3fuamxttwgmTYrANWcEkD8OvitOi+gi5ZOQwpABJn
	BuWqhk+nRmbe0Luf2xpNXb7adHbD+b40o076nyHtFRIgVPVCSH3PJhitSGaUwUx+SzeD5exqmDG
	9+457d6jtN1az9sW7HIQtGkyP4bE3HUH9X0hLDO6z
X-Gm-Gg: ATEYQzwmWC3xRG9dvnl2rA7S/5v+jd0R7PNMnyE21LaW0Jbidm7VWeyCNYyuj0l/0oj
	V0D3rcFk8fArxQevt1YEFyyM0QG6jK4+RKNysWp14jsOGNcEj9hWgrbMSk3+edFNnHwdMt0tBkG
	QQe8dV1pheZATbHd3PD8qxOtsO6Qpvamu5hNo9w7U0FpPDMBtef12M97BjSd4Z1V9CFlarA/YT+
	LHucR10A9K1Xzh8T5KWqqnKHHkb1vaTCBFJi8OlIWBHTSu+EVDTwBlp+Ill/astG/5gK6TLEUm9
	fHrHrlhAYq/fJg8PxuHcjbgXtUWoWwYNr8te
X-Received: by 2002:a05:6512:3f12:b0:5a2:7aeb:e7b3 with SMTP id
 2adb3069b0e04-5a2ab92ae11mr5011592e87.29.1774863365955; Mon, 30 Mar 2026
 02:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-8-l.scorcia@gmail.com>
 <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com> <CAORyz2J355NZH=7iQ9sTDBhAmtjP7xTpXe21_3Z9J_R5YvdXAQ@mail.gmail.com>
In-Reply-To: <CAORyz2J355NZH=7iQ9sTDBhAmtjP7xTpXe21_3Z9J_R5YvdXAQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 30 Mar 2026 17:35:54 +0800
X-Gm-Features: AQROBzDDuO289B2CM0DmVnpmaCFifXhpUymo-5rQ6aPBkZTqTiIMBWQIo9x2VA8
Message-ID: <CAGXv+5HRWRW=+Mk2z4qCPrF7zFax9zQJ70Q4ihR6PkWJP0OUrg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] regulator: mt6392: Add support for MT6392 regulator
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> Il giorno gio 19 mar 2026 alle ore 06:04 Chen-Yu Tsai
> <wenst@chromium.org> ha scritto:
>
> > If this PMIC is anything like the MT6358, then it has 0.01V fine
> > tuning for most if not all the LDOs. It is sometimes needed as
> > a rail may have a 0.04V boost that would otherwise be invisible
> > to the system. And then if you have something like 3.04V set in
> > the DT constraints, you end up with something the regulator driver
> > doesn't support, but the hardware does.
> >
> > Please see how it's done in the MT6358 driver. I spent a lot of
> > time on that driver to make it actually support the full range
> > of voltages, and describing the supplies.
> >
>
> I had a good look at the datasheet (MT6392 PMIC Datasheet v1.0 08 Dec.
> 2016) and unfortunately I did not see any fine tuning option in there.
> I'm sure this data sheet is not perfect as it's missing some regulator
> registers that are clearly used in the Android sources, but there's no
> mention of fine tuning in that code either. I guess it does not have
> that capability.

Well, thanks for looking. FWIW on the MT6358 / MT6366, the main voltage
control and the fine tuning are mostly in the same register. The fine
tuning is described as "calibrates output voltage" from +00mV to +100mV.

I looked into this because the LDO table shows some of the default voltages
with 0.01V precision, but the main voltage controls only have 0.1V precisio=
n.


ChenYu

> I will shortly submit v4 that hopefully addresses the rest of the comment=
s.
>
> Thanks for your help!
> --
> Luca Leonardo Scorcia
> l.scorcia@gmail.com
