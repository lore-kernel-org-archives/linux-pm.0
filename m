From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/4] power/reset: at91-reset: add missing of_node_put
Date: Wed, 18 Nov 2015 23:04:14 +0100
Message-ID: <1447884254-26336-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-pm@vger.kernel.org

for_each_matching_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression e,e1;
local idexpression np;
@@

 for_each_matching_node(np, e1) {
   ... when != of_node_put(np)
       when != e = np
(
   return np;
|
+  of_node_put(np);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/reset/at91-reset.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3f6b5dd..1b5d450 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -198,6 +198,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 			at91_ramc_base[idx] = of_iomap(np, 0);
 			if (!at91_ramc_base[idx]) {
 				dev_err(&pdev->dev, "Could not map ram controller address\n");
+				of_node_put(np);
 				return -ENODEV;
 			}
 			idx++;
