From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 1/7] of: Export of_pci_range_to_resource()
Date: Tue, 9 Jan 2018 14:49:31 +0530
Message-ID: <1515489577-2197-2-git-send-email-mmaddireddy@nvidia.com>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515489577-2197-1-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Tegra PCIe host driver parses of_pci_range from device tree and converts
to resource. Export of_pci_range_to_resource() to allow Tegra PCIe host
driver to be compiled as loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
V2:
* commit message update
V3:
* no change in this patch
V4:
* no change in this patch
V5:
* no change in this patch

 drivers/of/address.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index fa6cabfc3cb9..8d9b93f8701a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -361,6 +361,7 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 	res->end = (resource_size_t)OF_BAD_ADDR;
 	return err;
 }
+EXPORT_SYMBOL(of_pci_range_to_resource);
 #endif /* CONFIG_PCI */
 
 /*
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
