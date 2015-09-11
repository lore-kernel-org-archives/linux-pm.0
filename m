From: Xiaolong Ye <yexl@marvell.com>
Subject: [PATCH] fix incorrect initialization code for trans_stat of devfreq
Date: Fri, 11 Sep 2015 11:05:22 +0800
Message-ID: <1441940723-12360-1-git-send-email-yexl@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:2683 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270AbbIKDJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 23:09:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yizhang@marvell.com, kliu5@marvell.com
Cc: Xiaolong Ye <yexl@marvell.com>

Hi,

I met trans_stat abnormal issue while debugging devfreq feature for ddr in arm64 system, cat trans_stat 
would get extremely large time value which is unreasonable, I checked the code and found it was caused by
incorrect initialization code, time_in_state is initialized by devm_kzalloc and wrongly use sizeof(unsigned int)
as argument, but time_in_state which is defined in struct devfreq actually is defined as unsigned long, so
it is ok for 32 bit system, but will cause unexpected result in 64 bit system.

Xiaolong Ye (1):
  PM / devfreq: Fix incorrect type issue.

 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5

