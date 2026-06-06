Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0D2F7F18
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779916; cv=none; b=FDl1BHkMl3V511CP4QNZLLP0p8ecXkcpbkHrp8vNLdtQq6L8DQclRwvnMRotTsJdq/ciSx/4PSIApAn1bbPAmR0YYrgc4g+aBVja3YA/Kh5qaQhSDrGmRcLtkc5V7hmGbsSVW9ed1crz+2b5FWVUXyOvNtfgLcJ3COVx5WHg4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779916; c=relaxed/simple;
	bh=XvJ8iwzXt1UHbWadRF6VFNlg3KOsXG3iQ2zFCLx1qnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vif+M4UWTf3AXPINeRZzlFII+eDa3FxIwYJQLqyEkJMXebQyJwTTMp+DHE2oKqiqGXt+B/WGlmcPY3iHuhUzFcx20cHah2iNV/YmDna0ZLLp/pFalDCsO8OLxCKaJtPmTZsv0gLNL3HXwZEhRkVyqNGDVtzikCaBY/kuuvg40Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTq7FoR6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTq7FoR6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac357c55so35968785e9.1
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779914; x=1781384714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PKEFcZ4g7H6rAqtTcj0u3uyo4pWRrH0e5YYMUDpufY=;
        b=XTq7FoR6aYaHCf117SFCg6hTdHXBDqo84rvEbtIwn7jnK+pMSuCTjtI3pHbkDaFgvV
         13km3oANJ/6iatv6gemiwwl0KdqCinJ1zKVnT7rUTlzksr1lxrhQeXIosMEywVzkOMg7
         oOnmO/hymCmkqalaC/TrgBHs/XWOOTk7h6b3yAFmVjkBtGMZJd3rHbH5JyvHbQKh3bcn
         fBjUxjQs5fJq6dTVy9eURIvcZRgHCia4VIqlXs5VtW9hP6jWmZz0EvMT5hfmc1UXOJMR
         esXsXhFRc03Y+OWZbCHNZOglzjs9JwpMYiFJgCOk5ctW3VuUVLQJpUEZ1ZRwT39Ispjt
         o21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779914; x=1781384714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PKEFcZ4g7H6rAqtTcj0u3uyo4pWRrH0e5YYMUDpufY=;
        b=ZYF5cU0vNMbDhb75Gk1ql+GE3BiFERIKl102XCLjz+EOUEX0Lgi3G7THMAIblIqzHG
         UsbUv4ahNyA2Cx+8z+9z+kMtabeBEswAMI3zxqw6hFOHSG5TFebuwRZw1PVJ/A7vMirj
         PfiL1h/WEvTs9TMcSf+X/rsQ2xPsqEZpcQF3tzhRer8MckVw44yFbnKfB0weSBiXCEET
         axUQMFdbarhfmms4HATbDPzEM+j65YgTtwxQtFy8CTYlp9OI38EuLpbWq4tmUsOpdF4T
         gDu5KkxYYAlhLxuYOJdgpfP9Nmx374fOJ7Y6X4Zyp0s2mmDae4ppvPP5kbQaFeEDgRGM
         mAlg==
X-Gm-Message-State: AOJu0Ywy3RD2FQ+wf54IdSIenoJ2ZdOPWpPCEdGZRZnbVG4+PzxKhXy3
	iR5eRC7kHkJxwFybfDV6DahkwQuX0aBFBUa2+GfBjCJD6xchv96x7xMj
X-Gm-Gg: Acq92OE4MiST4mHD1dvsH06TJY/wiVB5hR6GbPDLc5U56Ykz0l0b4arXmiD+ViE7JWi
	u7aCwRBJzncQ7NZxzoICh7DiiPY3rpXosLaeQaXiX2P3FmZ+DXq/yMdiDLYj97wlAe3OByxV3Z/
	q112GZ8ZoPMOyGum/7rRjX3qjB9hLgMpASewUITX1IqZI/EDZYyecaddM6+fMb9HUNbtt83B3eL
	RV5uqQP3O1ILIQ3j2xfkM5Xf2x1UuZgNc1hsSLfIn623I+F5ywtlIPCi9RIRJuLG/NVXd/svWW0
	QpIDO+JNJgwsxi3Oe3j8vzQWzDjVi+WPGGpns4rXg9AHvLJkV7AUQMfJKshpAUFW5XcfsnpFuOz
	642A/lrbx5WuLboWiaTPu1Q2fH9DB/oh3JnH+JUlNj+WFmz6u/B3nY3pelLuc8Vdwupn5S9zEIz
	ihNFB64eUSXBIJIPq24a0ZGjfr6T349WV7p1BXQWDw5b0=
X-Received: by 2002:a05:600c:529b:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490c2528b6amr153469415e9.0.1780779913470;
        Sat, 06 Jun 2026 14:05:13 -0700 (PDT)
Received: from ws-linux01 ([86.124.200.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm39444226f8f.34.2026.06.06.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:05:13 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] thermal: testing: Avoid NULL pointer dereference on missing arg
Date: Sun,  7 Jun 2026 00:04:18 +0300
Message-ID: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commands such as deltz expect an argument after the ":" separator.
When the separator is missing, arg gets set to NULL, which is fed
directly to sscanf(). This causes a NULL ptr dereference:

$ echo deltz > /sys/kernel/debug/thermal-testing/command
BUG: kernel NULL pointer dereference, address: 0000000000000000
...
sscanf+0x57/0x80
tt_del_tz+0x39/0x1e0
tt_command_write+0x115/0x140
full_proxy_write+0x5d/0x90
vfs_write+0xd2/0x480
? srso_alias_return_thunk+0x5/0xfbef5
? count_memcg_events+0x8b/0x1a0
? srso_alias_return_thunk+0x5/0xfbef5
ksys_write+0x75/0xf0
__x64_sys_write+0x1d/0x30
x64_sys_call+0x223/0x1dd0
do_syscall_64+0x97/0x4b0
entry_SYSCALL_64_after_hwframe+0x76/0x7e

To fix this, make arg an empty string instead of leaving it NULL when the
separator is missing. sscanf() then fails correctly with -EINVAL on it.

Fixes: f6a034f2df42 ("thermal: Introduce a debugfs-based testing facility")
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/thermal/testing/command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
index 1159ecea57e7..5513a26feed7 100644
--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -150,6 +150,8 @@ static ssize_t tt_command_process(char *s)
 	if (arg) {
 		*arg = '\0';
 		arg++;
+	} else {
+		arg = s + strlen(s);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tt_command_strings); i++) {
-- 
2.53.0

