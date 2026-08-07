Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790C31F985
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097007; cv=none; b=LhqcS+aYb1Xb+TAbbWpFYS/6U1xWHXvzBFxyIU8XpBOU1z+v95gZPPJ7jMSgkEVwmm+/2emUs1tDmPT6RJsz+cNfSGuQvQbhOOleAOn4GdJ/5oCFwSfTOvFFA3CFVy7M2MiapZ2IFOAd7X3K0iL17LvIZ31eE8Sqqk7uDKjFO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097007; c=relaxed/simple;
	bh=pc/WzeeeJ6wBSTAG7SEULchghvROlW3G3xEf1OAypWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWDmIVubwJjadbvkhayyt3abc7nD++k1ZP0ePFlpl2oPn8VJ7f3PCLQ3QDSFdC3ZEvdQmobbdJAoTbhrl72ZKoWTQgkkvnzEzv6nQYFtXXb/LRdxmnZtgnMeFqd1CwsJeU9m6+mmxbnKInF+TkWB7YpZioY73ozvUR599kaqOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ2+PF5d; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ2+PF5d"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so3400354a12.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097003; x=1786701803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FhRStw61Ep8uRkimVCxquEUsUzeWSHfcLBMZIDMSAKw=;
        b=MQ2+PF5d6bYgAQQB6hCPFyRU4HVeygsSEZIkoT11cd5H+Znd7VTMXYvg8TdyumAIWZ
         NJkhzu//oBi5lJh7lQFZ6ouDpWMD+453VGmtR1Q8ONP9I6PefXCQYPkE8qSCDy6p6v3C
         nPsZ+Ap2hYdfBC9JWw7wmxZ/jz0gEJMbejz9nu/FyeC655c72UJo/Lm1dSXO+m1JzEFD
         Eg18QYP4QSCEhrukTInD7sClbGQCNQihOVijuHY6cYbeEQn/9eUEgaVUgCMrPe6ODtmt
         hCfDmRmIWxHxo9/nTy3MggL+srgPEG8BzOmtDfBLM0A/qQE4xNGxbYxY3ZNaOMSNjelp
         0TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097003; x=1786701803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FhRStw61Ep8uRkimVCxquEUsUzeWSHfcLBMZIDMSAKw=;
        b=LTbADd+j86sTz7O+9sN4jEf7GWo+ilXKEmL30SphDAEJ3lAmS+dd/0Q98XdsndWoSk
         9IN2HywpGGlfZ9zoaHe5zVHOzhpsuOxo0ZnyBhJF3/YbfWAqnIJKTggAoY/MZqvjZ58l
         p5o6XhoVyQLu2puPxyldONXF8/zEUidIhhheL0qHr3NMUgoczbyf2+wmVPhyyzCwvy9v
         d84XdAiKx2bGB9HtguvTsZ7wc/oRL9ZPRySJj1pUCS+dlUCqFs7wvGAB8Ikv56rvz43w
         deB8nVDd7Ue5FUo096NOHpZIwWWCda9VdLuXOb/geQX6Uhtn8iiZ7nV6HaNbOdgC2EEp
         Eg6g==
X-Forwarded-Encrypted: i=1; AHgh+Rq2KQGZuoud9sHqszeFh+LnBuGUSgCVxjj3K4FRlTFmdaj7aqcwpkEeRg7iwBZn01digV1rFXExJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnKoQ4nsd7T8UWArFj1TRKNNxbC/1nDZJs8vi6E70TumcAPdO
	y4tHiprooida2CaPIYMxhTGFp/DeG6OujuWt+p3Wpw/cAoFmNaq5qKVf
X-Gm-Gg: AR+sD13RXPI8qzqlRZ+bH/GZ8s4b9gjNxmnPUmDFVopSQx+MhrWRZya4PPxqhRnGUJp
	jsdFKCcZ1uhfBG21KcGbAolmqM0DbA0GeAK/121oRYqS/ZyLWV0xhEGz9aVmtwkS0u/FNUGWNp0
	Rl79/T1xx+zaX7dp/S07KF56icwSslOjLg8lrBQJPi6X4tRImTDErcjtGVeqrE+PJGSJPknUn9R
	ifXIYLBp91PD2ZdOAFP5JJArh4GcSOAWKP0R1rZXtibEdGrCphPwKcgWBskJvidwzLHU7GIslEU
	hXTRL4KwcoGRxmSs7K3lGGQcoUK4zAVcbZMQpoOsNH1z9/gUwNgCeTe0Y/7cki9fXLEY9trJ1AA
	EO7+rSEyR4dWlgLeLV5zCKnGqar/sAY50jeRRxu0+OfUI4PY3+IuLT3x65jS0bPc5DBQBCpE+EZ
	3TAARqWWaqXsGPIOcs14aXSEIo+a/mPgFYp/T0CvFAPGupiuI0DWD1QHgZvOIQMkeXQKoVN53t8
	lGlDSbYgmr/aw==
X-Received: by 2002:aa7:ccc9:0:b0:6a1:1bea:8ea0 with SMTP id 4fb4d7f45d1cf-6a1b4a9f052mr3101232a12.3.1786097002616;
        Fri, 07 Aug 2026 03:03:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:9a0d:6e0a:2fe5:1ceb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800214557esm4261107f8f.2.2026.08.07.03.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:03:22 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PM / devfreq: Convert to seq_buf
