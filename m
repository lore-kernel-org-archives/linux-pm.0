From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] selftest: cpufreq: Update MAINTAINERS file
Date: Fri, 20 Jan 2017 11:10:33 +0530
Message-ID: <ce0bdaab50468d22a46cce3cb04efbb21f467cb6.1484890757.git.viresh.kumar@linaro.org>
References: <c3cd3310-7a12-134e-3c5a-c5fcacc6821d@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36265 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdATFkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2017 00:40:41 -0500
Received: by mail-pg0-f53.google.com with SMTP id t6so20562810pgt.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2017 21:40:41 -0800 (PST)
In-Reply-To: <c3cd3310-7a12-134e-3c5a-c5fcacc6821d@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, shuah@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Update MAINTAINERS file with cpufreq's selftest directory.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi shuah,

Can you please add this one as well along with the code? Thanks.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c36976d3bd1a..bf414a1a5f82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3381,6 +3381,7 @@ B:	https://bugzilla.kernel.org
 F:	Documentation/cpu-freq/
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
+F:	tools/testing/selftests/cpufreq/
 
 CPU FREQUENCY DRIVERS - ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
-- 
2.7.1.410.g6faf27b

