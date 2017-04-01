From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
Date: Sat, 1 Apr 2017 23:50:26 +0200
Message-ID: <6dd907e4-c213-3174-8613-99427e6ea0e9@gmail.com>
References: <20170331073132.21457-2-zajec5@gmail.com>
 <20170331201124.656-1-zajec5@gmail.com>
 <20170401195136.GD28514@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170401195136.GD28514-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 04/01/2017 09:51 PM, Eduardo Valentin wrote:
> On Fri, Mar 31, 2017 at 10:11:23PM +0200, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>>
>> This commit documents binding for thermal used in Northstar family SoCs.
>>
>> Signed-off-by: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>> ---
>> V3: Add thermal-zones to the example
>>     Rob: Because of this update, I didn't include Acked-by I got for V2
>> ---
>>  .../devicetree/bindings/thermal/brcm,ns-thermal    | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>> new file mode 100644
>> index 000000000000..c561c7349f17
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>> @@ -0,0 +1,26 @@
>> +* Broadcom Northstar Thermal
>> +
>> +This binding describes thermal sensor that is part of Northstar's DMU (Device
>> +Management Unit).
>> +
>> +Required properties:
>> +- compatible : Must be "brcm,ns-thermal"
>> +- reg : iomem address range of PVTMON registers
>> +- #thermal-sensor-cells : Should be <0>
>> +
>> +Example:
>> +
>> +thermal: thermal@1800c2c0 {
>> +	compatible = "brcm,ns-thermal";
>> +	reg = <0x1800c2c0 0x10>;
>> +	#thermal-sensor-cells = <0>;
>> +};
>> +
>> +thermal-zones {
>> +	cpu_thermal: cpu-thermal {
>> +		polling-delay-passive = <0>;
>> +		polling-delay = <1000>;
>> +		coefficients = <(-556) 418000>;
>> +		thermal-sensors = <&thermal>;
>
> You need to define trips and cooling devices here. Otherwise, makes
> little sense to have this device in thermal subsystem. Here is an
> example of minimal set:
> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=1e2ac9821de6a85d3e8358f238436708d1d46869
>
> The above has no passive action. It is just gonna shutdown the system if
> temperature crosses a threshold.
>
> But, a typical cooling device would be CPU frequency throttling. Do you have
> that up and running in your routers?

I don't have CPU freq throttling, so shutdown will be the only solution for
critical temp right now.

I know I should have at least a trip for critical temperature, but the problem
is I don't know what value to use. There isn't any info about this in public
datasheets. Broadcom's SDK doesn't mention it. Vendors share only the max
environment temp, not the max CPU temp.

So for now I only meant to provide user space access to reading current CPU
temperature. I could do some stress tests and ask other users to do it as well.

Or maybe I could just put in Documentation some round value that makes more or
less sense and then work on a proper content of real DTS files?

Unless we can get some hint from Broadcom people. Jon? Florian? Anyone?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
