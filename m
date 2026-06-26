Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D302D7393
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466224; cv=none; b=Bm7OXZROei5sr8YdNiXk6vNAsLM5K+MCllaAomFxkagZBrp8IfaSmYrBLXz0t11GmV1tv9d1DGyx7CRY3Zk3ewgAlvhGLdd92NE/Y2rVB0U2pd8otcjuWJ2alBz/MpTEbco1YA0HiVD7TFHnXQKwHoHep/V+WLSbSu1LeWd+Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466224; c=relaxed/simple;
	bh=5TCVCZYMsHwklgptT0a+ukl8cIrb+npq0Sev7Hs4aAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtqowJhLycDB4LR+L8m8x3qSmQbsFTfneuMgk6wkoBZiXwLA4V49KBx4gOUL23H07QpCoEwA57msL5n7xYThHkZdc8GAqRtyTHKqgZFT2klBWDXPBoJxvL/Z9JjV4TA0kNXzJvqg605djmyC963MVp8cqR8oYGOrQdbb+0npZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pd49guFI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd49guFI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6bb8a5980so6212905ad.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466222; x=1783071022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUNxVgExdJDYrlTYUIFt1iBi5SI3UCc/8A0H3G/YdC4=;
        b=pd49guFIfOSWKS3ugmrawmV1Rjv3x5blFozIogKD0nlLIHN3ePI1FYTm1j4eJFnIoK
         NiS+tmK814FChC3/vJN/dbVBacXjMH3+cXM5kaXaWCILNGDXAomlFnegDGH8k5Y+MFx0
         W0vPV6QK+M0knmSS2ENJaxLvJQvk6K4q/4YM9P25jEUh8GOOjJSVR4JrFVPpveXs3FjO
         SIMSq9FCSf/dBuIlwvb1FWKun4GkFpK//8CGjmRCGNF0vBm7aLLf2ORGV5N1Rf5xFpsk
         PJwO0nQg4ccaH9+WRDGJ6fOtE/L560xBxQVcEvn6+n0GzvnUGa0zoTPQlQwGAFqUzng6
         63kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466222; x=1783071022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUNxVgExdJDYrlTYUIFt1iBi5SI3UCc/8A0H3G/YdC4=;
        b=ejjQXSTUHS7auaVtXYhHjOWgM9MMglfK0go7t4SJ1ShzWbLqDRkmstoPJ+R1tXrUqt
         XL/C7q2Dk2t9xAX1+cIrHfV9xUi/4JJQV+U04MNneSRpcZLpqVdkv8Pmcf+Y+ivRwf1k
         kiQdKRV8xxD7uhAIVMI0VEZhkxQ+KLkkhe0EAB8yr819N0c/Mvhwm2hcxV3xh58ThIo/
         zZnPAuT8WR2kQm0D5NAj8Bb2/ahrvFXKa9EZ/ImV+/Ysmt9Dc/BnfPcBAFpTPmwMvK+3
         JKgLpD958I6i3q1ozsRV0035aWuXoOfsW/qlU+fjObMQAwl0AwWsi/hsLtqGop5QlEIZ
         3+Qg==
X-Forwarded-Encrypted: i=1; AHgh+RqSu7x15w9KefvKmYJooT5IcaUByH/xgb8wAWk/N7ZbyqFYk9hFU0+JNIeR46GuxlRNdCSV5Peh6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+Q/w9ehL/NaNtTnMJ1AE8W4RmdtTcLkTtugl0fsTipfawlCa
	3q6S1oOAyaBQLGe3xnC/gwCwzkOZyKRB/gnTRIsoV1bNA+UAji0AF8o=
