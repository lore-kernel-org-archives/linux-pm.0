From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v9 2/7] of/irq: Adjust of_pci_irq parsing for multiple interrupts
Date: Fri, 27 Oct 2017 15:17:34 +0800
Message-ID: <20171027071739.21927-3-jeffy.chen@rock-chips.com>
References: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
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

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/of/of_pci_irq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 3a05568f65df..8b69211f0b88 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -27,7 +27,18 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
 	 */
 	dn = pci_device_to_OF_node(pdev);
 	if (dn) {
-		rc = of_irq_parse_one(dn, 0, out_irq);
+		struct property *prop;
+		const char *name;
+		int index = 0;
+
+		prop = of_find_property(dn, "interrupt-names", NULL);
+		for (name = of_prop_next_string(prop, NULL); name;
+		     name = of_prop_next_string(prop, name), index++) {
+			if (!strcmp(name, "pci"))
+				break;
+		}
+
+		rc = of_irq_parse_one(dn, index, out_irq);
 		if (!rc)
 			return rc;
 	}
-- 
2.11.0
