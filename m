From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
Date: Mon, 26 Nov 2018 08:41:51 -0600
Message-ID: <ca287382-1d21-ad73-1648-00291a5da21b@linux.intel.com>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org>
 <20181121173803.GB9801@arm.com>
 <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
 <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
 <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
 <20181123183428.GD21183@arm.com>
 <30fd45b5-50f0-7f2f-aab3-adc4528d21a8@codeaurora.org>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <30fd45b5-50f0-7f2f-aab3-adc4528d21a8@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, Will Deacon <will.deacon@arm.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, alex.williamson@redhat.com, robh+dt <robh+dt@kernel.org>, freedreno <freedreno@lists.freedesktop.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Vivek,

On 11/26/18 4:55 AM, Vivek Gautam wrote:
> 
> On 11/24/2018 12:04 AM, Will Deacon wrote:
>> On Fri, Nov 23, 2018 at 03:06:29PM +0530, Vivek Gautam wrote:
>>> On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>>> On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>> On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> 
>>>>> wrote:
>>>>>> On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
>>>>>>> @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, 
>>>>>>> ARM_SMMU_V1_64K, GENERIC_SMMU);
>>>>>>>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>>>>>>>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>>>>>>>
>>>>>>> +static const char * const qcom_smmuv2_clks[] = {
>>>>>>> +     "bus", "iface",
>>>>>>> +};
>>>>>>> +
>>>>>>> +static const struct arm_smmu_match_data qcom_smmuv2 = {
>>>>>>> +     .version = ARM_SMMU_V2,
>>>>>>> +     .model = QCOM_SMMUV2,
>>>>>>> +     .clks = qcom_smmuv2_clks,
>>>>>>> +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
>>>>>>> +};
>>>>>> These seems redundant if we go down the route proposed by Thor, 
>>>>>> where we
>>>>>> just pull all of the clocks out of the device-tree. In which case, 
>>>>>> why
>>>>>> do we need this match_data at all?
>>>>> Which is better? Driver relying solely on the device tree to tell
>>>>> which all clocks
>>>>> are required to be enabled,
>>>>> or, the driver deciding itself based on the platform's match data,
>>>>> that it should
>>>>> have X, Y, & Z clocks that should be supplied from the device tree.
>>>> The former would simplify the driver, but would also make it
>>>> impossible to spot mistakes in DT, which would ultimately surface out
>>>> as very hard to debug bugs (likely complete system lockups).
>>> Thanks.
>>> Yea, this is how I understand things presently. Relying on device tree
>>> puts the things out of driver's control.
>> But it also has the undesirable effect of having to update the driver
>> code whenever we want to add support for a new SMMU implementation. If
>> we do this all in the DT, as Thor is trying to do, then older kernels
>> will work well with new hardware.
>>
>>> Hi Will,
>>> Am I unable to understand the intentions here for Thor's clock-fetch
>>> design change?
>> I'm having trouble parsing your question, sorry. Please work with Thor
>> so that we have a single way to get the clock information. My preference
>> is to take it from the firmware, for the reason I stated above.
> Hi Will,
> 
> Sure, thanks. I will work with Thor to get this going.
> 
> Hi Thor,
> Does it sound okay to you to squash your patch [1] into my patch [2] with
> your 'Signed-off-by' tag?
> I will update the commit log to include the information about getting
> clock details from device tree.
> 
> [1] https://patchwork.kernel.org/patch/10628725/
> [2] https://patchwork.kernel.org/patch/10686061/
> 

Yes, that would be great and easier to understand than my patch on top 
of yours.

Additionally, can you remove the "Error:" as Will requested as part of 
the squash?

Thank you!

Thor

> Best regards
> Vivek
>>
>> Will
> 
> 
