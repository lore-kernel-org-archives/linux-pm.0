Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B503A3E84
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774503805; cv=none; b=lhm2Hr8/4cYlk2FVeo2xBp8ahb8oaz83ijJl2Zj0utpFaVCyCIlJ98RAJeEyGQQNRLJ5mwxwNUuFb22it16foA4kca8tx7xuKwMLtlljiZ+QgADVks6/5JawTbTQwYNe6wCQFWtMchgfr9zUiz627mehD1nLmIA2PpegVxZ7BFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774503805; c=relaxed/simple;
	bh=s27fcGErMBzKxY6t96v5alAOcgMfI4+l2mcmFG7QKYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO8lx2f5JNxUsYwMnFTZFGOIRZLv5xQY+Ucilz4Yvm1ffxO/JB/vSQSpuhlTrL9Ce1ZWZH38jyVnu+D5r7ftBuB+59aV04+H7tq8BztVykFuzWiV+egFuP1XIhqbR9P1K3kA1nhwjupIhwX+gq02/H/1hXTvfc0BAQ+9/F2rLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j9VIybWW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9VIybWW"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82418b0178cso291977b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774503804; x=1775108604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MC8YZMrpOiVQXaQsK16bopjggMD7NER7fOf0qrCs7A0=;
        b=j9VIybWWMartLF4E6u3VULN362czlBOTKyMl0iyYmmoAGbIhvg3XMOa6JDr0RwEPfv
         0s8bBNttKoQKhSHOwxycdbFzFsjM8f4Qcx+/rh0wlb2A2z2EFLB7wyAFHpMid1CKZCF3
         ODrhVtSkmB2Jc+j7xaCNZFM9E3NOxLvsHVvls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774503804; x=1775108604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MC8YZMrpOiVQXaQsK16bopjggMD7NER7fOf0qrCs7A0=;
        b=oxX1cVP0s+7WH0mocKOnKvndcYQfSEDC5aRqbANfPX0Z7NoLTchIg8r9Um5DRNjoBj
         nND1dsOAt1NBr+5ze/P/Pq9O0Qb7EF/baCRa3tEGLDa74nMU5jV21a5GciGgA1OgtSJ4
         QBFwHuNATJmJa0+pTsJldxd1XD0P1gfH10ExGAm6460ddRW+ZdKt5EVw3FCwHDIIx3fe
         VAy7U/smVnzPWzc7GoRcmVHEezQ5ioyCEFC2+w0hyyOJ8nwWo3qTYNAyeIH+B3WEb3EY
         zS69uVWXg3Fg2JKD272rTt5qaCFXcWGLhsjMZuSiYsfQuEuMKo68rOlUoHXDfu1VBepQ
         Ndug==
X-Forwarded-Encrypted: i=1; AJvYcCVLhGRD/Ql7Fn2q6DwYHSW8pWv/2w29u3Siqrls+qX5OiIo0u0lok0qIRC9YC2vBd6FBwshVAjO6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YzIpTU7B9bXS8WDMy9zLNaCEKLwKrDx7zcXy7A1MhE7vw+aA
	7Xyy47/4WJCRoUUtAD1L0dHTZp+33WTqrL87/jzYvzY96S9a/Vyxt+8iLkjzzEn6jA==
X-Gm-Gg: ATEYQzwN9vn5l8sj1jwRLc+W5Nsc0kpr1/xpNaWnoSU4YPSjxIAT3Q17S5bPNz9lEdj
	NAU2esjvJjrvvDF+RqWt1yyBZZJjqs3b8qfSXhFv/2+NIlOxZ0p4DoUINKlLr56KDs4qisWMdaf
	/bRgcLLQUMAzCMMPPQcjqR0iYay84twdDxuSkUG00ha9eRzBLXdUNzen+7YiSBXdU2hgU2MAXds
	CuwV1pS+JXzU9p9+heAUB+WwdKULT/6lkn1p+GuL5yTq1ikG/VpxJmLDUbgabBl5t4e29KwWhnf
	SBykwAiZx7hNPwEoqSJ07cRptQkOXsCG82j2dz63aAB712dmHLu6s9ZEPyNkmQzigDu0KzMolCw
	zOQuO1RviT7YZqpvB8U8xHG4YlJRfYkQA4ois3y8NQR2HxIhGZxxQj4WG9RpfEDbf49vfN5lTNi
	fkdQiXGuSzswkf0s8+eqYvYt2Kj0dd/GkfMKWGACCvJM11CSKjVdERYuA=
