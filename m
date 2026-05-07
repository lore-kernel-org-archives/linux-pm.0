Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3D30B502
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131793; cv=none; b=JpSTw8ZeJAUEZ6bSqVFM58pVomfI6Pvaxo5mX6faFiZLNWmqbAOzRUOOUheSlSzn8Hnhp4KsdNVHXYEurRjFan7M8pZK5ndXRDxMJ8Uc6AIJVtD+urTJ3ldHJs7LPzIwR8aicGL7xa94PbfgFfhLF3bqdCdRi1naYm+ohxn4MUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131793; c=relaxed/simple;
	bh=OYJ214Fe8gwJAadCE/++dcXZEA3TLa3L31EQ5+z8/1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKEOcxwlsOQf/fV3Fe2EWoISo3Dk/+i8GA0yWD0EuzFUwNneW6XYtNyuhoJF6W0j0d8KPhjfQYXFt8llbat4qzRmeQaOB7h1MquOa9cO1ShzJ5nZU6kS0ylG+RcB5oFAdzEXDgvglkWQ+JcUnT2TO3zwJ4XpPLiM8rgHB+5CiI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FVcpL1UE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FVcpL1UE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab232cc803so2072775ad.3
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778131792; x=1778736592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCzQfTRK49IWaZiPW/ydQ0Qt+IWS1LBpwzZsb8SJN0A=;
        b=FVcpL1UEAdYteupjaE8rcQ5ucPhrRTo7GpqyYWu1bx60LXyldXhUlLIuZID7rpMSa8
         z47jJcetNBDQ6SwmYybpAupo34cNuz+W/muy2DhDKl/dmGV9K5r4H3EDSQrQfpVZFUAy
         E5FwHo9XXsrlamTnHRd4KyMfow8cLPfgwy7eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778131792; x=1778736592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCzQfTRK49IWaZiPW/ydQ0Qt+IWS1LBpwzZsb8SJN0A=;
        b=D07UG7WJgRaoAFhMWSEZbsZOJ3ckywfq9VJ2C1cJHfUAPh0cmKFj2PhWxuvmFbAzu2
         KVuJ6F1luadV+RfK2BMs69V8oaWJ5uUM2L9pdMtKc0a84t5i2V+Qi8zIq/GV65LS0uUS
         TupD7LWPMCOLQGQJZca2VqPG4CiflbbKg7Yori6uELcAFMoyt9Azxao6gdmXwM+UFESi
         z++lWOBy7ZF8dayJXjpP/zMDuWcnfaC5K0aD+cM1AOchMQLISpZhGiDhSSJBfcu0eD7Y
         7BLB0ZGjQpLraUGTgghio7C+BATdlK8O3Oamt23sb6TY6PVCGA8vHnSpLoBeF6Ec7cjT
         jckg==
X-Forwarded-Encrypted: i=1; AFNElJ8wz84kDy0bA/fLFBXCIx5/09z+5rSCttL7zkTBJMgLZJzNiIhRqbadweWQGr5RFlgxAK4kaEWoRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRSqFXhHbqrFQYjO7pmg3VnJKTVIg05LazTXUuYQL7sbaNB0X
	G/RBVg4ih2JlpRm+5I1UrMYvKHQlxkG62D6iEQfwQvuwIXc9Nkob45ToIhkjSCE50A==
X-Gm-Gg: AeBDietLltX52oAAxDsEFmufmtOUQFhELZvlEJw1aI31NV17OCipSWHmbtMk7iBYbie
	S7zXjD5y00HoJidDfdxJLTAW1RJpV+RjWCJGalVV7Fgjc8O0EhiLv+Anneijt2Cz1pTj2MN9f1o
	ux9UTqHkDSwK67bEfcxVXLj3KkweC4roJlbfWPAxGtAO/zVdbyImtur0yXvveuUKGHyl8Yyo67b
	iBwwEBDJci0iPXkAGU5Eb86EOqgkhX+2obi8OJoJunnCBp6k1z1qfBLT6qVrUoSAoiVo1M+W4Ri
	duhF2qWyqPvxAeeu/GzwHIRYS/hnPeKFBCL7ElY6LpirSutmW2YvuZywGvkRnzIMzq+GDz18uYG
	KlpK6THeIJt0N3nhb+C4R8A9Qr7zFaRYX9kbeiiF8gWWZ9k4SzdPZYcTJqca5/6R+rth4wypxLX
	4PPXxbTBOVxkHoBow72DviKoAvPDcwCkHgcK7YWXRQapGwML9n5QrDVREQ84pFZjAPXtcQ1PCsk
	R1Gk/bUyBn4C+l7nQc=
X-Received: by 2002:a17:903:390f:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2ba79285966mr62622245ad.5.1778131791791;
        Wed, 06 May 2026 22:29:51 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3117:fcaa:4a23:3480])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaac34dbsm11126885ad.10.2026.05.06.22.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 22:29:50 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: sequencing: print power sequencing device parent in debugfs
Date: Thu,  7 May 2026 13:29:41 +0800
Message-ID: <20260507052943.3133349-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs summary currently shows the power sequencing device's name.
This is not really helpful since the device name is always "pwrseq.N".

Also print the parent device's name. This would likely be the device
node name from the device tree, something like "nvme-connector". This
would make it much easier for the developer to associate the summary
with a certain device.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 4dff71be11b6..14335c4f813e 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -1043,7 +1043,7 @@ static int pwrseq_debugfs_seq_show(struct seq_file *seq, void *data)
 	struct pwrseq_target *target;
 	struct pwrseq_unit *unit;
 
-	seq_printf(seq, "%s:\n", dev_name(dev));
+	seq_printf(seq, "%s (%s):\n", dev_name(dev), dev_name(dev->parent));
 
 	seq_puts(seq, "  targets:\n");
 	list_for_each_entry(target, &pwrseq->targets, list)
-- 
2.54.0.545.g6539524ca2-goog

