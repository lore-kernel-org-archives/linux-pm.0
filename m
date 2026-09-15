Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505644A2A53
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476300; cv=none; b=op8fBcxpl63tYXBstHRhnxd8c9V/eoOWtCv0G5HdSFRhxyyfkYpPne+rq3ICsv8N+B1a+nU8gcfeA0PhJuKzW6coas0HVlNILTvoHZQeO0ZDF2Jnhs+qb/9fqQLZIKBO1Z9+20EIICLUzbNTp67jMlQCmBshZfuV9858vn95Hec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476300; c=relaxed/simple;
	bh=977rc1EWISksdidwfBUtALBlv4loh7402R0pOF2uUq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GI/yziTXPAhgHBrTwKSqb8ilSwQLCUoJdWAoQVWp1jWXVgPDM+q6MJa3ffArRn8Z2qh1ygPtZAK9Wwnt56OMWLusVhSBbYrN7lz9TyJ41CY7eRwrDBC2TV94DSl0FwxvLdD96eH7N/2j5JSpkyD5/7n8KINoszw1BQYQ3g7jNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TySGeKy+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZ8zZbnY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TySGeKy+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZ8zZbnY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9h40d3415761
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BBB9G5hK0Apskt/iqfXGmW
	1kt8sDxofyVux5eGTzUqs=; b=TySGeKy+W0LWoQVLTmJNRNiPUJQ63oR15cNyKP
	dzrc+tUn6QpHntG0cpQYyrxcgdsCVDDWlK1mPLFSybx84KcXSQCKrAsSUpIlvhye
	yLvwAKWgIu4LfeyBshFgXOlaP68P4Y1va/lE9EUg2R1VKQvnHSILqTGH7ueCwRKL
	HRxfs3zqrkLFUPqUStN6oLElw3lFR6o10Nbg/ac319trcsV7F4OuZpj7MbDIIDpa
	TgRum6emtlb7LKcMgxeqGs0KWRdvRf3137Y5hotwHO7rCdKAOv4NtBfekDvv61IZ
	zfMv43KA7xNNFuYkgqhTTIHKfSvOrLOYweIacXCqKuHqP/XQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc0xdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:44:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936e393061dso714090285a.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789476296; x=1790081096; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BBB9G5hK0Apskt/iqfXGmW1kt8sDxofyVux5eGTzUqs=;
        b=hZ8zZbnYaEnVYnVw/Lq8KYtFkX36OYtMH9DoVIuPyFky6lpc64Ti41Iy5zOjTlKa8F
         k1xCtdZJBw7iGzlFQypOhMt7/frVIBYhn3y30a3k/wSIFCovJSXWbt0cIrIzhlpwZ931
         tJaByLydJVIVY+BKcOUq8s6+fj9n0834o2Bi3FYA9irN0QO+vI0xrI5fynCuzDpDamvq
         oopY+mqSL4L9+mG/itQXYj1kHBAcvJSUHELc2Of2QCacfx2c2flbfiQ3hXCU8XMq48pz
         jSTeOcC6lFPsbdCtzo5cpB81KGAdI9z+80YSX/iCpGLHJ9702rZejcPeLyOfI4TpbYIu
         FS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476296; x=1790081096;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BBB9G5hK0Apskt/iqfXGmW1kt8sDxofyVux5eGTzUqs=;
        b=xP9dZ+xYiRWdZgbuKWKlZ8hyGZs07rOJynJwNun7deKBDvSvaVbnjCVBEN+jJeIIVB
         JOzWXT06rsDQDR6LTFygYaH9CPM88Gq+t5exN28G3k/WFxHMS4DBnQp91xxz9+95CT7o
         UwpMBllJRT9yDUV/ZE5A8pAmpCx+fOqIMH4iF1nWe7rRm7ACDaBnvA7vLD69qi7KpojW
         craFe5tU4jLJXzN9Ke0kQoTZ8CaXNOijaLzZqeIQPiA1cq/UWoa/Yvz9+iqs/AXpKJpf
         KuA6Tm9Bu+U2eMhYIAAhymeElNVn8m4SjzKhREHKeVdny5zR8OXz24HB7vDzv7AHrbbr
         ngGg==
X-Forwarded-Encrypted: i=1; AKwUvBzX8M0vuPRtr4i7FMVXMc8+4zh4vf09mD62ZrdyybJ+9APa3Ka2Vgiz3schaJiN2DOrin63NRAHmw==@vger.kernel.org
X-Gm-Message-State: AFuF++nHcaLNxwyUEQ7rWie9kpn8ogVRWgHT8xcqFL/jqk7N+ykZHEL/
	2MtvVpJfFXsgTCZYQQRmizIE+GdXMdqOo1dWD2yTv18Dqa4R3WS3Lld69z68/AeVK5RDjFlOMMo
	ro4nB2z3H+pPEjHJawdWz1Ba9Fhb4aXTq5yBR7kyTquAWLaedqlmiS59NIhMuhQ==
