Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453021;
	b=u97z2reZ7ysENz6wjs2o1Snb6tOqSziAR8wYRcVxEkhfIfIb1qCefePBVdUWtkwBoOvB
	 12hivfmA1iPhngKsuZuD+6/+pnHaZ9/L1xjhfvxjWQj+DanqICAomyi+hASrf6QYAGMGW
	 Fa5/dNQT/QfYF3YURyIkbGQHWudrBavfjXvT05iL4loXVTF/H6bt+kDRZM3AarmAQD+Dp
	 rVBmI8IrkNZey+KL0EfksDV7Ovrzeb5Mp1tjjFcmM+QvyD0oOCk8UbAZs3vIkUaV8m0J2
	 C5FG43TMd14yXFueOp8Xjgka3Jnl5rdDRQAsfpYxBJwHM8JEcYGkO+7arRwmI5bNn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KyrkqULzyuOm2TygVu97UNN1jy5vwvlOJyvkTfDC074=;
	b=iuoOS6P+Oqd60ahr02zmHXByvh/aboaTQjJGsPTxEcdlL8HTUb98iwruN7h7jgWLgBDz
	 rZi5mvrYoclOWmY5tWXgjJMqYMNUIC0IxXn/y47MPWkMjEB7ioYix4YRLkWB3MIEv3Vo0
	 czZajXufzUXQ04PDNzymBjHo6nbhTWnE7ACnJ3nNFR9LsK2aA3JnwoWDWpMhz/uPL0a1i
	 ynsYLVpJxUxjiS1dYCPUtq8ngTkwveqjJG/hFDsdbNPI4WClMqroZRQbv1mc8jYl8Rfi5
	 jB6sjF7RlOEfKiITT5vrZyJfGf/J6xUmzCP2ZEIIH0GBc87zgTANjjZhRubwKiTJkXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cqz3Ihob;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fPDGYNoE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B69606A32A
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B69606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cqz3Ihob;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fPDGYNoE
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD01JR589532
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KyrkqULzyuOm2TygVu97UNN1jy5vwvlOJyvkTfDC074=; b=cqz3IhobwWakp0T8
	yECU8vLSjEdCzW5N29c7HRB+wAmBd6qLTnBpkgT2yzeZsQ3Oo/FbcrEZVwSrmayc
	DcRwTYYJQlSpQbPG/NZ2+hplgEKlgDYuYJi4annhNF4Of+80m3uOxvHUmT6zhGy4
	qDYlR8MKMKuRvGK2LoHIqo4M4Hj+rsKL0PnI3WNcSBbqBu15Yt0Z3D0VZWUFrmYf
	QbshOL5S4/2T+V/isiN3Vma7WpTsAnNXjzAg/rdbG8ZQQ3BQwf/CCbDUgA0AoHmH
	R4wZwAeQI2huPmPvBa2dsFZvPrAl64ZHYsw7HnmyAnr+zwyR5QPcJ/pSG4k9jlkQ
	X8wGkA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk10c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:40 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1af203073e0so525862c88.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793453019; x=1794057819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyrkqULzyuOm2TygVu97UNN1jy5vwvlOJyvkTfDC074=;
        b=fPDGYNoEZkEhIaAZHVRTQUcPuJAR8TD0FW2itWtt/goyOD+RRtwrG0xdX8KZLEARBV
         t6RPkaVf1l3lJwqf0CLjYtKx/iHxxxYsgDMTDURqN0ZdkF1o84F6gjMehsMWYg+RIQNR
         6xRTkOBDqcqNxaVvwQjx8DLIiiXVNGoQJ4PS3vU3VwT3baiZmju4DrHiRQc6O0MEtqXd
         YEqB2fNXN6Nw65yWNXG4izFt2iL+7eyGE9yWGRxAvXztZ93nepTteQ4sVzcCMpaMqTkh
         LQkxObni3DmcnjiEVbkldj5yAy9f/Uh7VOPTZxrw8pA3kv67KzzNnERbkpIZmZ/sgjEk
         wMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453019; x=1794057819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyrkqULzyuOm2TygVu97UNN1jy5vwvlOJyvkTfDC074=;
        b=DEGE111m/T49zzVQFBaCJU8nVAR4JI6R+9mhJExco7OdLnM7PSnqFbUHRc2aqAD7Zh
         IWU4Jw/n1RBfuYRzmk9rY14YusEMSo+XOqxaydcp45GmbELNAWhAe/w7uxbxfIVsKeFA
         4/6cgG/CCn6HPQ7k58bVs8D1SDsap5t+HK6FyFtAOvh8M4rkPoHNkqS65VMoGVh06Xo+
         tH6qCn4mrjkYByUJi7TQxqYzbzP9ACyGAlxIc/7hjVKx2ept5KsfVMlKWosp0NcdeAf0
         WpVtwAnAgtt8cGc5Vx6LbEVHTc/eOqTxKeZ8uvTZPqMSI61Ejgp5t3L/GlC/yQeIfi8L
         0brQ==
