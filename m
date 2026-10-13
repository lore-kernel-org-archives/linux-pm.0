Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367A46F498;
	Tue, 13 Oct 2026 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858912; cv=none; b=ji7l72I1OJAVteKCzhgg3HhrDw9EeKwuyEJZxnjfMhdasCoEosgM8mkcPn+4NignrEUM46pQ3YTYiT+yomE1gxMyihbJYJ8VAtaQn6NU7/X53zrNFIC0xv7v41KlTCcYnPgolTf7AMGfIidKsHI9A07nv3e1ZpQaPPKpB+o96tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858912; c=relaxed/simple;
	bh=nafdYhU7fWuCi+MOVEmBRrLHRFeOatrvaUTrzGZqYQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auGDi5K31Hp8txM/lQKtDl1PXrwC1g3Slz+9wJ7Qy0CSDidrzJAGAS1Du6raoATaFKwfS8rXknDZWg3ie5muy9Y+dcCgBJdM+298sQZa7ifWfGN1Kgx5yGGfUHpvkzrqETM+fKrboNfiXp3DNIVRcR5YnCQxHBazmz51YQ8Psng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nt/pxmZ6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nt/pxmZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bj
	E+YENk2DsOPlIyvDBf8opJWirpZtAYTX81+jkkRl0=; b=Nt/pxmZ6vfsyogrbpY
	WVfA9poWeOdoQ7lgURVGpRhUYprre65ZbG7ktbrEh/FXUlDtvCf3Hs3mAJf5rN7i
	QSob80qy6TZc2hpWVsFmWnoxdhgrjbmlP0B2y5JTZfMYKbu2hE/vEnmh+qZf+EI+
	tx1/7IovXlEGUjVfE6M4U1aws=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnz4O5mM1qXGwUEQ--.65500S2;
	Tue, 13 Oct 2026 10:34:34 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongxin Yang <yangyongxin@kylinos.cn>
Subject: [PATCH v3] PM: hibernate: Log the hibernation mode on entry
Date: Tue, 13 Oct 2026 10:34:11 +0800
Message-Id: <20261013023411.1364546-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012041733.798932-1-yangyongxin@kylinos.cn>
References: <20261012041733.798932-1-yangyongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnz4O5mM1qXGwUEQ--.65500S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrykKFyrXF43WF43WF4fGrg_yoW5AFy5pr
	Z7Wrs3t3ZrZF12va4rJrW5JF93Z392ga13JFnFgrZrArnrtas0yw40gF1IyryFk3s7Wa1Y
	gF4qyryUJF47GF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC5BpiAGrNmLoPQgAA3U

The hibernation flow is the only place where the kernel decides what
to do after a successful image write: hand over to the platform
firmware (ACPI S4), power the system off, reboot it, or resume from
the image right away. That decision leaves no trace in the log. If the
resume path later fails or hangs, the tester cannot tell which outcome
was requested, so a report of "the system rebooted instead of powering
off" cannot be attributed to configuration or to platform behavior.

The mode is selected through /sys/power/disk and stored in
hibernation_mode. Append its name to the existing "hibernation entry"
message, so that the line reads "hibernation entry (platform)",
"hibernation entry (shutdown)", "hibernation entry (reboot)",
"hibernation entry (suspend)" or "hibernation entry (test_resume)"
instead of a bare "hibernation entry".

The names come from hibernation_modes[], the same table that
/sys/power/disk uses, through a new hibernation_mode_name() helper, so
that the mapping from mode to name lives in one place.

No functional change.

Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
 kernel/power/hibernate.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..6f88b42b1af8 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -72,6 +72,24 @@ enum {
 #define HIBERNATION_MAX (__HIBERNATION_AFTER_LAST-1)
 #define HIBERNATION_FIRST (HIBERNATION_INVALID + 1)
 
+static const char * const hibernation_modes[] = {
+	[HIBERNATION_PLATFORM]	= "platform",
+	[HIBERNATION_SHUTDOWN]	= "shutdown",
+	[HIBERNATION_REBOOT]	= "reboot",
+#ifdef CONFIG_SUSPEND
+	[HIBERNATION_SUSPEND]	= "suspend",
+#endif
+	[HIBERNATION_TEST_RESUME]	= "test_resume",
+};
+
+static const char *hibernation_mode_name(int mode)
+{
+	if (mode < HIBERNATION_FIRST || mode > HIBERNATION_MAX)
+		return "unknown";
+
+	return hibernation_modes[mode];
+}
+
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
 bool freezer_test_done;
@@ -794,7 +812,8 @@ int hibernate(void)
 		goto Unlock;
 	}
 
-	pr_info("hibernation entry\n");
+	pr_info("hibernation entry (%s)\n",
+		hibernation_mode_name(hibernation_mode));
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
@@ -1130,17 +1149,6 @@ static int __init software_resume_initcall(void)
 }
 late_initcall_sync(software_resume_initcall);
 
-
-static const char * const hibernation_modes[] = {
-	[HIBERNATION_PLATFORM]	= "platform",
-	[HIBERNATION_SHUTDOWN]	= "shutdown",
-	[HIBERNATION_REBOOT]	= "reboot",
-#ifdef CONFIG_SUSPEND
-	[HIBERNATION_SUSPEND]	= "suspend",
-#endif
-	[HIBERNATION_TEST_RESUME]	= "test_resume",
-};
-
 /*
  * /sys/power/disk - Control hibernation mode.
  *
-- 
2.25.1

