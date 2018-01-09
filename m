From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v5 4/6] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Tue,  9 Jan 2018 15:31:47 +0530
Message-ID: <1515492109-753-5-git-send-email-vivek.gautam@codeaurora.org>
References: <1515492109-753-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515492109-753-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, gregkh@linuxfoundation.org, robdclark@gmail.com, will.deacon@arm.com, robin.murphy@arm.com, sboyd@codeaurora.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc: len.brown@intel.com, pavel@ucw.cz, airlied@linux.ie, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 95478bfb182c..33bbcfedb896 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1367,6 +1367,7 @@ static int arm_smmu_add_device(struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct device_link *link;
 	int i, ret;
 
 	if (using_legacy_binding) {
@@ -1428,6 +1429,16 @@ static int arm_smmu_add_device(struct device *dev)
 
 	pm_runtime_put_sync(smmu->dev);
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	if (!link)
+		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
+			 dev_name(smmu->dev), dev_name(dev));
+
 	return 0;
 
 out_cfg_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
