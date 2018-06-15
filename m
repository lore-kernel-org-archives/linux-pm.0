From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 21/26] devicetree: fix some bindings file names
Date: Fri, 15 Jun 2018 13:30:49 -0300
Message-ID: <bad15e2f685803321c11d0568620e375f2e22dfc.1529079120.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There were some file movements that changed the location for
some DT bindings. Fix them with:
	scripts/documentation-file-ref-check --fix

After manually checking if the new file makes sense.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt | 2 +-
 .../devicetree/bindings/power/supply/ab8500/chargalg.txt        | 2 +-
 .../devicetree/bindings/power/supply/ab8500/charger.txt         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt b/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
index 0ba1bcc7f33a..f181e46d8e07 100644
--- a/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
+++ b/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
@@ -13,4 +13,4 @@ Required Properties:
 	};
 
 For information on battery specific node, Ref:
-Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
+Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt b/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
index ef5328371122..56636f927203 100644
--- a/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
+++ b/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
@@ -13,4 +13,4 @@ ab8500_chargalg {
 };
 
 For information on battery specific node, Ref:
-Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
+Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt b/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
index 6bdbb08ea9e0..24ada03e07b4 100644
--- a/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
@@ -22,4 +22,4 @@ Required Properties:
 	};
 
 For information on battery specific node, Ref:
-Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
+Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
-- 
2.17.1
