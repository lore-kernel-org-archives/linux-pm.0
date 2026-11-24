Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517640;
	b=bAccuY/VbYxJdLHS/0k95nSOcF/HUEAjFQ+kyrCli7Dv60HnVvdtzfOYtBFHGSmzJn0W
	 9lMl6hGe6eQ5th7I9saZ4kNz71W007A+Heli1lEry5g8jdo0/s4K0qYk7jkqXUh2QjCCX
	 YDdU78mTTHa9EJWAd2rWCct9+nBdwKIBa5T1xuT6Nv9FysMq8tAEqZ8rEek6wk5N4VjpY
	 zU4UuEQekeZ/pmjz0OOctChgLuYeVT/d5Wja90fYTGkoiZSYnB7VrtnCLuY02FEX1hqR2
	 /2RP49lDACeTV6EKOfYezpgWihQnmq9EblhORkzdW5m/lUBHsiMoKS+wZOYFKjtujGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517640;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ogWxQ2xxIGHDPlXg+kfuqpwZhrR4bqe8TvXeM9trYbs=;
	b=s/bh8cAnHSdb7MCid2JsKsqSKapIbc7vqTQxGas69msV6axg+9IHWNDs8vTyUamZuv0X
	 /nboaCfNSxjmfY3lrGykiKJuYj3xc2/oLkAeQpxFiGR9+vSP7FcMzIa3FkdRkISexxCYj
	 N6IEZFNfxqVnwZlYCJBvr+dvLplucXhZIVggovqkDWqtQFVQC9fqWIQsSwyIYwr87J0L1
	 yk1zgJGNEfuLk8zDTS8etpJegbhnopoIn5EDTHhMfdUCPiwWmX0HSNK7eabjmswu8nXoT
	 KeBnS+PaU2ZOetfEJldKBopv4pfD9IKD/idFCGy28hNJVmpls2hU6yAhjU4W1HtEhUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HY9GENZp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWV+PsMk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11579606A332
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11579606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HY9GENZp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWV+PsMk
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8roiN1598148
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ogWxQ2xxIGHDPlXg+kfuqpwZhrR4bqe8TvX
	eM9trYbs=; b=HY9GENZpfyOEm1s+M0PgkFPKbE9Sp3wS5UzTT6TSh3wgMdPB7YM
	RKWyXR2NXR5A4AZJpS1sNhSUYD2YVOzfqBKhYL5pmr/f48N6lMNZzp93rP9evGJT
	cKYQMys67t8w5gxjIVcpCUu73SGTArJVQdESfDJrHpmLjGEWebKSyB3hNrQNO0Id
	GIKt6VRdUhtDu150wbSbmsLG0d4YxJM9NfIjyheO/Z4CJdpcMfAUyPt36So4mda4
	7vvCGs58LmalL7SjzcNAqJnqQ5ZYzIKUbBiwdLA6WTe1XEp9BDsdavOgqdjKGW3K
	dq7AW06CCwhagdx9Ep3HzNkFhst7DYxGSrg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukqk803-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:53:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386177b0516so11619338eec.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795517638; x=1796122438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ogWxQ2xxIGHDPlXg+kfuqpwZhrR4bqe8TvXeM9trYbs=;
        b=AWV+PsMk4Ps5mPZ5xfEZ6nolvYNhtukoVqCIK6fFnmQvLX+I4s0Do/KB0v1NpSeEDa
         qvcqac/tyw8ZmzWl7F0IWnSA1y9FKmYG2YpnsWtttwLKWO3Pj3Bv4peKBuikBahiDZld
         iNvSudURfJs1KSeByC02flwOG/Z4qBIniXK4tiDGyvoeHxEm/g81RDPJk2SzOqaX0IXg
         g3TYIoAnc1T43lS+ZUg2GGi8W+YLJzKQxsxlMR/I5CCyQYGPSZ5ctmXKNzWXUJ16DLOB
         uC7jWL+rufnAXXpgfgFNliD8RDUJyrIhfkH2HQR+gM6GmqHEYGq4SYXITyp9NyxlejPr
         jDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517638; x=1796122438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ogWxQ2xxIGHDPlXg+kfuqpwZhrR4bqe8TvXeM9trYbs=;
        b=0YoaIMMQosH92wxKTPULVVGcjZiufnWOXCEfeFsGFlWomfAbEd7a7Fgh8ubUsQthdk
         z5Mz9ySljNzAPQigynFODtUaXrzgh/UNlN+bKaUABuP4AvmGzotar9pzlteAiQzJ9l6c
         3zZjXMya8OYVSL7qGGgfl0RGjPSGPxwo/BwA/37GUh/lCuvJ6rzPOjo4mGpFOq7y/orA
         MtodiUb5vnHYlGsya5wT2r7eZ3tAANP1h9jAoWDXGRvzMbZdLPsb9KRJQW9/7GXjVTtA
         M5g6IKRB0BIYZXeumth4sWYCtZeTOzOsl6ujLNO0TG6ILXmmT/cZ35hCtXDW1907yfhA
         rong==
