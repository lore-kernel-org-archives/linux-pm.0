Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DB4582D8
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240392; cv=none; b=ls14vV0+mfApLxTPkSwKF60ZZ1mfnC5AFQK+z/qo4ZJiEo5jjmJ6VPyt0WRjisDInIujSYrsVT37z7B9eJr9t9ZFczyqh6UfdJ9Ol9WgcwWEVKHQGTujnzwiJoJn1hm6sAepfFxcYDz9gb0E6VdWdfTYMSsq6WvkMqwphp6mgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240392; c=relaxed/simple;
	bh=3EjLPMtvKg2GmNImlqYJqrTo1wBe3j2XE35A47khzrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgOC+UabaiFEI0etl3KP1nuc5I0Mf4DUBxGu06rFg6f97U7887beMtmH5JKxFgGBNHtZhH1pVtQMU+/rvEgLMCJv3LjxnLXJJE3uYUulCxl27zoM+9Kma9BB+hE5dZxl6bCujBlcqpEwkWGzC0whHjpAswsJvucQmvflpq4gFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxUnVPSY; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxUnVPSY"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1278825b3a.3
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240388; x=1789845188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HIyoexeJaOf4GZ5Mzi02CK37U3A8OAhoynQEmxQpvQ=;
        b=oxUnVPSYBtPggWEn+MOfo9FXtx4DX3lANkbForUWBr8rbfzzKFho2+GfJafWnmw4OL
         n3vHsJjXCFk3o4Q7FgAN83gZjSajGkp+GqDPoEcpb376qaFj9h/yV8raEBElqhKe5t/K
         ryVsIKWdnwyeIv8PB+AHTIdsfhAOWJmlKQVqaUq5fZk95m3ysHWXL/SmfmF0858VsKKq
         k+LhXNRLAIZI0+GtKMaENAeT/9rNZQs9GmE1A5ATzVN2TVDvUTShl750BD6Lsux4UvBT
         u7QcRLVe93kQpOGgHVjWbbQLoisJAk9k/y7okfNpbRMehmsUX3x3KEsmwGTLQQl0kPDP
         AZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240388; x=1789845188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HIyoexeJaOf4GZ5Mzi02CK37U3A8OAhoynQEmxQpvQ=;
        b=nnIkaCPvACrEsfCtVm5vWDut8ZON9kZIw0CkGgLFCEIyOK0Cwp5aUZCZnUSj2gdth9
         7YSRH3UAYK75xMChByJFo/HaygB48wrsTN12PAs8v7n/azozITQ3hC6nCqriAtAKeN87
         MJp/dg4KUpy78jYbJt2b6fwRTdk6JpSu0fSJME8/AxeTkQVT/VWkDW3f2xVB7emrSkdF
         bRXgWMNe/UTDFUPL+loimZ6f72Tcrj55bR7cACxmavEzenO2gMSJLRrIBVJIdpB6CfQS
         CvXvHO3a6tG/9lOUVDTE2/xnN31clX50gfCrIAtJNb+P0Y2yJrAqwWTvudQKw/DmKqXW
         3euQ==
X-Forwarded-Encrypted: i=1; AKwUvBx65FkadRFJ3OTgwhu9a1i+1ytVJQvgyQH5oFgAhJOOeLBp1JZiBlPT9wbhTbeGeCq4tKpmbdcmgw==@vger.kernel.org
X-Gm-Message-State: AFuF++n6P1rj6JSahuFm8ufUSRxeUG9oyN6JQYPUxBXqUdSTldq7ZyPT
	TMFrjXolSXIfLok1NFtXAL0xoJBEM2IQWz3dD420Us5rT+VV9p/tfg5K
