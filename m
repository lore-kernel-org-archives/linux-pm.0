From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/8] cpuidle: Add missing forward declaration
Date: Wed, 12 Jun 2013 15:08:52 +0200
Message-ID: <1371042535-22630-5-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34324 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3FLNJD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:09:03 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so456591wib.16
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:09:01 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

The forward declaration for the cpuidle_state_kobj and the cpuidle_driver_kobj
structures are missing. Let's add them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpuidle.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index b922db5..781addc 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -60,6 +60,8 @@ struct cpuidle_state {
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
 struct cpuidle_device_kobj;
+struct cpuidle_state_kobj;
+struct cpuidle_driver_kobj;
 
 struct cpuidle_device {
 	unsigned int		registered:1;
-- 
1.7.9.5

