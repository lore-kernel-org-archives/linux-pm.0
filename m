From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 0/2] PM / devfreq: Change the device name on sysfs entry
Date: Tue, 31 Jan 2017 16:47:55 +0900
Message-ID: <1485848877-19184-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170131074759epcas1p3415cd6ed09ce4c7b60e1e4018b4ce720@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55743 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdAaH6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 02:58:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

These patches change the name of sysfs entry for devfreq/devfreq-event device
as following:
- old
For devfreq, /sys/class/devfreq/[non-standard device name]
For devfreq-event, /sys/class/devfreq-event/event.(X)

- new
For devfreq, /sys/class/devfreq/devfreq(X)
For devfreq-event, /sys/class/devfreq-event/event(X)

Changes from v4:
- Applied the patch1/2 on v4 series.
- Add new ABI document for devfreq-event class.

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

Depends on:
- These patches are based on patch[1].
[1] https://lkml.org/lkml/2017/1/31/120

Chanwoo Choi (2):
  PM / devfreq: Simplify the sysfs name of devfreq-event device
  PM / devfreq: Modify the device name as devfreq(X) for sysfs

 .../ABI/testing/sysfs-class-devfreq-event          | 25 ++++++++++++++++++++++
 drivers/devfreq/devfreq-event.c                    |  4 ++--
 drivers/devfreq/devfreq.c                          |  4 +++-
 3 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-devfreq-event

-- 
1.9.1

