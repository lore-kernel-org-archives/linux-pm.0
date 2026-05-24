Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6C31DD97
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652236; cv=none; b=tR3geKsRAEM5S4ABurJU2MYmcQJUKBaUBUePHi1EGqgK2VLZtjCTJsPEidvjXQhRp/0v0IE5Di0Smgqmk3xuKr8snGRdM4NhQCyyiYYUW1rT7VwAvUwxNWNRCHa3/csi0+sSsehFteQRYqeVHltTM+oXC3xxE9fnHXNKqgBHJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652236; c=relaxed/simple;
	bh=HZ7/7IjeZoPhuLN/esuvDjyXVaXxhOuhe52lN9ZMwac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0NV8e9qGaI4TCMY7LxPldTKE+VKpNC8DQ6Zj9/jiBvNGmRHenmXYt7i+i19sUhn6OUQs5ra2xQf9e0/KjMMYCys2eAwD6TXhgKY0wi5YVhPQhJNxOuXf37cB+hrsoQ3xS3MlKy+7k+7FcvGuh0h4O0zmcnsgIIMTxmxVSFLdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGsLT25h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brtmXI/M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGsLT25h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brtmXI/M"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O2HQcD3866523
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QjPFT0emV6C2WElXznwvtli7ABAsS8Isx5jqdt400LQ=; b=VGsLT25hOjHPVj+q
	99Ha/BwlM3UQP5OnOnUuBTkh6fYdcG7eeTN/peYQdg61tWLzHwmrjLhLOanIz7OY
	9/mdNZmYRy5ifXtJfV521+oo6794cdn6M/3EAOeqxidVDovpSNsXD62o+L9V0cT1
	8b7Pxfa19qB77fpZcD+G+ZSzSvQ+6j9XGhJrVUOLl+Kuw9ZT+4ZoFMh/6WggzQEt
	ewhJfdOtJT8N5UDfLWnKXhMcJoQTVrZatYzudB5UB6rYLWPWXatNo1mNTX1JMyGu
	Zoo6qIsvhk+Sz5Tn6lzG5GJbhd0qK0Q9M9IFid5FCKymHZRZaMseZySplCOtF+2r
	xWiEWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7kuuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-367f715cbd0so8790191a91.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652233; x=1780257033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjPFT0emV6C2WElXznwvtli7ABAsS8Isx5jqdt400LQ=;
        b=brtmXI/Mv3egUhAXroXJ2TxGnttUkuZ6h3dViXCp4GUMw5ojhbyclbmVJaspJusPmo
         Qs4c+Rea6xp4Ev0rHJi3gzJmKF9S2s/UIMXHSBVQB7iXdJ3X8aCDdwrlh5jqLwZXlwdb
         EkYQEVPZ7YXikafCgvzDr3yPoR3ahO7a6PvEcl+wg1BK+FEjLL0NvHtGsQvMjunuWQvT
         32SXuSJ3zrBOaJq0Ks0PaX/muMSBwqbDFFwp7xsQr3xOVItj/jLZu9UH83Vm/4bLHWb5
         VK7NEtFDcRQQHZWsQKvQbPIblknic/sFJVPBKU3nyGk+77dJpZuuIU8FCe0w/3avbuMK
         o/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652233; x=1780257033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjPFT0emV6C2WElXznwvtli7ABAsS8Isx5jqdt400LQ=;
        b=L5PZmcAX55aw1+owu8Au3qINyZvnnVo8frc5A9WjPhLjeSWU9GUOS0CuN31cSIMUSL
         igecU37Laz8WxIYP1cvJUKtsVxKAUeWKnnA8gtyUl1EGu7LRWNms2ZDRGh8FjkPDiWQf
         orZv9H+b5zFbGxBP+/3ZeuNMFGy3JOmw54oBKDzkE4olMyWlSYKwQ67izsgakIrdGi+V
         dkc/p92znPGr1Hx+B0QfIHYbsoXvdSx1bD7SuWO2g4akd6lEDWEnL9v9q53mpNLxeN+P
         9oa2BlmWAfkRyGt4ojbh1S49dso5PRchHH1zR9L28N9FOVAdBIr3uQrcgiqyMisPdWq3
         qDxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HrUhNva/COwd29jLkRp7SEFcHcfnd2hFN4fzavtI9/+xLmyMce9b9DNRTpIhadfXkJQKVx/ZpxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3+Pg2QAnrCspTV7EyZOy5H8gyBs5527HkX2itP+T0J4Yd7ci
	cHuN1tYrRVtffeiRFAiSUSlqjvEdNl4k3tSN3UtLXbA43s6Y8PzVHHm6wCs82NU64SfRAQ9YTkg
	x6oHCPcP6AYZY868uuShe1nWNSCSZhKePeVWpR3rvR4qMcNuEXgZo96XEZK1OPQ==
