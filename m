From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/7] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
Date: Fri, 08 Apr 2016 14:00:42 +0900
Message-ID: <1460091646-28701-4-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1460091646-28701-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the NoCP (Network on Chip Probe) Device Tree node
to measure the bandwidth of memory and g3d in Exynos542x SoC.

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7b99cb58d82d..d80f3b66f017 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -294,6 +294,42 @@
 		};
 	};
 
+	nocp_mem0_0: nocp_mem0_0@10CA1000 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1000 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_1: nocp_mem0_1@10CA1400 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1400 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_2: nocp_mem0_2@10CA1800 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1800 0x200>;
+		status = "disabled";
+	};
+
+	nocp_mem0_3: nocp_mem0_3@10CA1C00 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x10CA1C00 0x200>;
+		status = "disabled";
+	};
+
+	nocp_g3d_0: nocp_g3d_0@11A51000 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x11A51000 0x200>;
+		status = "disabled";
+	};
+
+	nocp_g3d_1: nocp_g3d_1@11A51400 {
+		compatible = "samsung,exynos5420-nocp";
+		reg = <0x11A51400 0x200>;
+		status = "disabled";
+	};
+
 	gsc_pd: power-domain@10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
