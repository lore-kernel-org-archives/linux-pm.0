Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573087;
	b=GlyYHD44ScD1YD6NjcwMJgQF2u7PmNj5TUKPEsZMF3ZURWxdQ1cvbGJNirCyKCsA+/i9
	 mTt3oQTSRcm8LA/crfyUqvqWuMG76Xica2rJajPb4CpVTYdYjWHfNJB/P2awoIMvJ+eLI
	 qYH8RAlWaqQ4Ef3Eu8s8DjzSQ83hP5ewlE+t7UxQ6/ABckHr/0enQptXrI4NaCx9PgUbw
	 /VyeUhlpyDmvL++Go8KUeEvpRwkXQMxHIk5ujTdGroadfGYtAkkYj/Uob92Q2yZBQUHLz
	 1MLBQAUmMhVSPpsd3gCJz63FkcrYLIUULNqwruAAMoEElXcazABwH2RbvZWJ6XxXEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573087;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8ZFiJaYV0wG6Mf8urSzwz9QKuDKvIUO3FJOEVgQm81M=;
	b=o2k++Z1f+nAl5F39DTjoS4qCG/ndJHhruyryhBcUCCW08EQZ2FaJnfVO1snrxH6l+FMT
	 +xyS61janUrzV8+k8/fj3Jk0njV9UL4FvTznwZNZB6DEUSc6Qa5HrOS0HZr2G1idDMtcQ
	 n0TYIFCur5rCNLWF/T4p0suwO6fCLVgH0e9BaydwpIGugUwh1p4UldnY+c9RKsevYbkJQ
	 +plrjAYTAV+Pv3RoyNqNIWC36aEAxmhFRw7f/6b0odmU0SZRqXXO24Pq3zpavyajtPf8b
	 aIspmW+MgNXqK/BV+dJNKQn+zrPuZH5iUVeKFDq9ngFrT42/+U/c+j7Px1cb+8k1LZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CoR3xyfE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Btpq/Qni";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1E606A32F
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E1E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CoR3xyfE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Btpq/Qni
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j64H793374
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8ZFiJaYV0wG6Mf8urSzwz9QKuDKvIUO3FJO
	EVgQm81M=; b=CoR3xyfEu/ZkX8lBFWZsJc1CI1EhZQ9n1eGN2bLpbYsmOOso8mk
	TRtxnonqfH5tAsozA+q7oP52VLzCz/x1MSGscPLd91EeIJq5D0xz4+uxhz5EdITK
	ZeMCHK8f4/mLKOhzbsDEa6kymlWDAnsgbpORkACvj+6AjlKOhwd4hKy0Ee7dy/Br
	5HOMreQMKqx9d9+nhGhjkSX77JsTC30hM/lcAfELw0KszxdeDPBEprLcDmAKU11N
	4d0d+r4huzDHGXnT4QChxCQFdMOnlvjElkvhgR/6xLkCqwbDuQmbaGpNAu7qzD0Q
	tnm6CTmybe+c7BY53S6AuixLwsuGwdpIBZg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabk59h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:58:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ecdc701a2so60679185a.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792573085; x=1793177885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ZFiJaYV0wG6Mf8urSzwz9QKuDKvIUO3FJOEVgQm81M=;
        b=Btpq/QnidTLcffDDuN9vZ3iIlJtkYpb5OWffy6LG2WFYqGYstPkBf3HgjjFOJe6Tp9
         T0uJXtlytLsX9LK106hLbCjHaU7WmsbN0ya3fhINVyPIEEc3DSUaRFqpeIcRGylJCIS4
         KQU6X53P8Lh2KyVKKPSeaYQ8o+RHl5h0gNmLDkBENU0bqLkQ78oKx805CV+gNhxIsnfn
         DbPehWyoqqstkwUMaoXcMemv+BbRoi4Mp9K2CDfzH/qlEH3f43nXX/xMOnku9oZ4Wc7e
         /2wFGpmR2udxkidO3yO5fMAx6uzDPPydNniDFn6WqKiloN/mchyFZJ5/lA6ksuLOTMnM
         fsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573085; x=1793177885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZFiJaYV0wG6Mf8urSzwz9QKuDKvIUO3FJOEVgQm81M=;
        b=e15WQMLEXsmi4/YRR5wPwXedlcmc7BvATpbWpoltWWKam5RDWiEQP7rHd9muAxEFvx
         cQDcEni5aZA7i89eWn3g2YBuP4OvvzHMQXhYuKsLw93KaUKmPQmnALaOiC/+BiWkGGb2
         92A918f9FHKPpEAMfRA1mHLkLBFfX6+gp0uxv4nFoP5ktL/K/R0hETFYTd6+XyOe1ipV
         bhG0DgGd5QL1K9nag6Etji815R4X0Qjmhr76KNFLBS2P3t14m34MJMTUne1n3dHMIpKk
         2mdu7+T7CJB4L8Jh//MaEfKIEZoRiMd8ZyvQkRP4ghRUHOSEjDAPeo3wZNwiXsbRnV26
         DRuw==
X-Forwarded-Encrypted: i=1; AKwUvByeRjjn7/gs6R10RBB38DIVLxt+c5QrKyDOmb++d12Qr2aFhCfoxC3C7Z+jYvPyqeLWAze0UMEpeA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJytnYSnp6TcVEGsO0Fjtu+Q1pJGl4BSmflwRCK91nr0lV1STih
	yuqVE9whWayXhEXnLuxSEcfFBw5j4dl598HGR7zOKXDve1Ib8AepOnN5vSPFcs6oYAqTTPss3sw
	zy5h5Juun1NswMnHY4G0ZTX8oKGqnDGRgsA5Fsm38frMvjJdkugmhZxaYQgYjYQ==
