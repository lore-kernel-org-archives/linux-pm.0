Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764D3932E6
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240740; cv=none; b=Efh8Ep/jPzCsWwQmLYMULClGQ2VxaxYh0O86tXYFB7ewIh5ciBFUAxHsrpYNZnTyoRc2R5AX67UQqto/LyOmecdtaRFgV1ieLdbQK/5uKDDhkCjbYD9WKKJDnUbhvAFgJmnm8jLTSH8TnnzzPgsSkWqO2QoXgwNUnSTuVfT1oKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240740; c=relaxed/simple;
	bh=N+clSWmKldQgOxT8T5fNV4IIOVNxC8JfASo7QwlxHsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTzoHQJ8E5HtRJPIPgST+3eJQdiAdFJeIaOBzRl4cgGTvKRCgQDBUFPP3OM0EhhVQTg7AIuPJjru4iWeBWoKH0EVd4kAvstuI4xmRJ8Jf6kmCRfayEWowYEV0+j+yQRDd8H0NaO/OBzTnPwexEYRNvCR83Z+nyrmd+qTgTkSpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1fNsOs+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1fNsOs+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso1118939a91.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776240739; x=1776845539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fZYdbSpJsFdiEeS9AF+5M3wDWj7cMyvJAhs73ZaUoM=;
        b=N1fNsOs+GQacoHqfySTwy0XnK8mWeED/s0cc4B6cckbA8y82g+r1ihG1XpxbT7r8K5
         DJsXVFNCCSR0yNr7kFCe57Y8vT/YeBgiIOZITYS6a57sJ09oVla7ZtTSbsthpaBqDW7z
         gor0b4b3IkMmPJbPUw42qT41xR5zboUn0O6ONWokHnJjmjELc6pUO7V4g0eGpK3gP8C3
         cKfQksi4pucDN52ShMdB5+1H1ZH0x8qjEjRhuNbCMwYYmvhfqQ7xoQBr3OC45QjYgw7J
         6kImzlLDeFqyK29DiwmLxtOFREPnnU0aJZKR6LAWHz/Fa2faFBIsZn7imCMdTwQ+529y
         +/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776240739; x=1776845539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fZYdbSpJsFdiEeS9AF+5M3wDWj7cMyvJAhs73ZaUoM=;
        b=ii3TTQE9CQ67Z96iOb1zExldPJG629EmgSukKRFOqmuy0g+K4MEsYWh23NF9zNRSrJ
         ec8Szk2lZimOwjX1v288UUCZa+PfFfTEbzP753fIX5nM7mkhxUd8nzrRSzP2O/C1IqW6
         V278XC9mW1IzJLCC7pNidaHfvDKGAP7NK67VxVy+K6gSzqMaUuwYZvx8F0Ej4i9PSAh/
         2Wn6FxG2MsW9K70sYtjVyb8YOmQGuW+WTnI70DT3/iRlUfiFLxHLXxnRGfNDByEnMtS2
         M8xHKz+TmLVddIzogB2WKIKFIt2bnA6xXtZXCtkI5DOm9WeMMIyEq0qh23kY8bRBECrp
         oMDA==
X-Forwarded-Encrypted: i=1; AFNElJ9vj475kKW5RWwxrpJbz+ksoeuPO0cdcpoAHDXvQVGCd8R42PRNRtJfByH1XDBoY0CaxaHK29Uz4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeJP3Jz0GPQHuMRw+Ox66yq4Uz4SHhXufQ6K1YA9QpmEbbTC+
	MkS3OU5R24Pia32Z2arOeTGvYV8yKpZVEqahjirNkWUNB60PQBkaBMmh
