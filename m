Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0835E937
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245137; cv=none; b=CnRQ3KVlMDMqAK7CocPO5L+x6vb3TZu2hRl/sQHl1lZtV3N2XTng2QB8Bpm4S8JKEIQ8nggzrXW8mz5r6WQ9F7ZiOSb5nZ+kmTh4DJXBjw2tmZdHJOR4vYQNRwz8rL15pvlOobQOt73ykpX2zoJp9ECR4t/Brb6L3z/pv83YVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245137; c=relaxed/simple;
	bh=SL1wdM6vp1VIszL+xuNFr+53xhHZT8pJnJOiXD1KxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaQIucyv5VJht5L3J6EvuJQJ+TIH6C+UUScpME6QNpyFoj2oviUThJbTD1AuqpUHhiVAi3ZBb0iFRCDUVNxLnpKzRou8TLdwqWWQ+QCK5LiNzZYhOF/Y8z5Ma+qFPb6mQi8NUT2mqvY7QvtXKDKkn1ege3ZShxxtRqxNrXUiPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx9yH77e; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx9yH77e"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d7195706f1so43395515ad.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788245136; x=1788849936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RKT3VAzrTBQCbJUoz7WVF1Zm7cw9xcizV7Y1JN603Bc=;
        b=cx9yH77e1Z8sZhfdSJZ5Cu2hZ0snWIRFiHpx9+SoiHEycLcu6kPbzAVJYVnshh4wgf
         YG+SciIbDSQqmQMwcRryoSiQozzM3NVhl233uTn7NzOQ3I7A/UsxDvA/FxW/9uSqWW34
         3OeWfltYupz3m5VCzrwGQ4QOxJ249C0UEDMBlJdy5iFN4YFl1selqoR+Js0vRRyYvcLm
         5fYO+JcS1LdMbFpKiddQbrmjXC2ApZMMr9H5M48TXcQPq4VknVKCypu2ytNcPljr0TKP
         jf9SmvH1MB4COX4uSRGA81HA3djyBwGSIZH7iEBp+RXrfeT7UaLw0S3kk5l3hRBR1U5C
         aqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245136; x=1788849936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RKT3VAzrTBQCbJUoz7WVF1Zm7cw9xcizV7Y1JN603Bc=;
        b=jGVQeDgosLPTDvCvWz/3S9G6J0Y1SKlLZFgOE+kZNms++59PT91jNl4yQcqJkJaUc3
         MrkcpSwkxfaqjm/J5LYQ4B5l/DIBGNsxSeaGbeI5YjG1UrK6x6CsKqMqvaNJH+4SRMzI
         cJc1P4jxDD2RlbK04xhiCJZHJVTSrkKWdR5z2N0cLn31aIuKJtA3xZUF+JdwxqY547gH
         RSFPfQh9NfUOg9XdDH50WKJBHltVSw+2lYJBFW2ijafwYXbKC8OposkSnmF9IeOrq0od
         IsFgPo1hwGH0PWzOgzO3pg1VwM1aa1Ule1Gjeqn5H6jtZ87LSaJsOhOW2lkiJ44c+LNW
         w6Ew==
X-Forwarded-Encrypted: i=1; AKwUvBzKPbb7dz0d4QjL+aEuqFVf4BIMl5Ymx0r1e2IGxVlDljyiY1PTZ6ASR0HiRIKb/03SMjqwzCKwwA==@vger.kernel.org
X-Gm-Message-State: AFuF++l3xvAkADGclJE3Ie3JzkO1ayHcB7OJxFPoOHFP0qYyKWAN78l7
	7SEyc2NwdZI/S3s9+spk5t7ARhpk/aLpRtrEsewkoDj5Wa7SJT0DB8LN
X-Gm-Gg: AYBFou0YEic5lFMIxsgrJsHyHogcykpnv7S1YizTzZ1o1AhmSbmonXmd2m/Esul/zKL
	dhFePaslmXYNoQqpcz221WKhqwQ2ZfN7+llBBUcI0+3t38szv8Y/A4X4CF3gUzlrWDhK5zb6yoz
	Di8g7plyb0KVbTTopAIp68XWNGd5GFdAa9zO8LDFl0VEdofsK8SieNirs4a6luBsKforqIDKLS7
	I7/p34VBZtHuuIgdQoki7ZOggwYh1YjDi/1hOV/tlQ7gZt1B/o71W4mCMAx5Nps06G1O/f0jrn2
	Hj0A/x2/l0jkJQuRwFy5w5Q1H+VRP5p5XG4Ktr1FY3Vcw50dKtGSWu5Sssx3cHghcbzrlLzC1RD
	2wHVT2wx5BGtRR61VeItUCVC69cB12rXs8ImeDwCTk9ZRXIno9pJO8+eu9w4H7ZtuFKp72UFAbK
	Cq/EUWOGazvqUsQF06W4aXlukr1vQVD0Jv0dBVMAVWfaGoBL3NEMy792BRIrKKABVHjfodNCaz0
	HOhziWmU0dR
X-Received: by 2002:a17:903:2f0f:b0:2d8:d4cc:be65 with SMTP id d9443c01a7336-2d94a905007mr80536945ad.18.1788245135571;
        Mon, 31 Aug 2026 23:45:35 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm37019784eec.27.2026.08.31.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:45:34 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 07/12] dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
Date: Tue,  1 Sep 2026 06:43:52 +0000
Message-ID: <20260901064357.20055-8-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901064357.20055-1-sreeshankar0910@gmail.com>
References: <20260901064357.20055-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RPMh power domain for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0a45e1f55..e08441915 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,sm6350-rpmhpd
           - qcom,sm6375-rpmpd
           - qcom,sm7150-rpmhpd
+          - qcom,sm7250-rpmhpd
           - qcom,sm8150-rpmhpd
           - qcom,sm8250-rpmhpd
           - qcom,sm8350-rpmhpd
-- 
2.43.0

