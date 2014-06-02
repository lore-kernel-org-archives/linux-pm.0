From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/3] regulator: return -EINVAL from regulator_set_voltage() for !CONFIG_REGULATOR
Date: Mon,  2 Jun 2014 12:59:23 +0530
Message-ID: <788accde56086078d69d3eba0d913114315de43a.1401693980.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:49501 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaFBH3k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 03:29:40 -0400
Received: by mail-qa0-f51.google.com with SMTP id w8so2219082qac.10
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2014 00:29:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, edubezval@gmail.com, pavel@ucw.cz, lgirdwood@gmail.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Currently regulator_set_voltage() returns zero when support for regulators isn't
present in kernel, i.e. CONFIG_REGULATOR=n.

Make it return -EINVAL to propagate error instead of success here.
Audit of all users of this routine is done to make sure nothing breaks due to
this change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2: - New patch as suggested by Mark.

 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 1a4a8c1..28fa089 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -394,7 +394,7 @@ static inline void regulator_bulk_free(int num_consumers,
 static inline int regulator_set_voltage(struct regulator *regulator,
 					int min_uV, int max_uV)
 {
-	return 0;
+	return -EINVAL;
 }
 
 static inline int regulator_get_voltage(struct regulator *regulator)
-- 
2.0.0.rc2

