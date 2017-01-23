From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 0/4] PM / devfreq: Update the devfreq and devfreq-event
 device
Date: Mon, 23 Jan 2017 12:31:35 +0900
Message-ID: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170123033151epcas5p3349612f1f97c31d85d90604cbca8a19d@epcas5p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42906 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdAWDbz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 22:31:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patches update the devfreq and devfreq-event device. I add the summary
of each patch as following.
- Patch1 fixes the wrong description of governor_userspace.c.
- Patch2 show the information of registered PPMU devices.
- Patch3/4 modify the name of sysfs entry for devfreq/devfreq-event device

Changes from v3:
(https://lkml.org/lkml/2017/1/16/254)
- Patch3 initializes the init value of 'event_no' in order to remove
  the unneeded operation (-1) when calling the atomic_inc_return(&event_no).
- Patch4 uses the integer type for unique number of devfreq device.

Changes from v2:
(https://lkml.org/lkml/2016/12/28/102)
- On v2 patchset, patch1/2/3/5 were merged on devfreq git repo.
- Remain the warning message for exynos-ppmu.c
  when failed to get the clock of ppmu.
- Rebase these patches on devfreq git repo[1].

Changes from v1:
- Rebase these patches on v4.10-rc1.
- Include the separate patch[2] in these patches.

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch:
for-4.10-rc)
[2] https://lkml.org/lkml/2016/12/16/7
- [PATCH] PM / devfreq: Fix the wrong description for userspace governor

Chanwoo Choi (4):
  PM / devfreq: Fix the wrong description for userspace governor
  PM / devfreq: exynos-ppmu: Show the registred device for ppmu device
  PM / devfreq: Simplify the sysfs name of devfreq-event device
  PM / devfreq: Modify the device name as devfreq[X] for sysfs

 drivers/devfreq/devfreq-event.c      | 4 ++--
 drivers/devfreq/devfreq.c            | 4 +++-
 drivers/devfreq/event/exynos-ppmu.c  | 3 +++
 drivers/devfreq/governor_userspace.c | 3 +--
 4 files changed, 9 insertions(+), 5 deletions(-)

-- 
1.9.1

