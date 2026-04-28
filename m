Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBC43C07C
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397567; cv=none; b=hXXkBHMfOBGHbVSlfTxATUnWqQlMHtyUqKxdwUq+vwp1vA8Lcx1F16FPe9ZOkS9Z4eCGb1+30EYIxr3NgeNDQMkajnKmoSq8p4OlSu72eGi6xaUoeQ1ttMuCbrqIWh4uDU5soAaIgOyV1OVJ119BQ62yvgMQOQop6b80Dyj+P/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397567; c=relaxed/simple;
	bh=sWxRZSIVrfi9WvbsEWE1+L1L1nSmizDIwws8MkDeLgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uFZ0Y/JhX+CN/XfoNBaJR+Yxr51N+aQLsHWak+n1lowwNee6wlTjo6dtohI0ukQnq36wz/c0roVjX7uG5KqMecRawRo/T4wMEbi6+hgIIMtCx06UUKsXmfXdGGaJrAg/xl8yWICf8EkwhRhQEW7swz1+z/Rgv7Im2D4YSQVAV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9s6jmIG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/5G5Qht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9s6jmIG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/5G5Qht"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SFsVC11796854
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qz/+EjbHjFMwiqGr5dMO8y
	hfFwdsGsf/guraABNaMfk=; b=k9s6jmIGIGOQIROF+QREkaPV1JfzXO3tdTj9MX
	HWwNMMbHEAzr7E2GV/paL2BXoo79rZGHPt/HVyalE2TvhNz3GqrETzTK5GQaes7x
	1L17hWYukWV8azHkGSWrhdnOWPUblcZiRgqc43JVkMiPc6xXuTnd6FDcgaHWC5cK
	onKjUVCS7vYMu0GB260C34EC8f/2ACyPpV4N61OXG/dlmZQLZt3/ElWUDuiPK42a
	KjS6vnFEMtoIt+23Aad/esA/3ucaRI9odSKtX9GCJO5OuKjUG6E7Vrwjijiheu6Z
	Gy7X0XkWieig5oKX2S4l76dGO9lCAEgKISo5ik8qm8ldxveg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2sv8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:32:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d826ed6f9so1634111cf.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777397564; x=1778002364; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qz/+EjbHjFMwiqGr5dMO8yhfFwdsGsf/guraABNaMfk=;
        b=c/5G5QhtCmzSm6GNJRJmPiPyO0QfvucXEKimEG6MVvWfUfMzJtNRv0W0S25v51rPHm
         uoVYfLRlB7m9YYhEABc/oIdHgFikU48gID4YMQBVhAP/CedR5J/TM2bVrb5BvSsLISY+
         +a+Np8viL2gUaWklJXnpQT8pblxen0/WndYP52ieyO9POAKLQgykhtk0AfmVmyO0Bg9q
         YHS0cGUZDKuqkMz9HD8PjwxP1fzhXMfxr3XmKTo/cwvhb9ARSW0VtmELKO6JCR9V0Grq
         lDvhAC81bwhQlohehSzdWf8hZTjCCO2pXtuCzJnYhMNji3lhwzZnIdX8ofq3qG2Lpq8k
         eSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397564; x=1778002364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz/+EjbHjFMwiqGr5dMO8yhfFwdsGsf/guraABNaMfk=;
        b=fLpd7ZO7s+bZo0Gts2SdAixmXUtIb4aHP6Io+nMlxHE3lDixyOwMfCuGgEo3zS7p3i
         e+n68ZlRshiQWIhOEJx2Zin/Q7dHKBh06WtquStb/+ebXz2tr3lTOLTHVJ6XeyIQlyzU
         80BMULyHoJIjKvaL5klXSDfvMDfq9W6RLM8y5JcGBzwYLP7khgLiGBVrXLR+2222r6M8
         VY5bU9eEaKCqIWTagGPA8llZtjPktWck9Nak7/sIOKVtd/yfpw/obKklPVl7633PLZ2c
         NXTjQ3/EZn95ZM91Y49+sbbH/Q8hmoADPI0Sx8cNWMTa300NRs4M8Ps4h9hpJvFTMs4E
         h1fg==
X-Forwarded-Encrypted: i=1; AFNElJ88aMF79C4W7QpC5S4f2QQ+vy6YfUWmO+tAZHItM9Rw3oT+SItpB2qAShxUhHqGBJoRjD2QoSCyAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ44IIjxz9D7zJTb55rcBP/nKVkMomUX/FpU9Q1/eFvgp/a3ql
	UUkYa+/7afgfGepIpagORAGho+Cst1kJm+4F1mf7QY1DQCYT28lGOYAW891pUTma6m50D77yv4d
	OJ0uSlUa6ukXS+disZrbUfnc7tO+qzABboBuaalD64tlkr4eo+UkfxYKBCRG/SlVsKVno7A==
X-Gm-Gg: AeBDiesAsGFb3001CKTIDnEnm80f+2r6WMnak0jfu2T3BxYw6MhsHmBtplh6+jVf/Dk
	bM0M8UofyWCqGm2ti4N9yaFM3p2YMlCZpe8toWJD+Wt/idUMs55mguhCcqLgsD6+5ttNDOCmERD
	jbqfW5SwU32UO6HxcsM7DQA6gJwn9TcH3bH50y4tnElyre6nwbucdXLymM5NDRU2NNXTfivFbUv
	vkabA5lJSdYLbCCaSpt2kk1tkFth0Om4oJNK5DaL+qmNdKnZXEUsEInPvEs7rtrJ1GEJZq5JLuL
	VZ/rQQSS6NzJpiMvgaYKwMzgJWcz9LfcT6Ps6tNUqc++T6HXhNaP9wAV1oRgf7BqVaRCzCPz2GF
	x7e6z27EAhN8HYTkcswohV99qfjNugNMfff5HIBGcjvMY1f2vKSZfWcA=
