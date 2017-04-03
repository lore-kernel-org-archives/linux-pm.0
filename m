From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: Add bindings for
 nvidia,tegra186-ccplex-cluster
Date: Mon, 3 Apr 2017 18:18:43 +0300
Message-ID: <cc23f916-ea17-94b7-abb1-a77d776b0b28@kapsi.fi>
References: <1491223345-24386-1-git-send-email-mperttunen@nvidia.com>
 <1491223345-24386-2-git-send-email-mperttunen@nvidia.com>
 <20170403140617.GA22966@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170403140617.GA22966-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/03/2017 05:06 PM, Thierry Reding wrote:
> On Mon, Apr 03, 2017 at 03:42:24PM +0300, Mikko Perttunen wrote:
>> The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
>> registers that initiate CPU frequency/voltage transitions.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  .../arm/tegra/nvidia,tegra186-ccplex-cluster.txt   | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
>> new file mode 100644
>> index 000000000000..50cd615219e9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-ccplex-cluster.txt
>> @@ -0,0 +1,22 @@
>> +NVIDIA Tegra CCPLEX_CLUSTER area
>> +
>> +Required properties:
>> +- compatible: Should contain one of the following:
>> +  - "nvidia,tegra186-ccplex-cluster": for Tegra186
>> +- reg: Must contain an (offset, length) pair of the register set for each
>> +  entry in reg-names.
>> +- reg-names: Must include the following entries:
>> +  - "a57": Public aperture for A57 CPU cluster
>> +  - "denver": Public aperture for Denver CPU cluster
>> +- nvidia,bpmp: Phandle to BPMP device that can be queried for OPP tables
>
> "phandle"

Will fix.

>
>> +Example:
>> +
>> +	ccplex@e000000 {
>> +		compatible = "nvidia,tegra186-ccplex-cluster";
>> +		reg = <0x0 0x0e060000 0x0 0x1000>,
>> +		      <0x0 0x0e070000 0x0 0x1000>;
>> +		reg-names = "a57", "denver";
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +	};
>
> Where's the information about the register offsets coming from? The TRM
> says that CCPLEX_CLUSTER has a single aperture from 0x0e000000 to
> 0x0e3fffff.

Some internal document with a name related to Denver power management, 
IIRC. I'll link it to you tomorrow.

>
> Thierry
>
