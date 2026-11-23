Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471939;
	b=xwQLQLAE+f/44f/69JlZNyNOOduvvO48ne071oCX0O67b86x094KIOKUJVJvVOrWoZBQ
	 03HFWJYx5qJe9HVQKW+zrLsFksYtKL4N5JxQ0lDvS8h/ynoPxTawT+j4gIK8vhhwwpe5m
	 slnuDGN1/rByDlV+wFgfAYtxHAvNJyFtgYJw0g3jTf1w6ekGvE+mrSccPR/eHsjabzhW9
	 HO13l6+JDC7SSazNZRDDLzK8WJYcGH2ElTq8RlzLFU+BvM80Z8LQG/dmjtJ8sgvq/9EBP
	 jwLDt37deyQQJfuQ3211t66j0EYSylABdaPrBz5PaGux4LiGEFb17blVlrDgU3r6M2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RGJAfdrg71ZGzilepcfH7fG0P5vUDbAbU4ltPfqcZCY=;
	b=tdCVc+GQu0OsamGzx8+30WCbyft/owHsZtyPC9AyZ0hA5LwUhhQL/272REpLK4cm/mpY
	 clsD7NRRO7b2fDpf8wo73VD9sZwXjm5Bea9ZdQ8XPz0lqCAM+U0X5jI3+2z8GlWxmU2x0
	 /MxzR5amZtEAZTXvrXiVZWuXbsn1iZ8BBOaTvGrxlDs+wTsYUp4OR4SgWxv+xlFPBvRGF
	 vN/Aqz/PMM3ODxYjSxk+oO2BQkJZWyj8CcDKHAcpmN1L7LsK26AimC22bu2Il4ko5MGwi
	 AlPd02LE2kJvgPzF1CBwqJ/rPBhQ7zJFVMpFl6RJmdf3G8N9zPoJ9hkodGQdUqIplZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=figAiWkA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bye4dW6l;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9148606A32C
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9148606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=figAiWkA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bye4dW6l
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJunLJ2827791
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RGJAfdrg71ZGzilepcfH7f
	G0P5vUDbAbU4ltPfqcZCY=; b=figAiWkAS9XyDn0KhTuIaFOQOEj6NJ9wnKUIaA
	MGKrbz0EXevgkGwGMG6YchapPOX9a/PZ6rJdpxbKoh+xRnH1WeezDTR/akVVuWdX
	FUwJz1ymjmkBF/fR18hys29UQ0vjt9F+oJNYMgkb4ewj9/HVukQSp6Wj/FdzKdN+
	U6RA52cfySoXFXMGPdWi8nYsWG1RfSzNwvbFgIYlJiwsyXr8BE8zdaJvgLyUARa1
	V7sFbKM+4CaM3uztT/L06yfHI0YDdOadonC1tqblWRM0dVZAtmHUEJYULZ4pE80n
	rUaW5yPHGpV5sPgwhmSgJ1mVkNAa/Px3z8y1AmH+QSqtZd9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx3v7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9495a1f5e47so628340885a.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795471937; x=1796076737; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RGJAfdrg71ZGzilepcfH7fG0P5vUDbAbU4ltPfqcZCY=;
        b=bye4dW6lIhUnJ05BP1FI0LxBBB67m+yMOzxrjgtRHWaM2HOkACfGFl6nxcYNso7JlL
         rNOiHZ1Y9iV90BXcLO6EWvnqb4UhxbKQvCj3/Bo6hUWk2oRksK20+lbfwGHfMTeMLYV4
         f3jARrAckTRUCzjfH9+uFUergka9pf0fMRCBCY7Tb2B2HeMRr8fDCgxF+N4kZcRe4P+d
         fPq/TOeKodkZU3aH7cNEQLO3SDK1aVYzwFMk/9g2L7zx+2TvVH8jACtR1n0P+U35EHs3
         KYZraTnxbbwntYaScXryKvbihibh/BjIqHprsJROvnTbrMBji3rZH0hJesWaCMiUN7xT
         JERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471937; x=1796076737;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RGJAfdrg71ZGzilepcfH7fG0P5vUDbAbU4ltPfqcZCY=;
        b=FSnexgwhxP8lhd4fFcoBrsNsvuWKF/bDYaPM/mlh7tLnq7+8AqFrvLpt8dsTFksBWJ
         Lnmqq9TlO4R3W2PKqTy1QOp7tLY0plP1V+PHwF5Idz4nPKGADh4Y6CkQ8AGSIpViGoKG
         VcOMZZv6yJTMXpwuxiSqulsqbvCWCUnwRt0wIaLh2sT6zShdk4Y0TCbg6XWYsPhcgzWG
         p1Iw12RI9BllfKP9MHtP/wZh9lGcV2I+CoQHwdA+qnUNRyhkUig2LZlFfOlW1fAD+p5p
         WSmxk9Jxia2M0U+qkGetmyeKOGp2oqgdGhYSWkqAAI2Pswt1afJaPTjanLHWwmGnUgAR
         sVUQ==
