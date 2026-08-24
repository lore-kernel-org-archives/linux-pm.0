Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E136E478
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583832; cv=none; b=fWpGiXHox2BMwV0QEzwrdMf9t/DRsFseioivqKQ4VAfiD6SfdZrrA+nSgS1WroVFZ8fPJfy+xPUhOAvVZOPp4YpAYFNGJdrlWWqCsqH0W1m9T8pr8IPgMNVdJtcPUatdsbA8FVdl76fQompSfuzWZa5mzDuykGbVvLLFGs/3Jio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583832; c=relaxed/simple;
	bh=+m7WxzhF7QuTKjSt0vk6t6LsZP/6AIR8o4P2rlZl1RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+IHSxwXXQF0fUHRtPcm2fR92ehxiXTwYkXPy7n5urDiho+SjYkkkVxpKMDrLQiHq6ND5hxC0WLVPUd5Vnlt/mhFXGMakWWe1qj/nils6vVViXx+cClE4kZqR6Eg3+5sDlS4BeZgrbXvFP0NKJHrS7Lx4u0srlrfq81ePdMkKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkrhQHDo; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkrhQHDo"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-448b0ff4a57so4934642fac.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583829; x=1788188629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khMXXSisMw9dgBq90MQcu6P4BUMmcXEpcjfAoZEh/Pw=;
        b=VkrhQHDoc9z7G6sv5pr0hTTsb1AeiZUryAkvZl0Ykr0nyawl+9oVrSc1rRZYgKSRLP
         xJbP2yVPAhuzZVuFbVCMGrohJRCPR+sKY2+bqk0iII/C/iXGjvn1nmeyWq1TjrDk2BKG
         H496BFApo4zPo78nv1a4l8H5TlO+UWdHXYUhatsQo9fOctSZE7834OkMqeasDYJKqyi4
         xFrApOYkri9skrFy1vZMQidzXfPr2i0HuJHOB612J0hgktCavPW7LFtZqGG7QMay6K0L
         DoHe4LN7mYyWfQBdeJFHqqlJLihUp01SMZnEBzWGdwMAS6JnqEAMbyHs14NW1QIhWDGT
         sUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583829; x=1788188629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=khMXXSisMw9dgBq90MQcu6P4BUMmcXEpcjfAoZEh/Pw=;
        b=BXFYDlfdR90W9HdhdPIWmsXm8U/+0HG3q72owgmK5S8CgBGQhjqdcw7N0a2+YJBOG/
         p1rjc9WoXeG3MJuQz5s+EliJsjRRONBwBdpzcDBbu53uiJej6SBb4+KcDxmP0KxPnLJw
         qOJVZ2X2qPPN9Zu2Owh/o7M3uQL+C0njlrxqMlD25hBcwN8huCrNKCt8FDjdytag6z4P
         tLvhK/S+HQJ26Yyi3likXk8WGQ6txjtozIa18DHe1IzAXc2ZtziJNbIC/nv7Da2HXz2l
         VWEn7FKdJxUm85GAhGg0H7E0Gi7M/V7yEnj9pmG1V1iyqO/sqAq7g9DFFOjshrfJoWdc
         Q+gg==
X-Forwarded-Encrypted: i=1; AHgh+RpaylYGF0P0jim8xaYG/FiJpc+b34atoAiP67G5ARhXzH9ILfChbU2H2PO6mwhNOzoKLUY32zI4hw==@vger.kernel.org
X-Gm-Message-State: AFuF++kZVNO2VdF/K9CCx1wVnOErE49+Fa67YpqZ0r7Lky6e75x0tnzs
	6wbb2Yi2VzJxyItqyvJoiuKoH8kWuJWbWqVtp4f1CwHPbO+3VYT7/BCU
X-Gm-Gg: AR+sD12fDGmSQcgIS1exQyIA14PkrHFNCAlzAX1RYKzko6DCCs2U2WlVLxMvk7uTQZA
	3iZms73sKukHa3qOYvrPBzdhcoNy1KU2C5ZJl3O0aHBpUAh+Mop1NlWxlwzX/vJytnARMb4XJHe
	wsXiXhDVLivWsVGlpLkzwixz1G4CoLhM8ncmQ6YfWyuFYQtGLOVS/RXXL/68vkwH8ISye441yrR
	WSVrBqU/qVervkB9R/gfUbrvtFIRVp8Vqc5EYxPp9nvDr5n8zKEAiV0/Xt2S8nDnwPcCn9i6gZ5
	kRd9TI1k4tFuhi8ctUb7GNPpAAEh7Xq35OB+3KN4Hhp4BjOW0fdmulhZGPXvGX4i+zPduKmV/OM
	QTvTAqhJhg1DjuYPEzIoY+FZB9YGTCzWi0DpqNsRz1B3/zatkxe997QuI/B/uny/lw6mdHUZsbq
	iAx9z7F5gPMBuf/yTdiSQo8jfoHsjNbeYTU0wEUAVWqq5ttdzDp6upf2Y6oBUy65QfuOt33FKMR
	8JfG0zWF7HcLebN+eLa2Kc=
X-Received: by 2002:a05:6820:1513:b0:6b1:4cfe:ea6 with SMTP id 006d021491bc7-6b1593eb71dmr26836615eaf.32.1787583829120;
        Mon, 24 Aug 2026 08:03:49 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:03:47 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v6 08/13] pmdomain: qcom: rpmhpd: Add RPMh power domains for SM7250
Date: Mon, 24 Aug 2026 15:01:51 +0000
Message-ID: <20260824150156.1310-9-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RPMh power domains for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 96e4bd2f5..70d0ff5cc 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -490,6 +490,24 @@ static const struct rpmhpd_desc sm7150_desc = {
 	.num_pds = ARRAY_SIZE(sm7150_rpmhpds),
 };
 
+/* SM7250 RPMH powerdomains */
+static struct rpmhpd *sm7250_rpmhpds[] = {
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+};
+
+static const struct rpmhpd_desc sm7250_desc = {
+	.rpmhpds = sm7250_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm7250_rpmhpds),
+};
+
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
 	[SM8150_CX] = &cx_w_mx_parent,
@@ -910,6 +928,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm4450-rpmhpd", .data = &sm4450_desc },
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
 	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },
+	{ .compatible = "qcom,sm7250-rpmhpd", .data = &sm7250_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
-- 
2.43.0

