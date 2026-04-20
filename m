Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084C375F9E
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651265; cv=none; b=WuTCIBFqHtkaqs4RY9O34qYyjRFbUR42Ci8jWoUV1RutSXBaK7QZ1Z0LuI2S5GHzi4TgCUYOxJ0Z7sj52gEJqYKVcIEVOVS5yjWkJLxCL4KIjivhAbs8ES7dmJDAy1aZFrZDQqu1pGYA3HT5Glv3yBmel5B01fKDu3qFUgW89J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651265; c=relaxed/simple;
	bh=qfd7iwFejapOwdqgA3gcHNnMcjbjqRylRGGeikBCzkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcRz2p1qhWWN/XUXFpaIX2ssn/TYp2ALI+B4RI/f03ZwP5vMZABX0hf5HVGL7hIByL1+5rkpq4gCMKzsPYeCD2BmQpzLRSXNSrGlC5j7V9QJsvCNDvnvIItOzvf9oy5h0quP3i0eMyLJo0TPcEgWwYc7BoA8ClnAD/0Lonztlao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqMePNDl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xnxi7dzQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqMePNDl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xnxi7dzQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JBgahA966554
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 02:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WUzQyC7Uu/vAoTWoSFyqpH+tWUEuLq7L5Kq
	PZoVEBpc=; b=bqMePNDl3JXmbQrWg4+W1ziL2kXL+70Rp7w4JnDCl7jVKWjaOhr
	JHgCAvUKoWtETuEoX/xh0tG56KizgtncX/t8ybmQluX3ka35pFzSubbbeem1c0J9
	Cxe6pzLIiBn005eW3+aozx1GEVoQ62Gpu/2Avn1yiX0PUGmaxcqvC325b3lFF9dV
	ZNfBHEP277e2usXIn7BuAbiTBOt3css7OBr/UZhN4uzJFRqrbg75qz8jByoo0+/Q
	fxAooFQKgzPPBBpEbUI4TYN3QfOFl6aZ2C6BptA0AU74x6g26zt3j/CWzQrEnj12
	zivqDCgt171YVX0XWnVTkFNwD0yxqVVAGFg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ukm8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 02:14:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c16233ee11so3514169eec.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776651262; x=1777256062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUzQyC7Uu/vAoTWoSFyqpH+tWUEuLq7L5KqPZoVEBpc=;
        b=Xnxi7dzQ+eEUJ7ZQTv5svaO3N5UG9gb7OBhQe5Gjcf0H3eUVemMBhxeYtxiF0c/Iya
         YolnHeT0lyPO1tJWt+uSn9H4mwwYnM7/YINpvSNgVkyNAi1kLhrWjp33+R9xCAVaU9/9
         GSz3tvM8Y+LVQils5Bgob3Bxg+KQk6vLHwXNqeZcJrik/RwDiymXJSDdlqdbLBB3J3Eo
         8x0Rt+p2tXTXBbDWeXqUfg4FN2bCApJHpeMRJY8PVwVUdXDeul1shVzHO9JMhUkSjBzx
         EMKDo8q2QwujQPhCGC0CdTzfypZU/wL85SAp58DGln87QrpTXOMnOP5b+pSUnnQYiEUx
         i2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776651262; x=1777256062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUzQyC7Uu/vAoTWoSFyqpH+tWUEuLq7L5KqPZoVEBpc=;
        b=XJA3ZamL7/IilEJHQGLFftnVmUGJUBp0ybHIU0BCbjDQfW9T3mZKAYXYJ+aM0k565n
         RdCcZfOO8yPDbGKBGTfMFLMBKug8MEzXFlxs1Oso8qVM9IeFawvvjOZxx3VysHmV+xIP
         oVJOm+g1K6BACReyo3I1/JuxbjXTNBNRb8243lklWF+h5T3sG1hm0LZv5DYMNNfYN8Xs
         1H0baHSfS+ZbHY4/JQbrDv8i0jYIIRp5PtTgaLchyYkyHPTTfTPJPi9YL+axuMMYemxE
         r0KZjintjcD9Xq8sAmsv6ShT4rOWIdHY1EhgzLAcXcvGGYJXK11pmbm8AnjZE1OPi55Y
         4ZgA==
X-Forwarded-Encrypted: i=1; AFNElJ/WOP+54yuEXPrxLeWiOuBd21EzozNJkZq1apCfI4JBh4c4/9YQ5BMn2eKHcWCo3VWWzWL1HkNFEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwubTK7Wcs9EcMaL1Rp7zxCnEqOCEkRGOcZ8HKwGKeuQ6xOv/4Q
	gpUz6kdUe/thxGIOmJqoRVDDlmlhh7rthFAvkGdkUhmIKsKtcIqkaUY2BKsYDri+fB3uLkn7bX8
	8RhngBYZ4pQsRUJ8bXLYKCckHyvQ+AKw8Wn8ejyWSRkrA1Vpwd/f3+ClsG1oSVA==
