From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC-help needed 0/3] ARM: dts: thermal: Fix Odroid XU3-Lite overheat
Date: Wed, 17 Feb 2016 15:55:25 +0900
Message-ID: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I mentioned overheating problem of Odroid XU3-Lite after enabling
cpufreq-dt (when busy in a quite warm room). [0]

The patchset tries to fix this by adding CPU cooling device.
Unfortunately apparently I screwed something because on next-20160216
it does not help.

The fan works at full but CPU cooler is not enabled.

Patchset adds 2 additional trip points (so total 5). First 3 trip
points enable the fan. The new two trip points should trigger CPU
cooler.

However after reaching last fan trip point, the thermal zone stops
sending updates to the step-wise governor.
The last log for thermal_zone0 is:

[ 1366.604672] thermal thermal_zone0: last_temperature=71000, current_temperature=71000
[ 1366.604699] thermal thermal_zone0: Trip0[type=0,temp=50000]:trend=0,throttle=1
                                                     instance->upper:
                                                        instance->lower:
                                                           throttle:
[ 1366.604713] thermal cooling_device0: cur_state=0, 1, 0, throttle: 1
[ 1366.604725] thermal cooling_device0: CUR_state=0, 1, 0, throttle: 1
[ 1366.604735] thermal cooling_device0: old_target=1, target=1
[ 1366.604754] thermal thermal_zone0: Trip1[type=0,temp=60000]:trend=0,throttle=1
[ 1366.604776] thermal cooling_device0: cur_state=0, 2, 1, throttle: 1
[ 1366.604786] thermal cooling_device0: CUR_state=0, 2, 1, throttle: 1
[ 1366.604796] thermal cooling_device0: old_target=2, target=2
[ 1366.604810] thermal thermal_zone0: Trip2[type=0,temp=70000]:trend=0,throttle=1
[ 1366.604821] thermal cooling_device0: cur_state=0, 3, 2, throttle: 1
[ 1366.604832] thermal cooling_device0: CUR_state=0, 3, 2, throttle: 1
[ 1366.604841] thermal cooling_device0: old_target=3, target=3
[ 1366.604856] thermal thermal_zone0: Trip4[type=1,temp=90000]:trend=0,throttle=0
[ 1366.604869] thermal cooling_device1: cur_state=0, 3, 0, throttle: 0
[ 1366.604879] thermal cooling_device1: CUR_state=0, 3, 0, throttle: 0
[ 1366.604889] thermal cooling_device1: old_target=-1, target=-1
[ 1366.604901] thermal cooling_device2: cur_state=0, 3, 0, throttle: 0
[ 1366.604911] thermal cooling_device2: CUR_state=0, 3, 0, throttle: 0
[ 1366.604921] thermal cooling_device2: old_target=-1, target=-1
[ 1366.604935] thermal thermal_zone0: Trip5[type=1,temp=110000]:trend=0,throttle=0
[ 1366.604946] thermal cooling_device1: cur_state=0, 7, 7, throttle: 0
[ 1366.604957] thermal cooling_device1: CUR_state=0, 7, 7, throttle: 0
[ 1366.604967] thermal cooling_device1: old_target=-1, target=-1
[ 1366.604977] thermal cooling_device2: cur_state=0, 11, 11, throttle: 0
[ 1366.604988] thermal cooling_device2: CUR_state=0, 11, 11, throttle: 0
[ 1366.604997] thermal cooling_device2: old_target=-1, target=-1

After this, the temperature in zone0 rises but cooling devices do not
receive any pokes...

Did I make some mistake or this is thermal issue?


[0] http://www.spinics.net/lists/arm-kernel/msg482748.html


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  ARM: dts: Add cooling levels for CPUs on exynos5420
  ARM: dts: Add cooling levels for CPUs on exynos5422/5800
  ARM: dts: Don't overheat the Odroid XU3-Lite on high load

 arch/arm/boot/dts/exynos5420-cpus.dtsi        |  6 ++++
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 41 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi        |  6 ++++
 3 files changed, 53 insertions(+)

-- 
2.5.0
