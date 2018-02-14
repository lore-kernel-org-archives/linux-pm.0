From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v7 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 14 Feb 2018 12:45:09 +0900
Message-ID: <CAAFQd5Dke8VcR3K1Qg=b962AhQmqi3=HJO8dc4Uu1RZEO0juOw@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com> <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeau>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 13, 2018 at 7:25 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>>> +static int arm_smmu_init_clks(struct arm_smmu_device *smmu)
>>> +{
>>> +       int i;
>>> +       int num = smmu->num_clks;
>>> +       const struct arm_smmu_match_data *data;
>>> +
>>> +       if (num < 1)
>>> +               return 0;
>>> +
>>> +       smmu->clocks = devm_kcalloc(smmu->dev, num,
>>> +                                   sizeof(*smmu->clocks), GFP_KERNEL);
>>> +       if (!smmu->clocks)
>>> +               return -ENOMEM;
>>> +
>>> +       data = of_device_get_match_data(smmu->dev);
>>> +
>>> +       for (i = 0; i < num; i++)
>>> +               smmu->clocks[i].id = data->clks[i];
>>
>> I'd argue that arm_smmu_device_dt_probe() is a better place for all
>> the code above, since this function is called regardless of whether
>> the device is probed from DT or not. Going further,
>> arm_smmu_device_acpi_probe() could fill smmu->num_clks and ->clocks
>> using ACPI-like way (as opposed to OF match data) if necessary.
>
> Right, it's valid to fill the data in arm_smmu_device_dt_probe().
> Perhaps we can just keep the devm_clk_bulk_get() in arm_smmu_device_probe()
> at the point where we are currently doing arm_smmu_init_clks().

Sounds good to me. Thanks.

Best regards,
Tomasz
