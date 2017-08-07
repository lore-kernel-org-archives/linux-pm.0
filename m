From: Santosh Mardi <gsantosh@codeaurora.org>
Subject: [PATCH] devfreq: add error check for sscanf in userspace governor
Date: Mon,  7 Aug 2017 18:36:44 +0530
Message-ID: <1502111205-22560-1-git-send-email-gsantosh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gsantosh@qti.qualcomm.com, gsantosh@codeaurora.org, skannan@quicinc.com, rgottimu@qti.qualcomm.com
List-Id: linux-pm@vger.kernel.org

What this patch does:

	Current implementation of store_freq function in devfreq
	userspace governor executes further, even if error is returned
	from sscanf. This will result in setting up wrong frequency value.

	This patch adds proper error check to bail out if
	any error is returned.

Santosh Mardi (1):
  devfreq: add error check for sscanf in userspace governor

 drivers/devfreq/governor_userspace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1
