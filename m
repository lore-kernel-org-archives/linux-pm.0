From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 10/10] ARM: mvebu: Enable the thermal sensor in Armada
 380/385 SoC
Date: Mon, 28 Apr 2014 13:44:03 -0300
Message-ID: <20140428164403.GA17824@arch.cereza>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1398371004-15807-11-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50293 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756895AbaD1Qof (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Apr 2014 12:44:35 -0400
Content-Disposition: inline
In-Reply-To: <1398371004-15807-11-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org

On Apr 24, Ezequiel Garcia wrote:
> This commit enables the thermal sensor found in Armada 380/385 SoCs.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/ar=
mada-38x.dtsi
> index a064f59..02c6139 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -346,6 +346,12 @@
>  				clock-output-names =3D "nand";
>  			};
> =20
> +			thermal@e8078 {
> +				compatible =3D "marvell,armada380-thermal";
> +				reg =3D <0xe4078 0x4>, <0xe404 0x4>;

Dammit, there's a stupid typo in the register offset. I never noticed t=
his, because
the initialization sequence does not do much, and this register is not =
really used
(for now). The fix is this:

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/arma=
da-38x.dtsi
index 02c6139..370220f 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -348,7 +348,7 @@
=20
 			thermal@e8078 {
 				compatible =3D "marvell,armada380-thermal";
-				reg =3D <0xe4078 0x4>, <0xe404 0x4>;
+				reg =3D <0xe4078 0x4>, <0xe4074 0x4>;
 				status =3D "okay";
 			};
=20
Want me to send a follow-up patch?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
