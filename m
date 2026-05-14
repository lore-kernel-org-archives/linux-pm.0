Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8326314A98
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780251; cv=none; b=UjPPV4YLU4FJT2KVG/VAtjdn6Wz+bW8pD84bTB3iItlhL1LsuxfvW21OGx79pNUmaMJlK8Z4RCx1cXw7+bGOIUqyKsRvkzt3SniwVe4ZF7/8Og9kecu7z4JNwVaN/lgQKIPwsukvmy5AeJDfXlTCDfWrhiP+u/JA/G38MnlBqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780251; c=relaxed/simple;
	bh=JaRsDEoKGFVG+NKqz3xisdhqflAWlQTIzhLHAmBJPKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyQVv6yrjGZU7cnSCzl691KKrVKEEsKJpGXz/lCmX7C4sCZxkxo6zwYR9vZJHf37xDhI0kbf/3NBo/lB+7e2B/C3KOW8+/U8IuxgHZTOScsft5jzl6wsefEdwbo57kRA9Vfm4yMQ86HNGydf+ZgkSs3qAlSaihi8lSk3WZg+QIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFts49E/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFts49E/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a044cb827so6576411f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780248; x=1779385048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dyuDrwKO/rRDsGDrWQvGAN7iDf4/+1EK7qACTw3vwE=;
        b=dFts49E/KSYR9G5tg/HFKKxj4zyr5RAGHIMSzWe1mz0I/03tqtXD6iP1GmzSVK1Tik
         rjCQ03NJULYLKL8iYRkUJnIWsz5dtIoZUnsy49Q8Xx4eOYNg6ywbEKfLIFOJsE6NakKa
         tdGOb9PTsjK37DnSA2wMnTW4BBAo2mirRVjIv5+QBiQiwR6Qqfa/7OXhIUt5ymkA5Exs
         2FQyBE4z+7vbuf+eu3sDwfwFU/svBvEJl9jryDxg0qhyRMhvrh+j72/sDAqVcr27t3TM
         HzUOp1XnK9rlqOVcmD9AyULM1vwZgOEBxDwBEMjVA6fN+pJFOGIX39rfgs7bcjuMHVzj
         v9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780248; x=1779385048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dyuDrwKO/rRDsGDrWQvGAN7iDf4/+1EK7qACTw3vwE=;
        b=ao3JkrZXef1yIxthaAhWIcvcNgFRJ3kqvzlp3qLmXYDJPjOfpV6U2Sb/rv8qMuUz23
         PjtMQcSEtXT8hLha0ulaErK559MFZSWIMzb6tGE4KDUjv+IwNfXzR0a9+TmbbsuTGntA
         H5c6K+XTmaD3ceB9dMj+iJ1OTarboeZb0IxIPHQKaQGT97MyF0OBkG/3ykHplFYtJL52
         kSWbGDLJMa6TcVuV6ZZ2mnASRaYMtQ5/1qAXMYw51BN0sfaL1dJDlI4IS6p/KyHqAVB1
         EbjaZo2ZP7q3Bl/HGRKMcm3/U5ZvVb8pgwD2Fl82KWMH2Cgj+IgF66N0tD3u5nUmqONE
         R5vA==
X-Gm-Message-State: AOJu0YySbaseQND3H9UzDLzTQjSYe9uFnO2QT3c1exwxtPiYh2V5rohx
	78h4Xl4MSOl1/32aLfccWf+TEBuyiea38ppFZiF6ooEcbgsaD/3GrBI5
X-Gm-Gg: Acq92OGmpqcalxkHslK8cvTRan1aZMQVZJZJNqwFXnKvwcwmNby7Iu546HVkM5DLs4I
	jyiqmFsVYo9UgzOEAIIgxb3uLz0I2qVo1L/DPch/FyMQs2Zdmgi3gfuxF6nsfUlTZwjcBqYbFEK
	qWoVC8GpS5lIfsCVd016PWkVjzUOC7aM0Utvdpxw9u1MQ5B46h8rDtnZEEG6xKaM25pV/DnDtRc
	HohWHPsgYzyqiBWfEJ6oZGNSsaA4kBF9oFCF772qiijBmWiyBs1z+3pOd3lVurGo3Atu8Dmdosk
	+l154CRozRZkKMo2t2V9W2fi9DepSclVikSOrdUta3a37TsgjFdSmUblSkInQhfUQk0acK30Ctd
	8IMcLmvWXN+nmlfC112QrmN91Ei9gSOLU5Xij2KKjI/qFmUcuJvRPrx9lXQOQm6wbc+la2msZgU
	VNBJhrjQM9SKA11dAt7H1ly9V06dFfA2c/jOshlDmyWwg=
X-Received: by 2002:a05:6000:2289:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-45e5c5bebe2mr56644f8f.21.1778780248020;
        Thu, 14 May 2026 10:37:28 -0700 (PDT)