X-Gm-Gg: AYBFou3o/J/cv3jQp2sDvT4hKxR6kaikkJR0VjmrSvHarKKX18V6PH01mCwDNJZi0ye
	HC053NJkL2JIDrXUJwxFAKGLy6N2Qzj+mZQizv2AebNJ1SZcMj2CEs8YldvGvr5D3EXh4LQSmhP
	VSW2ZL4Ls3dEJZlszOG7TKKoIe7/Q2vWJe3pwyHfFOe54QX/qAGTUNb3brxfw57+2aPcZALvWct
	QYx91RFtZNrMpjU3YsDmX/jLzgQVGdN16+8qjXBBjf2IwUnsPUSm3y0geYNJPF1V5PNe+AEIbXf
	PR27rDcjSYcdRYxX1l8dt/D132ga3Y9sqAGHOYj2IzU0/Rorw41HJKZk2rSS1YXh5mLnP9Rk7Ri
	2wa9ZYpw=
X-Received: by 2002:a05:620a:43a1:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93a297c964cmr979623785a.4.1789476295920;
        Tue, 15 Sep 2026 05:44:55 -0700 (PDT)
X-Received: by 2002:a05:620a:43a1:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93a297c964cmr979614785a.4.1789476294993;
        Tue, 15 Sep 2026 05:44:54 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d284a7bsm144637485e9.3.2026.09.15.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:44:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:44:50 +0300
Subject: [PATCH] Revert "interconnect: qcom: x1e80100: enable QoS
 configuration"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-icc-qcom-x1e80100-revert-qos-enabling-v1-1-cc4ba943bd9d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAME9qWoC/yXNwQ6CMBCE4Vche3aTXQwEfRXjgdYR12grLRgSw
 rtb9fgd5p+VMpIh07FaKeFt2WIo0F1F/taHAWyXYqqlbuWgDZv3PPr45EXRiYpwmSFNPMbMCL1
 7WBgYjXQq2jq3B5XWK+Fqy+/ndP47z+4OP33jtG0fcz2O94kAAAA=
X-Change-ID: 20260915-icc-qcom-x1e80100-revert-qos-enabling-e5081016bb3e
To: Georgi Djakov <djakov@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, Marc Zyngier <maz@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=27754;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=977rc1EWISksdidwfBUtALBlv4loh7402R0pOF2uUq0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqqT3Eu1MzN2Oe53il8+AmBkn4nls8fGn+/AhVA
 sn8UJHmz8WJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaqk9xAAKCRAbX0TJAJUV
 VprDD/0fXEAncqECytyorRfHnVFKW34I5a/p7mBWFSsIdDAQlBZaaPKXCZp/q4V3/5EYE+l/UWX
 8yYoYwNtT68Or/3EFLA6zFsAGzE03a5mQKHd2ZRCwMZEDJxXwRvRPQujGLXW3uG2RdeeR+WJqYl
 u1xzISgsCIKcbAJJtDCxQ7viO7sEXMzVVmvsuvdAIiEg+xq1/9wcW9hBoY30sXPH0ghRO7yp6P8
 2dqWcNhnIdBHR7aIHlXY1HAWA4l4NUCV0KczCyGOu2eA+nELYK/5orDwTXLkrJdh/MCCj1fxKcm
 7FN4TUDZvPp4BF6vZNoJvYPoLZSk9Z4xWi5/FA8GhDU04Uaqw7cia35zIQT+qZq3cJbIckjOVkV
 yhDLFOhgNz6dKm6V/2eT/zecXBAGlI/01PT/o97iQ7yzZGSPwR4ul6UYPEg36jIan8rFfBMsI7K
 4gQz51cOjEuOk7tUqP8xzvPam2b2LSqDMWqqIaIOnqrscza3qBIeKeEbplw1jlvd83UlCYg8PbH
 fISeRTQTwRyF44SDyJvHOrtejoJAFeJ1rVOS0F9XJcFEOfI5nUA66RVKYd0ADS9zi3i72UPS5mS
 1RyCVTM+7R/z/UXv0WCqT0A5HkquL5NqDOwrx3BPckaQEpZSsLynG+3Zbgbf5Iav3OpJRdnrT/o
 PKO4b4TwrCiuC0A==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: F3VErFLq3_NgUiFerd_dZSww3PyrYpCX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4NSBTYWx0ZWRfX3xFMY5uENWC8
 WZikq6ynA6Pc7tXN7hIwmVHfyJ4m48lYby30dhdp1ZEZWFSNKYNQE0yL5PTm39sG5qXRLaTZZik
 1717vivDAb9/LlddJEFe6h/qLAGO4jg=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa93dc9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=Y0YJaGJQxN7WziX6K-UA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4NSBTYWx0ZWRfX3ak7ioPh7Czu
 lD3pJNkF0Jt32xFKNYfDSknmP1B/CaHOjBW/csne1hKDqyVNwrW3LjLBsm8QIs8zQNBCgEVicZK
 dNezZVq3/pFqx+tMAdGdQQ/vwkNa1laNtHabhDEqCBK+W5wBE4+QygFlMR1wDy5Dz7Knx+/KqOq
 NRIUeykZ8WiZh7DvjEsNguDMjjTyM1KefMmRQ+tgAaLrBwHUdKe4UfPY0MSfAccHcyhHvozLG66
 TJHm4AmRFBaM3gGC2cS4VosAAPbVNnLI5Ux0zrE2pgQPHa2J7oCnvIst94WyIehM2N+QX65dlD6
 zIz1GcP38cBkEBogd1k4NIHDFNtUdUYIDdeJXDnq4Fj8q8IckhfnV63NPvZykpmo1aa98g3a9vj
 FrNp+TBlPyoYYGsKlI0DrmOg80pZet5KaZiO33bdl71GEH2wg4cppWQz5hd9NQL+wVtTyPZtmE0
 u210QiOwBqViP9ov6CQ==