X-Forwarded-Encrypted: i=1; AL+hErF89d5cUnRJ6tWuW5BVFYpGqjjsNrTfugBpwa+futqKaALcNHwn4Z4AbmsC372wDVtq6ItVPrGv9A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xFwP/NoQureSbhAr1xoFhbfC/94WXqjTv2yZZhC23kQLISWR3
	VVaeFcQoxOPDdd+hm868PXJqeeicDlnXX4RwMamL4ysjeQcUaAng8X3q0Pa1gofezBapggNPMJv
	yAc09Cj2PPjDTiH7JjEr9E/MbfaRJcsXpU6QMYx5xTXKyQSQI7WrSYrlrr5ARAg==
X-Gm-Gg: AZFdTZfLr6mJeRl83w1/H/rE5VM1Q4hIy/02yXPoFB6QYkOtr0u2Lwo3KBVvMatX3Bw
	Tvnhi5Uxs6UZdPv5KouBtSeh0o4aQGHArb7shF7UBwfvZE/62WBOPDD4/wmo8/5kcctD6lGY3Rm
	QvjcrHp+anSX4r1G/pjYBjSBzfdYHrAsg8haw4vxSsDEveTQCtFoL4kg/kp8dRG1Sqxwf1SH/AA
	mssXdfzYNNnWEvxeLey70pPQQp8Bcx7+AoCkvGerxItX1nqn5G+aAbx4cJ+IgcAtBAX17j7zN1s
	5K4L6CuPM0W6pXyk5x9jujitv1xFzVBLddJozsK6JJ0R2j3Fz2sJdOB3wSWSf2wapB8QfbTPr1h
	ORANVK64KqBqiKebtuY3RteMlwNgCo+rt/RB4j6MM0Zrjj/NPEd6gB1SMYOuaCYGbB7M=
X-Received: by 2002:a05:620a:1d0b:b0:93e:6c4f:bdf1 with SMTP id af79cd13be357-949ba96e85bmr2174128985a.17.1795471936780;
        Mon, 23 Nov 2026 14:12:16 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:93e:6c4f:bdf1 with SMTP id af79cd13be357-949ba96e85bmr2174125485a.17.1795471936327;
        Mon, 23 Nov 2026 14:12:16 -0800 (PST)
Received: from localhost ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm211804255e9.1.2026.11.23.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:12:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] soc: qcom: socinfo: Drop DT bindings with IDs
Date: Mon, 23 Nov 2026 23:12:09 +0100
Message-Id: <20261123-qcom-socinfo-id-dt-bindings-v2-0-4504c1ce869a@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQqDMBBFryJZdyQJKtJV71FcxDjRKTWpGZUW8
 e6N9gKdxcBj/ry/CcZIyOKabSLiSkzBJ9CXTNjB+B6BusRCS10ppTVMNozAwZJ3Id2gm6El35H
 vGbByWKuyLYpaimR4RXT0Pu335se8tA+086E8EgPxHOLnrF/VkfuvaVUgAdNI54wuO3MLzPm0m
 Gd6GvO0RLPv+xfcbzLO3wAAAA==
