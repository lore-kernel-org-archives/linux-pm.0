Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A33290AA;
	Fri, 24 Apr 2026 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014758; cv=none; b=i7aTNvZ6wB4tDLFTfJ5u8pA/mm+d7v5GHWt8SymBJFaJulbRWZE3Bz9oHrRS1Qs70jAH6vp46r7dDNY/JzTSmftMm5qWDsb8MQ11pNT8aA5QzAzBF57SHwkafD8Z0FMVMQPcVrdG9dMSZpOBHHOIROjzgTv0tXVXcnvPG7OfAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014758; c=relaxed/simple;
	bh=ZTEIVhTuDqgIOT6cb5vgfcfT1omDHu17haDclS6sAvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEoxutbdhfuf0ceErqQsmiiYB1zCa5BW9ZtRvUryQS4jzKGiR5ZfIq0r7rSO+HX4Bij4VyYGf7JcilhdVMtyYKzhM0L37dIZSgO2F/0FUA3LTLPH/H5fH4q76q16sjMdvZcq4ZYOr8ZGy1Oh/AYJ0hGO46cdxbBMfblg95uWp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kVOvPJpc; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kVOvPJpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WJ
	mt2m1fxEpPdUIlZD31RR3XnRoJ5NOtO7F/JMDNteY=; b=kVOvPJpcFiGOOuoUp2
	o0DyFJtZCU5U4waUqKlr61Aa9IgpI7yruNdZUOrySe4AryQfV3HjAuOF4/1bp7jK
	HODwC2mZgyGkWy1e11fn67Wdg2+GwdRfqMj9iCbDikMUh65PvfIF+4GgN5WVGYiG
	4OTKPPFrR8DDbO5gfeEj51v6s=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAH66jKF+tp4CrsBA--.214S2;
	Fri, 24 Apr 2026 15:12:13 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] PM: tools: fix ValueError when parsing incomplete device properties
Date: Fri, 24 Apr 2026 15:12:08 +0800
Message-Id: <20260424071208.3610628-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAH66jKF+tp4CrsBA--.214S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45GrW7Cw1kCw1fKr43trb_yoW8CrWxp3
	y5CFWvyw1UGFn3Ga1vvF4rCanruw4xAws8JF1IqryUtFZ8XrnF9ryxKw1UKrnFvrW2y3s2
	v3sxA3y3GFW29r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE9aPUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC-g1OCWnrF83+SwAA3Z

From: Gongwei Li <ligongwei@kylinos.cn>

When parsing device properties from ftrace data, the devprops() function
assumes that each line has at least three fields and that the third field
(f[2]) always contains a valid integer. However, due to incomplete or
corrupted ftrace logs, f[2] may be missing, empty, or non-existent.

This can lead to the following error:

    Traceback (most recent call last):
      File "../sleepgraph.py", line 7142, in <module>
        stamp = rerunTest(sysvals.outdir)
      File "../sleepgraph.py", line 6255, in rerunTest
        testruns, stamp = processData()
      File "../sleepgraph.py", line 6181, in processData
        testruns, error = parseTraceLog(live)
      File "../sleepgraph.py", line 3470, in parseTraceLog
        tp, tf = loadTraceLog()
      File "../sleepgraph.py", line 3398, in loadTraceLog
        if tp.stampInfo(line, sysvals):
      File "../sleepgraph.py", line 3073, in stampInfo
        self.parsePlatformInfo(line, sv)
      File "../sleepgraph.py", line 3177, in parsePlatformInfo
        sv.devprops = self.devprops(sv.b64unzip(info))
      File "../sleepgraph.py", line 3158, in devprops
        if int(f[2]):
    ValueError: invalid literal for int() with base 10: ''

To prevent this crash, add proper validation before accessing.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 tools/power/pm-graph/sleepgraph.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 1555b51a7d55..f6d172254829 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -3155,7 +3155,7 @@ class TestProps:
 			dev = f[0]
 			props[dev] = DevProps()
 			props[dev].altname = f[1]
-			if int(f[2]):
+			if len(f) > 2 and f[2] and int(f[2]):
 				props[dev].isasync = True
 			else:
 				props[dev].isasync = False
-- 
2.25.1

