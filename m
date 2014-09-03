From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Wed, 3 Sep 2014 15:20:24 +0530
Message-ID: <CAKohpo=Pb88SBg0HwrAtzfRkG5Z9HgsapSmA1PbmqqvP-wQ1qw@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
	<9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
	<d9f1dbc51c9d408ea593d11a95a36ee4@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:60140 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaICJuZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 05:50:25 -0400
Received: by mail-oi0-f52.google.com with SMTP id e131so5367575oig.11
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 02:50:24 -0700 (PDT)
In-Reply-To: <d9f1dbc51c9d408ea593d11a95a36ee4@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

On 3 September 2014 13:32, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> Test confirmed what I am concerned. Patch 1 is working but patch 2 didn't working in hotplug case.
> (tested on t4240 platform with 3 cluster and 8 cpus in each cluster, kernel version is 3.12).

:(

> Log is as follows:
> root@t4240rdb:~# cd /sys/devices/system/
> root@t4240rdb:/sys/devices/system# ls
> clockevents  clocksource  cpu  edac
> root@t4240rdb:/sys/devices/system# cd cpu/
> root@t4240rdb:/sys/devices/system/cpu# ls
> cpu0  cpu1  cpu10  cpu11  cpu12  cpu13  cpu14  cpu15  cpu16  cpu17  cpu18  cpu19  cpu2  cpu20  cpu21  cpu22  cpu23  cpu3  cpu4cpu5  cpu6  cpu7  cpu8  cpu9  kernel_max  offline  online  possible  present  probe  release  uevent
> root@t4240rdb:/sys/devices/system/cpu# cat cpu8/
> altivec_idle            altivec_idle_wait_time  cache/                  cpufreq/                online                  physical_id             pir                     pw20_state              pw20_wait_time          smt_snooze_delay        subsystem/              topology/               uevent
> root@t4240rdb:/sys/devices/system/cpu# cat cpu8/cpufreq/affected_cpus
> 8 9 10 11 12 13 14 15
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu8/online
> Cannot set affinity for irq 467
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu9/online
> root@t4240rdb:/sys/devices/system/cpu# cat cpu10/cpufreq/affected_cpus
> 10 11 12 13 14 15
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu10/online
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu11/online
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu12/online
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu13/online
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu14/online
> root@t4240rdb:/sys/devices/system/cpu# echo 0 > cpu15/online
> root@t4240rdb:/sys/devices/system/cpu# echo 1 > cpu9/online
> smp_85xx_kick_cpu: Can not start CPU #9. Start CPU #8 first.
> smp: failed starting cpu 9 (rc -2)
> -sh: echo: write error: No such file or directory

I don't understand how is this related to my patch? And the successful sequence
below has CPU14 here instead of 8.. So this error might come without my
patch as well if this sequence is followed..

> root@t4240rdb:/sys/devices/system/cpu# echo 1 > cpu10/online
> root@t4240rdb:/sys/devices/system/cpu# cat cpu10/cpufreq/affected_cpus
> 10
> root@t4240rdb:/sys/devices/system/cpu# echo 1 > cpu11/online
> sysfs: cannot create duplicate filename '/devices/system/cpu/cpu10/cpufreq'
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:526

I think I know why this happened.

Does cpu_core_mask() gives mask of ONLY Online CPUs ? I *strongly* believe
YES looking at above crash.

If we can change that with some other routine which gives mask of all
(online+offline)
CPUs then this crash might go away..

Because of that, I believe there is another problem in your driver even without
my patch. Do this to get similar crash:

- build driver as module and don't load it by default
- boot your system
- offline CPUs 8 to 15 as you did above.
- insert module
- try to online cores as you did above.

--
viresh
