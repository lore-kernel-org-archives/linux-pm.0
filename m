From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RFC PATCH v12 2/5] of/irq: Adjust of_pci_irq parsing for multiple interrupts
Date: Tue, 26 Dec 2017 10:08:03 +0800
Message-ID: <20171226020806.32710-3-jeffy.chen@rock-chips.com>
References: <20171226020806.32710-1-jeffy.chen@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171226020806.32710-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Currently we are considering the first irq as the PCI interrupt pin,
but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).

Only parse the PCI interrupt pin when the irq is unnamed or named as
"pci".

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v12: None
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