Received: from user ([104.28.154.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm7977150f8f.2.2026.05.14.10.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:37:27 -0700 (PDT)
From: yoy95104 <yahia.a.abdrabou@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	yoy95104 <yahia.a.abdrabou@gmail.com>
Subject: [PATCH v2]  cpufreq: acpi-cpufreq: Add better support for amd zen
Date: Thu, 14 May 2026 20:37:22 +0300
Message-ID: <20260514173722.190104-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found some bugs in the original implementation and repeated code

Signed-off-by: yahia ahmed <yahia.a.abdrabou@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 80 ++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a488a2e2f914..29daca4ffdc6 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -65,7 +65,6 @@ struct acpi_cpufreq_data {
 	void (*cpu_freq_write)(struct acpi_pct_register *reg, u32 val);
 	u32 (*cpu_freq_read)(struct acpi_pct_register *reg);
 	int is_amd_zen;
-	int on_ac;
 };
 
 /* acpi_perf_data is a pointer to percpu data. */
@@ -773,7 +772,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return blacklisted;
 #endif
 
-	data = kzalloc_obj(*data);
+	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -781,42 +780,65 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		result = -ENOMEM;
 		goto err_free;
 	}
-
 	perf = per_cpu_ptr(acpi_perf_data, cpu);
-	data->acpi_perf_cpu = cpu;
-	policy->driver_data = data;
+	result = acpi_processor_register_performance(perf, cpu);
+
+	if (result)
+		goto err_free_mask;
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17 && c->x86_model >= 0x30) {
 		data->is_amd_zen = 1;
-		policy->cur = get_current_freq(cpu);
-		policy->shared_type = CPUFREQ_SHARED_TYPE_NONE;
-		unsigned int max_boost = get_max_freq(cpu);
-		u8 virtual_pstates = 16;
-		unsigned int max_freq = get_max_freq(policy->cpu);
-		unsigned int min_freq = perf->states[perf->state_count - 1].core_frequency * 1000;
-		unsigned int step = (max_freq - min_freq) / (virtual_pstates - 1);
-		freq_table = kcalloc(virtual_pstates + 1, sizeof(*freq_table), GFP_KERNEL);
-		for (int i = 0; i < virtual_pstates; i++) {
-			freq_table[i].driver_data = i;
-			freq_table[i].frequency = max_freq - (i * step);
-		}
-		freq_table[virtual_pstates].frequency = CPUFREQ_TABLE_END;
-		policy->freq_table = freq_table;
-		if (max_boost) {
-			policy->cpuinfo.max_freq = max_boost;
-			policy->max = max_boost;
+
+		if (perf->state_count > 0 && perf->states) {
+			policy->cur = get_current_freq(cpu);
+			policy->shared_type = CPUFREQ_SHARED_TYPE_NONE;
+			unsigned int max_boost = get_max_freq(cpu);
+			u8 virtual_pstates = 16;
+			unsigned int max_freq = get_max_freq(policy->cpu);
+			unsigned int min_freq = perf->states[perf->state_count - 1].core_frequency * 1000;
+			unsigned int step = (max_freq - min_freq) / (virtual_pstates - 1);
+			freq_table = kcalloc(virtual_pstates + 1, sizeof(*freq_table), GFP_KERNEL);
+			for (int i = 0; i < virtual_pstates; i++) {
+				freq_table[i].driver_data = i;
+				freq_table[i].frequency = max_freq - (i * step);
+			}
+			freq_table[virtual_pstates].frequency = CPUFREQ_TABLE_END;
+			policy->freq_table = freq_table;
+			if (max_boost) {
+				policy->cpuinfo.max_freq = max_boost;
+				policy->max = max_boost;
+			} else {
+				policy->cpuinfo.max_freq = perf->states[0].core_frequency * 1000;
+			}
+			return 0;
 		} else {
-			policy->cpuinfo.max_freq = perf->states[0].core_frequency * 1000;
+			pr_warn("ACPI Table didnt provide any P-States");
+			unsigned int max_freq = get_max_freq(cpu);
+
+			if (max_freq == 0)
+				max_freq = 2000000;
+			u8 virtual_pstates = 16;
+			unsigned int step = 25000;
+			freq_table = kcalloc(virtual_pstates + 1, sizeof(*freq_table), GFP_KERNEL);
+			if (!freq_table) {
+			    result = -ENOMEM;
+			    goto err_unreg;
+			}
+			for (int i = 0; i < virtual_pstates; i++) {
+			    freq_table[i].driver_data = i;
+			    freq_table[i].frequency = max_freq - (i * step);
+			}
+			freq_table[virtual_pstates].frequency = CPUFREQ_TABLE_END;
+			policy->freq_table = freq_table;
+			policy->cpuinfo.max_freq = max_freq;
+			policy->max = max_freq;
+			policy->cur = get_current_freq(cpu);
+			return 0;
 		}
 	} else {
 		policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
 	}
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
 		acpi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
-
-	result = acpi_processor_register_performance(perf, cpu);
-	if (result)
-		goto err_free_mask;
-
 	/*
 	 * Will let policy->cpus know about dependency only when software
 	 * coordination is required.
@@ -893,7 +915,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_unreg;
 	}
 
-	freq_table = kzalloc_objs(*freq_table, perf->state_count + 1);
+	freq_table = kcalloc(17, sizeof(*freq_table), GFP_KERNEL);
 	if (!freq_table) {
 		result = -ENOMEM;
 		goto err_unreg;
-- 
2.54.0

