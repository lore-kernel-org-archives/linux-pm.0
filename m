Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485636AB7A
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385748; cv=none; b=BAX5IvMjOuOcBrJlZgztoC50MHh/Z67ols13ZqGd1WwhgT5T64KbRYimLKeXUVdaM92VOWYCj2bg0QJZ6+fq7/yAFd8GJn3JEycoWemGSSZPbAyf0vXImtWua1oiuK+7dMToJESaD3Y2e3fFOyFUHg9BQaG8yUFiihtWHUjNlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385748; c=relaxed/simple;
	bh=RJyJVigQaOLM0F29T8s/4IhVwmKqS4ZNXPoeDAhzrkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqiv+XWFrm+21qnnnNsM2yqX0ZMSUF3OG+Qkh3IdhIEY5xmUlVI1xDXsisn0MVHUHDo5zp8i+KApqnDWtaISATsrU4pr3qkqMF9nUgP1OPsEfuikkVWykdyUET5g1tHAK+I4C2pMOaF2VYuzzuAOL1v9cWCDVxDW4fz0JFM0PyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnBwfq7R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VI7/5gM5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnBwfq7R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VI7/5gM5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tcvU2017738
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZBGna102s7UxMKQ9bLg8nid6z7Q/g4WSEiY00RCl3L0=; b=QnBwfq7RRGsS3fGU
	Js0PO1nYVjvfiAJCG45vb7H4EMdm7X/FyaN9eqS2/9BUbqjcOMG1Orztb2eyy0JD
	bTcegnnN4N1BK1c0OAbWET1IivwkcjZZ6tdluibyaEZjn0Eh92Z8s5AgTGZlBek0
	gB0SA/7CQe6KWMRHn4tUjqDSb/2ledeWJiAmcFsxkCR7jVGuz6LNAWYA4dR7NYQz
	LJ8c5PQf7HGm5yOHBztsbdNZ12NIPDBYk4Ue8C96LEcyxjCtZjIsZILdK/jlHDi3
	OOMQJFcz4ZXarzx7S0e1TlcapeluhzVe5+CmWxRfxZm/l5yqQ/JPVUL3gCiclzI5
	YAOl9g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4wvxqt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:09:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829b6b22dabso781776b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773385745; x=1773990545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBGna102s7UxMKQ9bLg8nid6z7Q/g4WSEiY00RCl3L0=;
        b=VI7/5gM5MVJcJXXboli4yxn8NlPLbkuV2Mfq7hNgu32Ud3k5mxzcm/Ny8nruVr+0YI
         ipt8GNnC6/eqx+PpY1rzwxreoai/Mqx+HtVQCUPVii/6Vhbj+/9PyYB/6XGzYB2+wyQf
         Ea7jAcjeGqFXeECrESA2Xf9Hg9Sj6A1mE+EWUDf+WwNY54Cd6J6Yo3Ql5IYRW6EfXe0J
         L6onM+0sMW4YT2t/9mKWW4iccupQ+Z7QLyXvwbl+REb3aTVym4aoHY0R66axSnOkZl44
         kBgHUnNEOrSeYmxsXG3Wl9WEz9AXVFPAXjuAUTCnt73w7Pqwf4KtdwoSiJboLE++smAM
         dioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385745; x=1773990545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZBGna102s7UxMKQ9bLg8nid6z7Q/g4WSEiY00RCl3L0=;
        b=PPHNBOzD+ql+TUVL4Q3loRK9nr6LlWvUzhmC6E7qkmskCTC5juVlL25vArLeIISath
         Uc9r5oX4DswtmYHBH5zt+mnpNNpFPTB7jgDMAg4QkC2umeCKp2iwnGIIrxdeaahRjIuV
         fcofPhxydRkTSG+YLkVcWqL3fBFABz+kIMNKgoDK6vH9v6l7JjEDsurq9kMRQYGZqOkE
         MKxTGqfJQN4NSYhAlnC3XJAH6QBxOi08Spcivp88Rdt5m/I1ZctNW90GID6Kt22dFl7g
         +MCtwAqYWnUElC4QcdQ1SulfXT7vPhnVAEr4aJR7+RqFMZFiO8Vg3gF2VDy+0GQ33yum
         aNyw==
X-Gm-Message-State: AOJu0YzcdWVc+vJDsOooloCnoxHqcKhrmGIgX2TqAgPE/iFF8qkGa8DQ
	GKQ380dcJWbiGDRTemal5nvMgbIPnzAcEBCjasq7+8pbQ41dmCCyie+HQ0lSWT23D7wMLrZEQ99
	y/L8VgN+uJe5Pj6mgx4ww1msdVWa2CD6B0B9wEd/jXd+nNxpyX4PrfzPa9M5Fgw==
