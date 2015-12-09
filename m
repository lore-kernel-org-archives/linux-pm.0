From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 10/19] PM / devfreq: exynos: Add the detailed correlation
 between sub-blocks and power line
Date: Wed, 09 Dec 2015 13:08:02 +0900
Message-ID: <1449634091-1842-11-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and power line
for Exynos3250, Exynos4210 and Exynos4x12.

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index c4fdc70f8eac..ed639c4f6466 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -33,6 +33,57 @@ Optional properties for only parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
                    the performance count againt total cycle count.
 
+Detailed correlation between sub-blocks and power line according to Exynos SoC:
+- In case of Exynos3250, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC
+		|--- G3D
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- FSYS
+		|--- LCD0
+		|--- PERIR
+		|--- ISP
+		|--- CAM
+
+- In case of Exynos4210, there is one power line as following:
+	VDD_INT |--- DMC (parent device)
+		|--- LEFTBUS
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- LCD0
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- LCD1
+
+- In case of Exynos4x12, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- IMAGE
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- ISP
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
