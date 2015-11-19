From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/6] PM / devfreq: Clean code and add set the freq_table array
Date: Thu, 19 Nov 2015 17:17:44 +0900
Message-ID: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch-set clean the code for both devfreq and devfreq-event framework
and add the 'freq_table' for devfreq device. After initializing the
'freq_table', the 'trans_stat' sysfs provide the appropriate information.

Chanwoo Choi (6):
  PM / devfreq: event: Remove the error log of devfreq_event_get_edev_by_phandle()
  PM / devfreq: event: Fix the error and warning from script/checkpatch.pl
  PM / devfreq: Add show_one macro to delete the duplicate code
  PM / devfreq: Set the freq_table of devfreq device
  PM / devfreq: Modify the indentation of trans_stat sysfs for readability
  PM / devfreq: Set the min_freq and max_freq of devfreq device

 drivers/devfreq/devfreq-event.c | 16 +++-----
 drivers/devfreq/devfreq.c       | 81 ++++++++++++++++++++++++++++++++---------
 include/linux/devfreq.h         |  4 +-
 3 files changed, 71 insertions(+), 30 deletions(-)

-- 
1.9.1
