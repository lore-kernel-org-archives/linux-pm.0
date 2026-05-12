Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BB3655C4
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588349; cv=none; b=b2OeYIqWoZ4qJ2jqkKEOLYn+YQCMbPaCvxH14hHMjwM0dtm5MuK+vd4mB4ufNYXKSkYZuHWLxzyld7ebMW01SrZtj+aqleixxAU/qXzYrmPo4Lfued5zNjkYcfDoWEU3/N8kFZajenvI4NUgc0Egrlg72M41JDug6eNWkHGdLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588349; c=relaxed/simple;
	bh=/fsGK0RcI++sYO1sq1g8j1sqo+5hrLDliu2X0fxunrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOXWSo0K85+Y7p/V1Rc3wTcTweBAfyow+9DzyCVuP5MFSVJ8UFSN0M1rJp2KqqRoPYUY5LFe6L/asN+oBFJf0XfyliqQFTb6kgcFurJygDspxb0cykCfj0bjKdPAmNxuU6W2MDKsMg0D+eQ2YKOlFL0PbYHQO49XiyMi8sFmf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uqtic9FU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Chn+9BPf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uqtic9FU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Chn+9BPf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CAUIS03444396
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMbEk1ndXqSY38Pt3AtE3A3ndA7Zc0BxITRNGNrHvFE=; b=Uqtic9FU99Xc8upV
	u0UasEZt6JiohZIbm9gfJXi1Bg1QAUnT/cOJn2meu8Yi6mFoVVlvmJ38K5MKR5fT
	yVNKPT2hFg1qOwk5IYMC8HrD5NFdLqNLSZAXhJ2Lcc08v3VEY1ygqoVRthxxGxef
	RN1Kdq2dNIjIB7ArDGjkzadeWKdn4q2SnR1MbEuwD8ZhplwirqLWhSjoHdBkun3Y
	TD/eG7m/cHIX7562PVaJxOQAEIguyWu0KjBwScSN1OczuL0G4DejaOFGm0K4KWmP
	zKQcqHKuj/1MtOLF9o1QmMpGkR9leXgd5UelKEGGWOzcewcrSAeRnDlSD3O5r/im
	3WTP9Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0k6xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:07 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6314220f28eso6201555137.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778588347; x=1779193147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMbEk1ndXqSY38Pt3AtE3A3ndA7Zc0BxITRNGNrHvFE=;
        b=Chn+9BPfTWB6Y5C/ykj2KQ8ZB5YwASAMmGxJK8+6c/XQwDG6bMC2R44ry0KvzIhKs9
         shi0x5LSfHzX9h4IZVVdtnUGKuf8J5Jy1NlT+6zo2FbB84PmS4u1kwQJEuyrNZ32oXOS
         9ThqJzz6M0vWZz0BkVcNw4b7VFVihPM7uCL0ABhLdO4kNDaGGbEPqXfC6mMCYFJq7hje
         pVcGrcvy9O0ywqmQ5Le6XojSHdR4HBJLDHM6Rc2/uY/ps60uJPJNLCQA00073N/yS6aa
         F3YyXhYWLdXtIer0BdcVgV4ZM1tCw1pYzKtJKzcZ6n3IxlOFJQMiWQMi0YAfiYA2XwU+
         kduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588347; x=1779193147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KMbEk1ndXqSY38Pt3AtE3A3ndA7Zc0BxITRNGNrHvFE=;
        b=eyA0OoOh004Rz43f+vVCrFK8rOJp6fAwkIjcC3MMR2YVXGw+6skeAK+1JkwTnMWIji
         fOITth3054lTHkJQYQ53Xr8oRUp1Gn5eqj92X23ZmYpENrH6OJrGETOT9cvWqBAHOooV
         C3zrG3zvjzKpJz8B41xomBAGMNcvf+z3gRlCTCV3+05nxs9D2JAqm6V8IRjAVYHV2Szv
         w2bkkOgaXkB3yTNya5mtAPwxhnnmSyoP7H2l4VBfPddxr4cDj5a8m2M/X6NeSunc1FZt
         9P7oS3ON81ckPfJNGIgWiLvd8HvzmMQWBNYNUhqC92s4OhFqgH/84qQmuywR4uhKmi6y
         tlYg==
