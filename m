From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/9] cpufreq: Add flag to auto-register as cooling device
Date: Wed, 06 Feb 2019 11:32:09 +0100
Message-ID: <2181391.oHn0C2QMFc@aspire.rjw.lan>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 29, 2019 5:55:06 AM CET Amit Kucheria wrote:
> Add a flag for cpufreq drivers to tell cpufreq core to auto-register
> themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others.
> 
> Things needing fixing (but not a blocker for the series):
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.
> 
> Changes since v4:
>  - Added IS_ENABLED guards in cpufreq.c
>  - Changed flag name to CPUFREQ_IS_COOLING_DEV
>  - Collected various review tags
> 
> Changes since v3:
>  - Got rid of wrapper function to register/unregister cooling devices.
>    Directly call the function in cpufreq.c
> 
> Changes since v2:
>  - Get rid of #ifdef'ery and let the pointer exist in all cases
>  - Get rid of (!CPU_THERMAL || THERMAL) dependency in all cpufreq drivers'
>    Kconfig
> 
> Changes since v1:
> - Fix compilation failures with allmodconfig
> - Get rid of #ifdef in cpufreq.c
> - Removed miscellaneous patches and sent them separately
> - Merged patches 1 and 2 from v1
> 
> Amit Kucheria (9):
>   thermal: cpu_cooling: Require thermal core to be compiled in
>   cpufreq: Auto-register the driver as a thermal cooling device if asked
>   cpufreq: qcom-hw: Register as a cpufreq cooling device
>   cpufreq: imx6q: Use auto-registration of thermal cooling device
>   cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
>   cpufreq: mediatek: Use auto-registration of thermal cooling device
>   cpufreq: qoriq: Use auto-registration of thermal cooling device
>   cpufreq: scmi: Use auto-registration of thermal cooling device
>   cpufreq: scpi: Use auto-registration of thermal cooling device
> 
>  drivers/cpufreq/Kconfig            |  3 ---
>  drivers/cpufreq/Kconfig.arm        |  5 -----
>  drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
>  drivers/cpufreq/cpufreq.c          | 13 +++++++++++++
>  drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
>  drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
>  drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
>  drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
>  drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
>  drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
>  drivers/thermal/Kconfig            |  1 +
>  include/linux/cpufreq.h            |  9 +++++++++
>  12 files changed, 37 insertions(+), 92 deletions(-)
> 
> 

I've applied the series, thanks!
