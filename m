Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913C35E1C0
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880393; cv=none; b=AMAg5s6OGC92vlb8rwXHXjMPbLXq/7jRjj07JJHmvrmEAkdEmyFZaZjx6Ef0nW7oynYRs3J6G94Z79MfUbJHGzv9Gs+85Alxf3dKyB+TrJf+wmAtqOmkfTMnwC6h3i3RMBunNYoPFJ/ZeFKW8p6HYwLYFVqo/gooIkCANHWZZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880393; c=relaxed/simple;
	bh=Hw5+Q73+ZWi9YmoMS+ZX9S0GXOSKMnNzUKiQEKe40vw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rDYHandWR6QgY3CcRFRrkhxRbfX+xc9y1lHrh1uzREolexZ/ovtnP/lP7SlDLUf3W1n3Gkzzyhan+BwwrhyM+YBIDOdDInZx3/babNs9Dv38mlTfVqSnywpYFPPYe6kkxTSeC108kOMDdx4QPNI+BlIqdDEzXoNrG83p4wYOuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e3a7e3a873611f1aa26b74ffac11d73-20260724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bbcb072c-3fb2-4077-a284-1c0044953157,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:30d74f645cd7322d1f00739a6d0a8e4e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e3a7e3a873611f1aa26b74ffac11d73-20260724
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1727008886; Fri, 24 Jul 2026 16:06:20 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] doc: power: update swsusp.txt references to swsusp.rst
Date: Fri, 24 Jul 2026 16:06:10 +0800
Message-Id: <20260724080610.3487628-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The swsusp.txt documentation file has been renamed to swsusp.rst.
Update the references in the Documentation/power/userland-swsusp.rst
comments to use the correct filename.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 Documentation/power/userland-swsusp.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 1cf62d80a9ca..b00b850148b2 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -4,9 +4,9 @@ Documentation for userland software suspend interface
 
 	(C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
 
-First, the warnings at the beginning of swsusp.txt still apply.
+First, the warnings at the beginning of swsusp.rst still apply.
 
-Second, you should read the FAQ in swsusp.txt _now_ if you have not
+Second, you should read the FAQ in swsusp.rst _now_ if you have not
 done it already.
 
 Now, to use the userland interface for software suspend you need special
-- 
2.25.1

