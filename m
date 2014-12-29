From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv6 7/9] ARM: dts: Add PPMU dt node for Exynos5260 SoC
Date: Mon, 29 Dec 2014 09:04:11 +0900
Message-ID: <1419811453-16160-8-git-send-email-cw00.choi@samsung.com>
References: <1419811453-16160-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1419811453-16160-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonghwan Choi <jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds PPMU (Performance Profiling Monitoring Unit) dt node
Exynos5260 SoC.

Exynos5260 SoC has following PPMU IPs:
- PPMU_DREX0_S0 0x10c60000
- PPMU_DREX0_S1 0x10c70000
- PPMU_DREX1_S0 0x10c80000
- PPMU_DREX1_S1 0x10c90000
- PPMU_EAGLE    0x10cc0000
- PPMU_KFC      0x10cd0000
- PPMU_MFC      0x11040000
- PPMU_G3D      0x11880000
- PPMU_FSYS     0x12220000
- PPMU_ISP      0x13370000
- PPMU_FICM     0x13cb0000
- PPMU_GSCL     0x13e60000
- PPMU_MSCL     0x13ee0000
- PPMU_FIMD0X   0x145b0000
- PPMU_FIMD1X   0x145c0000

The drivers/devfreq/exynos/exynos5_bus.c supports the memory bus frequency/
voltage scaling of Exynos5260 SoC with DEVFREQ framework.

Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jonghwan Choi <jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/exynos5260.dtsi | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 36da38e..26f3074 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -307,6 +307,96 @@
 			fifo-depth = <64>;
 			status = "disabled";
 		};
+
+		ppmu_drex0_s0: ppmu_drex0_s0@10c60000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10c60000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_drex0_s1: ppmu_drex0_s1@10c70000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10c70000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_drex1_s0: ppmu_drex1_s0@10c80000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10c80000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_drex1_s1: ppmu_drex1_s1@10c90000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10c90000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_eagle: ppmu_eagle@10cc0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10cc0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_kfc: ppmu_kfc@10cd0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10cd0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_mfc: ppmu_mfc@11040000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x11040000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_g3d: ppmu_g3d@11880000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x11880000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_fsys: ppmu_fsys@12220000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x12220000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_isp: ppmu_isp@13370000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x13370000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_fimc: ppmu_fimc@13cb0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x13cb0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_gscl: ppmu_gscl@13e60000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x13e60000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_mscl: ppmu_gscl@13ee0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x13ee0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_fimd0x: ppmu_fimd0x@145b0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x145b0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_fimd1x: ppmu_fimd1x@145c0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x145c0000 0x2000>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
