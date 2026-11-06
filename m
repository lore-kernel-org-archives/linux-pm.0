Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978215;
	b=D24Wow/irQCS9in9yJ5AFYXufso8EnZRq1Xm04IBJ1R6ygcYIxIrWM19p4DJWDrAALIU
	 ZiOH6cW/35rKQZWn3l5gtAg2X+q+hm6dXxxbya3LtV9AFJx0VbKHSTe8PETLFu0h0Rvmr
	 +coRm3NUMXk8upZ3qXzOkLsA/+emOX8HfY1+uIKOMvNHyHZDWfTvNCi5aSpC3LnbP3Opz
	 bMOyZ0juRUAmZpm4CfwPnZOxVBR6XIDZ2NCsoupoy/FtH2Clu4tgxPdwtKD7ahJU50dni
	 nAZ8gcJSedSFyKkxDNtqsGyw/i2qsuBnp6QlK1bMPbKtjiUA11tKDKqRbQhauTrtXKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
	b=0ErjtwqqywbSPXmg2iq+8jPFS2lV4uyaesdJx5pT1fwFnqRiu69BMUofGbZSvjWAlGDf
	 Opbz7XW0+703EPTMoDigjmYSWqlx8wnU0WCakbOWym4Tkx6HWpQGbve/F1dqoWlL7JDfe
	 bLE2VUl5prs/gwDyHLiNGOTN1HNQ3dcigdTPxmlfvSf2EoSDlIeBOObhxlMkjqlun+5Cr
	 bbehUcMb4UE9LJhbOsWnQHguk6hDwyCWKO9tRbuMtl2rNg5tSe+6s/6wlAitS+ll8Aemf
	 Drb3wTYh/QAg7nxBfQ7JS3v1WJxnYUakXacdcum8gvmSewOAOOnvRnVyC+sX70QdaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJ2mv+wU;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA2606A329
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EA2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJ2mv+wU
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36dbde64409so1003318eec.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978214; x=1794583014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
        b=UJ2mv+wUuXXO8u7SnP18fog6WaoiWwvWKnKvySMt7qV+3dlB2tt7iqeGvpAW1lrpi1
         z26GL514JQI4LJBgGjfHjRWMXWdE+euTdx0gAVgfRRsDDwK4O/3wCVVkVMr2atlDb6Sm
         fFLUzM0NZ1RvVn+om0BPvHoP4E4az7uFs5K9W7DWpegBIKSJZ7wMWJj7cAeQQAyrVeld
         cBfu7mHCX2BfrtH2PNu/Zr+UkPcmxPKP94S3Qp5JGnA83bfvm59addxBC5XCsj24ItmS
         bV6qYppWswv+1CAuZ9YWG7jer6QcEHI3i+6GZCmzAbLANmEVqn2zxFIhiDDaBvwgrXU9
         oi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978214; x=1794583014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
        b=2a/sfCqCq4Z82s6K+0Ho8npTCRJp1SRH18/ZChtp7iF7fz/Ac423J9pGouHpKbvCCK
         36cXshfV/3Tuhk/9LdfeIwWZ2+drB/zLZ3RCjQLFp6H3RjlTuJQMAEC6fUR0Mez9SRZY
         JKUxhhqynu0+08l78iyueVeLUBySu3+U8F5WDjrDZ45JlTHPHeX2myF6VRzhO3nLcqKQ
         34UwdrTi3XqNZgfyuPtx6jT7oRLwu5eVcQgUV+LATsgQ+kZkPaOE+KPFeZW1gqhYwf3U
         iOp3TZPrnyjX1ETB5QXN/JkEkuy+TLioR3AfBOBVhWrw23E4Bf1DmiUj9HAngY9iBUxb
         +/iQ==
X-Forwarded-Encrypted: i=1; AL+hErFl4hXqmHdWq3pP76LJ9qjikTXI92tc5g70/6eyYIne6QZGNIUBTWIERS60bNIIQxdrnU8m2GmHxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WDeHb2nqRp1M9MYh29hefWZqpAFgCR0k0759x85zRp4IR14ND
	NluEECFjAdRzcyLE7KFiJOO/Z0tiE0/UW2cPBAsI200zD37BPORrBPMB
X-Gm-Gg: AYBFou0JnQIhg0d7OSZVhjar/AB3DaIgLPBLVk0oNFb9sTilxchS0ZldceRWncAiML3
	4qq9ljytu6EEQafFwLmFR0307AHN/vym4yzghGflZZv5hrpdmHg6JCalaEM16jZRSyouX41lWID
	VybERDD9cg2Mozn2OhhLdslN5U652xd6yDkrSN4BuwgutdUIYNHblqz4sa3V0+ZXt+lUE+oaJzf
	/CSKzjwCjLc4HVBBQcK2nycFXPvylhZJW6mf1F2ZxmV/MaVbAfpvWJ/5LTPEm1Ool+B5O7QFftO
	7JziBDhC0DV8OMPNsNpCU/ADSl4fDXn0FAGG8idc+KYFhX0Cf3KAWyK/VYWfzNx4bXCW9KtWbtK
	9YHetgddvmZzA7ugak0KWHrIthfoamwV/mthBzVYisrdEx5igXDlDYOSK/sSyQHcDPG8SQ68Nlm
	qp6cdNVxRcP7ZNhcC90D7eRC9ATpPIk6eKPYnA89C3HGmZbZiJEgqPQbbKEh8sTiXQlkcsf7mbP
	aiyjsBnqDkLWVCnZ82HcoIHrUvrgeNRBvUJqYScAxXt0RiJpUnxoWXte28vGLFToawX5XN6+NxG
	942QyFoUpnHT9y8Vx/I98CIR4pIP9ZtpF3xs0Tma0LP8acl8uFHb9raSgY0+2BWwkVRW0v/HaDk
	wo1TR2ak=
X-Received: by 2002:a05:7301:190b:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-36f75441608mr3747167eec.8.1793978213641;
        Fri, 06 Nov 2026 07:16:53 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.221.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9ed126csm7581500eec.18.2026.11.06.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:16:53 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 06 Nov 2026 15:15:41 +0000
Subject: [PATCH v14 6/8] dt-bindings: firmware: qcom,scm: Document SM7250
 SCM
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sm7250-v14-6-7d167e993f9c@gmail.com>
References: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
In-Reply-To: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Sreeshankar K <sreeshankar0910@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793978147; l=838;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=rejlxjgmjiSGoOQieemcJFRPRnZEl4/NvRv6It0RMUo=;
 b=OJ/c3M3Wj0MaC02qVOKVTq5RLwsCER55eDtOI+BRvMbrJSwx6IJqxbkHqxxEctBHahiXCn3E/
 t4J9wrrf/FLD651S4+JcGBDdZwjERY/JULmn2DDTAIq5nBSrcU7QL5V
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the SCM compatible for Qualcomm SM7250 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 40a267c54..ee02a9c20 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -76,6 +76,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350

-- 
2.43.0