X-Received: by 2002:a05:622a:5d0:b0:50d:9c1b:941f with SMTP id d75a77b69052e-5100d9b1c64mr48784991cf.8.1777397564617;
        Tue, 28 Apr 2026 10:32:44 -0700 (PDT)
X-Received: by 2002:a05:622a:5d0:b0:50d:9c1b:941f with SMTP id d75a77b69052e-5100d9b1c64mr48784511cf.8.1777397564168;
        Tue, 28 Apr 2026 10:32:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b8ce444sm2089545e9.0.2026.04.28.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:32:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/3] interconnect: qcom: Some defconfig/defaults cleanups
 and improvements
Date: Tue, 28 Apr 2026 19:32:36 +0200
Message-Id: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTv8GkC/yXMQQ6CQAxA0auQrm3CjECMVzEuSilaIx3tgDEh3
 N1Rl2/x/wpZXCXDsVrB5aVZkxWEXQV8JbsI6lAMsY5d3cQDqs3inMyEZ3xympDvQobkU9cgCQ9
 EQdp96KE8Hi6jvn//0/nvvPS30n6nsG0fyaJ9V4EAAAA=
X-Change-ID: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=749;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sWxRZSIVrfi9WvbsEWE1+L1L1nSmizDIwws8MkDeLgM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp8O82gXCB/guorllzZBTQxlWYO2FxXI3zNxygL
 E+kOv+qPayJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafDvNgAKCRDBN2bmhouD
 107tD/9ByQwbryQhQjId9ZVIflCv9C6DcPxp35fudhSH3LeaHCjxILhn/03ELeGrdC0L9JvOFzm
 p5z6UErrmjVoO5lPX8GgxDbjIWoCnK5u8M2G0We3nU+p8qHaxpSg1ZtxUUaViYHUOIYzw1iAQCM
 vTtb8HAnmuFe82mhIPLdRqWecetIrvz3z09FOgnkCCailvrGuHP6R7qBhjfa+WXl6bvlK1Z7LDD
 VxeD4YznRixjR+NHlLNKML0myATbS9noohd8RFPR3CQP0fvi/fglFpKCnb/ZLOYwYoP6smD0iRD
 E0/hSQzVFvZjEQVqpwBHkjoCeFgT2l4UwcCgAEexhqZynKf2Wta/I3t9qlr5ij6FpqKv/HDHOh8
 KgCEVA0UFEvsaij/I56tttmurZDfUQR4Q5pTLdm6/p1DfUBUqqZVHUbb7FTifkOLBYO63V8K+7M
 i3kGmvYLbxDf4eOqSOzJfe08mxSgCFegHR7FNPSalfkvO20PWpox7WDN5A/GL7i4OopUvumHUaO
 nA6xLC1wq4+578hnrNj3UzAbRDa3oEGAwNlHL8PphlRyW3DKQeoNnR0+OK6KZO63zKpmlpyocsl
 htoKDVTcb4g+0CZhkUbsgiH4VL/7Y5yDlIU4dfNYdEO1avXOC/PAQAfxhEJxNH6idg8VesaeWqS
 J5PgD31kPmPf5nw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0ef3d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8w2PXEvidvIgLFpFqg0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: aG-qS2NbPsmeOk-jC1OKLwQ2FLOUhun3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2OSBTYWx0ZWRfX0AMGYTaRhVdA
 5NnH1bNxn3qFC2a8SYDpVa+hFHbHOO9Izh80xssTkLAuFaCfFKXVlOd5ISa/XUbV3tpdDh5betG
 lcT5ZJ8oXXYFYDquQrjaLSk1PI2cdJHWvhH0lrG3hLVdlovhuLRXja5wcbmJfKTNqn5Tsx23oQy
 7A595qsBD9XjZdI+o+wU+zWvAqemdc9gDK9qiihabPpHdQESXqSMqKty3DWOu+4X9dNwIHqiSA3
 avFdlDc7BulZtvvE8CNIM46A3qyqMkj0DlPLhisQKInJfPADz00tgZRgINmnZ12JrY2Va6ndmtH
 lJvYwdPAMd7Qffk1BdhR+xTHkEc/5BDEiO23lig8psuMom+VZjEAAXEWF/v1DqQSIvJ35nCfe3X
 RiJd3/tctE7zN3LSxHUVJOVo36jF8lWHXUvr8rbSkeAqT/gIY0lTXD4amvbVQmHhL+7SglykXqt
 bhmqBN0UdX7SEohnj6w==
X-Proofpoint-GUID: aG-qS2NbPsmeOk-jC1OKLwQ2FLOUhun3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280169

Similarly to clocks and pinctrl, interconnects should not be a user
visible choice.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      interconnect: qcom: Fix indentation
      interconnect: qcom: Restrict drivers per ARM/ARM64
      interconnect: qcom: Make important drivers default

 arch/arm/configs/qcom_defconfig   |   3 --
 arch/arm64/configs/defconfig      |  31 ------------
 drivers/interconnect/qcom/Kconfig | 103 ++++++++++++++++++++++++++++++++------
 3 files changed, 89 insertions(+), 48 deletions(-)
---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

