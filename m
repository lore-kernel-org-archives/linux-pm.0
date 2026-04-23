Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC29203710
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916019; cv=pass; b=EXCz7cgzzTlnVQm6twPwLH3I/mBhpWoekiLLuJPQNttsPWD0AyKq18QiDHJ5i6WHH8kpCq8boNzBdHi3NCK9xzuC9OiMsi9GMj+uT/wY7oAs2P4fbDyz8XPENRo+NbMDfkr1WkV6v5v3IEzxDHiCEx7CE3FRSWUdPprx6FQyGiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916019; c=relaxed/simple;
	bh=WeNkOMzbwUsxL+mQAEdQI1bS1CFi3gSHibm8joPuWt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPPx6V3VneKTBApbxKvGHG9v1f2flc9NsKJ9SVu8p9a6L58o+8DQ/c0Bcj7ruNFxeP2EF6cznBpVJ3Pb+mrURbf+GTRF7E+Tw3HdPGDummRjSjHlFupP/nd8oBMniY7uxUOjirD0zEFYpLtRtC4RtLt0qu7sLTt1rBZto0QdnD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHhGTmla; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHhGTmla"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b886fc047d5so1104670066b.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776916016; cv=none;
        d=google.com; s=arc-20240605;
        b=NXD/fwwnYWiQTn6Ho1zrf9inNDkvIKU9v0dFoz1NfoCa9/VcjczUYvGrrWSn4r39yd
         cNm0+HrelUnyu4yWKsISBmrFbnj223FKncBJfIHgdn3Tib5AwgC4S+eHnoZrgNrvhmhR
         pjQV5Fj7hmGgeOIAnfDlKxTWamquYpWpXWKYpn2kO+7F58UQ6lX38PuJd6+Zzb7cuDXp
         Ch8pCdyi2J/J1u9ImhnWaOm/sCHvaIEpE02/dprMiQTjn0YatAuvNUbxudp/KCpn4CRB
         5eMrRNVbBpIWREJoHjcvR3cJrzgSW9ddypr/sJ/xZ6hDGK2HrqQ2iZAYmCWWcd6H7F4G
         Bt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9GSW2Phd9oXEma1/9uB2odB8s4SQeX9sU39sUkX9FY=;
        fh=yLknprOYUcG3K1FX0Vob+5OsEFmn+BvQnRsEFQ0oaNg=;
        b=HJQf/Mz2m5yyY/BzmQvx5nBJf8xkzeyrQRcwYTA4zudKYgJN2qsvzEf4r2Gu8GA601
         SiG5Hlqs5I+uwKgczOnri5h2/OfIBdXYEc4aIncjHVRR2S+2JkwMlLLrhoa6OaZ02XD9
         dkQvWNHL+HfJ2Wr9hE/H8TNC/wgSGaaLwwUaIN8JnMXBRVC0MQXUvlKBdZB/+5hyWUev
         XkChsE6Mw3SEi01oIl3NM+stmZEFaYVlZKeaFK0N1wlkLH6tc6kqeXx/QnuOOItJRZ6R
         ws1mQQHWTd92QJBGODqS/Ad1p/E44whfXTxJOK3hKQs9StEViX/2gvBXDehmiFaZ1jBj
         rntw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776916016; x=1777520816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9GSW2Phd9oXEma1/9uB2odB8s4SQeX9sU39sUkX9FY=;
        b=lHhGTmlaieYH55/zPwV+zLy4DF34PgsYfn1vRiGRrV7Lh9gOqRo1rZOZyhVTaOunQW
         oFb1aLQV5zCirfs+bcUX+iVgOWdXc+Q73e2iMowE0n75JSKV+3Zu6IPVyThxJWtzNBz8
         NZ8CQ996VJ41yicjPK6VV8bnqwoi8MzCDRYjdeb0MsHx4HyLFXd/gz7BJ2VAY6PChUrc
         CgbFRuN0xDc3N3r1LhbjCPb0K/YHlwBGVEV/E4rxbozEGZrCW/h47zSFFx2A3bJGXbru
         SWIHhUjq0ggFCFzHA5nPzp6KIKGNEuoKq4WKoudqjn9Sjah7ipA6QTeSYhANMnwixBKM
         82cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916016; x=1777520816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9GSW2Phd9oXEma1/9uB2odB8s4SQeX9sU39sUkX9FY=;
        b=Eg/BHA2rz/NT1KC79bHnLKtoDI96CJafmfezUcceymTzRC5nv/xr+H5RzQtXVKB9Hh
         pFBpRpzm8I29bo7g1DAcJpOJukZsZ9nAGf0SMxzaDykqlHqb9OAYnoMvQRP0+Y8oJFMW
         e6dK12JX9Yf5SUwR24K4HQcY/rgMzUso/A9XBRvdn0iHzRu3/zS62MZOaCrSst4wzpZi
         KtCbzlxJtwuiuCdKGco+R/j/CFZhfu/XajgrroGc9Syzoc5BjqG2YPPX5diTtKuJ2Yie
         MUtYp6mhcMCCKIV6F7VsNsXCRxqpQCyTCaCh6FBf4N6i7XK2QhhqSXJIHV5nH5Qncb8c
         K7+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OFnY7TQZwhhCT8cE9rPklWyK4/SKz4erfJ8EhGmVKSA6E2O5pv1ldkS04jFJ2li6yOiIxAlIqxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnsu2a6ZkAYeKCK/HKrZ2tYfA0MoL6D1LnBfYfBJ4x+2C3MDt
	YJZgJffWjDceLE41QbCmYORUWiyPYVWDCY7mxRgWS+rytoAScTo8KvYrq+hjjOkgRTpm8eNC8ZJ
	EveuhVKDy8LFLEsXivuFFtaNdfXEJrUQ=
