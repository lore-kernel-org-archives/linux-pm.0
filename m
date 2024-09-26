Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81942AF1C
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361980; cv=none; b=bOymN4cM5QUXVm+AcJDRoz6vcKJtIpEDAZhmmnT/rN8ix4z0uDf+l2z4HGxkMkkNWa/MwtOuh1l5RdrL4PLgcQNzhnf0EfTMlRFJfJF4edLijlDPCj04gWw3GmuEkF8BNFfZoZTAGYjT/ZHxuz/Y0DsTlmJTzb+iPQ7aAz1XcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361980; c=relaxed/simple;
	bh=l685H206bV/ZtaIlp4CDv92ICY1j9yk/GrcIovfJQj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYf8NyskSIfQkDLYVbCv3yryqU20HWaYda6OWvBJsLbxKgQAQu7DPjRYeqRWa2PEee4tdrF1mleHq0ZMZvZWxRiuFylLJdZ0bhoYelt6Ck1TKweKuwpzIuThY463T3/W5LZvEQWkwbtJYKYTiJOwQ2LfBiEMMHGxWXwkpuIPDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF6gv5hQ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF6gv5hQ"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e0465e6bd5so552062b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727361978; x=1727966778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoCyxmzoTrojS+1jgv1EV/Qci10hCLEnIb9ThWnwI98=;
        b=RF6gv5hQsLTvflQ60R+aap5DfyETl1DLaoHSR9u/97+a3Yqy46tKhj0OVp9CBjm1Fk
         6wbYTlaiDYhaD8XEAwHGjk1se5xD9IXWiHS8mYKzdQ+4sAj3r/SPCLKAY3ZU5A0D8kME
         iIOyk5NRSa3fAoB2ODwlK89HqPrCc/5ZJ+Fg94Ma4vS6uemRyuuEOBMfKjN3fLgvvq+D
         BynE2kxm8jmZk6MBSgju00t8r7ISxF8T78htXbLvRMirsqOigr/KJ+X5xQ5xe5dSvMxS
         +bsnMHzJ89gKiVAqiK+OSDQanPhQf6Ny7I6pXPZLASs6mMwO/iv2eNwLW3Vyq/hPrPsP
         cPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361978; x=1727966778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoCyxmzoTrojS+1jgv1EV/Qci10hCLEnIb9ThWnwI98=;
        b=n7NQW9CFWOGp+l87MIjqrdMM7ixM/60+kg3/zE1gUcdtsZ3KLYNmc/wpdQeuJQ4ENO
         ZHxe6bUpigZUvMAerApQ9lS8XvAVpy0UxqGu8BwTzna/13LO9NPOExrUljOrK8MS2/vL
         PeIHtkvnIu4XUnCpTyhvku1PT+0TY8TMDEh0ydbW1GTxNAxANQceLymktiR3gv7C4JCX
         +bNcUvigY09kBLZe1hRNkn4ia0fqSsR2SYjbyefkI1cT0FU6aFseyy1jJYtKlCKwb2c7
         xKO+mHl+mEMu4FbiZTjbahvBrTG5aAh9S2KSMdj+SWHI/Ujrh4fiogTr+Pc1X0L7TRaJ
         iQNw==
X-Gm-Message-State: AOJu0YwOQVtm47SHQhxzvwrktgfhTldXfcENWHzAs53J9CPvbYjDpVf7
	N6wyL53VA01Bw9rGjrVRb8z3bStUEO3jjP+8ZUZRPQ+LMWRQu3IoeBGYfLTh
X-Google-Smtp-Source: AGHT+IH7L3/GqV6W+uabKm3KjpzW48TJOwzK8TGZSyJxgA/uByC7s7CBzxlq/Rpyd0rPflJg0RFouQ==
X-Received: by 2002:a05:6808:120d:b0:3e0:4db9:8c44 with SMTP id 5614622812f47-3e29b7bbf60mr5819718b6e.27.1727361977644;
        Thu, 26 Sep 2024 07:46:17 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e39358753esm5268b6e.24.2024.09.26.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:46:17 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] power: supply: rk817: stop updating info in suspend
Date: Thu, 26 Sep 2024 09:43:45 -0500
Message-Id: <20240926144346.94630-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926144346.94630-1-macroalpha82@gmail.com>
References: <20240926144346.94630-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The driver has a thread that checks the battery every 8 seconds. Stop
this thread during device suspend as while the device is suspended not
all values seem to be read correctly (such as battery voltage). The
resume function triggers the thread to start again.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index a3d377a32b49..d81fc7bd1cd2 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1202,6 +1202,15 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused rk817_suspend(struct device *dev)
+{
+	struct rk817_charger *charger = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&charger->work);
+
+	return 0;
+}
+
 static int __maybe_unused rk817_resume(struct device *dev)
 {
 
@@ -1213,7 +1222,7 @@ static int __maybe_unused rk817_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rk817_charger_pm, NULL, rk817_resume);
+static SIMPLE_DEV_PM_OPS(rk817_charger_pm, rk817_suspend, rk817_resume);
 
 static struct platform_driver rk817_charger_driver = {
 	.probe    = rk817_charger_probe,
-- 
2.34.1