X-Gm-Gg: AfdE7clBjoSRcIP+0O0L9jR9hj+EY/uE0y27y0+r9rSzCs6blyXOgdJ66VT6elDPRb4
	2+fibONzTyUY0u3WPQPzL9NT9I8qPTYnNn/kymYQl+1nJ8RhIVFijx3GRy9Q4c0YMHZamfHcy9I
	Sdx1sdhnHvf+PMsCH9x9b29w3ObIH0ZSi7hmZ5JkVwqCw04TAVfRqUbZDUuyUsqAJe3LKJr5cL8
	Y5DskVU69gyX5OhYmyFH+557pPbD/wCBCSolGVzGOlKXJO4BTUVe53dvSkDyhdiFUo7WDb/orGZ
	WFKog/YOOesAi0VKc2P+5vms1139cj2TITnfsq1uCarMSvbytYGji5J3SN87YHjP8IGt4FobnHW
	G82LpGn+SBpZYzzp6k6RJzISyErCclpEFKsnmYMwJ0cG8oDeE/IOZu0nhd1T3n28Pj4aWtWG60v
	/y09jzknuKPFbfXgvJN7AxR/1j6lgUe2mwnzJqjKaOvk+1GBbXXOcBfsLWAcY1v51Pyl6pOym1L
	l0tSQzh7P52z+FoYIt7e2ciWOQvZ0balIjzbjxG12wIpeounQ==
X-Received: by 2002:a17:902:d510:b0:2c7:9b20:37de with SMTP id d9443c01a7336-2c7fc62db17mr57730425ad.4.1782466222006;
        Fri, 26 Jun 2026 02:30:22 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b2bd7sm35408435ad.48.2026.06.26.02.30.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 02:30:19 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] cpufreq: tegra124: Disable DFLL clock on removal
Date: Fri, 26 Jun 2026 18:30:14 +0900
Message-Id: <20260626093014.66092-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tegra124_cpu_switch_to_dfll() enables the DFLL clock before switching
the CPU clock parent to it. If cpufreq_dt_pdev_register() fails after
that point, or when the driver is removed, the driver only drops clock
references and never disables the enabled DFLL clock.

Add a helper for switching the CPU back to PLLP and disabling DFLL, then
use it in the post-DFLL probe unwind path and in remove.

Fixes: 9f5ed5fe6060 ("cpufreq: tegra124: do not handle the CPU rail")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/cpufreq/tegra124-cpufreq.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index f8a76bbec..1fb3bf50b 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -54,12 +54,25 @@
 	return ret;
 }
 
+static int tegra124_cpu_disable_dfll(struct tegra124_cpufreq_priv *priv)
+{
+	int ret;
+
+	ret = clk_set_parent(priv->cpu_clk, priv->pllp_clk);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(priv->dfll_clk);
+
+	return 0;
+}
+
 static int tegra124_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np __free(device_node) = of_cpu_device_node_get(0);
 	struct tegra124_cpufreq_priv *priv;
 	struct device *cpu_dev;
-	int ret;
+	int err, ret;
 
 	if (!np)
 		return -ENODEV;
@@ -101,13 +114,17 @@
 	priv->cpufreq_dt_pdev = cpufreq_dt_pdev_register(&pdev->dev);
 	if (IS_ERR(priv->cpufreq_dt_pdev)) {
 		ret = PTR_ERR(priv->cpufreq_dt_pdev);
-		goto out_put_pllp_clk;
+		goto out_disable_dfll;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
 
+out_disable_dfll:
+	err = tegra124_cpu_disable_dfll(priv);
+	if (err)
+		dev_err(&pdev->dev, "failed to disable DFLL clock: %d\n", err);
 out_put_pllp_clk:
 	clk_put(priv->pllp_clk);
 out_put_pllx_clk:
@@ -175,12 +192,17 @@
 static void tegra124_cpufreq_remove(struct platform_device *pdev)
 {
 	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
+	int err;
 
 	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
 		platform_device_unregister(priv->cpufreq_dt_pdev);
 		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
 	}
 
+	err = tegra124_cpu_disable_dfll(priv);
+	if (err)
+		dev_err(&pdev->dev, "failed to disable DFLL clock: %d\n", err);
+
 	clk_put(priv->pllp_clk);
 	clk_put(priv->pllx_clk);
 	clk_put(priv->dfll_clk);
-- 
2.39.5
