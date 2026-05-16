Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A73E3C5D
	for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945033; cv=none; b=o+W6612H8YUT8AAfJfDUmqAnfkl8PJbIOY8RCNkeBDvS1kjmu55HFL3mFCA+FGN2e/ME9EaIQizO7IuhD0rMF8UooCAQgPTD6juQO+9FlwwQFIn02YlJ+7Egsj5q/kKC5PSw9Tl/hr/7bYmrmHmEFQu5ZMOyNg/ZPu8XbDuXykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945033; c=relaxed/simple;
	bh=4yj2+aZhJwSDPYMZeTnCB0Y62AmfW8gQ5CSgLzCMCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Btj5AZkGiZIYK1CYySY+eP/VMQsvEuPwnRjMRsp+nP/wBRwuKsnjKPzwERDZvIJGeChWjWkRn31EfM1KlY41Y0B8ad7gJHI2d8e+FGeIhYIZO9N4rWFJRZUr/qb7DlscvBesYWkF6pzpYSDB/pO8do0boEDb3Vt318J0ZsUGIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjitRO/g; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjitRO/g"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c80148ae949so281398a12.2
        for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778945031; x=1779549831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMSAU0/i2Bq1LOGi6eUSuoT4IlBYSFYcL23EMvbCK2o=;
        b=MjitRO/gTas6pCCibccij1hFroKU7rcqWxo+O/75yFf932P0GYohKrAjeq6YtdqZdK
         FxG//U06weHmkRWnAYesaejxClb5+rwPgO24a6DxJlbXYeobdOkiypBHKfd2w/wvrVyl
         2O91RSWpo22p9hlMXUn7CFIgolUnLXI4wDaB37OvEQsoZGj/jN+MtC0qcxEJsn45rX/J
         Rj5PowlOrS3wBuq/wk/I8d4PJh9GYhkJWUXyh8kTJLjkCppYIRLVBQGoDPKq6cLq4Yyc
         2OfuDEAv0S/w6BvSTf2t9HPYIJHrbrZiaSplxIXZGIDx23RhNGTQaQ8lCN6gy868AyyP
         MJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945031; x=1779549831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMSAU0/i2Bq1LOGi6eUSuoT4IlBYSFYcL23EMvbCK2o=;
        b=I04AZyQlv25Ed8J3YOsCZ9CNp+NXqEzvWgUAEdoWUk7JmxgVmF34zbea9HKCxmyjzK
         /zxO+Buc/Lb5Xgccg9dcbNmp/SSfgikjnlDVfYEKmogN2M/K+59xisS3Jnfrsy8+Y+CT
         sBDqLNJurDaLYg2kN4rf3kVMrLMgg6bTkV1hC8M4x8yiOQq1ZfXo7Q/5FcpkzCSYzLWH
         8WuJXnffx3lNFaik0hXRepKh5hQtC8236LT6jhMdIunO7JEwJ4CEjywc4wIp2L4AE3a/
         GUw3xRvXW1Toir9rr+lpfvktah7kzzYGlZ0ROwkrbuzfFUdfTGAdKjeafaxAySNfulwy
         7YFw==
X-Forwarded-Encrypted: i=1; AFNElJ8EXAcbXFl0rFM2So3JsF2sYOkXYIdJ/lL7PQfPWEbb2osng5NBQMNERh4RpBAKt+g+YRBbw6zESg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeQjKrAwvGr7YXmUZP7W4sykd9wRkXwLZJuXMzvccZK/CdKfX
	Z2C/ajfI9sLyKkQN/wvMMwoJ3BAULzymJdFeAH2Uy1+GRcg/JBd7lbQ=
X-Gm-Gg: Acq92OF+74M/hgAy2aVNS3UIA+ZSalIEL8LPbO7VvNCsH3uLwDLh0UFyll4nk6RZmSj
	vj3NfXZB5qIa77yImCwY046gvizs3aNsG60UiL6mgLMiCe+Xnh1cDrqpucGVPAm01/QQFTqh71j
	Bh1fhvjCEzCp3sZL7WlUHmf8I6Un9GjUb4UwrTWhHFjciajzbiUEBOszZO5ILPc2N68AdC+AmO9
	nrXWKQn3Azl76Fl0uojlT6lTO+m4IgrSUGhcVc3dJdIZHIru7A2K77994l1WpqaV7xh9SSwxX+P
	6im9+0+eO4LT3hvZhPnhWyEIhHB/iJaqUnRmCroL8XeQd6sfKxVzq0xSilr+c8vF8WeAHppg98h
	BkT7OLBiWNIKU/D35XZAQk4dCfIrAESDqoEiReKa8au2Nd8jwTiBMwdkVTDznD1/Pr0h6DpBpBs
	ZmKXvgsMMXtnFmUMP5Yrn7kpX5i+RPAzp0ou2Sun6j6w==
X-Received: by 2002:a05:6a20:12ce:b0:3a0:bc61:62e5 with SMTP id adf61e73a8af0-3b22ee0239dmr11096033637.44.1778945031334;
        Sat, 16 May 2026 08:23:51 -0700 (PDT)
Received: from localhost.localdomain ([1.232.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm8438364a12.3.2026.05.16.08.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:23:50 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: amitk@kernel.org,
	thara.gopinath@gmail.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drivers: qcom: fix typo in comment
Date: Sun, 17 May 2026 00:23:16 +0900
Message-ID: <20260516152324.1863-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the struct tsens_irq_data comment.
Replace "uppper" with "upper".

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..5e19c7588e03 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -27,7 +27,7 @@
  * @up_viol:        upper threshold violated
  * @up_thresh:      upper threshold temperature value
  * @up_irq_mask:    mask register for upper threshold irqs
- * @up_irq_clear:   clear register for uppper threshold irqs
+ * @up_irq_clear:   clear register for upper threshold irqs
  * @low_viol:       lower threshold violated
  * @low_thresh:     lower threshold temperature value
  * @low_irq_mask:   mask register for lower threshold irqs
--
2.43.0
