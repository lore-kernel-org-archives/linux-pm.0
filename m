From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] cpuidle: kirkwood: Staticize local symbol
Date: Fri, 09 Aug 2013 16:11:34 +0900
Message-ID: <000601ce94cf$ae4f0b40$0aed21c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18598 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030401Ab3HIHLf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 03:11:35 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR90026I5BALNB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 09 Aug 2013 16:11:34 +0900 (KST)
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>
Cc: 'Daniel Lezcano' <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, 'Silviu-Mihai Popescu' <silviupopescu1990@gmail.com>, Jingoo Han <jg1.han@samsung.com>

This local symbol is used only in this file.
Fix the following sparse warnings:

drivers/cpuidle/cpuidle-kirkwood.c:73:5: warning: symbol 'kirkwood_cpuidle_remove' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/cpuidle/cpuidle-kirkwood.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 521b0a7..3ca3a2e 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -70,7 +70,7 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
 	return cpuidle_register(&kirkwood_idle_driver, NULL);
 }
 
-int kirkwood_cpuidle_remove(struct platform_device *pdev)
+static int kirkwood_cpuidle_remove(struct platform_device *pdev)
 {
 	cpuidle_unregister(&kirkwood_idle_driver);
 	return 0;
-- 
1.7.10.4


