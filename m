From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu, 26 Jul 2018 16:30:53 +0100
Message-ID: <401d8509-b9ad-913b-334e-f4ac853472e3@arm.com>
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
	<20180719101539.6104-2-vivek.gautam@codeaurora.org>
	<e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
	<CAFp+6iF1XzFn1QhWjatxE-1sue-EFS7wNmQ4OB=c3pf1VMLuMA@mail.gmail.com>
	<CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 26/07/18 08:12, Vivek Gautam wrote:
> On Wed, Jul 25, 2018 at 11:46 PM, Vivek Gautam
> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> On Tue, Jul 24, 2018 at 8:51 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>> On 19/07/18 11:15, Vivek Gautam wrote:
>>>>
>>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>
>>>> The smmu needs to be functional only when the respective
>>>> master's using it are active. The device_link feature
>>>> helps to track such functional dependencies, so that the
>>>> iommu gets powered when the master device enables itself
>>>> using pm_runtime. So by adapting the smmu driver for
>>>> runtime pm, above said dependency can be addressed.
>>>>
>>>> This patch adds the pm runtime/sleep callbacks to the
>>>> driver and also the functions to parse the smmu clocks
>>>> from DT and enable them in resume/suspend.
>>>>
>>>> Also, while we enable the runtime pm add a pm sleep suspend
>>>> callback that pushes devices to low power state by turning
>>>> the clocks off in a system sleep.
>>>> Also add corresponding clock enable path in resume callback.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> Signed-off-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> [vivek: rework for clock and pm ops]
>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>> ---
>>>>
>>>> Changes since v12:
>>>>    - Added pm sleep .suspend callback. This disables the clocks.
>>>>    - Added corresponding change to enable clocks in .resume
>>>>     pm sleep callback.
>>>>
>>>>    drivers/iommu/arm-smmu.c | 75
>>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 73 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index c73cfce1ccc0..9138a6fffe04 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
> 
> [snip]
> 
>>>> platform_device *pdev)
>>>>          arm_smmu_device_remove(pdev);
>>>>    }
>>>>    +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>>> +{
>>>> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>> +
>>>> +       return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>>
>>>
>>> If there's a power domain being automatically switched by genpd then we need
>>> a reset here because we may have lost state entirely. Since I remembered the
>>> otherwise-useless GPU SMMU on Juno is in a separate power domain, I gave it
>>> a poking via sysfs with some debug stuff to dump sCR0 in these callbacks,
>>> and the problem is clear:
>>>
>>> ...
>>> [    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
>>> [    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 0x00201936
>>> [    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 6733980 ns
>>> [   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
>>> [   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 0x00220101
>>> [   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 6658020 ns
>>> ...
>>
>> Qualcomm SoCs have retention enabled for SMMU registers so they don't
>> lose state.
>> ...
>> [  256.013367] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
>> SCR0 = 0x201e36
>> [  256.013367]
>> [  256.019160] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
>> SCR0 = 0x201e36
>> [  256.019160]
>> [  256.027368] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
>> SCR0 = 0x201e36
>> [  256.027368]
>> [  256.036786] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
>> SCR0 = 0x201e36
>> ...
>>
>> However after adding arm_smmu_device_reset() in runtime_resume() I observe
>> some performance degradation when kill an instance of 'kmscube' and
>> start it again.
>> The launch time with arm_smmu_device_reset() in runtime_resume() change is
>> more.
>> Could this be because of frequent TLB invalidation and sync?

Probably. Plus the reset procedure is a big chunk of MMIO accesses, 
which for a non-trivial SMMU configuration probably isn't negligible in 
itself. Unfortunately, unless you know for absolute certain that you 
don't need to do that, you do.

> Some more information that i gathered.
> On Qcom SoCs besides the registers retention, TCU invalidates TLB cache on
> a CX power collapse exit, which is the system wide suspend case.
> The arm-smmu software is not aware of this CX power collapse /
> auto-invalidation.
> 
> So wouldn't doing an explicit TLB invalidations during runtime resume be
> detrimental to performance?

Indeed it would be, but resuming with TLBs full of random valid-looking 
junk is even more so.

> I have one more doubt here -
> We do runtime power cycle around arm_smmu_map/unmap() too.
> Now during map/unmap we selectively do TLB maintenance (either
> tlb_sync or tlb_add_flush).
> But with runtime pm we want to do TLBIALL*. Is that a problem?

It's technically redundant to do both, true, but as we've covered in 
previous rounds of discussion it's very difficult to know *which* one is 
sufficient at any given time, so in order to make progress for now I 
think we have to settle with doing both.

Robin.
