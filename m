Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F773AAF4C
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260468; cv=none; b=P+nyOhcNRwkv7ElfX+Qg212XftrWmVy45ejPRfEY2WmaYyxjDW4/YVU0m05mJPwY/LAzTK0uD5GK7aHl7Qt5+71h3shqh0OPKUwaY+mH+rqToc+qPMj2QP42ArsMgzb0nG9EcHuhaX/In6GO4u0F1LvEkggTHV7Tds1NEEa9hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260468; c=relaxed/simple;
	bh=j7kvLZyfBPOCqjXC+BDepJVgM7m3/VcCTgkhkXmjsMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0rhWNA/rg7adL2nKpzwhnN5OCWOZhOpT6XehaJkU8NG8sizkyF16aa6T8LrIui/DR9i4rOcfd4kjoWTnvhBBq12RMpYZ1oPMKdSq0nTxFjloSqQ2ejR69kAR3UcFw3isTX8TnR/1YUqaMFkwSOz/kvuPZdtviiNGKGbsvUGUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZ0Z/Ucf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GPABi+Qj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZ0Z/Ucf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GPABi+Qj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67960O461897126
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0tPicA3rc3no0t8b09/hiQO/EbRITwV69iZQgGvLo/I=; b=fZ0Z/UcfLTkIVHFP
	Z01Vb1RRQggdzXWOz7qeF+0sJdNQjpfKuQOhhOCmhyVk5KsISNgOzgjX/zK02lhD
	/WuSf9SbWULCYNjPyMSOvmoqva8stW82AdzEksgB6fZdtDgYKHrm+5sslcWoba/D
	RLCA1y7EnNTQl/M/j6B3gr1TqdanydlGiKeI8uLU8T5kSRta1/GqtDSQx6HVDkZ5
	z5jW+dIQCpldl5JJ7jpmTOVMCpoM37PynbznB8L3DoCn1MU3r/jC/K/cCqAF039A
	lgLcEUKb8eJ5LdEhoFMR1HZnZTruv0FGPXRQbddi/rs+KDqyhXIVBbR5uPZjLkUc
	DFgNWg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush2j38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:27:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso708013a12.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260465; x=1786865265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tPicA3rc3no0t8b09/hiQO/EbRITwV69iZQgGvLo/I=;
        b=GPABi+QjGxPBKvzjSegKv+BfVVFPX18mfR3wgzBWULB4Rw0xmP3LeUvp18QKNBlBrD
         AgCGU8hO4Xq+j7C25Rs50gnC1ycKz5KP7G/uYJR/e9RO/4ntKiXOBK3C0EdfOFRKvbPh
         fSfsgnwY1xlmXR0BPO07/61Pi5Q3S97X73eIn5CaK4wkAH6NxUM1egiaI/cJnPso4bAw
         IlBtKUkaJSWGghlZ/tvpqCYB8NGeoMsnPDx/85dm201uTx90WUPTy7yhMNC+yzxmGu2o
         NhIfjiySWxJmXaJIgZTlFIf3ed7CY14jLsR41pzEFTjInjBEMEqM/HJIK0IppgUZvPq0
         LF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260465; x=1786865265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0tPicA3rc3no0t8b09/hiQO/EbRITwV69iZQgGvLo/I=;
        b=ktVs/RafkfBzcsx5cBSHNpD1nIiglGJLE33iSZ0n1Kq9cTTYAcDguIg+BHg6z0FYBJ
         h1jYU++3CoExM+OHQ+JqCtTSilBqc2nNsrvJxsS7XKHK98kjJcRUY7rp0se1D5q35aui
         3b3Tsd6C76XoAFQUr8He4BDIcovqmGZRQzGFMEeP7Q89cJB1OnaQm7l1u+FzJhyS7008
         A5bI97mcOdx6un14ST8cJnndy26TxAYbNtuyELzH983TEq3ocTXB/hguDVbskN/3df6A
         P8s5OpEgTL7eTVr9H3JMxaGvz7J5h89ymyI6EoFXvIMvzSIHkwmUgWbSAATYPpmpx1ly
         Y2BQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfICyKdaez15ux1N34b69mkAgQmd232osAW9pEkJaQzMNZeQwBh8pSXD4STUzIV30SXIinJNAUQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytadZq7LuPpFuH8KjL5VBC22ZhoxKNidU9yYydakN3OKfHNo/i
	PIwvjE9H42B/I+FoA1rD1H26espeCWICpIfjxGf47ltAv6x4igkjfJ7tk6rmo00Ezv1DxMhonG3
	1AOrHKOpUZ2s17c7Qdg+qgkvpG8aaWMg/84mtZHgabYB/Pp1Hx7MDw9H6hqzaWQ==
