From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/1] kernel-power: Deletion of an unnecessary check before
 the function call "vfree"
Date: Sun, 16 Nov 2014 14:28:23 +0100
Message-ID: <5468A677.1030004@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:54938 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148AbaKPN2g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 16 Nov 2014 08:28:36 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 16 Nov 2014 14:18:28 +0100

The vfree() function performs also input parameter validation. Thus the test
around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index aaa3261..337c7a9 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1374,7 +1374,7 @@ out_clean:
 				kthread_stop(data[thr].thr);
 		vfree(data);
 	}
-	if (page) vfree(page);
+	vfree(page);
 
 	return ret;
 }
-- 
2.1.3