X-Gm-Message-State: AFq9FYLAwWQ/TqUuqgiJNeWmReDKxNWWjLpOmMHGdi0WvZqisZLTT7tw
	XsntvAzE1LaTrIRl1y59LDQsBrbLfpaAmyz/NTWyf8qsx9he92LqRMGQAQwlFG6XYUzN4a0WKK3
	8gaYawyZlvZWRlrNjM33p5/2KPBA8rRRebWO4ydKhR6D7hvmo9U7xUCZOoY1YVw==
X-Gm-Gg: AYBFou2BayOPrFcPY/XMX6719FSK9x7zvsPoKnBem/2xaIq2ufqgvd93O4smX1/e+nG
	Gm3PkESnhxF5xT3NzoEWELwqLGeFfwiXRwwgWVz/LyNCe2dKdabTp/ZSc587nLd6NofXp6lNTWk
	aJG+JgTiCKoCDQuZNPv0XhNvVo7+MFgnRda70N3ZFCQjkF1ZrJOSTlSRKB4+cjcAaDGNVThGgen
	T8T1d33IFanlDfd6UdTyJZRabPM8E0AI0ZgPfD39Gw9b3xFtbtYkcF8U7iUhnMCxPnE2rDjHJqZ
	rZQm4oKxvqmi5wT2S1t37LWrE/rvglRHATgqOigpVoiwUdWL2vhwKfAKrM+33xgRSpP2QXZBtY8
	l9Q6AVN1Lu2SZADNAQAPtikxmLmHaANgYljchDLWoKbbMgEroaq8E2zv4tjQxapTUDhP/fRVaGH
	NHVKo=
X-Received: by 2002:a05:7023:90c:b0:138:30b1:4c00 with SMTP id a92af1059eb24-1ac56d95448mr8133241c88.3.1793453019163;
        Sat, 31 Oct 2026 06:23:39 -0700 (PDT)
X-Received: by 2002:a05:7023:90c:b0:138:30b1:4c00 with SMTP id a92af1059eb24-1ac56d95448mr8133187c88.3.1793453018305;
        Sat, 31 Oct 2026 06:23:38 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm18234699c88.11.2026.10.31.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:23:37 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:52:50 +0530
