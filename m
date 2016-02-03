From: Jonathan Tinkham <sctincman@gmail.com>
Subject: [PATCH 3/3] power: bq24735-charger: document 'ti,external-control' option
Date: Tue,  2 Feb 2016 23:03:46 -0700
Message-ID: <1454479426-6437-4-git-send-email-sctincman@gmail.com>
References: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:35319 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbcBCGFJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 01:05:09 -0500
In-Reply-To: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Jonathan Tinkham <sctincman@gmail.com>

Implement an 'external-control' option for when the charger
shouldn't be configured by the kernel.

Signed-off-by: Jonathan Tinkham <sctincman@gmail.com>
---
 Documentation/devicetree/bindings/power_supply/ti,bq24735.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power_supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power_supply/ti,bq24735.txt
index 4f6a550..3bf5575 100644
--- a/Documentation/devicetree/bindings/power_supply/ti,bq24735.txt
+++ b/Documentation/devicetree/bindings/power_supply/ti,bq24735.txt
@@ -22,6 +22,9 @@ Optional properties :
    value must be between 128mA and 8.064A with a 128mA step resolution. The
    POR value is 0x1000h. This number is in mA (e.g. 8064), see the spec for
    more information about the InputCurrent (0x3fh) register.
+ - ti,external-control : Indicates that the charger is configured externally
+   and that the host should not attempt to enable/disable charging or set the
+   charge voltage/current.
 
 Example:
 
-- 
2.7.0

