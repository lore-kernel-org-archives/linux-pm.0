Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198597;
	b=3GWMWAcC//piYZT3/ZRM8kFme0oL27CtKEfJeuAZ17YRv7GNre6VftvkHDKb+xZ0mZ65
	 9BA/cNSEfkITPL0ahSzlWegr2S5ajZLTLribUSxzgWZNh6LaPVJCseOQSnEJxpiCqEUdv
	 KG9kYd8dH3JPBEBuVCbsOiYPZqS6pAbebd3fYSpb3eyX+hZYcsfdN0GfzFYDLwIWGHera
	 RQwnhl+f2dhW96uLiog0blX2AzgW5TXy7T485OYi0HI4iDpENSXEPiAtiHC3Unz4n55uA
	 Y7/Z0w9gPETcTzclWmLuIT0SAYGpEyvtLBlGOQogl8k6Z5kucwDOuwz5TI/4FvFMBaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VPm/N53b/qsbfk2FS3qgdrUd59JBO4w9mAZfXy6OFWE=;
	b=1mrpeEadUBsWlzc2eLUzpNQ6mf+mtOMZzQR8lioVmg1rUTt74ri0dLmvuE6dWR9jLBtG
	 v+5G0AtV+Kc9iGxOD9KfN6i7H5NhyHHap+EI+oydzBJ0zQXL2ZXr3ttCrliMTHxi42TMJ
	 TjCBPyu7ckRDpmt8aIUVK0yIh+KLXogyYK5WN/4sPWDXAVZRgIPEY6ezl5Mtt/SplYFEW
	 lsUxyRiysStTuIr5mbbixkIyfTJrW6rUOsMgijGs7ad2a4ORysBqqW1PFEFz/MQS/rTtw
	 HmbFNHp+0YjcBdabhYXgBmVnkzSF7DCj2zc0dc9jkRv/Bx5nYGcIGvIURH/7gNNbUgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zMF0mnSa;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41583606A32C
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41583606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zMF0mnSa
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so3172649eec.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198592; x=1795803392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPm/N53b/qsbfk2FS3qgdrUd59JBO4w9mAZfXy6OFWE=;
        b=zMF0mnSagPg68nJVvEx32vA3DRPcme38H8XiAufn3nU/0OdEoQFLbj/KxaBUDtmP95
         hOsx3KX8wWr0X1vMjVxUOaINwEzunhzSuXCYXDpEcpMvFSmL6GI7WU01M/cuF4FKJGxM
         TGOop0u1ig8o5jzHW1m7IHMOaNICnef3MamRaBPxYYE4mweLQCY3QqZ1aFsjPT/MsVJc
         KPYHuRi5WC4FpJors/lirWwi6+D3oLnLiHiWkkziW/pc6mN885FygKl6dbQ+AgDj1FUj
         irefs2Wmwq1HEVbFieHpywKGD/iLprojIB8Erk1zsNnhL8+sSvAxiNyLekWOb62BbWAv
         Gwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198592; x=1795803392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPm/N53b/qsbfk2FS3qgdrUd59JBO4w9mAZfXy6OFWE=;
        b=KOUTaSRJaWz7p32oeVkr2K6dFKcaxW5hCvFAV1k0A/iBVlrBwguYZKffNjXWgLmYa5
         18u5Bi+uf1+RqldXo13mHwNAu3YyssthsKeDPAOxDOQmeJXMJkEIzH3aQs4QXRQK1Y5q
         WkfBw0oMxOm1s/q/moFFMWiEguDuAbdlgQwrA/hmbnUCV81PUTreN6SJT8JUbuddH7Pe
         RZf7WuF8zX2s+WYcTxXhZCVrVLB3qjTAYbrDRjpnsjG49vOwhAfPnxA39sAA2sLFGXmO
         57qZw8hiXFyTrzpaqmUUVuMZDIqOmCRv7JnMDDAKwaY3dDvcqHbHSz5so18mmB3/t8MC
         1PXw==
