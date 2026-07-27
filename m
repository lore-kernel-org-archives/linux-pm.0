Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A903815FA
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162216; cv=none; b=nyssUUPsbux0ZWb/cCqsEaGqa75KxA+BQZxcddpvpj1yK6DQW0CBRpGOxDzKt3eoezDvf3uwrJlcrwMVcJhJ0vemoXXe6XsSUw6AGPOGKLO571nNPQihRLgqUYF8/NDT3fVGD0rYd21tGgKvHqwMlrf4DvURPbCCuBTsWfAwnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162216; c=relaxed/simple;
	bh=lY2yoHcldcA+3NaI8lXXUOj0RQzCzCCOyPwbI6I3/FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5/OWiTLbJR5HHGb+oLoeci2tOxqlK5NHFOVhWQl+1aVlDJpFFzaPtZ1URzF6AfiAGAoT5t4FB2wupsf8li30lUft+CooIYv5WO1rXsDjW5h4tsXjG8xmtks5ZNyHu4WRKJclez5t197Jx9vuEN4bsFLkvdEFJ67urOUumVkGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRKk0Ali; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K5LD5oJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRKk0Ali";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K5LD5oJV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlnUj856033
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LqMjPqmNKTABTQyu4/oXXNeGMN13hbmHy5tUZLQLrYc=; b=KRKk0Ali4VxzfNdy
	mSi9EKlqwIze2xfh71SEbCde5KOZvAdpu82P6btTVjzuEYhLcz7j6fVSZYlFQEw0
	T6D3p9BhkY3HrJo2aChnjXMOt/Q9pMUCdigMWc/P3tO65zXpV5s6EX/n18T/eDAU
	lMenKyJWZIv7CDuWKs9BcaSPRCWue47QybrYE34b/siNX9SHhLpf3yE3bMUokhvm
	8Azzko5St2gXl7mEIbU6aqcz4XcCq4ZNvol6C8rxnKYTDg11AiwvoHirk7h7K7z7
	XvnhzLWTSl1wPW22HzfADoyDSsfl1YDVcqNRUVXcgmcqtH+4viL2q0yXQdCQn7zq
	ydHi1w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wjc54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccbb61893fso60001165ad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162213; x=1785767013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqMjPqmNKTABTQyu4/oXXNeGMN13hbmHy5tUZLQLrYc=;
        b=K5LD5oJVQiec6nHlyaUCCrU9+yyqCtLVQbPHHFpKj+dn1eFxRsVrqFDDlWLXlsvQrg
         bqxiY/lWCoaXYP42So4sb3NuprcRb0mzJioLWxZL9kiszhgec3fiNc9T3bl006AZWsMF
         GnHtkEGzsTEsvBCj8uELpm4pFidulboBqCYmyWEW8iQ96JasyTi+t3DN7C56/eZ8EBpZ
         nHURhS5UgR77JMYC8YL7bf3JKf7TgYCc8Fe0GHuat3huvk3tos0v2VzpdGoz+PM6zRHi
         vIdXZgy6xnYkf9tBS3hT+cGA2jV3umTKyvlx70Mswoey14ppneQrgvyleIeusDrkZmrC
         bMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162213; x=1785767013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqMjPqmNKTABTQyu4/oXXNeGMN13hbmHy5tUZLQLrYc=;
        b=cY0yOrDvd5LODrxM7FzR5WXyXAHBRUxfoKfxfNHprF7HSNOj9n3OPuMxHEZxuiNsCP
         NZbfWCA4W7asyuZRwUtYMuYHcdt6Zs4DbpVCVEorkS4Sp2Nt1bdLGrURWA0doTitAvhM
         bFk6c1QmT5A6VGLQw2A0a5Lo2fJpfF075LXdOsV86MrALbD3qJ+qsqCcXRdxIcu7ARYL
         aoaivM7hv2S8loL8kFVAnxTBvMAEQf+V3tTDtf9Ii2FBDsux7J00C+NhmkEgsY29KSfi
         UAWMzj5RK9CEH/qDJnAia8FKSTP/MbhjIEgk8KuRW1u8Qm3FyZ9QHD04+fTZ5A68YCDV
         3cEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpv0MU8GA4j3qxEv/ykPzTC80z5HS2E5WlOoEX2wyl/tmOYmOATXFIUwzRvsr7Z491JR4Ln5pkmzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBg1C+ub6SPvJftHM6OKWwKmImbKbetvp9IryD5jiTddr52du
	eZhgWn2pZOFocam4+V+Kz9pf3+PF7Jn+SvaCUYhIlkDoYjPG7ZCLpCZMr9l5pr+R+XAobe4W9FV
	Ux/zPPEXB8PBNP7EFX4S/yMfRZub6KYVsbH3EXa3iUDXZ5VwiHgtatpir0wlR6A==