X-Gm-Gg: AeBDiesgcMhzpXruJAR//l+1lt1qXjq2K4OJlY6wUpYapDuid79++sULFL6SM65bz3F
	wsVScqOh9brDOCc0nQuJy5O+wTNqehJmvVoTKP2wDy/7kDMKAXz7DoYrAyIWjTRkVkl3JyWDws6
	x9QFXG5boda/Z4ydEWHOqzC4ksvibKhjZarfoJ/kDGW9GSrfOMsql4xZpYOBi6HfNJjLhjmHWqn
	tIQx2LZVxeLowzL0LMTGN9XBlN7XptEZNyrbfAzlChl0LDM2lIj4q+KnbXs1yO9t+P4LomrIhBv
	gP1hvIhed43KKVn9eoKXCot4gEU7w5SKQG1ZogiXBfwQTIeD+fWJ/bz9J/TLsqUrBncHGpn9gFq
	7w68ZDDhczbezwAvpKjhPHjotVR+dGX5yJRzFl/3c5PNIPpbyAiNHsNqqmd9Ee2GAgVBgmq/pfG
	vDXZ2tXwzNg78wI4lU
X-Received: by 2002:a05:6a21:4cca:b0:39b:b6d2:1f24 with SMTP id adf61e73a8af0-3a05cfad152mr1094977637.0.1776240738578;
        Wed, 15 Apr 2026 01:12:18 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581bad89sm898869a12.25.2026.04.15.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:12:18 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] PM: hibernate: align default resume swap with image-device checks
Date: Wed, 15 Apr 2026 17:12:13 +0900
Message-ID: <20260415081213.1732019-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snapshot_open(O_RDONLY) pins the configured default resume swap area for
hibernation image writes, but it does not fully propagate that choice to
the image-device checks used by the block layer.

In particular, snapshot_open() uses swsusp_resume_device without
swsusp_resume_block when pinning the default resume swap area, and it
leaves snapshot_state.dev unset even after the pin succeeds. As a
result, the default resume swap selected at open time is not kept
aligned with is_hibernate_resume_dev() and can still be rejected by the
block layer in blkdev_write_iter() with -ETXTBSY until user space
explicitly selects the same area via SNAPSHOT_SET_SWAP_AREA.

Use swsusp_resume_block when pinning the default resume swap area and
record the device immediately after a successful pin so that the
hibernation image-device bookkeeping matches the configured resume
area.  Also clear snapshot_state.dev on the open-time error path so it
never advertises a session that failed to fully open.

uswsusp itself is not affected because it always calls
SNAPSHOT_SET_SWAP_AREA right after open, which immediately overrides
snapshot_state.dev and re-pins the swap area.  The user-visible change
is for minimal hibernation user space that relies on resume= and
resume_offset= alone: such tools no longer have to restate the resume
area via SNAPSHOT_SET_SWAP_AREA just to satisfy blkdev_write_iter()'s
IS_SWAPFILE gate or to obtain SWP_HIBERNATION swapoff protection.  This
also matches the intent of the existing "The image device should be
accessible" comment in snapshot_open().  For the configured default
resume area, this gives snapshot_open() the same pin and
recorded-device state that SNAPSHOT_SET_SWAP_AREA would establish for
that same area, so user space relying on resume= and resume_offset=
does not need a follow-up SNAPSHOT_SET_SWAP_AREA just to satisfy the
IS_SWAPFILE gate and obtain swapoff protection.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Based on linux-next/master at commit e6efabc0afca ("Add linux-next
specific files for 20260414").

Tested in QEMU: with swap on a block device pointed to by
/sys/power/resume, opening /dev/snapshot O_RDONLY and then writing to
the swap block device returned -ETXTBSY before this change and -ENOSPC
(i.e. no longer rejected by the IS_SWAPFILE gate) after.

 kernel/power/user.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index d0fcfba7ac23..c51b8185de4b 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -69,9 +69,13 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data = &snapshot_state;
 	filp->private_data = data;
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
+	data->dev = 0;
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		/* Hibernating.  The image device should be accessible. */
-		data->swap = pin_hibernation_swap_type(swsusp_resume_device, 0);
+		data->swap = pin_hibernation_swap_type(swsusp_resume_device,
+						      swsusp_resume_block);
+		if (data->swap >= 0)
+			data->dev = swsusp_resume_device;
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
 		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
@@ -92,13 +96,13 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	}
 	if (error) {
 		unpin_hibernation_swap_type(data->swap);
+		data->dev = 0;
 		hibernate_release();
 	}
 
 	data->frozen = false;
 	data->ready = false;
 	data->platform_support = false;
-	data->dev = 0;
 
  Unlock:
 	unlock_system_sleep(sleep_flags);
-- 
2.43.0

