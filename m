From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 12/16] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Wed, 9 Dec 2015 12:23:47 +0000
Message-ID: <56681D53.9090600@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-13-git-send-email-jonathanh@nvidia.com>
 <7h4mfslpyd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7h4mfslpyd.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 08/12/15 19:07, Kevin Hilman wrote:
> Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> writes:
> 
>> Add power-domain binding documentation for the NVIDIA PMC driver in
>> order to support generic power-domains.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
>>  Example:
>>  
>>  / SoC dts including file
>> @@ -114,3 +120,58 @@ pmc@7000f400 {
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
> 
> We've had this discussiona for a couple of other SoCs, so I need to
> ask...
> 
> Presumably these are not device clocks that a runtime PM enabled driver
> should be managing for a device, right?  IOW, We want to make sure that the
> PM domain isn't managing clocks for drivers that should be doing it.
> 
> I understand there are legitimate reasons for the PM domain to manage
> clocks in addition to device drivers (e.g. for synchronous reset), but
> just want to be sure it's not a shortcut for having a proper driver.

So some clocks may also be used by devices, but they are needed as part
of the power ungating/gating sequence. The general power-up sequence for
tegra is ...

1. Enable the power-domain
2. Enable the clock(s)
3. Remove signal clamps
4. De-assert reset(s)
5. Disable clocks (optional)

You may say we should only handle #1 above for the powering up sequence,
but we can't do this. The reason is that there is one bit for each
power-domain that controls the signaling clamps and so we need to turn
on all the clocks specified in the TRM before we do this. Once we have
done this and released the reset(s), we can then disable the clocks
again (shown above an optional as it is not mandatory from a design
perspective) and then the devices in the power-domain should enable the
clocks they need as and when they want them.

Please note that I 100% agree that all clocks required by a device are
handled by the device and we do not implement any short-cuts here. The
only question I had was if there are clocks that may be bus clocks in
the power-domain that are required by all device in the power-domain.
However, may be this should be represented as a bus driver and all the
devices are children of it?

Hope that helps.

Cheers
Jon
