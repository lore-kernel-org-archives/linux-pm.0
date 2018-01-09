From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 1/6] base: power: runtime: Export
	pm_runtime_get/put_suppliers
Date: Tue,  9 Jan 2018 15:31:44 +0530
Message-ID: <1515492109-753-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1515492109-753-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1515492109-753-1-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The device link allows the pm framework to tie the supplier and
consumer. So, whenever the consumer is powered-on the supplier
is powered-on first.

There are however cases in which the consumer wants to power-on
the supplier, but not itself.
E.g., A Graphics or multimedia driver wants to power-on the SMMU
to unmap a buffer and finish the TLB operations without powering
on itself. Some of these unmap requests are coming from the
user space when the controller itself is not powered-up, and it
can be huge penalty in terms of power and latency to power-up
the graphics/mm controllers.
There can be an argument that the supplier should handle this case
on its own and there should not be a need for the consumer to
power-on the supplier. But as discussed on the thread [1] about
ARM-SMMU runtime pm, we don't want to introduce runtime pm calls
in atomic path in arm_smmu_unmap.

[1] https://patchwork.kernel.org/patch/9827825/

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

 * This is v2 of the patch [1]. Adding it to this patch series.
   [1] https://patchwork.kernel.org/patch/10102447/

 drivers/base/power/runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 6e89b51ea3d9..06a2a88fe866 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1579,6 +1579,7 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(pm_runtime_get_suppliers);
 
 /**
  * pm_runtime_put_suppliers - Drop references to supplier devices.
@@ -1597,6 +1598,7 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(pm_runtime_put_suppliers);
 
 void pm_runtime_new_link(struct device *dev)
 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
