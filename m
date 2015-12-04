From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 11/16] Documentation: DT: bindings: Update NVIDIA PMC for Tegra210
Date: Fri, 4 Dec 2015 14:57:12 +0000
Message-ID: <1449241037-22193-12-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

---
 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 02c27004d4a8..838e1a69ec0a 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -9,8 +9,9 @@ Required properties:
 - compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra30,
   must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
   "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc".
-  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
-  above, where <chip> is tegra132.
+  For Tegra210, must contain "nvidia,tegra210-pmc". Otherwise, must contain
+  "nvidia,<chip>-pmc", plus at least one of the above, where <chip> is
+  tegra132.
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
-- 
2.1.4