X-Gm-Gg: AR+sD11a+aA0+apLFcmZQCELudmt2E9ykktidsAYQU6nDztIlRLniXHvM5VhuRGQuaL
	mDOcgudmaqZwpNYvDeMMNR+2XN3YFIkXwAlhEfnG0CInxTQgKErhKIpj1hb3MmwQOtPuNv6+XCD
	mMEYrHHlgDmSLGo5txyMtY9tBVNiU6qvUNYf4DvGnjOz3Orw6Y48QhQLFAQh6sS2wGXpG+RhUg8
	MrlaIXSqhB+2e6JwcS4u/PgJZ+B6k5bj0Gvd1MMH/PqTPJBReJVwhbFMVyp3jHZYH3vUy+/w0/n
	NKCaxPWkB7p6dL9z5LuCeWn8PuuysfID4vebzq36EaX+GwqFEW84mY0AUCBWOjU21nH8XMT+U1e
	uGSi/jgWx3cGGI2TohEgWP06N+8xTVu1bJHEtXmsQJ0zcNypxxigLva2TnurDiPUmxmUYx2ytg6
	4FPaX63Vv2vi3rqxU2F0khsnM=
X-Received: by 2002:a05:6a20:430b:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3cbce8d4439mr12430189637.17.1786260464858;
        Sun, 09 Aug 2026 00:27:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:430b:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3cbce8d4439mr12430159637.17.1786260464430;
        Sun, 09 Aug 2026 00:27:44 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:27:44 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:02 +0530
Subject: [PATCH 03/15] pmdomain: qcom: rpmhpd: Add power domains for Kuno
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-3-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=1687;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=j7kvLZyfBPOCqjXC+BDepJVgM7m3/VcCTgkhkXmjsMI=;
 b=PJ+/gjyRuoFT4vk1O5bPH2iIGC9vGJnxxXXzP3ik5u+BRgjGnzZJn+u58Zt/lAiEF4zMOjNoX
 wmv3Y4l50mDDBzfI2UpIlkwgpgrlB8Ef4csZu+m66sfF0Wik0BmIFau
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: Ka7laQsS0jCISVNywW2fvrdiFX58BtOt
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a782bf1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1FmER_HI0FvT1hCPThAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Ka7laQsS0jCISVNywW2fvrdiFX58BtOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX/tGcL3+hCUEk
 +VXAvrLfs+2rP+s1rUUnNod+V8HqSomNlQzhHG9mf73xM62sgt36M0+4usE+ldKaoM2WsrSfm+g
 8H4w8kbGpf0c7skICMAjWNuU0kAxrClQIExJfdXHBSZN39RhZvktLaYmPO3YjITAb825UPCBv1w
 wObGC3WUUIZeeuuzF6i69q6rW073rlnYgHObcGZJRCdo0J3WkdO3Lotfrai5iAUMTr0GnPQxqBP
 j7//fKZmzNPnRUzFwwhh2nqD7jK5/S4FSH5wQfcvM8F3Y3fMHSY0qHiPxN5ZK6d7klRX0CWFRYo
 kyYHzN9V+5kW+aCI6cZPWLeoVgbWAKpgCXv/4/2JVjZI+hgxkFlZdmTELqhQEOO8rPUWEnu2OiD
 gF8vK4tINPaITO2+7RwphRO67wos22x7GHW6qZ5NyOyRS9mN5hyMhPVvOJ3EH6+zCo5YVPRUjWU
 Blv9dSiVdLK+6koIREA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX/uatmf0pelEt
 iqYM3r2uO/0RMRKh9/dKNkCFWV1iUn6vM8zFIrBjyOXqb/nK+qWz3Oc9uOe1SIw1olbVdT3zDVx
 glqEeq+rWkAGDKjY09JLlFSIV6/O+Wg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

Add the RPMh power-domain data for the Qualcomm Kuno SoC to enable the
new qcom,kuno-rpmhpd compatible to expose RPMh power domains. Kuno
exposes CX, MX and MXC domains (including always-on variants).

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 90743275942d..725ce802f683 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -681,6 +681,21 @@ static const struct rpmhpd_desc kaanapali_desc = {
 	.num_pds = ARRAY_SIZE(kaanapali_rpmhpds),
 };
 
+/* Kuno RPMH power domains */
+static struct rpmhpd *kuno_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+};
+
+static const struct rpmhpd_desc kuno_desc = {
+	.rpmhpds = kuno_rpmhpds,
+	.num_pds = ARRAY_SIZE(kuno_rpmhpds),
+};
+
 /* Hawi RPMH powerdomains */
 static struct rpmhpd *hawi_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -885,6 +900,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,hawi-rpmhpd", .data = &hawi_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
+	{ .compatible = "qcom,kuno-rpmhpd", .data = &kuno_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,nord-rpmhpd", .data = &nord_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },

-- 
2.43.0

