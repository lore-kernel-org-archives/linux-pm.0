From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 2/3] dt-bindings: Add bindings for
 nvidia,tegra186-ccplex-cluster
Date: Mon, 3 Apr 2017 18:19:49 +0300
Message-ID: <40534e51-db02-6eb2-2426-b34a5ea0f61d@kapsi.fi>
References: <1491223345-24386-1-git-send-email-mperttunen@nvidia.com>
 <1491223345-24386-2-git-send-email-mperttunen@nvidia.com>
 <87a034c6-ed81-4656-9593-b5708e65edb1@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a034c6-ed81-4656-9593-b5708e65edb1@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org, thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 04/03/2017 05:24 PM, Jon Hunter wrote:
>
> On 03/04/17 13:42, Mikko Perttunen wrote:
>> The Tegra186 CCPLEX_CLUSTER area contains memory-mapped
>> registers that initiate CPU frequency/voltage transitions.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
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
>
> Nit pick ... any reason why we append 'cluster' here? The TRM just says
> the "CPU Complex" consists of two CPU clusters. So
> "nvidia,tegra186-cpu-complex" or "nvidia,tegra186-ccplex" seems fine.
>
> BTW, I do see references in the TRM to CCPLEX_CLUSTER0/1, but never
> CCPLEX_CLUSTER in reference to both. I think it is just CCPLEX AFAICT.

The reason was that the MMIO aperture is called "CCPLEX_CLUSTER" in the 
address map. But I agree it's not a very descriptive name.

>
> Cheers
> Jon
>
