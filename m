From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to distinguish
Date: Mon, 01 Feb 2016 22:17:22 +0100
Message-ID: <5354361.hQXgJ7cEGx@diego>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com> <5387650.lAgTxexlF2@phil> <56AF1D4E.40307@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1571273.eaKMFl8bNX"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34527 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbcBAVRe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Feb 2016 16:17:34 -0500
In-Reply-To: <56AF1D4E.40307@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "David.Wu" <wdc@rock-chips.com>
Cc: David Wu <david.wu@rock-chips.com>, khilman@kernel.org, nm@ti.com, huangtao@rock-chips.com, cf@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1571273.eaKMFl8bNX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi David,

Am Montag, 1. Februar 2016, 16:54:38 schrieb David.Wu:
> =E5=9C=A8 2016/1/30 20:39, Heiko Stuebner =E5=86=99=E9=81=93:
> > Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
> >> As rk3368 contained two separated iodomain areas, this was
> >> determined to use which regmap base address.
> >>=20
> >> Signed-off-by: David Wu <david.wu@rock-chips.com>
> >=20
> > I don't think we need to specify this on a driver level. Both GRF a=
reas
> > are
> > "General register files" only located in two separate power-domains=
.
> > So the rockchip,grf property should work for both. Especially as no=
thing
> > keeps designers from introducing yet another GRF-area somewhere els=
e ;-)
> >=20
> > >From when I started working on the rk3368, I still have a prelimin=
ary
> >=20
> > patches for that sitting here, so I've attached on how I envisoned =
that to
> > work.
>=20
> Okay, i agree to you, but it make someone a little confused just from=

> the drive code,
> not DT file,  about  pmugrf regmap base address.:-)
>=20
> How do you feel about intergating GRF and PMU drivers in one driver?
> Thanks!

I will very strongly disagree here ;-) .
Similar to the power-domains being part of the pmu, the io-domains are
part of their individual GRFs. So if you want it really clean and tidy =
the way=20
to go foward will be the attached patches. Compile-tested only.

Other things like the usbphy control should move there as well in the l=
ong=20
run. But that's not immediate necessary.


Heiko
--nextPart1571273.eaKMFl8bNX
Content-Disposition: attachment; filename="0001-PM-AVS-rockchip-io-make-io-domains-a-child-of-the-GR.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-PM-AVS-rockchip-io-make-io-domains-a-child-of-the-GR.patch"

>From 7893f35ee24c8aa921a480a1fd3045d9dbe48a15 Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Mon, 1 Feb 2016 16:54:14 +0100
Subject: [PATCH 1/3] PM / AVS: rockchip-io: make io-domains a child of the GRF

IO-domain handling is part of the general register files, so should live
under the grf directly. This change allows the grf to be a simple-mfd and
the io-domains fetching the syscon regmap from that parent-node.

The old binding is of course preserved, though deprecated.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  4 +++-
 drivers/power/avs/rockchip-io-domain.c                         | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index b8627e7..7ed5518 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -35,8 +35,10 @@ Required properties:
   - "rockchip,rk3288-io-voltage-domain" for rk3288
   - "rockchip,rk3368-io-voltage-domain" for rk3368
   - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
-- rockchip,grf: phandle to the syscon managing the "general register files"
 
+Deprecated properties:
+- rockchip,grf: phandle to the syscon managing the "general register files"
+    Systems should move the io-domains to a sub-node of the grf simple-mfd.
 
 You specify supplies using the standard regulator bindings by including
 a phandle the relevant regulator.  All specified supplies must be able
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 8099456..3923e1f7 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -278,6 +278,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct rockchip_iodomain *iod;
+	struct device *parent;
 	int i, ret = 0;
 
 	if (!np)
@@ -293,7 +294,14 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	match = of_match_node(rockchip_iodomain_match, np);
 	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
 
-	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	parent = pdev->dev.parent;
+	if (parent) {
+		iod->grf = syscon_node_to_regmap(parent->of_node);
+	} else {
+		dev_dbg(&pdev->dev, "falling back to old binding\n");
+		iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	}
+
 	if (IS_ERR(iod->grf)) {
 		dev_err(&pdev->dev, "couldn't find grf regmap\n");
 		return PTR_ERR(iod->grf);
-- 
2.6.4


--nextPart1571273.eaKMFl8bNX
Content-Disposition: attachment; filename="0003-arm64-dts-rockchip-add-rk3368-iodomains.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-arm64-dts-rockchip-add-rk3368-iodomains.patch"

>From d2883f273e51b8cb2f06d587ecf56e46b91ef12f Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Wed, 29 Jul 2015 16:13:35 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: add rk3368 iodomains

probably unfinished
---
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 104cbee..e6e2a1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -211,6 +211,18 @@
 	status = "ok";
 };
 
+&grf {
+	io-domains {
+		compatible = "rockchip,rk3368-io-voltage-domain";
+
+		audio-supply = <&vcc_io>;
+		gpio30-supply = <&vcc_io>;
+		gpio1830-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -331,6 +343,16 @@
 	};
 };
 
+&pmugrf {
+	io-domains {
+		compatible = "rockchip,rk3368-pmu-io-voltage-domain";
+		rockchip,grf = <&pmugrf>;
+
+		pmu-supply = <&vcc_io>;
+		vop-supply = <&vcc_io>;
+	};
+};
+
 &saradc {
 	vref-supply = <&vcc_18>;
 	status = "okay";
-- 
2.6.4


--nextPart1571273.eaKMFl8bNX
Content-Disposition: attachment; filename="0002-arm64-dts-rockchip-make-grf-syscons-simple-mfds.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-arm64-dts-rockchip-make-grf-syscons-simple-mfds.patch"

>From 116217957ec3910b9dc05420441848f3343e450e Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Mon, 1 Feb 2016 22:09:03 +0100
Subject: [PATCH 2/3] arm64: dts: rockchip: make grf syscons simple-mfds

The general register files do contain a lot of separate functions and
while some really are only registers with a lot of different 1-bit
settings, there are also a lot of them containing some bigger function
blocks. To be able to define these as sub-devices, make them simple-mfds.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 122777b..4fc28e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -554,7 +554,7 @@
 	};
 
 	pmugrf: syscon@ff738000 {
-		compatible = "rockchip,rk3368-pmugrf", "syscon";
+		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
 	};
 
@@ -567,7 +567,7 @@
 	};
 
 	grf: syscon@ff770000 {
-		compatible = "rockchip,rk3368-grf", "syscon";
+		compatible = "rockchip,rk3368-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x1000>;
 	};
 
-- 
2.6.4


--nextPart1571273.eaKMFl8bNX--

