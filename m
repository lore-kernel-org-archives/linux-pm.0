From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 1/4] arm64: tegra: Add BPMP thermal sensor to Tegra186
Date: Mon, 10 Jul 2017 11:50:33 +0300
Message-ID: <842a7f8d-e95f-da94-e0a0-f6b458a8212d@kapsi.fi>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
 <20170630235603.GA2943@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:33388 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbdGJJO1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jul 2017 05:14:27 -0400
In-Reply-To: <20170630235603.GA2943@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, rui.zhang@intel.com, thierry.reding@gmail.com, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 01.07.2017 02:56, Eduardo Valentin wrote:
> On Fri, Jun 16, 2017 at 02:28:22PM +0300, Mikko Perttunen wrote:
>> This adds the thermal sensor device provided by the BPMP, and the
>> relevant thermal sensors to the Tegra186 device tree.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 48 ++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> index 5e62e68ac053..5c19ea74da24 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> @@ -4,6 +4,7 @@
>>  #include <dt-bindings/mailbox/tegra186-hsp.h>
>>  #include <dt-bindings/power/tegra186-powergate.h>
>>  #include <dt-bindings/reset/tegra186-reset.h>
>> +#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
>>
>>  / {
>>  	compatible = "nvidia,tegra186";
>> @@ -444,6 +445,53 @@
>>  			#size-cells = <0>;
>>  			status = "disabled";
>>  		};
>> +
>> +		bpmp_thermal: thermal {
>> +			compatible = "nvidia,tegra186-bpmp-thermal";
>> +			#thermal-sensor-cells = <1>;
>> +		};
>> +	};
>> +
>> +	thermal-zones {
>> +		a57 {
>> +			polling-delay = <0>;
>> +			polling-delay-passive = <1000>;
>> +
>> +			thermal-sensors =
>> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_CPU>;
>> +		};
>> +
>> +		denver {
>> +			polling-delay = <0>;
>> +			polling-delay-passive = <1000>;
>> +
>> +			thermal-sensors =
>> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AUX>;
>> +		};
>> +
>> +		gpu {
>> +			polling-delay = <0>;
>> +			polling-delay-passive = <1000>;
>> +
>> +			thermal-sensors =
>> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_GPU>;
>> +		};
>> +
>> +		pll {
>> +			polling-delay = <0>;
>> +			polling-delay-passive = <1000>;
>> +
>> +			thermal-sensors =
>> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_PLLX>;
>> +		};
>> +
>> +		always_on {
>> +			polling-delay = <0>;
>> +			polling-delay-passive = <1000>;
>> +
>> +			thermal-sensors =
>> +				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AO>;
>> +		};
>
> All the above zones are lacking mandatory fields. Please refer to the
> thermal binding documentation.

Will fix.

>
>>  	};
>>
>>  	timer {
>> --
>> 2.13.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
