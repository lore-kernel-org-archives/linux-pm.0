From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime
	suppliers
Date: Wed,  7 Feb 2018 16:01:22 +0530
Message-ID: <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
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

While handling the concerned iommu, there should not be a
need to power control the drm devices from iommu interface.
If these drm devices need to be powered around this time,
the respective drivers should take care of this.

Replace the pm_runtime_get/put_sync(<drm_device>) with
pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
the connected iommu through the device link interface.
In case the device link is not setup these get/put_suppliers()
calls will be a no-op, and the iommu driver should take care of
powering on its devices accordingly.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index b23d33622f37..1ab629bbee69 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	int ret;
 
-	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	ret = iommu_attach_device(iommu->domain, mmu->dev);
-	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 
 	return ret;
 }
@@ -52,9 +52,9 @@ static void msm_iommu_detach(struct msm_mmu *mmu, const char * const *names,
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
-	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	iommu_detach_device(iommu->domain, mmu->dev);
-	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 }
 
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
@@ -63,9 +63,9 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
-//	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
-//	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 	WARN_ON(ret < 0);
 
 	return (ret == len) ? 0 : -EINVAL;
@@ -76,9 +76,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova,
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
-	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	iommu_unmap(iommu->domain, iova, len);
-	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