X-Forwarded-Encrypted: i=1; AL+hErH00kkrDi33f5C9bOIiHF/TuBSBkhkB0MjH7h34PMkRqinP81gt9FQxkhwHhmjz1k4sE0SmuEpQzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9oebxolR8ICWwkoKpCBNajaT+u/E6JDndeWlJ7rjnUALfVFQZ2
	E4NjmO1ta6V2vYyDFgAJPi2vhoG/YgC/oOhO9UOZYZe4+/fKfXfpuSXf
X-Gm-Gg: AZFdTZcAWYgbUWtNXGw1A4TRNV+UerCF2BKwTw28WPyuCh1lMyBsZFXjeY8S3cwH6QP
	/5lioziuJNRibh0LW0i000eTW620uiQGqtfzTvrByQp9xzBFXeJbuWWu02JBUmVqerHC1Pt358H
	VOX0ix/b/A6p2R2Euf4EZ4xFV1GKki81fUcAX2TxdU2WxMpDCf0f3ye3UMy84svCj1BPs4l9DMI
	21TdbS/gqWMgnwF7Pn/HrlH9YH+0Fq0ymYDDp2m5e+cYp/kiYOU4Da1JqUUghqvihxZr2/G+cPB
	ljoJNg8jWiXLoEGmCRfvNs8XSBeZx9PEoxloDcCtLZUEoIw1NsNPoVR5ADNlAQIdWY0Xk3XKvP/
	YPEAT3U+q9oWEW3zxnbpq/p/2SdwGfTPZUWME0rTq41YwF2uNKl5+gJVINavKmWON561mSNRkt+
	SwzCjBf6RUw+Ab1ZZ+vVvYMBxuzfSpgpmE6hg/rcbNWoEwkwGrqHDAJYWorFXKUNBfMUaPjK7Fu
	Ku2NltZVlDHTCGQa2SJ4rvrnNWOxDjb7onkgRvRLzSHdZ0ifmCJpHFoVjNcqqClG5fyEI7iQVqR
	oyVC7tviiyLv0xWu2Ann2h78S6lUYcZwQBTcuBp7Z2TQFMxbtP7zbjeAnxIuVUjdyyy32Eo/ng=
	=
X-Received: by 2002:a05:7301:6405:b0:37a:cafa:6d78 with SMTP id 5a478bee46e88-3856ff54addmr3982441eec.33.1795198592317;
        Fri, 20 Nov 2026 10:16:32 -0800 (PST)
Received: from sumeet-VirtualBox ([58.84.61.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm9736610eec.23.2026.11.20.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:16:31 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com
Cc: lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] thermal/debugfs: Fix truncated cooling state transitions
Date: Fri, 20 Nov 2026 23:46:20 +0530
Message-ID: <20261120181620.12648-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.53.0
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

cdev_tt_seq_show() can truncate cooling device transition labels
in the trans_table debugfs output. The largest packed label,
"65535->65535" needs 13 bytes including the terminator. A W=1
build exposes this problem as a format-truncation error.

The buffer was sized for an assumed maximum cooling state of 1024,
but the transition identifier reserves 16 bits for each state and
does not enforce that assumption. The signed identifier was also
shifted directly, which can sign-extend the upper state when bit
number 31 is set.

Decode the packed identifier through a u32 and size the buffer
from the largest representable transition string. This prevents
truncation and prints both state fields as unsigned values.

Issue reproduced and verified with a W=1 build.

Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/thermal_debugfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index da02d8f179b0..107569d12965 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -322,14 +322,11 @@ static int cdev_tt_seq_show(struct seq_file *s, void *v)
 		seq_puts(s, "Transition\tOccurrences\n");
 
 	list_for_each_entry(entry, &transitions[i], node) {
-		/*
-		 * Assuming maximum cdev states is 1024, the longer
-		 * string for a transition would be "1024->1024\0"
-		 */
-		char buffer[11];
+		u32 transition = entry->id;
+		char buffer[sizeof("65535->65535")];
 
-		snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
-			 entry->id >> 16, entry->id & 0xFFFF);
+		snprintf(buffer, sizeof(buffer), "%u->%u",
+			 transition >> 16, transition & 0xffff);
 
 		seq_printf(s, "%-10s\t%-10llu\n", buffer, entry->count);
 	}
-- 
2.53.0

