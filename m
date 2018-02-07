From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
	add/remove device
Date: Wed,  7 Feb 2018 16:01:19 +0530
Message-ID: <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1517999482-17317-1-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
[vivek: Cleanup pm runtime calls]
Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9e2f917e16c2..c024f69c1682 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	int irq;
+	int ret, irq;
 
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		return;
+
 	/*
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
@@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	pm_runtime_put_sync(smmu->dev);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1407,14 +1413,22 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
-	ret = arm_smmu_master_alloc_smes(dev);
+	ret = pm_runtime_get_sync(smmu->dev);
 	if (ret)
 		goto out_cfg_free;
 
+	ret = arm_smmu_master_alloc_smes(dev);
+	if (ret)
+		goto out_rpm_put;
+
 	iommu_device_link(&smmu->iommu, dev);
 
+	pm_runtime_put_sync(smmu->dev);
+
 	return 0;
 
+out_rpm_put:
+	pm_runtime_put_sync(smmu->dev);
 out_cfg_free:
 	kfree(cfg);
 out_free:
@@ -1427,7 +1441,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1435,8 +1449,15 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		return;
+
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
+
+	pm_runtime_put_sync(smmu->dev);
+
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
@@ -2131,6 +2152,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	platform_set_drvdata(pdev, smmu);
+
+	pm_runtime_enable(dev);
+
+	err = pm_runtime_get_sync(dev);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2172,9 +2201,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	pm_runtime_put_sync(dev);
 
 	/*
 	 * For ACPI and generic DT bindings, an SMMU will be probed before
@@ -2211,8 +2240,13 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
+	pm_runtime_get_sync(smmu->dev);
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	pm_runtime_put_sync(smmu->dev);
+
+	pm_runtime_disable(smmu->dev);
+
 	return 0;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
