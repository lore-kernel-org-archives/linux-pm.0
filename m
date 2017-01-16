From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 0/4] PM / devfreq: Update the devfreq and devfreq-event
 device
Date: Mon, 16 Jan 2017 21:26:03 +0900
Message-ID: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170116122609epcas5p34b6109202b5bc05f13325318d0f2dbe3@epcas5p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patches update the devfreq and devfreq-event device. I add the summary
of each patch as following.
- Patch1 fixes the wrong description of governor_userspace.c.
- Patch2 show the information of registered PPMU devices.
- Patch3/4 modify the name of sysfs entry for devfreq/devfreq-event device

Changes from v2:
(https://lkml.org/lkml/2016/12/28/102)
- On v2 patchset, patch1/2/3/5 were merged on devfreq git repo.
- Remain the warning message for exynos-ppmu.c when failed to get the clock of ppmu
- Rebase these patches on devfreq git repo[1].

Changes from v1:
- Rebase these patches on v4.10-rc1.
- Include the separate patch[2] in these patches.

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch: for-4.10-rc)
[2] https://lkml.org/lkml/2016/12/16/7
- [PATCH] PM / devfreq: Fix the wrong description for userspace governor

Chanwoo Choi (4):
  PM / devfreq: Fix the wrong description for userspace governor
  PM / devfreq: exynos-ppmu: Show the registred device for ppmu device
  PM / devfreq: Simplify the sysfs name of devfreq-event device
  PM / devfreq: Modify the device name as devfreq[X] for sysfs

 drivers/devfreq/devfreq-event.c      | 2 +-
 drivers/devfreq/devfreq.c            | 4 +++-
 drivers/devfreq/event/exynos-ppmu.c  | 3 +++
 drivers/devfreq/governor_userspace.c | 3 +--
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.9.1
