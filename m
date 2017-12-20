From: Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 2/2] ARM: dts: r8a7743: Add thermal device to DT
Date: Wed, 20 Dec 2017 11:53:44 +0000
Message-ID: <KL1PR06MB1702004602DF211F92CFAC9BB80C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1513689449-2700-1-git-send-email-biju.das@bp.renesas.com>
 <1513689449-2700-3-git-send-email-biju.das@bp.renesas.com>
 <20171220085036.gdcnbhonyqlewyi4@verge.net.au>
 <KL1PR06MB17029FA8C7AD57F067777E11B80C0@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <20171220114844.w35ain6w6tvecfgo@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:49792 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754695AbdLTLxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 06:53:49 -0500
In-Reply-To: <20171220114844.w35ain6w6tvecfgo@verge.net.au>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Thanks, I will check and provide feedback if any.

Regards,
Biju

> -----Original Message-----
> From: Simon Horman [mailto:horms@verge.net.au]
> Sent: 20 December 2017 11:49
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Zhang Rui <rui.zhang@intel.com>; Eduardo Valentin
> <edubezval@gmail.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; devicetree@vger.kernel.org; linux-renes=
as-
> soc@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] ARM: dts: r8a7743: Add thermal device to DT
>
> On Wed, Dec 20, 2017 at 11:36:51AM +0000, Biju Das wrote:
> > Hi Simon,
> >
> > Just noticed that
> >
> > # make dtbs W=3D1 is giving below warning message.
> >
> > arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb: Warning
> (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges
> property
> >
> > Do you prefer a fix patch or a v2 ?
>
> I believe I have fixed that by applying
> "ARM: dts: r8a7743: move timer and thermal-zones nodes out of bus"
>
> Could you check the devel branch when I push it a little later today?


[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
