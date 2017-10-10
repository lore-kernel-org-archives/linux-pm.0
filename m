From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v7 1/3] dt-bindings: add eeprom "size" property
Date: Tue, 10 Oct 2017 11:30:35 +0530
Message-ID: <1507615237-21744-2-git-send-email-divagar.mohandass@intel.com>
References: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi, tfiga@chromium.org
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org, Divagar Mohandass <divagar.mohandass@intel.com>
List-Id: linux-pm@vger.kernel.org

This adds eeprom "size" as optional property for i2c eeproms.
The "size" property allows explicitly specifying the size of the
EEPROM chip in bytes.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 5696eb5..1436569 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -32,6 +32,8 @@ Optional properties:
 
   - read-only: this parameterless property disables writes to the eeprom
 
+  - size: total eeprom size in bytes
+
 Example:
 
 eeprom@52 {
-- 
1.9.1
