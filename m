From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v14 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date: Wed, 22 Aug 2018 16:43:32 +0100
Message-ID: <08965f23-5b97-3ea7-4bd5-4f36035fddf2@arm.com>
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
	<CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 20/08/18 10:31, Tomasz Figa wrote:
> Hi Robin,
> 
> On Fri, Jul 27, 2018 at 4:02 PM Vivek Gautam
> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>
>> This series provides the support for turning on the arm-smmu's
>> clocks/power domains using runtime pm. This is done using
>> device links between smmu and client devices. The device link
>> framework keeps the two devices in correct order for power-cycling
>> across runtime PM or across system-wide PM.
>>
>> With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [8]
>> (available in linux-next of Rafael's linux-pm tree [9]), the device links
>> created between arm-smmu and its clients will be automatically purged
>> when arm-smmu driver unbinds from its device.
>>
>> As not all implementations support clock/power gating, we are checking
>> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
>> power management for such smmu implementations that can support it.
>> Otherwise, the clocks are turned to be always on in .probe until .remove.
>> With conditional runtime pm now, we avoid touching dev->power.lock
>> in fastpaths for smmu implementations that don't need to do anything
>> useful with pm_runtime.
>> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
>> calls in map/unmap callbacks so that the clients do not have to
>> worry about handling any of the arm-smmu's power.
>>
>> This series also adds support for Qcom's arm-smmu-v2 variant that
>> has different clocks and power requirements.
>>
>> Previous version of this patch series is @ [2].
>>
>> Tested this series on msm8996, and sdm845 after pulling in Rafael's linux-pm
>> linux-next[9] and Joerg's iommu next[10] branches, and related changes for
>> device tree, etc.
>>
>> Hi Robin, Will,
>> I have addressed the comments for v13. If there's still a chance
>> can you please consider pulling this for v4.19.
>> Thanks.
>>
>> [v14]
>>     * Moved arm_smmu_device_reset() from arm_smmu_pm_resume() to
>>       arm_smmu_runtime_resume() so that the pm_resume callback calls
>>       only runtime_resume to resume the device.
>>       This should take care of restoring the state of smmu in systems
>>       in which smmu lose register state on power-domain collapse.
> 
> It's been a while since this series was posted and no more comments
> seem to be left anymore. Would you have some time to take a look
> again? Thanks.

Other than the binding issue which turned up in the meantime, I *think* 
this is looking OK now in terms of being sufficiently safe for all the 
various awkward retention vs. state-loss combinations. There's almost 
certainly still ways to improve it in future, but what we have now seems 
like a reasonable starting point that isn't impossibly complicated to 
reason about.

Robin.
