Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA43A7193
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383270; cv=none; b=hB9RtEZf5lCQDBpRyHMe5/qgUknHS6zkVNx7s0X8nGb2gx+1ybk63EKw0sqy77o7q/lUCMbzRsZskH37dxXXz0tdwcZLNegNa8ev9u8RzWHUI0+K0OliTz2S/hTE7ghsxLsZVnpaZ9JdqmbN8RRGrgyPWih0f1CyUKlnIEkBivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383270; c=relaxed/simple;
	bh=iIfLzY0RSV18IcvZfxcvZn2bQF6E4nr4oH+1NMGnZJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Iv+Jf1eTCMFpOQcXZuBVz6IuI1+YHg+8nmIKpXhMmzDU2P7Vv0gBp2bnNFxGgxlt2dr9AFa5Iq8aL/+dfjWcQoYmpew7sUnetDRb+b5cRVQffSddyeOQzfuk+n4JuayhaacgpJk6IpryhMdbMWp8UrTDbUN6e5u1ngG6dAFFt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maM0uCwD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lk+wI6iE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maM0uCwD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lk+wI6iE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6525tXti4012412
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 06:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=j+F4q7Sh2lmQKfIwbrzC4F
	r4FAkAVmOqbpOY+e2YGO0=; b=maM0uCwDyaN42iyqJHZCYXoNLwOONjxe3YQwfn
	hUHXqAccYk+ly4lMfI/nsylJcmONjSQ9cqeksimj2h4SN0Dg2ZIITfyzXfOV/swt
	43RXrM42gSX/hbQOksJrxKnmaQ+j9mdnZcOd3DUrTIlP9aREhfMVZiT9+r0fmQEe
	NVPGP9BX2EbVLeqHCRdWJxZ+X8TN2DBMLkFtve+L4izuHBpTL6kSsre0x4Tjzt95
	g/HhRS6qNldHD8ZzOttTZvXmbzr33ZYa82DgawiUromeAZngrgfYcaeF9L1D1q3t
	+LF7KVzg0npCukpsDinmmLcx5mOZcrB+CgYeKL/VVrDf3Jhg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf4g7f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 06:54:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c1e08848so30616075ad.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780383268; x=1780988068; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+F4q7Sh2lmQKfIwbrzC4Fr4FAkAVmOqbpOY+e2YGO0=;
        b=Lk+wI6iE/E/3pr1W+VS6gGci8FlMPCgdTWMP2XpLEwFK+VmfeIaF5MB987DI3uD7U/
         CPfn+5LTmopc2vNjtVkzPXmLShErE/cEsmmnp2Au319imvMtF/vF/Eid+wty8u0TXf0X
         2RtjRuS7pV0RAxbVvZHoZsc9pO/V2Ox8IIwMDi66wbLClMQfzLnRo1J8n3H3xmUnJix2
         hbiCg9LVwqTn3OPSYJELPlXWVbdPqv1+xmTLSzeXApFhRJqipRBfmeM8byHN/1TvOygF
         4+kyoVTyP0+CeEGH9tZPCvMtn1ddhY1r1Q8tbsyHllP/Oyh/GzxjqfBvApjkfp88iv/f
         VycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780383268; x=1780988068;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+F4q7Sh2lmQKfIwbrzC4Fr4FAkAVmOqbpOY+e2YGO0=;
        b=tF/+Tn/F+eLHbcPtHcU7aUPYkvp/6DGiDaCFpdsQR1ax/vrAHz+HHjhuaWxRf3vgIA
         BL5ph6id/0vovsdEUWnwuoehphDT6DQOGDQAQQHrcOrI6QWNP0fHJcLfBhBfr383EMQf
         VvCZWBb3QtyqQWH0kLodRYrPxBKpSO0hmhXnXlD+dJGchu1wCMyyFKPNkBa02sTlodTq
         755AgRbIeIMaXccLc1K1Nbmh1tvZyRKyaUZVsmXhyiVRorKWqRIg5Lprp9shsr6OWwSs
         edOYxoamLiyBr/KnFj8sQ9EX+YkKHIy2vGsUAueZ2LCIhZh/OVQ0oz1sxLwVAKt9/6Ts
         RR4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+6qeQPhBCnwgJBXchfEuL0OHJ5Jey3ziknggK1fQEtgn5QaofzEP/dTyNQ4LDqI+lwRCHxYvvdhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAURpOC1gnuNLEzx/YkeI2l1bzgGRAOdyqCK7VELOpMK0TWkC
	WIgx7Tqvt7FVot85eGUs2as5ZizUA88C356tQICVgZFHgDIYG/UAQj6j+6RjzMTOL2Jpl6jnqE5
	zkHAw2E5iOqTIPkvwz5EQIyVAI2AyCI6T+GvuB4/2BLJnXsQVwArvClrOjXq8Wg==
