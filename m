From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v11 2/5] of/irq: Adjust of_pci_irq parsing for multiple interrupts
Date: Mon, 25 Dec 2017 19:47:39 +0800
Message-ID: <20171225114742.18920-3-jeffy.chen@rock-chips.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

Currently we are considering the first irq as the PCI interrupt pin,
but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).

Only parse the PCI interrupt pin when the irq is unnamed or named as
"pci".

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v11:
Address Brian's comments.

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/of/of_pci_irq.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 3a05568f65df..d39565d5477b 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -27,9 +27,25 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
 	 */
 	dn = pci_device_to_OF_node(pdev);
 	if (dn) {
-		rc = of_irq_parse_one(dn, 0, out_irq);
-		if (!rc)
-			return rc;
+		struct property *prop;
+		const char *name;
+		int index = 0;
+
+		of_property_for_each_string(dn, "interrupt-names", prop, name) {
+			if (!strcmp(name, "pci"))
+				break;
+			index++;
+		}
+
+		/*
+		 * Only parse from DT if we have no "interrupt-names",
+		 * or if we found an interrupt named "pci".
+		 */
+		if (index == 0 || name) {
+			rc = of_irq_parse_one(dn, index, out_irq);
+			if (!rc)
+				return rc;
+		}
 	}
 
 	/* Ok, we don't, time to have fun. Let's start by building up an
-- 
2.11.0
