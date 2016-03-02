From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V6 07/10] soc: tegra: pmc: Add generic PM domain support
Date: Tue, 01 Mar 2016 16:18:20 -0800
Message-ID: <7hfuw968c3.fsf@baylibre.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
	<1456501724-28477-8-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456501724-28477-8-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> (Jon
	Hunter's message of "Fri, 26 Feb 2016 15:48:41 +0000")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> writes:

> Adds generic PM support to the PMC driver where the PM domains are
> populated from device-tree and the PM domain consumer devices are
> bound to their relevant PM domains via device-tree as well.
>
> Update the tegra_powergate_sequence_power_up() API so that internally
> it calls the same tegra_powergate_xxx functions that are used by the
> tegra generic power domain code for consistency.
>
> To ensure that the Tegra power domains (a.k.a powergates) cannot be
> controlled via both the legacy tegra_powergate_xxx functions as well
> as the generic PM domain framework, add a bit map for available
> powergates that can be controlled via the legacy powergate functions.
>
> Move the majority of the tegra_powergate_remove_clamping() function
> to a sub-function, so that this can be used by both the legacy and
> generic power domain code.
>
> This is based upon work by Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> and Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I didn't look in great detail at the SoC specifics, but for the for the
general genpd approach:

Acked-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
