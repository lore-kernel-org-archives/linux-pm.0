Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92E47A87E
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254795; cv=none; b=mG8HuGLO/p+Y2MOWkx0Pcc6LPXkR1dyG5AIpygIbwXuQyZ6YGgk5gbs77wJeYsai9yrWTsbNSs24ggdI0Oc5BBt+9HuXuk3yy58NamoIPs7jxCdsdZtlwr6vq+j5vOA85H+3RLOdJiDJlsuDuXj7qhA/NbwFqxk55ZVDMUi9/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254795; c=relaxed/simple;
	bh=+m7WxzhF7QuTKjSt0vk6t6LsZP/6AIR8o4P2rlZl1RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swzcAL1Zsn2yzRA/LgzJXvJ962W1PMfPRmlb3pkecj9lJx9FNzWRiCfyqSDsgBKKbAccEaXD1azoYtUaZmAnEi+yxlTEWMTuHq41lqKJUkt1+NxPDUU/z9I7AVmO1zAp2xBJnbZolgOYt+k2VzLpbTd7IPKCOvDFM3S5T4pZD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT0fKfCO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT0fKfCO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so6247168a91.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254793; x=1788859593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khMXXSisMw9dgBq90MQcu6P4BUMmcXEpcjfAoZEh/Pw=;
        b=eT0fKfCOXSn9IEcANvNS9ndZyCyuxaAS1IFXOLtORxQGtjmonf841KWUpIIpdDEKV/
         u0Lj4UC880YnlIBe1oFxjhjMjpP0YbQTvhboZnY6TYziQa2lBcuICvVdTqDWH6jUTVVJ
         qbrFHcMnHwKbGIAKt7PgzBNMdup6UrfD8gtX0R6wMKdC+ShNRa2lgEoZwGD8DKPfhwf7
         hBhxqR/PKvAWWPo3//cNkFu544p8m3s7CdAnQnRZusRFmxAV7DIZaqaZsAzXLJTiWf/L
         KU6c5EryAmwsiKRIAlFVJnwJkbAIUtatysj/rNri7bMgoki8na0yNvYvOQ/cNsu4ZMIr
         G1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254793; x=1788859593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=khMXXSisMw9dgBq90MQcu6P4BUMmcXEpcjfAoZEh/Pw=;
        b=ObefxxghyeTk0cYiuhqcuI7SNb0grctR3IiZQGrtS3xOvwTxiigMm5YbFsSgzxsTJW
         CNLZ2ju8b5mkJrAV6CDce+bh0JBLTFLmUZP+UqGJWZjdRt9Ujlflj7+Ep7UjKK9y1zsZ
         bbNgykOliYtRM050ZIooVCTVqW1obE0B+q9fGkld3MTDsmFzUvxduCxR7DWLCgFp+umT
         L6DL4Wm+tgKnKNmEplOgNYAd2mBFL7bNuavR5ikrjw5Q8VsH4jUkSrhNs6YM+PCXBSd9
         gQcjexpuV39Q6OcfPuRKImK8jd1jHWtNjvtJnJVMRMqyY1RExKRPwHSAOE/XUlzEZE61
         QY6g==
X-Forwarded-Encrypted: i=1; AKwUvBx62fWyv7wbZpnO9VgtUoVofaez0TeGQb/KblM3iYklcovGK17EJHV1ouxQ9lb3IenPLFYIbRV4Rw==@vger.kernel.org
X-Gm-Message-State: AFuF++kCDx9ulmSgNvNC/smZseZUwUkwK3nalqA3QbCTAn7oHfA9y+fs
	xLloekz5eq2QJ9WozdityR1Oit4WHtUk+08uasUCajlEHdrpqzBI7Jwc
X-Gm-Gg: AYBFou1cyiM3XOdXXcqaoVbyuaEowh6qpHpGNz0fOzBVDs63TTW5v7flOeD+1mLorTo
	wOVQ8Ws6HeS5UUJDAWa65rP9aSwuJO/oFkNl0ubDfcX9uW1tyeWazQRqSQHsJEMgqZxL9saJc5b
	uGlRqaybHi7v7xbYVKFYr1LbgOuP4qCqcbP3I+0htjXhcJF602KOLaKG0b+gg/zySiTmuSrfYxw
	Ana4g2htEkaix3NZZhByO0I5L/4HEthg71vq7nhI3GDcsdNv7L7S2YGaH9Xe0Jyl9Xj7laBWPrq
	hLir/Xe66/xU5vF8MpFWxRLgd9WK9lmhFfP1fNwpcdNTlBrsps1sjMPfkprrDThJ2yHlzwKWqGW
	1N89tIkQtVbUvN1QlgPXYpV36AZjR1dg5rNm1bYLU6G02sputOXZ8yMo/Qu1JR/MWWSUP+l1Lr1
	HuUuwdDvWX7JiT7eMXiPglbIw9v0F5vZl/Nm3F5L2k/iRYy7NZONcSZ2lBY3SQ7GcrfjkWVQEcM
	/SgfNadi4Ft
X-Received: by 2002:a17:90b:3904:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39907e82897mr9143773a91.21.1788254792747;
        Tue, 01 Sep 2026 02:26:32 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:32 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 08/12] pmdomain: qcom: rpmhpd: Add RPMh power domains for SM7250
Date: Tue,  1 Sep 2026 09:24:43 +0000
Message-ID: <20260901092447.3028-9-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
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

