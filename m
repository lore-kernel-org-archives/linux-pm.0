Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62251477E
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061739; cv=none; b=Pp3Bc+ey4+yKuPkWY4B+hO+7eDSoTzZ4R2StalEsyOQG71wumOUQHhoAqfRAAR1fxZHgnpgcqZC5Kq76OmNlUJSTibsvxU4HknpPHzdrwCNnShV3H7mGsMdiCnknTFfan3CujLiXRfgqIY7r52E7z7ajuz0ccrvfNbipwnBtv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061739; c=relaxed/simple;
	bh=Zuj0Mp5Z80P5Xe4Uv2Evzpt8jsUT1HsihC1ZLba1Ap8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gZ8HtS7PWRQ04FmDtsKZ9J+hpU2GJ3VjCRdnvMNMvqPNnClZSuWDfgtmghdzFKlqIUSejVT0Yruf3pvo3rP2C+qY/+9wKTZBXxCrEVWsjWBZkfZLvVG7CvfKiZoZPX/pliAvb8hbZc1PrDrl03V8uKBswlVV6ZaWhX84j6nBOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0C7Z0My; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kfcUbHUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0C7Z0My";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfcUbHUn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPuXM1596370
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JwyFlz/ChE0rMDIH1WU3Ms
	Q60a3WnORnoupBPMHI0Hk=; b=Z0C7Z0MyMyX8Q0oAR65iBflkULmBYpO2HVpLaR
	xHr/BSFLuyvIRn7UyyWhaT9JQsY6f33yD0dAmZoDuX4qwLbmMzuyGzer7ESxy3aq
	JSp2KcaV9oKBj5D4huMN4rpTZwJd/5PLqwtbUdM/ZY2psPotWktMtuhxNpB4hP6a
	/nvh9v998GfJxE9vE/2sYeaOPm53ijpSjPqEuFgmxciawzUA2u7Y+HUbQOFPzrsq
	IvQ6w7saU+nrixqTI8goanAfaa/NQmuPpCjNoQuZGq6+OVA+iwT1KsQT7uzlCppO
	fQMZVqfJpHvh99PrdY+AgxX47lkWWe0vRhDhVUXg9OhW1ogA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v83fs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:55:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso9216129eec.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792061737; x=1792666537; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JwyFlz/ChE0rMDIH1WU3MsQ60a3WnORnoupBPMHI0Hk=;
        b=kfcUbHUnXROwd9A3w594JyhXGc9wjlG47sljGEO9czhVcbSeqaioQcmH5oUF4ehRkV
         v6FlUfjfXFu5ZPhQfcK0gagNAivJG0cdqeeT61pUakO4nspq+OStEMKFhSg9OS5zMVuF
         nivRmvBQxnTt+5Iw+6qjJVljd1YdlL4x6Ob36iCTbPgMIZm9SmhomoDWv793UtHMJ/NF
         5Ba99vaI4TMbPyKIGTdHxxo44KwQlaCyerzGdfSVCZizm5L/HxoK5585NwlaP86MpTqL
         yzg2P9zYQ4sTioQ2cvPMwqXzfP6RlHWv3Xb9/bfRFiykwXyK8fKPxRKJOfEDQ0l5/RJR
         nTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061737; x=1792666537;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JwyFlz/ChE0rMDIH1WU3MsQ60a3WnORnoupBPMHI0Hk=;
        b=zqctpNnPpssj2ljw96GlAh5jBLIs7W7AIfUilYSUO8GWZWUWehu6gB/vYoMOFbMg1S
         KfT7dpdJMNNDzye1NwvoqkZx3L+GJAFfQUnFKB3UAl2YiRbJEvvPHXlNVwEzaN2V897r
         qYaRlQsBTgrEa+q/x7Alh8Lu9lL7tPK4EeWjEX82772zm1sUdM/pINtYCwmGGuuoXuBP
         iQhvE+C3C/kO4/KS63WFdLLF1LwX3TwvdboG7iHneG1xO/qY9XcAudyljKLXEPAp9Eyz
         2UAR+o2vYzlBmsckPnTFIt4vF+6s11TaOSPvkHFa3STx0MUAlgi3hegsC6bC/UHaR34O
         GhsQ==
X-Gm-Message-State: AFq9FYIxi/8B9jCRpyY8TplT51nFKPgZH0+YUIjj/M5uM4ylP87FZqCX
	1TXyj6aMHcmbCT1TOutD81EJStUIZWy8so9uO3JtkQ+ocm6BBFBJlQQEks5u9+eZ1ToTvHugROi
	S41ExwQUloTEdy0f7zWlaNoAN0e1X95N1xu6iF0L7G4MyDIe4VgpfVofkhMNhJfhQ/o4oSg==