X-Proofpoint-GUID: F3VErFLq3_NgUiFerd_dZSww3PyrYpCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150185

This reverts commit 5a8b2cc36e796d595c9d97eab23c2be22805cc1c.

Some Hamoa- and Purwa-based machines fail to boot after this change.
Attempts to resolve the issue have not been successful, so revert the
change for now.

Reported-by: Mostafa Saleh <smostafa@google.com>
Link: https://lore.kernel.org/all/apgeBNSiP01YfNcs@google.com/
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/interconnect/qcom/x1e80100.c | 485 -----------------------------------
 1 file changed, 485 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 8075e0ff2059..2ba2823c7860 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -173,13 +173,6 @@ static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
 	.channels = 1,
 	.buswidth = 4,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xb000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -188,13 +181,6 @@ static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
 	.channels = 1,
 	.buswidth = 4,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xc000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -203,13 +189,6 @@ static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xd000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -218,13 +197,6 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xe000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -233,13 +205,6 @@ static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
 	.channels = 1,
 	.buswidth = 4,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x16000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -248,13 +213,6 @@ static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
 	.channels = 1,
 	.buswidth = 4,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x11000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -263,13 +221,6 @@ static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x12000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -286,13 +237,6 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x13000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -301,13 +245,6 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x14000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -316,13 +253,6 @@ static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x15000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -407,13 +337,6 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x271000 },
-		.prio = 1,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -422,13 +345,6 @@ static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x27d000 },
-		.prio = 3,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -437,13 +353,6 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x273000 },
-		.prio = 6,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -461,13 +370,6 @@ static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.channels = 4,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 4,
-		.port_offsets = { 0x51000, 0x58000, 0xd1000, 0xd8000 },
-		.prio = 0,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -476,13 +378,6 @@ static struct qcom_icc_node qnm_lpass = {
 	.name = "qnm_lpass",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x275000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 3,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 			&qns_pcie },
@@ -492,13 +387,6 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x53000, 0xd3000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -507,13 +395,6 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x55000, 0xd5000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -522,13 +403,6 @@ static struct qcom_icc_node qnm_nsp_noc = {
 	.name = "qnm_nsp_noc",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x57000, 0xd7000 },
-		.prio = 0,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 3,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 			&qns_pcie },
@@ -538,13 +412,6 @@ static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
 	.channels = 1,
 	.buswidth = 64,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x277000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -553,13 +420,6 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.channels = 1,
 	.buswidth = 64,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x27b000 },
-		.prio = 2,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 3,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 			&qns_pcie },
@@ -569,13 +429,6 @@ static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x27f000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
@@ -616,13 +469,6 @@ static struct qcom_icc_node qnm_av1_enc = {
 	.name = "qnm_av1_enc",
 	.channels = 1,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x2f000 },