X-Gm-Gg: AR+sD1010GZAxUA7F1Hs7XijZaqAp6CzZ1BfNpsU7lFedo9i00DzZUgbV17G6mGLoZu
	wIFILcRG/vaMBtRT5F8528Wi2Oulzkq2ARdY/4MuxvaeBJbJe1rPFeI+s9dIyvG8bLZgq2CRi8R
	bG0sk03Dy0NHqiYSCyecoKTwAEbiIao65B5iLrXWJ6dAGo1cdCtUrGBxZPgD82wYdc+hc+uBib1
	j/b/lHxIq7jDSpziJiZxie9Z7YqNHgXZa51aAKHxopjylKNYyOiDFF1kZF3OgnIW9hlCiHZc2Lc
	e/5x0AHvEBJD1Qq2NC1szdlaOw3OqwZV9aX9ziEE2ZqHBAu61heZM2se1YwDyhIYUDyFR5YtdLG
	R7U4KkKKtFusMN+PXW/2ouVcrm1rodg==
X-Received: by 2002:a17:902:d48b:b0:2ca:d151:383a with SMTP id d9443c01a7336-2cfde7adcaemr86494055ad.20.1785162213475;
        Mon, 27 Jul 2026 07:23:33 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2ca:d151:383a with SMTP id d9443c01a7336-2cfde7adcaemr86493745ad.20.1785162212992;
        Mon, 27 Jul 2026 07:23:32 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:23:32 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:21 +0530
Subject: [PATCH v6 4/9] remoteproc: qcom_q6v5_pas: enable QMI TMD cooling
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-qmi-tmd-v6-4-973cd3a226af@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=3908;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=lY2yoHcldcA+3NaI8lXXUOj0RQzCzCCOyPwbI6I3/FA=;
 b=NeDCgOWKfvQfPbiBGlv8v4h+J0TA3CDp3WSY2FOn/Sipv4ba2znp8p0drrEA8UF7va2mTdFIb
 bjSzdydwb0jD6kju7rc+MVH+ZpDlJQDGgz6w4sxZHk1HEWIZpzwaPdW
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX6q7mQfktO1Wb
 Vc6ra3zzbjpsKULip9oUsJggGM16uEibL4w15OmBhZUKXigNM3vMq/QVPt23XJnWSeRx3S2b1U7
 a7wENf/ogkqQqmRhZabC7DWeB5+IMDgC3+zUpRYUq7uoQBIQPURbaeg6zv6rYi4OR0BIa/mlGKA
 R8AfLRc/qFkw/QPrTnZ1zk50pnCBJj9uE27w5zmIW8OA4lwio4dnkVeyYX4ZrZ+ceaJO475pRh6
 NjFaTlxsBh0tjnCHXsbjyEWwJi5oz5vpVKs6d4cLwMnou8z8QarQ5Qe8Z2EPUxluFEv+1xkOflD
 6Ays+x8/tKLyroXXd8jisvZZQia2zY+2BgN4HnWUkZk+x6bSE4lDKq3msxkPPylDrJhmghoVzXo
 QWBKX/TucgrpNV/W61vRqfQKiIB7yu8CoTS/mdsrp2XhjoyARKsYp+qkqKCwh4fjZVJq+AYdgfN
 PjQHm+yUotJGlVHVJqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX2aEJN+glufII
 c8ixKKi8zVPDdpItHKdj6PPuUG0xWeOEr2a+Q8Pi9pvAP977L8HYB3PhqpwTJWbw8cNf7XprOJi
 sVBMOOsIQdDfj6tzB2/keeoNvX3W6Vk=
