Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957A3BFE4F;
	Wed, 29 Jul 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309122; cv=none; b=g+OydhYcLxpEnXhawp6slSjeD/rWQhicwpupxkXDn/Lr3ioyaU0s/p6g+mtN/zTr/fs4CMdoVTQV3n2jJltzpgKIc0326SdiFLcxcYJaMaH4do4B8iz1OoNeHzBoP70NGU/XfgaZaaDzOvVTGmi5Yrts9E7fDz1e0qCvub0CphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309122; c=relaxed/simple;
	bh=AOBiTM10JHwNfkKAx0h0IIvMX6WxTXO2sDpbEzSHcAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3qo5LwnDD23YTFjHOsmey24JzcoILy4N4xTe3HUGrXmNiaEjoCw8IgiKEv6qsBGmkcS+Xl4Qo/An3CSkM5FZi1LMorFPMrp2Bic9p3Zy5rWbVi4hMBROt8+QiR/F0mcOCfUi2CvcBWj7XJ98hO+iYPoOieXfPlpZYx9MtCvB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Oa6xF27L; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Oa6xF27L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785309111;
	bh=O1YTKr8Y/rFna83YYS7U0F7BOEJLK+gg/3NGb/or4kA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Oa6xF27Lck4rPRi7Lmv/514TTFzz8VlvKWD4I10Jsk/YNy4+OA22Npt1a7SY4+4tt
	 3bPN+vUxwLtbgI3Zx0EOUHS7VBZLZ140FAr0kFLrehsPF7q8CQB1nX2jLbKQGKjLX7
	 ciHUIOOhMTS03zzAg5PYHWjTpflM0+rLsxBBGXU8=
X-QQ-mid: zesmtpgz6t1785309099t2b687191
X-QQ-Originating-IP: WjPQ/f7R7tCBToYIB7rUAtsVlZiqBzG/yOe+5Kgv67c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jul 2026 15:11:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17671344946874709150
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: laurent.pinchart@ideasonboard.com,
	rafael@kernel.org
Cc: gregkh@linuxfoundation.org,
	hansg@kernel.org,
	kernel@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu,
	tuhaowen@uniontech.com
Subject: [PATCH v4 2/4] PM: hibernate: add pm_hibernation_snapshot_done() helper
Date: Wed, 29 Jul 2026 15:11:21 +0800
Message-Id: <ac2ab0e03a93ef9b92b556d09cbcec58dcb73c87.1785226280.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1785226280.git.tuhaowen@uniontech.com>
References: <20260723084633.GE648629@killaraus.ideasonboard.com> <cover.1785226280.git.tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NZY6XYMwxuFE1sQDuHrBZxqiKntr09ZNADAqqtZx4dNptpJvZc5XVbDQ
	KgmBPidINJ0dz05scVJ64FkLMZTMaTdtOZXwxkfummMF5LvF7KLppE/8mBRnaoGNlvuvm91
	E6hwP2krTPTBMyCA9cksf0wbEPqmCl7PtmdxoaOpLRhE3G/vlbRW2w+QAE+1y+OUhHk5OG9
	QzRMv35Uyyy0XpDeJliCTLApGeExHid8TgJ0qmR2dLFj24WAEico5LitVs5kinQ4EeIfJer
	J3zxXP8i/JyP1dk2QQAuhjgLQiRxPcNCiiXaBpNEppnzxKdj+G/9iXi0pBTG792d+qgrXEU
	LQcLk4STXOeHMRxxAG9ceJDkZZB6qGh+rotgHS8XcFq/P2WWgsG2s1QQ74F4ryjD8mlXxhP
	UZ+MIb9xMTcT+FLD02MXbPnaikboHfMWA/w75hChnn9L8xJ1tqIokkO/yf0aBfv/itwiGA/
	y/fV32hW9+1Fsfa2Ktc3DH/xF9gP/YDZMo6xQrw5+vhF9118NyO98z2WdO2nbOda5NhT1nk
	uQNIzu4rWdm/w4cMNK5Y0P5uExVDZPhHXD2jbm7jWSjqDT9X6HplPuZrlRjO9YnVSh3xZPI
	QryfxhpZlKCapPL7qBOkdeuLiBPT8N1pYjOA58fPeGHQYHT5e3VAHLAiYDBydGEEEaxaVKH
	MFueYOtQdod5A10KMR04xZxgd7rURqe37/UM07vC5g8FlgXTTJYhU8ZnjFyQnazYMT87CPP
	9AkLUPIPgO2F4nuvTDM5T1m5OfoOhMH5aPvR5231RpWOL0JAUbmgZx5bNwJD0Nu2NpOFfuh
	MAUNpihuQZqzFk8nFySFqA9/yW6Ankf9gRtBHhONt2rsug5+QaPAzjHStAoGXq2bkGPdYl4
	VSqHzG5USkT/XCKACpB/bKWuIlec5WQ4lc3aBpq2C37bhsL1JBpVCZlNwHdQnrY96pCRTyF
	n0L/PbJLu9PCCgAMl57NXkjBwoVnEBMUFQnjK1GEcwxSwO0GlEzmwtXNp+mLoDm3ATCah/A
	tzfRc+GQ3GzpTHIzFZCfoXCaWrfYycFpc+i8pyKU8f21vMeGwHfxYSErcHeeQ3RgrBepByz
	yMSXToqJO+qEsSX2Qmwf9s=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Some subsystem resume callbacks do not receive the PM event and
therefore cannot distinguish the PMSG_THAW phase after snapshot creation
from the PMSG_RESTORE phase.

Export pm_hibernation_snapshot_done() so a driver can query whether the
hibernation snapshot has been created and is still available.  The helper
only exposes the PM state; callers remain responsible for ensuring that
any device-specific behavior is safe, including subsequent poweroff or
shutdown handling.

The helper returns !!in_suspend.  This variable is set before
swsusp_arch_suspend(), cleared before the snapshot memory is released,
and marked __nosavedata, so it remains clear on the restore path.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..2cebbec3e2f7 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -393,6 +393,7 @@ extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
+bool pm_hibernation_snapshot_done(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
@@ -412,6 +413,7 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+static inline bool pm_hibernation_snapshot_done(void) { return false; }
 
 static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 	return -ENOTSUPP;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 6d3e637c5a02..045d29f55011 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -113,6 +113,18 @@ bool hibernation_available(void)
 		!secretmem_active() && !cxl_mem_active();
 }
 
+/**
+ * pm_hibernation_snapshot_done - check if a hibernation snapshot is available
+ *
+ * Return: %true if a hibernation snapshot has been taken and has not been
+ *         released yet.
+ */
+bool pm_hibernation_snapshot_done(void)
+{
+	return !!in_suspend;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_snapshot_done);
+
 /**
  * hibernation_set_ops - Set the global hibernate operations.
  * @ops: Hibernation operations to use in subsequent hibernation transitions.
-- 
2.20.1
