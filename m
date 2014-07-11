From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
Date: Fri, 11 Jul 2014 12:12:07 +0300
Message-ID: <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 11, 2014 at 06:35:56AM +0200, Viresh Kumar wrote:
> Hi Tuomas,
> 
> On 11 July 2014 03:12, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
> > the CPU clocksource, switch immediately to the DFLL. It allows the use
> > of higher clock rates, and will automatically scale the CPU voltage as
> > well. We also rely on the DFLL driver to determine the CPU clock
> > frequencies that the chip supports, so that we can directly build a
> > cpufreq table with the OPP library helper dev_pm_opp_init_cpufreq_table.
> >
> > This driver is a completely independent of the old cpufreq driver
> > (tegra-cpufreq), which is only used on Tegra20.
> >
> > Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Please reuse cpufreq-cpu0 instead of adding a new driver. Similar
> is being adopted by all platforms now: krait, mvebu, etc..

I don't think that's going to work? The voltage scaling is handled in hw.
cpufreq-cpu0 seems to assume explicit sw control of the vdd_cpu regulator?

Cheers,

Peter.