X-Proofpoint-ORIG-GUID: 1KXsSgKXhPzIwBmYE5NLXNZWWRGbnoM3
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a6769e6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=j6jQExit_mXiN_RbaP8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 1KXsSgKXhPzIwBmYE5NLXNZWWRGbnoM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Enable Thermal Mitigation Device (TMD) support for PAS-managed CDSP and
modem remote processors on platforms that expose the QMI TMD service.

This adds per-platform TMD configuration in qcom_q6v5_pas for:
- Hamoa (X1E80100) CDSP
- Kodiak CDSP and modem
- Lemans (SA8775P) CDSP
- Talos CDSP
- Monaco CDSP

For each remoteproc, the configured TMD QMI instance ID is used to bind to
the TMD service running on that subsystem (e.g. CDSP: 0x43, modem: 0x0).
The driver then uses the corresponding TMD endpoint names ("cdsp_sw",
"pa", "modem") for cooling-device registration.

QMI TMD identifies mitigation endpoints by name, while DT thermal bindings
reference cooling devices by id. This change provides the mapping
between DT cooling indices and QMI TMD names, allowing remoteproc nodes
with #cooling-cells to act as cooling devices in the thermal framework.

With this in place, thermal policies can request mitigation from CDSP and
modem subsystems via QMI under thermal pressure.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 07336a2d75f7..ab23c371601f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1061,6 +1061,15 @@ static void qcom_pas_remove(struct platform_device *pdev)
 	device_init_wakeup(pas->dev, false);
 }
 
+static const struct tmd_name cdsp_tmd_name[] = {
+	{ .name = "cdsp_sw", .id = QCOM_TMD_CDSP_SW },
+};
+
+static const struct tmd_name modem_tmd_name[] = {
+	{ .name = "pa", .id = QCOM_TMD_PA },
+	{ .name = "modem", .id = QCOM_TMD_MODEM },
+};
+
 static const struct qcom_pas_data adsp_resource_init = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
@@ -1218,6 +1227,9 @@ static const struct qcom_pas_data sa8775p_cdsp0_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sa8775p_cdsp1_resource = {
@@ -1236,6 +1248,9 @@ static const struct qcom_pas_data sa8775p_cdsp1_resource = {
 	.ssr_name = "cdsp1",
 	.sysmon_name = "cdsp1",
 	.ssctl_id = 0x20,
+	.tmd_instance_id = 0x44,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sdm845_cdsp_resource_init = {
@@ -1263,6 +1278,9 @@ static const struct qcom_pas_data sm6350_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8150_cdsp_resource = {
@@ -1278,6 +1296,9 @@ static const struct qcom_pas_data sm8150_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8250_cdsp_resource = {
@@ -1362,6 +1383,9 @@ static const struct qcom_pas_data x1e80100_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8350_cdsp_resource = {
@@ -1430,6 +1454,9 @@ static const struct qcom_pas_data mpss_resource_init = {
 	.ssr_name = "mpss",
 	.sysmon_name = "modem",
 	.ssctl_id = 0x12,
+	.tmd_instance_id = 0x0,
+	.tmd_name = modem_tmd_name,
+	.num_tmd = ARRAY_SIZE(modem_tmd_name),
 };
 
 static const struct qcom_pas_data sc8180x_mpss_resource = {

-- 
2.34.1

