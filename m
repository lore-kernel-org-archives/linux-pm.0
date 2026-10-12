Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D64BB810
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819984; cv=none; b=pm2QAMjq184GJcpHPercKY0EiTfF21guyQp8vL0pqmM7tx9MRFaHGvXdgFpsA64VGv8UssmVmOBwp+OSkEYAKX/FUQ8pOOhWq0IDIEXAjIgV9omYcxNhGr5878CdqklaRSToP1/YBMqiIY4YL6FH0ObKVpTzbmmQoYucFqQJPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819984; c=relaxed/simple;
	bh=WsYQRqZVkYfAC0uocIQCG3hADVXXJg52uM4QwsZS/VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOSb1OEIRJ0prP+vyxhWjNyMSQTnmut7ZG8OCD3nuZi1KedwAoSex2L5ELRH8//SGQ49sP5p+0p7/vL4N/Tp2L5qfObP3j0UgB2RwnmJnieIgvTkPl1xPmXBh1Gy5bmIQ6u0B/XGqgGFzMA9744tHetdkydloS+dawy/bGfjF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ9KvtdX; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ9KvtdX"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3236897eec.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791819982; x=1792424782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NAuVFfQbxwKnXcYGVkoP45E/v8P/ovYGz0j3wut9/Dk=;
        b=pJ9KvtdXW+l9rUsPrCdb6JKioO2Prixdx4MaCp5jAIuyBohZmCvXTgX2Z0Haz2Sgfw
         31NHqmiImhmH6W2byXMbbRYcIobhKGM28Alqoh3udIy9fDXR8snKpIEzGCWPctq4geNY
         1V1ChZznBgrMv+0ONzjoDRxxWT326BRWTJ+w5dnM1xivr/2ixMdWfZ7nkM8VlyBaLaqz
         m0CSrPNjP8M0eIpxkBHoWI/2fCExSlQ4pPwmnO5kVUfAsVtnhLzKQaRaAjl/SWmw9r3k
         och8Vr/IVrKls9MdH81qSvxGQygU4NAHbYsyf231+KbGpck9BaNsEKro+ICl2/GIvlM7
         lzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819982; x=1792424782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NAuVFfQbxwKnXcYGVkoP45E/v8P/ovYGz0j3wut9/Dk=;
        b=YJaD5cdw6hYo8cVCL1vKdW4GOlszGqOtLQW+WfEeDfC1gTuJRYKcy1pmlZVF18zw+Q
         +IUX/t3FYZ9MW+aufRSD61jiHYQpz5kV+NFKz9+2G3o6POJrvMbXxF5H/cwEcLBlBdNl
         svkrqFm63vqI8Y0KQTXeBONisMDWocZUXbFjzX8+yHInkI/N8hxvgAd/Jzm8oY2koZ+J
         DnTFhPNaRmiTXoivAaC7A3EFE0VV+hst7J9i1rvUtrwWU6nM6ZE7GLHAumxExPpCgm6z
         SCPkoVhe6EiX++UBFQbUX9SYsGMSzzYANRghexFqY4qHnMvzECxwYO8Vu3jB/3XIEsGm
         uJMQ==
X-Gm-Message-State: AFq9FYL9lPGH7dPZJOFjJrmYpmHqKUjAP28nvkHvLLDCsdBCbyoWlEdd
	I2ePxsplxl/PqNvL843NWdlaohcd9stqr3hzR+97i0k/Zr2aK9cknd1lONUwwT2J2C0=
X-Gm-Gg: AYBFou1jenvyPTAQbboRMFRTRUgJNhdLOzdEU+eyrGbL/0HheGPehGqWiL5fPGeSkCC
	iNbsx+pCTjwS4q+o2m4fCP+8MLd49VKWdMTSz4LX/bM/frr9p2JkC9n9mh4Szf2e8/H3tC72gBD
	4uX3Gn06CMXum7R/ZMoKDOSpjcT8XkbzKzge+HpmYTkC2MJCpD7iGzgdGhF/y9vTWfeatC+quXi
	dQL4MWPmtOly24A1Ak78JG2d0uRnlh21UAovGl7MTg6ahwNtRlkik0UjoijrTRuUKDjVXIP0WD9
	iUOjgYXKlQTdKI/96fUBKzgdbN35SjsxNqsh20Bshg1iqqTWd7y5Gprz3EwKC2vW9lQwoS9fYuD
	S9TTHAEE6Dby/JNK7oWIpZqIij8A20PqPRGmEnx5w4zjKiM6GzJtvYr3BgiYRaUvGooucd9gI8y
	/ONipKA/N4h5PuAS/f55JN4jNhj4yOeuYCg3tmmyT+sV+YlkcmxEzxEqzXRARLNu3htMt2daXOj
	No30azPUJFVziDWJrseezXUkVXFhbYt8ju8b/J5Y0Um6gZPXzhl4ExD/WZdO66ljDPMnwGz
X-Received: by 2002:a05:7022:ea8c:b0:149:1feb:6dae with SMTP id a92af1059eb24-16a62bcc7c8mr12280029c88.39.1791819982235;
        Mon, 12 Oct 2026 08:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:c1bb:8d21:6c07:8107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm33838996c88.5.2026.10.12.08.46.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 08:46:21 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] power: supply: sgm41542: Use secs_to_jiffies()
Date: Mon, 12 Oct 2026 21:16:12 +0530
Message-ID: <20261012154614.42203-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both watchdog kicks are a flat five seconds written the long way. Use
secs_to_jiffies() from the same header instead.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/power/supply/sgm41542_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sgm41542_charger.c b/drivers/power/supply/sgm41542_charger.c
index 888096252..118b4c700 100644
--- a/drivers/power/supply/sgm41542_charger.c
+++ b/drivers/power/supply/sgm41542_charger.c
@@ -468,7 +468,7 @@ static int sgm4154x_set_watchdog_timer(struct sgm4154x_device *sgm, u8 time)
 		if (!sgm->watchdog_enable)
 			queue_delayed_work(sgm->sgm_monitor_wq,
 					   &sgm->sgm_delay_work,
-					   msecs_to_jiffies(1000 * 5));
+					   secs_to_jiffies(5));
 		sgm->watchdog_enable = true;
 	} else {
 		sgm->watchdog_enable = false;
@@ -970,7 +970,7 @@ static void sgm_charger_work(struct work_struct *work)
 	if (sgm->watchdog_enable)
 		queue_delayed_work(sgm->sgm_monitor_wq,
 				   &sgm->sgm_delay_work,
-				   msecs_to_jiffies(1000 * 5));
+				   secs_to_jiffies(5));
 }
 
 static void sgm4154x_disable_irq_wake(void *data)
-- 
2.46.0

