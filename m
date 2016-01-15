From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 09/16] soc: tegra: pmc: Ensure partitions can be
 toggled on/off by PMC
Date: Fri, 15 Jan 2016 09:32:06 +0000
Message-ID: <5698BC96.6040709@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-10-git-send-email-jonathanh@nvidia.com>
 <20160114141453.GD23082@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160114141453.GD23082@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 14/01/16 14:14, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Dec 04, 2015 at 02:57:10PM +0000, Jon Hunter wrote:
>> For Tegra124 and Tegra210, the GPU partition cannot be toggled on and off
>> via the APBDEV_PMC_PWRGATE_TOGGLE_0 register. For these devices, the
>> partition is simply powered up and down via an external regulator.
>> Describe in the PMC SoC data in which devices the GPU partition can be
>> controlled via the APBDEV_PMC_PWRGATE_TOGGLE_0 register and ensure that
>> no one can incorrectly try to toggle the GPU partition via the
>> APBDEV_PMC_PWRGATE_TOGGLE_0 register.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/soc/tegra/pmc.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
> 
> The TRM doesn't mention anything like this. Will this be updated in the
> TRM as well?

For T210, I have requested that the partitions are updated. Looks like
the powergate sequencing information for T210 is still missing from the
TRM. I can request that this is added. I will make a note for T124 as
well as it is missing.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
