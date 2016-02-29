From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V6 06/10] soc: tegra: pmc: Wait for powergate state to
 change
Date: Mon, 29 Feb 2016 10:38:29 +0000
Message-ID: <56D41FA5.5050205@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-7-git-send-email-jonathanh@nvidia.com>
 <20160229072415.GI23745@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160229072415.GI23745@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 29/02/16 07:24, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Feb 26, 2016 at 03:48:40PM +0000, Jon Hunter wrote:
>> Currently, the function tegra_powergate_set() simply sets the desired
>> powergate state but does not wait for the state to change. In most cases
>> we should wait for the state to change before proceeding. Currently, there
>> is a case for tegra114 and tegra124 devices where we do not wait when
>> starting the secondary CPU as this is not necessary. However, this is only
>> done at boot time and so waiting here will only have a small impact on
>> boot time. Therefore, update tegra_powergate_set() to wait when setting
>> the powergate.
>>
>> By adding this feature, we can also eliminate the polling loop from
>> tegra30_boot_secondary().
>>
>> A function has been added for checking the status of the powergate and
>> so update the tegra_powergate_is_powered() to use this macro as well.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>>  drivers/soc/tegra/pmc.c       |  9 ++++++++-
>>  2 files changed, 11 insertions(+), 14 deletions(-)
> 
> This looks to be independent from the generic power domain support. Can
> I apply this separately (for 4.6, without waiting for the power domain
> series' dependencies to go in)?

Yes this could be applied independently of this series for v4.6. I just
wanted to make sure that this change is added before the genpd changes
are applied.

Cheers
Jon
