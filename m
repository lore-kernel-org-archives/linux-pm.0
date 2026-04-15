Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592F3EB7FC
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271905; cv=none; b=DOzZ4LTFZAnN95ADGnDyPGkYfZJplRPQ34iHQ6neOQwbei6uwS2ub41Gk3bBETjooe5Q9NjAdk9ziHvVHylxbVMaRVwzX8oOuRzgSYEFgKSnqAEAZ3OaG0UjRjSU1nzdPK6UJk3Vlo0I978/RCXeqAH2Wqj1hXsdaCtGNaNFyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271905; c=relaxed/simple;
	bh=yVW09HBoy+d5XgL2WCG8yL6PIf/AuxPHvhhRzIY1De4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKg7X5MPSJtjK7SjZPN0SEm7JlwrM9sytFtnVRKBU1wwURFna24bp5RQKPU/6lN3oW8KGCSYURmq8pe5YgZhcKJcA7g8p63nREmXuc7DwftmUzybhhetOhEqlTGYVBqoLwGdM+7iWv9ZbGU+GomFi04cgvjyW1LAM+so6NJQF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pelwNhel; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pelwNhel"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d876329bbso72379451cf.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776271903; x=1776876703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CqYlI3nRpKhuVJs+uVySKa4C7z2CBbad339JqTlA5vs=;
        b=pelwNhelG767wfUEp7uqqiRNrh4XU+HlT7aSDrEOrajGENkNjzIyaQ2+4VefdoGiXb
         YuFP4H42xRYtRgBD+wUNJBmdW1wqAm4pBTIfU+HNI3o/K/7TLATzTyR9/YtSIE2C+ZZ9
         JZXpXwsnBZKQVsxH0W4LU+vguE9CqYZYCT2y4Qcd4PgHtIL7/yVSvLs70h/uLXWlRMWr
         endwrTWuy59t7FUzfA11odGmj8GJeXVj2CxIyzvCBE8xQ35Hui4R8FS3xMgk2t2vcIxu
         z/zpGoQv4GdYyW2MaGtEqGoQ6pkR1tkZ6zY6tmD4U2fX6Gjcri+WM0VBJVwmYDNfr9ZU
         KApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776271903; x=1776876703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqYlI3nRpKhuVJs+uVySKa4C7z2CBbad339JqTlA5vs=;
        b=bERSN0779NPcEBH7IS6VsjYLDnZ1cTkJrljtDOlTvjsOFiLS6CAcqP3VP/r9UjTJB3
         reN0E2QxRO2pykfxjGsfLQ1t9dpc8fLyi3OeREEKb2rH5epDDKnYTAJq3xIQhg6HXMYe
         faMckcJlHUXeDNn+9pPdtujlcAQkeDD0rmipGEva/q9oO+MzlX9GZoFrBcqzesbmWI+j
         Y3uyNpSCFcXVU8PikQzPuqVGFSFtKQKzeQeRZG+Q1YOCRJ2HFSvis1idnmL5qEAIBzNq
         uBsotLNNzFkDDZCjucvrLvpCI9WuGlRxo5jb+gQzvoOrDX7iFheBsRjz+2UBd2zgUVQ+
         Dtzg==
X-Gm-Message-State: AOJu0YwEgvofys3/aPhi39TZL7CwMYplXLvej4dRK5pJnW92bTv1pjOo
	K8+Wz3PQz4zLGnjbCaIschoUMMJb/Fxy+Tjqffg5UmpmeKDg1hYbZ5wGn3hlLV7C1z0=
X-Gm-Gg: AeBDietzk6KkXkT3hursKFxk5edPQWnebhIjD/q/6XpJfvW15NNeMY2Q5B/5b/p5Q36
	kz0MmT1kGx6cIIlPKLz9eHJoq/Ow5yGM/HJk+nlW+EJ7nrdzCOdMpRsMSdVqk+zfMM5NapMS9fL
	nCS0RlJ9sdbwqvkhYzhethJA2ANuZJDdYD1vRi8QJmhPW3K4QvTaWY2YlkNKo9lE16q0cVGUyEK
	PBx3IvZyknDlluyl4Gkqf1nt7VwUPho4lFqgghHssZ3UNV+83eWngeIRhAw0QLjhhVFs/afYxaX
	MyUQIPJAr0lXn9v8H4/XCpNUjuBomnQhf9lqe4mWW/M0oUWd2OD4AOGWcXnYFFOmIPL23iEz8xd
	iE9Lh0aX81KsqJeQXKk4u2CaKj8SEYp6sAHgcYygvl7jd6Y1w03/kne/trZecOwA6a0msRQgLFV
	lSKJpFkWV7o/j4ehOEbjgoaryyVR253m7rwmR+aENQVcJTeSrFd+NWTQ0h
X-Received: by 2002:a05:622a:a992:10b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-50dd5b7c087mr252544531cf.36.1776271903301;
        Wed, 15 Apr 2026 09:51:43 -0700 (PDT)
Received: from localhost.localdomain ([8.46.37.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1adc1029sm19039841cf.9.2026.04.15.09.51.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 09:51:42 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
Date: Wed, 15 Apr 2026 12:51:39 -0400
Message-ID: <20260415165139.14113-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcc_cpufreq_do_osc() evaluates _OSC twice with the same output buffer.
The first acpi_evaluate_object() allocates the buffer because output is
initialized with ACPI_ALLOCATE_BUFFER. Freeing output.pointer before the
second evaluation leaves output.length stale, so the next call treats
output as a caller-supplied buffer and performs a use-after-free write
into the freed memory. The final cleanup path then frees the same
pointer again, causing a double free.

Keep the first _OSC result alive until the shared cleanup path and route
the early error exits through out_free. This avoids both the use-after-
free on the second evaluation and the final double free.

Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index ac2e90a65f0c4..165826b5d6844 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -23,6 +23,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include "acpi/actypes.h"
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -351,16 +352,19 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
 		goto out_free;
 	}
 
-	kfree(output.pointer);
 	capabilities[0] = 0x0;
 	capabilities[1] = 0x1;
 
 	status = acpi_evaluate_object(*handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto out_free;
+	}
 
-	if (!output.length)
-		return -ENODEV;
+	if (!output.length) {
+		ret = -ENODEV;
+		goto out_free;
+	}
 
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
-- 
2.50.1 (Apple Git-155)

