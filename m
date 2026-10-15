Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B64C6531;
	Thu, 15 Oct 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052276; cv=none; b=r+UTcPCGsGJaRNf0nRCachWRCDqRKLUhM3UhsdAgPXdRTIn88qF2bx5RRRpQ07co/RC47NhjEV4TNv+aQtFL+1cSrKEWKE/01YQod/o0RLu3b1DPySgo/xHL6obHs41b6opAl3NwHBLoRb96RZQxpFZWZH8LT6xIX8HHOvODY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052276; c=relaxed/simple;
	bh=RKCtN1wXI2cvgrqNsXUwB6m/9sTuEtwUbZ0OanR6nZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGA50ILCBwEOc1aMA7Whuo120Q8s90EivqdU5XCBw8To/bKx1QnW5OmCL9G3cwCozdh3RHr+8LQyqMdzhcFR1yhD+X0c53TMqg+KjDOJyj3IOoT9Cv9MjI3eg4HnDz0Wz7PfH/4BbW1N5lUnQk2NHOueXVDwAyYCS0NPb1nTTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d/azfDLx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d/azfDLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yV
	uQanL4K+S38cQaMBb2N0Tzj0/cdnYmNCO8ZHjJ8s4=; b=d/azfDLxHItVaUtVk5
	uQB5jCqS501sX/c6pcuPbpOZ/1egRswKgdwATL799G1A2hl+8Z/mJlu4LGgE2lPR
	p3Q1t553hyyixMxYEVorbWaZkuCUsw5DOvYKn+WnGbLGdkQRzOaIfIlVCIF1my4t
	WxqC1R1JveUsaa66lMgrKwPKg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P74EjNBqLkvpAA--.28339S2;
	Thu, 15 Oct 2026 16:17:09 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongxin Yang <yangyongxin@kylinos.cn>
Subject: [PATCH v4] PM: hibernate: Log the hibernation mode on entry
Date: Thu, 15 Oct 2026 16:16:44 +0800
Message-Id: <20261015081644.1353321-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013023411.1364546-1-yangyongxin@kylinos.cn>
References: <20261013023411.1364546-1-yangyongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P74EjNBqLkvpAA--.28339S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrykKFyrXF43WF43WF4fGrg_yoW5XF18p3
	97Xrs3ta4DA3W2vayrJrW5JF93Z392ga13JFnFgrZrArnrta90yr40qF1IyryYk3s7Wa1F
	gF1Dt34UJF43WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC-wXykGrQjAVZJQAA3X

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

The name comes from hibernation_modes[], the same table that
/sys/power/disk uses, looked up directly by mode index.

No functional change.

Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
 kernel/power/hibernate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..2bbfd7ffafe5 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -72,6 +72,16 @@ enum {
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
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
 bool freezer_test_done;
@@ -794,7 +804,8 @@ int hibernate(void)
 		goto Unlock;
 	}
 
-	pr_info("hibernation entry\n");
+	pr_info("hibernation entry (%s)\n",
+		hibernation_modes[hibernation_mode]);
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
@@ -1130,17 +1141,6 @@ static int __init software_resume_initcall(void)
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

