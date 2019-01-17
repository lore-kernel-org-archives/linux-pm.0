From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Date: Thu, 17 Jan 2019 11:19:16 +0530
Message-ID: <20190117054916.dqduckt7larn32av@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dianders@chromium.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, mka@chromium.org, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, swboyd@chromium.org, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 14-01-19, 22:04, Amit Kucheria wrote:
> Add a flag to be used by cpufreq drivers to tell cpufreq core to
> auto-register themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others. 
> 
> Things needing fixing:
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.

is_bL_switching_enabled() lets you know if IKS is enabled or not.
Set/clear flag conditionally before the cpufreq-driver is registered,
based on the output of is_bL_switching_enabled().

>  - The other pending issue is to fix allmodconfig that leaves us with
>    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
>    references for functions defined in cpu_cooling.c

Okay, that's a terrible thing and the solution looks to be rather
difficult.

For others who may not be aware of the issue here, currently the
cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
which uses helpers of the thermal core (CONFIG_THERMAL).
CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
in Kconfigs.

The cpufreq drivers using the cpu_cooling.c file have this in their
Kconfig entry:

# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
#       depends on !CPU_THERMAL || THERMAL


This series now places the cpufreq core in place of the cpufreq driver
and it messes up everything. It is not just about allmodconfig, but
any configuration which makes the compilation fail.

What are the solutions we have now ?

1. Have following for CONFIG_CPU_FREQ
       depends on !CPU_THERMAL || THERMAL

   The platforms which don't need CPU_THERMAL (like x86) should not
   enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.

   @amit: If this gets accepted, please update the Kconfig entries for
   all those drivers to not have above lines anymore.

- Change CONFIG_THERMAL to bool instead of tristate ?

- Anything else ?

-- 
viresh
