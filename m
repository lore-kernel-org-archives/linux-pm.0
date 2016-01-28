From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 09/14] Documentation: DT: bindings: Update NVIDIA PMC for Tegra
Date: Thu, 28 Jan 2016 16:33:47 +0000
Message-ID: <1453998832-27383-10-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add the PMC driver compatible strings for Tegra132 and Tegra210.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt     | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 02c27004d4a8..53aa5496c5cf 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -6,11 +6,13 @@ modes. It provides power-gating controllers for SoC and CPU power-islands.
 
 Required properties:
 - name : Should be pmc
-- compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra30,
-  must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
-  "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc".
-  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
-  above, where <chip> is tegra132.
+- compatible : Should contain one of the following:
+	For Tegra20 must contain "nvidia,tegra20-pmc".
+	For Tegra30 must contain "nvidia,tegra30-pmc".
+	For Tegra114 must contain "nvidia,tegra114-pmc"
+	For Tegra124 must contain "nvidia,tegra124-pmc"
+	For Tegra132 must contain "nvidia,tegra124-pmc"
+	For Tegra210 must contain "nvidia,tegra210-pmc"
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
-- 
2.1.4
