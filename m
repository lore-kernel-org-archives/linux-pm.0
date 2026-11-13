Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531724;
	b=S5lImEt16Obz6oDXCUZ1rN9PdqvrBIwN0l55wDR7bat+ElUaTBLTjBTxqv+Rgp5AMoE1
	 80caYEYVB5O21nwFU4tqFRk1nI7FD7gVoVBaUjvGuT1nn2KCxAJTcVu8SO4L1f7zABfOF
	 b3kkTYQNvUMKpgcCA54+AtQbH0FwCWVqNziDWR/Crb/vP6dOx86VH5sUlwe2ce4uNN4TZ
	 tmWOWeY4eyaYO50bTW+dYhYAPkWsgobXHMQLa3LEiylQYlsdGgn9wDVFir+K3d4tXIcPo
	 gKSqLhRe5yKBE0rm6YkMSQ9gvxpl05O1LCdn/Ktr2BPM2W5Hwe5+SZhvwdtxSW9YdKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531724;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=MbV0nYCvQjonoY9GqSdbwd6uyf8l/vnEpP6Gg+I3jek=;
	b=F/GpotZlNnO9v98XnkQvjAklbdLLaCPVQ2+yfHdaL42wVihAUxPdTF6byZ34v+fSCJgc
	 vrj+0WyeH4ewf73eTZhDHLVvjPxDcEnmW0Kb+tGzHWeFhyWR827bk7btduAn4woqDo1aG
	 qjNDmTrVLkY7BL3AnG6VsZyVKXpBJzou3RVNT/didfYfoaf9QYGGXsY0CQrLVcIFnZBP0
	 qgxJrHLmuZrWxYwnhK0GrXEuIbOZadPlubUjMFKPSL0nFxRA7+e+Ga4YKxVLT3AsFzrq1
	 fA3CBVybrp42TsJBkWTVF4LctHPsx2I7F8BYX0Wee3qMfi4yhzE/hvkXDPvT4bFwmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=gTrK0sm9;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE282606A321;
	Fri, 13 Nov 2026 01:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE282606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=gTrK0sm9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794531703;
	bh=MbV0nYCvQjonoY9GqSdbwd6uyf8l/vnEpP6Gg+I3jek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gTrK0sm9FwPWze3VR6plnfneCjBCbbvPu6TqZbZWmQfRnJhJ0VGpyIXezwYek3PBi
	 b6XPKQn7ri896s+z6igEA3j7tu/0Q+46mG9LyP7HNGHD5HVdwvj5UaHbcLjV2PPFNw
	 N/WFAi+6AoR93PJoG1/E7Ox9/+37l1iFJL5avaOY=
X-QQ-mid: zesmtpsz4t1794531699t37acbc69
X-QQ-Originating-IP: IOQ6sw8ZhMxrz8Vfdt49he8dY5M/9y3F1itoJ/5IrEw=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 09:01:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3981416717420647714
EX-QQ-RecipientCnt: 6
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [PATCH] PM: hibernate: Restore PM notifiers on snapshot open failure
Date: Fri, 13 Nov 2026 09:01:34 +0800
Message-ID: <10852BF0B4974597+20261113010134.1408010-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MNbA5mkmBXEJt5quiIHHPKscnR5sId0xT3lkKlysIJeYYaS9ixObZIin
	6WVP5m9zMLWgb1yexso5CKCLR1QzQ7XnOIYOEMNTF6hpHvYqNX25VbGfrPQlfLc5oAKYYc9
	lMQrAyDsMQF2ZR/UhjcxFpNlz3RzaAIyCgXiySdCJH0/4WwcRcvZyigx1SbficUYiG289K7
	/gAATsJy2bsjI8ZJPNrRLfirnWYQVa6Rjxg5BEmAMcMXhIQ/IU9I3vsGn2Z3N0cXEX806LJ
	0AxeFfYvRdovEGI13bR6zbU9xvXfHcoz4MQTG2u4xqWs+Ltfei1Jx1A/3qcIvVCI8IAQB5m
	YAp56f9oAVtSYZa+7Tn3Ll+ueycXHiEnpAXOlGvxZPSTvLI6YUiylfs9HfgwNfVqzk3uqF8
	vX+/RN5LggVi0PQfPHESxA3wYAC/xz7qszjNC7wb21HYJAChADYwO0Pu7FXZ6Gr2GaRGy2+
	397RQmwVhBqF8gH5S5NJZUtXkOK0pjMr8cbg2krTd3RwwuYPieqEGS5NpF43nvsM7Z/PmQ5
	cXARKGDmX4Oimu6txZOOIZQ2RAJXfyQLrkymc9ubIC3TlGAnsO1Yi/09XO9LrpCj4s4zIkL
	J5SCLi2oXYOa3fY/xQni88HNl7jHjA7nr0PgvxRFuI0cwDtZFUm4c1aOBH7Yk1Z2Mu9s2c+
	fJlmvE1IImFOo8JT/hWUOZVNUbnMSzB8tfrSX/QFyFUJfA0lcg7275PWwMwPCasHsCqCKBR
	tvjQKbq2Xheg9KIlL9sHtIoypcx9H6MbY1Lu72PqzhvtpY0WDdKyBoF2PBgO6jsgohfRIIz
	R9TANNtA8l1n4jGgRm8jGhKCjyVWMq1QYmHaPZd2qSWLxeO76DBpeDQFRS0ihKZsr5lw/5d
	73nC7+rzCQZTYfcfl3vlyZ5fmEf8zlYH3NUPg8J2KJn7dNjZQJVB7DchLKcriKG4D3xz9Yd
	TyRnPlv8pGOxk4kw5UG0qcimAwA06BMPdXXh5HwUwQA5qmiyggZqQWlyCXICl+fqVOSglgQ
	NdRe/kcwrVMYdmvans
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
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

