Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538992DB7BF
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451782; cv=none; b=EWlWLRkpAAxqxdlLrLDKRDkpDnbCfXkvtHStKJbM8X1J/OcN7NHMr0kDmUQ0fdCRByoRK6Il1w4l1HvFz1csWbmXZ/XquFRqtSrxy3na5UFY7s+enfKSY228AlRAJq4gOAVhLpKUzU7urWVbe3IzJ4BkcjBXkoJjwVu9iUEl+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451782; c=relaxed/simple;
	bh=dV3jg1+DOv7fEiiK4J/r4Umlo5KMXsltUg3usnZprSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bq/bMKcQpa/MWpNuV2wQ6npp/R45nPicz4LAH4LYqe6Cx+mX53GXXSTe8F4GgJvrhRwaXMf8Yfg3WQePa2IeJGUJMXiGmQbobEWIMIIzuNMDBFyMnMVTTWTIJ6/snE2KOXLZ9OX5TwyrhmoMAKnJH/kQRLqdFeZHopYhakW3POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bynXUyNC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bynXUyNC"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a2e418105so944941fa.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773451779; x=1774056579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67czfmKo1V3NOWlO5mwtLHdHMMu/0CVjSbVaqAfW2I0=;
        b=bynXUyNCM/wFVUkOgWM1++yX6spCa+BKMGmHfkSNTWrTFDoRGUiEEdM9CBrjDlJ3AD
         k2h3Sm8NLltaGaFEmw8wOVaKbR8hdwKa1A5VQhtIDf95E8Qbm3wFvgmjsfvDhbgJdx4r
         bFii9x138wTTwDAZY1HpU3zwdfSdfAQNloU5qLJg5y1VxAAEBxG8All5qwSAtGpoF4vc
         m9IxOfVsF8KvDr+OgnHKIa81UPtGoL4pIPNg7MtSYtYr7xWu34Otr4Q2Q64De0szTqgK
         CnE5DEL13U4hK9ru3/Xlx0KZr1NCMiGjBqS+s4PA45YuuMN/rooqGTAHo4OAcuRG2GIv
         sv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773451779; x=1774056579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67czfmKo1V3NOWlO5mwtLHdHMMu/0CVjSbVaqAfW2I0=;
        b=SK26TzyNBh5TICEOls5vFrDZuM7WyeTpfDCiSnrhZ5FURpYb6ZGqVqBBbXdjqqo1jW
         MvmxWHzPiBLR95yARTD8gRl/7/sEzvcXe9jr57noBPXLs0kfZYyzjChsfA0hePvqhtJI
         fRpsFwK7r7xvo8nKjDV1sfppXjpVBm0wnH/xNdmbv10O6/OfPW1JonNOoP9xF8+eGn1/
         yHL1QebqiELLVKa7skfP96wBEe4lZ+On3RcH/hFKiDUWQFlNhrXaKnYRwQB0WCZ3FhNz
         ZKqMLNo2fTecAsHY/YKBlXcdJCvPSxy/EzjVVyvzXRTzgzMx6VyFlZXL+i1In8V1mTQl
         nZIw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZN9Xe5ML5Q/zSlR3hfET6QK0/C4dEpdoyRrFlTX/F9xOTX9OJt6IRl1ZmbMxUICIbi5QoPBKyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQp4shnq1bjJjTUjIdg8P5RiDCUr8884Bu+7muZUPN4CnTLkUz
	BdlNER7P5poxgiBV7KgkoCv8J/9t4P8cc/WltGptiT3/t+j/kTD1/m0J2VDhDGbbfUU=
X-Gm-Gg: ATEYQzyE+m9Y1mjMuupnV8nDw1MAD0W4VK/5FJ+01oe4IX2w0TA66lFUIezkK6Bu2DL
	5EQmxm9UUHLAuQatlWy7AJvmq+nKGmbXt3CATC4E4axcb4f6UYOsWWHD+JkxUvCLl/2cOaBCAQG
	KNuqZCsEKjQOTMHjY7DTB898r5sL+mZM8ZfTNOFqZusV9iA+tGeuj1JSb29GZwpPyxg84wqf8+P
	EP/vMP7tGxsxjO2YWDZRtBY8HHQTVFgkX/rAFVJ4GHSMTjij96OpkoI7ZoBp97zZ/1QT9zgzTsW
	LvmBcGh2cM+Efb3rH1uV9/RWdL3Wua8GJI++ySDvntt2d5uPH+upEt6pV4xa661KDZnlenfkYuP
	uW2c2KE0crchO/XItw4V4qlZY7yWIld0w3gX0i64TQszHeW02i0dh6zfe8sllfUjSYyONf+4SzT
	XTH27PlaMmOVMrTLDFagFTNbT8uJ4ic6SqtJYAyax2zMlXtXDzjGcicH1H61RAWkCUGg==
X-Received: by 2002:a05:651c:4211:b0:38a:80eb:58c0 with SMTP id 38308e7fff4ca-38a897a7cb2mr7685871fa.5.1773451779401;
        Fri, 13 Mar 2026 18:29:39 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a764b182asm11752201fa.37.2026.03.13.18.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:29:37 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Georgi Djakov <djakov@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: sm8450: Fix NULL pointer dereference in icc_link_nodes()
Date: Sat, 14 Mar 2026 03:29:33 +0200
Message-ID: <20260314012933.350644-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change to dynamic IDs for SM8450 platform interconnects left two links
unconverted, fix it to avoid the NULL pointer dereference in runtime,
when a pointer to a destination interconnect is not valid:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
    <...>
    Call trace:
      icc_link_nodes+0x3c/0x100 (P)
      qcom_icc_rpmh_probe+0x1b4/0x528
      platform_probe+0x64/0xc0
      really_probe+0xc4/0x2a8
      __driver_probe_device+0x80/0x140
      driver_probe_device+0x48/0x170
      __device_attach_driver+0xc0/0x148
      bus_for_each_drv+0x88/0xf0
      __device_attach+0xb0/0x1c0
      device_initial_probe+0x58/0x68
      bus_probe_device+0x40/0xb8
      deferred_probe_work_func+0x90/0xd0
      process_one_work+0x15c/0x3c0
      worker_thread+0x2e8/0x400
      kthread+0x150/0x208
      ret_from_fork+0x10/0x20
     Code: 900310f4 911d6294 91008280 94176078 (f94002a0)
     ---[ end trace 0000000000000000 ]---
     Kernel panic - not syncing: Oops: Fatal exception

Fixes: 51513bec806f ("interconnect: qcom: sm8450: convert to dynamic IDs")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 669a638bf3ef..c88327d200ac 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -800,7 +800,7 @@ static struct qcom_icc_node qhs_compute_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = { MASTER_CDSP_NOC_CFG },
+	.link_nodes = { &qhm_nsp_noc_config },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
@@ -874,7 +874,7 @@ static struct qcom_icc_node qhs_lpass_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = { MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
-- 
2.49.0