Subject: [PATCH v2 4/6] thermal: qcom: tsens: add hardware-bin trip-point
 filtering
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
Message-Id: <20261031-thermal_bin-v2-4-d76fd073ae98@oss.qualcomm.com>
References: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
In-Reply-To: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793452983; l=12971;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=xyKPuWk0ucxs0cPQi+kiBuczxmxXu+qUEiLpjxgyqKs=;
 b=nN52fRW7s8uzgHrVQsIS+VOd/MJ8jSC35EGNiNN0fb3yNdWM5UhORxyn8L5aoC1hYpxRhOEXN
 MlJB03+8480BFunSr97PnTTjRCOKBhShBHThELjUEYB+rPDdoH8ZHCb
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: OTEdsROs2ypxkxS-Mt6jzd3BT43YJU9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX/JSP6Hgh0Hoo
 5h4h6NxMnetZx8AaQoqi+QWfRmV+aCi5VWd7Iu9FtpGjbu3H0N4xl6aHB9CLOBQMuvPtUbqPJax
 op4viM9Fb/tZNVLPshdg4rAhuuAhSio075+Hpv5iMB4TcQNJCbwi0wNG0n005Gd1YA3B66WXgoN
 7diCvEYfZ0OEuV9n9GVksMf+4t9BcmvhDBnvkcPOWa4/dHv6doxZoL7oSzzKo4XcemKnkjqqpl7
 R4JKOAlwhtwy10T/QLRgRENnPuCaDbmAaKh7Oq14kpdeyWKt5Sb+q0+d0PNxoML1YmDxQBi3h+/
 mlWVhmqRk5uRLSFqaShNjOi+LAPb9B2qfNmSYsLAzMRpJEXKyKcVc0achy8WVcndQILv+FBD0GZ
 4xWqMtIQLGTy3uXU38/PK4aKUoyVTAK3nhA0e3hJM27w2knTrotJHPj8wUO+GHVyE3nSzWS92oG
 JfbY/YSUSkUluB/Z78w==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae5ebdc cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EHpzqkDVQ6hHbY9poFgA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX5q/OjrU0NAzI
 jSLaUV0exCQkZyCyryOsyP9ojgF13pNOoo8MEw12hPEuiuGCUWh50hzKG8QgBIFJOm0BMZbhSN6
 uLHWjV1v5zlL5V0pNx6ckfq77o+snsY=
X-Proofpoint-ORIG-GUID: OTEdsROs2ypxkxS-Mt6jzd3BT43YJU9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310053

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

Some Qualcomm SoCs are binned at manufacturing time and expose the bin
in qfprom fuses. The thermal OF parser can filter trip points by
hardware version; wire tsens up to feed it.

Add the per-SoC plumbing:

 - struct tsens_hw_bin_desc names the nvmem cells to read and supplies a
   compute_hw_version() callback that turns the raw fuse values into the
   hw-version bitfields consumed by the thermal OF parser. A SoC opts in
   by pointing tsens_plat_data.hw_bin_desc at one of these descriptors;
   leaving it NULL disables the feature for that SoC.

 - tsens_populate_hw_bin_info() reads the named cells at probe time,
   invokes the callback, and stashes the result in priv->hw_bin_info.
   When hw_bin_desc is NULL it is a no-op, so SoCs that do not bin are
   unaffected.

 - tsens_register() now uses devm_thermal_of_zone_register_with_bin(),
   passing &priv->hw_bin_info only when a bin was actually read.

Two descriptors and their SoC wiring are provided:

 - tsens_hw_bin_desc_i_temp reads a single i-temp bit and reports it
   directly as the hw-bin value; used by data_x1e80100.

 - tsens_hw_bin_desc_qcm6490 reads the jtag-id and feat-id fuses and maps
   the known qcm6490/sc7280 ID pairs to a synthesized hw-bin value (0x1
   for the standard profile, 0x2 for the elevated profile); used by
   data_sc7280, which serves both the sc7280 and qcm6490 compatibles.

Register the qcm6490, sc7280 and x1e80100 compatibles in tsens_table.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v2.c |  16 ++++
 drivers/thermal/qcom/tsens.c    | 190 +++++++++++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.h    |  29 ++++++
 3 files changed, 232 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 2ee117aa91ba..8b2a00956a36 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -271,6 +271,22 @@ struct tsens_plat_data data_tsens_v2 = {
 	.fields	= tsens_v2_regfields,
 };
 
+/* x1e80100: tsens-v2 with i-temp hardware-bin trip filtering */
+const struct tsens_plat_data data_x1e80100 = {
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.fields		= tsens_v2_regfields,
+	.hw_bin_desc	= &tsens_hw_bin_desc_i_temp,
+};
+
+/* sc7280/qcm6490: tsens-v2 with jtag-id/feat-id hardware-bin trip filtering */
+const struct tsens_plat_data data_sc7280 = {
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.fields		= tsens_v2_regfields,
+	.hw_bin_desc	= &tsens_hw_bin_desc_qcm6490,
+};
+
 struct tsens_plat_data data_ipq8074 = {
 	.ops		= &ops_generic_v2,
 	.feat		= &ipq8074_feat,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b5ec70201e2f..9ba6b3c4c133 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -71,6 +71,167 @@ char *qfprom_read(struct device *dev, const char *cname)
 	return ret;
 }
 
