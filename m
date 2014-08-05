From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/4] of: Add bindings for nvidia,tegra124-soctherm
Date: Tue, 5 Aug 2014 16:44:02 +0300
Message-ID: <53E0DFA2.6020900@nvidia.com>
References: <1407241137-32232-1-git-send-email-mperttunen@nvidia.com> <1407241137-32232-2-git-send-email-mperttunen@nvidia.com> <20140805133455.GA20354@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140805133455.GA20354@developer>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 05/08/14 16:34, Eduardo Valentin wrote:
> Mikko,
>
> On Tue, Aug 05, 2014 at 03:18:54PM +0300, Mikko Perttunen wrote:
>> This adds binding documentation and headers for the Tegra124
>> SOCTHERM device tree node.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>   .../devicetree/bindings/thermal/tegra-soctherm.txt | 35 ++++++++++++++++++++++
>>   include/dt-bindings/thermal/tegra124-soctherm.h    | 13 ++++++++
>>   2 files changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
>>   create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
>> new file mode 100644
>> index 0000000..3505c8f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
>> @@ -0,0 +1,35 @@
>> +Tegra124 SOCTHERM thermal management system
>> +
>
> It would be kind of you to add a more descriptive information of this
> device here.

Yes, I'll add one for the next version.

>
>> +Required properties :
>> +- compatible : "nvidia,tegra124-soctherm".
>> +- reg : Should contain 1 entry:
>> +  - SOCTHERM register set
>> +- interrupts : Defines the interrupt used by SOCTHERM
>> +- clocks : Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names : Must include the following entries:
>> +  - tsensor
>> +  - soctherm
>> +- resets : Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names : Must include the following entries:
>> +  - soctherm
>> +- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
>> +    of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
>> +    list of valid values.
>> +
>> +
>> +Example :
>> +
>> +	soctherm@0,700e2000 {
>> +		compatible = "nvidia,tegra124-soctherm";
>> +		reg = <0x0 0x700e2000 0x0 0x1000>;
>> +		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
>> +			<&tegra_car TEGRA124_CLK_SOC_THERM>;
>> +		clock-names = "tsensor", "soctherm";
>> +		resets = <&tegra_car 78>;
>> +		reset-names = "soctherm";
>> +
>> +		#thermal-sensor-cells = <1>;
>> +	};
>> diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
>> new file mode 100644
>> index 0000000..85aaf66
>> --- /dev/null
>> +++ b/include/dt-bindings/thermal/tegra124-soctherm.h
>> @@ -0,0 +1,13 @@
>> +/*
>> + * This header provides constants for binding nvidia,tegra124-soctherm.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
>> +#define _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
>> +
>> +#define TEGRA124_SOCTHERM_SENSOR_CPU 0
>> +#define TEGRA124_SOCTHERM_SENSOR_MEM 1
>> +#define TEGRA124_SOCTHERM_SENSOR_GPU 2
>> +#define TEGRA124_SOCTHERM_SENSOR_PLLX 3
>> +
>
> Having examples of usages of above defines improves the understanding of
> why we need them. Now, the way this patch is put, looks like they are
> optional (not even needed). For instance, you mention in the
> thermal-sensor-cells "Should be 1", so, why having extra defines?

Precisely since #cells is 1 :) But agreed, I will add a reference to the 
header and an example using the defines for the next version.

>
>> +#endif
>> --
>> 1.8.1.5
>>
>
> --

Thanks for reviewing!

Mikko
