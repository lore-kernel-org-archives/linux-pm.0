From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 13/14] ARM: mvebu: Add thermal support to Armada 370
 device tree
Date: Sat, 23 Mar 2013 21:22:04 -0300
Message-ID: <20130324002203.GB3269@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363991114-4225-14-git-send-email-ezequiel.garcia@free-electrons.com>
 <514DB9B9.8090601@cogentembedded.com>
 <514DBA1F.6050701@cogentembedded.com>
 <514DBB76.4080006@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42481 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3CXAWI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Mar 2013 20:22:08 -0400
Content-Disposition: inline
In-Reply-To: <514DBB76.4080006@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Sat, Mar 23, 2013 at 06:25:58PM +0400, Sergei Shtylyov wrote:
> On 23-03-2013 18:20, Sergei Shtylyov wrote:
>=20
> >>> This patch adds support for the thermal controller available in
> >>> all Armada 370 boards. This controller has two 4-byte registers:
> >>> one to read the thermal sensor, the other for sensor initializati=
on.
>=20
> >>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.co=
m>
> >>> ---
> >>> This patch depends on the patch to add Armada 370 support
> >>> in the mvebu_thermal driver:
> >>> 'thermal: mvebu: Add support for Armada 370 thermal sensor'
>=20
> >>>   arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
> >>>   1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> >>> diff --git a/arch/arm/boot/dts/armada-370.dtsi
> >>> b/arch/arm/boot/dts/armada-370.dtsi
> >>> index 8188d13..5831994 100644
> >>> --- a/arch/arm/boot/dts/armada-370.dtsi
> >>> +++ b/arch/arm/boot/dts/armada-370.dtsi
> >>> @@ -153,5 +153,11 @@
> >>>               clocks =3D <&coreclk 0>;
> >>>           };
> >>>
> >>> +        thermal@d0018300 {
> >>> +            compatible =3D "marvell,armada370-thermal";
> >>> +            reg =3D <0xd0018300 0x4
> >>> +                   0xd0018304 0x4>;
>=20
> >>     As the two registers are adjacent to each other, why have two =
register
> >> regions ISO one?
>=20
> >     Ah, I just saw the previous patch where the registers are not a=
djacent and
> > it became clear why.
>=20
>     However, the "compatible" properties are different...
>=20

Well, the compatible maybe different, but they belong to the same famil=
y
(i.e. same driver).

IMHO, it doesn't matter whether the registers are adjacents or not
as they have different meanings, as clearly stated in the device tree
binding documentation: the first register is for the sensor, and second
one (which is optional) is for the calibration.

Do you think this is confusing?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
