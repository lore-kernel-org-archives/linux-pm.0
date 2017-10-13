From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 0/8] PM / devfreq: Use OPP interface to handle the
 frequency
Date: Fri, 13 Oct 2017 16:48:16 +0900
Message-ID: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20171013074831epcas2p28bc5c380fb339650234037e9cd24fe27@epcas2p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17543 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdJMHsd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 03:48:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

These patches makes the devfreq to use the OPP interface and clean-up codes.

[Detaild Descripion]
The commit a76caf55e5b3 ("thermal: Add devfreq cooling") provides
the devfreq cooling device by using the OPP interface such as
dev_pm_opp_disable() and dev_pm_opp_enable(). It means that
the OPP interface is able to change the available status of the frequency.

Firstly, the existing devfreq doesn't reflect the result of OPP behavior
when showing the min/max frequency through the following sysfs nodes:
It shows the wrong frequency value because min_freq/max_freq don't
consider the frequency status by handling OPP interface (opp_dev_pm_opp_
{disable|add}()). So, these patches fix this issue.
- /sys/class/devfreq/devfreqX/min_freq
- /sys/class/devfreq/devfreqX/max_freq

Second, the 'available_frequencies' should show the all supported frequencies
even if the specific frequency is not available. It doesn't matter whether
frequneyc is available or not. Because the role of 'available_frequencies'
shows the all frequencies. Also, these patches fix this issue.
- /sys/class/devfreq/devfreqX/available_frequencies

Third, update_devfreq() get the available next frequency by using
new 'scaling_min/max_frewq' variables in order to consider the disabled OPP.

For example,
- devfreq's min_freq is 100Mhz and max_freq is 700Mhz.
- OPP disabled 500/600/700Mhz due to devfreq-cooling.c.
- simple_ondemand govenor decided the next target_freq (600Mhz)
|----------|-------------------------------------------------------------|
|Freq(MHz) |100     |200    |300    |400     |500     |600      |70 0    |
|Devfreq   |min_freq|       |       |        |        |         |max_freq|
|OPP avail |enabled |enabled|enabled|enabled |Disabled| Disabled|Disabled|
|Ondmenad  |        |       |       |        |        |next_freq|        |
|------------------------------------------------------------------------|

In result,
- Before this patch, target_freq is 600Mhz
  and TRANSITION_NOTIFIER sends the next_freq is 600Mhz to the notifiee.
- After this patch, target_freq is 400Mhz because 500/600 were disabled by OPP.
  and TRANSITION_NOTIFIER sends the next_freq is 400Mhz to the notifiee.

Lastly,
- patch6/7 fix the minor issue and cleanup codes.
- patch8 register the cooling device. It depends on opp patch[1].
[1] https://patchwork.kernel.org/patch/9962387/


Changes from v3:
- Add the new 'scaling_min/max_freq' to 'struct devfreq'
  in order to reflect the OPP behavior such as dev_pm_opp_disable/enable().
- Drop the call of devfreq_recommended_opp() in the update_devfreq().
- Show the available frequencies in an ascending order.
- Check '#cooling-cells' property before registering cooling device on
  exynos-bus.c.
- Change the return type of devfreq_set_freq_table() and remvoe 'devfreq'
  prefix from function name.
- Add acked-by tag from Myungjoo Ham on patch1.

Changes from v2:
(https://lkml.org/lkml/2017/9/20/886)
- Fix the exynos-bus.c for the cooling device on patch8

Changes from v1:
(https://lkml.org/lkml/2017/8/23/785)
- Show the available frequencies as an ascending order
- Change the author info from cwchoi00@gmail.com to cw00.choi@samsung.com
- Drop the patches related to opp_notifier
- Add new patch5/6/7/8

Chanwoo Choi (8):
  PM / devfreq: Set min/max_freq when adding the devfreq device
  Revert "PM / devfreq: Add show_one macro to delete the duplicate code"
  PM / devfreq: Use the available min/max frequency
  PM / devfreq: Change return type of devfreq_set_freq_table()
  PM / devfreq: Show the all available frequencies
  PM / devfreq: Remove unneeded conditional statement
  PM / devfreq: Define the constant governor name
  PM / devfreq: exynos-bus: Register cooling device

 drivers/devfreq/devfreq.c                 | 135 +++++++++++++++++++++---------
 drivers/devfreq/exynos-bus.c              |  32 ++++++-
 drivers/devfreq/governor_passive.c        |   2 +-
 drivers/devfreq/governor_performance.c    |   2 +-
 drivers/devfreq/governor_powersave.c      |   2 +-
 drivers/devfreq/governor_simpleondemand.c |   2 +-
 drivers/devfreq/governor_userspace.c      |   2 +-
 drivers/devfreq/rk3399_dmc.c              |   2 +-
 include/linux/devfreq.h                   |  16 +++-
 9 files changed, 146 insertions(+), 49 deletions(-)

-- 
1.9.1