X-Gm-Gg: Acq92OGGQH6pIIQ06b6BQE7W++wPl6CXOALYmdeyxO2SqvQCVsrL65OLYRdiQhpMBNG
	dbxlWU43D1Cnv9cx9i6KPiXUqRd+8y62LipodgZTuRgd3efFncNT49qkNrs6cNP+h1cERTHbVuL
	i4LyemXhl3d0FA+IAn1ilyLGoQooyzDaMD8iDg49B1hsTJph5asfwz3ck1/89UVC+Zx43zawGA8
	sxVytkDUV742+o4C/dMgjnqKjY/Y5pljFsQYK+SaSn+ZbbreB3c7sKFRZQZJU8kb3VCmSAmQxqB
	C0MUWZQmQwgn2vBhioxVujy60duMpg5FpKkWnMlV+ig2dl8PhPsh8HA3Gti5p0YE3UdulnyE4J6
	lDbdXtnqvNIDv34eDFQLt3VahB3DuKzEBgs28
X-Received: by 2002:a17:90b:2b4e:b0:35e:d015:d675 with SMTP id 98e67ed59e1d1-36a67719220mr12526936a91.7.1779652232908;
        Sun, 24 May 2026 12:50:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4e:b0:35e:d015:d675 with SMTP id 98e67ed59e1d1-36a67719220mr12526916a91.7.1779652232445;
        Sun, 24 May 2026 12:50:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:16 +0530
Subject: [PATCH 12/16] arm64: dts: qcom: shikra-iqs: Enable CDSP, LPAICP
 and MPSS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-12-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1018;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3Lftxp5wY6kDco3NZNja7NALjN725ANWhNeWOYYhkAM=;
 b=VrlMrPDl3C+ezrF9VyKFMopuk63KiuZBmykDz1gHiy8/Xii3Syr0n/6ETHr3lm44J6ffV2Mk2
 Vpstd7HuwODCUZdQlaTB1cwRi31DZ6GYbrvzsJUoaEw/5kjiysAkIkL
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: OOD1Er-_eJC_D87Co3IufLtnIDyEGCY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXx9d+eyf3pWuv
 Sr6cXQKM8Qm+U3sHCapincMODqjZeB73lZEnWDIEgw2dnVsYld0+8YkmsZKo4s5bFuYTjl2+REd
 eA2bXoKT3NQAyuKE3iE8ZzDQt878fsZ8FkObT7HI7ckAPQNP6mgNIcdga9u5V/QyL3BUdX4MDPl
 vyic7AVXckGv6v00bTTOOhsE/4VyXvB8bxn+D6026FXkAhscwxwqEcZmUpVGIl+BSz9ywTdA4Hs
 7wP4xC5DJlBktnLhot/qru2xFx4Qbwq6grtZIQefy1fiwpze2o1iNU+mo74TM2KdJeaP9NKL2F3
 QAagdUlBCCMKuYk/xZyB8eBbKz6yfaPr75LhnTq7ORtRVFvGa9LgCPEg6Lw7o7puwGvZOZZEV3l
 58AZjFqeMSu+ca2ny+4Fg7EJuEis6t1XIXB/YMleOFZLjJ7U//cuUo2HkxbxGmX1icgdwSl3aa9
 MkJKyj9BVBYURZ3FlBQ==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a13568a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=O3QOSsIWTsd9q-9u8mAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: OOD1Er-_eJC_D87Co3IufLtnIDyEGCY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..727809430fd1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.34.1

