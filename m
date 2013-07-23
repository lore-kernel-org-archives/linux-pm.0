From: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: [PATCH 2/2] cpuidle: export cpuidle_idle_call symbol
Date: Tue, 23 Jul 2013 17:28:01 +0800
Message-ID: <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:5261 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756012Ab3GWKTh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2013 06:19:37 -0400
In-Reply-To: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Wang Dongsheng <dongsheng.wang@freescale.com>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Export cpuidle_idle_call symbol, make this function can be invoked
in the module.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
Branch: pm-cpuidle

 drivers/cpuidle/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 534320a..d0a61d6 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -168,6 +168,7 @@ int cpuidle_idle_call(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cpuidle_idle_call);
 
 /**
  * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
-- 
1.8.0