X-Forwarded-Encrypted: i=1; AFNElJ9XGRrHzKRjT2YtG5HQvHZmQm92POHgH5IujSw/fbMFcBf6pFW5uoBp6zNhzjeqFmhRDTOtth8HcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEcO8EHqkUL7PY5N5SPxymlRY7eRFjoG65VGeLWLLTY11PMx/
	bSzPP6J1T62AJSqimiu2Hw6a+Po4WBxYHBYhsDjDwp1LXtZEZlY3maMwbcvAmFnoZoC0kU3z2lv
	xHIuxO8sO6T/7U+06RF1jXMbW0vSfKs2cIc4y2Wzo29zc7Yh6d1WbUFo/ljeR3g==
X-Gm-Gg: Acq92OGCl7h03s0L4ldBfkVSo9ruEjKMXHpIDEKgQKc/mG1Hv1EDMPwH/yuLs6z4JKA
	t52ZEWOrF716+SA7j+Etmidd12unrPt4lMRC9iyTP4d9PDxbeFhfdjrJq32HI5UbKPexUCHZc29
	cjwInKPjwGOZ0NGXqdZw+2m85q9aZlotkz+WXZavNFvW4gb6NvPUNggsg89grWUQpur/IMnj66Y
	hDDDyMK+yqspody+6NRWcrJ3tcCL+Ki3HAy/KHF72PmCsl88LUPygq3wGHLisk4jMNZVtv6fhDV
	7vfOM7SjZxHQ37jhm98WIBr8xJVAuQX0zkzli25ZXMErvlXXtVdbpC3zAHuOqfiYSSiPVG4AalU
	ksNcF/K0Ce0gb71PXUQEUeX/5jG0gEQ==
X-Received: by 2002:a05:6102:8014:b0:632:1e2f:3a6f with SMTP id ada2fe7eead31-636180cd12fmr967933137.24.1778588346347;
        Tue, 12 May 2026 05:19:06 -0700 (PDT)
X-Received: by 2002:a05:6102:8014:b0:632:1e2f:3a6f with SMTP id ada2fe7eead31-636180cd12fmr967881137.24.1778588345625;
        Tue, 12 May 2026 05:19:05 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm33700213f8f.6.2026.05.12.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:19:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 12 May 2026 15:18:53 +0300
Subject: [PATCH 2/2] interconnect: qcom: eliza: Add SDCC1 slave node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-2-b1edf81bac3b@oss.qualcomm.com>
References: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
In-Reply-To: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=/fsGK0RcI++sYO1sq1g8j1sqo+5hrLDliu2X0fxunrw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqAxqyHa8bNRbGRYhaal1bqBqlrQQ5A/ygPzOAo
 sXvByYsYhCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCagMasgAKCRAbX0TJAJUV
 VjtEEACltHlYJTIgQOqUb9Ffu2aOQrsIWIZGhbgQrPLddl1jYPKssCXIxycFFp+M4/4uravI32U
 oUALuU9j3fJA34GHVkMjSdIBzHKJrDn/thG+ZenA+m0ogXm5nYG4mxVIPuD9blcqrgfNIXJB8AG
 oBQN6wxZtuhjeClVBtdlZkIoDiwmLs+70Z8GSneEcKJsJ188i2ERBnLY86mT4s6TYKSVkx2ODGH
 LEGIFckv5Uws5L4olPw06hklufT6ohtsyvIHjy585mlNkpHZOPI4Nocyk9ujVjCp7ugiRggFi9m
 VvDF6JeSBQVCbbfo4T4MnuOOWT0Al8Q8sMsM6wpobxLjOzFfVIsjF169tcSni3+FhTDF22wmr4x
 kRq3Dcutg61prXWmOW8Ezzxi8J1tZj4R8FaEU+JjLrpAUGF6i+mMVD3Z/fMLTpYNvyRV7WRM7fd
 LNnPPXVQTaUJeYEW1Adr3HEnyWYsfX5CfS+CEYtpmIjure2PyCpllMQFi9AME5hmyi3jqbbSzUB
 8iMg2LeeIQ+KK1h87vKkGKlw9FoY8d7tnAoMIROFWdbFUX57Ed+d5SyYBVyayNdvCJyehNnZeiU
 zlGHPiNtkmSNs9dseYYwshXraDaO2sBUltBTmKVGn0ANLUNReUTCc1DBwAzSVgu0E0RwuaXRsAH
 L/OrjxUFp7AaaXw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a031abb cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=gcnggjyPzmaCdwFRn6A1TQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eJdK8YEf0-IbTu21kd4A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 1csKJMbekwgUtd2gpWOw5E1r2WSlduHU