+/*
+ * Hardware-bin fuse support
+ *
+ * Each SoC that needs trip-point filtering based on fuse values provides a
+ * struct tsens_hw_bin_desc in its tsens_plat_data.  The descriptor names the
+ * nvmem cells to read and supplies a compute_hw_version() callback that
+ * converts the raw fuse values into the hw-version bitfields consumed by the
+ * thermal OF parser.
+ */
+
+static int tsens_compute_hw_version_qcm6490(struct device *dev,
+					    const u32 *fuse, unsigned int nfuse,
+					    u32 *hw, unsigned int *count)
+{
+	u32 tsens_jtag;
+	u8 tsens_feat_id;
+	bool elevate_trip;
+
+	/* Hardware-bin values for thermal-hw-bin matching in DT. */
+	const u32 hw_bin_std = 0x1;
+	const u32 hw_bin_elevated = 0x2;
+
+	/* Higher thermal profile identification for qcm6490/sc7280 bins. */
+	const u32 tsens_chip_id0 = 0x197;
+	const u32 tsens_chip_id1 = 0x198;
+	const u32 tsens_chip_id2 = 0x20e;
+	const u32 tsens_chip_id3 = 0x20f;
+	const u8 tsens_feat_id2 = 0x2;
+	const u8 tsens_feat_id3 = 0x3;
+	const u8 tsens_feat_id4 = 0x4;
+
+	if (nfuse < 2)
+		return -EINVAL;
+
+	tsens_jtag = fuse[0] & GENMASK(19, 0);
+	tsens_feat_id = fuse[1] & GENMASK(7, 0);
+
+	elevate_trip =
+		(tsens_jtag == tsens_chip_id0 && tsens_feat_id == tsens_feat_id3) ||
+		(tsens_jtag == tsens_chip_id1 && tsens_feat_id == tsens_feat_id4) ||
+		(tsens_jtag == tsens_chip_id2 && tsens_feat_id == tsens_feat_id3) ||
+		(tsens_jtag == tsens_chip_id3 && tsens_feat_id == tsens_feat_id2);
+
+	hw[0] = elevate_trip ? hw_bin_elevated : hw_bin_std;
+	*count = 1;
+
+	dev_dbg(dev,
+		"qcm6490 hw-bin from jtag-id=0x%x feat-id=0x%x => 0x%x\n",
+		tsens_jtag, tsens_feat_id, hw[0]);
+
+	return 0;
+}
+
+static int tsens_compute_hw_version_i_temp(struct device *dev,
+					   const u32 *fuse, unsigned int nfuse,
+					   u32 *hw, unsigned int *count)
+{
+	if (nfuse < 1)
+		return -EINVAL;
+
+	/* Single bit: set bit 1 for high-temp bin, bit 0 for standard bin */
+	hw[0]  = (fuse[0] & BIT(0)) ? 0x2u : 0x1u;
+	*count = 1;
+
+	dev_dbg(dev, "i-temp hw-bin from i-temp=0x%x => 0x%x\n",
+		fuse[0], hw[0]);
+
+	return 0;
+}
+
+static const char * const tsens_cells_qcm6490[] = { "jtag-id", "feat-id" };
+static const char * const tsens_cells_i_temp[]  = { "i-temp" };
+
+const struct tsens_hw_bin_desc tsens_hw_bin_desc_qcm6490 = {
+	.cell_names         = tsens_cells_qcm6490,
+	.ncells             = ARRAY_SIZE(tsens_cells_qcm6490),
+	.compute_hw_version = tsens_compute_hw_version_qcm6490,
+};
+
+const struct tsens_hw_bin_desc tsens_hw_bin_desc_i_temp = {
+	.cell_names         = tsens_cells_i_temp,
+	.ncells             = ARRAY_SIZE(tsens_cells_i_temp),
+	.compute_hw_version = tsens_compute_hw_version_i_temp,
+};
+
+/**
+ * tsens_populate_hw_bin_info - read fuse cells and populate priv->hw_bin_info
+ * @priv: tsens private data
+ * @data: platform data containing the optional hw_bin_desc pointer
+ *
+ * If data->hw_bin_desc is NULL, this is a no-op and returns 0.  Otherwise,
+ * reads the nvmem cells named in hw_bin_desc->cell_names, calls the
+ * compute_hw_version() callback, and stores the result in priv->hw_bin_info
+ * for later use by tsens_register().
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int tsens_populate_hw_bin_info(struct tsens_priv *priv,
+				      const struct tsens_plat_data *data)
+{
+	const struct tsens_hw_bin_desc *desc;
+	u32 fuse_vals[TSENS_HW_BIN_MAX_CELLS];
+	u32 hw_versions[THERMAL_HW_BIN_MAX_LEVELS] = { 0 };
+	unsigned int hw_count = 0;
+	int i, ret;
+
+	if (!data->hw_bin_desc)
+		return 0;
+
+	desc = data->hw_bin_desc;
+
+	if (!desc->ncells || desc->ncells > TSENS_HW_BIN_MAX_CELLS) {
+		dev_err(priv->dev, "hw_bin_desc ncells %u out of range\n",
+			desc->ncells);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < (int)desc->ncells; i++) {
+		ret = nvmem_cell_read_variable_le_u32(priv->dev,
+						      desc->cell_names[i],
+						      &fuse_vals[i]);
+		if (ret < 0) {
+			dev_err(priv->dev,
+				"failed to read nvmem cell '%s': %d\n",
+				desc->cell_names[i], ret);
+			return ret;
+		}
+	}
+
+	ret = desc->compute_hw_version(priv->dev, fuse_vals, desc->ncells,
+				       hw_versions, &hw_count);
+	if (ret) {
+		dev_err(priv->dev, "compute_hw_version failed: %d\n", ret);
+		return ret;
+	}
+
+	if (!hw_count || hw_count > THERMAL_HW_BIN_MAX_LEVELS) {
+		dev_err(priv->dev,
+			"compute_hw_version returned invalid hw_count %u\n",
+			hw_count);
+		return -EINVAL;
+	}
+
+	/*
+	 * Store a copy of the hw-version array in priv->hw_bin_info so
+	 * tsens_register() can pass it to the thermal OF parser while trips are
+	 * parsed.
+	 *
+	 * Use devm_kmemdup so the copy is freed when the device is unbound.
+	 */
+	priv->hw_bin_info.supported_hw_bin = devm_kmemdup(priv->dev, hw_versions,
+							  hw_count * sizeof(u32),
+							  GFP_KERNEL);
+	if (!priv->hw_bin_info.supported_hw_bin)
+		return -ENOMEM;
+
+	priv->hw_bin_info.supported_hw_bin_count = hw_count;
+
+	return 0;
+}
+
 int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2, bool backup)
 {
 	u32 mode;
@@ -1206,6 +1367,12 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,qcm6490-tsens",
+		.data = &data_sc7280,
+	}, {
+		.compatible = "qcom,sc7280-tsens",
+		.data = &data_sc7280,
 	}, {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
@@ -1218,6 +1385,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,sa8255p-tsens",
 		.data = &data_automotive_v2,
+	}, {
+		.compatible = "qcom,x1e80100-tsens",
+		.data = &data_x1e80100,
 	},
 	{}
 };
