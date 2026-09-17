Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3750EBFC
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651810; cv=none; b=CMHHKXfXaLyFXuAgk2qXmrM378U7mHyiqitzLJOh901/79XQIjcVufw23HT2g+pGip4z3BntsX5Y7slkJqEafb4x46CvLmNFqf0v21+vK6eIIzGpU1C3IhssfNpf3lR3RAsxD7Sx+wdn/SgnfEjz+wtOjFGOjx73puJpt5zkFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651810; c=relaxed/simple;
	bh=m2UU0/l7oXH4nDDm4aNiVdsK/0ORRSvCe00W37MZM54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0PGRZ2ei65UePwWDVTKIkP+Y4Jv3qQuverm6RbNs/Y6kHFn4FWzHhGfdNnVOIy2HoFeQq2pB8kcVFs1r2FA6Lrk/qB4WirqygxX5RshZMiN+cisxYgPc9jg7R+F0FOZNLe6S8o9QIwcTIt+lq90v44Z0QvObYJznoTn/3AdWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=EkGNaUPH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="EkGNaUPH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so4679445e9.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651798; x=1790256598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYqy4JvgQiRzCuvqvHp97HhL8V2ft2LLYeHwmXteui8=;
        b=EkGNaUPHk0gCOURnQPHeX9tSlGgDfIPzVjd/lnLCeRErwDbYKU4BQDoajk1jwvDy+j
         NBa0QpS7P47So6cifHV8RRnY4WadJVeszl2Nsf/8i3nDeQaYjMKCeYOKSx/hxBSomZEw
         rnXazoXlGfmpepFfToUV0s6lnvTCkFMMCgS0Sbq6F9WumcWYWyg2Ub8WXsFqfXytRoQi
         L3cvrslXCgqzO0zKviYkehDLwSeO/HZoMBgY3yFjoykyymVLXNJDb9/E4EBlJximhl5g
         sxZyax/5Kt5VChk4VBXhKrYXBnpzeSVI7OxWa+FFL8VhNit1cwxjtoO4pKQXtIZjNL5C
         X1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651798; x=1790256598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYqy4JvgQiRzCuvqvHp97HhL8V2ft2LLYeHwmXteui8=;
        b=vs65o377DD/aE484nBYGFP8UhYQnZP9g2/8aWCNAYTQSyvlYSUu4OHl0zAMKcV/hhx
         6iVxnIKopBNNlISuBGzZd7LhGuz7BDRSqhKo07tj34fg0fD8Aecyf0zLqVcRYIdMcKrt
         3jhRqV3z8oXmQ58ki2dNyZ84f3yRpqiotDM5DTzhKwWnyuhIFE6fo6ikTWluBBUdH7y1
         famYx2I0TUm/q1/D1jPl0B49FzKIBRtG40EmT+/eViW7mjPMN71yvkPyrh8QtEQ46vfK
         rFWEqdeJ7JAXF0Wjqbe02/HlwP9JP1bqc4ICjfEvJxqIV6F7Pq/HqRRXpdCHrMwRUfHC
         1LDw==
X-Gm-Message-State: AFuF++laL6lTL8qh2CLRCeOEtJbi6yvbILbSMS8GibjBnHUqhEwVj0q2
	JL3mZzQK42yrvtOIce0UDxbgfQbjcQvLX8O9FaTHJ29VBy5tvfYhphy6kmmp7yy9KFwTa7veWe3
	czNbq46RP
X-Gm-Gg: AYBFou2/2V0DQgk/cFcR/jRC+qSh8KBeOqsSTM7l2MPuEbckeo0OHcAE2wPNFBSEdUb
	OJpmwk3zCK0BrfUFEqD8vWJwqkSlCME3wosRZtPGP8l2J93qNL5qVR8qO/be+CPUtVTbAbeadSc
	whZfoL0V+heHKOBQ0tQm6n3sfC68EPVocNKpQfuvDWTbicFcc+CFDnKyH5kw8M9Q+bg3JxAk8fY
	c8kOoia4cfjEZLsPbQ2O0Of2lKM5D08LFFmC9K57mv17Nih3+Xrcxayy0Npkrg3zy4jm5MQ/FU+
	LduCR7wS1D2Yj/rMe3LZldZdsdh0l84WGPhOL1kQY7mf6KzpHw3ej5M0HhFXJQGSWssq4Vpico8
	oibDKOSvIeA2ZARs4kIJYCRkxSAJYchxPpPI/SPzk5quClrgtl14AIVHB7V41gQHXBZbp5XQK4C
	yJ1X16ej8K3RGTHAu8rqL+oD1i+WpQ8Ti4i+gzo5zFVh0l/yRNlWrf5HmlEcB7GugucLYW/i8s6
	heZ3SdHKS3zvw46+YkAcijEkuM=
X-Received: by 2002:a05:600d:644f:20b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-49fc199e215mr12253705e9.28.1789651798061;
        Thu, 17 Sep 2026 06:29:58 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2356d1sm97548275e9.6.2026.09.17.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:29:57 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Evan Green <evgreen@chromium.org>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 RESEND 3/4] PM: hibernate: permit encrypted snapshot device under lockdown
Date: Thu, 17 Sep 2026 14:29:49 +0100
Message-ID: <f237b56e8444ea7b477dbcf4aa6dafd2ff0c1dc7.1789651778.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789651778.git.sean@starlabs.systems>
References: <cover.1789651778.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdown disables hibernation because restoring attacker-controlled image
data can modify kernel memory. Permit opening the userspace snapshot
device under lockdown when encrypted hibernation support is built, but
require encryption to be enabled before image data can be read or written
and before restore or power-off ioctls can proceed.

Tested on StarFighter MTL with lockdown enabled: encrypted uswsusp
hibernate and restore used the snapshot device path.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 kernel/power/hibernate.c | 8 ++++++++
 kernel/power/power.h     | 1 +
 kernel/power/user.c      | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a95cb447a13a..0b8626bdf81a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -114,6 +114,14 @@ bool hibernation_available(void)
 		!secretmem_active() && !cxl_mem_active();
 }
 
+bool hibernation_snapshot_dev_available(void)
+{
+	return nohibernate == 0 &&
+		(!security_locked_down(LOCKDOWN_HIBERNATION) ||
+		 IS_ENABLED(CONFIG_ENCRYPTED_HIBERNATION)) &&
+		!secretmem_active() && !cxl_mem_active();
+}
+
 /**
  * hibernation_set_ops - Set the global hibernate operations.
  * @ops: Hibernation operations to use in subsequent hibernation transitions.
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 815c84c1e0dd..351b5f68bde3 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -168,6 +168,7 @@ extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
 extern bool hibernate_acquire(void);
 extern void hibernate_release(void);
+bool hibernation_snapshot_dev_available(void);
 
 extern sector_t alloc_swapdev_block(int swap);
 bool swsusp_swap_range_allocated(int swap, loff_t pos, size_t count);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index de41f590c98d..b8d3342f1548 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -184,7 +184,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	unsigned int sleep_flags;
 	int error;
 
-	if (!hibernation_available())
+	if (!hibernation_snapshot_dev_available())
 		return -EPERM;
 
 	sleep_flags = lock_system_sleep();