X-Change-ID: 20261122-qcom-socinfo-id-dt-bindings-e6fe815b4480
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ixs+Xf9HRb6b5amjgvE1FPvRJEPclZ7DZ8oKq2faZXk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrBLo7VKePSkf0Ha+bUy4l2f2Yk24Lvpk5IAHS7
 jks98mNQkuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawS6OwAKCRDBN2bmhouD
 12RXD/4+tibSTTTeA2HDlw3CnAHKxPdq6sr6SQ+6yrKhK0js/EjPWPtTh8a0xk6PnjdlwW1nES+
 YWRK5voXWr++A4DQdprlwrrsAjKRJgrokXqmImjeKSLk142oaePsH0xT5ltiolN37vNp7Txpqd6
 U/zLTmt1faV0/3JK4QdyubzLcc2dJTgtt8EpH434offfCvtbCic6cyTlNk/pihjTPGUj75zp9rC
 fScKfl1r4iZ2Mapu5sudvjNNQCUhxtM8KXQTer2rPYiVBnklk31Cke9PA78UE1OLHuE+mMSekpT
 ehspatFOq1Iws2iuc5+v64sKhJiBDh+x41z87b3e4f+BBrqyfYWHwAYr7IUSGFoHe9hnbSJbSey
 6iTdCBY7HrN5r+1gy/byie2lx+AsSSbyg15+4Oh4vaKAsEgiCnUYbgm4gshEqD6iUyXhpC6ER3/
 r68nzauBUiovvaBqsWtSddWK5fK+5xec273Q+y3mMdzltDzJfhpAc9ABRqeEejNaAcSA3IZFsgW
 KgLeGzLo5QRcNox+iyXtESZ6RAa4XDeb8hA2zL7p63loDbTNiId+5xhZUsoGmom/KZa+sKZWWl2
 ldtgaSB98kkJtjeAGsGkxOQt/D760CPYvt3uVDrdAJnzck3yKYgb+BQWZdFvHhD+uPh/aPekSud
 Y5XRjl8KZa0qGog==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b04ba41 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1ggKHJeX72ul5W_pt2IA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: mfb8qIRpqAaHZfJoqWmWcC7csXWgiMg6
X-Proofpoint-GUID: mfb8qIRpqAaHZfJoqWmWcC7csXWgiMg6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX6XRRFpgDbOc5
 edk3LcxVzf2QOU9/c5kFxKJMtR9M6Xz8yuiEQ2Cu79lDpd/XTB++rNh42QkIpxgZzPLP8MsAzQq
 iLLtSVZcCOcrLssaHgvlmJHVEi7tvK4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX3W81OAMP78zW
 DU+M7ARdOjjSqCeqREIcoUJx498HL6mhu365QQa8/hMKhnFxlO9RTG7ri9jnVqPuOqHPEGNhPK0
 TCO6Wz8pS4nuFdnhAY5aX65CquhldDOsz2NuwAnvMOeBom3xqbRptTUiOddMgGSA2j5Pqnx8gRz
 Zv8LpUZj51wEDzXlhn9LLS8oIZcfs7RbRNUkdMnswZj1/HKXEvlmBpKAZTAIFThpg4WcoWtoqvr
 PR8nzVdGxkPqevvZAiSfL52uBriwxomW2+dDbqNnlIQ1Bh4Vj32fVVbhQCx4a8gIeuGbqVyETyf
 95T3HkMF3+U9B9BXVwvtblUuALZ7OdgOJ7yxWqjlr8+b1QGkCAoxr72v4kAmqVRYM+CCfPjnaEK
 ZfIrLZ3oCq2SEQiQ5ZlePqcy/PP/aTgq5RnTEJR54LjYHtW0pWjd7fBxDwpzOwtuEndpzrfhSXS
 qY/HbJcmr9EeYg7ouhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230088

Changes in v2:
- Fix order of QCOM_ID_IPQ5404 and QCOM_ID_QCS9100
- Keep QCOM_ID_QRB5165 and QCOM_ID_SM7225, as these are the last ones
  allowed to use that DT ABI
- Commit msg fixups
- Link to v1: https://patch.msgid.link/20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com

It turns out that people add SoC IDs as Devicetree bindings, thus ABI,
and then want to change them, for example because renaming/marketing happened.
Well, that is discouraged - either this is ABI and cannot be changed, or
is not an ABI and can be changed.

https://lore.kernel.org/all/9eda2209-d64a-4a1c-915d-4415ac47df45@kernel.org/

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      soc: qcom: socinfo: Copy new SoC IDs from bindings
      dt-bindings: qcom: qcom,ids: Remove unneeded ID constants

 drivers/clk/qcom/apss-ipq6018.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c |  1 +
 include/dt-bindings/arm/qcom,ids.h   | 91 +----------------------------------
 include/linux/soc/qcom/socinfo.h     | 92 ++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 91 deletions(-)
---
base-commit: 711b991738702a5c144b7cd1d182ec03b08e8853
change-id: 20261122-qcom-socinfo-id-dt-bindings-e6fe815b4480

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

