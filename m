From: dirk.brandewie@gmail.com
Subject: [PATCH 02/11] cpufreq: intel_pstate: Remove unnecessary type casting in div_s64() call
Date: Fri, 18 Jul 2014 08:37:18 -0700
Message-ID: <1405697848-13546-3-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57645 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422799AbaGRPhm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:42 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3766254pdj.40
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:41 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

div_s64() accepts the divisor parameter as s32. Helper div_fp()
also accepts divisor as int32_t.

So, remove the unnecessary int64_t type casting.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 601c428..e5fd780 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -50,7 +50,7 @@ static inline int32_t mul_fp(int32_t x, int32_t y)
 
 static inline int32_t div_fp(int32_t x, int32_t y)
 {
-	return div_s64((int64_t)x << FRAC_BITS, (int64_t)y);
+	return div_s64((int64_t)x << FRAC_BITS, y);
 }
 
 struct sample {
-- 
1.9.3

