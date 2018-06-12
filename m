From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] dt-bindings: power: sbs-battery: re-document "ti,bq20z75"
Date: Tue, 12 Jun 2018 13:20:42 -0700
Message-ID: <20180612202042.107603-2-briannorris@chromium.org>
References: <20180612202042.107603-1-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612202042.107603-1-briannorris@chromium.org>
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

In typical DT fashion, the <vendor>,<part-number> specifics should be
used ahead of the generic "sbs,sbs-battery" string, so we can handle
vendor specifics -- so document this. Language borrowed mostly from
Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

Also fixup the example to use this property (it's already implying that
it's "bq20z75@b"); fixup the node name to be generic ("battery", not
"<part-number>"); and fixup some whitespace.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rhyland Klein <rklein@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: add Rhyland's Acked-by
v3: no change
v4: add Rob's Reviewed-by
v5:
 * note "sbs,sbs-battery" as a fallback for vendor,part-number
 * improve the Example
 * I still kept the {Acked,Reviewed}-by, since the substance of the
   change is essentially the same. Apologies if that is not proper.
---
 .../bindings/power/supply/sbs_sbs-battery.txt        | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index c40e8926facf..4e78e51018eb 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -2,7 +2,11 @@ SBS sbs-battery
 ~~~~~~~~~~
 
 Required properties :
- - compatible : "sbs,sbs-battery"
+ - compatible: "<vendor>,<part-number>", "sbs,sbs-battery" as fallback. The
+     part number compatible string might be used in order to take care of
+     vendor specific registers.
+     Known <vendor>,<part-number>:
+       ti,bq20z75
 
 Optional properties :
  - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
@@ -14,9 +18,9 @@ Optional properties :
 
 Example:
 
-	bq20z75@b {
-		compatible = "sbs,sbs-battery";
-		reg = < 0xb >;
+	battery@b {
+		compatible = "ti,bq20z75", "sbs,sbs-battery";
+		reg = <0xb>;
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
-- 
2.18.0.rc1.242.g61856ae69a-goog