@@ -1327,12 +1497,18 @@ static int tsens_register(struct tsens_priv *priv)
 {
 	int i, ret;
 	struct thermal_zone_device *tzd;
+	const struct thermal_hw_bin_info *bin_info;
+
+	bin_info = priv->hw_bin_info.supported_hw_bin_count ?
+		   &priv->hw_bin_info : NULL;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
-		tzd = devm_thermal_of_zone_register(priv->dev, priv->sensor[i].hw_id,
-						    &priv->sensor[i],
-						    &tsens_of_ops);
+		tzd = devm_thermal_of_zone_register_with_bin(priv->dev,
+							     priv->sensor[i].hw_id,
+							     &priv->sensor[i],
+							     &tsens_of_ops,
+							     bin_info);
 		if (IS_ERR(tzd))
 			continue;
 		priv->sensor[i].tzd = tzd;
@@ -1425,6 +1601,14 @@ static int tsens_probe(struct platform_device *pdev)
 	priv->feat = data->feat;
 	priv->fields = data->fields;
 
+	ret = tsens_populate_hw_bin_info(priv, data);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "thermal-bin failed to read FUSE data (%d): trips with temperature-bin will use first entry\n",
+			 ret);
+
 	platform_set_drvdata(pdev, priv);
 
 	device_init_wakeup(dev, !data->no_irq_wake);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e8376accdff3..1ebdc6935b79 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -40,6 +40,29 @@ enum tsens_ver {
 	VER_2_X_NO_RPM,
 };
 
