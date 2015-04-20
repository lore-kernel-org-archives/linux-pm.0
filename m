From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: Re: [RFC/PATCH v2 3/5] devicetree: bindings: Add new cpuidle enable
 method for Renesas R-car SoCs
Date: Mon, 20 Apr 2015 16:39:35 +0900
Message-ID: <5534AD37.20705@renesas.com>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com> <1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com> <20150417124624.GD21904@leverpostej> <CANqRtoTaGc7QCJAVj8Jhpo5HgbwyfiRQZz5j0zBkE1cBkDZAzQ@mail.gmail.com> <20150417143723.GC2347@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:64030 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753869AbbDTHjs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 03:39:48 -0400
In-Reply-To: <20150417143723.GC2347@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "horms@verge.net.au" <horms@verge.net.au>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Magnus, Mark, Lorenzo

Thank you for your comment.

(2015/04/17 23:37), Lorenzo Pieralisi wrote:

> On Fri, Apr 17, 2015 at 02:11:24PM +0100, Magnus Damm wrote:
>> Hi Mark,
>>
>> On Fri, Apr 17, 2015 at 9:46 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Thu, Apr 16, 2015 at 11:35:38AM +0100, Keita Kobayashi wrote:
>>>> This patch add the ARM CPUs Device Tree binding to document a new
>>>> enable method of Renesas cpuidle.
>>>>
>>>> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>>>> index 8b9e0a9..663ee11 100644
>>>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>>>> @@ -196,6 +196,7 @@ nodes to be present and contain the properties described below.
>>>>                           "qcom,gcc-msm8660"
>>>>                           "qcom,kpss-acc-v1"
>>>>                           "qcom,kpss-acc-v2"
>>>> +                         "renesas,rcar-idle"
>>>
>>> The enable-method is about how to bring the CPU up (and potentially
>>> implies other things, like how to take it down again).
>>
>> Thanks for your clarification. I now understand that this is related
>> to SMP boot and CPU Hotplug.
>>
>>> These is no code in this series to that effect, no semantics are
>>> provided, and the name implies this is idle-specific.
>>>
>>> So this doesn't look right, and makes no sense to me.
>>
>> Ok, I somehow (incorrectly?) assumed that the following line in patch
>> 2/5* tied into this:
>> +CPUIDLE_METHOD_OF_DECLARE(rcar, "renesas,rcar-idle", &rcar_cpuidle_ops);
>>
>> [*] [RFC/PATCH v2 2/5] ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
>>
>> But if it is unrelated it should of course be dropped or reworked.
> 
> It is related, but Mark's remark is correct. We have to keep in mind
> that an enable-method defines how a CPU is powered {up/down} and
> also suspended (quiesced through idle).
> 
> It has to be defined through proper bindings and related code, adding a
> random compatible string for the sake of matching does not cut it,
> that is not acceptable and I stated it from the beginning.
> 
> So, to make it clear, an enable-method defines CPU operations as a
> whole, cpu init, power{up/down} and suspend.
> 
> It must be documented with proper bindings that defines compatible string and
> related properties.
> 
> The sooner we incorporate the CPUidle ops into SMP ops the better to
> prevent this abuse from happening, an enable-method encompasses SMP
> ops and CPUidle ops, actually they must be merged because they represent
> the enable-method implementation as a whole.
> 
> I hope this helps.
> 
> Lorenzo


I will rename "renesas,rcar-idle" in the next patch.

Regards.

Keita Kobayashi
