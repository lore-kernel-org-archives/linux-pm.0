Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0B340410
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895089; cv=none; b=K9Hgca8JLuhFO4YkrwpgbVQLZdu2l4XMz6ehryHJtHzNgJ26GJ4BhDBegzKyHLhNJo0enBZdE7LSrBpCfHvSnJyV7fcqf84gncFwrwUyjvpXpuPRHB9Vt0urrhcthGIqHGBwovWJhOLUWI6wlENerMMEUMEzMoNZxDUjCfWbBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895089; c=relaxed/simple;
	bh=asqAK3SoXu8/htKWhVGXzuock8mQJTHGvtneCHlq64k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JStTZNxc7Jhw9gQ3PazLEw896dUQV4Bd6k559Fld1m6OYoHfWZ+r8ddh4wsgAHLdOJKRA6phudkzxmDe9yF24kZRwd69bEXxoZ2Jc6+yDFQmExL2N5MsyVHmMT31CzgFl2EI0lalxZfVboRHqzu/0Ic5eG0Bob7Vbc+2ra84olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYBVQ3Ar; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYBVQ3Ar"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1604181b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895087; x=1781499887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Msw1JwiAso6BYV3Ybo65LRpP2frOXynj3tYTZ5sNuE=;
        b=dYBVQ3ArTyGLFiKery8a0XcppHqj1Ij3kdCiHdCOHd63haKOcwjo4LXJGo93FDNDRz
         yX3wMCQXy8T7AG6qVd7Z80TQcHfHhkanVGFVN+T2ODN6MCrY/Icm2lZHY3mBidfult+n
         jpBo7MFcFf85NfejhzhgYffUc+fNkbG0PJuS36NGjPOQxff9mxg0tY97ywmNv1NFyP70
         I2a4Je29W6SjNxS6CTh1bkHl8G8A3EzvsriEU+fSXkaDLkxqPn8MArMRJpYFqd7xzfPg
         QQuEZS6Lp9zNVDyRMF/hOlzAH2EGv67ZKajq9/k8RHbqhH17rZz/ceLuyKmJ+9pqWusQ
         +3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895087; x=1781499887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Msw1JwiAso6BYV3Ybo65LRpP2frOXynj3tYTZ5sNuE=;
        b=ZaGUP7osh21tQf6AHUH3QeyeBXJ19RX9YFWFfedoPhhBjlbYbH+nDL1TWDnyTTmREj
         3/DUs/7NQNuKKOwBPnmT9HWXCpsdEFUSudV1U8TLOfAi980QLkzR0YkIzH7bYW+b+cdL
         JWGH/YyrLjartQ+FSm1fVZgnCadLERYzw1c1pcdztW3D1r5F7XnDyDGPHsvKwGKDzudZ
         E5vUGawhNeUUc9GuEp7uaASDtKkLrLtBNJMUvAj1ZYmYelwrhTtdhR1mr6xJMohO9bwM
         HFy8Ikc47SY1meVbbMpOVT4V1lJocgITDoderlPjoZ9meAKSup1kfGXRrhQbJxQ19YFN
         8apA==
X-Gm-Message-State: AOJu0Yy5uvHmVJSHZbsMWEP+WLyxIfRirO6MhGBgt96O2lD7YGsaPdN+
	kzTd4VQqm/xDYjy/CFwuEX5oil8lPFZLyooTaSfYQXhpc1Ikhj4BG6GJnjDqBA==
X-Gm-Gg: Acq92OFuw7HAdm91krWEWjyn1m+rY1w4CR97gxWnzoRBINW/Kn92zk4l729VqyBZZr7
	OTBWKiib0oc4EbSiYNS15swOaaj5TyerAQdUsnTzlIqQJnEykruswdadFwJAQCpzxXc7j5C81hJ
	u9LXMuiUknS1JBt3J/DjCXE0291X6k0wT7dHdPQdLWYaEJX2/LGkjb+L823sJMRbD+hSMWRkhgi
	IV4XKLdkEkFSl30j5NUnwtpTmHUQ0Q5n+EbYNtrOl96hIbDM0SB0hNELDstM93m7rChydylUZ7t
	T0uT7lxFxYGORzMKI2rSCnGFzHhYqp2ARETUQUTcO7E+piK7xY30ENRkkOYK0FGJbrdrcxXJSvb
	SyqvdgA4ZBmcP4GzRvH6J4o3ICg0I2FT1kCV5yfYlsp7x8Q32IQ7vrplft8yulIk8T8A4GkMk63
	38jlku54thU6JsYWqB6tjdYFdP1AgmuqHpqe0GfdG6Pe9DPAJqFa/O48/k6/s7EUr6B518cj4S3
	LjTJ5Y9g6LK6g6rI8msd7MN7eRa0oQPx0+MzziAwHXDnw==
X-Received: by 2002:a05:6a00:1d89:b0:842:4f49:6bfd with SMTP id d2e1a72fcca58-842b10677admr13727414b3a.26.1780895087366;
        Sun, 07 Jun 2026 22:04:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm19997835b3a.44.2026.06.07.22.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:04:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] interconnect: qcom: simplify allocation
Date: Sun,  7 Jun 2026 22:04:29 -0700
Message-ID: <20260608050429.5990-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to reduce allocation by 1.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after allocation before any array access,

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 ++-----
 drivers/interconnect/qcom/icc-rpm.h | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 23a1d116e79a..ca4c8a944755 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -479,13 +479,11 @@ int qnoc_probe(struct platform_device *pdev)
 		cd_num = 0;
 	}

-	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	qp = devm_kzalloc(dev, struct_size(qp, intf_clks, cd_num), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;

-	qp->intf_clks = devm_kcalloc(dev, cd_num, sizeof(*qp->intf_clks), GFP_KERNEL);
-	if (!qp->intf_clks)
-		return -ENOMEM;
+	qp->num_intf_clks = cd_num;

 	if (desc->bus_clk_desc) {
 		qp->bus_clk_desc = devm_kzalloc(dev, sizeof(*qp->bus_clk_desc),
@@ -507,7 +505,6 @@ int qnoc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->num_nodes = num_nodes;

-	qp->num_intf_clks = cd_num;
 	for (i = 0; i < cd_num; i++)
 		qp->intf_clks[i].id = cds[i];

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 7d1cb2efa9ee..b08821c2ef74 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -64,9 +64,9 @@ struct qcom_icc_provider {
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
 	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk *bus_clk;
-	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool ignore_enxio;
+	struct clk_bulk_data intf_clks[] __counted_by(num_intf_clks);
 };

 /**
--
2.54.0

