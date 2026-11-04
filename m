Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778410;
	b=bx+06tce9o/ZXlNpuTfynaAVUjOmNVnbruVM4TOPs8H0BRK45iK3Xu5kFYM73QM21ds0
	 o7/whPo3xYVhBcrvFWlop9A0B6ZGBHCSos78z3WhIqjSrQAmVuDsk/UJLT0vtBIGmALsl
	 ylialhFjf8XzqwIKpnJ6o5Dz4qaqwOunAt9jtkkSEqBHPE2oTP9zgwi4nwRaorgdaEpQu
	 79wGTO0CUC83QGUlunuzo6QFg3RizcYrPRXhGhGSZ5XfK87Z6oi8mjU+11vvcWMNCLT6d
	 ZDyA4PeJLbq3KKa57Gmp91QMXrDPAzvpoTEour5neTTF9S/dsGl+6ERTwd9jyM5QRSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
	b=IG0WvrzZNft8wilaXflgLBeCA9zqyn0YMFHF2W+jYvK6EvtHjAxOYm7+TzfVhY0fbMmD
	 qDHyQQL1bJGY23WcamVfskn2hnEBzyTZamYVyO6gwkMyt4xvYvCbDUhwoFVNlmvx3BEGj
	 NsJ2tR/F/bZ2OTyE+0YfnNVRESV8ojIXEiig3fHMhEKerdMddzKD/4Fe47AxXDWj7yObD
	 zl6yA9Mrofa20pqlBORl8IjYaKFZ5IitFvflqH3aAGmjX1t3GZ++BNEuDxiepRBGxsXMr
	 aG+KJ40CYAHPfFd8Rq3odyp5g+DryvyzAN8TjnuRG6aSanE9/2NBDmEYaKuXFOtCaPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sV3ynZL2;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F3606A33C
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 07:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A8F3606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sV3ynZL2
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35c76e9614aso489033eec.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793778409; x=1794383209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
        b=sV3ynZL2djp/uSfXZHC9ADdJ2Xf7y9fXRV3nczxd92MjSP4LgMOOaBP1T9LpwyvOfe
         Znql1e8wAVB0kHXK+wF94w0TqsBJFhULKM90WcGi1ELan/WbL1I8lKhy8sYBVJ+/7Tfi
         W5s7n/F0aBc1icuzGa8GlwKmTIHx8dLKxVmxUCK9eOpP+RFggQsiTgp3pl3z56AWI/6R
         JzpB541XSbN7HUQKzg/FJlevLki2JSj3BLb+sKG/cXdpN43Kxcp2W2EJAmG67WJKyq2G
         hjQPVIsExLqUJmZjlpbdp/nF4Vttuwc6RFL3s01X3cJ+IGFXTMrWZZGkYYrflGWLT0Vn
         y7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778409; x=1794383209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4fFdtJNvcZ6y6D1x1v24LO+4CMQIoUBaMtD1ZPuCLk=;
        b=tefUu9xFEuhsCJGKh8TKJcoE/EfHhxcigxFYLJFFSPBpI954Oos/t2Vc/eQSJS6rcU
         AGjuHorAvHu/xKPYwg3stCSvb2NWcJciAQCu0zEehSwcrkyceBRTxy3qwIWO2WJPzfOd
         kLP+X4F1VPm9FhbW98sDvwDcqJIcNpcOa7zYs8VFBeeF22vNSAI6KtrFurgcMeiBULyZ
         VJG21ROHoNdZk7F8BBhOv9N0Xii64jypyYjh0Wg15AyBhOUyAgq7TzAGkiiOJ9fHM9Rm
         kOLflb/81fzcYeQ93J9ZLwps4cVKirikTZ+ks6+Y0aEWHmbyrRG+HM/eiwLbxnW5DnWm
         +Gwg==
X-Forwarded-Encrypted: i=1; AKwUvBwzLV9K3XXndpERx29gNEFPamKscII2u9z2uFZo6iD47+H442sBRk7D2YU2HxbfEfNCwxARcq7GlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+/7VkU4rpnr2EMUJmFMkgbeZ8nXOQBsfZZGLWVN/1Wl7niV6VC
	Kc4giHQZB0sVS3K33MY/nnJXYa4pVQdraoKFLkMNDCI/Juao6/jBhpCd
X-Gm-Gg: AYBFou0iqk+9uSM6XVHpOReRTtdvhAHR8Z6mXIBLSjwNCnI5lkyyC/hNG70dTWd3rqG
	XRE+7QuMuRfyC9/szQU9d6IFUhop3CsYVSxx3U22iXI4JLX6PExvjVCkCyQrX9k7kVW6Ckfz3Yx
	FaaZ1/moeWxy9poeDPTg/iDfszwT/yRJ48cF8gmCzvCXP0nj/eon0LZy/xVpV8RoPrv/Mj8k/GI
	ba3X/LkEZcT0SwWQF9iQN/C8t5ODjDPArUFiXVnXJt29zQkvFQostl+reAOLNOPzHHrAeQCULRm
	uZjlxjgIaWOLxETbp0+9X/CpEhj9YWUZQ3yxeYALwN8BHlXR1WTkiQx4vd2D5w8ZlUb4Eg0TC0v
	GAEQJFpvE1JzAoRakcobbEQbU9MQE3L+EbRgTOxTEJLur5jUd0awDAvurq0c9nc9p67m/bgcdRj
	5Vn85oKSx0DMdFq+66GVDbOGa6EK433lAz9VgHl2EohuES7qlvHmU8N3RpnfNjdLaz1TMOVPc/K
	8i+CgDbPTecqigDBDjFfnvMjglSPDz4OBE4nQpf0ZkpR05NOC0BFqgUqEMnrDORaGN5Lok0EB4W
	CCn59rNJd8zbyXbbQnkYZzwMbeEts+gUOLHydF3XOoBZ08vyqIxWug+Q1XNNmcOstbcERCUwfJN
	iJZ84Xg==
X-Received: by 2002:a05:693c:42d9:b0:369:f18f:3492 with SMTP id 5a478bee46e88-36a423fbc3amr23892888eec.35.1793778409284;
        Tue, 03 Nov 2026 23:46:49 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.204.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm4566016eec.8.2026.11.03.23.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:46:48 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 07:46:06 +0000
Subject: [PATCH v12 3/6] dt-bindings: firmware: qcom,scm: Document SM7250
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
Message-Id: <20261104-master-v12-3-57fbe9eef978@gmail.com>
References: <20261104-master-v12-0-57fbe9eef978@gmail.com>
In-Reply-To: <20261104-master-v12-0-57fbe9eef978@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793778372; l=838;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=n/5l0LzNHQkrbMmziTZYOIF2FEcc8PMKPnj4oscjta0=;
 b=He+lmNaewUvT9cE0bl4y22+ugSs3dJvjKw92KlKpQtRY9AvK5BMkrVzkdj8zXEZl8fG8GPtLL
 uKhSpXXDFh5DROYlAe28kXAKP55HN9uHwz3XLOcdD+pVNlTNmMJWUri
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