X-Gm-Gg: Acq92OFxgRQ78wVmqKUVVyH3Fw0OW7MojbeqeiraIi8oKGngUtE/DcrBfaarcedqeO8
	z6OddQfigrIK4XCYrl0fzpxgavb1Ht3/edtlEpbDUbMKTZgnfn9nbC9kATc3ZN4oe3ish3PZJIg
	ktD00GKk6aqlVVy2h0bNZy3ECTb00CZNJDrDppX1I9xWkUj1xoSuX/b4Lo/I4Z3gtpA6lukjMlu
	HR21QE4q2YoBgrJYVhzv9iHPZ1a38NOke8Fs+J4jyS4vPGdtv9HHSBGXDHZKPkALTJiWhSl+M3W
	5uAjD2zQDzvJeiK9Qsy5cQHpTuMummDjdJodLLV7k83nye3Gcr1tRHhRthFCDUohd5ku0jA87Tg
	PeyyWrEA7ppdPGDBGwYbg3n6YABiX+uEtDf5jx4LeTutk2K95DColMeK/S5XVc4evknMifNsSfK
	Of4bxdr7YFw/LoCAwbF/lYESMjHQ==
X-Received: by 2002:a17:902:e54c:b0:2bd:a529:4b5e with SMTP id d9443c01a7336-2bf36898ff8mr149246125ad.41.1780383268078;
        Mon, 01 Jun 2026 23:54:28 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2bd:a529:4b5e with SMTP id d9443c01a7336-2bf36898ff8mr149245675ad.41.1780383267565;
        Mon, 01 Jun 2026 23:54:27 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c5a350sm167383405ad.83.2026.06.01.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:54:26 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 14:54:13 +0800
Subject: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: Add Maili
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-bwmon-v2-1-d4a851c45f37@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABV+HmoC/y2Oy27DIBBFf8ViXSIeNjVZ9T+qLIZhqJFqk4Djp
 Ir878V2NiMd6cy998UK5UiFnZsXy7TEEtNUQX00DAeYfohHX5kpoYzopOLuMaaJE7pWBw9Go2X
 VvWYK8bnnfF8qOyjEXYYJh+17hDJTfouZbvfaMx/2oWIaxzifm64TRrTeoHWWAvZemB5CsK1HL
 aSxLXxC8ERsKxlimVP+27cvcg87ZqruPXORXHLXB0Oyt6hJf6VSTrc7/G6Fp3rYZV3Xf8qVGaQ
 GAQAA
X-Change-ID: 20260512-bwmon-ecb43fda63c9
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780383264; l=1402;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=iIfLzY0RSV18IcvZfxcvZn2bQF6E4nr4oH+1NMGnZJw=;
 b=SOZ11f34zTO5w2eBWAI+fNTAGn5fB4Cgk4enr+W9Gf3Y0QlDucGnbu0Y73wEjhcRK8768YtUv
 khMf6/4DL7OBbBAfSwh/YFgutmgqbC2A2UTRv0FlW/BeChUFZ5dRVPr
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2MiBTYWx0ZWRfX1Vk6laZ3rzmk
 WOUlf01KNC+5H4MYeDXxK2WU4FQUdrXkPkVixJBnHOqjPfXO0Gt7shudgC8ogbWmudEijFrnERS
 QkwJMbe/rCnbEY/ucGdzOHvcMdjmdDKmI8X9Jizu4r1+7+wodHYZkoMLPSwmkqac53hBB6vZLur
 2yRtN0XTJfgx9vkuswyhSfeHIAPbtOrOBVBgchCRSkOwnTivlzsxO27f419qtbBlO5cXrQUpNNt
 lHTbzPJiscQ5zI2nprRLw2VzZ5uZWOi6cfOZIK6gWjiXki/BOnXJ87QOqZgB5ZoS0v77hfU2jjl
 AYPaqN+NOxmuVfarmo/3odyZFFYCctm/M73zVuWgv3LQZfe3X7qBJaREN1bouVcyB+b4npWalz2
 spXeWKWl3/FedA8SuBVn7GGwfwFJfzTfeAeMwM6A+KQMzqfe3BJoVjH9jaamty4v5pvN1yNcPkE
 cWus1eQmIc5+UEVfAow==
X-Proofpoint-GUID: 2LutSH_BYio9UDxAH4mcPHVbO_XUy29S
X-Authority-Analysis: v=2.4 cv=AJZ7LEvz c=1 sm=1 tr=0 ts=6a1e7e24 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=XRsJJl_DE4KtB7T7ePwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 2LutSH_BYio9UDxAH4mcPHVbO_XUy29S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020062

Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
consistent with the existing pattern used by other recent SoCs such as
sm8750 and kaanapali.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
Changes in v2:
- Drop Assisted-by tag; no functional change.
- Link to v1: https://patch.msgid.link/20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 82b1d94d3010..7989db1aa774 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,glymur-cpu-bwmon
               - qcom,hawi-cpu-bwmon
               - qcom,kaanapali-cpu-bwmon
+              - qcom,maili-cpu-bwmon
               - qcom,qcm2290-cpu-bwmon
               - qcom,qcs615-cpu-bwmon
               - qcom,qcs8300-cpu-bwmon

---
base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
change-id: 20260512-bwmon-ecb43fda63c9

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>