X-Gm-Gg: AeBDievHlQF+q2FX/nW/dE87iZzq2W3u0OARCZe/RM+0xflU/WxbF5kSjvl0k3xQw/E
	8c3P3kV+ZeifnWZAAOkMOMQ7HrUbGbKs+4PuzB5MOT8pi5ozKFIB9qxUf8oarS8Qs0GMPrk6Zse
	nr2FgWuZ30W4dpcin263DxHQLYKhQHMDROAPX/COBktZf+mKz2frA3UpctqI6de37PWtWRQ24ST
	k5NYUuCIn1xyUf2/mxRFLd7j6RQEaZebu3NUkPKCzbPRfezjP0AI5MTLtI/EqWgLqqFlRHKcgtH
	di69ePc6Y4H0/2M=
X-Received: by 2002:a17:907:1c10:b0:ba8:7b3:176b with SMTP id
 a640c23a62f3a-ba807b322c2mr525199966b.49.1776916015972; Wed, 22 Apr 2026
 20:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
 <20260119-patchv2-k1-thermal-v3-3-3d82c9ebe8a4@163.com> <CANAwSgTOmbb+Vzhck1riVaFM89zYLdMe3dn6DRHrc7p+rkR2DQ@mail.gmail.com>
 <DHZM9D696P6G.NVPMN20XXM3H@mailbox.org>
In-Reply-To: <DHZM9D696P6G.NVPMN20XXM3H@mailbox.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 23 Apr 2026 09:16:40 +0530
X-Gm-Features: AQROBzAWkvO9UaeaqqzBdwiPl2IRb1rnMdxCjeOVlETl66PPfZzCcgEwKW1aUrg
Message-ID: <CANAwSgQCOoC7aZWhekqmVS3OTTyzTyDaSxsTsdfMUphxx8vX+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: Add thermal sensor for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: Shuwei Wu <shuweiwoo@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuwei,

On Wed, 22 Apr 2026 at 16:07, Shuwei Wu <shuwei.wu@mailbox.org> wrote:
>
> Hi Anand,
>
> Thank you for the careful review.
>
> On Wed Apr 22, 2026 at 1:56 PM CST, Anand Moon wrote:
> > Hi Shuwei,
> >
> > On Mon, 19 Jan 2026 at 08:13, Shuwei Wu <shuweiwoo@163.com> wrote:
> >>
> >> Include the Thermal Sensor node in the SpacemiT K1 dtsi
> >> with definitions for registers, clocks, and interrupts.
> >> Additionally, configure thermal zones for the soc, package, gpu, and
> >> clusters to enable temperature monitoring via the thermal framework.
> >>
> >> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> >> ---
> >> Changes in v2:
> >> - Update compatible to "spacemit,k1-tsensor"
> >> ---
> >>  arch/riscv/boot/dts/spacemit/k1.dtsi | 101 ++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 101 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dt=
s/spacemit/k1.dtsi
> >> index 7818ca4979b6..0fe7396ea6e4 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> @@ -338,6 +338,96 @@ osc_32k: clock-32k {
> >>                 };
> >>         };
> >>
> > I feel the thermal zones appear to be configured at significantly
> > higher temperatures
> > compared to the thresholds typically used in commercial-grade and
> > industrial-grade device
> > test environments 1.2 Test Environment
> >
> > [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone/k1/k1_hw/avl_veri_sop.md
>
> The official definition of this temperature range is as follows:
> "The CPU delivers stable and reliable computing power from -40=C2=B0C to =
85=C2=B0C,
> complying with the demanding requirements of industrial applications."
>
> [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone
> /k1/k1_docs/root_overview.md
>
> Therefore, this does not mean that the chip cannot continue to work above
> this temperature.
>
> The datasheet also defines another temperature, the Junction Temperature,
> which represents the chip's temperature limit. Exceeding this temperature
> may permanently damage the chip.
>
> [2] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone
> /k1/k1_docs/k1_usermanual/4.Electrical_Characteristics.md
>
Ok,
> >
> > Thermal zones should be defined as part of the SBC board design,
> > with the option to integrate PWM-controlled fan support in the future.
>
> These thermal zones describe fixed hardware properties of the K1 SoC itse=
lf,
> and are common for all K1-based boards.
>
Ok,
> And this is also done in Allwinner D1, StarFive JH7110 and some other chi=
ps.
>
Ok thanks.
> >
> > Thanks
> > -Anand
> Best regards,
> Shuwei Wu
Thanks
-Anand