X-Gm-Gg: AYBFou3GTg/QLsR2tndzwWGnmAgZsaEn7uOjSSSjhcKmRKzXJ1zUH1s0QAq9dnKrUXt
	C9nu8jevYps288uRq5yr32MKhvIBXz2MJK88Nmw+KSE+CJ6xvZq4ofWjrBs4gSZ40V3FHmdogKT
	62p+Y7U9YZuw2Mgp55NWFSWCgj28+6m9bAVq9WaksJlTD/DhoY2cMlG/9drXVPO/dp/hnd0nHFB
	QlU+3QSt8yZcZP2flAogQ4TPmNzBkV7TWT9oJovYbEyRSaUAw9dTrYzYOV3JjQyIIWA41AQxt37
	th1rE4ZtEHH8HWsRwMee0VYiGq/8WU815/8is0dBBj+L+rwD7FuU9Z6A3zg4dtzj2u4yZnzREmt
	jAIalC68PgevCa0l5/ip73xPUUw==
X-Received: by 2002:a05:620a:17ac:b0:93f:2cf4:e6dd with SMTP id af79cd13be357-93f57f935abmr306340485a.51.1792573084589;
        Wed, 21 Oct 2026 01:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:93f:2cf4:e6dd with SMTP id af79cd13be357-93f57f935abmr306336985a.51.1792573084055;
        Wed, 21 Oct 2026 01:58:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8d9e:b00d:491:1503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258424bcsm4058401f8f.55.2026.10.21.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:58:02 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com
Cc: andersson@kernel.org, Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
        linux-arm-msm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] thermal/drivers/qcom/tsens: Release parent resources on probe failure
Date: Wed, 21 Oct 2026 10:57:46 +0200
Message-ID: <20261021085749.3786101-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX8cWEk87CUHj2
 PVwgE8L6RSWNY1bCR4SEjEShYg3bGWJcGT1pAhbexp4SMJeXIovI2lX5YP0oXQJtaVNyvoTFYXQ
 EDDT0uqvn/V8f+q0V7LSFRQNZ6/3CT4=
X-Proofpoint-ORIG-GUID: A3XuIAWe8I0zi5uqf8qWnLPDtTZJ8nEM
X-Proofpoint-GUID: A3XuIAWe8I0zi5uqf8qWnLPDtTZJ8nEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfXx6n43wL0HiGw
 rNuNWMKwWdJGohKAot9UkDt5YOhKzrGkfx121Z6HfnnFPpSopbmpXHS91DJawDUI4lLXO29v9p9
 Axt4eDmhdPyyhFro7ZT85KEEjxzd+VNdhloqmMN9cQ06xCtzb9LFyZfXE3jWZE00Y5kix6gKVtU
 dCBRLMefncbHa6nBCdU9NLkhO2iJLkIQEsUYz80pzZ0m0R3Ts1M6lJVPwJiUX2Se9PqNNwW/1/y
 Fzn0ps2S5hR7Kux1hBMb+3eDFVnORy5Ny/XMTAb0G1+P2SYhW06P+ybjJTTgURGNghnCVYJJw3d
 C2MP58jg5mgexBYJhSbHUey3B44fQrUrlbgFTsq10Op+JTCBSSoyjOvzCkQ20hYYFkcYjNj1Eeq
 pik5zdn7tw3KqMfcCo07EyDCXlc2rfIcLS6lCp/UB0ekUhLaaK5UjSaS+mRgWgLBVXqnDLMT2DZ
 o7GwLiIXxLDpSYf1X4w==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad87e9e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8
 a=uMi6mabLCCkMMC-zsVUA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210035

On legacy MSM8960/APQ8064 device trees without a separate TSENS child
node, the Global Clock Controller (GCC) driver creates a qcom-tsens
platform device without an OF node. TSENS consequently uses the parent
device for firmware lookups and managed resource allocations.

If probing fails, including calibration returning -EPROBE_DEFER, the
driver core releases only the child device's managed resources.
Allocations attached to the parent remain, accumulating across repeated
probe attempts.

Wrap the parent-bound allocations in a devres group and register a
cleanup action on the TSENS child. This releases the resources on probe
failure and unbind while preserving legacy firmware lookups. Keep the
group handling in a probe wrapper so the existing initialization path
remains self-contained.

Fixes: 9066073c6c27 ("thermal: qcom: tsens: Add a skeletal TSENS drivers")
Closes: https://sashiko.dev/#/bug/linux-7dc6dad0-c471-47ca-b493-8402752cf13a
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b5ec70201e2f..4f69ce4976d9 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1374,7 +1374,7 @@ static int tsens_register(struct tsens_priv *priv)
 	return ret;
 }
 
-static int tsens_probe(struct platform_device *pdev)
+static int tsens_probe_common(struct platform_device *pdev)
 {
 	int ret, i;
 	struct device *dev;
@@ -1452,6 +1452,41 @@ static int tsens_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void tsens_release_resources(void *data)
+{
+	struct device *dev = data;
+
+	devres_release_group(dev->parent, dev);
+}
+
+static int tsens_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/*
+	 * DT-backed devices own their managed resources directly. Legacy devices
+	 * created by the Global Clock Controller (GCC) driver have no OF node and
+	 * use the parent's firmware data and managed resources instead. Group
+	 * those resources so the child releases them on probe failure or unbind.
+	 */
+	if (dev->of_node)
+		return tsens_probe_common(pdev);
+
+	/* Tie resources allocated on the parent to the TSENS lifetime. */
+	if (!devres_open_group(dev->parent, dev, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(dev, tsens_release_resources, dev);
+	if (ret)
+		return ret;
+
+	ret = tsens_probe_common(pdev);
+	devres_close_group(dev->parent, dev);
+
+	return ret;
+}
+
 static void tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
-- 
2.43.0

