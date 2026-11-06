Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978205;
	b=J3zp/Nq4Ca614cHDghkW4j59paGS8AvH4I1dQwK9sBbrVKNxOho+kOIPuwo7xy4s39nA
	 F6qTXXbmGA0ljB78KE3EdnQFXMiv6Lk8qY2AWC0QnOS5MnwR6PnbAN6pOzD0cnA6/ioUj
	 Dt++lkaUDVdsRbYmd7cggzMaRy5+E3tBWAsliQg9rDLYp1bifOz1QdzAOBa9ZABlrfVvU
	 GMin6wpKpQVhdyxO6cFR0gcBmyleB6QWQJhtT8iRqAuM0ZtSAbWwy242m2I8FuMHhUfpy
	 17cHwj5QlycCBYhbhzvMvJzBl7al6RQLhQLqibUFupwB4jj2TQSxNH4DFtSxTDPTY2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=c7DqBwfCOvSVsSgj/qzC/h4TOpHot16HRpVVgmGU0qw=;
	b=dax21os6oC07EzSb6gARrNd30mWVYihBnRTnDmmzPA4dVJkJ9A9AIh6mIuIlI6uCyheI
	 OJlVBdirh99v8Up90W9DZRJUcoiRhR3y/lo8VUNce9u+PByFKLDlhGcLFvdaQSLEA6uR1
	 Z6KaE1Rtifyu3q5NeNkGl8LkqjFqLE1kBF2laHdZiLQiRRxZxtXVL6AR8lZ/Z6OQ07FmD
	 v+JlZC1hfqPE3XJGXAfvzS9v4Nras4xZAW+orDDpS0qOTTliPq7b39DULmcWrUHMPKbVg
	 Fg9zTCA7txxqdrVE9vrmB8hpEZlQeWEre8gWMDiAvXok7ToH8IOca2lC3RBoitjq/yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Do0JzGhN;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CD606D814
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59CD606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Do0JzGhN
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35829219da8so1867725eec.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978204; x=1794583004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7DqBwfCOvSVsSgj/qzC/h4TOpHot16HRpVVgmGU0qw=;
        b=Do0JzGhNzVIDY8BiFnEhm2v+P6LqjF8efTg+mpnLu/lGFVMhPLcudHIw0oZR6aMZmZ
         Cx2dqeLiuUKo/D8GjF+MC9SqOo1/YXUNojU8kQxfWXY6fLVKPP4tW0Xo1APUVk1K7r6x
         MnkoXfGtNWw1exePsnFJYAePhyDDGxp15gltREqoh6/M/IJiIC32HpJsuaFyb/pSabkq
         Lkm4Jr+SbdwB9UmY1lg3IsP4DQumhurcsx1rakZr7ue5Jb7azcTV2HrVmCqbb2SjKBMx
         mADi7qeWHLhFHaL4xGBbuqsgCoOSPwXavVa2JITRk98jG2hZfpQwtFBqfu/7B/5qZLxb
         whpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978204; x=1794583004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7DqBwfCOvSVsSgj/qzC/h4TOpHot16HRpVVgmGU0qw=;
        b=YSqtlMFgKx2iGLD9QDtXti4t24TMC9RVLQvnIQE6hbWxlsepKK55tiMNvnXJRV0Fe0
         EThtDP9bcM3XxlFlhjOuvRGj0sLiylh3MJArzBr6bpEsD/iF+rHSDEX15nv+0H3Gg7aU
         wKpywde7xujbAemRDi0OtBvvKFEPnfIBgNGzMghUuUNdZe5fhnIFwbui8hIhOsXJVqn0
         Inw1l3Bjvq0G3lY1BE2IiqzWdNSNr1beSJG6B9ZD21qeqjNTQr6T4D29k7BC0uQfQNLu
         EKyD0nghPIb8ZJ4//U4Zmp7lr7M2Iz7NjLqmT79xM5ZPDcx6bnyq3bI8YeE5n1kpJ3jP
         m6gw==
X-Forwarded-Encrypted: i=1; AL+hErGYiPwzPoj7B7my/AQF5kOu3/W+weSiHXI9+xGA6+JTGkqyJMHjbLHEmU9bNDXJkddHROscXbH6Ig==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yxTVYwnbF7upjtjc4cBGXMhbvKuygdcowg/QUBg6meZ5ufWaV
	HE/RvMXRAoUAvQvEhGLPbumAPsT4x5c0WQlaZR6c2u2KkWww18AEimi0