X-Gm-Gg: AeBDiesq3K5WeX7hDr2U1LsoFqls8ANjQ+tMEIWW8tzUmgYd6VSQs7Ui6ao7XRNLUDi
	o+KPThVjagBacK73rmrW/czY+RV/L+0yUbhpp/5UlxYnWQcdxwnh6sAGor6jdp883AJ+0+M+GbY
	7KBPvhB3EfT+7InaPod/yUOhQmYPESiVxN5hUuCpRjfqgfLX8ZRY8ZL/9XcBnDZrqYBHBUm+Wvz
	svaZzyPfN2qZCR2YEO6dvxnA0apE/IbNXl4+T0ODieIQdjitQQQxSr+goTJbeIM8fyyH6YaRzBz
	jd4GaUz6w6m19rGrL8BNKMBNhipidX2Kjfy8Y7vgbMC4tAiQVx6ed5TphFZG1uy0K4zvNnOkn/6
	aS7cuEGp8q//p7p1xyYfVdKLvDatGJcPq/uFjzscXfFCpQt+hTE8xojsmNI+hsRvjA7oDTQIrPf
	ygFh73QEDQ9bWJ7ZhQ
X-Received: by 2002:a05:7300:4308:b0:2dd:8a02:e8bb with SMTP id 5a478bee46e88-2e479110945mr6195968eec.27.1776651262420;
        Sun, 19 Apr 2026 19:14:22 -0700 (PDT)
X-Received: by 2002:a05:7300:4308:b0:2dd:8a02:e8bb with SMTP id 5a478bee46e88-2e479110945mr6195951eec.27.1776651261881;
        Sun, 19 Apr 2026 19:14:21 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ab8b89csm12556600eec.12.2026.04.19.19.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:14:21 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Qualcomm Nord SoC
Date: Mon, 20 Apr 2026 10:13:49 +0800
Message-ID: <20260420021351.1239355-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAxOSBTYWx0ZWRfX6mr6RYHw0FRt
 FTgyT4Uy3gw6mKTCXKci/2WboKKqNFZaUoGhr4B4KC1av7pTMmNl23vyMy0mt6Z1mHo6FF3INkD
 5+z7C7+0AZr+hlauODi7DmvMS9ARrBeMHC9uXvtIaANXakn3nbent1v+y+FxxIe0HXrtyuUFxjc
 GJEtkXjlWK+ioFGQr5Tjt02qH4/3tTOGDnwOSrr17l474W1BcW1NNspLR/kf/hP89Y9z5RGLJSq
 PVzobiipGhZE9b6WAtFHmQm9L3go9ifjurtQR5ICG+cLo8EqY8Cpb/IJNOJqobinDc1STKcurmb
 WCW4cIz46YTzuwL9yMRkeaJ9qs9akrMjEryICOt08dYrHlcoOxAy9D8ZcV42+22pSzRyQYQpuOn
 NPFlXdBSR0OJs8DjRTZA0QGyeiqW2p4fnztFnpoF3XlgewZJUGipvDzVotmbMntVOZ4Waea9wuV
 P77SdHuGgglzflEc/jQ==
X-Proofpoint-GUID: RdjtupJnhLuPEdqi-ZREoZt_HCN_Sr-P
X-Proofpoint-ORIG-GUID: RdjtupJnhLuPEdqi-ZREoZt_HCN_Sr-P
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e58bff cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=fJYZd5zOr1s3VisSgZEA:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200019

This series adds RPMh-based interconnect support for the Qualcomm Nord SoC.

The Nord SoC features a rich Network-on-Chip topology comprising 19 NoCs
including aggregate NoCs, a high-speed configuration NoC (HSCNOC),
a multimedia NoC, four NSP data NoCs for AI/ML workloads, PCIe inbound and
outbound NoCs, a system NoC, and virtual clock/MC nodes. Bandwidth requests
are communicated to the RPMh hardware through Bus Clock Manager (BCM)
resources via the Resource State Coordinator (RSC).

Odelu Kukatla (2):
  dt-bindings: interconnect: Document RPMh Network-On-Chip for Qualcomm
    Nord SoC
  interconnect: qcom: Add interconnect provider driver for Nord SoC

 .../bindings/interconnect/qcom,nord-rpmh.yaml |  131 +
 drivers/interconnect/qcom/Kconfig             |   11 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/nord.c              | 2682 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,nord-rpmh.h |  217 ++
 5 files changed, 3043 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,nord-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/nord.c
 create mode 100644 include/dt-bindings/interconnect/qcom,nord-rpmh.h

-- 
2.43.0

