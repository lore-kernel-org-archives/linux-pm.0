Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038B429825
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835736; cv=none; b=nvvzfXK6kbnwgU3o3dOTqT90f+4+ysLYlSWGHYTA7dLBw76D3rTKNXOjZHmtJZ9arivVIZgYM19PTv9+2GHvBvh7aklmZ9squht/4aF+n6lEpiI+BQAd4ahNk8U2THMbTNY96E4rkeUP69Z3/6x5L8lpjrooxIjdt6tY9inr0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835736; c=relaxed/simple;
	bh=QIk7JPCunkbKluanxQkxUv0yYQaC75cEo7KnXQQKbys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaYEKaZATRiWhA3AA6vtbPF1HUin1YfD5r+DQxE1GrlHzL4/SuEbRGYhMfyoUBnXAlHAXxBcGkiLhQoiUAZc4QeHg2l3WiHN1J55msfE9Sgzi2NaVFYPCAD0sQVfbfkq9wNzHb2ao4cJWOrAhTqCO1CRk4wItVZXqzL68kMcdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lPyRB48M; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPyRB48M"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so7142354a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835735; x=1779440535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04SKeVBhvRIfsHaTWxnqsLENnjwWESaqrABBm+vFKc=;
        b=lPyRB48MdySvrLxUPjSIJtXH9XTUO69dL/fHGI1Yh2IyKrtIa/VkpLd6MErLFlH6zz
         IckhG3nXnBSVeDkOEWWz6/7f/KU3o2A5sXsH8RSEh89U2rnM8EiP2liyKZgtZNDjgSY7
         p3Eo4tPUhYr1t8YBuvnxG5NJirHq/IG0XQgaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835735; x=1779440535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+04SKeVBhvRIfsHaTWxnqsLENnjwWESaqrABBm+vFKc=;
        b=HpJoyFt1FDckgJfs1I7kfBwkr92APvs98xj2y9FI809M3AgBkTpK+K6SAxVUPeg2m+
         g4MQmsy142Z3NO44X3o37XBLukP5b/aCCoIdMsx6keBmh6s//m4a4bVrJUx3mAREYAxC
         qPzkEDF3j4mmMKkjhMV+jvltJE3WJOwK7/rkjSaxE6ErKrtWWdfgpZ4YPcPVr22CFUqQ
         iFCwu3FarWUUB3Zb+ssCiA/FWMRJStdqzo/rN25pIwN1+jiN8JAVBXVAO+YJn+6VCSug
         y73MnQ1DIVc4lvGuInGN7I+ervHciHmU+fgw9V3NJ+SifWeFEtWKQsmrePhkf8GAZeJ+
         KG7g==
X-Forwarded-Encrypted: i=1; AFNElJ/ymBSKdjwIG/ATtRsk5h54mLWAVbQvng+qDSZnT3O3e+MF43efyTa3ji2T725OQQFiEyjobfLApg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCuyjnVZnGMLfYjxhHmb5qds9vonMKpk1CVPVVMKpZO0ImKd2
	eNDT9s2O0+cqjs0+3FJkwwYW7I2dxGKAmSHvbfMp7lG5nqvRk0jGU9n44zxL9UGTTg==
X-Gm-Gg: Acq92OFzbqM/HUflEUnMj4OJLcX9XUWrt1lyTOEdOptk9qFE2nX71jFmuHdd2Qdlsm5
	i5RSJQYrl6O5omb/ZfhIBQOitnXtweJUj84vvSIps7YpZqTU4N4D3UO+2KDFI/vy+kwGMKq7QyP
	hkJIgjm4E9PcCTxHes19ILfPpn53a9tkRh+ppZtBjpbDVSCMiIxlyJUJsJk0DqfyUaB1SUTCCos
	qSwfrKE9+FmvXJbM66IZWNGZVlsLocWowuPX+tvd/UtK5nZY7D+3tkad6vbuZWsbAWfK4rzDDTX
	ZyxGL/eHyWRxV3XfqvwiH8IjZeO2x9s7lRreCCgYQN6bpL3z3OkKTj2B+VKW6/df8azY6eMo3wi
	neYGl9i9mrOwje++Q9qbFHOUwiThpLf5NaHMW1jsbljTa4xHOiK8hey8PeaGZjKHQ2JUJmBg0Jg
	iQLeUglFyas6OVh7OvO5e3EBrJKwUQWZ1kLpX9Fs2Tjz5X9eH+JhmvmBDZU0of76n7wdWJs6HKY
	mUIB/bN
X-Received: by 2002:a17:90b:50d0:b0:367:bb47:9fc2 with SMTP id 98e67ed59e1d1-369518bae79mr3243819a91.2.1778835734722;
        Fri, 15 May 2026 02:02:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:14 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH RFC 02/12] power: sequencing: pcie-m2: implement port index matching
Date: Fri, 15 May 2026 17:01:38 +0800
Message-ID: <20260515090149.3169406-3-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515090149.3169406-1-wenst@chromium.org>
References: <20260515090149.3169406-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For USB connections, the upstream USB (hub) device could be connected to
multiple M.2 E-key slots (or other power sequencer providers) via
different downstream USB ports. The provider needs a way to tell the
different connections apart so that the correct provider is matched.

In the previous change an index parameter was added for the consumer API
and the provider matching function. Implement port matching using the
index parameter. We simply check if the remote endpoint's port number
matches the index.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 16a332f9da7d..c9aed2c02e81 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -165,12 +165,28 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 
 	/*
 	 * Traverse the 'remote-endpoint' nodes and check if the remote node's
-	 * parent matches the OF node of 'dev'.
+	 * parent matches the OF node of 'dev' and the port number matches
+	 * 'index'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		struct device_node *remote_ep __free(device_node) =
+				of_graph_get_remote_endpoint(endpoint);
 		struct device_node *remote __free(device_node) =
-				of_graph_get_remote_port_parent(endpoint);
-		if (remote && (remote == dev_of_node(dev)))
+				of_graph_get_port_parent(remote_ep);
+		struct of_endpoint ep;
+
+		if (!remote)
+			continue;
+		if (remote != dev_of_node(dev))
+			continue;
+		/* For existing users of pwrseq_get(): index = -1 */
+		if (index < 0)
+			return PWRSEQ_MATCH_OK;
+
+		/* Check if the remote endpoint's port matches 'index'. */
+		if (of_graph_parse_endpoint(remote_ep, &ep) < 0)
+			continue;
+		if (ep.port == index)
 			return PWRSEQ_MATCH_OK;
 	}
 
-- 
2.54.0.563.g4f69b47b94-goog

