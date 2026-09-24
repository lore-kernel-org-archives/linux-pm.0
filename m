Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B61FC0;
	Thu, 24 Sep 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241381; cv=none; b=g5gL4SjwQ4MdaEzg4Gy7hphFSeYOiKURj58+myrZogTux/KbN/aUXa5i0vPRSZiZIjNsgqHJVOWfwDWPQU44UKUIYwDez6vVSKB4eQ/d/eq+rgtYZgY5Kz8psPlgk4pjjB0i3rzAbJ3p6TsFYJgVaJR8kTcw75b1p3jCLafR1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241381; c=relaxed/simple;
	bh=mxDJacuipcRiB7b2yV1gYeeEIRh0C90gctrM/wdJWZ0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ukkLNL4Tv+cWOXGvAydH3r1nmD0ghz2/hvLq10z5ymJpqj+IwDbpokVyvtSnlXI29mf+kIel7ga5BJommnDw4qaBCxbHMptLq6MsP9a7TBBKEWOG8FWVkVpyb7zQgRw9gm6kA10QfNs9J+cY/88W9d11IlSVCnIpRBk3vqH4z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JVNLgL24; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JVNLgL24"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:b6d6:9a4a:6c9b:2322])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1976AC23;
	Thu, 24 Sep 2026 11:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790241269;
	bh=mxDJacuipcRiB7b2yV1gYeeEIRh0C90gctrM/wdJWZ0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JVNLgL24Phmm4TXO/Yx/6FgzOsmLX4iLoW5gt7CDyCPOceJEJjcwQG3wA/P13O6nJ
	 B7e+GA0e0gnSOh0gigY97UqHkWaQv2WLO3s6bWfHUxT/3MdiWbIc2QL0/x7fNTxWoS
	 YmgKiandddEjs4mD/BI47VsI/MEu7ivy4VSTATq4=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260919175851.GI1124359@killaraus.ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com> <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-8-dbe9236bfd22@ideasonboard.com> <20260919175851.GI1124359@killaraus.ideasonboard.com>
Subject: Re: [PATCH v2 08/11] media: vsp1: Document X5H SoC ID
From: Paul Elder <paul.elder@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-media@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 24 Sep 2026 18:16:10 +0900
Message-ID: <179024137074.2882041.17628313046085880585@neptunite.rasen.tech>
User-Agent: alot/0.0.0

Quoting Laurent Pinchart (2026-09-20 02:58:51)
> On Sat, Sep 19, 2026 at 02:07:05AM +0900, Paul Elder wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >=20
> > The R-Car X5H uses 0x09 as the SoC ID in the version register. Document
> > is with a macro, as done for other R-Car SoCs.
> >=20
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
> > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> > ---
> > Changes in v2:
> > - Fix the version register number: s/0x04/0x09/
>=20
> Thanks for the fix.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>=20
> But I think we can squash this with patch 09/11.
>=20
> > ---
> >  drivers/media/platform/renesas/vsp1/vsp1_regs.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/=
media/platform/renesas/vsp1/vsp1_regs.h
> > index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..8abf39bac6c2f333696ebf5=
5de87586d2df3bed0 100644
> > --- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> > +++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> > @@ -816,6 +816,7 @@
> >  #define VI6_IP_VERSION_SOC_E3                (0x04 << 0)
> >  #define VI6_IP_VERSION_SOC_V3U               (0x05 << 0)
> >  #define VI6_IP_VERSION_SOC_V4H               (0x06 << 0)
> > +#define VI6_IP_VERSION_SOC_X5H               (0x09 << 0)

Do we need to add an X5H1 (0x09) and X5H2 (0x07)? Or whatever 0x07 is becau=
se
that's what the bsp is referencing for X5H. I've personally observed 0x09 f=
or X5H1.


Paul

> >  /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identific=
ation */
> >  #define VI6_IP_VERSION_SOC_RZG2L     (0x80 << 0)
> > =20
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
