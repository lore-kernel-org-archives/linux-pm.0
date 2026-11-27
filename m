Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779761;
	b=37/9N16N2aRkWzbhNawI6zDT70gnlAivBmCEHwyxZ1Di2s/WSE7Mnb1D5RObmX6ahEKy
	 qC4Xcwf48mKLVUIAIQ8orA42eJDtlVab8sS0zVkFShvJzKfkDmOpGBNZG2yFsTMUFosQK
	 JGRrhLkBSbnnQm0rwiBoP3t2tjzpWPdexxLuLOTHgM61RhHwUjvJN1r136azFHGwTlmLr
	 7D3eu0lun3WsAM+WPlbKMDYU6T8Dmct8o/4Lfn9cCn7goY0j5zl2zKD5z+NIQ7kgpxpBH
	 azPluHcSmec8NC6bRzBbzDBxrWAQsKCeBayaTPF15DDfSzRMi/+Sg45BtwRcIdsXlwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779761;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=l2zHjtdkc4bPdfmyWQiRRfRG0SvicK7zwbULG7MLnG4=;
	b=Sm0J7gpphQ+aNQGn0/CrsRw+tw2zQuAD39Mg3yx+699UHq/a9yfb/hiDRdry/eZOurhX
	 4meC5mp3fgjEt6acrFi1lqft6DP3r87iQfViQCxj0dCXYbi2Jgt3dGo4ynYGcZuPS/G2D
	 P+2tEHBL5YNVgTrXJskCQvPmQYGmK/G8fiAGMLfHnBfNzBrrB10b4FncGzmYg1G6LqjAC
	 fYajELDCBoVOzT837wFp/YBOXt6R2Sh9hqHcmiILVdRP+LQFbmVL+Xpohd+Us9ImXvf/v
	 knfZa9tTb5odMD2h8KIsDzOPh5SDJi6uowGz+tOWcqUA7+JhaF2iQ0SfjiLHeOtJj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cL2dvodg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="V/mQ+VV6";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B70606A336
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B70606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cL2dvodg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V/mQ+VV6
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp2jA1047057
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l2zHjtdkc4bPdfmyWQiRRfRG0SvicK7zwbULG7MLnG4=; b=cL2dvodghi4ryDGY
	IliP+jkQHTi5nZnmTRdoUTE2HuNJSaM21GUZ4AU+LQcOxu48oRHvz2KWMJvB2TUf
	Sj6Vpvtk6cf6ggT+Tx6EPjzCpEPsYCtTQxv9sdtoptYH8Oid+GNvajqwSkRBY95D
	tzr3iTy3QCLlpotPJ2biGrAezTHbp5Dc1Cfroz+FLaUFmyIOqY9Cp0gFYDJxmXWP
	irh4s4y1SkX4dc2rsf/jInfKKG8BJzysk4h97UkNq4b4hvwW7mV+FqjQRplxF6rC
	jUYmFvbvu0dwbRynN7WaErbpnIl4HUiAhMaQj8N2wCmi8njbCTklCTX9bWEnpzTT
	8BB15g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqkscn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94960131b4eso538915585a.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779758; x=1796384558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2zHjtdkc4bPdfmyWQiRRfRG0SvicK7zwbULG7MLnG4=;
        b=V/mQ+VV6MHMYzSvTvVyLJUA3kAiOYEMUHhKdyMJQzTWYgaM90pinEZXFiKXIPWA7F+
         LP+qjj81tAa2Aw9sVv1rUpKhnriHo9xuoBf5+81AbJE2e6ZamX7Vejysq0Khp2Z0Zhv8
         J2yRkcckTLV1gOJe1FLIPs93gvG7Wq6rYU38DzVZj+coOn/0Dze7N3GCwf6CGasHKkG8
         4AamiNZiFC+SCFPa77Ro83P8ijJVziYloe4jedRfBfGeDSkBf9Blb4jXx5pH9FHs7y+6
         /fEj47NlSMHLQgv9564NgFSaveW9gMHmacuz5/qXOqQvMiBryvoDGS5Auj+OnU3jxEZ1
         Lt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779758; x=1796384558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l2zHjtdkc4bPdfmyWQiRRfRG0SvicK7zwbULG7MLnG4=;
        b=RjZxgrbHGECZ6YOucoqLrV3eG0qNunkB76nmTAiDMpf2tJkpsswIZu5ENwLp1cibOD
         k/zLdQB7DopVrFGV6LrnN7WByeRQ2coixzl6vLTrNNcFqLGrn6+tX7TacqkklKchud01
         ONuKyV5RBprmUOYcGNtqHmo6RuZvyheMcRC8HKDgfWCsZwSpIzfrjx8ULIGVFyc30LJP
         vOopTfyAPVC9uTGIvV3J3nErxeqASJrIvrdCEquXEfxufFGbw2X0HArf/ZqWdCu4srm9
         sGe7QWWSZ6c8o+k0TJ0cdgUE4SHkS2AxZXu4ZqTl4KPLGsDJFaquPa3m7p65fbo5+8gu
         dRFg==
X-Forwarded-Encrypted: i=1; AL+hErFLJrJDguZWQAI1aUK2LFTi3dn9M582O1geWcBfSAJCFvoG1WM1ePklvVoW/sY1BLsllX6l9Gc/yg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/4OGFYJqWDaixEclom5EvPNYF8OFNTnVw6KeMBKpXIRC8+ps3G
	DCaGfzxEvxQZ6P3Z16dj/+hN4UDhHUY7c/ZULfClmJlJIsLD9JOiZJ5OSN+rF8Cj5VGOzqq74nJ
	SGvo5YoVwrm1CkL++S5mOj1kvDv2oJZy/Pl7gU0lH6MQgPZd8t/Af1YOSZvfWug==
