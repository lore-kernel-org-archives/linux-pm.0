From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 00/12] PM / devfreq: Use OPP interface to handle the
 frequency
Date: Thu, 24 Aug 2017 10:42:47 +0900
Message-ID: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170824014259epcas2p4d92e5c404f54b629e7bdfb6a2c5ed0ed@epcas2p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12287 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdHXBnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

These patches makes the devfreq to use the OPP interface as a mandatory
and fix the bug, clean-up codes.
- patch 1/2 fix the bug.
- patch 3 refactors the private code.
- patch 4~12 are related to the OPP interfaces 

The commit a76caf55e5b3 ("thermal: Add devfreq cooling") provides
the devfreq cooling device by using the OPP interface such as
dev_pm_opp_disable() and dev_pm_opp_enable(). It means that
the OPP interface is able to change the available status of the frequency.

Firstly, the existing devfreq doesn't use the OPP interface when showing
the minimum and maximum frequency through the following sysfs nodes:
It shows the wrong frequency value because min_freq/max_freq don't
consider the frequency status by handling OPP interface. So, these
patches fix this issue.
- /sys/class/devfreq/devfreq.X/min_freq
- /sys/class/devfreq/devfreq.X/max_freq

Second, the 'available_frequencies' should show the all supported frequencis
even if the specific frequency is not available. It doesn't matter whether
frequneyc is available or not. Because the role of 'available_frequencies'
shows the all frequencies. Also, these patches fix this issue.
- /sys/class/devfreq/devfreq.X/available_frequencies

Lastly, the devfreq uses the OPP interface as a mandatory method
and so the devfreq has to support the OPP notifier in order to
catch the OPP events. So, patch12 adds the new opp_notifier_cb()
function pointer in the struct devfreq_dev_profile. The user can
add the their own callback function to receive the OPP events.

Also, the devfreq provides the default OPP notifeir callback
in order to remake the frequency table when OPP events happen.
- default_opp_notifier_cb()

Chanwoo Choi (12):
  PM / devfreq: Fix memory leak when fail to register device
  PM / devfreq: Fix locking range for making the frequency table
  PM / devfreq: Move private devfreq_update_stats() into devfreq
  PM / devfreq: Add dependency on PM_OPP
  PM / devfreq: Set min/max_freq when adding the devfreq device
  PM / devfreq: Check the entered min/max_freq is supported or not
  Revert "PM / devfreq: Add show_one macro to delete the duplicate code"
  PM / devfreq: Show the available min/max frequency through sysfs node
  PM / devfreq: Show whole available frequencies
  PM / devfreq: Remove 'devfreq' prefix from helper function
  PM / devfreq: Remove exported opp_notifier function
  PM / devfreq: Add opp_notifier_cb() function pointer to support OPP
    notifier

 drivers/devfreq/Kconfig      |   1 +
 drivers/devfreq/devfreq.c    | 286 +++++++++++++++++++++++++------------------
 drivers/devfreq/exynos-bus.c |   7 --
 drivers/devfreq/governor.h   |   4 +
 drivers/devfreq/rk3399_dmc.c |   1 -
 include/linux/devfreq.h      |  56 ++-------
 6 files changed, 181 insertions(+), 174 deletions(-)

-- 
1.9.1
