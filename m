Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30725A642
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542290; cv=none; b=gi89E3t8bhXv4qwnxOTydTw26SSGNe09o/SPB1uf3F4bsrsIxOM68jU3qTJuQTK4fsmqBjzQVENkZVZRdHt5G3WB36uZkhBYwr1OmT9GhpVJ967QCx7Ncr3xGVfznoLzHW2TLmUOKjfJg54BMVmoi372mdYg2rhsCv2u552e5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542290; c=relaxed/simple;
	bh=CZCKrxXEgvdkEh/Sae7MgTomn3ZPrLlEG1hbRDak20A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9fT6oNop/AGP4TliThQNckkTmKWaPwpnUWD3cdSqETJATcQzd8U6wj6DJ6fg8hR8dzG7beMyAgEU1c0HT2gcEOjpEidNVlrJXx6HMKRwFG8BWZ0uo2bu56JG/HDjaTTbgRv+iJ4OcrW/jhv1oWFJLdn6EBDU8b9o/cvTqsB8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRVrW4lr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRVrW4lr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caea3f742bso46991225ad.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2026 20:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542288; x=1788147088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFrsmmlSYHb7sUcLIy0ALhfjp7FP5iWgM32VwHTY2aM=;
        b=CRVrW4lrJVnnARil+8RnkJov+lJYQcMeVKNHfTdPgZcvzPFlsCOv8XronmTLbJbPrG
         mAD7mK7un2OE9hO5ClVtkmnDLVvxkhxhGOY8FNqVKYxxUwIsCi/twxWYAZKp5q++h8Jy
         +7OkwPWubKrQiDVeaQ8muEVO9mKNVlyR1k8baV725M4xFLui2TbNs+fln9dBfu8Wl1I9
         5SjM0BqdkIvHtfRuZ6x02nI4W5dzO3A+arK4L3M/U/DQ/CkkbtAZCryKYlOIgpRsv8ZV
         ukH9gtftk6wyxPv3HTRgokVQnPg8I9RTTloCutCk1I3NQWUFcDUb1nYdjb5zYGkB7sa/
         gU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542288; x=1788147088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFrsmmlSYHb7sUcLIy0ALhfjp7FP5iWgM32VwHTY2aM=;
        b=MrJLNitry7uAbBpCPutAkSnafQ1Vt5z7XFJ5VVqt7CdApU46Gjw6UtyhHGBwdKCGTm
         411kzBiKQ38NUm0D29Kq1zgfBbJWLmlfALN+QWnQUpcn3FAr+Wvm2Po2WJG6EELr+SYP
         kS4uXUw6LaRiPI1M+cSWKeJ+obIhTrnMgtCAqoCJRwBjk649Z7bIxywns4PBkPvafoxB
         z/ksmDS0rdWULLeJYhOH/e0JBSJW6ROSxVLahLfOnH7Ddu7XouHs5NpAyUyDUQgknjBz
         Rj7gj+r0be96XQjKUSfSDMpH9fONd58gjyPdoANHp9l3LKOslaJ08WvOzRZ8kLBIzZH5
         5mnA==
X-Forwarded-Encrypted: i=1; AHgh+RoMzKXamdOuo5SGiTD2X9j1jdCusLhEyg6s7uh/5Uv6VO6eXJcRFGwwfAPZRnQhU2NjYQGpCdbndQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l3SrMeRChH39KxfhmKqy104QFvXy0BDPzaUlGuN1KDeh4VMRvz
	4mQYBuJlIwI390Oztfz4a62yY3aODF08ruu9/oXKJL4tD5Ky7m992Jjc
X-Gm-Gg: AR+sD100w64rZGrlBzfLQ8EDRlm98PBKzRg++MGj8UL+gWZFakZdew+yOxZGdYrE6RQ
	+xIukDekjKtDNnPmkqSuvewFYVGrI0v1KwBe2ijkbbK/Abn8IfdkJrNRJ8/Eec7Ujv4ALkXdotV
	8PGHfj155B8UTyLbGDBiDBWVLF+QE8Haedbj2osEP9kF5LBBnDlhDtyeRZxJc3d8S1wURz+7Qu5
	tOULuG86vBAa0jcAYb5Z6yLmQR0dboDbJ4t/gxm9n2ml4oVf+O/6/oRtf6BQQFu9/mBMC/m3c82
	M9MPk3hvLQVtb4IvZyaAxBZHqQ9yW3XBsSlwaOrDCNfcLXHyVq8rS/903hgzfkYU75Ib5qjio0c
	EWN1w0P3XU0kSE5mtpxlXXnHvxTDQ1/bcXOEKrsYlJBni5XjoILbb6rJ+8FHjNKfmPXmyCGzu+w
	ahCQZIqyZC6yVijJQ0U4QvzrpJxcMJyehr1W+mNpc1XF7arAqlNSbDJj6tPgyX1pn4ceZ357kc9
	N665VU92mZSNp3L2RMBYg==
X-Received: by 2002:a17:903:354b:b0:2d3:2e86:647a with SMTP id d9443c01a7336-2d64af6f896mr448583275ad.5.1787542288096;
        Sun, 23 Aug 2026 20:31:28 -0700 (PDT)
Received: from Alone ([2407:1400:aa0f:29d8:c1b7:3f39:4ae0:ce0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923615asm21037150eec.29.2026.08.23.20.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:31:27 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] treewide: Fix typos in comments
Date: Mon, 24 Aug 2026 09:16:07 +0545
Message-ID: <20260824033107.347011-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 arch/arm/kernel/cpuidle.c      | 2 +-
 drivers/base/power/clock_ops.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index fba1f8bb0..784457ac7 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -79,7 +79,7 @@ static const struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
  * cpuidle_ops are tagged __initconst and will be unloaded after the init
  * process.
  *
- * Return 0 on sucess, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
+ * Return 0 on success, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
  * no cpuidle_ops is registered for the 'enable-method', or if either init or
  * suspend callback isn't defined.
  */
diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e82..3b8ba2780 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
-- 
2.55.0

