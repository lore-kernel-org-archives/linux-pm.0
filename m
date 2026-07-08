Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5C40BCC1
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502581; cv=none; b=f3FobJDl3HFBsjY6igN3Vwosdp9wvVVLyL/8T6qvuXVVOvDy4Y7dYCMD0F581MM3hYtChr4K75hLFlKemSyst675+VH7+lA9it8NIl2SuYd18qAbaNzu6Xx8SQMJKd/J/+c9GPKLp+XcV02if34EJQQkybaagYB22kfCS0Nq9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502581; c=relaxed/simple;
	bh=QK57sEWbpetPyM5S3PpzY+vdkzKJPq7rmLzPoSsdEF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Sja58ODhFj+NVWZdR9MhVIm275iQ4BGGF01MJIulurfnu3K+ssLYdVfl1eUe9nlIOZ50xMENoCtFHjOO8dHHwk1lOdMuD2/R+f8SaUHRv6+cI/LcsBSjEEUZDh0c3WDAGbXxx2ms674hlM17Hv/admbco0jjwOWa6TZ61DrPJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbXZB4SR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbXZB4SR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cca24023edso6906185ad.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783502580; x=1784107380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3SacGhwSbkGS3qcaoGtvVjy4TybBKSuqQFODkWgiYfM=;
        b=dbXZB4SRvmGh6IDQj3iebVvcfusACF/Eqg64U2oLM6Ow55rrnOWzuLYVCUJkK2B7ji
         iUwDrXOuq56refZqmtfTZkscWAcubNI6izhon7SO963T81+lW112FDXR+flDOQsTkX3X
         K3s66Orrb3Nq4cU1FGX/qiLSwry4+RVOXnvgRHh/UnetIDe0n7iE4DDa64pm9m7fLW8J
         TIFxVP6ayt3OOkWyFDxUu3D1jEfF82UQwN8tj4asA+DrMoJjSvh1nOwCIpzpQMg0yong
         P2PGCtYx2IodZkHeTsHUCJJdpTPX6++CYjmoDqDIFkXsnmI/AXr0XB1UYJ6yTW5s/jSl
         Gelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502580; x=1784107380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3SacGhwSbkGS3qcaoGtvVjy4TybBKSuqQFODkWgiYfM=;
        b=O88vQbesSazf7TTPs+SWH1DNQ4gctij5snxAM6iCrEV7by7Rjt0LAZyyPPUAPBBw82
         tjI6wKAn5Sdm7SRyVjB1BawG4tqFwiAPcvLrSOormbO/NKalYSoF813uYh2NVM/6aQni
         KcpmhgRtKSHMRPHkKvXOreh+ov6OwGUNlsUiuJ1SrIJe4rphRFC9ymiMCkEhkXx6vQna
         QN5vAcLDHJhqQXJ+1KHFCMnsYt0AWqLMCPSlpCOOQfRGALLeJo0AufEofqj1NYPKZSve
         oW4zTpZSsiDuk6Fhez+frvk3UD055wJw47QsRgF7p3QokXEhX6jY9oYq46xiLK7D+iW6
         8ndA==
X-Forwarded-Encrypted: i=1; AHgh+RqXgSQXsLcPvvtI9sSyEiG6OPlQXhAe9NATQsFIo+AaAbDBW+Ljen5jqLo8eP8M38VbzJrJA2uKBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8A02ckqCMbRLjwxka+G0JtFunfczZK7oqc96MJ57wG2B2i8H2
	+EFyLnKTcILKampLAEmSr41kFzz4JCJsQqcGuGzt5pnhBSlqUwiiK/uD
X-Gm-Gg: AfdE7ckeqPEEL2m3+yJDzzlpw5lKMdmtWYk3/ABj9/+b4fmoKPtRqIQR3F/2Ru0jExz
	S3SzCA4/EPITfU9a+/0FKDuRrl/9P4XSP20W58fR/SP8KsBebBpTZeFK0HXWWgx+ddN5mOMUcCT
	D19rU7O4b0CMeluMcC+Bxcxq8goI6sQgwjlCcPZZ8sklTj27KCfmggqhZdPVMI3wnuksVlpGqM6
	Giez8Rr3qZxAvUctGy6DgmPgt7HQDk7wXOOxwaYoJuioP4pHvrVe/u3bSrLQ/nofjAjYqeIykhv
	2rZL6+DsPyphAR2Y20Rt7ChC3EZxlj0HLixm7l+LmwdAQoF04S266e5Q5NDt3hy+KwocP5eEJjz
	lShYl1MAzX5b8fcPCI4h7xZ6VSlfRborEBe8yPf1d0PTs2rU8zE0JMooQFNi39nS8WWi83pxmP9
	xlQ8BygA==
X-Received: by 2002:a17:902:cec2:b0:2cc:9179:32e with SMTP id d9443c01a7336-2ccea37df94mr17127855ad.10.1783502579629;
        Wed, 08 Jul 2026 02:22:59 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e279sm24999735ad.45.2026.07.08.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:22:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Irving-CH Lin <irving-ch.lin@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Adam Ford <aford173@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] pmdomain: mediatek: fix remaining %pOF after of_node_put()
Date: Wed,  8 Jul 2026 17:20:38 +0800
Message-ID: <20260708092038.741308-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scpsys_get_bus_protection_legacy() looks up several legacy bus
protection regmaps from device-tree nodes.

Two error paths put the device node before checking whether the regmap
lookup failed, but still pass that node to dev_err_probe() with %pOF on
failure. If of_node_put() drops the last reference, the later %pOF
formatting can dereference a freed device node.

Keep the node reference until after the error message has been emitted in
the infracfg and SMI lookup paths. Also drop the SMI node before
returning when the SMI phandle is missing.

Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps retrieval")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index e1cfd4223473..f877d6694dd5 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1032,12 +1032,15 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	node = of_find_node_with_property(np, "mediatek,infracfg");
 	if (node) {
 		regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
-		of_node_put(node);
 		num_regmaps++;
-		if (IS_ERR(regmap[0]))
-			return dev_err_probe(dev, PTR_ERR(regmap[0]),
+		if (IS_ERR(regmap[0])) {
+			ret = dev_err_probe(dev, PTR_ERR(regmap[0]),
 					     "%pOF: failed to get infracfg regmap\n",
 					     node);
+			of_node_put(node);
+			return ret;
+		}
+		of_node_put(node);
 	} else {
 		regmap[0] = NULL;
 	}
@@ -1046,17 +1049,22 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	node = of_find_node_with_property(np, "mediatek,smi");
 	if (node) {
 		smi_np = of_parse_phandle(node, "mediatek,smi", 0);
-		of_node_put(node);
-		if (!smi_np)
+		if (!smi_np) {
+			of_node_put(node);
 			return -ENODEV;
+		}
 
 		regmap[1] = device_node_to_regmap(smi_np);
 		num_regmaps++;
 		of_node_put(smi_np);
-		if (IS_ERR(regmap[1]))
-			return dev_err_probe(dev, PTR_ERR(regmap[1]),
+		if (IS_ERR(regmap[1])) {
+			ret = dev_err_probe(dev, PTR_ERR(regmap[1]),
 					     "%pOF: failed to get SMI regmap\n",
 					     node);
+			of_node_put(node);
+			return ret;
+		}
+		of_node_put(node);
 	} else {
 		regmap[1] = NULL;
 	}
-- 
2.43.0

