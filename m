From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250 platform
Date: Fri, 24 Apr 2015 00:02:11 +0530
Message-ID: <CANAwSgR0nZVADsdD5sRXdfqRdJ6_bF_yOM4yNvNKvXf31dhwcg@mail.gmail.com>
References: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
 <5439319.JYC6t7bzy4@amdc1032> <7hsibtavuz.fsf@deeprootsystems.com> <4008289.pQOxzKW0Ir@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38837 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbDWScd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 14:32:33 -0400
In-Reply-To: <4008289.pQOxzKW0Ir@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kevin Hilman <khilman@kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

Hi Bartlomiej/Kevin,

I have being testing github branch on OdroidXU3 board,

Would you consider testing by applying patch.

https://lkml.org/lkml/2015/1/30/423

On my board it stuck after booting. Below is the console log.

 * CPUFreq Utilities: Setting ondemand CPUFreq governor...
  [ OK ]  * CPU7...
[   14.245169] wait_until_divider_stable: timeout in divider stablization
 * Starting CPU Frequency daemon cpufreqd                                [ OK ]
[   14.385179] wait_until_divider_stable: timeout in divider stablization
[   14.400162] wait_until_divider_stable: timeout in divider stablization
[   14.470180] wait_until_divider_stable: timeout in divider stablization
[   14.525157] wait_until_divider_stable: timeout in divider stablization
[   14.665200] wait_until_divider_stable: timeout in divider stablization
 * Starting NTP server ntpd                                              [ OK ]
saned disabled; edit /etc/default/saned
root@odroidxu3:~# [   14.945183] wait_until_divider_stable: timeout in
divider stablization
[   14.960159] wait_until_divider_stable: timeout in divider stablization
[   15.085154] wait_until_divider_stable: timeout in divider stablization
[   15.105170] wait_until_divider_stable: timeout in divider stablization
[   15.125180] wait_until_divider_stable: timeout in divider stablization
[   15.365147] wait_until_divider_stable: timeout in divider stablization
[   15.505163] wait_until_divider_stable: timeout in divider stablization
[   15.520167] wait_until_divider_stable: timeout in divider stablization
[   15.930146] wait_until_divider_stable: timeout in divider stablization
[   17.765953] BUG: scheduling while atomic: kswitcher_7/1456/0x00000002

root@odroidxu3:~#
root@odroidxu3:~# [   23.625134] wait_until_divider_stable: timeout in
divider stablization
[   23.640137] wait_until_divider_stable: timeout in divider stablization

root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~#
root@odroidxu3:~# [   26.215135] wait_until_divider_stable: timeout in
divider stablization
[   26.230135] wait_until_divider_stable: timeout in divider stablization
[   26.237850] BUG: scheduling while atomic: kswitcher_7/1456/0x00000002
[   26.243196] Preemption disabled at:[<  (null)>]   (null)

root@odroidxu3:~#
root@odroidxu3:~# [   26.282330] BUG: scheduling while atomic:
kswitcher_7/1456/0x00000002
[   26.287501] Preemption disabled at:[<  (null)>]   (null)
[   26.293244] BUG: scheduling while atomic: kswitcher_7/1456/0x00000002
[   26.299170] Preemption disabled at:[<  (null)>]   (null)

root@odroidxu3:~# [   27.660264] Unable to handle kernel paging
request at virtual address ac22254f
[   27.660633] Unable to handle kernel paging request at virtual
address 76688788

-Anand Moon


