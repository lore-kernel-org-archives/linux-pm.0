Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04D3A5995
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079184; cv=none; b=A7dxdfe/EW9xLiBiQreMD5VbLjMh0CGAXWAz8H3INqafZU2I0hGYAoBS1/+AR/0MJbJ28Ufg7yXp/8TFgZoQ4GqdvpDjiNjoM295YBoAE2GlsDNzskicaH/J0CBzENc2IuKpeZxW6gqg4EpcPM0ThcSzLeSbXKar8CQYxx76uFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079184; c=relaxed/simple;
	bh=v5y2S4KEuK9ll8FKbt2wx7n2tKCwSSz3NBpnzhwlnk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuqwEBiSmqtGe0qZ5vbQqbFPNM347ROy9ZIhEjQpRw9Z7MzauCiByooLYxd674GJHpWTQE1CethDX8ael9g5carEbJAK38mVMg97LKIJ0VVrF5x5AYTJ2MC3yKfnG5kTc6TQ9rwreGo9Kmq7+hDxdt0/eFEzqOvXGykXxNDw0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XgO8IG/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bbAkNIiN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XgO8IG/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bbAkNIiN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7iKl3992605
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bmrPzwjDfZQ
	LqRIOrgrQTwpDk+/Ro0GV+O0RqY/iaOE=; b=XgO8IG/IfJI5VGjZtkEFnUEJqIv
	xIVrLsjMFpAZw3bd4WFNtb1R8d86+dxzPN6+0oFyJ2z2UZJ8ZAaTNsQAUpWQ4aKT
	ixaIpgQIf4ewB2X6Snpor73T+SAwjNK7RIGYxLrpjrLlM0a0NaYXPMtBoiuxAlyp
	ey2DW7aSCnVDerqeuMMnfvogsgLAFckXOQX3Fm1+vRMqF9WhMKbGbzIs0hqnnJpl
	fTJbcNktNlW5bOuZNZQSAav0tBws//JqHVXGmiz4CiL6I90dq3QU7xVdKkzYGrM9
	Cv62hrZ1+Bv+FvhcfS2krLx36Pw2qdGHeBy4h53L545djGX+zdJnC+f7Jow==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq1tg0k68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:13:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf1dece2ecso66716155ad.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781079180; x=1781683980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmrPzwjDfZQLqRIOrgrQTwpDk+/Ro0GV+O0RqY/iaOE=;
        b=bbAkNIiNawCJ3k0hyHLY6JcQtQ1/tQDvucrgFd6I2eVtEdiJaa6HchpN0IN9xqR+wP
         AAVBIgnWyRfwhlDhQOwH+/LPe2HHaJupRTed9AIIHNXrSqM2mF7zy1tFyxRFlK+x3sDr
         1xHYt2vv9AVYGcxofZQOd0txV1/9mWT9q6CAc+R1Y6Qb8jH9JtoFkId0pwhuJIc3YI0c
         mSQBgvBjZ3+GxIWhh/D2TkRvHqypEpVITWK7mERSm3gu69jtg5Hgj/xwo1TxQxyMvKUH
         Fii+vgUdFXCQYEAwvrYlT4dsEvrZJiWyN4DHKIGfR91uSGqaCgRSS0SqIrCHCiypuZh1
         vYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079180; x=1781683980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmrPzwjDfZQLqRIOrgrQTwpDk+/Ro0GV+O0RqY/iaOE=;
        b=SjCNjS3w/iXkjv41qghivDs++msadzgne0Auvaoi5qr5SP0/0O2PI5Vh5EQrvVhfpI
         78D4OgqskFUef3EK6F1hkfPd4FzyWW9ulFc952y4YnOPE4syvE90JmDx6XiZUANzrEzQ
         L2RYon+Fen5l17X0Q+WBrzktqqOzfflekC/LJOotVEZoPyrLLa21odoCq0qbbwlhgCkQ
         BiDl7E4c0/tBOLjrCWFiF4V++XuXwLW2CaVqFYGL2Cb5CCR/RTG0xYkUWxJOEP7bmHDJ
         7qMzj1qa8NcG82AGKY35ck18NClEhoztY88uBihxCD9tv4A2C9sYHLj/QiPj/o0Dlnh9
         2Piw==
X-Forwarded-Encrypted: i=1; AFNElJ+E1+/wJJll5xdyTdk0mRNKYRy+u9qGqMBpRdSUrWhW6RxKTjR7H9Zmy6pmxcB9cz+xDXwXJQhTfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09z7u/Qm5l5dF53yxqQ3S4yp3YChqifrksIy9F7rDoM1LWArJ
	eZtl2H71m2OLJunZFTGH89NxcW+mTusL4lVWSFo4vioRoMabdgB4uQ+6Tif+zF3s56onjPADCB8
	2Sk0nHKOOO2Uz8IRw2BDLuu7/tqTRvVExeKOSiYYQNPbqNzIZP0tzD2+/chbhLg==
