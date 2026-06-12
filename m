Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D5391E4B
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245545; cv=none; b=JMkciH5feFK1H1ltmiizIAP96d74cBDgX8NFsKqh5HtnkDW3uNWWXsLxNq0k8jY2/1QcKl8HYPx38pQQyN5hhMkcQ2flBGgA9AGaZ/qlvzTEUBIYXpnRkygTJX5QVnJDxXI4VbVeDT0i/YDBh2jkcMNroYAa0z0/q2vGgarm4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245545; c=relaxed/simple;
	bh=eDJalkhcwszTgqWkt5k6Xiv4V3wvMrx9KlBasD0915U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT6KalbV0vhPtqagTVo2UZ6XHdbKYplinLcebgU9BEY9hXd0cxv11iozZgOFOGKJIK6prYDZZ1HfDpYgTu2nFJJMI8h6kG3k8QTDDIx+TNcOf8iP4yaA5yj4Z3ECyYEQd/h7rZzDpTHjrzGZb3vD6NDQ/FVTpS4r2cbZzce5+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKr7BkRQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKr7BkRQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso3787235e9.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781245542; x=1781850342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7iYg2CGSj66UuoTzJIguPRNGdJgDxZ5bFJ2MXxl5FU=;
        b=iKr7BkRQCEIMdbmg109iupOhCDzIUsZP65HS5Xf+OlRU1aZXCAYGLDBxmbQ6dVJtvM
         20XMJiTaP2INWbIAKNklqtTTtdZyzNvxc3P2bF4WuoUtrowqpiG9QLYRH6A23jase44h
         4hejb+2u3Upc//iGsNLcXhCx76FzVMLtJeIqg0XQLIngxe3P0Yc6QeMpfTtodPoLk49q
         zCRieJ7cx/e2jXvd/HNb0+3PckleSfYkqnKXuDVxwjSBs+b8Qg053dObGhJgnBhGKUeo
         H/tAAlesNTAGHOT3qqUuKLbWaMHPMs6IJzWGWLtRzar9iUsiyIwUNiPyEreiU5cDx3lo
         7Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245542; x=1781850342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7iYg2CGSj66UuoTzJIguPRNGdJgDxZ5bFJ2MXxl5FU=;
        b=tE8xhlK+rnSDsKPir+rV75DJHs1nTlj5k3xBKx6YXJ2sOARQ/fjnHmzcO81zW4pGn6
         lf/T3fTOJIsbpY8IVv24lD311sCGHNGiGWYeB2JwiWZFgoIvfdtuv06D5CvW4DbLwQZO
         RwIZF4LcyRlJzChzHHwgBSGqXrqKncJdE8qaKv9aGG0TJR8DPV/5Op7QsS9TUbvSDcQ1
         Zkj1J6TfzBwFbYe3oik8TjpNKXxHsoj0wLF+L5Pd4/5Y1MaRvLf0axyLG8ts7PpcEo7v
         F1CZkytWwq1vL8eA15lSQFCBjFvjKIdOZ2dY/uIrMGcITaP0HfBasJ0YvrCUO5nw1HzT
         aPjw==
X-Gm-Message-State: AOJu0YwmASACHzsKH+cNIkLx31dUqoYQfyMWGAwACDtHklgII06U4ymi
	BeHQqnihWzVNVcS++ONkMWkmqgmZ26Vl+yBNvQ8cr3FyFuT5/GpPObtPoKif3bKUOzM=
X-Gm-Gg: Acq92OG772g0q05nhJRVvtBRHkdhgG6DppYt2hZ5mXNyfv471CtaGsfRJ/QE+YTTKph
	yg6SEFZkV/psr5wksUkilaTEazZfdRWLOuPQ2YzVW/Yd58kGPDGdJemOYSDj6uaSBqJFwbeKPym
	dEDtKVkRh7csuiIvpcGXTumVe6oZ7nrz5ezrkaaZKse77McRyZ3psRZcvcD6yuY5yIFt0OENGmz
	FnZA7GkKOIoyw6sRk5nyAoASefBAh+dVvuPCD2xqqyoi13H+4SvWVs05vmarHznQjTXJvc37vXd
	bLpdrN9V+kMvPT9WNVhrprd04eHOYBAj00aMoqXOmExy812QlYpJJrbs6pd5tZjrW04zAQ6CbG1
	LfRbvf98Z0eMJ68CnF4zT2EqXi7fj5WNwr1mWMdTXhHAR/9NzMlPrChbiV4XS1Fmo8rNDIAWxnM
	/tXO2zu1T392aFf3mpuMBpus098t/S0i07/K42HD0r8Uyak50ORxR1T2i7CRFOgf1nqz4ZAFdHs
	7iUAFVf+ThzT0VwePgKKTw1f/oNR4X1vrIrlKpzbWnOig==
X-Received: by 2002:a05:600c:500d:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490ec4b6176mr16866885e9.12.1781245541950;
        Thu, 11 Jun 2026 23:25:41 -0700 (PDT)
Received: from MBP-Elazar-Leibovich.civet-hops.ts.net (bzq-85-130-200-168.static-ip.bezeqint.net. [85.130.200.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm52501375e9.11.2026.06.11.23.25.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 23:25:41 -0700 (PDT)
From: Elazar Leibovich <elazarl@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Sivan Zohar-Kotzer <sivany32@gmail.com>,
	Elazar Leibovich <elazarl@gmail.com>
Subject: [PATCH 1/2] powercap: dtpm_cpu: Fix out-of-bounds read in set_pd_power_limit()
Date: Fri, 12 Jun 2026 09:25:35 +0300
Message-ID: <20260612062536.9147-2-elazarl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612062536.9147-1-elazarl@gmail.com>
References: <20260612062536.9147-1-elazarl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sivan Zohar-Kotzer <sivany32@gmail.com>

The loop in set_pd_power_limit() looks for the first perf state whose
power exceeds the requested limit, then uses table[i - 1]. If the very
first perf state already exceeds the limit, the loop breaks at i == 0
and table[-1] is read out of bounds.

The powercap core clamps the requested limit to dtpm->power_min, but
power_min was computed by update_pd_power_uw() with the number of
online CPUs at that time. If CPUs have come online since the last
update, the clamped limit can still be below table[0].power * nr_cpus,
making the underflow reachable.

Start the scan at index 1 so the lowest perf state is used as the
fallback when even it exceeds the requested limit.

Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 0a460f97bf15..5e06909ae4fc 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -54,7 +54,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 	rcu_read_lock();
 	table = em_perf_state_from_pd(pd);
-	for (i = 0; i < pd->nr_perf_states; i++) {
+	for (i = 1; i < pd->nr_perf_states; i++) {
 
 		power = table[i].power * nr_cpus;
 
-- 
2.50.1 (Apple Git-155)

