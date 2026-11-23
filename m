Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398306;
	b=M99GYoU7ozK8SadYML9EyvUiKt5qZGuk0aFaU+xJ9I5bnfR9XEsH/BT3KxonjWWlLzIy
	 y0FuhkbBk5SeJzJv/UhUMBvRc1L3gNgvyUK0uFjlB8y+cVPn3ELGytux+56B6IN4N+8g1
	 5W4iPpIFBw7CDw6cvM+4A4PmRuHxgrzA8XJ7a/pCOyiXstOZQnmMSqMSimLgHEguF5aYz
	 UPVUTldRANnqTh/P06P3nUeUjeFBy0yeHh7HknBBO7JZWUZgwL0daqLvcRpubhn6AmzL/
	 2NzOpDFVyOiJQ8HVsTI3cuftOvmJAwbVV4JQW4yURlt1rui00qsYWaNzqbdj5JD06ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398306;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=VU4I0UfBx0/SzkSaLn2PbLn8QOm5gaP54n8Sj6YBGow=;
	b=M+svVBOfNH6qGsG39FpMP4tFG3Ht+7yZyhDpxGLBnIEUSgULndtlz2QuLNAHpvN/esH9
	 dCIL4iJer1vnsckYslBTY1xpfKRlJc2/bYTDBOSFCgLS6AbzoHFdjy1tWKQ6cMJBPvMp3
	 u18ftjNWmHOlAyZ2bZe8p/7zaDug2n3BLykhQ3Xxtb+y5qW7NbplQe18bwkhmytwIqhkS
	 gFxd2hNPZroDkUsOurWFBdxVQFXGyY9fJ0ntRfu/cGabNuKNI1q4Tk5wD0B4k6uYuwPiF
	 oU/4VJ6VD0c+LE85pxCe2bKZ809TFycTLO/eLLdBY9rUAZLa0lab71Y91/O8IHQ1t/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=nqTGtaNk;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E7606A31A;
	Mon, 23 Nov 2026 01:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B6E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=nqTGtaNk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795398281;
	bh=VU4I0UfBx0/SzkSaLn2PbLn8QOm5gaP54n8Sj6YBGow=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nqTGtaNkXbGbYiN3JPCHF3ndmLB5TOYICIoEoIRByceUPKL6bxx3Kp21N//VP8IFT
	 c/r1rkpEg0nl3vsS2nvUsQBikMtEtb28fYVrXHti2e7nKG+3SlCvF8gywWKbimuTKV
	 uXXfT2eyOiUxfMAksV55ydbM1bU4yDN+nZ16Rkwo=
X-QQ-mid: zesmtpgz3t1795398276t8a79188d
X-QQ-Originating-IP: RNm+elcpYHUW1IT/nKJuHct58YidW7PzxwWLjuRSKoM=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Nov 2026 09:44:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8055298123164367588
EX-QQ-RecipientCnt: 6
From: Haowen Tu <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH v2] PM: hibernate: Restore PM notifiers on snapshot open failure
Date: Mon, 23 Nov 2026 09:44:31 +0800
Message-ID: <7E32B0BA837D5BD3+20261123014431.1413620-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAJZ5v0j79Z35=G0j53UYxzY9T_vgpzhrMAWdejTfUZ=tYXLM8g@mail.gmail.com>
References: <CAJZ5v0j79Z35=G0j53UYxzY9T_vgpzhrMAWdejTfUZ=tYXLM8g@mail.gmail.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NN51gi9eLBwa2oII7lNDPA8FmmwZ2HQlo5w6NGwXSgKtoZv0SUV+zTlE
	Yf+WZLM12mkmKtp/Wuz7yrU5fG75VIZjWT4iI1y73RcZUG7P4uyGjleMfzlLRAMJ7YHhPOV
	iOmNrjUb/vPXje+N6zjGHn8WVlzv6xfqz2W/k9PJXngPycSLUAPPoNYPJR8xEyYcxZlJiUh
	Wg9Y1sryY/R/Kg4ApItgVuR8CTVGNIhrUZo1wCmr66Cy4xknmng2mkypLESa8ExS2fhH3PD
	4LLGYF/9h25DPen34SgroTq8/eEIo+HKHYN117aYFEHgGuAngJwqwNFbkCbrW7g+EYF4inF
	/lSnfWzHebAQPf+eeQn5FSo6phgpd9IgfZDZgCDfcz/1HBXwblvJQsAqM2tPYmwq+b+UKMz
	0PcJactU7JKWNo3dzEvD2IaFfx3JcEigu3xhudDjXxy2tGKWMS7jvvOUw7Pzo0hbUWQ4C8D
	6Gy8oDlQD0EaFZNMIqYA14rJaKCx52Sb0OovOzVZUxegusZh9BT7iUWgJIhW/lZp7v+bb9S
	CGKR8X6bYK+g44vDrm4fy9lTbeaGJZm7VzQCqE0Ov+RfNjOiPaXZa+77t7n56j9945FXIGk
	kfaSOP6fniQtuNMJOSAYBZNAWvVqODPbny420UKbGZ28lraZayA1IWAijwNMad8DXLabxjq
	bg1a002U6ryQFV/k+0iaS7AFc6yKwPMMTPQvsnYnh+M1un9upzIQDZw24HMIuXpGOiEfdcq
	a9aY1BsYFIMmmR04yZ2gBgWU4EfFBxooudzrIRtOvofqR7M6UKPhiKv47OPam+U1dqM5YhG
	T8T+y7HY3lrrLTVjgkwWfawGeorppPfVoP5otpU/kcYos51nZkbN/R8myZKflMmz1x8Dpbs
	o12vKRqLHXKpwFZ5bl3B9/VEUXgjBJIqCrSDd2QjcUS4gNpUyGl+gWTNXJQX5kQRK75z/UE
	ie6J7uew8dKDl50rjf4E9KwRvIcogBANgmi7+KPkv8ui/Cj9thdnJpp94RAVsuC3jEZfttC
	7P0FDZy/chK5oby9Yurc+YQlxoAKc=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Opening /dev/snapshot for writing calls the PM_RESTORE_PREPARE
notifiers before allocating the basic memory bitmaps. If the allocation
fails, snapshot_open() returns an error without sending PM_POST_RESTORE.
The release callback is not called after a failed open, so it cannot undo
the preparation either.

In particular, the firmware loader enables firmware caching during
PM_RESTORE_PREPARE and relies on PM_POST_RESTORE to reset the cache state
and schedule the cached firmware for release. An allocation failure can
therefore leave firmware caching enabled after the restore attempt has
already failed.

The robust notifier call only rolls back failures within the notifier
chain. It does not cover a subsequent failure to allocate the bitmaps.
Send PM_POST_RESTORE for that failure, after a successful prepare call,
so that the notifiers can undo their preparation without being called
twice when the prepare notification itself fails.

Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
Changes in v2:
- Use my full name in the author and Signed-off-by fields, as
  requested by Rafael. No code changes.

 kernel/power/user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 6e4f40e49319..e7e8016a4f1a 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -87,6 +87,8 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 		error = pm_notifier_call_chain_robust(PM_RESTORE_PREPARE, PM_POST_RESTORE);
 		if (!error) {
 			error = create_basic_memory_bitmaps();
+			if (error)
+				pm_notifier_call_chain(PM_POST_RESTORE);
 			data->free_bitmaps = !error;
 		}
 	}
-- 
2.50.1

