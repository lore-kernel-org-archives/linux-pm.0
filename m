From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/6] PM / devfreq: Modify devfreq/devfreq-event for improvement
Date: Thu, 24 Nov 2016 14:01:02 +0900
Message-ID: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34693 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbcKXFBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 00:01:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patches modify the devfreq and devfreq-event framework for improving
them. But, these patches don't make an impact to operation of
devfreq/devfreq-event.

Chanwoo Choi (6):
  PM / devfreq: Fix the checkpatch warnings
  PM / devfreq: Modify the device name as devfreq[X] for sysfs
  PM / devfreq: event: Simplify the sysfs name of devfreq-event device
  PM / devfreq: Remove the duplicate sysfs entry for current frequency
  PM / devfreq: event: exynos-ppmu: Use the regmap interface to handle the registers
  PM / devfreq: event: exynos-ppmu: Add the completion log of device registration

 drivers/devfreq/devfreq-event.c     |   2 +-
 drivers/devfreq/devfreq.c           |  25 ++-
 drivers/devfreq/event/exynos-ppmu.c | 329 ++++++++++++++++++++++++++----------
 3 files changed, 251 insertions(+), 105 deletions(-)

-- 
1.9.1

