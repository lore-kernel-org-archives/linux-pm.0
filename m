Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B73BCD37;
	Wed, 29 Jul 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309114; cv=none; b=BY0krNcYQuSZi87KkQJTNxDTB3zsAJ6QFRhEq+TEHJZf5eeCLvkmTic4mDaardbzEd5+nvDSJP09/kwU7RJXJsGPb+9yWhTEVqzIwW1RWzNFM3q3gO2AQB4ea6euKSmRBd0UMrIMA2Om4Gc+VV4r4CEWv6apnCewJdB4/kZy6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309114; c=relaxed/simple;
	bh=0mwRk7GLVROlgRMPs5q2Igv7V8qKoyti5DUfIC/gP2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nidHgcDpSwKOyaRTT0Kr22jioMLpkg0zc6Z+9lyfBZA17oDSzcawIp38V6qY+Ra3Vr/PRNDO2ou1y/SnYXOvVOJuPwx6/1jBgoNAtTPzEhTsZVHRdaL/cQhsYVxDTvPkKxp2mj6PN5kw8LjfTBnGKzZHM8D23DogYB0oaybVbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oyRUJnP9; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oyRUJnP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785309106;
	bh=JH1QDDx9o4boh27DWmqYCkbwbUyXJy/qdQiBxn++36c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oyRUJnP92zdohMp+/HXeyka7M6UU1AnklFgKPa3DXVUmjbgqPuh4WsF54yCFRnWcO
	 U/CWGFXWiRR8HAJboZFwr7rB0LLo5Png8gbxGsnJUWuq/BzTjMBfsvppqSyGqQkCEb
	 FJWBGWT1nyN5oVPrEoL/H/yoN3BgyLO7sU/LgD1o=
X-QQ-mid: zesmtpgz6t1785309095t97444c05
X-QQ-Originating-IP: F7xhpMI9oRzjaxfbDCiGGyerJ9Su+L/Hsf9QNyfpLtM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jul 2026 15:11:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1664637546155480196
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
Subject: [PATCH v4 1/4] PM: hibernate: clear in_suspend before freeing the snapshot
Date: Wed, 29 Jul 2026 15:11:20 +0800
Message-Id: <4fafe6c2c7bc99e8b4e5042eae19ad9587f99cc1.1785226280.git.tuhaowen@uniontech.com>
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
X-QQ-XMAILINFO: N0zPMTspoMafiepaqDqyYjYW9YOiDAznycfpOiDj0owxwshWwnkIZyVH
	9TCFW/IkSd50n5xM543R0QaWlHk14QBA6hA4kuzQkd5Vu3XU5cVQ/0rkSVbuxhOPe6Eq/Tv
	L7m5lZBB01Z2R0HO6QTnmEnZueDnQbOz9pPaVROudKylvlxuDmBxRQgi2x4AxnQliCmGmdg
	E/S2HlSd/rRxJ/BDPTxAgPtJwPJRfcI0WkuHOhIw77jFI9RvjiDfUyJYjv3rNKQbUa3r+7E
	YfpOD8CAO5AzmyPHa9ISP+cIp5M5JSFdbi5JZMSo6o+feRgwu/Fv5rFiR2UxU/xpEYNlWWm
	0iCdQ6nEs3rwZwws6nb46IRkIWQ4R8br6YoQoxCvM4etIkP1i5ePronaXsrsWy5NFV0NyPP
	bKKQtOKJlRMpUVI59+aHFUPPMEZaN29sKJssIemoQLLmWPtw4h0Pr880rlO9w3nb+1KFEwQ
	KdI9eJMf8jRhW4pfU2QLZ7BfnwP6gW1rXUWogLBvIkUZaE0TcrBp1+ub3gV2D5yJwMS17aF
	yZaHLuBUsFNWnUq1Bb2zU1A0Bi4gEjf/GRC0x0eBXVBWvDzLtoCywX7m8aqbSUmtFf+bcV4
	0xvKLvcyOrz3JzbUwWX1JjMFulr6butpX2zRy74oTe2Obb1W8ghUqOa9deVNsQSNOEljppf
	gJNQbrXIog6r+h+AkiHe6OxfrQIK5wPa0fjLHqXZpbpQHyHjY6hVuk7UTDhHLY7mtF+rNbl
	WBtYO5JIBoAbbLNm6HnDJ9ToMzY/DaS4qkz6prH1UDSlGHv7upc9q5hkakWgnQ35s0hhSNU
	T2VUnRPookfguKFVJWHUF1XVMD2LcGPIQ6RrCxkDg7Bl20K3Us73vfXh5htiMszM2+W5BtD
	2akfJhNx2ZgLPX7qbrBaT6MzlygVteonR9y65qCVEkGnaz8xJUJh1jHe8QQHwIzO5Hpy+37
	MlDnqOdmONR4ZpW/xISxqoDWgybZEqkzszBMHcwSXtys2fZTqOFaI/vddHumyGIvlr9ZWYf
	1Qf+gk32UD/ozUMvuHRSDmG/DpSuHG5+CNcLag1wVTwPn+TywYnMdRzL7ZTuvlaJRhrDr3S
	A==
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

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
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
