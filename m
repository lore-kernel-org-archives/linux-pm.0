From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/5] power_supply: charger-manager: add missing of_node_put
Date: Sat, 10 Oct 2015 14:30:51 +0200
Message-ID: <1444480254-14399-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-pm@vger.kernel.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
+  of_node_put(child);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/charger-manager.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 907293e..1ea5d1a 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1581,8 +1581,10 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 				cables = devm_kzalloc(dev, sizeof(*cables)
 						* chg_regs->num_cables,
 						GFP_KERNEL);
-				if (!cables)
+				if (!cables) {
+					of_node_put(child);
 					return ERR_PTR(-ENOMEM);
+				}
 
 				chg_regs->cables = cables;
 

