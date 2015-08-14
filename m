From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 10/10] arm64: dts: Create SoC thermal zone for Juno
Date: Fri, 14 Aug 2015 13:44:31 +0100
Message-ID: <9hhlhdeghu8.fsf@e105922-lin.cambridge.arm.com>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com>
	<1438615378-14241-11-git-send-email-punit.agrawal@arm.com>
	<20150812155500.GW20890@e106497-lin.cambridge.arm.com>
	<9hh1tf7i7oi.fsf@e105922-lin.cambridge.arm.com>
	<9hhsi7mgi44.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9hhsi7mgi44.fsf-Z9gB6HwUD+TZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org> (Punit Agrawal's
	message of "Fri, 14 Aug 2015 13:38:35 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, "linux-pm@vger.kernel.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors@lm-sensors.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Apologies for the duplicate, I accidentally Hit send before I finished
the reply.

Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org> writes:

> [ adding Eduardo, Rui for their take on OF-thermal bindings ]
>
> Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org> writes:
>
>> Hi Liviu,
>>
>> Thanks for having a look.
>>
>> Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org> writes:
>>
>>> On Mon, Aug 03, 2015 at 04:22:58PM +0100, Punit Agrawal wrote:
>>>> Setup a thermal zone driven by the SoC temperature sensor on Juno
>>>> r0. Create passive trip points and bind them to cpufreq cooling
>>>> devices that support the power extensions.
>>>
>>> Hi Punit,
>>>
>>>> 
>>>> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
>>>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>>>> Cc: Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
>>>> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
>>>> ---
>>>>  arch/arm64/boot/dts/arm/juno.dts | 50 ++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 50 insertions(+)
>>>> 
>>>> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
>>>> index d2e67f3..664961c 100644
>>>> --- a/arch/arm64/boot/dts/arm/juno.dts
>>>> +++ b/arch/arm64/boot/dts/arm/juno.dts
>>>> @@ -9,6 +9,7 @@
>>>>  /dts-v1/;
>>>>  
>>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +#include <dt-bindings/thermal/thermal.h>
>>>>  
>>>>  / {
>>>>  	model = "ARM Juno development board (r0)";
>>>> @@ -90,6 +91,8 @@
>>>>  			next-level-cache = <&A57_L2>;
>>>>  			clocks = <&scpi_dvfs 0>;
>>>>  			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>>>> +			#cooling-cells = <2>;
>>>> +			dynamic-power-coefficient = <530>;
>>>
>>> The Documentation/devicetree/bindings/thermal/thermal.txt document describes two additional
>>> required properties, cooling-min-state and cooling-max-state which are missing here.
>>>
>>
>> The bindings do suggest that the cooling-*-state are required but I
>> couldn't find any code making use of this property.
>>
>> I'll send a patch with the next version making those properties
>> optional.
>>
>
> On second thoughts...
>
> The question about cooling-*-state has come up in another thread as
> well [0]. I'll re-iterate the question for the thermal maintainers to
> clarify.
>
> The cooling-{max,min}-state properties are marked mandatory in the
> bindings but aren't used in the code anywhere. Can we drop those
> properties from the binding documentation? Or at the least, make them optional?
>

Let me know your preferred approach. I can include a fix in the next version.

[0] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/84512/focus=63339

> [...]
>
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
