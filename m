From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 12/16] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Fri, 15 Jan 2016 09:43:01 +0000
Message-ID: <5698BF25.2080309@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-13-git-send-email-jonathanh@nvidia.com>
 <20160114144158.GF23082@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19744 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240AbcAOJnG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 04:43:06 -0500
In-Reply-To: <20160114144158.GF23082@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org


On 14/01/16 14:41, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Dec 04, 2015 at 02:57:13PM +0000, Jon Hunter wrote:
>> Add power-domain binding documentation for the NVIDIA PMC driver in
>> order to support generic power-domains.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> ---
>>
>> Please note that I have been debating whether I add this
>> "nvidia,powergate-clock-disable" property or just leave the clocks
>> disabled by default. Some downstream kernels leave the clocks enabled
>> for the audio power-domain because the clocks required for powering up
>> the power-domain are needed by all modules within the power-domain.
>> However are the same time there are other power-domains that may need
>> to be on, but not always clocked and so having the ability to specify if
>> the clocks should be disabled seems useful. However, I can also remove
>> this and just have the appropriate devices turn on the clocks as well.
>> ---
>>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 ++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> index 838e1a69ec0a..8e4641db51a9 100644
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
>> @@ -69,6 +71,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>>                       Defaults to 0. Valid values are described in section 12.5.2
>>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>>  
>> +Optional nodes:
>> +- pm-domains : This node contains a hierarchy of PM domain nodes, which should
>> +	       match the power-domains on the Tegra SoC.
>> +
> 
> pm-domains is a linuxism. Perhaps name this after what Tegra calls this:
> "powergates"?

Ok.

Jon
