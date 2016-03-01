From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V6 05/10] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
Date: Tue, 1 Mar 2016 11:36:48 +0000
Message-ID: <56D57ED0.10305@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-6-git-send-email-jonathanh@nvidia.com>
 <20160229072221.GH23745@ulmo> <56D41F60.6010504@nvidia.com>
 <20160229110100.GB674@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160229110100.GB674@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 29/02/16 11:01, Thierry Reding wrote:

[snip]

> I've always considered per-SoC invariant data to not belong into
> bindings. That is, constants such as power partition IDs or SMMU client
> IDs should be defined via tables in drivers, and DT should be used to
> hook them up to devices.
> 
> Defining the existing power domains in DT seems rather brittle to me. A
> compatible string would imply the set of supported power domains anyway
> and having that set specified in DT would technically require us to add
> code in the driver to validate that the DT is sane, which would entail
> the addition of a very similar table anyway.
> 
> One further reason why I prefer not to have these things specified (as
> opposed to "glued" together) in DT is that the DT is ABI, so if we ever
> happen to ship a broken DT we won't be able to easily fix it. Driver
> code, on the other hand, can always easily be fixed.

Yes, I guess that is consistent with other Tegra drivers too. Ok, I will
drop the reg property and just use the name.

Cheers
Jon
