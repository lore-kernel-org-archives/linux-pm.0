Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8A5FDA7
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245086; cv=none; b=RAqjWcJ76wgq9gCirZGszGX9RmniwpWcpKSuCXkvXlUBw4S8d+t1iUJ3L1Y8/1Yz5/YMFG0jrOAGG1mMSVKay60ZTJZt1QGCt9bLw8+5sU4WWhI3vaXp59qlRc548RIampZffGdb+HyYYNDxQx6B9ZNsUZlq/xZW5n9HJ/UDR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245086; c=relaxed/simple;
	bh=HpzD8eE93G0QF+A2LkG7W4+8iO6y5XPc4Rl8E5Fjv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn3t5U1qPpTYkvV9PMWO8KYF4mglscwCRgKRJWba51yYlDmuOyipoV+pHljStvgVj140muHFBJOoCM4FL14C9I4BlvJ8nFwfeRTalATfUuW1PQRQ3TdyvazbKl2dM5zQ15kMUqcjl/zqf/84qBX+CAMwR5HMPynjGOnhyaxOA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQYbTE4Q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQYbTE4Q"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca80d708489so551850a12.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 23:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788245084; x=1788849884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=lQYbTE4QqGdE0wQwwuysJR1UqNoFXLSrRZ+BftyXSrgZAzPEI4/M2xAAxr/EgMzVrN
         GrgD0PpRQJkfl9wcpCLCbRNC9Cp4rfwTty4HQqLcdrVAlwr/Z6V2vhZioofHYsXauKFp
         TZXdlDgYSOywXqb+RfUx2kDECKp128UnKWTEiy5PlvCCChZYFli3i6Br3ucosVUyOUk2
         jm8AbEDcHN2BRE4GX+Kgk7+jluxRpZl0719cKD8RYJQuc4DYTjRbbSWJJoGpP/sLb3+u
         HPAYSCnh7NBwRS5vfrknYI6qSKILABg1k9cIvy2bLDHrR7vAuBz6vVsCd0iRH3gUKEz/
         +orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245084; x=1788849884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCothkY1Rqth/F0B2N1+XSPKgmCrj36SkVxYCdKHFgQ=;
        b=mjNnCRQWtqtQPWmUkQPZYmLHs1ntbsyf9Kk/sUiaSGoJeV+hZPOj7GB100HDgKC7G2
         oH/w3lZ/j1PBH4EaBAXj2MrnMIrUNnc0NmcCqxth2ymddOfYhNqBTmFlCeTfN3AjwVRg
         vxfj+9rG2DaoYMHUan/vot/CbV5unq1Lg8x1Q7qJDq/wjqyXMN8x1ugpBSVFi8Uaondq
         o/oMLt7NTNkALjUiAw4e30Wb9OTh/kNXFENU1OH+Uq9p1s3qw2X6BmongC3Ljx7zg6uV
         IXjMno05iExQox5PR0xKqcnIMDrDIiT5uC3rsKkWmSFW++wL9eAUJf54LT8JbqQ6wkDO
         xqeg==
X-Forwarded-Encrypted: i=1; AKwUvBwVVgtV9iMpQoEqkHCV3MMvqfsCKEFMuzYhYkdRO0jMXZNIGJfmJkTQkao8tPglr46QPjQYSJcvGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kuOK0fZZaHrOut9SVGKSj70svOOWOWbL92Jkrj660Cm2O5Tq8o
	BAwAbgYom5UOgAjOThwUlr7i45w7HBH9T8WaG88XCCKK+ml9MWLeDwr3
X-Gm-Gg: AYBFou1WDwX0Wab0Hk9uOVKGJvm8D2lYA8VnTXQKakokoPdd7thP1NvUlNvkaHNLxn8
	BwWoB4acLs5oObSpKBNE5ikTrmgcIOGX1C+ko5j48TayXx7zDS2y/iIHvyqlfrOlQG7cz0InYrk
	2KeRcW9RzqCf+R5yrn6FnEY7pHYDdVqHKCvpBuYlyAc3jFn/kGMIUSOMyYrmf6/rR+imeWQ5MeU
	JAxQkMyJ4Z70EAj+TfC8+dPvyRPPEh61xqxXLUA7e72HV3vVQ7EmtFXe4e3O7zD7IAM9DvOkQjE
	piOCy73CH9EL+IWRlUWtG53oBksm1+PWupf/em0s0ddVe7jJHROKstH7nBes+iobGx3eNBdLmm5
	dj0nlGp30FiQQlgwKEeEQwPPHYB9KYo3APTJU06faldIF145D95I5ylWVHFdKkTtZ4/JDV+yd8G
	YbYry6OTVmk3xUcDc7zokNzVgheFGz6uHgz07WZVNdjQGAY5kFw6zkIjJpbEAT77VLXaJhEkdYl
	LRJmmrb85TR
X-Received: by 2002:a17:90a:10d7:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3990f1b223cmr1809753a91.0.1788245084147;
        Mon, 31 Aug 2026 23:44:44 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm37019784eec.27.2026.08.31.23.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:44:43 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v7 02/12] soc: qcom: socinfo: Add SM7250 SoC ID
Date: Tue,  1 Sep 2026 06:43:47 +0000
Message-ID: <20260901064357.20055-3-sreeshankar0910@gmail.com>
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

Add SoC ID for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 1836e226a..63ee5cd56 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -450,6 +450,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ8172) },
 	{ qcom_board_id(IPQ8173) },
 	{ qcom_board_id(IPQ8174) },
+	{ qcom_board_id(SM7250) },
 	{ qcom_board_id(IPQ6018) },
 	{ qcom_board_id(IPQ6028) },
 	{ qcom_board_id(SDM429W) },
-- 
2.43.0