+/**
+ * struct tsens_hw_bin_desc - per-SoC descriptor for hardware-bin fuse reading
+ * @cell_names: NULL-terminated array of nvmem cell names to read
+ * @ncells:     number of entries in @cell_names
+ * @compute_hw_version: callback that converts raw fuse values to hw-version
+ *                      bitfields for thermal OF trip filtering
+ *
+ * Embed a pointer to this struct in tsens_plat_data.hw_bin_desc to enable
+ * hardware-bin trip filtering for a given SoC.  Set to NULL to disable.
+ */
+struct tsens_hw_bin_desc {
+	const char * const	*cell_names;
+	unsigned int		 ncells;
+	int (*compute_hw_version)(struct device *dev,
+				  const u32 *fuse, unsigned int nfuse,
+				  u32 *hw, unsigned int *count);
+};
+
+#define TSENS_HW_BIN_MAX_CELLS	8
+
+extern const struct tsens_hw_bin_desc tsens_hw_bin_desc_qcm6490;
+extern const struct tsens_hw_bin_desc tsens_hw_bin_desc_i_temp;
+
 enum tsens_irq_type {
 	LOWER,
 	UPPER,
@@ -533,6 +556,7 @@ struct tsens_features {
  * @feat: features of the IP
  * @fields: bitfield locations
  * @no_irq_wake: if set, TSENS interrupts will not be configured as wakeup sources
+ * @hw_bin_desc: optional hardware-bin fuse descriptor for trip filtering
  */
 struct tsens_plat_data {
 	const u32		num_sensors;
@@ -541,6 +565,7 @@ struct tsens_plat_data {
 	struct tsens_features	*feat;
 	const struct reg_field		*fields;
 	bool		no_irq_wake;
+	const struct tsens_hw_bin_desc	*hw_bin_desc;
 };
 
 /**
@@ -568,6 +593,7 @@ struct tsens_context {
  * @feat: features of the IP
  * @fields: bitfield locations
  * @ops: pointer to list of callbacks supported by this device
+ * @hw_bin_info: hardware binning info read from SoC fuse (populated at probe)
  * @debug_root: pointer to debugfs dentry for all tsens
  * @debug: pointer to debugfs dentry for tsens controller
  * @uplow_irq: IRQ number for uplow (upper/lower) threshold interrupts
@@ -591,6 +617,8 @@ struct tsens_priv {
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 
+	struct thermal_hw_bin_info		 hw_bin_info;
+
 	struct dentry			*debug_root;
 	struct dentry			*debug;
 
@@ -677,6 +705,7 @@ extern const struct tsens_plat_data data_ipq5018;
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
 extern const struct tsens_plat_data data_ipq5332, data_ipq5424;
+extern const struct tsens_plat_data data_x1e80100, data_sc7280;
 
 /* TSENS automotive targets */
 extern struct tsens_plat_data data_automotive_v2;

-- 
2.34.1

