From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V6 05/10] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Mon, 29 Feb 2016 10:37:20 +0000
Message-ID: <56D41F60.6010504@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-6-git-send-email-jonathanh@nvidia.com>
 <20160229072221.GH23745@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16000 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbcB2Kh1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 05:37:27 -0500
In-Reply-To: <20160229072221.GH23745@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


On 29/02/16 07:22, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Feb 26, 2016 at 03:48:39PM +0000, Jon Hunter wrote:
>> Add power-domain binding documentation for the NVIDIA PMC driver in
>> order to support generic power-domains.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 ++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> index 53aa5496c5cf..0c383a9e720e 100644
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
>> @@ -70,6 +72,11 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>>                       Defaults to 0. Valid values are described in section 12.5.2
>>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>>  
>> +Optional nodes:
>> +- powergates : This node contains a hierarchy of power domain nodes, which
>> +	       should match the powergates on the Tegra SoC. See "Powergate
>> +	       Nodes" below.
>> +
>>  Example:
>>  
>>  / SoC dts including file
>> @@ -115,3 +122,57 @@ pmc@7000f400 {
>>  	};
>>  	...
>>  };
>> +
>> +
>> +== Powergate Nodes ==
>> +
>> +Each of the powergate nodes represents a power-domain on the Tegra SoC
>> +that can be power-gated by the PMC and should be named appropriately.
>> +
>> +Required properties:
>> +  - reg: Contains an integer value that identifies the PMC power-gate.
>> +    Please refer to the Tegra TRM for more details. The parent node
>> +    must contain the following two properties:
>> +    - #address-cells: Must be 1,
>> +    - #size-cells: Must be 0.
>> +  - clocks: Must contain an entry for each clock required by the PMC for
>> +    controlling a power-gate. See ../clocks/clock-bindings.txt for details.
>> +  - resets: Must contain an entry for each reset required by the PMC for
>> +    controlling a power-gate. See ../reset/reset.txt for details.
>> +  - #power-domain-cells: Must be 0.
>> +
>> +Example:
>> +
>> +	pmc: pmc@0,7000e400 {
>> +		compatible = "nvidia,tegra210-pmc";
>> +		reg = <0x0 0x7000e400 0x0 0x400>;
>> +		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
>> +		clock-names = "pclk", "clk32k_in";
>> +
>> +		powergates {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			pd_audio: aud {
>> +				reg = <TEGRA_POWERGATE_AUD>;
>> +				clocks = <&tegra_car TEGRA210_CLK_APE>,
>> +					 <&tegra_car TEGRA210_CLK_APB2APE>;
>> +				resets = <&tegra_car 198>;
>> +				#power-domain-cells = <0>;
>> +			};
>> +		};
>> +	};
> 
> Should we not spell out the list of supported power domains per SoC
> here? The example gives only one, but we have a bunch of others. If they
> can be referred to by phandle I'd expect there to be a list of them. I'm
> not sure if this was discussed earlier, but does it perhaps make sense
> to tie names to IDs, such that we don't need the reg property? That'd be
> analogous to how PMICs define regulators.

So the supported power-domains per SoC are described in the header
"include/dt-bindings/power/tegra-powergate.h" (see patch #8). Perhaps, I
can move patch #8 to before this patch and add a reference to the header
file for a list of supported power-domains. However ...

> The reason why I'm asking is that in the above example it's possible to
> have this:
> 
> 			pd_audio: pcie {
> 				reg = <TEGRA_POWERGATE_SOR>;
> 				...
> 			};

... if we eliminate the "reg" property and just use the name, then yes
it would make sense to move the list of support power-domains into the
binding doc.

It all depends on whether we want to define the IDs in the binding or in
the PMC driver. Right now we have a static list of power-domains in the
PMC driver per SoC and I had thought that in the long term we would be
able to get rid of these and just rely on the binding. But ...

> And there'd be no way to sanity check other than by human inspection.
> Perhaps I'm being overly paranoid and we can easily filter these out
> during code review.

 ... that would mean that we have to rely on the binding being correct
and inspect manually. On the other hand, if we don't have the IDs in the
binding we still need to inspect the static arrays in the PMC driver and
so far I have found a few errors with these. So does it really
change/improve anything?

Cheers
Jon



