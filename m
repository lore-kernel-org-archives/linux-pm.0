From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Remodel Tegra cpufreq drivers to support Tegra
 series SoC
Date: Tue, 17 Dec 2013 11:56:29 +0530
Message-ID: <CAKohponJAU20MQ92y4VaOXbsOOmxz6K=349KCq91c5=P=zQOQQ@mail.gmail.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386229462-3474-1-git-send-email-bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 5 December 2013 13:14, Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> This patch series remodel Tegra cpufreq driver to make it more easy to
> add new SoC support, in addition to that, adding probe function in the
> driver to let probe defer can be used to control init sequence when we
> are going to support DVFS.
>
> Changes since v2:
>
> - Fix Kconfig.
> - Rebase on top of branch 'cpufreq-next' on git://git.linaro.org/people/vireshk/linux.git.

That's wrong base.. This branch is used only for Rafael to pull in
stuff and so it doesn't
get updated everyday..

You must rebase on Rafael's linux-next branch all the time.