X-Gm-Gg: AZFdTZdFJOx2ZDJ5V8kxeAyKpTCfEZuoR/KR5cst2Yktmq92Ee/oDgtR49XS8vsXm5J
	L9URUBfvkomZEnyhXobPJ5hK43Duxsq1L71Ci/kiTzD7LlItMkwdbjMPjKtuf4P71MHco6lnWLy
	VcDPTbkOG63H2Pwt+WTYx1rR9kG3ZnWFFRkd2DxenoOtIWgjgPaCXoUQpV5qoKOPFoQ0oHZccLG
	wD7HaRggBgwj36lmR/qKYjxTiFGXog4PEVZEtjS5GxWdzrlciDVVeMfcSzz1WQv88D+eLRqrIKX
	sB9i6gvcVo3kprKByC8FRLcwZwtDUKj5Xsl4We4Cnq9wD7a0sjmYQv46+rNy0mVMxL1BNbnBCZJ
	3HWkBw5//nSKCjLosKc2SKv5vOf/EwmZsGO3HJ3pWa6axSxXRlmMOH7Vi+lVANWKo7Klyzt/aGz
	nFIa1CfsU/GL93IEHJLd5M+zcHiH7LfilXNDVDaCFBsAzoTsSG1BmubKBLtyJSWKc=
X-Received: by 2002:a05:620a:4106:b0:949:61c5:73a5 with SMTP id af79cd13be357-949bab4dedemr4396715585a.59.1795779757743;
        Fri, 27 Nov 2026 03:42:37 -0800 (PST)
X-Received: by 2002:a05:620a:4106:b0:949:61c5:73a5 with SMTP id af79cd13be357-949bab4dedemr4396707285a.59.1795779756959;
        Fri, 27 Nov 2026 03:42:36 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm56457254f8f.21.2026.11.27.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:42:36 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:42:30 +0100
Subject: [PATCH 2/2] interconnect: qcom: add the Seca interconnect provider
 driver
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
Message-Id: <20261127-seca-interconnects-v1-2-a31bf9b36ac4@oss.qualcomm.com>
References: <20261127-seca-interconnects-v1-0-a31bf9b36ac4@oss.qualcomm.com>
In-Reply-To: <20261127-seca-interconnects-v1-0-a31bf9b36ac4@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=59862;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Du6CH9wUlZr6mz1uI+g12OMZU5/LXcMv99QYkf+o2mc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrCWynSFf9ycR+AhzrHeXIBWAs8VRbHe1EWChoS
 k8zA3kBxpuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawlspwAKCRAFnS7L/zaE
 wxw+EACCYXTPHNjwEViYnfHjSXsrdXtWgPaV8PB1QfV+1gNIiCeznOAWrpRUTp+RvWUmxSBHD16
 9nm9FidJVzEl4rPnQELBL/LNtkvvN7G0dL+YI/XT7zp6DcBfozanM7hUlFqRAedA0OE27pW+5I4
 cY7fuHJlzak/n9LfBIAenQn6aTgG/F4CilMflAceE/2gwq+peIt09eH2m4E2J8MkIdLfW+JyZiR
 hM9nqUaI6BaXm+rrTHthi+iNTPr1mC9sbog8kZr9c+yLGx/207BNcgAbVhcjlUItj+PZT0aVPkJ
 N6QmSWzu+pSVTHQzDMEW9l2C8cXp9HT7NrZmJHykivA053Y2aCuiVwJ9/uEYdpD4ezGAaYaovX5
 8CyrraUwKIA5xeKaxKT9XAJQvLxxHrGGImyKXetjSxZu+/wsermiK+qivQG530cnIhC5EEqUeTk
 dEelPu+C70EPK1fIduKqFK5xvU+Mr7c/VoVt2HQVVQprQ3kfIEbH+AI9r2nd1jnjXYJApmHpDvl
 7pypdvp06X4JpzGX15wtBmrcQeaoafvkoXPSQxTzcfMTpzG66HTde9lcD3HMgvAFNMxt8zPwifG
 tZsW8p9C9FWAUGWI38j8kOYjpYrTKFcGHWRggitUl2mdCtmodS9iXftwnhwFHru8mBoNCShmO9k
 4N/DXdAH65Wg62w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: KCo3iYqak4vYMMFYJWhBGCOmK7oWc4aH
X-Proofpoint-ORIG-GUID: KCo3iYqak4vYMMFYJWhBGCOmK7oWc4aH
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b096caf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=4V28zKMCJPVY47lCisUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXxm49hWFM8XJt
 E/zmJpDlja6gd/RLXD4/31PreE0iS/Pux2FPDuJ4MgzTh7oBX7xFFl9ci3Z5/mloKxVEjeIsAQv
 EAPfllbvTdbjceYQK9XUJ6Kj0cktkRQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXyQ2TIfKJaenG
 V7L1Quq35c2+w7pNu1SBW9CwK/z+wWDhs8kSLK+CCasv4NMcCYpa3QkhQiaBGBThuUsso0X4dCC
 dxJXPiMDNGnuISgqC/Kyrm1Ff9vEWaGoYc/YNJdtJBiF7RiQ0tc0cxvVf51uglHNaIurAVplpZR
 /reypgR9u0+qyvnG/4+6MlEl/TIMtHhFP8riUTvobTkTF+QTGGKdJ2yF5bB/0ETQOcLLQEl/rW6
 A4a9A7Z19J3PoE7uD5vnKDNykTqJQroz1oQEnVK7oKkH0sewSGbTjgjzTNsZEwv7IaaJKp+hYqW
 4DiF/Xh9TujxB+2MHstmn81wjHjfmM5gTnYCouBB4PlIzrUK81usQMY30x1q5xHuF2c/OF1DWkf
 UdwQBxTz2IXaKcq1EbttrNsPPta1g9jRriRZyXVtIR8UI60PrsfcQBezmtLmLgDsQPwN3t5RU9M
 Ojr2tAEGaFUerJAczpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Add driver for the Qualcomm Interconnect buses on the Seca SoC.

