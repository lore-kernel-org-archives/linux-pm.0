From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 07/17] clk: tegra: Add Tegra124 DFLL clocksource
 platform driver
Date: Tue, 26 May 2015 11:17:22 -0700
Message-ID: <CAMAWPa8PQgNWbajvrxMiD4qcUBg+Q1xsOU5hhhFQbxE4VxW_uQ@mail.gmail.com>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
	<1431529131-16710-8-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431529131-16710-8-git-send-email-mikko.perttunen-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Sc hrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 13, 2015 at 7:58 AM, Mikko Perttunen
<mikko.perttunen-/1wQRMveznE@public.gmane.org> wrote:
> From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Add basic platform driver support for the fast CPU cluster DFLL
> clocksource found on Tegra124 SoCs. This small driver selects the
> appropriate Tegra124-specific characterization data and integration
> code. It relies on the DFLL common code to do most of the work.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
> Acked-by: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Various boot failures on non-tegra platforms (sunxi, omap) started
showing up in next-20150522, and still exist in next-20150525[1] and
today I bisected them down to this patch.

I didn't look closely, but I"m guessing the module_init() function
here needs some compatible checking so it's not actually executed on
non-tegra platforms.

I confirmed that reverting this patch on top of next-20150525 gets
both the sunxi and omap platforms booting again.

Kevin

[1] http://kernelci.org/boot/all/job/next/kernel/next-20150525/