X-Gm-Gg: AYBFou05zWVLSbB9WTKYJzbYup7j7oxch4l4xTi1K84YI7cGb8D5quEE5HOVimjSyeX
	i2rpmvaQUZtK74QfA2JuyVAyfHida1Uv0kLSi0bCYH7iiAwEYPBqBiUHzX41N+uLouxDy7Fyl5J
	743ve8gOiqa+Qm4HJQPy+V59Nwj+cHj36VURxOONZgRrilsx9NmSlhY+Egj1WOoajFoOr9NAwpg
	MXdQevaEaD6z2o0YsU9G8a5S9/xgU4V/ghxxLu/bqw7ZwzjILWrOOfKaeopcAumWRz69mwi9ZCV
	ftldGZcC0zF+6t9I9A5VdN6ekj/PthZH+XkVkS0rpyfUJey8vaWWMr1h5Q5HRJEJI9BzrtfI4m8
	v2z1RNW7J0swQPdeoNtBVoaSqVR9DFmib1zj3a8FKrAiWtAkCEwRXUmuVXtctKp774KDfDC65pF
	qJILc4FCACzega3JUQNVK01tq1nvau
X-Received: by 2002:a05:701b:4503:10b0:158:7ea9:4a5c with SMTP id a92af1059eb24-16a60066981mr25230151c88.27.1792061736465;
        Thu, 15 Oct 2026 03:55:36 -0700 (PDT)
X-Received: by 2002:a05:701b:4503:10b0:158:7ea9:4a5c with SMTP id a92af1059eb24-16a60066981mr25230128c88.27.1792061735948;
        Thu, 15 Oct 2026 03:55:35 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm72352996eec.14.2026.10.15.03.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:55:35 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:25:28 +0530
Subject: [PATCH] dt-bindings: cpufreq: qcom-nvmem: Allow generic OPP tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB+x0GoC/y3MwQrCMBCE4VcJe3ahKUa0ryI9pHGie2gSk1QKp
 e9usB7/Yfg2KsiCQoPaKOMjRWJooU+K3MuGJ1geranv+ovutOGYEl+9MYB2t8l6as+U4WX9Kff
 x6Iz30rB6jDTZAnZxnqUOKmCt/AfPNO77Fxa+wcaGAAAA
X-Change-ID: 20261015-opp-8f55ee1c9baf
To: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfX51UHg/aU4hrM
 iIYds2jTybYKjHtiw7fgmtGqZpurPD7m9IhM1DA59i+ViFAFMfVKpIqlVOLaqwC8KTUyNajCW03
 +/yBsQBfAkP3UvEdjgBqdOJEIilqpA09jx1wxz0UmreeP5scM4KSawl9vPowGz4KTgO7HRlUuiG
 sNdq2BWU+ewAHG1OcYUpem/j8EsvslsbqjvneNw+W2jS9MiBKGu/uJ1FUw1Vye+Bdf//bqtO1pC
 E4whF7imr9Xq+V+CnfQ6tjL8SpFsN2EmLtRrVHSTJxKTdgzPy3SyOFnPr5bfHMFjIa7eFavrHmE
 nf7Jxt6WebfZCLS5IjoumLMW8IbLWa+xC5FrwITrgffvWqI7Au0GFqD3CVNo/lwqoUu/QRulTti
 IeW17bizQ77M646lH+/s9YvZz3XiUhXbeASuRj28rgJ02LNHDfOVFwjpCf3s0bmajOOeA1QTU2Q
 jZ1Lc+Cgve+Sli/luKw==
X-Proofpoint-ORIG-GUID: K9vRqO5hAIsjbfWZSEu6A1sPfeUxS7N3
X-Proofpoint-GUID: K9vRqO5hAIsjbfWZSEu6A1sPfeUxS7N3
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0b129 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hxkfFdRD5dxKw9vi-7wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MyBTYWx0ZWRfXxhuhQa3+n318
 guiBIUyCnq4bM43z8loyitgo9F04kGG/6GsydHBBbKu/LY1wA5ddS0Yb3uRFXxmvsKJFK4vd1na
 wGP3F9VpdgZqOvEhEvN3myWjnltUxZ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150043

The OPP table node-name pattern also matches peripheral OPP tables on
supported SoCs. However, it only handles Qualcomm CPU and level OPP
compatibles, causing unevaluatedProperties errors for generic
operating-points-v2 tables.

Reference the generic OPP binding when compatible is operating-points-v2
so these tables are validated against the appropriate schema.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 547265b8b118..fa9330cb3223 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -60,6 +60,13 @@ patternProperties:
         then:
           $ref: /schemas/opp/opp-v2-qcom-level.yaml#
 
+      - if:
+          properties:
+            compatible:
+              const: operating-points-v2
+        then:
+          $ref: /schemas/opp/opp-v2.yaml#
+
     unevaluatedProperties: false
 
 allOf:

---
base-commit: ab8eada9868faeee95f25d81d3d6fed0d1c98b78
change-id: 20261015-opp-8f55ee1c9baf

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

