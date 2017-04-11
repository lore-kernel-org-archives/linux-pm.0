From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] soc/tegra: bpmp: Generic PM domains for Tegra186
Date: Tue, 11 Apr 2017 21:37:30 +0200
Message-ID: <CAPDyKFqD+_sShdbo4uGisPO-6DvdcnZnx_bb_ubC9ZKHyTuPyA@mail.gmail.com>
References: <20170329163452.10761-1-thierry.reding@gmail.com> <20170411152838.GA13819@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170411152838.GA13819-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11 April 2017 at 17:28, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Wed, Mar 29, 2017 at 06:34:49PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >
> > Hi Rafael, Kevin, Ulf,
> >
> > This series implement generic power domains for Tegra186. Since the
> > power partitions on Tegra186 have a non-contiguous ID range, the PM
> > domain core is enhanced with a way to allow PM domain providers to
> > override the default ->xlate() implementation. This is used to look
> > up the correct PM domain given the ID read from device tree.
> >
> > The second patch updates the BPMP ABI header to a version that has
> > support for the MRQ_PG request which is used to enumerate available
> > power partitions and control them.
> >
> > An implementation of the generic PM domains using the MRQ_PG request
> > is provided in patch 3.
> >
> > Given the dependency of patch 3 on patch 1 I think it'd be easiest
> > to get an Acked-by on patch 1 and take all of these through the Tegra
> > tree. If that's okay with you, I can provide a stable branch with the
> > first patch that could be pulled into the PM tree to resolve potential
> > conflicts.
> >
> > Thanks,
> > Thierry
> >
> > Changes in v2:
> > - take into account PG_STATE_RUNNING in tegra_bpmp_powergate_is_powered()
> > - check return value of pm_genpd_init() and clean up on failure
> > - simplify error unwinding in tegra_bpmp_init_powergates()
> >
> > Thierry Reding (3):
> >   PM / Domains: Allow overriding the ->xlate() callback
> >   soc/tegra: bpmp: Update ABI header
> >   soc/tegra: bpmp: Implement generic PM domains
>
> Any comments on this? If not, can we get this into v4.12?

Thanks for the reminder!

Allow me to get a couple of more days for this, I have just catched up
on mmc, due to travel and sickness.

Kind regards
Uffe
