Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056F44E671
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783013; cv=none; b=q/hTQ6i+9O2kR4FNn9eUkGQRh6KMkwauq/riD1/zaizXwdUWknByv7kvKTbctRcAo9cb/AHT7j/09HZzRO4SziV6xkpAsWA7LGae2M95yXUgQCzS/S9B0+m9DkdgexHv99w/SJoSlizsIHyWX6YfGPrPv/DgzOub4hhiqltY9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783013; c=relaxed/simple;
	bh=76GWlvs2S6RvtzUC9P3JnexZlLh1ZyGKNxkhMVs2ZXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4y3FblT2PucK53R6zsywC06q7m1h5AnYo2geQKoOr4qVkS6Y2uBRq/PDfWFiOKkOJyxlpI9fEKht7A7lgEedban47FYpVHDtvdmGqBb4CtqihOvt/sD6dznCzMMTBxoLqLmlwAiml2VEVCgAKl0FjpHm16yldsL1VErxnJWzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JOhXVm2V; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JOhXVm2V"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so327228a12.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787783006; x=1788387806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHtBci+7WqjdzbXMCO1Bw7FN1oZt8E0+8PQeHHnAE4w=;
        b=JOhXVm2VWPMnk+jZNNn5FkzrfLXTM5E5aNAjJt9aoduGjsv916fuUzASO9guLRMN5y
         jSNTG44cSJdy3/rl15cZmUT4e6tosTsnWLUu6q0qtHjGB9EDZ2U7IIJxJ/S/3kyu8xHl
         GuhBZrF9UmwSclQYgAQMtMyo1OlTGvkgmAvIaAZYsGJUUVQyF82yI+x+ZxV86i+QjlVh
         x4f0utW+FzE/B1i8niZKjB5qaxUy6S34AYnDZIJal7jn8+H4ImxTK1vaAgYqCL9IIavj
         91fAx8iSC2A4AJ5icQdIISpufIXd2xzXpSXc5o67CPfmijLcWnfwHSIZSYd5qGu9DLY0
         67tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787783006; x=1788387806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHtBci+7WqjdzbXMCO1Bw7FN1oZt8E0+8PQeHHnAE4w=;
        b=RNBw2nKwkcF3GYWfyZluJkJ1fbulFEAV/JJV3tMNmxZCEDckRFK0TkxyZKc0sLT7fQ
         1pIsswxNB1izodXb2Vgy4v0YEFTtPkNeRw3/BARGF+x3VEbLrCKNlAAIIYMQsQ0phkPX
         tPHxRYD2lY1Gb0v+hdRhNt16sda5pFKwCDJteVui3ti0vr8FFQzqy+EQJffFUk4nshV3
         WN/vX8ra8IjZqkeoTs3OPaMdhtgndhuYSXjUmku3Z4cs+wzIWL8AGEjpSoHBy62CDuh+
         1qfHaYowrebNQv7AqZ+2CbbKpDjlH9Gd6CEsHbVzOYpu/eeF3vxmyPbK7Ml/PILEW+oL
         aJOA==
X-Forwarded-Encrypted: i=1; AHgh+RooHMTb5Hk1R1ygh+/7n0q9czuIjlhw8wrbxVO1LRTnfcOr/9Q2GKMmI0kuJJ5zvpgOfvJk1TGjtQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mz07pvBiWCD30V5sJkfJUfCxvyGfGHNuFY39t7OS3jjVDC+VPk
	UTs74Po+zhXFuTewRwqoLSAuYJCEGSEY300b97eHT8heglc+h7ktrGsPzXnWuspBsu0=
