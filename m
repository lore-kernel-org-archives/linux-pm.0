Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F113EC687
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144965; cv=none; b=TNJBPk+Mz+gjIzpwIxFtqRM/q36q9/DyXxjaDG6Dq5CNPicAR9+h2jTzz3k+hYa5SOzwkn48IhJDHI1C7YGGklImjUfZuTvtKLav4wszpC7NHnIcsQo5a+//iO2fk5lYDz+NFKDaEwv77g9AaQMnt8+zY2m4tvP1OwIPUk/h36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144965; c=relaxed/simple;
	bh=EsLaqCTH3yj/zPfNexvBXOoNc+S/fHhmvdiDzcTnYl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5ekgKBo+OI0dPgcIkB0CZR1Wam3CoINYurNJUiT1CHKY8jSCLKz6g4c2bwWPgv5nCDestXpzwBCM+YEPIxUBwIOpN+S8h1qh/Rd1/pFGXR+bZHSC2H9IwSLIZhLS4+w2C42nyiSHqDvgex5RBiq+m0mV/+pW2smQeUAc69FMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=DAS9QJUN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="DAS9QJUN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so24600425ad.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785144962; x=1785749762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELWN7U27SFkZyrD+z5RrldDItBA7BRjMuvttsGL2v4s=;
        b=DAS9QJUNk5CNs20TgRUc3+ga8pl4Xbr3i+B2EcWGO5R1ZH2P9zKyO79F/sdxMBGcEC
         3jVhOhh9BZbweVKyiFCY/WTuWu4vZkuWcGs8TY677z0atiZxCS0Zy745NyQTX/up40uV
         D/SbVW51/D9r0Xm2Oz+kyXmc7btKKjPpuClG1jIgnPzT5vu8wjp0ub2eS1xZ1DtZmqef
         v7MEvmoou9av5M3Qv839U9XEFO0CIOavaxyJErmgJAo69vBDiH8fhSXeUDNOsGsFISe1
         ezLeipuYBax0lrhzVnzE23F3OCpumiCfdy330gDKyCDVh8BotpFwrykHvh6qdDG3VI+K
         rK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144962; x=1785749762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELWN7U27SFkZyrD+z5RrldDItBA7BRjMuvttsGL2v4s=;
        b=PVVZCiar/Qb5sYPCxy1AKTtimZ07f3n4DMiOyD5IPf5b4/6a/X1FXpfQt7iQzaoqU1
         aoP6LjBga7gGuwbZ0urkN4ksriXh+pYlZgih73snBbYgdwN+fspY2RRngCAYnoYXfzpC
         5JuXu+n5xE8XDV/PpfLD4pwm1YE+tjP1IQ7JU6gdQgxK8siKKHwLKIlkPmfDe0m3k/UM
         lDS7RJpTlxjg6iPRC3pIs5VlK42oaGbQVVXQP0bMM4ZbW6Zh+7T+GP744FuCFJl2Vyps
         VkBbVXpjBPfFHxL9Ydac3ZWLEWy9PqX4BK948GQ5kGQXr8xs1uD7cXZsMEGYOw/+NZBQ
         tHuw==
X-Forwarded-Encrypted: i=1; AHgh+RoH6ho4SnqkqcE2L1kSIgmJSrHbIzHiSf8Adz3MkWwKWqF9KWswag95miw+E/0dNomGoL5h/mHWug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyU/GPAAtml+8gLk1S2JEXl1kOukT+y+jsnNO+hgtKNaDP9I0c
	MRJ9JXmAHDttOAtHFKGy+YlEmDq+l6JhwNwYlgXuSmXhyBY6EKvfbBe8VayULi4DpPc=
X-Gm-Gg: AR+sD13xQzOTSQi57dhR45UTJImHayh1oYRwbj+sCwvqzmi4eNlZGXSZDBZfCQ2wp6p
	WCRdORs2BHksQqrbpFBkYpClae5ikotbJTyvNuwLSRyluHDPFscprNB71eohNXQGN4IEqyT1KhV
	wQ4XP+6f4OShvBtmEH9eZfJ5DaninR4LTqhplxZlOI77wCbo70UOJAfeB5nNAuseST+tNaEiIUZ
	AO5ZYu5UWCYTehubQ2/cN/xioq1KL/YRwruFmK3uUGanOoDT4G9itWK003r1o+ocdmQuheoTQGp
	Dpw68yc5gSWfe6KhTvARLQqQyqsPoM4OPWSauVXX5RXvRpTeNZ4/tejhQxHOak1AxznL0UML3C+
	UXgzxnfmCzLs2PK5t7z7JbqxOBPXGiqmUC8VQthEDfAlWeKQPI1itzu3wmHFfvyeEWJ8ujj97Cm
	9HwrMj9cBvkPjUsQ2CHJ2UQMF2oDW6Pv6LqCuCbBWMTiAunv7iRUyBLwHkuuskP5mAr0vqTTNjG
	iEwfE2uRrG3iP+LyX8QfMA8QTDKMg+V
X-Received: by 2002:a05:6300:86:b0:3c0:9c19:65a4 with SMTP id adf61e73a8af0-3c67e027636mr7353187637.76.1785144962163;
        Mon, 27 Jul 2026 02:36:02 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm48567410eec.13.2026.07.27.02.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:36:01 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: rafael@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
Date: Mon, 27 Jul 2026 15:05:51 +0530
Message-ID: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for data->powernow_table inside
powernow_k8_cpu_init_acpi() or find_psb_table() is not freed in one of
the error paths in powernowk8_cpu_init(). Fix that by adding a kfree().

Fixes: 1ff6e97f1d99 ("[CPUFREQ] cpumask: avoid playing with cpus_allowed in powernow-k8.c")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/cpufreq/powernow-k8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index fe1f499b4fc0..c9bcc6f0ab7b 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1085,6 +1085,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 
 err_out_exit_acpi:
 	powernow_k8_cpu_exit_acpi(data);
+	kfree(data->powernow_table);
 
 err_out:
 	kfree(data);
-- 
2.43.0