X-Received: by 2002:a05:6a00:1ac7:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-82c6dfb1e09mr6141757b3a.30.1774503803653;
        Wed, 25 Mar 2026 22:43:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d5d89b5sm1411849b3a.41.2026.03.25.22.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:43:23 -0700 (PDT)
Date: Thu, 26 Mar 2026 13:43:16 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wens@kernel.org, Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 9/9] arm64: dts: mt6392: add mt6392 PMIC dtsi
Message-ID: <20260326054316.GB910813@google.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-10-l.scorcia@gmail.com>
 <c1a425ba-a4ca-49ea-9660-5de74bede124@collabora.com>
 <CAGb2v64+oofwTiJTXDYCuzUEpk=zioi16i8a7iMimc_eZ1RPUQ@mail.gmail.com>
 <28102417-4a2a-4e29-afbd-d0f2aa76074b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28102417-4a2a-4e29-afbd-d0f2aa76074b@collabora.com>

On Wed, Mar 18, 2026 at 06:22:42PM +0100, AngeloGioacchino Del Regno wrote:
> Il 18/03/26 14:54, Chen-Yu Tsai ha scritto:
> > On Wed, Mar 18, 2026 at 8:39 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > 
> > > Il 17/03/26 19:43, Luca Leonardo Scorcia ha scritto:
> > > > From: Val Packett <val@packett.cool>
> > > > 
> > > > Add the dts to be included by all boards using the MT6392 PMIC.
> > > > 
> > > > Signed-off-by: Val Packett <val@packett.cool>
> > > > Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> > > > ---
> > > >    arch/arm64/boot/dts/mediatek/mt6392.dtsi | 141 +++++++++++++++++++++++
> > > >    1 file changed, 141 insertions(+)
> > > >    create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> > > > new file mode 100644
> > > > index 000000000000..fbf6f671524c
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> > > > @@ -0,0 +1,141 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2019 MediaTek Inc.
> > > > + * Copyright (c) 2024 Val Packett <val@packett.cool>
> > > > + */
> > > > +
> > > > +#include <dt-bindings/input/input.h>
> > > > +
> > > > +&pwrap {
> > > > +     pmic: pmic {
> > > > +             compatible = "mediatek,mt6392", "mediatek,mt6323";
> > > > +             interrupt-controller;
> > > > +             #interrupt-cells = <2>;
> > > > +
> > > > +             keys {
> > > > +                     compatible = "mediatek,mt6392-keys";
> > > > +
> > > > +                     key-power {
> > > > +                             linux,keycodes = <KEY_POWER>;
> > > > +                             wakeup-source;
> > > > +                     };
> > > > +
> > > > +                     key-home {
> > > > +                             linux,keycodes = <KEY_HOME>;
> > > > +                             wakeup-source;
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             pio6392: pinctrl {
> > > > +                     compatible = "mediatek,mt6392-pinctrl";
> > > > +
> > > > +                     gpio-controller;
> > > > +                     #gpio-cells = <2>;
> > > > +             };
> > > > +
> > > > +             rtc {
> > > > +                     compatible = "mediatek,mt6392-rtc",
> > > > +                             "mediatek,mt6323-rtc";
> > > > +             };
> > > > +
> > > > +             regulators {
> > > > +                     compatible = "mediatek,mt6392-regulator";
> > > > +
> > > > +                     mt6392_vproc_reg: buck_vproc {
> > > 
> > > s/buck//g
> > > 
> > > Also, no min/max voltages?!
> > 
> > We really shouldn't set min/max voltages in the PMIC dtsi file.
> > 
> > The min/max voltages are supposed to be the intersection of the
> > consumers acceptable operating ranges. The min/max of the regulator
> > itself is already implied by the model / compatible.
> > 
> 
> Your point is fair, but it's also true that some of the regulators are not
> really meant to ever output anything different than what they are supposed
> to, though, with slight variations being possible... I guess the best option
> here is to leave declaring voltages to board DTs instead, which is sensible
> in the end.
> 
> Okay, agreed. Let's go with no voltages.
> 
> Reminder for myself: there's a bunch of PMIC devicetrees to cleanup in here...

And to be honest, even the default names are not needed. They are again
implied by the compatible, and even the regulator's own node name.

So either we could have a whole bunch of empty regulator nodes with
labels for easy reference, or just have the upper level "regulators"
wrapper node with a "mt63??_regulators" label for board dts files
to reference and add the _used_ regulators to.

If you agree, I can do the cleanup work.

ChenYu