X-Gm-Gg: ATEYQzwuWfm5FP8JNtPoaIQGNf5qmsyuOT0zxOyctYEbsvErwF2CVCeF5E47bVCdCWy
	3kuJvwjhGLYh9BLA44nC9c0E2+rS5bxATRClldKJrr7Z5iEGKChNJqVTHyiDzVzPCrIguqTKJyu
	ae5DMrF4midfKdMAg33dtv3AcFtFamFyRWc86rkrWZ52dRUVo4KaP2Dgmafjea/xiR9xfitZZ8i
	+RcwIByn4GUPUfqEfIUJ4dHuIIvu1vEVMyAUlzCl+pPgT6EzMFXjbliBCKrWFdm4o3BLaoRNHFQ
	bUPG//nDlVB4ci7bjbWuL9Ib+aFblToMuXi/enEmOheXba+faQsTo9Az9JaanZrnmdQAFC5vYOJ
	YQMNhCsDVdP9dYnMvwKV9lxR8Wzo4sHt59IjFEh4Z1Fz095BZatflRy95
X-Received: by 2002:a05:6a00:928a:b0:81e:4476:f67c with SMTP id d2e1a72fcca58-82a196d976emr1922413b3a.3.1773385744788;
        Fri, 13 Mar 2026 00:09:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:928a:b0:81e:4476:f67c with SMTP id d2e1a72fcca58-82a196d976emr1922376b3a.3.1773385744317;
        Fri, 13 Mar 2026 00:09:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340518sm5148536b3a.34.2026.03.13.00.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:09:03 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:38:41 +0530
Subject: [PATCH v8 2/3] gpio: Add fwnode_gpiod_get() helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wakeirq_support-v8-2-48a0a702518a@oss.qualcomm.com>
References: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
In-Reply-To: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773385725; l=1348;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=RJyJVigQaOLM0F29T8s/4IhVwmKqS4ZNXPoeDAhzrkA=;
 b=D8zrgRQtWArQCv0Zo1sugUcPcd6RMCLTFZxMCAirCh1759Ub3bZFRNHVBFJlIJBo9VhI1BjAH
 n+15tflY2ABAjeEzI0mPp3HJ+vk9sBQ+glRmAnvJ+fcrsp15205EQG5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=GcoaXAXL c=1 sm=1 tr=0 ts=69b3b811 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: B9w2IQangaD_yK4Y6RFmpQ8mUniT0Phu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NiBTYWx0ZWRfXx8sQW47T/RfN
 8/A3WcQpiVrdFT1/vDhMKdz/XRmNUG0+CeDpv7H0JBolIVegkjm91WTj9H1jDwyXj4DpqOlmTRH
 YAl8xW/q55VB1kmf/aERcoOS7xWBj8+66/EZpD80bFFd1+L9BM3K3VB+dN3Osh8b/SfKM6SUyNy
 NUpiRLcgHZ9sZZgZNRk4DoIbNeMvn2SzzbBumjXOlpToyHGoKXGpqV4eiUCD8/EmBt8GWagNI2d
 TPI8gzYzQjMH3PtlHComDrHp4mHmrsXmiaiW5P+D/+rMI/8M+744w4cdebZeCPW6/vhXS/mlajg
 A/Axi1uTBOVPBKBYmG7w4OZjT91dvakWTXB0tbUhsKge3b5e4om64mtm17wMARVFe5IdNmopktp
 VFcWfNFSk5yjneeJulj04hcwnhPPYi22AJgz/asaSgyNsMnOWKuh1Ey7Xfo2RXka1zE+3hRNznV
 ArDwxF34Xp6EfS4Dv9g==
X-Proofpoint-ORIG-GUID: B9w2IQangaD_yK4Y6RFmpQ8mUniT0Phu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130056

Add fwnode_gpiod_get() as a convenience wrapper around
fwnode_gpiod_get_index() for the common case where only the
first GPIO is required.

This mirrors existing gpiod_get() and devm_gpiod_get() helpers
and avoids open-coding index 0 at call sites.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/gpio/consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0d8408582918680bfea6a04ccedfc0c75211907a..fee926c0262ce9dc4b9a3c151e74f2cf37470a49 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -596,6 +596,15 @@ static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
 }
 #endif /* CONFIG_GPIOLIB && CONFIG_HTE */
 
+static inline
+struct gpio_desc *fwnode_gpiod_get(struct fwnode_handle *fwnode,
+				   const char *con_id,
+				   enum gpiod_flags flags,
+				   const char *label)
+{
+	return fwnode_gpiod_get_index(fwnode, con_id, 0, flags, label);
+}
+
 static inline
 struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 					struct fwnode_handle *fwnode,

-- 
2.34.1

