Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB3332ECB
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292554; cv=none; b=ivLRVUqa3M64l5r0fU0u6/YjSu4qYBSb5YjlHArJUnpn+RZlJlVxgKaYQG7wUWbQAu6pPtV9wZp5s01i3t2ohwEeTMvGtsh4LgKowY9/IzbFA7SZLZ6Dl3ogrEsS8HY6zDZuRSwyF/yZYJgE7U5trG8y2hkKQA+7nSnZcC8ZHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292554; c=relaxed/simple;
	bh=/GG9HDZ1S07BiQPboyg7BK9uXBaHXRo71xOtjnxUVh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TF8jGL+fwZKrqMW/A6cIT6tm/LNT/U0Anaqh/jf/C2v0+DxBLiMP2lX7Z1jhFiLXHAGRJOj+Z9x+u5s9hJUbi+Qe0J3BpvBjcA9QqS0M4MamLU/soW5Sn+JnYaFL0YMCRjdbS82/7JqHSTP2gvmZIs7/ZxY7wztLWbEuH9GZcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FONIzgU6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FONIzgU6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso67260575e9.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292550; x=1779897350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOxCa0nAdk2kPR8ljw7z0QC4wu57IzFw2yREzNsnu4Q=;
        b=FONIzgU6ghGimqkhMZ+REDB9pJYkNFjAEbVkQmGaC6LkPcRC3J7Y2rGrIlKzWsGsJo
         Czg5FdBrUNgBPd3v9z3BToKe135IJ8PaA2w7HZIc99p7+IlVxGRlY3Wn8oCTPrIRvDMo
         YGh7JlUDij1b8zx4ZS6+/f6S3+2bYZ6SyUpa7e76ocBCc0mOCxpJP+T4teKS33aT6prt
         IqZHMrussNfEVcqGRlW96So5vrLLGCT7eA4LxJdNXkEPYYf1EHJfKtiu3rhu2db5vWMA
         LUR1qRN8w/fDgkoW9Qyn0YrKfzz8R8R5t4OVBv50bez3FTU44ZiQbluUn12qI7s3coBx
         ggbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292550; x=1779897350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hOxCa0nAdk2kPR8ljw7z0QC4wu57IzFw2yREzNsnu4Q=;
        b=fqGKJP97p44uAhplXwd1rJRClRxZ+t4WJFJca/P1v9deZoMGMF18I+zrRPyQLYIjLI
         lCtC7kACc44wTljQotW8c0UuBhj9Olh1uLY2KDIb90T4EJz4kzwrqTdlYb8kfRD45WTx
         JxsVUVe0gbF0RnlgqZxnpA4JXsD5XILXDAf/K2it8sdZaUKnhW7av0KGc6euGamiQSDm
         neDmain3KtfzYx9rMkppD4JfErkXet2+qDGuAwcWtLb9uoKSUxPGrPXVWg5ps41vQPsI
         NgM6+sXyAF2VFEMp08upTocLOOVOkGOgxYn03Z6Kc5r8pgqqOnrdxFe1IhZjMM1uPnHD
         CdVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cRXZ71h34C9WT8URvO38+DBBhE+TXue0Y7fqffqDfDeQr8v09xXxCorBOtLEI/DnUMORQhgzsTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjU03XQKQis7YWRRWJjAVf4vpxniSGFQ0UQ3+vOtlUC0DRJPO
	a2w1VISppxdGMjkZZhjZzwHdCUkgqtPfkg5App/TUOva/4357T+vWepN
X-Gm-Gg: Acq92OF1iDnTfPjbgOlW+ldrWx3l0V6hacf/FPdUMFitKS+Py8Q0NxdHe7Kj9tzhbAe
	7QnkN7kuFOUff0QN25gYuWQM6TJCRjiJU2+oYJw77tVVFCrEBdiCLSHTS32b3JeRf+YxhtW3HV+
	LQ/vjRiCObGfGxyCR/9UljoeNrxYRU0jr6Uc596cRrXDGinOSxHckQhMNdzK3RKJhcOIMXS8Er8
	pEtP0gOHjYDNMIuN2fsshZKVScRphvh1eGb5WNd/DZ5VmlmnK7cx5UKM+Z0oezOrXF2Y67PeCCo
	YVLjB9E8swuh/wrOlsFvpB/DjB5Uygr7rl2iWwgE4PY1vX2VdjQJWtKjwzlXqHBSHGhGA28vKaA
	LwJ43yfHc5p/AZznIYEVLldGAHpVbacnA4cVKVqfN2trP3URwGGbqPSk+PiLV6fo8L9EgGoCKzC
	VAC3ze4RlPTNjBRsiKT+QxjplllhwyzYRj3m7liSstShVZ/ydPYhwtzUjG4a9Gv7CTWyTGxqq3C
	Q==
X-Received: by 2002:a05:600c:4692:b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-48fe6325792mr384226205e9.16.1779292550440;
        Wed, 20 May 2026 08:55:50 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-22-5-99.retail.telecomitalia.it. [79.22.5.99])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fed253f93sm132123215e9.16.2026.05.20.08.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:55:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 2/7] thermal/drivers: airoha: fix copy paste error for sen internal
Date: Wed, 20 May 2026 17:55:15 +0200
Message-ID: <20260520155525.22239-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520155525.22239-1-ansuelsmth@gmail.com>
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In airoha_thermal_setup_monitor there is a copy paste error on configuring
the internval for temp monitor. Fix the error and use the correct mask for
the sen interval for the EN7581_TEMPMONCTL2 register.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 439aa011b75c..829a7327fc40 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -403,7 +403,7 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * sen interval is 379 * 52.715us = 19.97ms
 	 */
 	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
-	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
+	       FIELD_PREP(EN7581_SEN_INTERVAL, 379),
 	       priv->base + EN7581_TEMPMONCTL2);
 
 	/* AHB poll is set to 146 * 68.64 = 10.02us */
-- 
2.53.0

