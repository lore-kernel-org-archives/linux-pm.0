From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [next] Odroid XU3 boot fail after cpufreq: dt: Use
 dev_pm_opp_set_rate() to switch frequency
Date: Sun, 14 Feb 2016 13:56:18 +0900
Message-ID: <56C008F2.3080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33382 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbcBNE4Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2016 23:56:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi all,

Recently Odroid XU3 failed to boot on linux-next
on multi_v7 defconfig. exynos defconfig boots fine.

Probably the "cpufreq: dt: Use dev_pm_opp_set_rate() to
switch frequency" is important here:
commit 78c3ba5df96c875b1668e1cd3ee0a69e62454f32
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue Feb 9 10:30:46 2016 +0530

    cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
    
    OPP core supports frequency/voltage changes based on the target
    frequency now, use that instead of open coding the same in cpufreq-dt
    driver.
    
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
    Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Full log:
http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7/builds/276/steps/Boot%20odroid/logs/serial

dmesg:
Feb 14 10:29:58 [    1.620308] vdd_ldo9: ramp_delay not set
Feb 14 10:29:58 [    1.631144] vdd_ldo13: ramp_delay not set
Feb 14 10:29:58 [    1.638523] vdd_ldo15: ramp_delay not set
Feb 14 10:29:58 [    1.649500] vdd_sd: ramp_delay not set
Feb 14 10:29:58 [    1.712318] ------------[ cut here ]------------
Feb 14 10:29:58 [    1.715490] kernel BUG at ../drivers/regulator/core.c:216!
...
Feb 14 10:29:58 [    2.109871] [<c0684af4>] (regulator_check_voltage) from [<c06857ac>] (regulator_set_voltage_unlocked+0x58/0x230)
Feb 14 10:29:58 [    2.120000] [<c06857ac>] (regulator_set_voltage_unlocked) from [<c06859ac>] (regulator_set_voltage+0x28/0x54)
Feb 14 10:29:58 [    2.129880] [<c06859ac>] (regulator_set_voltage) from [<c0775b28>] (_set_opp_voltage+0x30/0x98)
Feb 14 10:29:58 [    2.138543] [<c0775b28>] (_set_opp_voltage) from [<c0776630>] (dev_pm_opp_set_rate+0xf0/0x28c)
Feb 14 10:29:58 [    2.147126] [<c0776630>] (dev_pm_opp_set_rate) from [<c096f784>] (__cpufreq_driver_target+0x184/0x2b4)
Feb 14 10:29:58 [    2.156394] [<c096f784>] (__cpufreq_driver_target) from [<c0973760>] (dbs_check_cpu+0x1b0/0x1f4)
Feb 14 10:29:58 [    2.165143] [<c0973760>] (dbs_check_cpu) from [<c0973f30>] (cpufreq_governor_dbs+0x324/0x5c4)
Feb 14 10:29:58 [    2.173637] [<c0973f30>] (cpufreq_governor_dbs) from [<c0970958>] (__cpufreq_governor+0xe4/0x1ec)
Feb 14 10:29:58 [    2.182477] [<c0970958>] (__cpufreq_governor) from [<c09711e0>] (cpufreq_init_policy+0x64/0x8c)
Feb 14 10:29:58 [    2.191141] [<c09711e0>] (cpufreq_init_policy) from [<c09718cc>] (cpufreq_online+0x2fc/0x708)
Feb 14 10:29:58 [    2.199634] [<c09718cc>] (cpufreq_online) from [<c0765ff0>] (subsys_interface_register+0x94/0xd8)
Feb 14 10:29:58 [    2.208472] [<c0765ff0>] (subsys_interface_register) from [<c0970530>] (cpufreq_register_driver+0x14c/0x19c)
Feb 14 10:29:58 [    2.218263] [<c0970530>] (cpufreq_register_driver) from [<c09746dc>] (dt_cpufreq_probe+0x70/0xec)
Feb 14 10:29:59 [    2.227104] [<c09746dc>] (dt_cpufreq_probe) from [<c076907c>] (platform_drv_probe+0x4c/0xb0)
Feb 14 10:29:59 [    2.235508] [<c076907c>] (platform_drv_probe) from [<c07678e0>] (driver_probe_device+0x214/0x2c0)
Feb 14 10:29:59 [    2.244345] [<c07678e0>] (driver_probe_device) from [<c0767a18>] (__driver_attach+0x8c/0x90)
Feb 14 10:29:59 [    2.252750] [<c0767a18>] (__driver_attach) from [<c0765c2c>] (bus_for_each_dev+0x68/0x9c)
Feb 14 10:29:59 [    2.260895] [<c0765c2c>] (bus_for_each_dev) from [<c0766d78>] (bus_add_driver+0x1a0/0x218)
Feb 14 10:29:59 [    2.269128] [<c0766d78>] (bus_add_driver) from [<c076810c>] (driver_register+0x78/0xf8)
Feb 14 10:29:59 [    2.277103] [<c076810c>] (driver_register) from [<c0301d74>] (do_one_initcall+0x90/0x1d8)
Feb 14 10:29:59 [    2.285254] [<c0301d74>] (do_one_initcall) from [<c1100e14>] (kernel_init_freeable+0x15c/0x1fc)
Feb 14 10:29:59 [    2.293918] [<c1100e14>] (kernel_init_freeable) from [<c0b27a0c>] (kernel_init+0x8/0xf0)
Feb 14 10:29:59 [    2.301975] [<c0b27a0c>] (kernel_init) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
Feb 14 10:29:59 [    2.309508] Code: e1550004 baffffeb e3a00000 e8bd8070 (e7f001f2) 
Feb 14 10:29:59 [    2.315585] ---[ end trace 42d99689dedcb6cb ]---


Device boots fine after reverting last three opp patches:
1. dd02a3d920083b6cb0ee4f0eaf2c599b740bf5fe
2. df2c8ec28e73d47392b8cb24828c15c54819da41
3. 78c3ba5df96c875b1668e1cd3ee0a69e62454f32


More details:
1. multi_v7_defconfig with enabled IPV6,NFS_V4,SENSORS_PWM_FAN,PWM_SAMSUNG
and disabled LEDS_TRIGGER_HEARTBEAT.
2. exynos5422-odroidxu3-lite.dts
3. The OPP used for cpufreq-dt are a combination of:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/exynos5420.dtsi
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/exynos5422-cpus.dtsi
4. Reproduced recently on next-20160212. First encountered on next-20160211.

Any ideas?

Best regards,
Krzysztof
