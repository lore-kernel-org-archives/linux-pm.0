From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/3] PM / devfreq: Fix the bug and add reviewer for devfreq
 support
Date: Thu, 15 Dec 2016 18:30:35 +0900
Message-ID: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59150 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcLOJkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2016 04:40:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patches fix the bug of devfreq_add_device() when governor name is wrong
and the wrong return value of probe() function for exynos_bus.c driver.

And I've been helping reviewing and tesing the devfreq support patches
for the couple of years. Also, I'm going to contribute the improvement
for devfreq subsystem. It would be easier for me for review if I'm cc'ed
for patches. So, patch1 adds myself as a reviewer for devfreq support.

Chanwoo Choi (3):
  MAINTAINERS: Add myself as reviewer for DEVFREQ subsystem support
  PM / devfreq: Fix the bug of devfreq_add_device when governor is NULL
  PM / devfreq: exynos-bus: Fix the wrong return value

 MAINTAINERS                  |  1 +
 drivers/devfreq/devfreq.c    | 15 ++++++++++-----
 drivers/devfreq/exynos-bus.c |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
1.9.1

