From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
Date: Wed, 19 Oct 2016 11:59:09 +0200
Message-ID: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This switches the ARM Integrator/AP and Integrator/CP to use the
Device Tree cpufreq policy with its definition of operating points
using the generic OPP library.

The Integrators does not need to control a regulator to switch
frequency, only a clock. This clock and its device tree bindings
have been defined in the device tree and merged upstream for v4.9.

This approach provides a little better granularity on the
Integrator/AP where I defined a few operating points: before
this change the Integrator would just switch between min speed
(12 MHz) and max speed (71 MHz). Now it can switch between a
few arbitrarily chosen OPPs as in the examples below:

The following tests were made on the Integrator/AP:

/sys/devices/system/cpu/cpufreq/policy0 echo ondemand > scaling_governor
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 71000000 Hz --> 24000000 Hz
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 24000000 Hz --> 12000000 Hz
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 12000000 Hz --> 24000000 Hz
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 24000000 Hz --> 12000000 Hz

The switch from 12 to 24 MHz is triggered by as little as using the
command line with the ondemand governor. If we do this:

yes > /dev/null &
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 12000000 Hz --> 36000000 Hz
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 36000000 Hz --> 71000000 Hz
pkill yes
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 71000000 Hz --> 12000000 Hz

So the algorithm is indeed using all the OPPs.

Also as a confirmation test to make sure performance is affected by the
speed changes, we set the performance governor and:

echo 12000 > scaling_max_freq
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 71000000 Hz --> 12000000 Hz
time find /sys|sort|uniq > /dev/null
real    0m 45.51s
user    0m 11.15s
sys     0m 26.74s

echo 71000 > scaling_max_freq
cpu cpu0: dev_pm_opp_set_rate: switching OPP: 12000000 Hz --> 71000000 Hz
time find /sys|sort|uniq
 > /dev/null
real    0m 9.13s
user    0m 2.35s
sys     0m 5.50s

So it is working.

If people are happy with this approach and approve of the patches
I'd like an ACK from the cpufreq people and then merge the whole set
through ARM SoC.

Linus Walleij (5):
  cpufreq: enable the DT cpufreq driver on the Integrators
  ARM: dts: Add Integrator/AP cpus node and operating points
  ARM: dts: Add Integrator/CP cpus node and operating points
  ARM: defconfig: turn on the DT cpufreq for Integrator
  cpufreq: retire the Integrator cpufreq driver

 arch/arm/boot/dts/integratorap.dts    |  35 +++++
 arch/arm/boot/dts/integratorcp.dts    |  26 ++++
 arch/arm/configs/integrator_defconfig |   1 +
 drivers/cpufreq/Kconfig.arm           |   8 --
 drivers/cpufreq/Makefile              |   1 -
 drivers/cpufreq/cpufreq-dt-platdev.c  |   3 +
 drivers/cpufreq/integrator-cpufreq.c  | 239 ----------------------------------
 7 files changed, 65 insertions(+), 248 deletions(-)
 delete mode 100644 drivers/cpufreq/integrator-cpufreq.c

-- 
2.7.4