On 22 April 2015 at 23:07, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> On Tuesday, April 21, 2015 04:45:56 PM Kevin Hilman wrote:
>> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
>>
>> > On Monday, April 20, 2015 02:07:33 PM Kevin Hilman wrote:
>> >> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
>> >>
>> >> > Hi,
>> >> >
>> >> > This patch series removes the use of Exynos5250 specific support
>> >> > from exynos-cpufreq driver and enables the use of cpufreq-dt driver
>> >> > for this platform.  The exynos-cpufreq driver itself is also removed
>> >> > as it is no longer used/needed after Exynos5250 support removal.
>> >> >
>> >> > This patch series has been tested on Exynos5250 based Arndale board.
>> >> >
>> >> > Depends on:
>> >> > - next-20150330 branch of linux-next kernel tree
>> >> > - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
>> >> >   platform" [1]
>> >> > - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
>> >> >   platform" [2]
>> >> > - "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]
>> >>
>> >> Any chance you could prepare a branch with all the dependencies for easy
>> >> testing?
>> >
>> > All cpufreq changes with needed dependencies are now availble in
>> >
>> >     https://github.com/bzolnier/linux.git
>> >
>> > repository and the branch is
>> >
>> >     next-20150330-generic-cpufreq-exynos5420-5800-v2
>>
>> Great, thanks.
>>
>> >> Also, The previous version from Thomas was v12, and this one is neither
>> >> versioned nor has any reference to what may have changed since that
>> >
>> > Please note that Thomas' patchset was split on separate parts (this is
>> > part #3) and heavily modified so the previous versioning was dropped.
>> >
>> > The cover letter of part #1 ("[PATCH 0/6] cpufreq: use generic cpufreq
>> > drivers for Exynos4210 platform") contains detailed changelog on what has
>> > been changed since Thomas' original v12 patch series.  Individual Thomas'
>> > patches which were modified by me also contain such information.
>> >
>> > Part #2 ("[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
>> > platform") was entirely new code when compared to Thomas' v12 patchset so
>> > its cover letter doesn't contain such detailed changelog as part #1.
>> >
>> > The newly posted part #4 ("[PATCH 0/8] cpufreq: add generic cpufreq driver
>> > support for Exynos5250/5800 platforms" https://lkml.org/lkml/2015/4/21/314)
>> > also contains the detailed changelog.
>> >
>> > However for part #3 (this one, "[PATCH 0/4] cpufreq: use generic cpufreq
>> > drivers for Exynos5250 platform") such summary changelog got missed for
>> > some reason.  Here it is:
>> > - split Exynos5250 support from the original patch
>> > - moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c
>> > - added CPU regulator supply property for Google Spring board
>> > - removed exynos-cpufreq driver entirely as it is no longer used/needed
>>
>> Great, thanks for clarifying.
>>
>> >> version.  Also, on v12, I had several comments[1] and wonder if they've
>> >> been addressed.
>> >
>> > All issues previously reported should have been fixed.  If you still see
>> > some problems please let me know.
>> >
>> > [ I see now that exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
>> >   exynos5420-smdk5420.dts and exynos5800-peach-pi.dts should also have
>> >   been updated to contain CPU cluster regulator supply properties or else
>> >   if the default vdd_arm/vdd_kfc regulator state is set to too low value
>> >   there may be problems with stability when switching to higher than
>> >   default frequencies.  I have posted v2 version of patch #2/8 of part #4
>> >   and pushed v2 combined branch on github.  Sorry for the inconvenience. ]
>>
>> I've now tested your v2 branch with the bL switcher disabled, CPUidle
>> enabled and CPUfreq enabled.
>>
>> With the default governor set to performance, it fails to boot.  The last
>> kernel messages on the console are:
>
> [ Small explanation for people not following the discussion from
>   the start:
>
>   This testing is relevant to part #4 of the rework: "[PATCH 0/8]
>   cpufreq: add generic cpufreq driver support for Exynos5250/5800
>   platforms" (https://lkml.org/lkml/2015/4/21/314"), not this one
>   which is part #3 and has no known issues. ]
>
>> [...]
>> [    3.426021] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
>> [    3.431189] cpu cpu4: bL_cpufreq_init: CPU 4 initialized
>>
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
>
> Could you please check if disabling cpuidle support helps?
>
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
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
