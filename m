From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 0/6] iommu/arm-smmu: Add runtime pm/sleep support
Date: Tue, 9 Jan 2018 17:19:15 +0530
Message-ID: <70e20deb-66fa-9e69-8b36-ba7b17d9390c@codeaurora.org>
References: <1515492109-753-1-git-send-email-vivek.gautam@codeaurora.org>
	<1568773.GtDhb2pIXv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1568773.GtDhb2pIXv-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 01/09/2018 04:53 PM, Rafael J. Wysocki wrote:
> On Tuesday, January 9, 2018 11:01:43 AM CET Vivek Gautam wrote:
>> This series provides the support for turning on the arm-smmu's
>> clocks/power domains using runtime pm. This is done using the
>> recently introduced device links patches, which lets the smmu's
>> runtime to follow the master's runtime pm, so the smmu remains
>> powered only when the masters use it.
>>
>> It also adds support for Qcom's arm-smmu-v2 variant that
>> has different clocks and power requirements.
>>
>> Took some reference from the exynos runtime patches [2].
>>
>> Previous version of the patchset [1].
>>
>> After much discussion [4] over the use of pm_runtime_get/put() in
>> .unmap op path for the arm-smmu, and after disussing over more than
>> a couple of approaches to address this, we are putting forward the
>> changes *without* using pm_runtime APIs in 'unmap'. Rather, letting
>> the client device take the control of powering on/off the connected
>> iommu through pm_runtime_get(put)_suppliers() APIs for the scnerios
>> when the iommu power can't be directly controlled by clients through
>> device links.
>> Rafael has agreed to export the suppliers APIs [5].
>>
>> [V5]
>>     * Dropped runtime pm calls from "arm_smmu_unmap" op as discussed over
>>       the list [4] for the last patch series.
>>     * Added a patch to export pm_runtime_get/put_suppliers() APIs to the
>>       series as agreed with Rafael [5].
>>     * Added the related patch for msm drm iommu layer to use
>>       pm_runtime_get/put_suppliers() APIs in msm_mmu_funcs.
>>     * Dropped arm-mmu500 clock patch since that would break existing
>>       platforms.
>>     * Changed compatible 'qcom,msm8996-smmu-v2' to 'qcom,smmu-v2' to reflect
>>       the IP version rather than the platform on which it is used.
>>       The same IP is used across multiple platforms including msm8996,
>>       and sdm845 etc.
>>     * Using clock bulk APIs to handle the clocks available to the IP as
>>       suggested by Stephen Boyd.
>>     * The first patch in v4 version of the patch-series:
>>       ("iommu/arm-smmu: Fix the error path in arm_smmu_add_device") has
>>       already made it to mainline.
>>
>> [V4]
>>     * Reworked the clock handling part. We now take clock names as data
>>       in the driver for supported compatible versions, and loop over them
>>       to get, enable, and disable the clocks.
>>     * Using qcom,msm8996 based compatibles for bindings instead of a generic
>>       qcom compatible.
>>     * Refactor MMU500 patch to just add the necessary clock names data and
>>       corresponding bindings.
>>     * Added the pm_runtime_get/put() calls in .unmap iommu op (fix added by
>>       Stanimir on top of previous patch version.
>>     * Added a patch to fix error path in arm_smmu_add_device()
>>     * Removed patch 3/5 of V3 patch series that added qcom,smmu-v2 bindings.
>>
>> [V3]
>>     * Reworked the patches to keep the clocks init/enabling function
>>       separately for each compatible.
>>
>>     * Added clocks bindings for MMU40x/500.
>>
>>     * Added a new compatible for qcom,smmu-v2 implementation and
>>       the clock bindings for the same.
>>
>>     * Rebased on top of 4.11-rc1
>>
>> [V2]
>>     * Split the patches little differently.
>>
>>     * Addressed comments.
>>
>>     * Removed the patch #4 [3] from previous post
>>       for arm-smmu context save restore. Planning to
>>       post this separately after reworking/addressing Robin's
>>       feedback.
>>
>>     * Reversed the sequence to disable clocks than enabling.
>>       This was required for those cases where the
>>       clocks are populated in a dependent order from DT.
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg567488.html
>> [2] https://lkml.org/lkml/2016/10/20/70
>> [3] https://patchwork.kernel.org/patch/9389717/
>> [4] https://patchwork.kernel.org/patch/9827825/
>> [5] https://patchwork.kernel.org/patch/10102445/
>>
>> Sricharan R (3):
>>    iommu/arm-smmu: Add pm_runtime/sleep ops
>>    iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
>>    iommu/arm-smmu: Add the device_link between masters and smmu
>>
>> Vivek Gautam (3):
>>    base: power: runtime: Export pm_runtime_get/put_suppliers
>>    iommu/arm-smmu: Add support for qcom,smmu-v2 variant
>>    drm/msm: iommu: Replace runtime calls with runtime suppliers
>>
>>   .../devicetree/bindings/iommu/arm,smmu.txt         |  35 ++++++
>>   drivers/base/power/runtime.c                       |   2 +
>>   drivers/gpu/drm/msm/msm_iommu.c                    |  16 +--
>>   drivers/iommu/arm-smmu.c                           | 124 ++++++++++++++++++++-
>>   4 files changed, 163 insertions(+), 14 deletions(-)
> I need some time to review the series.

Sure, thanks Rafael.

regards
Vivek

>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
