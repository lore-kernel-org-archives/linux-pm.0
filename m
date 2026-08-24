Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433341F34E
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576713; cv=none; b=BNyJGXnUMB7LjzFnBxoPKFrTVy+qMJOXfNQXb8+zCHiaHHivLBr9CsVXuZ3wS8NBK3BWk2IZLZY5nxhidfZchAbSpiRl7IqRWLEcZgqt5Kc/h813yEQsA7brhB8pu17+V1XpwfAE89xIZaNyycrdX8ENvXqhrctjnxIrDS7r4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576713; c=relaxed/simple;
	bh=pbOuLnMdY2W+iCdw66yndLQjoRN+QvlknxTRrElQL8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUbVhABrueE5ChfQnDNws66BUO60s+n/3I+JUOV0C39uI2F62DnyyvO0qE7phsPJ4Dthok+WvjfcBtyCXbZ+caKuoBuyJmof9wghj69rnF+R+KcihipBZ0Kd0vg72hktcIobKQJqrAkWZ0mEHwFKASqAlfRiK8cQGlTm4rwqA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDeBg8Hn; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDeBg8Hn"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b69cfc6dso3221541fac.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576711; x=1788181511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=068pYnBVpLmUX/vSkfsFSQIv11h+T+N0t9GB6UkmtgU=;
        b=HDeBg8Hna/geD1n1B3JgsT0q3KEg8go8efjdUh6y+LbzF0Jv2Eew/g21tYygLzLuKU
         NIQTSiRyC92o3VHcES50TLjmhu1BC6Dxhmn8EVTm5oSFZbhVsPF48/gJLRHmr6/DD9qr
         tcsr/KbgOFPHWHKGfJC8Dk5kcpcKhQ7KP1dr96vuZMIQmKD6ibxU1IiYxVPE7G56b9MG
         k7ULvlHSNpf/Q1Zf8eUJn1iLuVtAkcx+XqEcFzXotmgWcPgzQ5Kw0NnDCaTJz9NWz+iX
         DYd7PFQxoCXFIIPsJ0pGI0MwEF9yjfjJA5/FKgjrzVF1haYySujztV8VYAGMwtt6JD0K
         kKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576711; x=1788181511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=068pYnBVpLmUX/vSkfsFSQIv11h+T+N0t9GB6UkmtgU=;
        b=lcnb+WTUofF7Mzf6pVZQnfCK+ibQDTn9cppJ+C36ofn4zmS7sBXv1krStd3y+5SE+V
         20aI58jbEvCIL/pt2NAu3Yp6wOpGDsP7BwWMML4Y6sAbjAkrr4XbyLafWUzA63pu08pj
         /Ds+Oq3K9xSsB3ukQX824LAGugIlf7t7fV+ygJUkQgoYe35D2Tx0kOuFcWN4+BpZSEtn
         cKajq5RqYEm4hncIXUmH65PV/EFQc3tMq9aLjvsxxk0TBEgT3dX1Q/7aLI71KW5QEAiR
         AqocMwn6C7Au6QxXFKjC+9H6zMEeRduI3UOHpRfLThGK8UVlgyc/NH3VPLMXF4ckODL3
         yZjA==
X-Forwarded-Encrypted: i=1; AHgh+RoI+I/hIx99rPmYZ6fGV1Of/WLpV23dRfboa9Xy9ALG350cwlorP10aks/HBnmveDTk4lz1New9Og==@vger.kernel.org
X-Gm-Message-State: AFuF++lBMaJx0qUTVER9weulzdUlLaFk73opxvtvc0+WJzMvmqU6Mrrs
	1FNhbf98Klavtt8p/DZ239uZhC/EtoX+RAacX5qbt4bavbTojHCoSMG5
X-Gm-Gg: AR+sD13WFNSVkqJKpF2YEw82s8NG6vBsyHNxKuZGsALA6/NDmLGP7TV5HxeqaLFj//a
	gml7IU7k+RsJT3j8JgrLKhlLk50E++SF4uLt2B8RNVTvDWIXE7xnKB+pgRZBWPiS7o4xE3q4U8r
	l/IL14losiS+weD9w37xQWiGV8E2lSJ9abgt7CYEC1y8e4o81SnLYswPKRKPu00AGU9PoxRo6lU
	je4VQn144/a/APe24DLq2+fyCYVCXs52U2NWnKm6JDX1vOn+qsqePcjUE621tCiLIMYIW2h9XDd
	zNYWNfHa8u/x3YwlsFlpKRxoTsv9NX30F0BYylk9AN8iDJjCgXfRfa/rCzJ0gcDmfERu1UFYaYT
	IdBTNfH8n/Lh+kCmBVgXqkik48VICt08+Mo/KhpDPxhWnSlmhB4V6kF6T69a/TugQoA/06OHmiI
	zf0EgPtQLbVyJQGwfHp8rfB19PNMVdZJdsUAZJ6xLtTRJVvJDKa6lK4R1mpiUuZPZaVxuFiYzwV
	jYA+90ngO6c0B837kEPcLA=
X-Received: by 2002:a05:6820:a50c:b0:6b1:5180:bc73 with SMTP id 006d021491bc7-6b15925dbc4mr18970135eaf.15.1787576711215;
        Mon, 24 Aug 2026 06:05:11 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:05:10 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 01/13] dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
Date: Mon, 24 Aug 2026 13:04:25 +0000
Message-ID: <20260824130437.2771-2-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824130437.2771-1-sreeshankar0910@gmail.com>
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ID for the Qualcomm SM7250 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 2cf433f61..b63e4a0b8 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -209,6 +209,7 @@
 #define QCOM_ID_IPQ8172			397
 #define QCOM_ID_IPQ8173			398
 #define QCOM_ID_IPQ8174			399
+#define QCOM_ID_SM7250			400
 #define QCOM_ID_IPQ6018			402
 #define QCOM_ID_IPQ6028			403
 #define QCOM_ID_SDM429W			416
-- 
2.43.0

