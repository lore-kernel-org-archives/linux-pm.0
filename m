Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EE38886B
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746713; cv=none; b=pAHNUW3zeA/FhFJM/axFdSCrDUxsclqgMFfdCAagKII5V+FDrrewn0YpHON1kSATcKSZJ0d2qeg9Zz4ONRjnFyJigCGU4Woigq4y2/Az8ACyywMD5aaHaDJrENnaE+s8iJx5ozeV253MPt8qtStHit0O/Hy88dr7HLSbc55ozZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746713; c=relaxed/simple;
	bh=/3drJTkAoSyT9HMCopKOWwzCA4DDLk9nvpn/kWsBuo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jRHRkgg672ImcxLQuJTUcL6Wiw284JIp3EayhmQqVzA+3j9GAhcpNd/p9z+2Psr1AsRCIG7hWymWJ9wQmtWu35udp2qNO6BkjhbZATXEtbKe9N9rK6EI3zY20uPS85ZtSuXl6t1wC1bi4imblISwkKAZqVNFjAAZMHTiVFYLjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIOY0oST; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIOY0oST"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49954b88fffso21845455e9.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788746708; x=1789351508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vLyGYK1rjMxKKIttwl0OglpXzNnjGoM3s6w9NqjDkM0=;
        b=pIOY0oSTJAOCwRFpMUWIE2fTuzioDnfELySWj5olnNd/lOSEaJiUZHWWviW8RNJIi1
         b2EA79AquwQT0J6s2v+5JFyUNGFi2k1nLa7260rb6yCnFyoJsDyMEpvyD8ScF6SXuJ7U
         V+7xYBzDB9ANqaJ14RiTLT3AWiS94vQpDP0vXAgqf7uk0AXzGj97xbijr9lMY3sP72hm
         EiOfOP976ofU0uG8WV3UovPUlWpoc9mf/3mpJMEZffjDOmcYV+WzQcwqn8uunRlgqTbB
         e8xveXw3DUQNtMuHf86RVe5m+bLW7okpi2wG3DsL8wLXFzhUVm9YGDCY726b/tdYU6BC
         IXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788746708; x=1789351508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vLyGYK1rjMxKKIttwl0OglpXzNnjGoM3s6w9NqjDkM0=;
        b=HpmOsL+VKrp8EjQZGTRVmvYjyZxmunexxWA9RSoIrFKjgfPHcEmyMWX4LGPL4ePO+g
         MFTtZ1XKgsJTwn9IfRaoJQZ7i0Znwqkaz6SgITcDt4nsZVjrCnubXvW8FxsgEtRRSjaP
         r4qAiW23wfHqIT10iXoDxCgojWapBCARn8byqnrUQVlw8BAMBsovGLK88EV3dPHyVKhx
         D8cvjD+K0NmPPKcy0Mc225oM9WwGfSnQ3ecux9y16JeK3zsVqfnjfoQupzdATeKDust3
         7p2RItBBXNbYgsYewVeQIutj84nJy0OvMHtj+Ri8z9+PUFIfGTJRQfYcXro/vPzwX09J
         DZjA==
X-Forwarded-Encrypted: i=1; AKwUvByMuKki8F5ZRb38UGCYAVQjnObRm4P8s6g9/geUhvDpX+VeomOw3AhL196dR6bmmmGZy1mbr3ScBg==@vger.kernel.org
X-Gm-Message-State: AFuF++k4ScGhoYokvHa4axOzIiUiziEr8tGBQgzLKqnjcKgwTmVbzd3k
	Vvb6ULSZOcHEIHqwvRMa+ui01b/3J/iv/ZsYJWfxO0QWFTvVp8Ibtmhi
