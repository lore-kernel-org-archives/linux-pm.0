From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and
 Tegra20/30 support
Date: Fri, 3 May 2019 09:31:57 +0900
Message-ID: <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
        <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
> Changelog:
> 
> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
> 
>     - changed the driver removal order to match the probe exactly
>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
> 
>     Chanwoo, please also note that the clk patch that should fix
>     compilation problem that was reported the kbuild-test-robot is already
>     applied and available in the recent linux-next.

I knew that Stephen picked up your path about clock.

> 
> v3: Addressed all review comments that were made by Chanwoo Choi to v2.
> 
>     Patch "Synchronize IRQ after masking it in hardware" morphed into
>     "Properly disable interrupts", which disables interrupts more solidly.
> 
>     Added new minor patch: "Rename tegra-devfreq.c to tegra30-devfreq.c".
> 
>     Added missed error handlings for dev_pm_opp_add().
> 
> v2: The patchset was quite heavily reworked since v1, few patches we
>     dropped or squashed into the new ones and more patches we added.
>     In a result more bugs and potential problems are fixed now, driver's
>     code got more clean up.
> 
>     The Tegra20 driver-addition patch is now a part of this series, it has
>     no changes since v1.
> 
> Dmitry Osipenko (16):
>   PM / devfreq: tegra: Fix kHz to Hz conversion
>   PM / devfreq: tegra: Replace readl-writel with relaxed versions
>   PM / devfreq: tegra: Replace write memory barrier with the read
>     barrier
>   PM / devfreq: tegra: Don't ignore clk errors
>   PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
>   PM / devfreq: tegra: Drop primary interrupt handler
>   PM / devfreq: tegra: Properly disable interrupts
>   PM / devfreq: tegra: Clean up driver's probe / remove
>   PM / devfreq: tegra: Avoid inconsistency of current frequency value
>   PM / devfreq: tegra: Mark ACTMON's governor as immutable
>   PM / devfreq: tegra: Move governor registration to driver's probe
>   PM / devfreq: tegra: Reconfigure hardware on governor's restart
>   PM / devfreq: tegra: Support Tegra30
>   PM / devfreq: tegra: Enable COMPILE_TEST for the driver
>   PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
>   PM / devfreq: Introduce driver for NVIDIA Tegra20
> 
>  MAINTAINERS                                   |   8 +
>  drivers/devfreq/Kconfig                       |  15 +-
>  drivers/devfreq/Makefile                      |   3 +-
>  drivers/devfreq/tegra20-devfreq.c             | 212 ++++++++++++
>  .../{tegra-devfreq.c => tegra30-devfreq.c}    | 315 ++++++++----------
>  5 files changed, 379 insertions(+), 174 deletions(-)
>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
>  rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (81%)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