-		.prio = 4,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -631,13 +477,6 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x28000, 0x29000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -646,13 +485,6 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x2a000 },
-		.prio = 4,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -661,13 +493,6 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x2b000, 0x2c000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -676,13 +501,6 @@ static struct qcom_icc_node qnm_eva = {
 	.name = "qnm_eva",
 	.channels = 1,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x33000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -691,13 +509,6 @@ static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x2d000, 0x2e000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -706,13 +517,6 @@ static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
 	.channels = 2,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 2,
-		.port_offsets = { 0x30000, 0x31000 },
-		.prio = 0,
-		.urg_fwd = 1,
-		.prio_fwd_disable = 0,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -721,13 +525,6 @@ static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x32000 },
-		.prio = 4,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -736,13 +533,6 @@ static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x34000 },
-		.prio = 4,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -783,13 +573,6 @@ static struct qcom_icc_node xm_pcie_3 = {
 	.name = "xm_pcie_3",
 	.channels = 1,
 	.buswidth = 64,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x7000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_north_gem_noc },
 };
@@ -798,13 +581,6 @@ static struct qcom_icc_node xm_pcie_4 = {
 	.name = "xm_pcie_4",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x8000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_north_gem_noc },
 };
@@ -813,13 +589,6 @@ static struct qcom_icc_node xm_pcie_5 = {
 	.name = "xm_pcie_5",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x9000 },
-		.prio = 3,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_north_gem_noc },
 };
@@ -828,13 +597,6 @@ static struct qcom_icc_node xm_pcie_0 = {
 	.name = "xm_pcie_0",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x9000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_south_gem_noc },
 };
@@ -843,13 +605,6 @@ static struct qcom_icc_node xm_pcie_1 = {
 	.name = "xm_pcie_1",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xa000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_south_gem_noc },
 };
@@ -858,13 +613,6 @@ static struct qcom_icc_node xm_pcie_2 = {
 	.name = "xm_pcie_2",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xb000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_south_gem_noc },
 };
@@ -873,13 +621,6 @@ static struct qcom_icc_node xm_pcie_6a = {
 	.name = "xm_pcie_6a",
 	.channels = 1,
 	.buswidth = 32,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xc000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_south_gem_noc },
 };
@@ -888,13 +629,6 @@ static struct qcom_icc_node xm_pcie_6b = {
 	.name = "xm_pcie_6b",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xd000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_south_gem_noc },
 };
@@ -919,13 +653,6 @@ static struct qcom_icc_node qnm_gic = {
 	.name = "qnm_gic",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x1c000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_gemnoc_sf },
 };
@@ -958,13 +685,6 @@ static struct qcom_icc_node xm_usb2_0 = {
 	.name = "xm_usb2_0",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x6000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_north_snoc },
 };
@@ -973,13 +693,6 @@ static struct qcom_icc_node xm_usb3_mp = {
 	.name = "xm_usb3_mp",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0x7000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_north_snoc },
 };