X-Gm-Gg: AYBFou0Wql4LV+57XKN4Zmxhuoki+tmqXUa+crmVwFpbZdukz8N/iEheAJ0911Tkrjq
	KfaAoXIp98aeO3xJpcEP3EKP3D/HNWN6U4h8TqtwLJec5V8182+BWQUOjDoXGXS6fdS6FoeNfDJ
	5PtBO0wiYcuN4BjbE4qqjtE+oyBEA8KuiEuptqXmqB5geMkZKMGHr7L12Wk8qlWYGeUqTOzYJvZ
	iZZku+KuOOxB5pYd7Jc7UiyzxsthWB8uvJocEZuzwULiZWwvQwMdMzI3p1W+J8P4FleVhbANhH2
	nYIL/GRyPeDrYr+Uaa5F+G2LqVRvSKwY2cP1COHZAz9fnwotqjW6hLOkqngBXPLXGPUHl8+08mq
	PN/54ut9UjRsNxJYft6EFcaNnrw2WEpA+FBFH5kss1Ta4R2zkTSqtK6khLSF6wbtjcJ9IqQgVOm
	VB30mnclDqQX24acdI4mJJoQv+KNxyvnKX30z7kdFIQUFeIMPxr/NjJ/bkKrEjCRrWBtroDNXUs
	zOylKAwpEEsR1N0UWyXLit2xlYU3gTawBxEqOS3lA5ASrz/Kp5lmD4ysdghWdMmYhg28TPIHN+O
	QZ7g44sTUWFpgVt/ZfpM+Nljhshx+a4BMc4Gk7ATr5DANqpJD2UaukDheB+d9O/DH1pkr6TWxIP
	ul3JiwjzTQTk=
X-Received: by 2002:a05:600d:4449:20b0:49d:3a:e576 with SMTP id 5b1f17b1804b1-49d003ae639mr93352765e9.5.1788746707963;
        Sun, 06 Sep 2026 19:05:07 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-9daa-d59e-970b-f46c.310.pool.telefonica.de. [2a02:3100:b0c9:3601:9daa:d59e:970b:f46c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07a23e85sm152337165e9.5.2026.09.06.19.05.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 19:05:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Add kernel-doc for devm_of_icc_get(), icc_enable() and icc_disable()
Date: Mon,  7 Sep 2026 04:05:04 +0200
Message-Id: <20260907020504.24783-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/driver-api/interconnect.rst lists devm_of_icc_get(),
icc_enable() and icc_disable() in its kernel-doc directive for
drivers/interconnect/core.c, but none of the three functions has a
kernel-doc comment. The directive silently produces nothing for them, so
the consumer API section of the rendered documentation never shows
them.

Add kernel-doc comments in the style of the neighbouring functions.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/interconnect/core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 4aa991a54101..6f854375201d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -423,6 +423,17 @@ static void devm_icc_release(struct device *dev, void *res)
 	icc_put(*(struct icc_path **)res);
 }
 
+/**
+ * devm_of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function is the resource managed version of of_icc_get(). The path
+ * is released with icc_put() automatically when @dev is unbound.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
 {
 	struct icc_path **ptr, *path;
@@ -786,12 +797,32 @@ static int __icc_enable(struct icc_path *path, bool enable)
 			  path->reqs[0].peak_bw);
 }
 
+/**
+ * icc_enable() - enable a path
+ * @path: reference to the path returned by icc_get()
+ *
+ * Mark all requests on the path as enabled and reapply the bandwidth that
+ * was last set with icc_set_bw(). A NULL @path is ignored.
+ *
+ * Return: 0 on success, or an appropriate error code otherwise.
+ */
 int icc_enable(struct icc_path *path)
 {
 	return __icc_enable(path, true);
 }
 EXPORT_SYMBOL_GPL(icc_enable);
 
+/**
+ * icc_disable() - disable a path
+ * @path: reference to the path returned by icc_get()
+ *
+ * Mark all requests on the path as disabled, so that they no longer count
+ * towards the aggregated bandwidth, and reapply the constraints. The
+ * requested bandwidth is kept and restored by icc_enable(). A NULL @path is
+ * ignored.
+ *
+ * Return: 0 on success, or an appropriate error code otherwise.
+ */
 int icc_disable(struct icc_path *path)
 {
 	return __icc_enable(path, false);
-- 
2.53.0