X-Gm-Gg: AR+sD12tjQcA33/OiPupdm0DdMW9GxGC6b04ZPjVpTEVqnH1Me1C/Mmj4jOivopUnvh
	qG8/F/5nNhAKjP7mWy8e/upDSxx+KzpimX/XzIIERuau5P6oEKA+uTAVFvwCyqTIVFjPQwGxC16
	lzexTPx9VPPyYc8321M1+DoVP5aImhYSU5Xgx4M3l9zGr72dhN17oGo19dA9SHKtBPl6v5dRKCH
	AnkYyJ0FWLS6YfOCjGCH95n8aZbzeM6jQTRNgT60yHRpOA1mbbFPaZUSYqWdxxxVdUeNNhcMXQs
	97dAWBWbNVpxUNO3mddCGR6YZ0pcSyZv7yKT1OnPJZxmWNv5Uuij5rInC2NXJhT5uv+PT+0bJuS
	a4gzWb6hglOUUUikctFNzJSRtTc/RUgjejFkLpB3LN5kwPZWilvsvc65wav1eENthdmFpS761IA
	FfSVk9GzZTCscDS0QLihVkAIEtbqJDEddEtelNkhSy+9fKsYOvOBmf15PcGA==
X-Received: by 2002:a17:90a:e7cb:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3969bb7ae09mr2031694a91.5.1787783006026;
        Wed, 26 Aug 2026 15:23:26 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-396b1123142sm25952a91.15.2026.08.26.15.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:23:25 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 26 Aug 2026 15:23:19 -0700
Subject: [PATCH v5 1/4] PM / QoS: add flag to indicate latency applies
 system-wide
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-topic-lpm-pmdomain-device-constraints-v5-1-28cbf43f7e38@baylibre.com>
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
In-Reply-To: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=76GWlvs2S6RvtzUC9P3JnexZlLh1ZyGKNxkhMVs2ZXE=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqj2dbUSE3zZgL6ihQq1NtmctUKHMNjRIetQSux
 PWtyJ0p3cuJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCao9nWwAKCRBZNxia0/vG
 ZYdWEACEuZstO7lQt3ypK8PXJqvKCK0x3y3ZEU0KlAthu17gPvIZNfUqua7LCr5HvmXZlL5VecV
 R3fKztBG0mYehpzm76hrIAZIY9VNNxoFwDx4grwpbVQr+zN+HcngXiU0/yECSkdL3UPVINTo8Eg
 pDfwrLR1xQOtHQiEU/aMhy6rCaTpT1MtJn6mRRwtK1LLCfPemx6xb3FMqF5gtV69DB7B86k3t1t
 HxPh4eVgTFxAtCpuhyBnEZTA6pg1JP6ZoVhw7X6uKAnkvwcTJWBXimSh3sLY8i6IdgE+4m0f95P
 UJOiAxAJi9lN68uJSe6zfZAN3bHjN3X7Hq2JdCsOnPzZptzhPb4wMBHZrQOy1nJa2vR315ZQEVq
 xU3n/6vMDPdPm/RuZDuWZv+XqmYS6gl9Jkp3gpo+lIq9LwLQ6E04b1Woy33c8w2z9jQzE4eRwI8
 PTQvx9lnzKo9vyk8AuAtKgwleCi5vgYeFSYHyDuuqkFqLSyQKFO7RxQ0Cijisudcu/UWQ0+PTn+
 wNb25Hd5U2P3yYR9wl4uW68eaCfJ8B7PXRUVhD8oYGnhgn6ivnEaU6yAJew3B3cH+ECxyZlzxk6
 xvf7qPvorSavJkcE0ZVyBF0j8c9WdX4HUqtNFvx/nuJH08oPHrTvGnfpLwPWZMNV/PrEta/xVVz
 W3aGhdVnKuhoheA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

By default, the QoS resume latency currenly only applied to runtime PM
decisions.

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume latency QoS constraint should be applied to system-wide
PM *in addition to* runtime PM.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..aededda52b6b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -37,6 +37,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
+/* latency value applies to system-wide suspend/s2idle */
+#define PM_QOS_FLAG_LATENCY_SYS		(2 << 0)
 
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,

-- 
2.47.3

