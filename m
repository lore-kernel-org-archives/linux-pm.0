From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v5 3/4] ARM: tegra: Add thermal trip points for Jetson
 TK1
Date: Wed, 24 Sep 2014 21:34:16 +0300
Message-ID: <54230EA8.7080604@kapsi.fi>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com> <1408616242-21009-4-git-send-email-mperttunen@nvidia.com> <20140924183204.GE27076@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140924183204.GE27076@developer>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, juha-matti.tilli-X3B1VOXEql0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 09/24/2014 09:32 PM, Eduardo Valentin wrote:
> Hello Mikko,
>
> On Thu, Aug 21, 2014 at 01:17:21PM +0300, Mikko Perttunen wrote:
>> This adds critical trip points to the Jetson TK1 device tree.
>> The device will do a controlled shutdown when either the CPU, GPU
>> or MEM thermal zone reaches 101 degrees Celsius.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>> v5: added cooling-maps nodes
>>
>
> OK. But no cooling map entry in it. What was the reason again you don't
> need/want to add the maps?

There is currently no cooling device to map to.

Mikko

>
>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 41 +++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> index 0cdb5cf..bcdab7f 100644
>> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> @@ -1876,4 +1876,45 @@
>>   			 <&tegra_car TEGRA124_CLK_EXTERN1>;
>>   		clock-names = "pll_a", "pll_a_out0", "mclk";
>>   	};
>> +
>> +	thermal-zones {
>> +		cpu {
>> +			trips {
>> +				trip@0 {
>> +					temperature = <101000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +			};
>> +		};
>> +
>> +		mem {
>> +			trips {
>> +				trip@0 {
>> +					temperature = <101000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +			};
>> +		};
>> +
>> +		gpu {
>> +			trips {
>> +				trip@0 {
>> +					temperature = <101000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +			};
>> +		};
>> +	};
>>   };
>> --
>> 1.8.1.5
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
