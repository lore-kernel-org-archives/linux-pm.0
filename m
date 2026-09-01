Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCFA3F4DD7
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246467; cv=none; b=sHQza4/nqjw0A3UJNzamhGq3JJplRj5Vx4GK46Rcc2SOSpW5aJfeFTaSlU3J0euDen62rLy9Uf4/x+SCjvhHp1CB2AESjN6bkwZEpCsns/uYrPkgiuncaDmcdNiQDrckgs8Ukk0KUZLW7bsKc7AeeuDOTYiT5FtGjdZsAVyft4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246467; c=relaxed/simple;
	bh=LO0HNWJQ2iffOvEO/jDwBG49x7KRRSW4adIk00h3Zhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvd64aBwdjBnzWXCeVOu6X7zUvAjgwLEfn7LlZvm5IFkQ7FeB+uEn0WDTwgVkjHiJtZFQlXk+YCZsXBvuywO3WEdnI/yxmUbVXE/rn/5Aw/APuT057C0UzCWjYvHKYmCIBubZFb3ZYF811wjAjd5d+pYwTPuFSgN4YHgNGd+7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb00GfeS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb00GfeS"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso624612a12.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246463; x=1788851263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=gb00GfeSlSTVxcbk7DATppkpH7mC230XrpG+2I5v1dSPdan/uOCo66qE1+d/ASGHei
         dfr/yBlAZ/Jb4CMNZUhlg9BdfAxHQyOpBv33fR6oLnf9BizdrZJeRRC4L39uQDRqKdnp
         eriRRaSxJHRGPNH7SSvHjVVyuUzTqEXFLBuJu2nVZC95LjqAwXhwE6uajI9Yd7svt8dB
         qPOZub54W/v2VxyoyS1SecH3dnsel9QS6jtvh4Sc0cAwBWR+8xwwrlcpJb65aZBV7LTS
         UWvSmOyAC/3kLuaMgQJubCQgGn+7lpjc6jVNLB84nmaNCryRpr8MD+eK9K+lFbFomLvK
         XeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246463; x=1788851263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=DIOCNerVlcFK9p0nVdNNdV4LL6LGTfmL/SBKW4wVySuxsK9KFiwh8M5jL7gZOizEba
         SLymAWx1bJeV9kR7UbihYOYgTDMKSuw4+dWNvvJip1TUxHoQwZXe3JYr6VXp0tgHvXnG
         3z+3Z2pMP4iYs7QhWpMdEwKDbHQyZ6HAfpLK7N9U/L0mfCwO7ehpAhQLfHWVeBztGH3/
         ZOC3r8Lr5v30qCNbh5I1waQPjrpKoyVRjiqxd0vgbH2QgHQqtD6vSONhupxsBvJtTv4S
         AjbDZMP0BUvzSBO3Nl5InURjusjAcSKV1boHdykW4m9aUsC/Rh0KestvQJalEEYk4RR0
         0HOw==
X-Forwarded-Encrypted: i=1; AKwUvBxE8mFm2KNajkr+xqa7xd021/M4o/S4NOaCNKeVXLx5feLI6sA7NLccdpu+tirVkGSMo8IItg6tLg==@vger.kernel.org
X-Gm-Message-State: AFuF++kKmaikl83FxTo1vJLJaNEIgcKIaNNqxZ8Ketwfkn/w2q3kqSLU
	Sdn49OEaOtFQxGAaAoKdaNzazWiTmQs5/fQKwr/7bwqLU+/GdL/QkNQo
X-Gm-Gg: AYBFou1eSzdfxyCUxgx48LKi528322zWZ+VJDRL728Q9Evk9/GEjIQGz31j3NfOJBur
	pyI/YHOdCn5YuRpYGF0ERb0+QQOT8rbbt/yvo2pf/01dDxlIt60IrDITjioAYqvi6XGYccBRpix
	iJ4fB+ekeQZlys9YlC2nv3+5mGIxY4y8eXY29+ILSIiE6wmlagaxnEIzalqmJ3yIB/+MFXtbOp5
	IXjxOtbh613NyBqNABYMTN3x0bSxNN9WCWPB4LQ0dQCY8LcPYMcyIX2J/krS4Cq9bix6mZcH8ol
	rLW41w1nIlCtVOpvJJbOGkCJo+1oXtrANsf3xcQBcugSMSLCKoROgj3FZpyVgOoC4Wfjp486tfc
	p44SGKPsQmTEqAWOJFtqbKUlPLINca56F+3EIt6aoP8Cg8x+yx3SEefSRcFqHwXtXBPKcBmlra9
	EpP2avK+rRN++XvkOOuiAt9W9hEzoYdMfJEmSgGhfUMoI6Y4ZcqbLm5Ri0j0G6wsdUD0IB0HEKa
	red8Y7m65XQ
X-Received: by 2002:a17:90b:582e:b0:398:9be9:ab8e with SMTP id 98e67ed59e1d1-3989be9acb8mr32700156a91.19.1788246463258;
        Tue, 01 Sep 2026 00:07:43 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm18274680eec.1.2026.09.01.00.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:07:42 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v8 01/12] dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
Date: Tue,  1 Sep 2026 07:07:06 +0000
Message-ID: <20260901070717.20513-2-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901070717.20513-1-sreeshankar0910@gmail.com>
References: <20260901070717.20513-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ID for the Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