X-Proofpoint-ORIG-GUID: 1csKJMbekwgUtd2gpWOw5E1r2WSlduHU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNyBTYWx0ZWRfX1rsnV5Y8Hhei
 R4DjQPNAi8t88jm7hw7QMRsAuAwh3PyRILf2kx6UWFx6CBRpwFP60GKVjr1oVVC2fNoR33wwm4T
 BVS70XIwmmmM06KGGk6Pjy1GwsNcjrKBuOitHHxlPVempWaFpjnlNFZbUud8G3/LDsuyPV7PyQs
 vaxa74uxe3elNbm393MzK7meiL8+AFXTVrJKfTm99mQub5NccRWulYNJcCBYxEuPPXnW9F0Ms5y
 b6ZYVU5GF21HNaqylAXpvCXg7E/HOTsYYuX0SKEiYqoO1A3bBlNsxgGTOgovVFiAXwp/6CgI3wH
 R+aq2bdq7WhYMGKFMvfP+P+hr7SbIsHz3oEE12MS62FfLdHGiKuDbt+F2/cfAXJaZ3R+lqwNM/1
 lXifkKo5iFB3dO6XGaKxB/X0XCs9aAaFJB/hDamtSQ4UrTcJ2Og1RDcSwhthGIbaQ2xa2f3sAcp
 vVjfURC74VG50OcA3rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120127

The Eliza interconnect provider is missing the SDCC1 CNOC CFG slave
node. Add qhs_sdc1 to the provider node table and qsm_cfg links so
SDCC1 interconnect paths can resolve to a provider node.

Bump the qsm_cfg link count to match the new entry.

Fixes: a39efc80ff50 ("interconnect: qcom: Add Eliza interconnect provider driver")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/interconnect/qcom/eliza.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/eliza.c b/drivers/interconnect/qcom/eliza.c
index a4f7903f0524..6d12a1c3c034 100644
--- a/drivers/interconnect/qcom/eliza.c
+++ b/drivers/interconnect/qcom/eliza.c
@@ -127,6 +127,12 @@ static struct qcom_icc_node qhs_qup2 = {
 	.buswidth = 4,
 };
 
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
 	.channels = 1,
@@ -383,7 +389,7 @@ static struct qcom_icc_node qsm_cfg = {
 	.name = "qsm_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 29,
+	.num_links = 30,
 	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 			&qhs_camera_cfg, &qhs_clk_ctl,
 			&qhs_crypto0_cfg, &qhs_display_cfg,
@@ -392,7 +398,7 @@ static struct qcom_icc_node qsm_cfg = {
 			&qhs_mss_cfg, &qhs_pcie_0_cfg,
 			&qhs_prng, &qhs_qdss_cfg,
 			&qhs_qspi, &qhs_qup1,
-			&qhs_qup2, &qhs_sdc2,
+			&qhs_qup2, &qhs_sdc1, &qhs_sdc2,
 			&qhs_tcsr, &qhs_tlmm,
 			&qhs_ufs_mem_cfg, &qhs_usb3_0,
 			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
@@ -1321,6 +1327,7 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 	[SLAVE_QSPI_0] = &qhs_qspi,
 	[SLAVE_QUP_1] = &qhs_qup1,
 	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
 	[SLAVE_SDCC_2] = &qhs_sdc2,
 	[SLAVE_TCSR] = &qhs_tcsr,
 	[SLAVE_TLMM] = &qhs_tlmm,

-- 
2.54.0

