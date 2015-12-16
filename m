From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 1/3] i2c: document binding for multi-master case
Date: Wed, 16 Dec 2015 19:44:18 +0100
Message-ID: <1450291460-10514-2-git-send-email-wsa@the-dreams.de>
References: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We need this binding because some I2C master drivers will need to adapt
their PM settings for the arbitration circuitry. I skipped the "i2c-"
prefix because I can imagine to be useful outside of i2c.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index a00219f5ee0733..c8d977ed847f3c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -54,6 +54,11 @@ wants to support one of the below features, it should adapt the bindings below.
 	"irq" and "wakeup" names are recognized by I2C core, other names are
 	left to individual drivers.
 
+- multi-master
+	states that there is another master active on this bus. The OS can use
+	this information to adapt power management to keep the arbitration awake
+	all the time, for example.
+
 - wakeup-source
 	device can be used as a wakeup source.
 
-- 
2.1.4

