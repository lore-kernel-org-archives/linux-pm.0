From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
Date: Thu, 3 Jan 2019 17:52:58 +0530
Message-ID: <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org, dianders@chromium.org, evgreen@chromium.org, linux-kernel@vger.kernel.org, mka@chromium.org, ilina@codeaurora.org, bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 12/29/2018 3:08 AM, Stephen Boyd wrote:
> Quoting Raju P L S S S N (2018-12-26 01:44:43)
>>
>>
>> On 12/22/2018 1:09 PM, Stephen Boyd wrote:
>>>> +If an RSC needs to program next wake-up in the PDC timer, it must specify the
>>>> +binding as child node with the following properties:
>>>> +
>>>> +Properties:
>>>> +- compatible:
>>>> +    Usage: required
>>>> +       Value type: <string>
>>>> +       Definition: must be "qcom,pdc-timer".
>>>> +
>>>> +- reg:
>>>> +    Usage: required
>>>> +       Value type: <prop-encoded-array>
>>>> +       Definition: Specifies the offset of the control register.
>>>> +
>>>>    Example 1:
>>>>    
>>>>    For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>>>> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
>>>>                         <0x179d0000 0x10000>,
>>>>                         <0x179e0000 0x10000>;
>>>>                   reg-names = "drv-0", "drv-1", "drv-2";
>>>> +               #address-cells = <1>;
>>>> +               #size-cells = <1>;
>>>> +               ranges;
>>>>                   interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>>>>                                <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>>>>                                <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>>>> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
>>>>                                     <SLEEP_TCS   3>,
>>>>                                     <WAKE_TCS    3>,
>>>>                                     <CONTROL_TCS 1>;
>>>> +
>>>> +               pdc_timer@38 {
>>>> +                       compatible = "qcom,pdc-timer";
>>>> +                       reg = <0x38 0x1>,
>>>> +                             <0x40 0x1>;
>>> I don't understand this whole binding. Why can't the pdc timer be
>>> programmed within the rpmh driver? This looks like a node is being added
>>> as a child just to make a platform driver and device match up in the
>>> linux kernel. And that in turn causes a regmap to need to be created?
>>> Sorry, it just looks really bad.
>>
>>
>> There are two RSC devices in SoC one for application processor subsystem
>> & other display subsystem. Both RSC contain registers for PDC timers
>> (one for each subsystem).
> 
> When is the timer programmed on the display subsystem's RSC? It's hard
> to give advice without all the information.

For display subsystem RSC, hardware sleep solver takes care of timer 
programming for wakeup when the subsystem goes to Power collapse.

> 
>> But only for application processor the PDC
>> timer needs to be programmed when application processor enters
>> sleep/suspend. As the driver is common between both RSC devices, this
>> approach is taken. Do you have any other suggestions to distinguish
>> between the two? Perhaps, by additional compatible string?
>>
> 
> Maybe compatible? I sort of doubt it though. Do all RSCs have a PDC
> timer?

Yes. all RSCs have their own PDC timer.

> 
> I would think that it would make sense for the application processor's
> RSC timer to be programmed from the broadcast timer mechanism in the
> kernel so that timers during idle work and suspend turns off the timer
> appropriately with a shutdown hook. I guess the PDC can't tell you the
> time though? It looks like a shadow (and limited) version of the ARM
> architected MMIO timer that we already program for the broadcast timer
> mechanism. Is that because even the MMIO timer can't wakeup the system
> in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
> always be used as the system wide broadcast mechanism because we need to
> augment it with the PDC timer to get the actual wakeup.
> 

Yes. this is correct.

> Maybe we should be adding hooks into the broadcast timer mechanism to
> program this wakeup event hardware in addition to the ARM MMIO timer. Or
> we should stop using the ARM MMIO timer on these systems and read the
> system register based physical time in the RSC timer driver and register
> this 64-bit PDC register as the broadcast timer. So the time reading
> would be through sysreg and the wakeup programming would be done by
> writing the PDC timer. The assumption would be that we have access to
> the physical time registers (which sounds like the assumption we have to
> make).

There are no physical timer registers available in RSC for this purpose.

> 
> Do we get an interrupt somewhere from the RSC hardware when the timer
> fires? Or does that just cause a system wakeup event without any pending
> irq and then another irq (like the ARM architected timer) just happens
> to be pending around the same time? If we get an interrupt somehow then
> I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
> timer approach.

There is no interrupt for PDC timeout. It just causes system wakeup 
without a pending irq. ARM MMIO is necessary for irq.

> 
> How the RSC is used in general by other devices, like display, is not
> clear to me. We don't have a "wakeup event" framework in the kernel that
> device drivers like the display driver can grab a reference to and
> program some system wide wakeup for. That sounds like something new that
> could be handled entirely in the display driver with direct register
> writes, or it could be some qcom specific API/framework that eventually
> calls down into the same RSC driver that knows what offsets to write
> into in the display RSC's register space, or it could be an entirely
> generic framework like clk or regulator frameworks that could be used by
> anything. BTW, are we using the display RSC yet?
> 

Only display subsystem RSC is programmed along with CPU RSC in Linux. 
display RSC instance is not present in upstream but it is present in 
downstream and used for resource communication purpose only.
