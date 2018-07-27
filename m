From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add
 pm_runtime/sleep ops
Date: Fri, 27 Jul 2018 10:35:46 +0530
Message-ID: <cc36024e-888f-b323-d960-93f76a7bbea0@codeaurora.org>
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
 <20180719101539.6104-2-vivek.gautam@codeaurora.org>
 <e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
 <CAFp+6iF1XzFn1QhWjatxE-1sue-EFS7wNmQ4OB=c3pf1VMLuMA@mail.gmail.com>
 <CAFp+6iEYpM7w+pq0bG83vgjedqy4ZkQbUP9Bx=61TbEUN45OkA@mail.gmail.com>
 <401d8509-b9ad-913b-334e-f4ac853472e3@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537761834=="
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <401d8509-b9ad-913b-334e-f4ac853472e3-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--===============1537761834==
Content-Type: multipart/alternative;
 boundary="------------37BEB597666699A5F82FD777"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------37BEB597666699A5F82FD777
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/26/2018 9:00 PM, Robin Murphy wrote:
> On 26/07/18 08:12, Vivek Gautam wrote:
>> On Wed, Jul 25, 2018 at 11:46 PM, Vivek Gautam
>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>> On Tue, Jul 24, 2018 at 8:51 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> 
>>> wrote:
>>>> On 19/07/18 11:15, Vivek Gautam wrote:
>>>>>
>>>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>>
>>>>> The smmu needs to be functional only when the respective
>>>>> master's using it are active. The device_link feature
>>>>> helps to track such functional dependencies, so that the
>>>>> iommu gets powered when the master device enables itself
>>>>> using pm_runtime. So by adapting the smmu driver for
>>>>> runtime pm, above said dependency can be addressed.
>>>>>
>>>>> This patch adds the pm runtime/sleep callbacks to the
>>>>> driver and also the functions to parse the smmu clocks
>>>>> from DT and enable them in resume/suspend.
>>>>>
>>>>> Also, while we enable the runtime pm add a pm sleep suspend
>>>>> callback that pushes devices to low power state by turning
>>>>> the clocks off in a system sleep.
>>>>> Also add corresponding clock enable path in resume callback.
>>>>>
>>>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>> Signed-off-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>> [vivek: rework for clock and pm ops]
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>> ---
>>>>>
>>>>> Changes since v12:
>>>>>    - Added pm sleep .suspend callback. This disables the clocks.
>>>>>    - Added corresponding change to enable clocks in .resume
>>>>>     pm sleep callback.
>>>>>
>>>>>    drivers/iommu/arm-smmu.c | 75
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>    1 file changed, 73 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>> index c73cfce1ccc0..9138a6fffe04 100644
>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>> +++ b/drivers/iommu/arm-smmu.c
>>
>> [snip]
>>
>>>>> platform_device *pdev)
>>>>>          arm_smmu_device_remove(pdev);
>>>>>    }
>>>>>    +static int __maybe_unused arm_smmu_runtime_resume(struct 
>>>>> device *dev)
>>>>> +{
>>>>> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>>> +
>>>>> +       return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>>>
>>>>
>>>> If there's a power domain being automatically switched by genpd 
>>>> then we need
>>>> a reset here because we may have lost state entirely. Since I 
>>>> remembered the
>>>> otherwise-useless GPU SMMU on Juno is in a separate power domain, I 
>>>> gave it
>>>> a poking via sysfs with some debug stuff to dump sCR0 in these 
>>>> callbacks,
>>>> and the problem is clear:
>>>>
>>>> ...
>>>> [    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
>>>> [    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 
>>>> 0x00201936
>>>> [    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 
>>>> 6733980 ns
>>>> [   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
>>>> [   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 
>>>> 0x00220101
>>>> [   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 
>>>> 6658020 ns
>>>> ...
>>>
>>> Qualcomm SoCs have retention enabled for SMMU registers so they don't
>>> lose state.
>>> ...
>>> [  256.013367] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
>>> SCR0 = 0x201e36
>>> [  256.013367]
>>> [  256.019160] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
>>> SCR0 = 0x201e36
>>> [  256.019160]
>>> [  256.027368] arm-smmu b40000.arm,smmu: arm_smmu_runtime_suspend
>>> SCR0 = 0x201e36
>>> [  256.027368]
>>> [  256.036786] arm-smmu b40000.arm,smmu: arm_smmu_runtime_resume
>>> SCR0 = 0x201e36
>>> ...
>>>
>>> However after adding arm_smmu_device_reset() in runtime_resume() I 
>>> observe
>>> some performance degradation when kill an instance of 'kmscube' and
>>> start it again.
>>> The launch time with arm_smmu_device_reset() in runtime_resume() 
>>> change is
>>> more.
>>> Could this be because of frequent TLB invalidation and sync?
>
> Probably. Plus the reset procedure is a big chunk of MMIO accesses, 
> which for a non-trivial SMMU configuration probably isn't negligible 
> in itself. Unfortunately, unless you know for absolute certain that 
> you don't need to do that, you do.
>
>> Some more information that i gathered.
>> On Qcom SoCs besides the registers retention, TCU invalidates TLB 
>> cache on
>> a CX power collapse exit, which is the system wide suspend case.
>> The arm-smmu software is not aware of this CX power collapse /
>> auto-invalidation.
>>
>> So wouldn't doing an explicit TLB invalidations during runtime resume be
>> detrimental to performance?
>
> Indeed it would be, but resuming with TLBs full of random 
> valid-looking junk is even more so.
>
>> I have one more doubt here -
>> We do runtime power cycle around arm_smmu_map/unmap() too.
>> Now during map/unmap we selectively do TLB maintenance (either
>> tlb_sync or tlb_add_flush).
>> But with runtime pm we want to do TLBIALL*. Is that a problem?
>
> It's technically redundant to do both, true, but as we've covered in 
> previous rounds of discussion it's very difficult to know *which* one 
> is sufficient at any given time, so in order to make progress for now 
> I think we have to settle with doing both.

Thanks Robin. I will respin the patches as Tomasz also suggested;

arm_smmu_runtime_resume() will look like:

     if (pm_runtime_suspended(dev))
         return 0;
     return arm_smmu_runtime_resume(dev);

and,
arm_smmu_runtime_resume() will have arm_smmu_device_reset().

Best regards
Vivek
>
> Robin.
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------37BEB597666699A5F82FD777
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 7/26/2018 9:00 PM, Robin Murphy
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:401d8509-b9ad-913b-334e-f4ac853472e3-5wv7dgnIgG8@public.gmane.org">On
      26/07/18 08:12, Vivek Gautam wrote:
      <br>
      <blockquote type="cite">On Wed, Jul 25, 2018 at 11:46 PM, Vivek
        Gautam
        <br>
        <a class="moz-txt-link-rfc2396E" href="mailto:vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">&lt;vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org&gt;</a> wrote:
        <br>
        <blockquote type="cite">On Tue, Jul 24, 2018 at 8:51 PM, Robin
          Murphy <a class="moz-txt-link-rfc2396E" href="mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org">&lt;robin.murphy-5wv7dgnIgG8@public.gmane.org&gt;</a> wrote:
          <br>
          <blockquote type="cite">On 19/07/18 11:15, Vivek Gautam wrote:
            <br>
            <blockquote type="cite">
              <br>
              From: Sricharan R <a class="moz-txt-link-rfc2396E" href="mailto:sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">&lt;sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org&gt;</a>
              <br>
              <br>
              The smmu needs to be functional only when the respective
              <br>
              master's using it are active. The device_link feature
              <br>
              helps to track such functional dependencies, so that the
              <br>
              iommu gets powered when the master device enables itself
              <br>
              using pm_runtime. So by adapting the smmu driver for
              <br>
              runtime pm, above said dependency can be addressed.
              <br>
              <br>
              This patch adds the pm runtime/sleep callbacks to the
              <br>
              driver and also the functions to parse the smmu clocks
              <br>
              from DT and enable them in resume/suspend.
              <br>
              <br>
              Also, while we enable the runtime pm add a pm sleep
              suspend
              <br>
              callback that pushes devices to low power state by turning
              <br>
              the clocks off in a system sleep.
              <br>
              Also add corresponding clock enable path in resume
              callback.
              <br>
              <br>
              Signed-off-by: Sricharan R
              <a class="moz-txt-link-rfc2396E" href="mailto:sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">&lt;sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org&gt;</a>
              <br>
              Signed-off-by: Archit Taneja
              <a class="moz-txt-link-rfc2396E" href="mailto:architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">&lt;architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org&gt;</a>
              <br>
              [vivek: rework for clock and pm ops]
              <br>
              Signed-off-by: Vivek Gautam
              <a class="moz-txt-link-rfc2396E" href="mailto:vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">&lt;vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org&gt;</a>
              <br>
              Reviewed-by: Tomasz Figa <a class="moz-txt-link-rfc2396E" href="mailto:tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">&lt;tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a>
              <br>
              ---
              <br>
              <br>
              Changes since v12:
              <br>
                 - Added pm sleep .suspend callback. This disables the
              clocks.
              <br>
                 - Added corresponding change to enable clocks in
              .resume
              <br>
                  pm sleep callback.
              <br>
              <br>
                 drivers/iommu/arm-smmu.c | 75
              <br>
              ++++++++++++++++++++++++++++++++++++++++++++++--
              <br>
                 1 file changed, 73 insertions(+), 2 deletions(-)
              <br>
              <br>
              diff --git a/drivers/iommu/arm-smmu.c
              b/drivers/iommu/arm-smmu.c
              <br>
              index c73cfce1ccc0..9138a6fffe04 100644
              <br>
              --- a/drivers/iommu/arm-smmu.c
              <br>
              +++ b/drivers/iommu/arm-smmu.c
              <br>
            </blockquote>
          </blockquote>
        </blockquote>
        <br>
        [snip]
        <br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">platform_device *pdev)
              <br>
                       arm_smmu_device_remove(pdev);
              <br>
                 }
              <br>
                 +static int __maybe_unused
              arm_smmu_runtime_resume(struct device *dev)
              <br>
              +{
              <br>
              +       struct arm_smmu_device *smmu =
              dev_get_drvdata(dev);
              <br>
              +
              <br>
              +       return clk_bulk_enable(smmu-&gt;num_clks,
              smmu-&gt;clks);
              <br>
            </blockquote>
            <br>
            <br>
            If there's a power domain being automatically switched by
            genpd then we need
            <br>
            a reset here because we may have lost state entirely. Since
            I remembered the
            <br>
            otherwise-useless GPU SMMU on Juno is in a separate power
            domain, I gave it
            <br>
            a poking via sysfs with some debug stuff to dump sCR0 in
            these callbacks,
            <br>
            and the problem is clear:
            <br>
            <br>
            ...
            <br>
            [    4.625551] arm-smmu 2b400000.iommu:
            genpd_runtime_suspend()
            <br>
            [    4.631163] arm-smmu 2b400000.iommu:
            arm_smmu_runtime_suspend: 0x00201936
            <br>
            [    4.637897] arm-smmu 2b400000.iommu: suspend latency
            exceeded, 6733980 ns
            <br>
            [   21.566983] arm-smmu 2b400000.iommu:
            genpd_runtime_resume()
            <br>
            [   21.584796] arm-smmu 2b400000.iommu:
            arm_smmu_runtime_resume: 0x00220101
            <br>
            [   21.591452] arm-smmu 2b400000.iommu: resume latency
            exceeded, 6658020 ns
            <br>
            ...
            <br>
          </blockquote>
          <br>
          Qualcomm SoCs have retention enabled for SMMU registers so
          they don't
          <br>
          lose state.
          <br>
          ...
          <br>
          [  256.013367] arm-smmu b40000.arm,smmu:
          arm_smmu_runtime_suspend
          <br>
          SCR0 = 0x201e36
          <br>
          [  256.013367]
          <br>
          [  256.019160] arm-smmu b40000.arm,smmu:
          arm_smmu_runtime_resume
          <br>
          SCR0 = 0x201e36
          <br>
          [  256.019160]
          <br>
          [  256.027368] arm-smmu b40000.arm,smmu:
          arm_smmu_runtime_suspend
          <br>
          SCR0 = 0x201e36
          <br>
          [  256.027368]
          <br>
          [  256.036786] arm-smmu b40000.arm,smmu:
          arm_smmu_runtime_resume
          <br>
          SCR0 = 0x201e36
          <br>
          ...
          <br>
          <br>
          However after adding arm_smmu_device_reset() in
          runtime_resume() I observe
          <br>
          some performance degradation when kill an instance of
          'kmscube' and
          <br>
          start it again.
          <br>
          The launch time with arm_smmu_device_reset() in
          runtime_resume() change is
          <br>
          more.
          <br>
          Could this be because of frequent TLB invalidation and sync?
          <br>
        </blockquote>
      </blockquote>
      <br>
      Probably. Plus the reset procedure is a big chunk of MMIO
      accesses, which for a non-trivial SMMU configuration probably
      isn't negligible in itself. Unfortunately, unless you know for
      absolute certain that you don't need to do that, you do.
      <br>
      <br>
      <blockquote type="cite">Some more information that i gathered.
        <br>
        On Qcom SoCs besides the registers retention, TCU invalidates
        TLB cache on
        <br>
        a CX power collapse exit, which is the system wide suspend case.
        <br>
        The arm-smmu software is not aware of this CX power collapse /
        <br>
        auto-invalidation.
        <br>
        <br>
        So wouldn't doing an explicit TLB invalidations during runtime
        resume be
        <br>
        detrimental to performance?
        <br>
      </blockquote>
      <br>
      Indeed it would be, but resuming with TLBs full of random
      valid-looking junk is even more so.
      <br>
      <br>
      <blockquote type="cite">I have one more doubt here -
        <br>
        We do runtime power cycle around arm_smmu_map/unmap() too.
        <br>
        Now during map/unmap we selectively do TLB maintenance (either
        <br>
        tlb_sync or tlb_add_flush).
        <br>
        But with runtime pm we want to do TLBIALL*. Is that a problem?
        <br>
      </blockquote>
      <br>
      It's technically redundant to do both, true, but as we've covered
      in previous rounds of discussion it's very difficult to know
      *which* one is sufficient at any given time, so in order to make
      progress for now I think we have to settle with doing both.
      <br>
    </blockquote>
    <br>
    Thanks Robin. I will respin the patches as Tomasz also suggested;<span
      style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><br>
      <br>
      arm_smmu_runtime_resume() will look like:</span><br style="color:
      rgb(34, 34, 34); font-family: arial, sans-serif; font-size:
      12.8px; font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">
    <br style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">
    <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">    if (pm_runtime_suspended(dev))</span><br
      style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">
    <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">        return 0;</span><br
      style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">
    <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">    return arm_smmu_runtime_resume(dev);<br>
      <br>
      and,<br>
    </span><span style="color: rgb(34, 34, 34); font-family: arial,
      sans-serif; font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><span style="color: rgb(34, 34, 34);
        font-family: arial, sans-serif; font-size: 12.8px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">arm_smmu_runtime_resume()
        will have arm_smmu_device_reset().<br>
      </span></span><br>
    Best regards<br>
    Vivek<br>
    <blockquote type="cite"
      cite="mid:401d8509-b9ad-913b-334e-f4ac853472e3-5wv7dgnIgG8@public.gmane.org">
      <br>
      Robin.
      <br>
      --
      <br>
      To unsubscribe from this list: send the line "unsubscribe
      linux-arm-msm" in
      <br>
      the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
      <br>
      More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------37BEB597666699A5F82FD777--

--===============1537761834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5v
IG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==

--===============1537761834==--
