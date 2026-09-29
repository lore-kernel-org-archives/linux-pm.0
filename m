Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C8501297
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676380; cv=none; b=LwfVdFHsKlT0wlKh6eOg7WeH/aH4rmJsZ/nC6Vd8+KOg1lk0xXgX/VRMsqlIXfHENzHMZsx7PZXyw+gw4xtx8K8sTBKng0IyxRH54oyb4lOaxWm4gi3Tt4dmzhXuMZnorXwLWugDtQBCxtqKNO8V9VQFBe0m26TuHvwlNk8/ymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676380; c=relaxed/simple;
	bh=ShugmlWzQ+axlYeISSDfAQXNJTdMsRRo0wVSobYI9Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmhVo+JcwGGdS6XYpHqaoXs3MU8xb5Dh4y1UZS5XXb8rAREf/VBNc09fF74VV/9BL6aT2wzlf9b2ElQHHvsmjE9CXqzcuLKQTG2sj5dFWqaMk547tIlxLcit/vAmQO5FyFf3xIYvLyJKWDK4J3Ljc91yzyz1bBfeYbuLpK+Rb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=RvTe9qwd; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="RvTe9qwd"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so31454025e9.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676366; x=1791281166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ukRavR0+R/g1KM+J7IJTcCj4Xa6LxCCXFXLdFwBmwpU=;
        b=RvTe9qwdS1wtNDCbRIsnLKiGnXTSYhU2aArwaWST3kti5NAgzI9/ti+VrT0JvAfRUy
         EIse878ODl5LNjlTy77n0YsyRPZtmaf3zbrrpDUCKMUrcvxI8DfyuUXuxn6hsBRz8eav
         MofcGLgEhgR2cL4LSbyD27ey4vcmTXMRe16OVWPSYGXmvogqaP+xD8YT8xVb3p1M+BMV
         yvq0Nz7aBFW/FNB2Y+/hayCxVbXb0aQUrKZKEy5hOjVCIdY7+YSOE+k0oZjS9RZKlkmL
         4pD+ZxX/9Q+COGYbNcF0vMBJWrspteZ+G27rS8ku0uH77CX4/A0RJLCRobao4efjIA2r
         q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676366; x=1791281166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukRavR0+R/g1KM+J7IJTcCj4Xa6LxCCXFXLdFwBmwpU=;
        b=h4ebcjvhkmpVLOPQCq9TgUzHspMtfHNh6wNlLEbBn7YtLgS7n3GaNeqj9eBRWPG0TN
         4Ncti4i+GaxWiKYst10XXAojRnPR/ZAPoEeIwgIW/AvT4qHbL+r287S+GDOlMMkFW52F
         6iRmjKGSBVpvuBGk7aHFvs61fhlFHA4C0PSk7o1rp/Q+KGOABb5vW/r6qd2UvHFri8YR
         yUoCHMiDwPbtWmrNYY65ly43QijkhzTLsrjCNRp6derdMU+MO3k7clr3KN5Wgqfacmpy
         kQ/6ttnHnbxiytnePkfy9b9riHUvY2btnABL0a1T49u/HSlJYdQtZTN4dS5BA1PTshgf
         CCFg==
X-Forwarded-Encrypted: i=1; AKwUvByC56/R2HNKzopIcwF1J7rVwY+eaHlsKdLQNqV0TeE6BSdmCWZ6pdXlvRUfVH4T/xLmEWnmWOJ2cA==@vger.kernel.org
X-Gm-Message-State: AFuF++n3HD4oT1dxUx9KeCaNrkqLMWt20ewmCqPMtP1rxRkSYWbRo+1K
	viSO2qQEgl8qPG1N3TR2t838mDSeQ+fTM0I+5vd3Md0Lau+HzuwhWXtTv4oDKzngE6Y=
X-Gm-Gg: AYBFou1RSElIuA2cSjUBBWK3xvxv7e5a0xLR2hUjn9LFJLs/lwxAslUdzlL9cj7Tgem
	jnkESMHQiT2+Ktcr6xgLwEaa0n4qaEhM/LvXp7aG/TmAfnxZWZaHecpIu2vVgfH/yk3OIUQZ9xl
	lJ8WR43Q1xMXUv7fSjtsWIi+uX2Oqhgd9JMhjhIleI+iivtTYo2NFuwtg5j7YOmfjAXzpqFZB8d
	6XlpAFoWl2zPCGtzj3FbkSZf+iuk9zUiJgou2OOmsr+c1NdT+Xqfh2BrY9/0nElcBkIYPRlqKFj
	1Mt8MqDLjxsKrl4Ub8Cdwz63Y8bKRLqYBG5glKyYxVkr3chDGa4m65G/jSwONfY08/QC4PUyXH5
	zpUnfgArZbP5610ONqQ1dxDxsBT+RJJQt48u+1uoueUTQ8Pleur/2bwiD/blbxUATsUUiwaQgZh
	1hJFCY5VHy/Z//ka/U+3CoPlDtdVmgzaoAQ1fDCQ/CGY/mYE7QzIu7zSQeSDSQhqxcGqTRrGNPd
	BKe2kHDa/g53lpe
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fe66f9fe3mr275023955e9.31.1790676365876;
        Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:48 +0400
Subject: [PATCH 3/4] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-3-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ShugmlWzQ+axlYeISSDfAQXNJTdMsRRo0wVSobYI9Tk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m15c+pMVMvP3nmVCzY9SDy54GzM04bw+nyrExdDN
 4lf7QwT7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqi68wMsxI18jebmlg+G2XWuSld11BNwUXLzhvdu4BV43+y3UyJnsYGdYwz2/
 +37siqnD9lao/K0uSyrjlHCKu6x9m8l7JoTqLnQUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
pwrseq-pcie-m2.c never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 91916768e922..0febe4b3d980 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -613,6 +613,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 err_free_regulators:
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 
 	return ret;
 }
@@ -626,6 +627,7 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.55.0

