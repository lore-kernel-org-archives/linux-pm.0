Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870742641B
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281821; cv=none; b=pPIq1h/IoqOR4SYn2KoyBvMtIdOYl8h6LdvgJHuNVRBU55f//dyl5Eek/QOBO+D/Kb9G88x+1U8Rvr44+aRTIfrTYWl6vhA/GIEGLmsj2igXDBjlXWpqhOL5yWCEs4XZAcgvF0vFl2sfT9gjJ82x3pOKCXa4pCKSykXGyyCfN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281821; c=relaxed/simple;
	bh=5DZ/nLnxCxfQO4kajog7xGVkPie0bnH1eSRCJb9Yst8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4rEdmfDRXmiji07G+sruOOQauPKdgqw0NwVEwKCnYKuySRFj/X6MKulcvYNl1c7jEgAebIo6B1yRMWyAMwlrayzhr1+owf1xg28PlxbdYPXjNr9Q/ACY452q6VbzzA0gu0EVGvzDALUGgO7dsytPprzSUwmL8owlupcL9dJNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X28JdzRv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="X28JdzRv"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so158755a91.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790281810; x=1790886610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sv+MUiOEP3/RF1kItJkpWgD1vZhiIIYN2y4NUfdViXQ=;
        b=X28JdzRvuJKGdoQsspNlPxl6E4Gdr/oTGlM1qSXgR67Cd6dH4Sgb9yEnhg6Q7dvDz5
         XMbsERHW1cyhVPY4eS18qlhty7t736qKvIqUyvn72FesJKUV79gU2Ssg1iKV86T6O5md
         7fMtXcfdYZbXXLpJxq/T7e/uXpHuIgVf6uYWI9woc10rRrY3/Ge3s8kRdgOs9nTA6XTL
         zBbxP/m7dlyxTiTAKV6OMDF55WWIPGLbh0zpUxTxvonDPFORdG6mPpTRNjitMEdFZm9r
         v7d6nJQFqAw5PTzxSq6kYVI1ztiWEDmP/pfBNsOGIYDaHvBMZjZuIVczMxFR9jFiR0KV
         ZhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281810; x=1790886610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sv+MUiOEP3/RF1kItJkpWgD1vZhiIIYN2y4NUfdViXQ=;
        b=1/uC3JkGgEXtNyMRmauxqw+a4gK2+upMP79Ls5kQG9+qAPRU/01U7hcC9GKJ8OAjLG
         aavEtZh6NkTvflRrkqfrSomJvPwn1hm9f2+aBI2UJ09a0SuTcn3XaSOez4gy4gOCnfSm
         jGA6+roNxLqyjHsv1sGbXnJ6xyDOadzoiC1cOQhbOkgqMrZ+BWqd+eaUfUvtB5jn4NW4
         8j5kyYK9kFAdhbbRUwDfCEBBKu3mocqsixB6aD3LMEmhoN8ZNaHRTar6b1ii06W1Y7oC
         hZp2BMxfOPvgNPARik27idTBXEYBQ82EyfVo3YC+O0GRyNbkSXd9VftKLoSSXzObgmlo
         CilA==
X-Forwarded-Encrypted: i=1; AKwUvBydKD0jzGph0gXn7qFqXc8kQp+IeGVUHxNZFsRv79ft+a7yCRqj2M1BK/WUsAt5o9WfIe9CMANXuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m5yB3NbdfggT6lC0wXfvweghLEqYsPOESQt4teKcxcJ8RPCYyq
	Ztf85f5O2zWKsf9e/d2x+FbJBERnVjvdnoJAlaa1BBypUokyRADz/gWnhdGPutn6mpE=
X-Gm-Gg: AYBFou0IGmIgWXq3Fogx9lmwCwctjiaVFnUP8fD4LmTaF9NZy8dlcgKr40bO4u//laL
	+jsunT7bwhoH84CWVNzX0sNMKJkuYvFFR/XvRCWsRn9Xq+FTo0+641LZUnBGM3ckX6Z1no7rYur
	nMuK0UjQLp66NG1q7uLTKThSjmRGQ77vq1Kzv0fo+UpRMc/wCz8bl/8vfbs++OoH2AP9+60pSEL
	8CNM/W+cQlk5RgDC9VAA+Ga1iPnF1C2olQZ9hCsYAqyUlbYAyz1ENVZLyxp3UX0LUyXzv8r1avn
	ZAvv29yoGrpAklfzxCPolFb6bx8bL0UJaY5vhc1KCgsb+5nnfsU6wz0Rthx1c4RsHwLw55Iqv8M
	OsFaIwzddEIO7ehOybqhdxh+qQJnbpQ7ftXJVB/T6sDONn/A6nwmR0OTc6Si4by5U0Mu+ezul/I
	8azZv5awDLhHiVYWx5Qbnp5FXu6/5yEolGH8i2krYv2XcdLOFM6ueQIK2JSsT6YP/KWQ8RzmwpG
	bdhrvc=
