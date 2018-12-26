From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
Date: Wed, 26 Dec 2018 15:14:43 +0530
Message-ID: <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 12/22/2018 1:09 PM, Stephen Boyd wrote:
>> +If an RSC needs to program next wake-up in the PDC timer, it must specify the
>> +binding as child node with the following properties:
>> +
>> +Properties:
>> +- compatible:
>> +    Usage: required
>> +       Value type: <string>
>> +       Definition: must be "qcom,pdc-timer".
>> +
>> +- reg:
>> +    Usage: required
>> +       Value type: <prop-encoded-array>
>> +       Definition: Specifies the offset of the control register.
>> +
>>   Example 1:
>>   
>>   For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
>>                        <0x179d0000 0x10000>,
>>                        <0x179e0000 0x10000>;
>>                  reg-names = "drv-0", "drv-1", "drv-2";
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>>                  interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>>                               <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>>                               <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
>>                                    <SLEEP_TCS   3>,
>>                                    <WAKE_TCS    3>,
>>                                    <CONTROL_TCS 1>;
>> +
>> +               pdc_timer@38 {
>> +                       compatible = "qcom,pdc-timer";
>> +                       reg = <0x38 0x1>,
>> +                             <0x40 0x1>;
> I don't understand this whole binding. Why can't the pdc timer be
> programmed within the rpmh driver? This looks like a node is being added
> as a child just to make a platform driver and device match up in the
> linux kernel. And that in turn causes a regmap to need to be created?
> Sorry, it just looks really bad.


There are two RSC devices in SoC one for application processor subsystem 
& other display subsystem. Both RSC contain registers for PDC timers 
(one for each subsystem). But only for application processor the PDC 
timer needs to be programmed when application processor enters 
sleep/suspend. As the driver is common between both RSC devices, this 
approach is taken. Do you have any other suggestions to distinguish 
between the two? Perhaps, by additional compatible string?

Thanks for the review.

- Raju
