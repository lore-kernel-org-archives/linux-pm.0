From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/2] cpufreq: qoriq: Make the driver usable on all
 QorIQ platforms
Date: Fri, 21 Nov 2014 14:52:05 +0530
Message-ID: <CAKohpokKJQV3-b-hqUz7pKgM+SVRBqW=tq54sxpkeAU=Pg73pQ@mail.gmail.com>
References: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, r64188@freescale.com
List-Id: linux-pm@vger.kernel.org

On 21 November 2014 14:48, Tang Yuantian <Yuantian.Tang@freescale.com> wrote:
> Freescale introduced new ARM core-based SoCs which support dynamic
> frequency switch feature. DFS on new SoCs are compatible with current
> PowerPC CoreNet platforms. In order to support those new platforms,
> this driver needs to be updated. The main changes include:
>
> 1. Changed the names of functions in driver.
> 2. Added two new functions get_cpu_physical_id() and get_bus_freq().
> 3. Used a new way to get the CPU mask which share clock wire.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v3:
>         - put the menu entries into Kconfig
> v2:
>         - split the name change into a separete patch
>         - use policy->driver_data instead of per_cpu variable
>
>  drivers/cpufreq/Kconfig               |   8 ++
>  drivers/cpufreq/Kconfig.powerpc       |   9 --
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 160 +++++++++++++++++++++-------------
>  3 files changed, 107 insertions(+), 70 deletions(-)

For both patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
