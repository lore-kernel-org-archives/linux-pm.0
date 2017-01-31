From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/3] PM / devfreq: Fix issues about passive governor
Date: Tue, 31 Jan 2017 15:38:15 +0900
Message-ID: <1485844699-24582-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170131063825epcas1p41a0d68066744675d0ef7b5bf527a469b@epcas1p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40072 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdAaGjS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 01:39:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patchset fix the two issues about passive governor
and remove the unneeded separate _remove_devfreq() function.

First, the parent devfreq device can use the governors except for
the passive governor on the fly through sysfs entry and the passive
devfreq device is only possible to use the passive governor.

The 'available_governors' entry doesn't distinguish this difference
between parent devfreq and passive devfreq device. So, the patch1
fixes the this issue.

Second, the devfreq updates the statistic of frequency for each
device. But, 'trans_stat' of the passive devfreq device doesn't
update the statistic. So, the patch2 fixes this issue by calling
the update_devfreqw_passive() after setting the frequency
of passive devfreq device.

Finally, the patch3 removes the separate _remove_devfreq()
because this function is only called once in devfreq_dev_release().
I think that it is not necessary to make the separate function.

Changes from v1:
(https://lkml.org/lkml/2017/1/18/52)
- Add acked-by tag of devfreq maintainer to patch2/3.
- Remove the is_passive_gov() function because it is not appropriate
  to handle the specific governor name in the devfreq core. Instead,
  add the new 'immutable' flag to struct devfreq_governor.

Depends on:
- These patches based on the devfreq.git[1].
[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch: for-4.10-rc)

For example,
- The v1[2] series includes the detailed example about 'available_governors'
  and 'trans_stat' sysfs entry. We can refer to it.
[2] https://lkml.org/lkml/2017/1/18/52

Chanwoo Choi (3):
  PM / devfreq: Fix available_governor sysfs
  PM / devfreq: Fix wrong trans_stat of passive devfreq device
  PM / devfreq: Remove unnecessary separate _remove_devfreq()

 drivers/devfreq/devfreq.c          | 57 ++++++++++++++++++++++++--------------
 drivers/devfreq/governor.h         |  2 ++
 drivers/devfreq/governor_passive.c |  6 ++++
 include/linux/devfreq.h            |  3 ++
 4 files changed, 47 insertions(+), 21 deletions(-)

-- 
1.9.1

