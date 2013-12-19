From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Thu, 19 Dec 2013 10:59:21 +0530
Message-ID: <CAKohpo=fJTLrN6myq5b9FTSro1m9oN3ep-aMu-3iv0J-S6TpdQ@mail.gmail.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>
	<1386229462-3474-3-git-send-email-bilhuang@nvidia.com>
	<CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>
	<52B02D04.4050905@nvidia.com>
	<CAKohpom0n8P8goQnsgBnWJwyqCVv_FRX3xKvO1yFW0VUMpMW8w@mail.gmail.com>
	<52B187F5.7020105@nvidia.com>
	<CAKohpokwhYC4FGnhpZPOGuJ2AM_7vygNk+3S+VpA_eXAexQX7g@mail.gmail.com>
	<52B28397.5010808@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52B28397.5010808-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bilhuang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 19 December 2013 10:56, bilhuang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> I'm not sure virtual regulator for CPU is a good idea, in addition to that,
> we don't have a single SoC OPP table, we need several which are speedo-id
> and process-id dependant, but generic cpufreq-cpu0 is assuming there is only
> one statically

Can't that be handled via DT ?

> for some SoC the frequency table is not fixed, they are
> created at runtime combining our fast and slow CPU frequency table and dvfs
> table. So I'm really not sure is it worth adding so many tweaks in order to
> use the generic cpufreq-cpu0 driver.

Hmm, maybe I got confused because I don't have a clear picture in my mind.
It might be better to go ahead with your implementation for now and after
everything is set, we can choose to use cpufreq-cpu0 if it is worth it.

--
viresh
