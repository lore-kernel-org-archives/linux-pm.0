Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9C3DA7D8
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842094; cv=none; b=HVpHujZ098DwfM/U8WauKf84DtFpN99pY1iU7NiZiJFJIwZFB1MJQ/cMf/4fq9uG2BX2SBEGr/jaL2N7Cbm5GOySewOJT1Gk5cg42QuPqBLmpdkAcwxNttRbnTYZbZ3/yJ7oT+Brf7u00tY4nN2jfaiZ5sIbZbr8/GvwEbI4/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842094; c=relaxed/simple;
	bh=UvzEZ/uLgrl9NDF/Qan/mdqTQ9JfJbGQ1y0WmfWlBig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1NyvGGwCpvlj3RuUGXpLAS3Ep/lzBLTn/sRfwTM0JNoPxQ4563ahaG7lylQK/ZYXODn63MgNbqxpO+EsVYulXtXMMzDKeZNftezp5Qj3JcqNlj2/xnVgfMTdd7AwsptjY4B8svBMX4F+seeXhfvK68JNhlXOG1irKIKgNHwMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB0DEdrn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB0DEdrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B80C2BCC6
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773842094;
	bh=UvzEZ/uLgrl9NDF/Qan/mdqTQ9JfJbGQ1y0WmfWlBig=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qB0DEdrnaL7e3krvAzwPX9bhvpMnhJPP5ox+pNBZ8+QN7SPbVNbW11oJPGS4me3Ck
	 f+KStOkaHhTiiCkzgKXiFf0oo4cEJzbUY6fY3UJEhN9PrHJFJaeYmi8y33sYmQttW4
	 SBCThQr/XFF0Cca7ydytH4X6nBiMvfOLCpRhC/j/9ibSKJX4p5y+5L0rqO74qnsppO
	 XLe1gtw8JM53YeeQjMNJfAiVloci0q4POkDG7d3ITdejFTCi2OjwP8s6Vu11FXjZ88
	 xKHFuWfqWfOpbRC+r8FNCt+6gonUzh4ootjYqWzPe51HWrmXMjIERjnLAZAnfmlqoK
	 NuTMmB4mzV39w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so653202e87.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 06:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD/ijTWhzTEpjaxmR4Fyb6WImVMzq9ZMyPE8+yhE/mF3a2VcA7gWZD8KQIyr6yHbkEJ4D8UsN0uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXTHxE8IIxO8ecNXIFwB4k8BOl57VSQfhFZLiLUnsHQpqFZfX
	00WE8/c7wYl3CiSKecF/AuPG3BVjy63rTpOpc+VIiGbeKG62TJdMFvA/sltWL72vWfbHfi8OJP+
	f+fPJlLHp90QUVB4V4pUKxqbAbU6EaLs=
X-Received: by 2002:ac2:50b9:0:b0:5a1:3485:1c29 with SMTP id
 2adb3069b0e04-5a279597e2emr1044745e87.6.1773842091908; Wed, 18 Mar 2026
 06:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-10-l.scorcia@gmail.com>
 <c1a425ba-a4ca-49ea-9660-5de74bede124@collabora.com>
In-Reply-To: <c1a425ba-a4ca-49ea-9660-5de74bede124@collabora.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 18 Mar 2026 21:54:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64+oofwTiJTXDYCuzUEpk=zioi16i8a7iMimc_eZ1RPUQ@mail.gmail.com>
X-Gm-Features: AaiRm50qgpWw6pso0fmDKuVqzybTij2WNFJYFTn7FlTu4OnRbnNdG68B7V1oZ0w
Message-ID: <CAGb2v64+oofwTiJTXDYCuzUEpk=zioi16i8a7iMimc_eZ1RPUQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: mt6392: add mt6392 PMIC dtsi
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-mediatek@lists.infradead.org, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:39=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 17/03/26 19:43, Luca Leonardo Scorcia ha scritto:
> > From: Val Packett <val@packett.cool>
> >
> > Add the dts to be included by all boards using the MT6392 PMIC.
> >
> > Signed-off-by: Val Packett <val@packett.cool>
> > Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt6392.dtsi | 141 ++++++++++++++++++++++=
+
> >   1 file changed, 141 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot=
/dts/mediatek/mt6392.dtsi
> > new file mode 100644
> > index 000000000000..fbf6f671524c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + * Copyright (c) 2024 Val Packett <val@packett.cool>
> > + */
> > +
> > +#include <dt-bindings/input/input.h>
> > +
> > +&pwrap {
> > +     pmic: pmic {
> > +             compatible =3D "mediatek,mt6392", "mediatek,mt6323";
> > +             interrupt-controller;
> > +             #interrupt-cells =3D <2>;
> > +
> > +             keys {
> > +                     compatible =3D "mediatek,mt6392-keys";
> > +
> > +                     key-power {
> > +                             linux,keycodes =3D <KEY_POWER>;
> > +                             wakeup-source;
> > +                     };
> > +
> > +                     key-home {
> > +                             linux,keycodes =3D <KEY_HOME>;
> > +                             wakeup-source;
> > +                     };
> > +             };
> > +
> > +             pio6392: pinctrl {
> > +                     compatible =3D "mediatek,mt6392-pinctrl";
> > +
> > +                     gpio-controller;
> > +                     #gpio-cells =3D <2>;
> > +             };
> > +
> > +             rtc {
> > +                     compatible =3D "mediatek,mt6392-rtc",
> > +                             "mediatek,mt6323-rtc";
> > +             };
> > +
> > +             regulators {
> > +                     compatible =3D "mediatek,mt6392-regulator";
> > +
> > +                     mt6392_vproc_reg: buck_vproc {
>
> s/buck//g
>
> Also, no min/max voltages?!

We really shouldn't set min/max voltages in the PMIC dtsi file.

The min/max voltages are supposed to be the intersection of the
consumers acceptable operating ranges. The min/max of the regulator
itself is already implied by the model / compatible.


ChenYu
