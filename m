From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/3] PM / devfreq: Fix issues about passive governor
Date: Wed, 18 Jan 2017 15:56:48 +0900
Message-ID: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170118065653epcas5p23158122f1f54c7419bc010527174b48e@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patchset fix the two issues about passive governor
and remove the unneeded separate _remove_devfreq() function.

First, the parent devfreq device can use the governors except for
the passive governor on the fly through sysfs entry and the passive
devfreq device is only possible to use the passive governor.

The 'available_governors' entry doesn't divide this difference
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


Depends on:
- These patches depends on the devfreq.git[1] and devfreq patches[2].
[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch: for-4.10-rc)
[2] https://lkml.org/lkml/2017/1/16/254
- ("[PATCH v3 0/4] PM / devfreq: Update the devfreq and devfreq-event device")


For example,
Following exmaple is the bus frequency device
of INT (Internal) block on Exynos5433-based TM2 board.

1. There are differences about 'available_governors' sysfs entry.
- Parent devfreq device (soc\:bus0)
- Passive devfreq device (soc\:bus1) depends on the parent devfreq (soc\:bus0).

1-1. Before applying these patches:
- parent devfreq device
$ cat /sys/class/devfreq/soc\:bus0/available_governors
passive userspace powersave performance simple_ondemand

- passive devfreq device
$ cat /sys/class/devfreq/soc\:bus1/available_governors
passive userspace powersave performance simple_ondemand

1-2. After applying these patches:
- parent devfreq device
$ cat /sys/class/devfreq/soc\:bus0/available_governors
userspace powersave performance simple_ondemand

- passive devfreq device
$ cat /sys/class/devfreq/soc\:bus1/available_governors
passive


2. There are differences about 'trans_stat' sysfs entry.
- Parent devfreq device (soc\:bus0)
- Passive devfreq device (soc\:bus3) depends on the parent devfreq (soc\:bus0).

2-1. Before applying these patches:
- parent devfreq device
$ cat /sys/class/devfreq/soc\:bus0/trans_stat
     From  :   To
           : 100000000 134000000 160000000 200000000 267000000 400000000   time(ms)
  100000000:         0         0         1         0         0         0     80664
  134000000:         0         0         0         0         1         0      7552
  160000000:         0         1         0         0         0         0      8136
  200000000:         0         0         0         0         0         0         0
  267000000:         0         0         0         0         0         1     23208
* 400000000:         0         0         0         0         0         0   1188144
Total transition : 4

- passive devfreq device
$ cat /sys/class/devfreq/soc\:bus3/trans_stat
     From  :   To
           : 100000000 134000000 160000000 200000000 267000000 400000000   time(ms)
  100000000:         0         0         0         0         0         0         0
  134000000:         0         0         0         0         0         0         0
  160000000:         0         0         0         0         0         0         0
  200000000:         0         0         0         0         0         0         0
  267000000:         0         0         0         0         0         0         0
* 400000000:         0         0         0         0         0         0   1317400
Total transition : 0


2-2. After applying these patches:
- parent devfreq device
$ cat /sys/class/devfreq/soc\:bus0/trans_stat
     From  :   To
           : 100000000 134000000 160000000 200000000 267000000 400000000   time(ms)
  100000000:         0         1         0         0         0         0    110372
  134000000:         0         0         1         0         0         0      6180
  160000000:         0         0         0         1         0         0      3748
  200000000:         0         0         0         0         1         0      2992
  267000000:         0         0         0         0         0         1      4648
* 400000000:         0         0         0         0         0         0      1636
Total transition : 5

- passive devfreq device
$ cat /sys/class/devfreq/soc\:bus3/trans_stat
     From  :   To
           : 100000000 134000000 160000000 200000000 267000000 400000000   time(ms)
  100000000:         0         1         0         0         0         0    110372
  134000000:         0         0         1         0         0         0      6180
  160000000:         0         0         0         1         0         0      3748
  200000000:         0         0         0         0         1         0      2992
  267000000:         0         0         0         0         0         1      4648
* 400000000:         0         0         0         0         0         0     14500
Total transition : 5

Chanwoo Choi (3):
  PM / devfreq: Fix available_governor sysfs
  PM / devfreq: Fix wrong trans_stat of passive devfreq device
  PM / devfreq: Remove unnecessary separate _remove_devfreq()

 drivers/devfreq/devfreq.c          | 60 ++++++++++++++++++++++++++------------
 drivers/devfreq/governor.h         |  2 ++
 drivers/devfreq/governor_passive.c |  5 ++++
 3 files changed, 49 insertions(+), 18 deletions(-)

-- 
1.9.1
