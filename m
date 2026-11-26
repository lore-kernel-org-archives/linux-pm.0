Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669165;
	b=aCTaj7165ZxRoUR3wGGnDL3/dK4/oxHyvnpgf8tVBPc1Ilkn/Gz9YXWOOgfeJdDNWwqh
	 htdskOnuHbj1U7xpfM09JYG8KpFfPYPeGWrJIbDpzHRHsV+po7539xMsREk1kfDd0infO
	 NpS/AoCLdo4GZfA3bH7Y/GvJYniYYFx1Tf+/x1qTFIt8OOiwNJibrlP8zqEgbA5hSaCrY
	 Jil6Cb4eVxtQU8S/w9E9gJgFcPmvHoHV4tB3dxty4SAOQ9yXqNxgnc0ObxV6yQt+lGjya
	 A9bRMYVY/bpYN5rJTLUKZYbJ1AC693rtbUdyfqChHBumbNQKFbcbwxRZm8MRYaSAIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
	b=2ZKblIQnI/WPhfQ/CUxRbUsFXe6JE29eOtYKxPO7NZa/AEV3TjSMuFzA0ildHS+CQ5qx
	 hmJ41ZBLViWOBQxYKmQYeobcyo9aQ57Y3pFszwxcUHahhG/aFMrOfC/izJNLkZhshF1cQ
	 v/cz523kzy0HnFneSw4WfoHoTTLL7WAafX20ZQ4+n41O/FEpS8BrZLwaoXrFI1ESVJ70K
	 Dcb7GtKQmA1EYfpUvoN4ZLT26oBbUHiqkQIxy5RBB31BhyYpoLqF006/eU2ZUutGoKQ04
	 kGaCnnna5LXMuwjSvjm0kRxZ3Al6llEUu5HbDBl/DJZOz43osr40iCG/V1AQzm4emSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0EUPNu5;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089A606A326
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E089A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0EUPNu5
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-386ab9ab619so8535880eec.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669164; x=1796273964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
        b=g0EUPNu5vCG1KDaEwv7YBLGPLoMP8KZ7WoVFgrp5ESMpyu+wnidD/QLjIVYThZWUke
         Ub1fy5iT1lyS1Qhheq8ppbHt23EmO4mUDGw1PnB/2unVy2R2bty/WC0iuhmSLyp0Vtol
         2YEieXVlMiqDv7YQ9yxEeaT7nJeW6ag0YunW+V496cdBOJMzP0NzKs+3mbwbv+GGBKav
         JUNncL7d7oCSkyDB8BzA7VhpkDJ4+jsHDI1xIbf9en0rpLFzRBJ6a8R+6il36uFagNYs
         I/bhcBDhOPC6Rr9qb5NJeYOwMjbU9ZOQlVVJIJyVDQK6v2RMFlEEdD6L7CfvPq/ECj4W
         5tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669164; x=1796273964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOERypWJhWIh0EMLri6y7PTlFgXfpVg7COFVnAl5d1M=;
        b=KI4gT0alJDmGGld2qArTPxaL4l/mWZ8cEsv9TlgZ0eKjmfncY5XnqSXKtIbk/eB7uc
         1lFLDVYDZEgu1R+jKFtXZELrC9RqjvIjqYp8k42W4K+6cNlbVdB7ORnkGRAKRid7xHQS
         QiBLI0NDYrMKRKIIAKAaplpw3on2cqSA/pb7oH3ksFE9wCWxJq/7haw4+rnEMDCRkF09
         5J5lKaPtcbPwqN9xiAoyLzYztwyT31ai0JdBqiLoCtedjIuGTlabJnmdXRpjsLfAswke
         L7BWFAIQ/sU26i2cwCIZUfQG1Z0dCt/Sfs8nGU4xJSROvmqwPmcuCdZddaAQHrLZbPQN
         usNA==
X-Forwarded-Encrypted: i=1; AL+hErHiDOfccw9LNqzl63a2gc5IFrMo8sKw4jrLhT7id3N9Qo/tKzG01b+veZdv8g7m6pOltecUInOpFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/qHcIRnHNCKm3yHdce+qQ7k+l2EZxQM4XUR3HqjCxt0VKfIps
	NTR8nhsfu+0KtE6y3+d64L6LRqakJj7LAkm5FTLSseh8Krq/BZTDVYCI
X-Gm-Gg: AZFdTZfTrLlm6T/cc2FXTMNUSN6amTC8kzwz60tAecV4D4UAxC8B2As0v/LVdndv6CO
	jrPfzyR2riLlJO+GgXyq67lSq6Eh6uXkC1xmTqDB3PlyYI2zWyyKcnrZceUjJ0piY8p8EjbEEhw
	qnWdRbHsPzHlNTcjja98zXfwWyG3YUba8f5ZIs9C+XTlzU58/QQ+XiFxhUz4oFGwGKOlDu2irq/
	tJh0I/zCVrrvJE4j/p4hhZIWzUKWnr47ozQENu6WUInCvb8AV02e8KkFFK8U7c5pp/pNJ42oBl4
	S2wytjjbUUamcL6ZTBEmTJ+ROi1TQb5LEVVfgZi9wMSRjeJeHXkw1Vxg3lVlU4lkpX4HCwgEBaL
	MHzU0Hsi55dV6+RZkrRjua4sICfxnES1Ef0Ku80a6dsrNDvrhYNdskRgXxgVJte+4cLYKHBS5kV
	R+HnOwqhofDNANcme554WT94OsbrfwymkJCwjFqxX4L0ZIyahJDgphrWsizbfINjeeA+dv4Vbld
	3dLnG9/e/QBvM409TOcyzxBotMuDlUKhodFyIaR19QCF+o9UOFqvTMMg4SWXS380SpE6KtcaygC
	9UOnHl1UlpKkN6P19V8gnFkmK3CrmrGHdc3JO5gabmJU50an6U6KZFz0M2wrdi6eLtMGc81rENX
	N2F7628nn0Sx+KK7hf1XD7RYCWiXg
X-Received: by 2002:a05:7300:1486:b0:383:6eb6:5730 with SMTP id 5a478bee46e88-38570e24c0fmr24177940eec.32.1795669164035;
        Wed, 25 Nov 2026 20:59:24 -0800 (PST)
Received: from Sobhana.localdomain ([152.59.222.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54800362eec.7.2026.11.25.20.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:23 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 26 Nov 2026 04:58:11 +0000
Subject: [PATCH RESEND v15 6/8] dt-bindings: firmware: qcom,scm: Document
 SM7250 SCM
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
Message-Id: <20261126-sm7250-v15-6-492014ec0a52@gmail.com>
References: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
In-Reply-To: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795669088; l=838;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=rejlxjgmjiSGoOQieemcJFRPRnZEl4/NvRv6It0RMUo=;
 b=r2mgp8vyKY7YS6WEV6WlbjzksgxAH2OHXCWlysqnGLfAg4qb8dWAEbzAtXsFTcCD/KseGgpZX
 PcFCJVXO5ABAnOZzv5+RU8kim3m9XyqAWQLCECJmV50I6nzgtR+FIy6
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

