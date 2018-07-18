From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v7 5/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Date: Wed, 18 Jul 2018 12:12:59 +0530
Message-ID: <CAHLCerOWYzx0BJDrLZnXwcxWUbYnX=D_bwtUApmZrAKHW8L42A@mail.gmail.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
 <20180718000918.GG129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718000918.GG129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Douglas Anderson <dianders@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 5:39 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Thu, Jul 12, 2018 at 02:09:06PM +0530, Amit Kucheria wrote:
>> We want to create common code for v2 of the TSENS IP block that is used in
>> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
>> most of the common functionality start with a common get_temp() function.
>>
>> It is also necessary to split out the memory regions for the TM and SROT
>> register banks because their offsets are not constant across SoC families.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> index 06195e8..b5312a8 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> @@ -1,18 +1,28 @@
>>  * QCOM SoC Temperature Sensor (TSENS)
>>
>>  Required properties:
>> -- compatible :
>> - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>> - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>> - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
>> +- compatible:
>> +  Must be one of the following:
>> +    - "qcom,msm8916-tsens" (MSM8916)
>> +    - "qcom,msm8974-tsens" (MSM8974)
>> +    - "qcom,msm8996-tsens" (MSM8996)
>> +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
>> +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
>> +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
>> +  with version 2 of the TSENS IP. MSM8996 is the only exception beacause the
>
> s/beacause/because/
>
>> +  generic property did not exist when support was added.
>> +
>> +- reg: Address range of the thermal registers.
>> +  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
>> +  register spaces separately, with order being TM before SROT.
>> +  See Example 2, below.
>>
>> -- reg: Address range of the thermal registers
>>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
>>  - #qcom,sensors: Number of sensors in tsens block
>>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>>  nvmem cells
>>
>> -Example:
>> +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
>
> s/propoerty/property/
>
>>  tsens: thermal-sensor@900000 {
>>               compatible = "qcom,msm8916-tsens";
>>               reg = <0x4a8000 0x2000>;
>> @@ -20,3 +30,12 @@ tsens: thermal-sensor@900000 {
>>               nvmem-cell-names = "caldata", "calsel";
>>               #thermal-sensor-cells = <1>;
>>       };
>> +
>> +Example 2 (for any platform containing v2 of the TSENS IP):
>> +tsens0: thermal-sensor@c263000 {
>> +             compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>> +             reg = <0xc263000 0x1ff>, /* TM */
>> +                     <0xc222000 0x1ff>; /* SROT */
>> +             #qcom,sensors = <13>;
>> +             #thermal-sensor-cells = <1>;
>> +     };
>
> Besides the typos:
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>
> Oh, and you also might want to reorder the patches as suggested by
> Doug on v6 to put the changes in the binding before the code changes.

Ahh, sorry I missed that reordering.
