Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48525B083;
	Thu,  3 Sep 2026 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401762; cv=none; b=PIEZtQuheGFm2ptVKCA+sPw94uTdwQlpw99kKvt9cba/s3HNovMlriSOs+j5bjLldtbhvvtd9Fd9ymJ1KZglE5JqFSuYWEFK4sNICWGru4fhExpnFGcXVGDjyKxsWdKxzK4AahWznpTHTcja1fn5iNVmQOmYkuxN6pwDsVKlaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401762; c=relaxed/simple;
	bh=vnu+7OTVyrfngxBgjEV+wbBsUgwuLr2CGX38vK2EnYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/pWG9Cwt4/kRQJaBNcf8q8MSbXb5eAlcO+FPauRARIDICRg1V1r++D6Lrb3mVSXFQypoQxCoYqc+DrSdXWLPK5xd/Gjq90davhFJCFuFajgjMPNN44Cx8m2r1mV2H9CDE47VDVHLt23jhHGojJ7WLYaBiTR3LPxC4lxG03QOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Mfbm8y+d; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Mfbm8y+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788401722;
	bh=TDmE22prZiWyICupTJBxOHtt4OkSMDD7JlVtXA21HRM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Mfbm8y+dpqDPaV3yADYCDFllKIcl9c2Kiu8QPbafPiO7Pi4jjC9VjKvQbQ1hiuTQt
	 xQ+BEIyxPJ0Pmf5FCTLYlL5i9daIyOXEx+Mue2EajjoCy84BoGqYiNQ4/fNDSUxUMx
	 PytMRsS7Usp/pADc9BB9h+Zistvog2frGUv7/3Qw=
X-QQ-mid: esmtpgz16t1788401716t09e2fba8
X-QQ-Originating-IP: HWN1kVLmaxC5DhOLmv1XOyn9IGplrGoyhXFMvCPmKtw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 10:15:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11223455846511623105
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: rafael@kernel.org,
	laurent.pinchart@ideasonboard.com
Cc: tuhaowen@uniontech.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	huangbibo@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu
Subject: [PATCH v5 2/4] PM: hibernate: add pm_hibernation_snapshot_done() helper
Date: Thu,  3 Sep 2026 10:14:57 +0800
Message-Id: <0a72acf8defd73508bfc5d2fb7c985521696630f.1788399733.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1788399733.git.tuhaowen@uniontech.com>
References: <20260730153817.GA1555869@killaraus.ideasonboard.com> <cover.1788399733.git.tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NPoj0uw5JpnxDHD51MeC6irDPVpmKERcIEEDN3NIJghEMh0JOh5GbyCs
	ZPV3sblXDh6lOE5yPrIefhn8solUGA2Gom00RbbLcP43yatSIVTDz+AwNiepEnHTFkqzjB0
	1SJT37rQtvMAgSqOFoOVqCLe6GBRQBM971ZrJ0XvkISrmR7GqIa3dQleRrVBuIFlgQ2bHa3
	nV+14Zin1Mmdb3I5/ViaB7yYtSXPyE9CkxH531ciOPP+iMENDIXDiGMHTZNM43pPXIYUgP/
	HHNPp7VwyH+rzYN/8o99FBMEYFJPpIgUU0UiiVArnnyXuvDvMeThoG+8xktsdWW1fKAQuez
	Lm59hjXZ+jR1QMqYERv9CX3OcJrLpNahPvk1Tx+jzhaUd/5Vy/C6v1+FZ7v63XFr+j6gWCR
	OpiJG5FLp0YCg1fA5C1ya95R42uUFF6B0Yl+HE2j+shUkn1ywvO6N6Cx+oQG7H6n6QB9rRn
	Y36O/YF2jAqXFP8SuEzP2mxFHKyjIEfsEdNpM4OTKb0FfGabhhH5CFFwlV5nrklY8OY04kp
	1kub4bS0VhkDO5I4QxpUcieym5xrmulIlj1p7ra09Zq0i1EUI+qXWPtOH2jCe2J4bw64gRb
	xTJ5y7y9VXbifBEHcAyApYgiioSAhz47TLjFJ1+PpgN/NMdyBe3fZ3iRjQHafAooz8KNxLH
	YlyXEXP439hagqbkyCZxU7V2s2HmUt3Q6ub0uaCrA0D+8D6frpt02fzP7O/YNXUiF5VkMlK
	KTeqrO07lppHb6ueULT6TaNSaJJKkxyi9eUuHjSBvrI1e4n4pguUXgUi6GFvAQ8AHcOxt0e
	3Tu0dIQVal3pyax9l7wyaHMSMiLMM+f3NwyqQSypwgbhjt9DhEO/H1xcsOrRG69rBYdQLpO
	LpEyXgPoQtPiO9kYc2KnNCZ77hhuJYspgHkherKzu43QpU6E2KHmJBPKn0mC7t7BZhnYLYZ
	/VJ+brvAD7uNc4ZSP00cWHMBo+j/M8I9+dtde4rQ9PrGmPCRZcL78gQvn0c55H5GHJ3/K+S
	8kbkUR5JQlGNOyz9bahCbAYtrzaieZFa2D3DCDFjDhwcN9MVZwuBg0fAHtGwHZmSmaMlXkS
	rR3d7Iy3xcwyaDWv0YMrR0=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
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
