Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764B26B2D3
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783781590; cv=none; b=ph3PtIQoCb3jLzPrQxkr8jG6O5UnYKryOBKS/oXG73SQ7v415vDdsnA/16Pw5TcQdcFdB5NpydoVMQ0AJiT/e8eBghhJOSgcGuXBwW8PwLQb/SOGipOOHSFdE1TfFMcmw9k0idOkLwAcxnaLGMdXPBb/H8k+usYkTZCtGVtKJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783781590; c=relaxed/simple;
	bh=maBxh30Ot5sGG+NXT7NhtFKTb4zNy9lYAwyOnjvsjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RN61+5no82UyBgL1Yvl9u4ordMt5phJSU6c3y2TVpQd43I/gHisaqhe+pJSVIY9smJ6EEamXVejIqkTSh9bJU26NJPmjqVx+T4H0nRK15SPEgcwFTqrn7cNjeHAxz7EUo85lgNypstJy4mKsOxwsagpfYjwyTa7iZEq9zLQhQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTGQSiQR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTGQSiQR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381ed661712so2279844a91.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783781588; x=1784386388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VInIyLRCaI65EOZkEY6bHUdgAExKI+1x+V4m7DQD6xQ=;
        b=GTGQSiQRmvswBYRLKioF4RkxcwprpXfElY0/SEg+3AoMJBKnhmluvLUa9MsbMSugfy
         bvCq0vWplMF9QgRLSxduSE3vS+vp8erwXKoc3kKE0WINW5wav8EOaO4MsDJ9JNz7/TXR
         yrnug0hdMboVjIXlnsUV/m1KMISkoy4kRdYa/PRlEgEhwevsvY69OBKf+mOURFuOAbhi
         XTbU0SAtgMStWuQXIxjjRW3zNSQhtHtdn4Z8svZGmut/e3LC+ZA6LIHO+QN5Roar5kYh
         NetxqEJP3D0meaIhws6VLtZECYO1tRPNOFoGxCbcHsFJJv0t2/kciy1Vt0LvO/y+nYkD
         eR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783781588; x=1784386388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VInIyLRCaI65EOZkEY6bHUdgAExKI+1x+V4m7DQD6xQ=;
        b=N8bE+sbMKBoYGB2WHsFAE4H1B4PMZ+nvGoBw2xTv8q2ohhQVjJ2HsEOJPKSalzutyG
         pES4PAw8tkPbE+GhTuSVQNsECLu4T6FzarHz03NEbAInHdeblVkE8YHJ/s4NWFALbNCP
         Ib/gU2vIZjO4m/LZ6iq2wVPk2hraHxfMYEH8zB3Egshy3II8ARAsMlD2GgikU6DVBMFr
         j2ak3I9thqYHbfr1PRrhrn6QKmci1BH/WBwU8rSct+5zGZrFo6uulXpx6cfvChQ/yZLS
         YT6EenByHtASY1JE0s/1PkfjJfb/aU4BnfrftpxtTXdSzjAlSCf85d6TRKWWPVUrHqK8
         L4Zw==
X-Forwarded-Encrypted: i=1; AHgh+RoW99zbdCQ5THjVhv9w5uUzW7VLfvl/lg0DfRW7Hb5HsYxSTr52bgyImnHI9uFcWjgX1plB51QeWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPVO9xV9RmwyKfOUgrU4onj5UjzZDcprKAha7nWIjMyCmbuzD4
	9NhG5v01yS86YO++P9UeORW8gK7k9jdBQAByRa+Vh0cKXwul2UuV52Ep
X-Gm-Gg: AfdE7cmSE+wduUMuQPGk9paV7lk3Pvj89/IbAmbsyPxNAqAH8qyp6O00JaYDc/nlyVd
	AnMsMvMktnhlBkDXvSW1sxxnHLpDxXTWSAYYzoPZsWqvYqxGoU8yO9dLUySE4JQpJKDEESHFW9r
	7qYoz4ETC0dkyA7aAxW6S9NIb6W5TNLxxU9R2IQvzaILMNra/2kD2XRWO40+ecI1US/BB5y3lSW
	ALB3Hn9S8WMIT5tB5eoyNuFieYe6jnYEc2n7C/bTber/iT97Ay+YDH6cEDrs2e8ulNcWuBQvCXB
	OXosLCX7YNAQlmBfgG0Ok8vuA++4BLd9T7fU5onrDZxQ/HJ1sobL7VJtFGU2X0ibmDHq3zteqCU
	+k5LI1BVdjJ69tjjkNC1uuzK8/w8q1EgKlT7fLBnas3vQMdfBYFke07qncNCrw+CpJzadnj1GJ8
	mjGwhHcG5A2BSp2H3QvSaKkMeC/h+nhi/1rmtceXeQB9RLSHB6uF+FLIrX
X-Received: by 2002:a17:90b:164d:b0:381:21ea:912b with SMTP id 98e67ed59e1d1-38dc74c4c37mr2726543a91.1.1783781588260;
        Sat, 11 Jul 2026 07:53:08 -0700 (PDT)
Received: from fedora.mrout-thinkpadp16vgen1.punetw6.csb ([223.181.49.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm53449794eec.11.2026.07.11.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 07:53:07 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: bgeffon@google.com,
	rafael.j.wysocki@intel.com,
	linux-pm@vger.kernel.org
Cc: mrout@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Fix memory leak in snapshot_write_next() error path
Date: Sat, 11 Jul 2026 20:22:45 +0530
Message-ID: <20260711145246.8625-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When memory_bm_create() succeeds for copy_bm but fails for zero_bm,
the function returns without freeing the resources allocated for
copy_bm. This results in a memory leak that includes radix tree nodes,
zone structures, and page lists.

Fix this by calling memory_bm_free() to release copy_bm's resources
before returning the error code when zero_bm allocation fails.

Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 kernel/power/snapshot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d933b5b2c05d..4a73927cc55b 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2797,9 +2797,10 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			return error;
 
 		error = memory_bm_create(&zero_bm, GFP_ATOMIC, PG_ANY);
-		if (error)
+		if (error) {
+			memory_bm_free(&copy_bm, PG_UNSAFE_CLEAR);
 			return error;
-
+		}
 		nr_zero_pages = 0;
 
 		hibernate_restore_protection_begin();
-- 
2.54.0

