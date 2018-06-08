From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 2/2] dt-bindings: power: sbs-battery: re-document "ti,bq20z75"
Date: Fri,  8 Jun 2018 15:36:55 -0700
Message-ID: <20180608223655.33565-2-briannorris@chromium.org>
References: <20180608223655.33565-1-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608223655.33565-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>, Alexandru Stan <amstan@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Doug Anderson <dianders@chromium.org>, Phil Reid <preid@electromag.com.au>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

This compatible property was documented before the driver was renamed to
"SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
bq20z75->sbs rename to dt bindings")). The driver has continued to
support this property as an alternative to "sbs,sbs-battery", and
because we've noticed there are some lingering TI specifics (in the
manufacturer-specific portion of the SBS spec), we'd like to start using
this property again to differentiate.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rhyland Klein <rklein@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: add Rhyland's Acked-by
v3: no change
v4: add Rob's Reviewed-by
---
 .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index c40e8926facf..a7a9c3366f82 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -2,7 +2,7 @@ SBS sbs-battery
 ~~~~~~~~~~
 
 Required properties :
- - compatible : "sbs,sbs-battery"
+ - compatible : "sbs,sbs-battery" or "ti,bq20z75"
 
 Optional properties :
  - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
-- 
2.18.0.rc1.242.g61856ae69a-goog