X-Received: by 2002:a17:90a:d40f:b0:3a0:42a9:9c81 with SMTP id 98e67ed59e1d1-3a0986ee06cmr3294941a91.17.1790281809938;
        Thu, 24 Sep 2026 13:30:09 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a0976c8f8dsm6695485a91.12.2026.09.24.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:09 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 24 Sep 2026 13:29:57 -0700
Subject: [PATCH v6 2/4] PM / QoS: add lockless read for flags
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-topic-lpm-pmdomain-device-constraints-v6-2-a69a4856252b@baylibre.com>
References: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
In-Reply-To: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=5DZ/nLnxCxfQO4kajog7xGVkPie0bnH1eSRCJb9Yst8=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqtYhOaqDZnD+pG3K/6nVjR++x0keaZsrbzYMrY
 UYyM/bHZAmJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCarWITgAKCRBZNxia0/vG
 Ze3LD/4rvCrToYDOg4NocQRJjY9FXamA4TtwaNIUX1UdgVfHvj+MVDFDtbWkIW+4Uk5UjhrdWsZ
 78Qz9t6C27Gz1au0yFeQxHYh0hTwJD8hB8xOuwVEuqRLYZ/6IhBSK4ywyp3qUzLY4y2m85qhFds
 t8M9244JvoL7Gsy/Y7G4v3cFihf0haSHFWwwUB2htRrF8nhq86mFWvkL16bq9Ekg8VMViXdyP7Z
 qlxiFzjtccIJg3TxiwvGOnu8yIznbnNa0VstOM7egDveMjDZ+s9xastv9iUEpaWB6YoRpAYyzXf
 Wtg7q0uUftXUhdqC5FbnVz2VU9JURkoFRrfrqZ8SJ5LHPvcifzfqwsHoSCK6yid+g0eSR++tJn5
 vKU/qjyAK3OUoSIh09bFZaeR+s7BNlM3+p/6Z++t7uC74bVDo7iWOaRmXD/+lUUhCZcuNeti9Ua
 S9NVMYQXwU7iV3BGE9Nfi8jmsYv7AGBeN4QoPwIfDcVecMQu8ogvoH9FP9oajs4SnyL+Ux1Ixik
 1NZdfw2NCdl3H6O+3LixdRyMW/Jvqfw+QeKpWELvXG/OqnfGQ3lilhmLOnULcMyJAG7zD3Exa1D
 BPwYia7Q77DCewRRzsy6VuN/gkejH4K8K479T1gXp1XvIRR5KOeIoJ8E4qUI9KVRsvQsJ3K5XrU
 /zVDgMe5/4rc3kA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Add a lockless read for QoS flags similar to the lockless read for
resume latency (dev_pm_qos_raw_resume_latency) which may be called
from atomic context (e.g. genpd governors running under a raw spinlock
or in the syscore suspend path), where taking that sleeping lock would
be invalid on PREEMPT_RT.

dev_pm_qos_raw_flags() now reads dev->power.qos->flags.effective_flags
with READ_ONCE() so also add corresponding WRITE_ONCE() to the two
effective_flags writes, the same way pm_qos_set_value() already does
for target_value/pm_qos_read_value().

Reviewed-by: Kendall Willis <k-willis@ti.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 7 +++++++
 kernel/power/qos.c     | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index aededda52b6b..439a9e779d81 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -219,6 +219,12 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
 		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
+
+static inline s32 dev_pm_qos_raw_flags(struct device *dev)
+{
+	return IS_ERR_OR_NULL(dev->power.qos) ?
+		0 : READ_ONCE(dev->power.qos->flags.effective_flags);
+}
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
@@ -300,6 +306,7 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
+static inline s32 dev_pm_qos_raw_flags(struct device *dev) { return 0; }
 #endif
 
 static inline int freq_qos_request_active(struct freq_qos_request *req)
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 1944dbeb0d4c..c241da5bccf6 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -159,7 +159,7 @@ static void pm_qos_flags_remove_req(struct pm_qos_flags *pqf,
 	list_for_each_entry(req, &pqf->list, node)
 		val |= req->flags;
 
-	pqf->effective_flags = val;
+	WRITE_ONCE(pqf->effective_flags, val);
 }
 
 /**
@@ -193,7 +193,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 		req->flags = val;
 		INIT_LIST_HEAD(&req->node);
 		list_add_tail(&req->node, &pqf->list);
-		pqf->effective_flags |= val;
+		WRITE_ONCE(pqf->effective_flags, pqf->effective_flags | val);
 		break;
 	default:
 		/* no action */

-- 
2.47.3

