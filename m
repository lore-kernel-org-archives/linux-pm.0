Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155702;
	b=zZsYdmFve0aUW+zZ2MrxhZxHP6cUMz9oRKVMU84/8fdYsgYCZfmcxnBo1XZ0Bxe/JDzB
	 UM5NbsQI3anT0VAT35icS8y17GOdM9Z0LIlkL/3mbVM5rfEV1IqO7h0f6C1Ak5YfNIKvj
	 RlHaxdtQhDfJqW4s5cWCNmiAXu5GQ0G0l72ivDPhQIU38VXtlTtlK52xxyCQAtdu/kdrn
	 3MsDqYCd9QnDUYjGChDZmf+CfMEYqpL875HcVZJe7YeJQj0736AFD8TQ7gzvTpFo9dtdD
	 L5o9IQtawotoeZyVXLaLdbZrI/YaBThDR0Z3MwWBR3rNKNTmsUrv5MaYG3aNGnC8R+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155702;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+GP/zeDv1zvvHWp5vTGwt+gLtDBXhM3z8JdD3KwXby8=;
	b=WR5Vsgh9rZGU9MokxFuqmMBBIVACGuHmHIztAE0cX0YTEaxDvX1F1vtKMYLrmC1y8m+f
	 xEFWDIc1LVjXC5a7cZIjaW7Yr43mcXEuv88PJ+0FBvKmvlPZDtSeqroGlY4ddFH2sFc1h
	 Dqu6K2FzBHWnDUIqMEFMZi5r4Dk0xNqGKnrwK4efO3syA1IInir1eHsNVx5RzyMzJSVjH
	 CoU2WesQi3k8zmUWf6j2IOIflwPCIGyYuI+/OkCWFYF3zoptLJ5XzBI9bXADaf0EKmpCX
	 OZFuENuVdO7uw/ih67JWeDCpBOG60gETHDJMnVC0t48HMZ+wiigh3a1T3otXWmJdlRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=U+QieZXh;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F6606A33D
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3F6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=U+QieZXh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=U+QieZXh5134+rXXeC2IjhpKRwAuXkAlkW/Basq0509d9gpXlLMn0ooNcN8QW41SFPPrs1ooWbAzc
	 bEGlyY7Y7KURB/wNzlfNwXbhLt7E7aEjloLRgs7U2PDRX+kK+KRbn/ORlhcOjJ5/H+e19n9xMvwdj5
	 qAq7WPJXo04US/To=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46affe6ed79d-c4d4c;
	Fri, 20 Nov 2026 14:21:35 +0800 (CST)
X-RM-TRANSID:2ee46affe6ed79d-c4d4c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86affe6ee2fc-80e21;
	Fri, 20 Nov 2026 14:21:35 +0800 (CST)
X-RM-TRANSID:2ee86affe6ee2fc-80e21
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: trenn@suse.com
Cc: shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] cpupower: Propagate errors from child powercap zones
Date: Fri, 20 Nov 2026 14:21:33 +0800
Message-ID: <20261120062134.98489-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powercap_walk_zones() returns a callback error for the current zone but
discards errors from recursive calls. A callback that fails on a child
zone therefore does not stop the walk and the caller receives success.

Propagate the recursive return value so callback errors have the same
meaning at every level of the hierarchy.

Fixes: c2294c1496b7 ("cpupower: Introduce powercap intel-rapl library and powercap-info command")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/power/cpupower/lib/powercap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e55ef..76ca392161e6 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -300,8 +300,11 @@ int powercap_walk_zones(struct powercap_zone *zone,
 		return ret;
 
 	for (i = 0; i < POWERCAP_MAX_CHILD_ZONES; i++) {
-		if (zone->children[i] != NULL)
-			powercap_walk_zones(zone->children[i], f);
+		if (zone->children[i]) {
+			ret = powercap_walk_zones(zone->children[i], f);
+			if (ret)
+				return ret;
+		}
 	}
 	return 0;
 }


