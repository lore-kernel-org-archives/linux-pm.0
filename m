From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 11/16] Documentation: DT: bindings: Update NVIDIA PMC
 for Tegra210
Date: Mon, 7 Dec 2015 09:54:15 +0000
Message-ID: <56655747.9070009@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-12-git-send-email-jonathanh@nvidia.com>
 <20151206003106.GA12441@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151206003106.GA12441@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 06/12/15 00:31, Rob Herring wrote:
> On Fri, Dec 04, 2015 at 02:57:12PM +0000, Jon Hunter wrote:
>> ---
>>  Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> index 02c27004d4a8..838e1a69ec0a 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>> @@ -9,8 +9,9 @@ Required properties:
>>  - compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra30,
>>    must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
>>    "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc".
>> -  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
>> -  above, where <chip> is tegra132.
>> +  For Tegra210, must contain "nvidia,tegra210-pmc". Otherwise, must contain
>> +  "nvidia,<chip>-pmc", plus at least one of the above, where <chip> is
>> +  tegra132.
> 
> Can you reorg this some so the compatible strings are a list rather than 
> a paragraph of text. I find the last sentence a bit confusing as well. 
> Seems like <chip> should be a list rather than just tegra132.

Yes no problem.

Thanks
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
