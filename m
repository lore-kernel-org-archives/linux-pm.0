From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 10/14] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Wed, 3 Feb 2016 11:02:24 +0000
Message-ID: <56B1DE40.7080403@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-11-git-send-email-jonathanh@nvidia.com>
 <20160129160625.GA21918@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160129160625.GA21918@rob-hp-laptop>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 29/01/16 16:06, Rob Herring wrote:
> On Thu, Jan 28, 2016 at 04:33:48PM +0000, Jon Hunter wrote:
>> Add power-domain binding documentation for the NVIDIA PMC driver in
>> order to support generic power-domains.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 55 ++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> index 53aa5496c5cf..3c77373aa826 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> @@ -1,5 +1,7 @@
>>  NVIDIA Tegra Power Management Controller (PMC)
>>  
>> +== Power Management Controller Node ==
>> +
>>  The PMC block interacts with an external Power Management Unit. The PMC
>>  mostly controls the entry and exit of the system from different sleep
>>  modes. It provides power-gating controllers for SoC and CPU power-islands.
>> @@ -70,6 +72,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>>                       Defaults to 0. Valid values are described in section 12.5.2
>>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>>  
>> +Optional nodes:
>> +- powergates : This node contains a hierarchy of power domain nodes, which
>> +	       should match the powergates on the Tegra SoC.
>> +
>>  Example:
>>  
>>  / SoC dts including file
>> @@ -115,3 +121,52 @@ pmc@7000f400 {
>>  	};
>>  	...
>>  };
>> +
>> +
>> +== PM Domain Nodes ==
>> +
>> +Each of the PM domain nodes represents a power-domain on the Tegra SoC
>> +that can be power-gated by the PMC and should be named appropriately.
>> +
>> +Required properties:
>> +  - clocks: Must contain an entry for each clock required by the PMC for
>> +    controlling a power-gate. See ../clocks/clock-bindings.txt for details.
>> +  - resets: Must contain an entry for each reset required by the PMC for
>> +    controlling a power-gate. See ../reset/reset.txt for details.
>> +  - nvidia,powergate: Integer cell that contains an identifier for the PMC
>> +    power-gate that is associated with the power-domain. Please refer to
>> +    the Tegra TRM for more details.
> 
> Why not make this value be the power-domain cell for consumers and the 
> pmc be the phandle.

Is there anything wrong with using a label for the consumers? Seems
simpler, if you can just say ...

	adma: adma@702e2000 {
		...
		power-domains = <&pd_audio>;
		...
	};

> Then use reg property for the subnodes. That avoids a custom property.

That is fine with me.

Jon
