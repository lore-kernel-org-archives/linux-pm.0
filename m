From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V6 03/10] PM / Domains: Add function to remove a pm-domain
Date: Mon, 29 Feb 2016 13:10:48 +0000
Message-ID: <56D44358.5050606@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-4-git-send-email-jonathanh@nvidia.com>
 <20160229071521.GG23745@ulmo> <56D41A17.20008@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D41A17.20008-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 29/02/16 10:14, Jon Hunter wrote:
> 
> On 29/02/16 07:15, Thierry Reding wrote:
>> * PGP Signed by an unknown key
>>
>> On Fri, Feb 26, 2016 at 03:48:37PM +0000, Jon Hunter wrote:
>>> The genpd framework allows users to add power-domains via the
>>> pm_genpd_init() function, however, there is no corresponding function
>>> to remove a power-domain. For most devices this may be fine as the power
>>> domains are never removed, however, for devices that wish to populate
>>> the power-domains from within a driver, having the ability to remove a
>>> power domain if the probing of the device fails or the driver is unloaded
>>> is necessary. Therefore, add a function to remove a power-domain. Please
>>> note that the power domain can only be removed if there are no devices
>>> using the power-domain and it is not linked to another domain.
>>
>> So I guess this introduces a problem not uncommon to other types of
>> resources. If you remove the driver, even if you fail ->remove() the
>> module may still go away along with any code associated with it. So
>> even if the PM domains can't be removed, you can't prevent the module
>> from going away. That could be somewhat mitigated if we were holding a
>> module reference count, because then the only way to unload the driver
>> would be via sysfs (we could prevent that too, which might be the best
>> way to do this today).
>>
>> There is work underway to solve this generically, Rafael was working on
>> this, so I'm not sure we need to add additional infrastructure to the PM
>> domain code as part of this series. But we may want to mark the Tegra
>> PMC driver as .suppress_bind_attrs = true, to make sure it can't be
>> removed.
> 
> I see what you are saying. It nearly seemed to me that I should use
> BUG_ON() if we fail to remove a genpd in the PMC driver, however, I know
> that using BUG_ON should be avoided. I will add the suppress_bind_attrs
> = true for the PMC driver as that does make sense for now.

Just to let you know, the PMC driver already has suppress_bind_attrs =
true.

Cheers
Jon