X-Gm-Gg: Acq92OGbIopl62vbclLaFjPUJUlFZt409z8wd4gIhX65+X6Er6E5o6Rquqwnp0UZzdT
	PgBac07eXTUVeLF4Tz2KjjFkcQA0f6ee0XHyvm8OBufsVgq6CX5+BCI83qfqiLS5ZY+7evP5IZs
	IKaF8nUGya29L+YJiEboDA+wIVNWDdNpWoh74t1aSolaaGjHCMpm7WH8l90WcYqjaA2GLHeDyQw
	gUOpqLedt6/ZlMuwApnkn+fr7GmxoLDMchuyekbeetDk0lE3LfMCXQnTMcQ2xNMa6Terx3IsTmT
	lcwaqkuhlL3pslre8SameDvjus9GkzQLnLkEe5rrQk+qboKtab45TXX6RXmfJIXCClZ3BaJZJ98
	WqluYSzALrHAGKh52txAyZt9UVPTyUZLutjrQPd38/4LTF/pmluFTXV009eKYgp/CbqmuZJixvu
	XULtpeEMtgYtlGGYxd0ratY5pR+e1b87Bq17/gUSmZBw7YTTMN9NASJ2u6oATEiw==
X-Received: by 2002:a17:902:e5ca:b0:2c0:b932:867d with SMTP id d9443c01a7336-2c1e893d0b9mr270665345ad.29.1781079180106;
        Wed, 10 Jun 2026 01:13:00 -0700 (PDT)
X-Received: by 2002:a17:902:e5ca:b0:2c0:b932:867d with SMTP id d9443c01a7336-2c1e893d0b9mr270665045ad.29.1781079179556;
        Wed, 10 Jun 2026 01:12:59 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm228858575ad.21.2026.06.10.01.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:59 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 2/2] thermal/drivers/qcom/tsens: Add support for ipq9650 tsens
Date: Wed, 10 Jun 2026 13:42:41 +0530
Message-Id: <20260610081241.1468507-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MBKRW4B0-WJt3Xun4iChPrKWhYSR6_Qg
X-Authority-Analysis: v=2.4 cv=dLmWXuZb c=1 sm=1 tr=0 ts=6a291c8d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nMt2SIcdhh0IZDtwxJkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3NiBTYWx0ZWRfX2XXCJZwDVFCf
 iWb4b3o+R0ve5+r+p2YZmVXKYaHoV9OFZVwGv9hmXQkClv87GqNEh3IiehzUKdOasX+mUjkJdJv
 cYETPz/b9H3Xxn49ikTeIfnHBkS7IXj19hH+x20ZUWhz3H9LBG7sRQrnZgbnCpatNEyehwSfz2d
 22DPoS1ucl9rOJ8JRd4hqgkV9X84tH9fx5fjCTMMe0uhhhsasJFnKpw9QTq7YYrVC2UrGmgmCKG
 00OD1w1N4cwgbR5xpznABsYnSPafv4yANgSHSrUpTOmlQm3keI4QtKgCY7zM+GBdivgOzxxa6EI
 aNY0CqWQULkVFG27Dq4yyP5V2voQ2eqit0IvDJWY4uNlj6SeCZHYy2sWSfr2Ezk4OHQr1FkzWwd
 4HihW8/Dcmcx3Rpd2ETmTW8+deZG8xxfIAaXFqW1UsC0KMo2vqjvtcmKl6ZMnNQvBnYgR26XZ2m
 ubWzrwcZ/kEhe16e1DQ==
X-Proofpoint-ORIG-GUID: MBKRW4B0-WJt3Xun4iChPrKWhYSR6_Qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100076

ipq9650's tsens is similar to ipq5332 tsens but has different number of
sensors. Re-use the ipq5332 data for ipq9650 and modify the sensor related
information.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
 drivers/thermal/qcom/tsens.c    | 3 +++
 drivers/thermal/qcom/tsens.h    | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8d9698ea3ec4..ef1fee2266a3 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -300,6 +300,14 @@ const struct tsens_plat_data data_ipq5424 = {
 	.fields		= tsens_v2_regfields,
 };
 
+const struct tsens_plat_data data_ipq9650 = {
+	.num_sensors	= 11,
+	.ops		= &ops_ipq5332,
+	.hw_ids		= (unsigned int []){5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
+	.feat		= &ipq5332_feat,
+	.fields		= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..e7bc622891ca 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1122,6 +1122,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-tsens",
 		.data = &data_ipq8074,
+	}, {
+		.compatible = "qcom,ipq9650-tsens",
+		.data = &data_ipq9650,
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2a7afa4c899b..d9d50d32c962 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -657,6 +657,6 @@ extern const struct tsens_plat_data data_ipq5018;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
-extern const struct tsens_plat_data data_ipq5332, data_ipq5424;
+extern const struct tsens_plat_data data_ipq5332, data_ipq5424, data_ipq9650;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.34.1

