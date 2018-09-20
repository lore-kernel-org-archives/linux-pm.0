From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Fri, 21 Sep 2018 04:08:28 +0800
Message-ID: <CAMz4kuKj1wtUMLLM8kzKSzotA64vHk466f2G7AxRsdWXZVJL_Q@mail.gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com> <20180920165847.6xqzeoqzqkyotshx@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Craig <ctatlor97@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 21 September 2018 at 00:58, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> [Dropped a couple of people from CC, added Baolin]
>
> Hi Craig, Baolin and Rob,
>
> On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
>> On 16 September 2018 13:10:45 BST, Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
>> >Sorry for my long delay in reviewing this. I like the binding,
>> >but the "qcom," specific properties should become common properties
>> >in
>> >
>> >Documentation/devicetree/bindings/power/supply/battery.txt
>> >and referenced via monitored-battery.
>
>> Thanks for the review, what bindings for ocv would you prefer? The
>> spreadtrum ones or mine?
>
> Most importantly I want to see only one generic binding supporting
> both use cases. As far as I can see there are two major differences:
>
> 1. Qcom uses legend properties and SC27XX embedds this into data
> 2. Qcom supports temperature based mapping
>
> The second point is easy: Not having temperature information can
> be a subset of the data with temperature info. The main thing to
> discuss are the legend properties. I suppose we have these
> proposals:
>
> Proposal A (from Qcom BMS binding):
>
> ocv-capacity-legend = /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45 ...>;
> ocv-temp-legend-celsius = /bits/ 8 <(-10) 0 25 50 65>;
> ocv-lut-microvolt = <43050000 43050000 43030000 42990000
>
> Proposal B (from SC27XX binding):
>
> ocv-cap-table = <4185 100>, <4113 95>, <4066 90>, <4022 85> ...;
>
> I prefer the second binding (with mV -> uV), but I think it becomes
> messy when temperature is added. What do you think about the
> following proposal (derived from pinctrl style):
>
> Proposal C:
>
> ocv-capacity-table-temperatures = <(-10) 0 10>;
> ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;

For SC27XX, we have no temperatures consideration, but I think
Proposal C can be compatible with our case.

-- 
Baolin Wang
Best Regards
