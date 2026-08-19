Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084893644A6
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153195; cv=none; b=TmWXN5p8BnghZxoXqOmEOLStUN5/tZ2Uy9lFbdzRAo2KA3Dn13CYx3tBLtTIoIZ+VM3MPyBIwawDl04oAhH3en1d8nUPOuNp4PUOeDuOkkbJioregRXMeTkgqQan2Xnf0i/6/+GeY9sVoaKnVYgoyvSIlIWmUli3s695uKhvtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153195; c=relaxed/simple;
	bh=N+36xrUjkOa1sFBgSJgN+WTh7PZ3GhdlZultGg/uzmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMpCwwFY2PzgrzpAgsncjK9y/bfPsHOUIgunE7/4nUs6YNLN4SWXxj9sFaOyiUSMnxo5ylwypv86BrYYfT7fVm7vfKZ3IHK4nMBNt5m3wfBgcqudkSYQYw0te+JhjasMAqzbkMuWGHOj8KsamBC71Gg3YQ3Q4mnG5KIFBOniwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbvHjkvn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbvHjkvn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3900e39d935so1260907a91.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153193; x=1787757993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FGrDocbe45FnzHVdI0AJ39xfusQIB2gkHqvovUs3S0=;
        b=IbvHjkvn7Jes6Hy8Y30bWuJBvBh+Ic0voURZ8J9Ptrq+o7Fo7ZPOiD+ERrnkeSpJ5C
         imNpKB7+1yiiWLHN1q8XG+kWOPmvISVwMVJWTAfKf9wcZHIie5DibOwpDERTz54xOhJt
         onDQRDOxDRtXYEkoXXzuKy8CFc/GX1uNftG4/Lq/z12PwFSGu7Wux82gFxK1Za7mf6aS
         Kd/spScH64RkBUH0aqF0bQlSFzpHLT7ITLCf0pfqRJmK/0qjhCi/cg7jMWDDoSTmCwL4
         4EKaG3H5PaZ8fnKZSIpR9emMD7Fm0bdyI4J7rShPC7fNdynl/708YayLUSLcawqjJK+u
         g5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153193; x=1787757993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5FGrDocbe45FnzHVdI0AJ39xfusQIB2gkHqvovUs3S0=;
        b=LkCyuJrCD6t44ty3vLMNW0OSKn3AZM7adN/MSR+6wQ8MOfI5qs191pCdK1ct4RgzpT
         p0DFssiTH9D2gLw9oiuRI0cQVz9lm2XCfnx8i2ZFaTGe6WJPpQSv7jus0TfhxouGAsj6
         Okmy3F56piAWvDi8xg5p7GaNiGWmnWEpQLxHEJumzshhfbMZTPMby0+k+BKKJeg/gwoL
         HU454FglPPNkNMX8IO4sjR6ZwH4ngVLTDYNBFu0zU4rX0UX+qks/VGeXaH6fo6nQqmBT
         8e6aHMn3uhmA9rK5kY3PdtEyVnuxRBbclkr2Y1NU/GXC6Q9/stl3wN8PuN42wfy5enbs
         GtAw==
X-Forwarded-Encrypted: i=1; AHgh+Rrq5cDdBshgrwlHt8jzJI3NAXV5CR1MD0Sp/chO3e5FZZhRKPQXwO/EF/DP3kTg9ZW7fH86TP2Veg==@vger.kernel.org
X-Gm-Message-State: AFuF++lRMquwflXykGW6xIgG96Ao3uiXgPYbvBH53QkDqSidLSOTxe//
	KIkoYPmNsTDJZa4gvdQ5y+BdZoKFQpb1E8ifUD+VxuQC7t0lIshRNxQO
X-Gm-Gg: AR+sD11yyoqTrqMpwbGVhNCnr9sAup12Li92zBgpdbYPVk2gB5+Dnc8XMPo5zFT3c9N
	EE0sAvGCMGUHzeRtDtV8GukiUIIcrSpG3zNJD9GuvwqImr5rm8VhOAHQAZYkvA1Lplrxd/xg7CS
	I30y3yu+fIqw6wm58PIXzUWgOnRZYLMPiXBg9D6XYSa5FGDdwIY28HwdVPEdX7lv1YQULpUFdB/
	+bEaEvUn5nbXQmVyuE8MfZjb8Mn9aV+hDrutE2VjzIsyRSo3+87XgT9N2h2cdwyifXQDKIiE6gS
	GMY/hx25if9/CdfXQrqwUn044bMmQh90FMvfiwHFEDf/9bZYNS6aHWWwPlG/i7brSb/e21ZuOOT
	P6S643d4oYDBPVZiKNjDzhX+nefQkItoOs7M4qS9sXrICVhFCTnMfQKh2rPv7QVSWKGwbT0pJyV
	1fJBVliBc0kEa9Z9T0Dm1F6VmBl2NEUvxHjsOeqVbG07qk4gdYp90rJeYSlxYnYAJUV4p2uHOnT
	/TIhMnNgLQ=
X-Received: by 2002:a17:90b:380e:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-39581212176mr9795535a91.9.1787153193270;
        Wed, 19 Aug 2026 08:26:33 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:26:32 -0700 (PDT)
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
	quic_tdas@quicinc.com,
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 02/13] soc: qcom: socinfo: Add SM7250 SoC ID
Date: Wed, 19 Aug 2026 15:25:31 +0000
Message-ID: <20260819152545.3934-3-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819152545.3934-1-sreeshankar0910@gmail.com>
References: <20260819152545.3934-1-sreeshankar0910@gmail.com>
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

