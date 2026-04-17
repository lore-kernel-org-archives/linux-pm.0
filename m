Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049F3B389E
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435016; cv=none; b=gEfMaftsikmZO5wcu2hECUza8CktnGcVKj8J9/evRa5R++wPnkIBePlS8uxSbPv4lpPOinCtNYORX2o1uoLf7XV3htmh4t2JTTasRwlm3DyXL32usCkTWjsJUcf1dyTA2wNG9vudk7ozipp3ckNu4RKFRryNUM37asXrWN9BcMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435016; c=relaxed/simple;
	bh=NvpmBrY0ABsUPV1roWq6NJ54SzNCp+urB1Mou1gy4b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wknne73dmniiOjT1xxkAByD65cE0vHv9CRAZQ+L+ZhVxIVazzdKfCh/tZRsraQVC2leFaXcQvN9HBqQvw23BcKhf2SFMgZcZG06aaGymRxxzVvxroM2qr9nTBFkDyTEnQkCPvmdl2HqS75lklkmCu1S4DBkiMTJahTILKsGkSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJLJoHSI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJLJoHSI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so544714a91.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435014; x=1777039814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLXQ1g+JQhA9eV489mVjlXB/6L3Mb9jjgtdk7Eb7TjE=;
        b=FJLJoHSI2GjnUUDbmyrBCtOkZz2osbfNjwdgVbRT36/fFKxH09hVUgo5sNV8ZlVehB
         W9sH88qPVD9UvqztcVzXTIVd/hfB05H+ZNHkFQKLV6WvRcwM+aRz01Y+I/Npi26fMuG7
         fzxESg7PEQ7T2awPeJKEV3dMrsyC6RHufXniOmZHR6RBC2Z3FguAIdzmSRtyxStO6sYD
         +iU39CLx9Kr3BUzorb3iP/r7X0N/tNQzqfj/vKfypjrLtTmhh2npooSOZvYhyEoXgtx+
         QB81Tt4o1XXR/pE6CoqpiXluLT2GBiArned6Aw2ueAGHkgPT6qTe7HN+6XPo2v50k0u1
         ErfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435014; x=1777039814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLXQ1g+JQhA9eV489mVjlXB/6L3Mb9jjgtdk7Eb7TjE=;
        b=a47j7YvEHcEoWK0lRAdwl4HWDr9mVbykyQ6xx6gNX9klRdWqhvfyW3CST/FmE4fjWD
         gPsLLNGGO0FDoy+8BTtbPvUN7Z2gTkwNetK5mP8EE44ktew9WSHh43He1eLT6h5X1KCG
         DVrFvflLuYCxo/KL38zJCAD5ffnQlpHFhLcza4HQR35XyZDjwyA41IsjlB81Edm0hXp3
         rqT/xH5MD9nZnLLAHG/Kys5T0tO/FEo6PQlVYj7IA5aHYzL3JQwWOci/NqPHoFnYeKlV
         aOZp90YJUaA0TnN9aPXKajFkxEL+PXZMzHtZv6RjSKBLwXA3VQuz0f0F+yfcAvHcgC7N
         pfAg==
X-Gm-Message-State: AOJu0YxgVJzv8fpXeuloCKwwwB81yXwGYKhwtFhLEzb6tOzNoROdr0Qx
	qL8uNExuWpGlES4+TU/0qFdKv4GUMW+rbis8G0o0ZRriXiFuxt2Rvt1P
X-Gm-Gg: AeBDievvfCIS8J27Exprl28DcxePTuWx59kfG2Teb3d3vYB55WBJLOX5J2ssbWoTmV1
	DFjHPhrpylCe62Mfr83ATLzAh9BbsW9+Ry1XmIhQzgOl32/fqpkBUOWbiNaN73gFc2lI7v39qqk
	v5LBJbECNZyURkh0gW7oqdhQhD/MqLzvXvC+9yVDA7NEv2tjBTtNvgYq2ST0nNw2MLCRAK2xpBt
	os0rnksb6B973FtO3SohihTcSoPDRBvx6RuZ8i8cMpka3PvaL5RsoufAQtbEFrbEj1x7JXb3H7V
	1YWWUo2MRNmW41PsSegE2eGWc3RtP56FhWhn2iqq8tw2Zq7ZAMGo6j5fMqNcYxC0jwWIa+98WeU
	y/iMJ+ZZPt/uesX7AYhavE5EW3GtzgFNSbDyBQcIbgkuCGxoPf27eqoUoKHgsDlUMj0nlPsB0oX
	+Nd1zbd2ca0uL0GipErp4OlJo0tJ7RwByO22NTZwlw33FOd2j05remTO24jVuWTfaWYTnutYy0n
	KqtTDn34LqLEg==
X-Received: by 2002:a17:902:da87:b0:2b2:a267:784a with SMTP id d9443c01a7336-2b5f9f51ab1mr35266375ad.24.1776435014431;
        Fri, 17 Apr 2026 07:10:14 -0700 (PDT)
Received: from mohit-joshi-Victus-by-HP-Gaming-Laptop-15-fb0xxx.. ([59.89.50.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm20341275ad.23.2026.04.17.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:10:13 -0700 (PDT)
From: Mohit Joshi <joshionmohit@gmail.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Mohit Joshi <joshionmohit@gmail.com>
Subject: [PATCH 3/3] PM: wakelock: fix spacing and improve readability
Date: Fri, 17 Apr 2026 19:39:56 +0530
Message-ID: <20260417140956.55232-3-joshionmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417140956.55232-1-joshionmohit@gmail.com>
References: <20260417140956.55232-1-joshionmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 kernel/power/wakelock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index fd763da06a87..9f576809b5f5 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -214,13 +214,15 @@ int pm_wake_lock(const char *buf)
 	if (!capable(CAP_BLOCK_SUSPEND))
 		return -EPERM;
 
+	/* Extract wakelock name (until space or end) */
 	while (*str && !isspace(*str))
-		str++;
+    	str++;
 
 	len = str - buf;
 	if (!len)
 		return -EINVAL;
 
+	/* Check for optional timeout value */
 	if (*str && *str != '\n') {
 		/* Find out if there's a valid timeout string appended. */
 		ret = kstrtou64(skip_spaces(str), 10, &timeout_ns);
@@ -245,7 +247,6 @@ int pm_wake_lock(const char *buf)
 	}
 
 	wakelocks_lru_most_recent(wl);
-
  out:
 	mutex_unlock(&wakelocks_lock);
 	return ret;
@@ -264,7 +265,7 @@ int pm_wake_unlock(const char *buf)
 	if (!len)
 		return -EINVAL;
 
-	if (buf[len-1] == '\n')
+	if (buf[len - 1] == '\n')
 		len--;
 
 	if (!len)
-- 
2.43.0

