From: "Tobias Jakobi" <Liquid.Acid@gmx.net>
Subject: Aw: [PATCH v6 05/18] arm: dts: odroid: Enable TMU at Exynos4412
 based Odroid U3 device
Date: Fri, 23 Jan 2015 13:23:21 +0100
Message-ID: <trinity-4494e7a2-16bf-4a95-9dc2-a9bcd04f845a-1422015801467@3capp-gmx-bs08>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015010-11918-1-git-send-email-l.majewski@samsung.com>,
 <1422015010-11918-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422015010-11918-6-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

just a small nit concerning the patch subject. Shouldn't it be "Enable =
TMU on Exynos4412 based Odroid devices" (since it's not just for the U3=
)?

With best wishes,
Tobias
=C2=A0

Gesendet:=C2=A0Freitag, 23. Januar 2015 um 13:09 Uhr
Von:=C2=A0"Lukasz Majewski" <l.majewski@samsung.com>
An:=C2=A0"Eduardo Valentin" <edubezval@gmail.com>, "Zhang Rui" <rui.zha=
ng@intel.com>, "Kukjin Kim" <kgene.kim@samsung.com>, "Kukjin Kim" <kgen=
e@kernel.org>
Cc:=C2=A0"Linux PM list" <linux-pm@vger.kernel.org>, "linux-samsung-soc=
@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "Bartlomiej Zoln=
ierkiewicz" <b.zolnierkie@samsung.com>, "Lukasz Majewski" <l.majewski@m=
ajess.pl>, "Amit Daniel Kachhap" <amit.daniel@samsung.com>, "Abhilash K=
esavan" <kesavan.abhilash@gmail.com>, "Abhilash Kesavan" <a.kesavan@sam=
sung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>, "Viresh Kumar" <vire=
sh.kumar@linaro.org>, "Lukasz Majewski" <l.majewski@samsung.com>
Betreff:=C2=A0[PATCH v6 05/18] arm: dts: odroid: Enable TMU at Exynos44=
12 based Odroid U3 device
This commit enables TMU IP block on the Exynos4412 Odroid U3
device.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- None
Changes for v4:
- Rename patch title from "thermal: dts:" to "arm: dts: odroid"
Changes for v5:
- None
Changes for v6:
- None
---
arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm=
/boot/dts/exynos4412-odroid-common.dtsi
index 0adb57c..c7517fc 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -396,6 +396,11 @@
ehci: ehci@12580000 {
status =3D "okay";
};
+
+ tmu@100C0000 {
+ vtmu-supply =3D <&ldo10_reg>;
+ status =3D "okay";
+ };
};

&pinctrl_1 {
--
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-samsung=
-soc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
