From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 03/19] memory: tegra: add flush operation for Tegra30
 memory clients
Date: Tue, 21 Jul 2015 09:54:03 +0100
Message-ID: <55AE08AB.6060903@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com> <1436791197-32358-4-git-send-email-jonathanh@nvidia.com> <20150717100337.GH3057@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150717100337.GH3057@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?windows-1252?Q?Terje_Bergstr?= =?windows-1252?Q?=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 17/07/15 11:03, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jul 13, 2015 at 01:39:41PM +0100, Jon Hunter wrote:
>> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> This patch adds the hot reset register table and flush related callback
>> functions for Tegra30.
>>
>> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> [jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Removed tegra_mc_ops and added
>>  metastable_flush_reads.]
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> ---
>> v3: removal of tegra_mc_ops
>> ---
>>  drivers/memory/tegra/tegra30.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
>> index 1abcd8f6f3ba..3b4987f39b52 100644
>> --- a/drivers/memory/tegra/tegra30.c
>> +++ b/drivers/memory/tegra/tegra30.c
>> @@ -6,6 +6,7 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> +#include <linux/device.h>
> 
> What do you need this for?

Looks like I forgot to remove this, when removing the tegra_mc_ops.
Thanks, will remove.

>>  #include <linux/of.h>
>>  #include <linux/mm.h>
>>  
>> @@ -936,6 +937,26 @@ static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
>>  	{ .name = "isp",  .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
>>  };
>>  
>> +static struct tegra_mc_flush tegra30_mc_flush[] = {
> 
> const

Yes, will fix.

>> +	{TEGRA_SWGROUP_AFI,        0x200, 0x204,  0},
>> +	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
>> +	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
>> +	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
>> +	{TEGRA_SWGROUP_EPP,        0x200, 0x204,  4},
>> +	{TEGRA_SWGROUP_G2,         0x200, 0x204,  5},
>> +	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
>> +	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
>> +	{TEGRA_SWGROUP_ISP,        0x200, 0x204,  8},
>> +	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
>> +	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
>> +	{TEGRA_SWGROUP_MPE,        0x200, 0x204, 11},
>> +	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
>> +	{TEGRA_SWGROUP_NV2,        0x200, 0x204, 13},
>> +	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
>> +	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
>> +	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
> 
> Spaces around { and }, please.

Ok.

Cheers
Jon
