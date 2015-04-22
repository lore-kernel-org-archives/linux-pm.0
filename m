From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250 platform
Date: Wed, 22 Apr 2015 16:40:37 -0700
Message-ID: <7hegnb91fu.fsf@deeprootsystems.com>
References: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
	<5439319.JYC6t7bzy4@amdc1032> <7hsibtavuz.fsf@deeprootsystems.com>
	<4008289.pQOxzKW0Ir@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36487 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706AbbDVXkl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 19:40:41 -0400
Received: by pdea3 with SMTP id a3so1827815pde.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 16:40:41 -0700 (PDT)
In-Reply-To: <4008289.pQOxzKW0Ir@amdc1032> (Bartlomiej Zolnierkiewicz's
	message of "Wed, 22 Apr 2015 19:37:43 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

[...]

>> However, with the default governor set to userspace it boots fine until
>> my userspace (ubuntu) tries to enable the ondemand governor, and then it
>> hangs. 
>> 
>> For it to boot, I have to disable the ondemand governor, and set the
>> default governor to userspace.
>
> I've tried with ARM big.LITTLE cpuidle support enabled (I've just noticed
> that it is not turned on in exynos_defconfig) and my ODROID-XU3 board
> fails to boot.  This happens even with cpufreq support disabled (hard
> lockup happens during mmc initialization which is done just after cpufreq
> initialization).

Right, the XU3 has broken secure firmware such that MCPM cannot properly
control CCI, so CPUidle will hang when trying to hit low power states,
so you have to disable CCI by adding something like this to the end of
your XU3 .dts file:

&cci {
     status = "disabled";
};

> Could you please check if disabling cpuidle support helps?

For now, I've disabled CPUidle so we have a similar setup, but it
doesn't change anything on exynos5800-peach-pi

>> As I reported earlier on Thomas' series, I suspect this is related to
>> the fact that the higher OPPs aren't really functional without voltage
>> scaling also supported. 
>
> Part #4 contains voltage scaling support for arm_big_little[_dt] driver
> so this should not be a problem any longer.
>
> You may try next-20150330-generic-cpufreq-exynos5420-5800-v2-debug
> branch from my github (with cpufreq debugging printks enabled) to check
> whether the voltage scaling is indeed done on your board.
>
>> I'm also seeing the wait_until_divider_stable errors when switching
>> between the available A7 OPPs.  I'd reported this one earlier as well,
>> along with the script to reproduce it.
>
> I've tried your script and it works fine for me (I only needed to change
> cpu4 to cpu0 as on ODROID-XU3 CPUs 0,5,6,7 are A7 and 1,2,3,4 are A15).

Then it seems something isn't quite right for exynos5800-peach-pi.
Below is the script[1] I'm using on exynos which also checks the voltage
by quering the regulator fwk (and optionally checking the INA2xx sensors
on odroid-xu3 if that support is enabled)

On your debug branch, it just gives -1 for all the voltages, so the
regulator voltage never changes:

# ./dvfs
CPU regulator: cpu0, vdd_arm, /sys/class/regulator/regulator.18
[   45.691483] arm_big_little: bL_cpufreq_set_rate: cpu: 0, old cluster: 0, new cluster: 0, freq: 200000
[   45.699581] arm_big_little: bL_cpufreq_set_rate_cluster: cpu 0, cluster: 0, 400 MHz, -1 mV --> 200 MHz, -1 mV
current freq: 200000 
current voltage: 1262500
[   46.969821] arm_big_little: bL_cpufreq_set_rate: cpu: 0, old cluster: 0, new cluster: 0, freq: 300000
[   46.978272] arm_big_little: bL_cpufreq_set_rate_cluster: cpu 0, cluster: 0, 200 MHz, -1 mV --> 300 MHz, -1 mV
current freq: 300000
current voltage: 1262500

I added a bit more debug to the cpufreq driver[1] and found that the
regulator_get_optional is failing:

[    3.407295] cpu cpu0: Unable to get regulator cpu-cluster.0
[    3.458282] cpu cpu4: Unable to get regulator cpu-cluster.1


Kevin


[1]
#!/bin/sh

if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ]; then
  echo "CPUfreq not enabled in kernel."
  exit 1
fi

# NOTE: odroid-xu3: CPU0 = A7.0, CPU1 = A15.0
cpu=cpu0
reg_name=vdd_arm
hwmon=hwmon0
#cpu=cpu4
#reg_name=vdd_kfc
#hwmon=hwmon3

cpu_reg=$(dirname `find /sys/class/regulator/regulator.*/ -name name -exec grep -l $reg_name {} \;`)
echo CPU regulator: $cpu, $reg_name, $cpu_reg

# Cycle through frequencies (and check voltage)
cd /sys/devices/system/cpu/$cpu/cpufreq
echo userspace > scaling_governor
for freq in `cat scaling_available_frequencies`; do
  echo ${freq} > scaling_setspeed
  sleep 0.2

  echo -n "current freq: "
  cat scaling_cur_freq
  echo -n "current voltage: "
  cat ${cpu_reg}/microvolts

  # odroid-xu3 INA231 monitors
  if [ ! -z $hwmon ]; then
    if [ -e /sys/class/hwmon/$hwmon/in1_input ]; then
      echo -n "current voltage (ina2xx)":
      cat /sys/class/hwmon/$hwmon/in1_input
    fi
  fi

  sleep 1
done

[2]
diff --git a/drivers/cpufreq/arm_big_little.c
b/drivers/cpufreq/arm_big_little.c
index 024f185b2154..4108f909cc9c 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -16,6 +16,7 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  */
+#define DEBUG

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

@@ -446,6 +447,8 @@ static int _get_cluster_clk_and_freq_table(struct
device *cpu_dev)
                ret = regulator_set_voltage_time(reg[cluster], min_uV,
                max_uV);
                if (ret > 0)
                        transition_latencies[cluster] = ret * 1000;
+       } else {
+               dev_warn(cpu_dev, "Unable to get regulator %s", name);
        }

        ret = dev_pm_opp_init_cpufreq_table(cpu_dev,
        &freq_table[cluster]);
