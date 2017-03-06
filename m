From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Use thermal fuse value for thermal zone
 0 on Exynos5420
Date: Mon, 6 Mar 2017 12:59:06 +0530
Message-ID: <CANAwSgR9kstsMXAoDxLzW_nrLFo1esggDdHO9uqfmqCJ5--AJQ@mail.gmail.com>
References: <20170211201456.27974-1-krzk@kernel.org> <252f9e32-ff2c-a1ce-3c98-6383a1148e02@osg.samsung.com>
 <20170304080109.j2kuwmqj7mgfx3ky@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33890 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdCFH32 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2017 02:29:28 -0500
In-Reply-To: <20170304080109.j2kuwmqj7mgfx3ky@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Willy WOLFF <willy.mh.wolff@gmail.com>

Hi Krzysztof,

On 4 March 2017 at 13:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Mar 03, 2017 at 06:50:06PM -0300, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 02/11/2017 05:14 PM, Krzysztof Kozlowski wrote:
>> > In Odroid XU3 Lite board, the temperature levels reported for thermal
>> > zone 0 were weird. In warm room:
>> >     /sys/class/thermal/thermal_zone0/temp:32000
>> >     /sys/class/thermal/thermal_zone1/temp:51000
>> >     /sys/class/thermal/thermal_zone2/temp:55000
>> >     /sys/class/thermal/thermal_zone3/temp:54000
>> >     /sys/class/thermal/thermal_zone4/temp:51000
>> >
>> > Sometimes after booting the value was even equal to ambient temperature
>> > which is highly unlikely to be a real temperature of sensor in SoC.
>> >
>> > The thermal sensor's calibration (trimming) is based on fused values.
>> > In case of the board above, the fused values are: 35, 52, 43, 58 and 43
>> > (corresponding to each TMU device).  However driver defined a minimum value
>> > for fused data as 40 and for smaller values it was using a hard-coded 55
>> > instead.  This lead to mapping data from sensor to wrong temperatures
>> > for thermal zone 0.
>> >
>> > Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
>> > do not impose any limits on fused values.  Since we do not have any
>> > knowledge about these limits, use 0 as a minimum accepted fused value.
>> > This should essentially allow accepting any reasonable fused value thus
>> > behaving like vendor driver.
>> >
>> > The exynos5420-tmu-sensor-conf.dtsi is copied directly from existing
>> > exynso4412 with one change - the samsung,tmu_min_efuse_value.
>> >
>> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >
>> > ---
>> >
>> > Testing on other Exynos542x boards is much appreciated. Especially I
>> > wonder what efuse values are there.
>>
>> I tested on both Exynos5422 Odroid XU4 and Exynos5800 Peach Pi boards.
>>
>> The temperatures levels reported for these two boards on a warm room are:
>>
>> Odroid XU4
>>
>> # cat /sys/class/thermal/thermal_zone*/temp
>> 50000
>> 50000
>> 54000
>> 51000
>> 48000
>>
>> Peach Pi
>>
>> # cat /sys/class/thermal/thermal_zone*/temp
>> 42000
>> 44000
>> 27000 <-- weird value for thermal zone 2 like zone 0 in your XU3 lite
>> 45000
>> 45000
>>
>> And the efuse values for the TMU devices are:
>>
>> Odroid XU4
>>
>> TMU0 = 45
>> TMU1 = 44
>> TMU2 = 44
>> TMU3 = 46
>> TMU3 = 46
>>
>> Peach Pi
>>
>> TMU0 = 44
>> TMU1 = 46
>> TMU2 = 36
>> TMU3 = 53
>> TMU3 = 46
>>
>> The fused value for TMU2 is < 40 so that explains the weird temperature
>> level for thermal zone 2 in Peach. So after your patch, makes more sense:
>>
>> # cat /sys/class/thermal/thermal_zone*/temp
>> 41000
>> 42000
>> 45000
>> 43000
>> 43000
>
> Great! Thanks for testing!
>
>
>> I wonder though if 0 is the best value or if we should just lower more
>> to cover the used e-fuse values in Exynos5 boards. But as you said,
>> we have no knowledge about these limits...
>
> Yeah... we could set value of 10 or 20... but that would be blind shot.
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>
> Thanks,
> Krzysztof

Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

I have being trying to change the trips temperature in the dts to some
higher values
in order to improve the performance of the board.
Here are the results under idle state and stress state.

root@odroidxu4n:~# cat /sys/class/thermal/thermal_zone*/temp
58000
58000
61000
60000
56000
root@odroidxu4n:~# stress --vm 16 --vm-bytes 128M --timeout 10s
stress: info: [2138] dispatching hogs: 0 cpu, 0 io, 16 vm, 0 hdd
stress: info: [2138] successful run completed in 10s
root@odroidxu4n:~# cat /sys/class/thermal/thermal_zone*/temp
58000
58000
61000
60000
56000

Which is too high for in idle state.

Second part of my testcase is the pm-qa from linaro.

[1] git://git.linaro.org/tools/pm-qa.git

pm-qa# make -C thermal check

I have observer in the testcase that their is use moderate heating of heat_cpu
get started by the testcase but it dose not get signal to kill on
exiting of the testcase.
most of these testcase failed to Odroid XU4, but the same case pass on
Odroid U3.

I have also tested with different e-fuse values [10,20,30,40] but the
results are same.

Going through the source code for HK it seen to set exynos_tmu_control
set more trigger level

[2] https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/drivers/thermal/exynos_thermal.c#L1144

Best Regards
-Anand Moon
