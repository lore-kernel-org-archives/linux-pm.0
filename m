From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: Add optional dynamic-power-coefficient property
Date: Mon, 09 Nov 2015 18:39:35 +0000
Message-ID: <9hhvb9b6mqg.fsf@e105922-lin.cambridge.arm.com>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
	<1447090163-13700-2-git-send-email-punit.agrawal@arm.com>
	<20151109174542.GA19016@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151109174542.GA19016@rob-hp-laptop> (Rob Herring's message of
	"Mon, 9 Nov 2015 11:45:42 -0600")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Mon, Nov 09, 2015 at 05:29:21PM +0000, Punit Agrawal wrote:
>> The dynamic power consumption of a device is proportional to the
>> square of voltage (V) and the clock frequency (f). It can be expressed as
>> 
>> Pdyn = dynamic-power-coefficient * V^2 * f.
>> 
>> The coefficient represents the running time dynamic power consumption in
>> units of mw/MHz/uVolt^2 and can be used in the above formula to
>> calculate the dynamic power in mW.
>
> I have no issue with the binding, but I wonder if a single value is 
> really sufficient to model this. Don't you also need a static
> component?

In general, power consumption does consist of the static and dynamic
power. Here we are only modelling the dynamic component.

For CPUs, we found that a single-coefficient model using frequency and
voltages gives a reasonable estimation of dynamic power consumption. For
thermal management, because of using closed loop control providing the
dynamic consumption is good enough as long as static power for your
platform is not significant.

On the other hand, there isn't a generally applicable model for static
power - it has complex relationships with temperature, voltages, etc
which make it hard to express as a simple formula. For platforms where
static power is significant, providing it via platform code is the only
option for now.

This patchset enables platforms where dynamic power works well to setup
their power model for thermal management via device tree.

>
> Rob
>
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index 91e6e5c..c33362d 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -240,6 +240,23 @@ nodes to be present and contain the properties described below.
>>  		Definition: Specifies the syscon node controlling the cpu core
>>  			    power domains.
>>  
>> +	- dynamic-power-coefficient
>> +		Usage: optional
>> +		Value type: <prop-encoded-array>
>> +		Definition: A u32 value that represents the running time dynamic
>> +			    power coefficient in units of mW/MHz/uVolt^2. The
>> +			    coefficient can either be calculated from power
>> +			    measurements or derived by analysis.
>> +
>> +			    The dynamic power consumption of the CPU  is
>> +			    proportional to the square of the Voltage (V) and
>> +			    the clock frequency (f). The coefficient is used to
>> +			    calculate the dynamic power as below -
>> +
>> +			    Pdyn = dynamic-power-coefficient * V^2 * f
>> +
>> +			    where voltage is in uV, frequency is in MHz.
>> +
>>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>>  
>>  	cpus {
>> -- 
>> 2.5.3
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