Co-developed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig  |   11 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/seca.c   | 2335 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2348 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 6a3fff343488739a7aa5552f31693f8ed3ef3924..582097c11de81a33e0839437b2fc9c4ed666138f 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -394,6 +394,17 @@ config INTERCONNECT_QCOM_SDX75
 	  This is a driver for the Qualcomm Network-on-Chip on sdx75-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SECA
+	tristate "Qualcomm Seca interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on Seca-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SHIKRA
 	tristate "Qualcomm SHIKRA interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 7fdb3967d391ca0c4c4ae2cdd950adfcc2208cf0..7f717299ef2a966318cf54acdd9a4e0d3524e104 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -40,6 +40,7 @@ qnoc-sdm845-objs			:= sdm845.o
 qnoc-sdx55-objs				:= sdx55.o
 qnoc-sdx65-objs				:= sdx65.o
 qnoc-sdx75-objs				:= sdx75.o
+qnoc-seca-objs				:= seca.o
 qnoc-shikra-objs			:= shikra.o
 qnoc-sm6115-objs			:= sm6115.o
 qnoc-sm6350-objs			:= sm6350.o
@@ -92,6 +93,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) += qnoc-sdx65.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX75) += qnoc-sdx75.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SECA) += qnoc-seca.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SHIKRA) += qnoc-shikra.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6115) += qnoc-sm6115.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) += qnoc-sm6350.o
diff --git a/drivers/interconnect/qcom/seca.c b/drivers/interconnect/qcom/seca.c
new file mode 100644
index 0000000000000000000000000000000000000000..7795fbf61a4c2ea23408fd4345976cef2ddf98b2
--- /dev/null
+++ b/drivers/interconnect/qcom/seca.c
@@ -0,0 +1,2335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,seca-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_hbcu = {
+	.name = "qhs_hbcu",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_soccp = {
+	.name = "qhs_soccp",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qxs_pcie_dma_0 = {
+	.name = "qxs_pcie_dma_0",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qnm_cnoc_pcie_dma = {
+	.name = "qnm_cnoc_pcie_dma",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qxs_pcie_dma_0 },
+};
+
+static struct qcom_icc_node qns_pcie_dma = {
+	.name = "qns_pcie_dma",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_cnoc_pcie_dma },
+};
+
+static struct qcom_icc_node ps_eth_0 = {
+	.name = "ps_eth_0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ps_eth_1 = {
+	.name = "ps_eth_1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ps_shs_server = {
+	.name = "ps_shs_server",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy3 = {
+	.name = "qhs_ahb2phy3",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy_eth_0 = {
+	.name = "qhs_ahb2phy_eth_0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy_eth_1 = {
+	.name = "qhs_ahb2phy_eth_1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto1_cfg = {
+	.name = "qhs_crypto1_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto2_cfg = {
+	.name = "qhs_crypto2_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_1_cfg = {
+	.name = "qhs_display_1_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dprx0 = {
+	.name = "qhs_dprx0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_eva_cfg = {
+	.name = "qhs_eva_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_0_cfg = {
+	.name = "qhs_gpuss_0_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_i2c = {
+	.name = "qhs_i2c",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mcw_pcie = {
+	.name = "qhs_mcw_pcie",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mm_rscc = {
+	.name = "qhs_mm_rscc",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ne_clk_ctl = {
+	.name = "qhs_ne_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_nspss0_cfg = {
+	.name = "qhs_nspss0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_nspss1_cfg = {
+	.name = "qhs_nspss1_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_nw_clk_ctl = {
+	.name = "qhs_nw_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup3 = {
+	.name = "qhs_qup3",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_safedma_cfg = {
+	.name = "qhs_safedma_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_se_clk_ctl = {
+	.name = "qhs_se_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tsc_cfg = {
+	.name = "qhs_tsc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.channels = 2,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb2 = {
+	.name = "qhs_usb2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_1 = {
+	.name = "qhs_usb3_1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qss_computenoc_cfg = {
+	.name = "qss_computenoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_ahb2phy_cfg = {
+	.name = "qhs_pcie_ahb2phy_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_cfg_0 = {
+	.name = "qhs_pcie_cfg_0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_cfg_1 = {
+	.name = "qhs_pcie_cfg_1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_cfg_2 = {
+	.name = "qhs_pcie_cfg_2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_cfg_3 = {
+	.name = "qhs_pcie_cfg_3",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_dma_0_cfg = {
+	.name = "qhs_pcie_dma_0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qsm_pcie_noc_cfg = {
+	.name = "qsm_pcie_noc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 6,
+	.link_nodes = { &qhs_pcie_ahb2phy_cfg, &qhs_pcie_cfg_0,
+			&qhs_pcie_cfg_1, &qhs_pcie_cfg_2,
+			&qhs_pcie_cfg_3, &qhs_pcie_dma_0_cfg },
+};
+
+static struct qcom_icc_node qss_pcie_noc_cfg = {
+	.name = "qss_pcie_noc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qsm_pcie_noc_cfg },
+};
+
+static struct qcom_icc_node qss_qtc_cfg = {
+	.name = "qss_qtc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu0_cfg = {
+	.name = "xs_sys_tcu0_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_sys_tcu1_cfg = {
+	.name = "xs_sys_tcu1_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_sys_tcu2_cfg = {
+	.name = "xs_sys_tcu2_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 51,
+	.link_nodes = { &ps_eth_0, &ps_eth_1,
+			&ps_shs_server, &qhs_ahb2phy0,
+			&qhs_ahb2phy1, &qhs_ahb2phy3,
+			&qhs_ahb2phy_eth_0, &qhs_ahb2phy_eth_1,
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_crypto0_cfg, &qhs_crypto1_cfg,
+			&qhs_crypto2_cfg, &qhs_display_1_cfg,
+			&qhs_display_cfg, &qhs_dprx0,
+			&qhs_eva_cfg, &qhs_gpuss_0_cfg,
+			&qhs_i2c, &qhs_imem_cfg,
+			&qhs_mcw_pcie, &qhs_mm_rscc,
+			&qhs_ne_clk_ctl, &qhs_nspss0_cfg,
+			&qhs_nspss1_cfg, &qhs_nw_clk_ctl,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup3, &qhs_qup1,
+			&qhs_qup2, &qhs_safedma_cfg,
+			&qhs_sdc4, &qhs_se_clk_ctl,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tsc_cfg, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3_0,
+			&qhs_usb3_1, &qhs_venus_cfg,
+			&qss_computenoc_cfg, &qss_pcie_noc_cfg,
+			&qss_qtc_cfg, &xs_qdss_stm,
+			&xs_sys_tcu0_cfg, &xs_sys_tcu1_cfg,
+			&xs_sys_tcu2_cfg },
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qsm_cfg },
+};
+
+static struct qcom_icc_node qss_ddrss_cfg = {
+	.name = "qss_ddrss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qnm_hscnoc = {
+	.name = "qnm_hscnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 10,
+	.link_nodes = { &qhs_aoss, &qhs_hbcu,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_soccp, &qhs_tme_cfg,
+			&qns_pcie_dma, &qss_cfg,
+			&qss_ddrss_cfg, &qxs_imem },
+};
+
+static struct qcom_icc_node qns_hscnoc_cnoc = {
+	.name = "qns_hscnoc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_hscnoc },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.channels = 8,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &ebi },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.channels = 8,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &llcc_mc },
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node xs_pcie_2 = {
+	.name = "xs_pcie_2",
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node xs_pcie_3 = {
+	.name = "xs_pcie_3",
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node qnm_hscnoc_pcie = {
+	.name = "qnm_hscnoc_pcie",
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 4,
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1,
+			&xs_pcie_2, &xs_pcie_3 },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_hscnoc_pcie },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.channels = 1,
+	.buswidth = 64,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb2d000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qns_hscnoc_sf = {
+	.name = "qns_hscnoc_sf",
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.link_nodes = { &qnm_snoc_sf },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_hscnoc_sf },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qxm_crypto_0 = {
+	.name = "qxm_crypto_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x19000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qxm_crypto_1 = {
+	.name = "qxm_crypto_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x17000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qxm_crypto_2 = {
+	.name = "qxm_crypto_2",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x18000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_usb2 = {
+	.name = "xm_usb2",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qnm_aggre_north = {
+	.name = "qnm_aggre_north",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x821000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qns_a1noc_hscnoc = {
+	.name = "qns_a1noc_hscnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre_north },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_hscnoc },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_hscnoc },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_hscnoc },
+};
+
+static struct qcom_icc_node qxm_qup3 = {
+	.name = "qxm_qup3",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_hscnoc },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.channels = 2,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x15000, 0x16000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_hscnoc },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_hscnoc_sf },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_soccp = {
+	.name = "qxm_soccp",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qnm_aggre_south = {
+	.name = "qnm_aggre_south",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2b000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qns_a2noc_hscnoc = {
+	.name = "qns_a2noc_hscnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre_south },
+};
+
+static struct qcom_icc_node xm_emac_0 = {
+	.name = "xm_emac_0",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_hscnoc },
+};
+
+static struct qcom_icc_node xm_emac_1 = {
+	.name = "xm_emac_1",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x17000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_hscnoc },
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_node qup3_core_slave = {
+	.name = "qup3_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup3_core_master = {
+	.name = "qup3_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup3_core_slave },
+};
+
+static struct qcom_icc_node qhm_mm_rscc = {
+	.name = "qhm_mm_rscc",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qss_cfg },
+};
+
+static struct qcom_icc_node qnm_hpass_audio_hscnoc = {
+	.name = "qnm_hpass_audio_hscnoc",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11a000 },
+		.prio = 3,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qns_hpass_agnoc_audio = {
+	.name = "qns_hpass_agnoc_audio",
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_hpass_audio_hscnoc },
+};
+
+static struct qcom_icc_node qnm_hpass_dsp0 = {
+	.name = "qnm_hpass_dsp0",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qns_hpass_agnoc_audio },
+};
+
+static struct qcom_icc_node qnm_hpass_dsp1 = {
+	.name = "qnm_hpass_dsp1",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qns_hpass_agnoc_audio },
+};
+
+static struct qcom_icc_node qnm_hpass_dsp2 = {
+	.name = "qnm_hpass_dsp2",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qns_hpass_agnoc_audio },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa18000 },
+		.prio = 1,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node alm_qtc = {
+	.name = "alm_qtc",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a000 },
+		.prio = 3,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node alm_sys_tcu0 = {
+	.name = "alm_sys_tcu0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb2c000 },
+		.prio = 6,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node alm_sys_tcu1 = {
+	.name = "alm_sys_tcu1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x820000 },
+		.prio = 6,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node alm_sys_tcu2 = {
+	.name = "alm_sys_tcu2",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x218000 },
+		.prio = 6,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_gpu0 = {
+	.name = "qnm_gpu0",
+	.channels = 4,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 4,
+		.port_offsets = { 0xa19000, 0xa1a000, 0xa1b000, 0xa1c000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x822000, 0x823000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x824000, 0x825000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_nsp0_hscnoc = {
+	.name = "qnm_nsp0_hscnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x219000, 0x21a000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_nsp1_hscnoc = {
+	.name = "qnm_nsp1_hscnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x21b000, 0x21c000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.channels = 1,
+	.buswidth = 64,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2c000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x826000 },
+		.prio = 4,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_mnoc_hf },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x18000, 0x19000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qnm_dprx0 = {
+	.name = "qnm_dprx0",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1c000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qnm_mdp0 = {
+	.name = "qnm_mdp0",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x1a000, 0x1b000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qnm_mdp1 = {
+	.name = "qnm_mdp1",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x1d000, 0x1e000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_mnoc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_nrt_icp_sf = {
+	.name = "qnm_camnoc_nrt_icp_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1b000 },
+		.prio = 4,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_rt_cdm_sf = {
+	.name = "qnm_camnoc_rt_cdm_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1c000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x1d000, 0x1e000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_cv_cpu = {
+	.name = "qnm_video_cv_cpu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x21000 },
+		.prio = 4,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_eva = {
+	.name = "qnm_video_eva",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x23000, 0x24000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_mvp0 = {
+	.name = "qnm_video_mvp0",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x1f000, 0x20000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x22000 },
+		.prio = 4,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qns_nsp0_hsc_noc = {
+	.name = "qns_nsp0_hsc_noc",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_nsp0_hscnoc },
+};
+
+static struct qcom_icc_node qnm_nsp_data00 = {
+	.name = "qnm_nsp_data00",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qns_nsp0_hsc_noc },
+};
+
+static struct qcom_icc_node qns_nsp1_hsc_noc = {
+	.name = "qns_nsp1_hsc_noc",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_nsp1_hscnoc },
+};
+
+static struct qcom_icc_node qnm_nsp_data01 = {
+	.name = "qnm_nsp_data01",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qns_nsp1_hsc_noc },
+};
+
+static struct qcom_icc_node qns_pcie_hscnoc = {
+	.name = "qns_pcie_hscnoc",
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.link_nodes = { &qnm_pcie },
+};
+
+static struct qcom_icc_node qnm_pcie_ibnoc_dma = {
+	.name = "qnm_pcie_ibnoc_dma",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &xs_pcie_0 },
+};
+
+static struct qcom_icc_node qns_pcie_obnoc_dma = {
+	.name = "qns_pcie_obnoc_dma",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_pcie_ibnoc_dma },
+};
+
+static struct qcom_icc_node qxm_pcie_dma_0 = {
+	.name = "qxm_pcie_dma_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x50000 },
+		.prio = 0,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 2,
+	.link_nodes = { &qns_pcie_hscnoc, &qns_pcie_obnoc_dma },
+};
+
+static struct qcom_icc_node xm_pcie_0 = {
+	.name = "xm_pcie_0",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_hscnoc },
+};
+
+static struct qcom_icc_node xm_pcie_1 = {
+	.name = "xm_pcie_1",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_hscnoc },
+};
+
+static struct qcom_icc_node xm_pcie_2 = {
+	.name = "xm_pcie_2",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_hscnoc },
+};
+
+static struct qcom_icc_node xm_pcie_3 = {
+	.name = "xm_pcie_3",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_hscnoc },
+};
+
+static struct qcom_icc_node qnm_safe_dma = {
+	.name = "qnm_safe_dma",
+	.channels = 1,
+	.buswidth = 64,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1b000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_hscnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_c0n0 = {
+	.name = "C0N0",
+	.keepalive = true,
+	.enable_mask = BIT(0),
+	.num_nodes = 2,
+	.nodes = { &qnm_nsp_data00, &qns_nsp0_hsc_noc },
+};
+
+static struct qcom_icc_bcm bcm_c1n0 = {
+	.name = "C1N0",
+	.enable_mask = BIT(0),
+	.num_nodes = 2,
+	.nodes = { &qnm_nsp_data01, &qns_nsp1_hsc_noc },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto_0 },
+};
+
+static struct qcom_icc_bcm bcm_ce1 = {
+	.name = "CE1",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto_1 },
+};
+
+static struct qcom_icc_bcm bcm_ce2 = {
+	.name = "CE2",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto_2 },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.enable_mask = BIT(0),
+	.num_nodes = 5,
+	.nodes = { &qhm_mm_rscc, &qnm_hscnoc,
+		   &qnm_cnoc_pcie_dma, &qnm_hscnoc_pcie,
+		   &qnm_pcie_ibnoc_dma },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 2,
+	.nodes = { &qhs_display_1_cfg, &qhs_display_cfg },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.enable_mask = BIT(0),
+	.num_nodes = 12,
+	.nodes = { &qnm_camnoc_hf, &qnm_dprx0,
+		   &qnm_mdp0, &qnm_mdp1,
+		   &qnm_camnoc_nrt_icp_sf, &qnm_camnoc_rt_cdm_sf,
+		   &qnm_camnoc_sf, &qnm_video_cv_cpu,
+		   &qnm_video_eva, &qnm_video_mvp0,
+		   &qnm_video_v_cpu, &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.vote_scale = 1,
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.vote_scale = 1,
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup2 = {
+	.name = "QUP2",
+	.vote_scale = 1,
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup3 = {
+	.name = "QUP3",
+	.vote_scale = 1,
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qup3_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.num_nodes = 19,
+	.nodes = { &alm_gpu_tcu, &alm_qtc,
+		   &alm_sys_tcu0, &alm_sys_tcu1,
+		   &alm_sys_tcu2, &chm_apps,
+		   &qnm_aggre_north, &qnm_aggre_south,
+		   &qnm_gpu0, &qnm_hpass_audio_hscnoc,
+		   &qnm_mnoc_hf, &qnm_mnoc_sf,
+		   &qnm_nsp0_hscnoc, &qnm_nsp1_hscnoc,
+		   &qnm_pcie, &qnm_snoc_sf,
+		   &xm_gic, &qns_hscnoc_cnoc,
+		   &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_hscnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.enable_mask = BIT(0),
+	.num_nodes = 11,
+	.nodes = { &qns_a1noc_snoc, &qns_a1noc_hscnoc,
+		   &qns_a2noc_hscnoc, &qxm_pcie_dma_0,
+		   &xm_pcie_0, &xm_pcie_1,
+		   &xm_pcie_2, &xm_pcie_3,
+		   &qns_pcie_hscnoc, &qns_pcie_obnoc_dma,
+		   &qnm_safe_dma },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_ce1,
+	&bcm_ce2,
+	&bcm_sn1,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_CRYPTO_CORE0] = &qxm_crypto_0,
+	[MASTER_CRYPTO_CORE1] = &qxm_crypto_1,
+	[MASTER_CRYPTO_CORE2] = &qxm_crypto_2,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_USB2] = &xm_usb2,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[MASTER_USB3_1] = &xm_usb3_1,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct regmap_config seca_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1d400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_aggre1_noc = {
+	.config = &seca_aggre1_noc_regmap_config,
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_tile_bcms[] = {
+	&bcm_sn1,
+};
+
+static struct qcom_icc_node * const aggre1_noc_tile_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_QUP_3] = &qxm_qup3,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[SLAVE_A1NOC_HSCNOC] = &qns_a1noc_hscnoc,
+};
+
+static const struct regmap_config seca_aggre1_noc_tile_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x23400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_aggre1_noc_tile = {
+	.config = &seca_aggre1_noc_tile_regmap_config,
+	.nodes = aggre1_noc_tile_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_tile_nodes),
+	.bcms = aggre1_noc_tile_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_tile_bcms),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_SOCCP_AGGR_NOC] = &qxm_soccp,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct regmap_config seca_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1b400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_aggre2_noc = {
+	.config = &seca_aggre2_noc_regmap_config,
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_tile_bcms[] = {
+	&bcm_sn1,
+};
+
+static struct qcom_icc_node * const aggre2_noc_tile_nodes[] = {
+	[MASTER_EMAC_0] = &xm_emac_0,
+	[MASTER_EMAC_1] = &xm_emac_1,
+	[SLAVE_A2NOC_HSCNOC] = &qns_a2noc_hscnoc,
+};
+
+static const struct regmap_config seca_aggre2_noc_tile_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1b400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_aggre2_noc_tile = {
+	.config = &seca_aggre2_noc_tile_regmap_config,
+	.nodes = aggre2_noc_tile_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_tile_nodes),
+	.bcms = aggre2_noc_tile_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_tile_bcms),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+	&bcm_qup2,
+	&bcm_qup3,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[MASTER_QUP_CORE_3] = &qup3_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+	[SLAVE_QUP_CORE_3] = &qup3_core_slave,
+};
+
+static const struct qcom_icc_desc seca_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_PS_ETH_0] = &ps_eth_0,
+	[SLAVE_PS_ETH_1] = &ps_eth_1,
+	[SLAVE_SHS_SERVER] = &ps_shs_server,
+	[SLAVE_AHB2PHY_0] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_1] = &qhs_ahb2phy1,
+	[SLAVE_AHB2PHY_3] = &qhs_ahb2phy3,
+	[SLAVE_AHB2PHY_ETH_0] = &qhs_ahb2phy_eth_0,
+	[SLAVE_AHB2PHY_ETH_1] = &qhs_ahb2phy_eth_1,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CRYPTO_1_CFG] = &qhs_crypto1_cfg,
+	[SLAVE_CRYPTO_2_CFG] = &qhs_crypto2_cfg,
+	[SLAVE_DISPLAY_1_CFG] = &qhs_display_1_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_DPRX0] = &qhs_dprx0,
+	[SLAVE_EVA_CFG] = &qhs_eva_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_0_cfg,
+	[SLAVE_I2C] = &qhs_i2c,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_MCW_PCIE] = &qhs_mcw_pcie,
+	[SLAVE_MM_RSCC] = &qhs_mm_rscc,
+	[SLAVE_NE_CLK_CTL] = &qhs_ne_clk_ctl,
+	[SLAVE_NSPSS0_CFG] = &qhs_nspss0_cfg,
+	[SLAVE_NSPSS1_CFG] = &qhs_nspss1_cfg,
+	[SLAVE_NW_CLK_CTL] = &qhs_nw_clk_ctl,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_3] = &qhs_qup3,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SAFEDMA_CFG] = &qhs_safedma_cfg,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SE_CLK_CTL] = &qhs_se_clk_ctl,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_TSC_CFG] = &qhs_tsc_cfg,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB2] = &qhs_usb2,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_USB3_1] = &qhs_usb3_1,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_COMPUTENOC_CFG] = &qss_computenoc_cfg,
+	[SLAVE_PCIE_NOC_CFG] = &qss_pcie_noc_cfg,
+	[SLAVE_QTC_CFG] = &qss_qtc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_SYS_TCU0_CFG] = &xs_sys_tcu0_cfg,
+	[SLAVE_SYS_TCU1_CFG] = &xs_sys_tcu1_cfg,
+	[SLAVE_SYS_TCU2_CFG] = &xs_sys_tcu2_cfg,
+};
+
+static const struct regmap_config seca_cnoc_cfg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xb200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_cnoc_cfg = {
+	.config = &seca_cnoc_cfg_regmap_config,
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_MM_RSCC] = &qhm_mm_rscc,
+	[MASTER_HSCNOC_CNOC] = &qnm_hscnoc,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_HBCU] = &qhs_hbcu,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_SOCCP] = &qhs_soccp,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_PCIE_DMA] = &qns_pcie_dma,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
+	[SLAVE_IMEM] = &qxs_imem,
+};
+
+static const struct regmap_config seca_cnoc_main_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1d200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_cnoc_main = {
+	.config = &seca_cnoc_main_regmap_config,
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_node * const hpass_ag_noc_nodes[] = {
+	[MASTER_HPASS_PROC_0] = &qnm_hpass_dsp0,
+	[MASTER_HPASS_PROC_1] = &qnm_hpass_dsp1,
+	[MASTER_HPASS_PROC_2] = &qnm_hpass_dsp2,
+	[SLAVE_HPASS_AGNOC_AUDIO] = &qns_hpass_agnoc_audio,
+};
+
+static const struct regmap_config seca_hpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x37080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_hpass_ag_noc = {
+	.config = &seca_hpass_ag_noc_regmap_config,
+	.nodes = hpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(hpass_ag_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const hscnoc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const hscnoc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_QTC_TCU] = &alm_qtc,
+	[MASTER_SYS_TCU_0] = &alm_sys_tcu0,
+	[MASTER_SYS_TCU_1] = &alm_sys_tcu1,
+	[MASTER_SYS_TCU_2] = &alm_sys_tcu2,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_A1NOC_TILE_HSCNOC] = &qnm_aggre_north,
+	[MASTER_A2NOC_TILE_HSCNOC] = &qnm_aggre_south,
+	[MASTER_GFX3D] = &qnm_gpu0,
+	[MASTER_HPASS_AUDIO_HSCNOC] = &qnm_hpass_audio_hscnoc,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_NSP0_HSCNOC] = &qnm_nsp0_hscnoc,
+	[MASTER_NSP1_HSCNOC] = &qnm_nsp1_hscnoc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_HSCNOC_CNOC] = &qns_hscnoc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+};
+
+static const struct regmap_config seca_hscnoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xb2d080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_hscnoc = {
+	.config = &seca_hscnoc_regmap_config,
+	.nodes = hscnoc_nodes,
+	.num_nodes = ARRAY_SIZE(hscnoc_nodes),
+	.bcms = hscnoc_bcms,
+	.num_bcms = ARRAY_SIZE(hscnoc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc seca_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_hf_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_hf_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_DPRX0] = &qnm_dprx0,
+	[MASTER_MDP0] = &qnm_mdp0,
+	[MASTER_MDP1] = &qnm_mdp1,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+};
+
+static const struct regmap_config seca_mmss_noc_hf_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2e400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_mmss_noc_hf = {
+	.config = &seca_mmss_noc_hf_regmap_config,
+	.nodes = mmss_noc_hf_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_hf_nodes),
+	.bcms = mmss_noc_hf_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_hf_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_sf_bcms[] = {
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_sf_nodes[] = {
+	[MASTER_CAMNOC_NRT_ICP_SF] = &qnm_camnoc_nrt_icp_sf,
+	[MASTER_CAMNOC_RT_CDM_SF] = &qnm_camnoc_rt_cdm_sf,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
+	[MASTER_VIDEO_EVA] = &qnm_video_eva,
+	[MASTER_VIDEO_MVP0] = &qnm_video_mvp0,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+};
+
+static const struct regmap_config seca_mmss_noc_sf_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x40000,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_mmss_noc_sf = {
+	.config = &seca_mmss_noc_sf_regmap_config,
+	.nodes = mmss_noc_sf_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_sf_nodes),
+	.bcms = mmss_noc_sf_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_sf_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_data_noc_0_bcms[] = {
+	&bcm_c0n0,
+};
+
+static struct qcom_icc_node * const nsp_data_noc_0_nodes[] = {
+	[MASTER_NSP0_PROC] = &qnm_nsp_data00,
+	[SLAVE_NSP0_HSC_NOC] = &qns_nsp0_hsc_noc,
+};
+
+static const struct regmap_config seca_nsp_data_noc_0_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2a200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_nsp_data_noc_0 = {
+	.config = &seca_nsp_data_noc_0_regmap_config,
+	.nodes = nsp_data_noc_0_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_data_noc_0_nodes),
+	.bcms = nsp_data_noc_0_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_data_noc_0_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_data_noc_1_bcms[] = {
+	&bcm_c1n0,
+};
+
+static struct qcom_icc_node * const nsp_data_noc_1_nodes[] = {
+	[MASTER_NSP1_PROC] = &qnm_nsp_data01,
+	[SLAVE_NSP1_HSC_NOC] = &qns_nsp1_hsc_noc,
+};
+
+static const struct regmap_config seca_nsp_data_noc_1_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2a200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_nsp_data_noc_1 = {
+	.config = &seca_nsp_data_noc_1_regmap_config,
+	.nodes = nsp_data_noc_1_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_data_noc_1_nodes),
+	.bcms = nsp_data_noc_1_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_data_noc_1_bcms),
+};
+
+static struct qcom_icc_node * const pcie_cfg_nodes[] = {
+	[MASTER_PCIE_NOC_CFG] = &qsm_pcie_noc_cfg,
+	[SLAVE_PCIE_AHB2PHY_CFG] = &qhs_pcie_ahb2phy_cfg,
+	[SLAVE_PCIE_CFG_0] = &qhs_pcie_cfg_0,
+	[SLAVE_PCIE_CFG_1] = &qhs_pcie_cfg_1,
+	[SLAVE_PCIE_CFG_2] = &qhs_pcie_cfg_2,
+	[SLAVE_PCIE_CFG_3] = &qhs_pcie_cfg_3,
+	[SLAVE_PCIE_DMA_0_CFG] = &qhs_pcie_dma_0_cfg,
+};
+
+static const struct regmap_config seca_pcie_cfg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x7200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_pcie_cfg = {
+	.config = &seca_pcie_cfg_regmap_config,
+	.nodes = pcie_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_cfg_nodes),
+};
+
+static struct qcom_icc_bcm * const pcie_data_inbound_bcms[] = {
+	&bcm_sn1,
+};
+
+static struct qcom_icc_node * const pcie_data_inbound_nodes[] = {
+	[MASTER_PCIE_DMA_0] = &qxm_pcie_dma_0,
+	[MASTER_PCIE_0] = &xm_pcie_0,
+	[MASTER_PCIE_1] = &xm_pcie_1,
+	[MASTER_PCIE_2] = &xm_pcie_2,
+	[MASTER_PCIE_3] = &xm_pcie_3,
+	[SLAVE_PCIE_HSCNOC] = &qns_pcie_hscnoc,
+	[SLAVE_PCIE_OBNOC_DMA] = &qns_pcie_obnoc_dma,
+};
+
+static const struct regmap_config seca_pcie_data_inbound_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x50080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_pcie_data_inbound = {
+	.config = &seca_pcie_data_inbound_regmap_config,
+	.nodes = pcie_data_inbound_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_data_inbound_nodes),
+	.bcms = pcie_data_inbound_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_data_inbound_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_data_outbound_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const pcie_data_outbound_nodes[] = {
+	[MASTER_CNOC_PCIE_DMA] = &qnm_cnoc_pcie_dma,
+	[MASTER_ANOC_PCIE_HSCNOC] = &qnm_hscnoc_pcie,
+	[MASTER_PCIE_IBNOC_DMA] = &qnm_pcie_ibnoc_dma,
+	[SLAVE_PCIE_DMA_0] = &qxs_pcie_dma_0,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_PCIE_2] = &xs_pcie_2,
+	[SLAVE_PCIE_3] = &xs_pcie_3,
+};
+
+static const struct regmap_config seca_pcie_data_outbound_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x17000,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_pcie_data_outbound = {
+	.config = &seca_pcie_data_outbound_regmap_config,
+	.nodes = pcie_data_outbound_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_data_outbound_nodes),
+	.bcms = pcie_data_outbound_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_data_outbound_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_SAFE_DMA] = &qnm_safe_dma,
+	[SLAVE_SNOC_HSCNOC_SF] = &qns_hscnoc_sf,
+};
+
+static const struct regmap_config seca_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1b080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc seca_system_noc = {
+	.config = &seca_system_noc_regmap_config,
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,seca-aggre1-noc", .data = &seca_aggre1_noc },
+	{ .compatible = "qcom,seca-aggre1-noc-tile", .data = &seca_aggre1_noc_tile },
+	{ .compatible = "qcom,seca-aggre2-noc", .data = &seca_aggre2_noc },
+	{ .compatible = "qcom,seca-aggre2-noc-tile", .data = &seca_aggre2_noc_tile },
+	{ .compatible = "qcom,seca-clk-virt", .data = &seca_clk_virt },
+	{ .compatible = "qcom,seca-cnoc-cfg", .data = &seca_cnoc_cfg },
+	{ .compatible = "qcom,seca-cnoc-main", .data = &seca_cnoc_main },
+	{ .compatible = "qcom,seca-hpass-ag-noc", .data = &seca_hpass_ag_noc },
+	{ .compatible = "qcom,seca-hscnoc", .data = &seca_hscnoc },
+	{ .compatible = "qcom,seca-mc-virt", .data = &seca_mc_virt },
+	{ .compatible = "qcom,seca-mmss-noc-hf", .data = &seca_mmss_noc_hf },
+	{ .compatible = "qcom,seca-mmss-noc-sf", .data = &seca_mmss_noc_sf },
+	{ .compatible = "qcom,seca-nsp-data-noc-0", .data = &seca_nsp_data_noc_0 },
+	{ .compatible = "qcom,seca-nsp-data-noc-1", .data = &seca_nsp_data_noc_1 },
+	{ .compatible = "qcom,seca-pcie-cfg", .data = &seca_pcie_cfg },
+	{ .compatible = "qcom,seca-pcie-data-inbound", .data = &seca_pcie_data_inbound },
+	{ .compatible = "qcom,seca-pcie-data-outbound", .data = &seca_pcie_data_outbound },
+	{ .compatible = "qcom,seca-system-noc", .data = &seca_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-seca",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("Qualcomm Seca NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.47.3