X-Gm-Gg: AYBFou3k/BO+IcwPoDAvDzz1MXvcL49S7wJhdWv8MlMNN1rNkNtdmi5HzlZv08DsYbA
	A7GbVZORyr9xF8hku6FAlPDsak0yJQq1gVJ/eJa1OZ20i962hSxa74IO74uWmFVS2tS6nZTfMXH
	XbTptQWB3LTlyzqeMeNKbcn4LT30JUuS7PNDvPHWWS4u5D8j7Fv870qd8/6n5ScoDef4FjR5dcw
	AUyqqLXcF/epWyY4gptrPKUFr3S4MIvkVfkS5GjstCXUpv4ScxgFKkB6+iI9vX83GQdTXYdgYWx
	rPS4On48wV1FuPybsyxCaqW9DAxjvUnWA4xlGmV6Rxk2zy2AhkpW1mwrvGu3Z1hQdZ5eMA4pMzV
	lXLF4wyPOvGPmB1yHNogZbbzyVB+eN4t5JUtkYng2lrVVZuugIVFUT13Ok4g2crWcpdpqmfElvt
	nMzKXTEtgSn6M3ZqP8E6SwjPRm7sS9XqUgzQzipRDNeh/mJm9s8aEL4v8srckt9de2gptj
X-Received: by 2002:a05:6a20:d807:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3daed15f5b6mr20435411637.8.1789240388372;
        Sat, 12 Sep 2026 12:13:08 -0700 (PDT)
Received: from gmail.com ([58.84.61.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm14722239c88.3.2026.09.12.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 12:13:07 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	krzk@kernel.org,
	amit.kachhap@gmail.com,
	daniel.lezcano@kernel.org,
	thara.gopinath@gmail.com,
	talel@amazon.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	mmayer@broadcom.com,
	viresh.kumar@linaro.org,
	sumitg@nvidia.com,
	peter.griffin@linaro.org,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sven@kernel.org,
	j@jannau.net,
	marcan@marcan.st,
	casey.connolly@linaro.org,
	sre@kernel.org,
	wens@kernel.org,
	t.schramm@manjaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH v2 4/5] thermal: Use %pe to print error pointers symbolically
Date: Sun, 13 Sep 2026 00:41:54 +0530
Message-ID: <20260912191156.185448-5-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912191156.185448-1-sumeet4linux@gmail.com>
References: <20260912191156.185448-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
to pr_err() and dev_err(). The %pe format specifier prints a symbolic error
name (e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled, otherwise it
falls back gracefully and prints the raw integer value. This makes messages
more readable without any functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/cpufreq_cooling.c        | 4 ++--
 drivers/thermal/devfreq_cooling.c        | 4 ++--
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 768859a7aed0..856d619370db 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -661,8 +661,8 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, em);
 		if (IS_ERR(cdev)) {
-			pr_err("cpufreq_cooling: cpu%d failed to register as cooling device: %ld\n",
-			       policy->cpu, PTR_ERR(cdev));
+			pr_err("cpufreq_cooling: cpu%d failed to register as cooling device: %pe\n",
+			       policy->cpu, cdev);
 			cdev = NULL;
 		}
 	}
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 0330a8112832..9ada52cbf7dd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -156,8 +156,8 @@ static unsigned long get_voltage(struct devfreq *df, unsigned long freq)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
 	if (IS_ERR(opp)) {
-		dev_err_ratelimited(dev, "Failed to find OPP for frequency %lu: %ld\n",
-				    freq, PTR_ERR(opp));
+		dev_err_ratelimited(dev, "Failed to find OPP for frequency %lu: %pe\n",
+				    freq, opp);
 		return 0;
 	}
 
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index af72db6299cd..4554a6fa55d1 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -680,8 +680,8 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 				continue;
 			}
 
-			dev_err(adc_tm->dev, "Error registering TZ zone for channel %d: %ld\n",
-				adc_tm->channels[i].channel, PTR_ERR(tzd));
+			dev_err(adc_tm->dev, "Error registering TZ zone for channel %d: %pe\n",
+				adc_tm->channels[i].channel, tzd);
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
-- 
2.43.0

