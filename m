From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [RESEND PATCH v17 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Fri, 16 Nov 2018 16:54:25 +0530
Message-ID: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com, mark.rutland@arm.com, rjw@rjwysocki.net, robdclark@gmail.com, linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org, sboyd@kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi Will,
I am resending this series after we concluded on comments [1,2] on v16 of
this patch-series, and the subsequent patch [3] was posted.
Kindly merge this series.

Thanks
Vivek

Previous version of this patch series is @ [4].
Also refer to [4] for change logs for previous versions.

[1] https://lore.kernel.org/patchwork/patch/979430/
[2] https://lore.kernel.org/patchwork/patch/979433/
[3] https://lore.kernel.org/patchwork/patch/994194/
[4] https://lore.kernel.org/patchwork/cover/979429/

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         |  39 +++++
 drivers/iommu/arm-smmu.c                           | 192 +++++++++++++++++++--
 2 files changed, 219 insertions(+), 12 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
