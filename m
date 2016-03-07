From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 2/4] Documentation: DT: bindings: Add power domain info
 for NVIDIA PMC
Date: Mon, 7 Mar 2016 19:33:40 +0000
Message-ID: <56DDD794.8090207@nvidia.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
 <1457094186-15786-3-git-send-email-jonathanh@nvidia.com>
 <20160305043104.GG13525@rob-hp-laptop> <56DD515A.4020207@nvidia.com>
 <56DDBEC6.7080102@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56DDBEC6.7080102-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 07/03/16 17:47, Stephen Warren wrote:
> On 03/07/2016 03:00 AM, Jon Hunter wrote:
>>
>> On 05/03/16 04:31, Rob Herring wrote:
>>> On Fri, Mar 04, 2016 at 12:23:04PM +0000, Jon Hunter wrote:
>>>> Add power-domain binding documentation for the NVIDIA PMC driver in
>>>> order to support generic power-domains.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>   .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 80
>>>> ++++++++++++++++++++++
>>>>   1 file changed, 80 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>> index 53aa5496c5cf..7d52bbe99709 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>> +++
>>>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>> @@ -1,5 +1,7 @@
>>>>   NVIDIA Tegra Power Management Controller (PMC)
>>>>
>>>> +== Power Management Controller Node ==
>>>> +
>>>>   The PMC block interacts with an external Power Management Unit.
>>>> The PMC
>>>>   mostly controls the entry and exit of the system from different sleep
>>>>   modes. It provides power-gating controllers for SoC and CPU
>>>> power-islands.
>>>> @@ -70,6 +72,11 @@ Optional properties for hardware-triggered
>>>> thermal reset (inside 'i2c-thermtrip'
>>>>                        Defaults to 0. Valid values are described in
>>>> section 12.5.2
>>>>                        "Pinmux Support" of the Tegra4 Technical
>>>> Reference Manual.
>>>>
>>>> +Optional nodes:
>>>> +- powergates : This node contains a hierarchy of power domain
>>>> nodes, which
>>>> +           should match the powergates on the Tegra SoC. See
>>>> "Powergate
>>>> +           Nodes" below.
>>>> +
>>>>   Example:
>>>>
>>>>   / SoC dts including file
>>>> @@ -115,3 +122,76 @@ pmc@7000f400 {
>>>>       };
>>>>       ...
>>>>   };
>>>> +
>>>> +
>>>> +== Powergate Nodes ==
>>>> +
>>>> +Each of the powergate nodes represent a power-domain on the Tegra SoC
>>>> +that can be power-gated by the Tegra PMC. The name of the powergate
>>>> node
>>>> +should be one of the below. Note that not every powergate is
>>>> applicable
>>>> +to all Tegra devices and the following list shows which powergates are
>>>> +applicable to which devices. Please refer to the Tegra TRM for more
>>>> +details on the various powergates.
>>>> +
>>>> + Name        Description            Devices Applicable
>>>> + 3d        3D Graphics            Tegra20/114/124/210
>>>> + 3d0        3D Graphics 0            Tegra30
>>>> + 3d1        3D Graphics 1            Tegra30
>>>> + aud        Audio                Tegra210
>>>> + dfd        Debug                Tegra210
>>>> + dis        Display A            Tegra114/124/210
>>>> + disb        Display B            Tegra114/124/210
>>>> + heg        2D Graphics            Tegra30/114/124/210
>>>> + iram        Internal RAM            Tegra124/210
>>>> + mpe        MPEG Encode            All
>>>> + nvdec        NVIDIA Video Decode Engine    Tegra210
>>>> + nvjpg        NVIDIA JPEG Engine        Tegra210
>>>> + pcie        PCIE                Tegra20/30/124/210
>>>> + sata        SATA                Tegra30/124/210
>>>> + sor        Display interfaces        Tegra124/210
>>>> + ve2        Video Encode Engine 2        Tegra210
>>>> + venc        Video Encode Engine        All
>>>> + vdec        Video Decode Engine        Tegra20/30/114/124
>>>> + vic        Video Imaging Compositor    Tegra124/210
>>>> + xusba        USB Partition A            Tegra114/124/210
>>>> + xusbb        USB Partition B         Tegra114/124/210
>>>> + xusbc        USB Partition C            Tegra114/124/210
>>>> +
>>>> +Required properties:
>>>> +  - clocks: Must contain an entry for each clock required by the
>>>> PMC for
>>>> +    controlling a power-gate. See ../clocks/clock-bindings.txt for
>>>> details.
>>>> +  - resets: Must contain an entry for each reset required by the
>>>> PMC for
>>>> +    controlling a power-gate. See ../reset/reset.txt for details.
>>>> +  - #power-domain-cells: Must be 0.
>>>> +
>>>> +Example:
>>>> +
>>>> +    pmc: pmc@0,7000e400 {
>>>
>>> Just pmc@7000e400. We were erronously using commas for 64-bit addresses
>>> briefly, but the correct usage is when there are distinct fields in reg
>>> like PCI bus,dev,func.
>>
>> Ok. Looks like we use this style quite widely across all Tegra 32-bit
>> and 64-bit devices for all peripheral devices.
>>
>> Thierry, Stephen,
>>
>> Do we need to correct this for existing devices?
> 
> I don't think so; my understanding is that where reg has multiple
> address cells, they all get represented in the unit address. Otherwise,
> the node names couldn't be guaranteed unique.

OK, but I am a bit confused as that does not sound exactly the same as
what Rob is saying?

Also, I see that starting with tegra124 we have #address-cells = <2> and
#size-cells = <2>, which I also don't understand either. Are the bus
addresses really 64-bit for tegra124?

Cheers
Jon