X-Forwarded-Encrypted: i=1; AL+hErEsajkuVkmKBoUGnrx5hnbRseXoM5w5il/bO4oZR9txXCdoiMxk0xY5Dzi8cBapjHnIBxdlCVBGqA==@vger.kernel.org
X-Gm-Message-State: APuU4Z90V/pUCPFGfW0m/v0Byslk8KZcYJPblC6E8BVgJnmR3JOa3iHc
	nobCM86T757aTIsfsJdo2GgtOd9/Iq8eH19mar1tVXR45ztYtzSK17uj4en3z8kVZ93fPWO0p42
	BDq6xaSyuUs3kWIGeQkLQBZZkDGg0tFeTO2xmR2JVoC07UwYL2nX0z1cu2s1BVA==
X-Gm-Gg: AZFdTZdVsARdx29Y4/fRRtoh7Id4SXFKIOA1ay+fDvRfAzaJ36a0sYIBQTZI9iuFfeL
	TdSHihmYR/yLOmnLCHT35d47iRYaFsWPA4Bb3AlmFlUVL4LiDsf6bSDrq+L5uYAtdv8lJenLX3l
	iGjISo4eTE3nPHmJpfx2Rl3ushNdmmrE85JHdX2GnlP1kA7TgGgVX6TFDbxU4DE3fo74WaP/mBe
	qMiaQ+/23RmNMzXfTrPu9q08v/RKv/tQhEaXkv/FlOLPZeU7NqX1L/a3cmPPdkQzsBF5q7xZPYs
	rjLBDyYu4ghTkwOSxRE+cehY0bCINLDk+3NqG/Cs8X6c8/fmNJnPGg9O4PWddRXSuvxO0Duewit
	IY/wEKkmudws6HCp2DS+D1o2DfhRIhZZk+J6rR8PGDP5VC3ipeSDQJArq58OMIyIU9drnWec7ao
	ly5Le2cCa85U3G6JhlWrihSIli0ZWCYI5/ysKqrnXsmlWLq0viSg71c1o=
X-Received: by 2002:a05:693c:20ce:20b0:37a:a9db:6bd2 with SMTP id 5a478bee46e88-3856e63b064mr16005452eec.11.1795517637486;
        Tue, 24 Nov 2026 02:53:57 -0800 (PST)
X-Received: by 2002:a05:693c:20ce:20b0:37a:a9db:6bd2 with SMTP id 5a478bee46e88-3856e63b064mr16005427eec.11.1795517636854;
        Tue, 24 Nov 2026 02:53:56 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm53796353eec.11.2026.11.24.02.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:53:56 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Add Seca TSENS compatible
Date: Tue, 24 Nov 2026 16:23:50 +0530
Message-ID: <2d8b5fdcdff1f5d0df738d84773b0ed54159eee0.1795517630.git.yadu.mg@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Wu++otfv c=1 sm=1 tr=0 ts=6b056cc6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=lHObh2IfMKzVuqTG74EA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX/n9GLUuCTS4s
 DOTm6oFHcLChqwOxZqyNDe9TH9G3FJEvjtJoknXpZ/VKMB/sde2SAREwQcA7DIh4FhfJmje0oe7
 LvvvcKWNJ0/fywRWaewW3mNyAkDB9RdligASQXxDMbJ4ak0t0FYVZBOEbz7eiYC91hS/et4jUfa
 dZ9TxW2h1vNaWIJt9tVm2zGCCBSnPFgP7W2wM6urw+9gRiVNdyK6ZVn6wOqknK1fNyUL3wzE1Ed
 hbM3LPPmJRS1ls2UWb1EMHRWWsc2pq/EYH7jrFfhgEy91ZMU9mXbgmWoDzKcLkH23zxl012Pb+S
 ns8zPxQUB8PLewEfw2bw3Bxy8Qio0KSEyG7XWfpicJbl152bxe6DPMRQj7+P5BEo9PczTcOUqSn
 THQ9A5JJ7gJ6L+DEyL13KSFUkbl0DMWUa8+8hoyoOktO7xSh6IUwAE04JMMfSH+bp5iG7i8NNKq
 wHBal+xPH/Z7SKAzkKw==
X-Proofpoint-GUID: 34zFhJIQM1IvRQiWDnjUcuwhm9yVjRBT
X-Proofpoint-ORIG-GUID: 34zFhJIQM1IvRQiWDnjUcuwhm9yVjRBT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX++JPqugjDxBa
 aaZurDRuRxjJ6RzNYHefZLuzGma/NWb6rpaveW4vA+HccdrI+BXAR1PZm8es+U++Gen3ZY82FQP
 tykKWCMQir5szh1++VQAADnNMsJJqc0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240042

Add qcom,seca-tsens compatible string for the temperature sensor
in Qualcomm Seca SoC.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
The Seca SoC device tree using this compatible will be posted as a
separate series.

This series was prepared with help from an AI coding assistant
(Claude). It assisted with review on the device tree, bindings and
driver (formatting and alignment fixes), rewording commit messages,
and running the validation steps (checkpatch, dt_binding_check,
dtbs_check and W=1 builds). All changes were reviewed and tested on the
Seca Ride board.
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index c78074fbcecf..a96f51feec87 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -78,6 +78,7 @@ properties:
               - qcom,sdm630-tsens
               - qcom,sdm670-tsens
               - qcom,sdm845-tsens
+              - qcom,seca-tsens
               - qcom,shikra-tsens
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

