Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8E371876
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435008; cv=none; b=ZsRmxiNZFF5D3pNnJa8UW6K8psirk66L3nCA0y87ldnTomuAbanYp960+ZyPqBr01sS0X3+DfPROiz/Kxygo5WrCNVW8TPiD+WTexWoQymWe6WHnXGE4Ecx2o66b2H2owhgj5UUjMRQWzR+tbpbYMZ0PrkODil6ZIynQ4wkvdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435008; c=relaxed/simple;
	bh=xqg0PDM2bvV+i0XKo4uNvyuVC4rUpQrt09d4c5dNC18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBQC4SoWkN0CNrRew1aW+MhYFbC9/cV7MlCCo+9LbaFfgPj2uDjAtRiuBQnOO/Vqe+7oiqaHEASeB9RoHrBruufbiJul3J4vogc/7J9rIgD0g8zTOJ3RjgIaMb+mcc5Ut/JW39+PxxTPmlPRrUIhmRg6WtPU8YKtVNG9WfQR3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPpd2HtE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPpd2HtE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab077e3f32so3254495ad.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435006; x=1777039806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdR31Nbdb6V2hjv9lvZnyC34znZvsNm6CKqmWu09XT0=;
        b=IPpd2HtEPY4TyHaU/dOZTYI15gOubUMl+D3kwTxGExxkNohsYYMVqK4XmuND8vX9dW
         jVkNK41jIJsf8Ttla6mc5nLZqPoYtADXBqFYsQGzQdL3/TvwF7oNGQHqHXIyM43NhBy2
         lDSaBVoZb7TZSUf2qS2IGabrRxM5VCv4FbUlb1oALIyfcwRhIQTvC4bXJLDvZKnfC1Xo
         lNltpGUBiGggldS2+gOshGdHnj/EpDRhokC6IDUnGAijyhUy6mFFIBFWQuiwF/Ukbaxz
         EQDwf6BzpKwkfelZ4rq9avJsaTqVVbsBy4jyUeQgu07sEI1ZKnQmrPlbFibef3YjcqwQ
         1Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435006; x=1777039806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdR31Nbdb6V2hjv9lvZnyC34znZvsNm6CKqmWu09XT0=;
        b=QUlpGQ3pRssphJ0RjyLbQ09wNQJbtHr0lSbKKmwmmnmQBdE8jjjHWLpgbxzIQP6qpM
         lBUl3XlF9SBUbCEbBYRjBMkBlBLxzr2yZCEogq+RmnBN9GBs6+GTIBAir3a1q8WMyp3B
         eLUmpIJLRkqyshwyinwYyGJAaTryH0YPIvpS6nHvSjRR0OXlT7hBByOLugCM788YBLcO
         R7zTjz13Ra/AF8qybzC9xEjWNeoIiEKfEKBs94pA2r+lwHT9fGTyOm3yX+ZMTbSwae7Y
         riIITYNS5vWN9shlUAT/YpjU1+rFZRdHK3NP3f4HurbKaaBkZvlnmAE/WigieQQVkW4L
         /k7w==
X-Gm-Message-State: AOJu0YxS8q7RQs+rAE/iikbwSPJ5lUCZ4iVHpi2VN2qt6LNzW9likYDF
	bIrJJWLEAzxaKDX5t/94rygJKOL5MgrSQA5mLfUfYfHZiBoW6fXC8Kkl7h9/HYj1
X-Gm-Gg: AeBDietGFKkukleP+D0njhoRUILzYCEVVhSV/qZX8wUza3SAguH9BfoBYVnOB5aQX+j
	7k7WNKI5ahYZFyVt26M/qghnDANifr4qgKpS47LbON0mUz4q9/ee1jc1jNRXokgw1ynFNYOQVx3
	ZGgf5cjMeKEmVjuaJx4jTMUurWG1ZXJCl3RCB5b+BCyTPCmVxp4p1ZZxuzX5tF+2A3abHJ7dfph
	SVXi6ve9oaBOOSwx8d87zDcCX5YCW1VFYheqjGjjduGWWZ/hu5sWfPt51ejXlV5vGm36HkuWobm
	gmcETF8nppbXZFVsBfBARjJQ8e9BH/j6PZOwZ/RIdx/jPZAsPObQoMPHIN/SvPA93Q0H+2AUcV4
	8H/G51Cg8rvmzkFusdgURHeIKab1qMJLJYr9J/C+hubx9fhbkdM7Op5zN3/b8XbdpwFYldRBeyY
	Ec1uewvOUtT57MFxL20lRi782vNd9UzaZkIqJ8e0/NR64EMZTxHc9uDvpbSu1HOTh6NlE+KIDdo
	vlgV/ktM721h183KChlKVjp
X-Received: by 2002:a17:902:f545:b0:2b4:61cc:37a8 with SMTP id d9443c01a7336-2b5f9eceb9amr33843715ad.17.1776435006385;
        Fri, 17 Apr 2026 07:10:06 -0700 (PDT)
Received: from mohit-joshi-Victus-by-HP-Gaming-Laptop-15-fb0xxx.. ([59.89.50.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm20341275ad.23.2026.04.17.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:10:05 -0700 (PDT)
From: Mohit Joshi <joshionmohit@gmail.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Mohit Joshi <joshionmohit@gmail.com>
Subject: [PATCH 1/3] PM: console: fix minor style issues and improve readability
Date: Fri, 17 Apr 2026 19:39:54 +0530
Message-ID: <20260417140956.55232-1-joshionmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 kernel/power/console.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/console.c b/kernel/power/console.c
index 33ace63b1088..57377046933b 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+/* Tracking whether we switched VT during suspend or not */
 static bool vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
@@ -62,7 +63,7 @@ int pm_vt_switch_required(struct device *dev, bool required)
 	if (!entry) {
 		ret = -ENOMEM;
 		goto out;
-		}
+	}
 
 	entry->required = required;
 	entry->dev = dev;
@@ -144,11 +145,11 @@ void pm_prepare_console(void)
 	vt_switch_done = true;
 
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
-	return;
 }
 
 void pm_restore_console(void)
 {
+	/*No switch is needed & none was done*/
 	if (!pm_vt_switch() && !vt_switch_done)
 		return;
 
-- 
2.43.0