X-Gm-Gg: AYBFou1d+r4UEXWFMFEryaGRn8/ThuKVtcBCDp32KbBnRewpFIpShVJN7W2qBVAVUp+
	yuccPBdFRvF52b9fQouB21XnNyqrIC85CkC1cQ7EbEJGR2CWmOEQY3POg8FR06WTX/I7XN68QbU
	4jF4xzn8bWO09gaeQvaWI8eWsX8mciyI0kTJocRBiHv5ljEDGg9QZrZGx6zfJX+RhrnlqFBpJzE
	kgRroIvmtloj1kRUjJyVoEsdoMv/DCRjmzF4ousi4MXmjEoovf32CQlBWtDsC4vfGKUfhRc/57H
	kBcnlhBU9kDaYvE6+fk6/rD8c92TnnpwIKh6QdcjQrZJeAEzvw0t/b8jB2Rsq1AJsXgdhF57dDo
	HVM3DCqTsBd1nsnUo08x1UQwBr/ah2zjgo71B+8lyJH03JCEi/6FZ4nkGK4Zn8zu6lBD6TJyiEk
	qDofdduSbspyu66yJ57MlqtprjAzqsnqKnfCc58FKZ2q+tsrdaFLsNfM/FMgFFhGzpmrkynnI2g
	7oqCAu+NsQ7pHxxCeaVliyIw1dL2LyT6NXkxw3aki2TKBTDkNpO3j73w0vvU3iHoaV6GyqKui0+
	G6vT01BYL6LvKQ/M4yvzZZBwRhFC9WA6XqyMI04jAPZFiDJeisQgwEKCUdrqxnH45+dXG0xF9Gq
	njwo8lN8=
X-Received: by 2002:a05:693c:87c6:20b0:36d:be15:2dd6 with SMTP id 5a478bee46e88-36f786b80a3mr3656191eec.11.1793978204009;
        Fri, 06 Nov 2026 07:16:44 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.221.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9ed126csm7581500eec.18.2026.11.06.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:16:43 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 06 Nov 2026 15:15:40 +0000
Subject: [PATCH v14 5/8] thermal/qcom/lmh: Add support for Qualcomm SM7250
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
Message-Id: <20261106-sm7250-v14-5-7d167e993f9c@gmail.com>
References: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
In-Reply-To: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Sreeshankar K <sreeshankar0910@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793978147; l=1842;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=nrvB5zH4Ws6lN2/TYy6n3q0Zl+5LhXT2AF19e7i0mWw=;
 b=Bg26cDWip0StNiuXBGFDPJOYA7KHd30tYkjhqU1XZP27OEap2sAlfVjbtRada9ecFjGKKD0gE
 WxgM/5NqCakBw7UEG/sJYuE/yYsOf69BwoP7gnV/1MR0D6xdbLwbf3h
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Qualcomm SM7250 features an asymmetric 6+2 core topology where the
Silver cluster consists of CPU 0 to CPU 5 and the Gold/Prime cluster
starts at logical CPU 6.

Add the SoC match data defining the CPU-to-node mapping (CPU 0 to
LMH_CLUSTER0_NODE_ID, and CPU 6 to LMH_CLUSTER1_NODE_ID), and register
the "qcom,sm7250-lmh" compatible string so both LMh cluster instances
can probe and register their respective DCVSh interrupt domains.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index e160ac477..d3e6084e9 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -110,12 +110,22 @@ static const struct lmh_soc_map sdm845_map[] = {
 	{ .cpu_id = 4, .node_id = LMH_CLUSTER1_NODE_ID },
 };
 
+static const struct lmh_soc_map sm7250_map[] = {
+	{ .cpu_id = 0, .node_id = LMH_CLUSTER0_NODE_ID },
+	{ .cpu_id = 6, .node_id = LMH_CLUSTER1_NODE_ID },
+};
+
 static const struct lmh_soc_data sdm845_data = {
 	.map = sdm845_map,
 	.num_nodes = ARRAY_SIZE(sdm845_map),
 	.flags = LMH_ENABLE_ALGOS,
 };
 
+static const struct lmh_soc_data sm7250_data = {
+	.map = sm7250_map,
+	.num_nodes = ARRAY_SIZE(sm7250_map),
+};
+
 static const struct lmh_soc_data sm8150_data = {
 	.map = sdm845_map,
 	.num_nodes = ARRAY_SIZE(sdm845_map),
@@ -124,6 +134,7 @@ static const struct lmh_soc_data sm8150_data = {
 static const struct of_device_id lmh_table[] = {
 	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_data },
 	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_data },
+	{ .compatible = "qcom,sm7250-lmh", .data = &sm7250_data },
 	{ .compatible = "qcom,sm8150-lmh", .data = &sm8150_data },
 	{}
 };

-- 
2.43.0

