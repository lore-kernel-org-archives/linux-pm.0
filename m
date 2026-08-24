Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244C41E6D9
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576724; cv=none; b=kxhqmMSpG967P7XFo+Dw9AsYFaQHTrV8vaidP9vrL+uzlgivXJmIbbZ4mJ5LT9yERm1o9hsZfZv17hC7ULxtFd2UAoeNMLOBeIk02n4Z4pBNCfs1IoNa0rkfVpXBvAaMBLg8ChKD+AWdPjawPNSvzH9fxR/uu3BkfiQuk3q2KSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576724; c=relaxed/simple;
	bh=0wB3huwwaG49ycl517NSgfQ5t7SptdZ6MYz/Al88uo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEdgmbvPzBV+BSKwJhnQenKfKMAJRleOQrfnnOijKdEVJiqFeMsVeOWzQ7cnBwerpSePfW2HNqT812qcbjq8ixdVR+rAzAP+6nxSzlzQou3yYimQcO5GeaEF/tDqc3U3Ktz9ZqbHW/4bZfhvOy34L+SG/CuaG4WAUItktIY7mAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ5hszws; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ5hszws"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb34c17b96so3256841a34.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576721; x=1788181521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvJP88qTTuZPBMVLY1eZgRPCHAr9o03VzsEiEHnDVHs=;
        b=TQ5hszwsadExAZ/HgzBagiaYn1wZ2NWrPaj8sBg36pMmNwsmhWLSS5qIBL3Ls3tMsf
         wVmBlq5gGEMy+CbP3tXZTb3J7uIpRxlW3aZ/moH1cVCDCS94RTMeyCGKoJ0OjYkC4G9l
         Gsv6c0RgCKM9bafNWC3FmcRL3vN8H3yhj7n+anve+JH8meFARlwsjt/7ptiPSxjorNXW
         OwiBvruGYrU/Bo7EACrx/NTejhIHFaO4gzaprT0QIb9Tfu/FzofwxDxiNnMQ9aS0Ue9k
         i2IGMQ4tMQeSz6J0UBJFVvM2VsAcpluiTbUlm5RMqsJKkRsdy322dsRySdFkPz0EGpCZ
         sADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576721; x=1788181521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvJP88qTTuZPBMVLY1eZgRPCHAr9o03VzsEiEHnDVHs=;
        b=KBODs9K5fczc9aK6mMzjyNl3GLTUoSP9m0c2nTbxrn6ZJH6Sekip77isyZKRTDneOo
         cusz/0PS8LQHrtMNo05FZz0YUJ67c2MBvVj+Dd2aFG0wU+HUaYJdC30xvRFz+jWt6QDD
         y35BSJu/QjGom1K0Ha+WUVbeEJTHkHpiKwWMKxp/jFcBj2rISe1/5nkmzqkb0hQTrOnm
         Lb5/z9KUepq9hyUyYDMinVOln5+4hVJh0X3WkEtoHTCT5XuQoTlWWO+FK+PbCEMZkpG/
         p8IIlq9gwmKVe7tNRsE1jlcrlpvlm1bKGzheJ12Oo/8bzKe61FmJD7cHHxdeaV9jH4xY
         lJLg==
X-Forwarded-Encrypted: i=1; AHgh+Rou/pv0tMe+JMOjyvvYGJkelBRgMNRwM4HpK261XcDPanIh3Czf9WOWUb4JahJG0dufkK7UWh8zkw==@vger.kernel.org
X-Gm-Message-State: AFuF++lz53PT0Iww9y03xcJIroXMS2fe0JRxXsudRl8Kf/4pb9wXJ4ar
	JLOiwJTm1nlQT5NS51S1WckcPtMNv+VDeL76u+ZBymOR/2UcXqDU2Km7
X-Gm-Gg: AR+sD13Ku3hS963BJjD8fCaN939EGjEHS9jOnierh+HfwgY8UA1AsR5lwHAEyfvmlZn
	Tairtf7g5edp6cO5mID5hlPKA9MA9Eb/qJasVn4uLYM9chRfodiI89qd/04pLhyqgeH+Vh23woL
	f+A9eNN/or48/KgvVVboJJjTKO5dQVpp3k9fol7ql41mqPi2ohTnMMUH1IeKNFTfj9drf8Y9iAu
	4G0WPtlPaHaRjAWV7mrFvdgRYSQirjy68p3V51Hm/I2UzKFFOtcZhYb1ENvZIkFEFIUTFJh7eEe
	9ddDAM4imjo2n1eYFpGBNABjrEzAAmRyYkYcF/w33byrugK+/aJ/BTMMTSHYlY2K+Lh3sllT83/
	/+fa1ZCIk40CeJrhR3pS0Cd0onWaXCdQcufS39B9BlAjeXXcHiRlAx6tB0MnIuO76dYLL10DdON
	mu+b+QR+TBJR8oulbZO6zxe7usrJx1Fvqp9B52L5fUeFk9BDi7M23A0WRDwcLU+eELFVCNfBC5n
	JJYMi6/GArA
X-Received: by 2002:a05:6820:1629:b0:6b1:7ee2:6d42 with SMTP id 006d021491bc7-6b17ee28ef3mr6476143eaf.27.1787576721331;
        Mon, 24 Aug 2026 06:05:21 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:05:20 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 02/13] soc: qcom: socinfo: Add SM7250 SoC ID
Date: Mon, 24 Aug 2026 13:04:26 +0000
Message-ID: <20260824130437.2771-3-sreeshankar0910@gmail.com>
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

Add SoC ID for Qualcomm SM7250 SoC.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
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

