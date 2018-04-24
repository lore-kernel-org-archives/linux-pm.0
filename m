From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 0/6] Misc devfreq_add_device() fixes
Date: Tue, 24 Apr 2018 15:35:15 -0700
Message-ID: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The first 5 patches corrects error handling, reoder things and stop holding the
devfreq mutex in devfreq_add_device(). The last patch validates that a client
doesn't attempt to provide a freq_table, as the implementation relies on the
freq_table being an internal representation of the associated device's opp
table.

Bjorn Andersson (6):
  PM / devfreq: Free devfreq upon set_freq_table error
  PM / devfreq: Use the device release function for cleanup
  PM / devfreq: Reorder devfreq_add_device()
  PM / devfreq: Remove unnecessary locking
  PM / devfreq: Use put_device() on device_register error
  PM / devfreq: Reject client provided freq_table

 drivers/devfreq/devfreq.c | 73 ++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

-- 
2.16.2
