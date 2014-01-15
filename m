From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date: Wed, 15 Jan 2014 13:55:36 +0000
Message-ID: <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:38412 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbaAOOBh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jan 2014 09:01:37 -0500
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

Declaring this allows drivers which need to initialise each struct
cpuidle_device at initialisation time to make use of the structures
already defined in cpuidle.c, rather than having to wastefully define
their own.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 include/linux/cpuidle.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 50fcbb0..bab4f33 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -84,6 +84,7 @@ struct cpuidle_device {
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
 /**
  * cpuidle_get_last_residency - retrieves the last state's residency time
-- 
1.8.4.2


