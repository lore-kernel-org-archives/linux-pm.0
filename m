From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Remodel Tegra cpufreq driver to support Tegra
 series SoCs
Date: Thu, 12 Sep 2013 16:57:28 +0530
Message-ID: <CAKohpom-8abJCL_VrdvowmKUkfyEw0svne-RpXFhhO1AH6NPew@mail.gmail.com>
References: <1378985091-9447-1-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378985091-9447-1-git-send-email-bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12 September 2013 16:54, Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> This patch series remodel Tegra cpufreq driver to make it more easy to
> add new SoC support, in addition to that, adding probe function in the
> driver to let probe defer can be used to control init sequence when we
> going to support DVFS.
>
> Changes since v1:
>
> - Split up patches.
> - Split configuration-time data out of structure "tegra_cpufreq_data".
> - Bug fixes.
>
> Bill Huang (4):
>   cpufreq: tegra: Call tegra_cpufreq_init() specifically in machine
>     code
>   cpufreq: tegra: Remove not used header files and clean up codes
>   cpufreq: tegra: Re-model Tegra cpufreq driver
>   ARM: tegra: defconfig updates
>
>  arch/arm/configs/tegra_defconfig  |    1 +
>  arch/arm/mach-tegra/common.c      |    2 +
>  drivers/cpufreq/Kconfig.arm       |    8 +-
>  drivers/cpufreq/Makefile          |    1 +
>  drivers/cpufreq/tegra-cpufreq.c   |  194 +++++++++++++++++--------------------
>  drivers/cpufreq/tegra-cpufreq.h   |   42 ++++++++
>  drivers/cpufreq/tegra20-cpufreq.c |  138 ++++++++++++++++++++++++++
>  include/linux/tegra-soc.h         |   11 ++-
>  8 files changed, 290 insertions(+), 107 deletions(-)
>  create mode 100644 drivers/cpufreq/tegra-cpufreq.h
>  create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

I haven't gone deeper into these yet, but there are some cleaup
patches that I have prepared/posted earlier, which will be queued
by Rafael soon.. And after that you would be required to rebase
your stuff on top of it..  As there would be many conflicts..

--
viresh
