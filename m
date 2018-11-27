From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v18 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
Date: Tue, 27 Nov 2018 15:41:45 +0530
Message-ID: <20181127101145.7682-6-vivek.gautam@codeaurora.org>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc: alex.williamson@redhat.com, mark.rutland@arm.com, rjw@rjwysocki.net, robdclark@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org, sboyd@kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, thor.thayer@linux.intel.com, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
clock and power requirements.
On msm8996, multiple cores, viz. mdss, video, etc. use this
smmu. On sdm845, this smmu is used with gpu.
Add bindings for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f02e0f58e696..29ce9e10abd4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -121,6 +121,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -2031,6 +2032,7 @@ ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
+ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
@@ -2039,6 +2041,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
+	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
