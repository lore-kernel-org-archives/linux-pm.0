Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D367328B62
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973531; cv=none; b=imckVvehKgsrBZ7sQxNPevkGOEWkZAQ6t8G1JbFywfHTpfflMYrbBgTlgAlrQVI1Lvg95ag1uBgisfSfQnGnek0z3Hhl8w3XqTZur/T1xNp8x4TDzjxROcUYJQ8aYoNq3J3yIJ4/owW19iwZUU1gtQNUaN2BKaIoXwzenSc/2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973531; c=relaxed/simple;
	bh=lW2baFvdOp8T8qIYmYG510KFhnL7nWjspdl9Q2bQKTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiSErjwzsnkOQq+HiBLObmTEVDlIawyQWQPulUvzN+WUL/LyOYK3ZeMI2BIPNAorQM2jO6M61vLANXwwviJIAgzZRTpopmxKDJDZszRTYw/rrRrKCKSchlaYUaqKD80SPXUoi4Ohu2DawPc0IlGlFTvmnV2klTGzWIXVrjZRS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niwGUIYc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niwGUIYc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so48148475e9.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788973527; x=1789578327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxdZRvXz8X1My70IJ3RwMner0dA2d2QTLo+O2qcpmmE=;
        b=niwGUIYc7zRKRwOCFQViPVK/AaddsSLpmoQQIIJojBI0R59va5aaoXZq6FHAFoWY+o
         Ro6XD2OhjQKrFUkoTjE2OjvAk7SWP3WBGcWnIvbB05sMTSpKrXL+iqU+C14CgE1KKW/a
         5sz/XF3H8kDYW7UrtPKjNbbUfCN3iHNxDS24fBvzCR48T3GPYICNXAp2w4B7aB2DggOJ
         urB2tJRybQyZ6YijKWLfSGN3mvCA+6WiKnXvIUOEjIsSnIyYz82gQYp4wbQUORGET/pm
         Q1KA9m/0KuaBfqvBAUcypW+8z2ljzAe9tjULHDMSVYybcc7fi46ayhbLAEsGsBIz1vTp
         zqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973527; x=1789578327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxdZRvXz8X1My70IJ3RwMner0dA2d2QTLo+O2qcpmmE=;
        b=Ff6+cIkiGNZvuMExL2hM8JmIeJZgrvgNy4DhKiNannjMxpqu2Sf4Q8qWpZOP5lbUsz
         4SbSYY42njvo3qNkbwjkqzKsxXASqdNrg5VxeG2H9ZaHv1z5TfYIio6tN6HB8FM37Nxg
         aCbqKHKFO+iyktLJZWwrbeUS9eSsGdwMICoP/dp9Sg9q4rcqFEUsHRHMnyO1z7XnXhGr
         uuIe6q0xXIEO+6JWAMo6VevY1n8bJekqf36UbIaKwMnU/NqR0FlaiXltbGdb76Po+M0E
         uGSoubzUFZWyqZQ1WtEyTW4d1cOpbJboxFYa7uR4E+J5U3M/eDX6np1NjusuNoH6Cpa/
         y5pQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuspY7QQ7/aYqb+iEizhLjXagf0B5neHU/YzoQf9RxxDGinGWJSI1v+esLyLwQBZzFB0ssgaI3zw==@vger.kernel.org
X-Gm-Message-State: AFuF++kq7vcaPi0lCEKMoknVKDZEmBC/N3cFhJnKRZmvzuQdiGLAg1tP
	uPw0liJ4v6c7U+0yt89ZQ6ql+5BKKcBa7MhkQDfJWnP0AcdwqZD+Fh2H
X-Gm-Gg: AYBFou0FduvGzt6+MmonX6ARCjJjQxFDbc9WNMZwkT+AWnEUaXxVx8AHNFX86qTIUkX
	BNkCrDmnSd5vmEfN/zTJqE1tsngwHATxGA/qTnl2Jy0+hwqQfDOIfkC4LH7iQoiDXAwqhhpnENL
	GT/YZpha3rwTYqogFNzpHRUTuPGyGh2wxULtoSD5vl9IYZtDMuSETuxtXyZJK0bLW14Ry805PFN
	pv+erZ9DG9eYxhVwfyO9ggdsqquj9zfY0TKJ3JJHVXPYIdch12/uh+fagkVYuGVSGHStCtYb/Xm
	Je+Imddj5TSWpBj3ai9panWcYs3zPH/uU+CIm3CQBquANkKuXdsF9rWJ4msj1zuNIJm9j0VqFwZ
	hJhGVR2jyOTwB9rWmnnwKuYYqcyXQQt/zLbizCIx9WD/U9YMGlCx6S1sTcKv8/r/Qkno0YD4CMn
	8HcQpFQtYHoOO4Yzs1n8f0UyypPaV4USwHZhjbzO8/JRgrGEJlIudsO/5eH0gRX00JcCJpXVHqu
	LWfwsjmV1+NLJ1t43XSWRedSK/ecP5lRu42DBcD8xKEPIcjhZ3fF8ER3dpqlMKJWqnUmypgTA==
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id 5b1f17b1804b1-49d0e79635amr218836585e9.26.1788973526639;
        Wed, 09 Sep 2026 10:05:26 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfb5sm4719445e9.5.2026.09.09.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:05:25 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] PM: sleep: only allow relevant powerpc platforms to enable PM_SLEEP_SMP
Date: Wed,  9 Sep 2026 18:05:20 +0100
Message-ID: <20260909170520.553867-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM_SLEEP_SMP selects HOTPLUG_CPU, but on some powerpc platforms, this
creates an unmet dependency such as:

WARNING: unmet direct dependencies detected for HOTPLUG_CPU
  Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
  Selected by [y]:
  - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]

because HOTPLUG_CPU is only available on powerpc platforms IBM pSeries and
PowerNV, Apple PowerMac, and Freescale Book-E.

For powerpc, let's ensure that PM_SLEEP_SMP can only be enabled on those
systems that support HOTPLUG_CPU.

Fixes: f3de4be9d5f8 ("PM: Fix dependencies of CONFIG_SUSPEND and CONFIG_HIBERNATION")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 kernel/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 71165e7f04f4..7cb6495ffaa0 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -146,6 +146,7 @@ config PM_SLEEP_SMP
 	def_bool y
 	depends on SMP
 	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
+	depends on PPC_PSERIES || PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE if PPC
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 
-- 
2.55.0

