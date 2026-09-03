Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440D31D375;
	Thu,  3 Sep 2026 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401734; cv=none; b=gJH+eMkgmJiaW80mjzowtWyXcUDAF4CoYHH4SLuJwsgfHw73UtKJXeba5cqNBUs3IFm/5hH/6I8H53oYxb0t4xy5GjhIcr2XJspaS8Wt0cxA+zsxyqr05MZeohbBN1sqeJJ0iARfGc+I7lZK93wATf933yOVAuWPCYEBrNvU9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401734; c=relaxed/simple;
	bh=7uDxDA+9YGPfFObepLXMSaNMgViB4yTDUFprc9wOwvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQpqukUX1w007IqX8BImXSOYIwFQD8W9LNGK2wZiU2rSUSOYb3o7G1V+Po4fw9X2JwbDJv5kqFQw+qVWxITmu4fL5uS2UvUhWePFobM4Ib4/wQCKnfEagZNhKHxn0O4uOtxleOjV8gfSTjdhoK5AUCKZOUCDUmePvD4Se3qpeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ORWCSIhl; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ORWCSIhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788401718;
	bh=e1VUNUQlMg1MCx8hA5n24AtoXedvcMVZEK6NYKkfTKg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ORWCSIhla07GA7oppnADl/3g7RLe/w590zxolRcn9gSoxg9gMoWXJ4Yc5jg3csAQI
	 L06Xv+5kjeXWfd/7LRnLr6evAgQ5Lz93Er/tPffcMn6eACdsULt/UgwqvhUS7NuD1S
	 yVUih3xMhL7JCwgAHgeuJv0wy/4zF7cDxTFx4XIM=
X-QQ-mid: esmtpgz16t1788401712t3e9f05e1
X-QQ-Originating-IP: bMS2EqBMEyD8n8HuSXP+i7ZyiGSYTxj0CYMPqPnOlp0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 10:15:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6501738363549994098
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
Subject: [PATCH v5 1/4] PM: hibernate: clear in_suspend before freeing the snapshot
Date: Thu,  3 Sep 2026 10:14:56 +0800
Message-Id: <55f5c4da1e27b13d97266989166e2d877f518957.1788399733.git.tuhaowen@uniontech.com>
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
X-QQ-XMAILINFO: Mk/PZYwFczs7mEgCScIV9zbB3u5ODLgX/m2CXybKgBTJ5zwmaym+naot
	kH1neW2iT0d5QmDeSKJclw0WLbNj9YSwr6UAdc9jVT9f+eLKiK8+lmqQ0Mttdo9RFSlipJF
	1Wo0bJaSzXzRZcumChO1DCDyTBrmsLy/JVdtm+u4kxIoJdfyZSigg0YWhtca5AWqUgisa56
	vd/ip2ieA6XSdyWwgcPZOf29Hv4AVcgvqFdMk+AqaK3L1Vxwv2HrCNSu5Mcg3cIce+0eTVY
	HXp2vYTQKOgGaMWdw/sTPFH6mnE7L6LHyGP+JrmkdBQPNNEwOBQa/764fm//VKtFuXJkicM
	CRZBww5XFfZqhRo8LxYPK4w9fup6sXUMUnQtXuMHTvip8zQHnhlTGAu0sLARz8BjAF6SH5j
	z2iC8BxmDHFNvotUwtaP/ytKnjZriJMPtuxa0C5PCcjcQECRU2bWZS6nMjrH3+ugpkaTlT9
	NAO6Ey+oyFGM9PO1it2J17hQ1acVGrgmF/OvOanfb21/kBxyMGkYz6PzFKR/qvp6Y757HZs
	Q4jI0RKM901kxDzSYBng8GLb8r9Ks0CMVH2+1ljKzIHxgVX+DqkDmKZwoTaoGqwDgc1UTHD
	vlVirdUeBCO4Hj4iw5o/Tf/XObTG27CTHG76A3JDpH5cU60lnL/URdJ8YKySAk7HUwucu4F
	em+kRDnmgK1DuPCdqMrIbQYmV/wJA/1ljEV1T6bPLNJQexEbmSL8VA3YP+VINUKOaMkmFvt
	zI9a/OFPQro72hAAouckrvLOaXVqsr5dpOwrj/D8rYcizFoBhMmsDo+MtbBTCmet9CDhZrb
	Kg0T6lJD3oe0vDlbW1M4id8i3vDwG4pTSULmR37IBj4ZUNs9ODSjDgXPD953c7J8fJOqjm/
	L9cjPuGLvdDcwwaJxYyc931+I6sIajAH67p84gE11kWPw2c5erLY2XWewqcs+YwSqKpoLS9
	AjsKhtyC4x3EHNitiJ2iUiEJdK59e41ZhSk9YWexI5K8uf1uGl8y934OnCW+zfqfautZASo
	Ymfzw+GSXzwy3qz60hjrYBrvmQc4XxYPBfnADH99+6Xp9JmZNmP/f+JVmw5A9ttJfIWCzOw
	g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

in_suspend indicates that a hibernation snapshot has been created and is
still available.  Keep that state consistent with the lifetime of the
snapshot memory by clearing in_suspend before swsusp_free() releases it.

If image creation fails after in_suspend has been set,
hibernation_snapshot() releases the snapshot memory but currently leaves
in_suspend set.  Preserve its value locally long enough to select the
appropriate device resume message, then clear it before releasing the
snapshot.

Also clear in_suspend before releasing the snapshot after swsusp_write()
returns.

Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
 kernel/power/hibernate.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..6d3e637c5a02 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -418,6 +418,7 @@ static void shrink_shmem_memory(void)
 int hibernation_snapshot(int platform_mode)
 {
 	pm_message_t msg;
+	bool snapshot_done;
 	int error;
 
 	pm_suspend_clear_flags();
@@ -474,15 +475,18 @@ int hibernation_snapshot(int platform_mode)
 	 * returns here (1) after the image has been created or the
 	 * image creation has failed and (2) after a successful restore.
 	 */
+	snapshot_done = in_suspend;
 
 	/* We may need to release the preallocated image pages here. */
-	if (error || !in_suspend)
+	if (error || !snapshot_done) {
+		in_suspend = 0;
 		swsusp_free();
+	}
 
-	msg = in_suspend ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE;
+	msg = snapshot_done ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE;
 	dpm_resume(msg);
 
-	if (error || !in_suspend)
+	if (error || !snapshot_done)
 		pm_restore_gfp_mask();
 
 	console_resume_all();
@@ -865,6 +869,7 @@ int hibernate(void)
 
 		pm_pr_dbg("Writing hibernation image.\n");
 		error = swsusp_write(flags);
+		in_suspend = 0;
 		swsusp_free();
 		if (!error) {
 			if (hibernation_mode == HIBERNATION_TEST_RESUME)
@@ -872,7 +877,6 @@ int hibernate(void)
 			else
 				power_down();
 		}
-		in_suspend = 0;
 		pm_restore_gfp_mask();
 	} else {
 		pm_pr_dbg("Hibernation image restored successfully.\n");
-- 
2.20.1