@@ -988,13 +701,6 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xa000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
@@ -1003,13 +709,6 @@ static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xb000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
@@ -1018,13 +717,6 @@ static struct qcom_icc_node xm_usb3_2 = {
 	.name = "xm_usb3_2",
 	.channels = 1,
 	.buswidth = 8,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xc000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
@@ -1033,13 +725,6 @@ static struct qcom_icc_node xm_usb4_0 = {
 	.name = "xm_usb4_0",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xd000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
@@ -1048,13 +733,6 @@ static struct qcom_icc_node xm_usb4_1 = {
 	.name = "xm_usb4_1",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xe000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
@@ -1063,13 +741,6 @@ static struct qcom_icc_node xm_usb4_2 = {
 	.name = "xm_usb4_2",
 	.channels = 1,
 	.buswidth = 16,
-	.qosbox = &(const struct qcom_icc_qosbox) {
-		.num_ports = 1,
-		.port_offsets = { 0xf000 },
-		.prio = 2,
-		.urg_fwd = 0,
-		.prio_fwd_disable = 1,
-	},
 	.num_links = 1,
 	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
@@ -1795,21 +1466,11 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
 };
 
-static const struct regmap_config x1e80100_aggre1_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x14400,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_aggre1_noc = {
-	.config = &x1e80100_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
-	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1827,16 +1488,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
 };
 
-static const struct regmap_config x1e80100_aggre2_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x1c400,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_aggre2_noc = {
-	.config = &x1e80100_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1921,16 +1573,7 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static const struct regmap_config x1e80100_cnoc_cfg_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x6600,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_cnoc_cfg = {
-	.config = &x1e80100_cnoc_cfg_regmap_config,
 	.nodes = cnoc_cfg_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
 	.bcms = cnoc_cfg_bcms,
@@ -1960,16 +1603,7 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 	[SLAVE_PCIE_6B] = &xs_pcie_6b,
 };
 
-static const struct regmap_config x1e80100_cnoc_main_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x14400,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_cnoc_main = {
-	.config = &x1e80100_cnoc_main_regmap_config,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1999,16 +1633,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
 };
 
-static const struct regmap_config x1e80100_gem_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x311200,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_gem_noc = {
-	.config = &x1e80100_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -2023,16 +1648,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
 };
 
-static const struct regmap_config x1e80100_lpass_ag_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0xe080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_lpass_ag_noc = {
-	.config = &x1e80100_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -2048,16 +1664,7 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
 };
 
-static const struct regmap_config x1e80100_lpass_lpiaon_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x19080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_lpass_lpiaon_noc = {
-	.config = &x1e80100_lpass_lpiaon_noc_regmap_config,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -2072,16 +1679,7 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
 };
 
-static const struct regmap_config x1e80100_lpass_lpicx_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x3a200,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
-	.config = &x1e80100_lpass_lpicx_noc_regmap_config,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 	.bcms = lpass_lpicx_noc_bcms,
@@ -2126,16 +1724,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
-static const struct regmap_config x1e80100_mmss_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x5b800,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_mmss_noc = {
-	.config = &x1e80100_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -2151,16 +1740,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
 };
 
-static const struct regmap_config x1e80100_nsp_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0xe080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_nsp_noc = {
-	.config = &x1e80100_nsp_noc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -2177,16 +1757,7 @@ static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
 	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
 };
 
-static const struct regmap_config x1e80100_pcie_center_anoc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x7000,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
-	.config = &x1e80100_pcie_center_anoc_regmap_config,
 	.nodes = pcie_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_center_anoc_nodes),
 	.bcms = pcie_center_anoc_bcms,
@@ -2203,16 +1774,7 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
 	[SLAVE_PCIE_NORTH] = &qns_pcie_north_gem_noc,
 };
 
-static const struct regmap_config x1e80100_pcie_north_anoc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x9080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
-	.config = &x1e80100_pcie_north_anoc_regmap_config,
 	.nodes = pcie_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_north_anoc_nodes),
 	.bcms = pcie_north_anoc_bcms,
@@ -2231,16 +1793,7 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
 	[SLAVE_PCIE_SOUTH] = &qns_pcie_south_gem_noc,
 };
 
-static const struct regmap_config x1e80100_pcie_south_anoc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0xd080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
-	.config = &x1e80100_pcie_south_anoc_regmap_config,
 	.nodes = pcie_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_south_anoc_nodes),
 	.bcms = pcie_south_anoc_bcms,
@@ -2262,16 +1815,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
 };
 
-static const struct regmap_config x1e80100_system_noc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x1c080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_system_noc = {
-	.config = &x1e80100_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
@@ -2287,16 +1831,7 @@ static struct qcom_icc_node * const usb_center_anoc_nodes[] = {
 	[SLAVE_USB_NOC_SNOC] = &qns_aggre_usb_snoc,
 };
 
-static const struct regmap_config x1e80100_usb_center_anoc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x8800,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
-	.config = &x1e80100_usb_center_anoc_regmap_config,
 	.nodes = usb_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_center_anoc_nodes),
 	.bcms = usb_center_anoc_bcms,
@@ -2312,21 +1847,11 @@ static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
 	[SLAVE_AGGRE_USB_NORTH] = &qns_aggre_usb_north_snoc,
 };
 
-static const struct regmap_config x1e80100_usb_north_anoc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x7080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
-	.config = &x1e80100_usb_north_anoc_regmap_config,
 	.nodes = usb_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_north_anoc_nodes),
 	.bcms = usb_north_anoc_bcms,
 	.num_bcms = ARRAY_SIZE(usb_north_anoc_bcms),
-	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const usb_south_anoc_bcms[] = {
@@ -2342,21 +1867,11 @@ static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
 	[SLAVE_AGGRE_USB_SOUTH] = &qns_aggre_usb_south_snoc,
 };
 
-static const struct regmap_config x1e80100_usb_south_anoc_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0xf080,
-	.fast_io = true,
-};
-
 static const struct qcom_icc_desc x1e80100_usb_south_anoc = {
-	.config = &x1e80100_usb_south_anoc_regmap_config,
 	.nodes = usb_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_south_anoc_nodes),
 	.bcms = usb_south_anoc_bcms,
 	.num_bcms = ARRAY_SIZE(usb_south_anoc_bcms),
-	.qos_requires_clocks = true,
 };
 
 static const struct of_device_id qnoc_of_match[] = {

---
base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
change-id: 20260915-icc-qcom-x1e80100-revert-qos-enabling-e5081016bb3e

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