Date: Fri,  7 Aug 2026 11:03:17 +0100
Message-ID: <20260807100320.121108-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The devfreq transition table sysfs attribute (trans_stat_show()) builds
its output using manual sysfs_emit_at() calls with hand-rolled length
tracking and PAGE_SIZE bounds checks scattered throughout the loops.

On SoCs with large frequency tables, such as Renesas RZ/G3L, the
resulting table can exceed PAGE_SIZE. In that case the function bails
out entirely and returns -EFBIG, logging:

  devfreq transition table exceeds PAGE_SIZE. Disabling

which makes the attribute completely unusable on affected platforms.

Convert trans_stat_show() to use struct seq_buf instead. seq_buf_printf()
tracks the buffer position and handles overflow internally, removing the
need for manual length checks before every write. If the table still
overflows PAGE_SIZE, truncate the output to PAGE_SIZE - 1, NUL-terminate
it, and log a rate-limited warning rather than failing the read outright,
so the attribute still returns a usable (if truncated) table instead of
nothing.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/devfreq/devfreq.c | 64 ++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f08fc6966eae..3c4c6fa23cfe 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -28,6 +28,7 @@
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/pm_qos.h>
+#include <linux/seq_buf.h>
 #include <linux/units.h>
 
 #define CREATE_TRACE_POINTS
@@ -1661,9 +1662,10 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
-	ssize_t len = 0;
-	int i, j;
 	unsigned int max_state;
+	struct seq_buf s;
+	ssize_t len;
+	int i, j;
 
 	if (!df->profile)
 		return -EINVAL;
@@ -1672,6 +1674,8 @@ static ssize_t trans_stat_show(struct device *dev,
 	if (max_state == 0)
 		return sysfs_emit(buf, "Not Supported.\n");
 
+	seq_buf_init(&s, buf, PAGE_SIZE);
+
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
 			devfreq_update_status(df, df->previous_freq)) {
@@ -1680,47 +1684,39 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len += sysfs_emit_at(buf, len, "     From  :   To\n");
-	len += sysfs_emit_at(buf, len, "           :");
-	for (i = 0; i < max_state; i++) {
-		if (len >= PAGE_SIZE - 1)
-			break;
-		len += sysfs_emit_at(buf, len, "%10lu",
-				     df->freq_table[i]);
-	}
+	seq_buf_printf(&s, "     From  :   To\n");
+	seq_buf_printf(&s, "           :");
+	for (i = 0; i < max_state; i++)
+		seq_buf_printf(&s, "%10lu", df->freq_table[i]);
 
-	if (len >= PAGE_SIZE - 1)
-		return PAGE_SIZE - 1;
-	len += sysfs_emit_at(buf, len, "   time(ms)\n");
+	seq_buf_printf(&s, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (len >= PAGE_SIZE - 1)
-			break;
 		if (df->freq_table[i] == df->previous_freq)
-			len += sysfs_emit_at(buf, len, "*");
+			seq_buf_printf(&s, "*");
 		else
-			len += sysfs_emit_at(buf, len, " ");
-		if (len >= PAGE_SIZE - 1)
-			break;
-		len += sysfs_emit_at(buf, len, "%10lu:", df->freq_table[i]);
+			seq_buf_printf(&s, " ");
+		seq_buf_printf(&s, "%10lu:", df->freq_table[i]);
 		for (j = 0; j < max_state; j++) {
-			if (len >= PAGE_SIZE - 1)
-				break;
-			len += sysfs_emit_at(buf, len, "%10u",
-				df->stats.trans_table[(i * max_state) + j]);
+			seq_buf_printf(&s, "%10u",
+				       df->stats.trans_table[(i * max_state) + j]);
 		}
-		if (len >= PAGE_SIZE - 1)
-			break;
-		len += sysfs_emit_at(buf, len, "%10llu\n", (u64)
-				     jiffies64_to_msecs(df->stats.time_in_state[i]));
+		seq_buf_printf(&s, "%10llu\n", (u64)
+			       jiffies64_to_msecs(df->stats.time_in_state[i]));
 	}
 
-	if (len < PAGE_SIZE - 1)
-		len += sysfs_emit_at(buf, len, "Total transition : %u\n",
-				     df->stats.total_trans);
-	if (len >= PAGE_SIZE - 1) {
-		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
-		return -EFBIG;
+	seq_buf_printf(&s, "Total transition : %u\n", df->stats.total_trans);
+	len = seq_buf_used(&s);
+	/*
+	 * If an overflow occurs, seq_buf_used() can return a value greater
+	 * than PAGE_SIZE. Clamp the return length to PAGE_SIZE - 1 and
+	 * ensure a null-terminator is written to prevent the sysfs
+	 * "bad count" or out-of-bounds warning.
+	 */
+	if (seq_buf_has_overflowed(&s)) {
+		pr_warn_ratelimited("devfreq transition table truncated due to PAGE_SIZE limit\n");
+		len = PAGE_SIZE - 1;
+		buf[len] = '\0';
 	}
 
 	return len;
-- 
2.43.0

