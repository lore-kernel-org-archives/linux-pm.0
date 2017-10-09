From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] power: supply: replace pr_* with dev_*
Date: Tue, 10 Oct 2017 02:39:54 +0530
Message-ID: <20171009210954.5fdeimcmt35jbcoa@aishwarya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37795 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbdJIVJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 17:09:59 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com

Use kernel preferred dev_* family of functions in place of pr_*,
wherever a device object is present.

Done with the help of coccinelle.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
The following cocci script was used to make the patch:
@r exists@
identifier f, s, x;
position p;
@@
 f(..., struct s *x,...) {
<+... when != x == NULL
 \(pr_err@p\|pr_debug@p\|pr_info@p\|pr_warn@p\)(...); ...+>
 }

@struc@
identifier dev, r.s;
@@
struct s {
        ...
        struct device *dev;
        ...
};

@@
identifier r.x, struc.dev;
position r.p;
@@
(
- pr_err@p
+ dev_err
|
- pr_warn@p
+ dev_warn
|
- pr_info@p
+ dev_info
|
- pr_debug@p
+ dev_dbg
)
 (
+ x->dev,
...)

@rr exists@
local idexpression struct device *dev;
@@

<+... dev ...+>
(
- pr_err
+ dev_err
|
- pr_info
+ dev_info
|
- pr_warn
+ dev_warn
|
- pr_debug
+ dev_dbg
)
 (
+ dev,
...)
---
 drivers/power/supply/power_supply_core.c | 2 +-
 drivers/power/supply/twl4030_charger.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 02c6340ae36f..4b57fa9779ae 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -669,7 +669,7 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
 static void power_supply_dev_release(struct device *dev)
 {
 	struct power_supply *psy = container_of(dev, struct power_supply, dev);
-	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
+	dev_dbg(dev, "device: '%s': %s\n", dev_name(dev), __func__);
 	kfree(psy);
 }
 
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index a5915f498eea..7ed2bc3039c4 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -743,7 +743,7 @@ static int twl4030bci_state(struct twl4030_bci *bci)
 
 	ret = twl4030_bci_read(TWL4030_BCIMSTATEC, &state);
 	if (ret) {
-		pr_err("twl4030_bci: error reading BCIMSTATEC\n");
+		dev_err(bci->dev, "twl4030_bci: error reading BCIMSTATEC\n");
 		return ret;
 	}
 
-- 
2.11.0
