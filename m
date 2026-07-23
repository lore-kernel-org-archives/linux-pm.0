Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B83A1A54
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835333; cv=none; b=mVRnwNOztG3XqzkgksnudarP3gqDGcktpdHtUsBpCRUzpMY++DaPYMGtrbhEb7j7c4sD3aDhIT4M+sgg1z+tk2v8Ob1EEhXySHElI8+jorCiyf6rFPFIb3sx1SrNNuxbwFiQw/tyye8U0sQ1ZIT/if0z0VT89XfZ6UOPGOveo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835333; c=relaxed/simple;
	bh=tJrprejrY8l1UjpwCqwWq3AmQAd9qV4z6/2T7isrbJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coGVTjVMqoDZtAH3dO3HF1VahUOw7Bm2dz73Jn5qdT46s7u9QERDgxciNxMQ+04e1jQnTa65G8fDbsGJ/Vnyf5amA/7IBAXrSsyYVOdGZYHpei57JaSy59CMl4egzXjxaucDKLbKIE2GNfDOsSn6O2HyhLiO05ywX3nGNEt8pg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLskVY3b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HexXJxv2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLskVY3b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HexXJxv2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NIm7Jg840267
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 19:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WrsIEgKJu1x5XHgLFDMvH5f6iCy+GXxJv6G
	sh8HHl1Y=; b=SLskVY3bD9tCsh2BB8/4Af2l1dGMsK71yWo7RNgzzjOZFp919ne
	ywb+ZYPbSsIx1QxLadmYubu0BtkxWZLczRZhYlNvfU2mxshGaC/Oav8Okej1MVa1
	izZyrSB9LjPugbQhI3skqhTow7ohpnaGP+eso44maNjezivr5J03V4gQzR6VAEqn
	vYfrEIdXf7xV+JFY40NOuKzDg5jSICUaxbugv6p+OjM/d687d6yVYYIDZqnPNXX/
	8KaIr/2CDtrgB9SWTrosITTugKDYnuDSYJ1uAELj89zYwsW0xYz6DRTphY5e+GeS
	9T8fqqxVEdDJsmynfUzQenNEsjJSSAGYFIg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa18hvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 19:35:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe3fa93bso20721741cf.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784835330; x=1785440130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WrsIEgKJu1x5XHgLFDMvH5f6iCy+GXxJv6Gsh8HHl1Y=;
        b=HexXJxv2J+r/X/lSxWuoi2lcU70sjnQoQC01jMQSWFZAJ/WTP06KEni7C6RFSXDT6Z
         2MAvJhVO769IvYbcjsweQiwA0ceiC1rI9xCZa6qPx2QNsLO6U2hef/KLedamSi5rja9J
         Bld9C5pethCBXsz6uXKlK3zW+B46U6ebNdhbvqpr/PSgbWj01WTwnGCQw8CqKZ1kGsw4
         nIEEU7DsHiGvIiREF1C2a85Qm0KuSlu5mvgw1BkDr6PcrIQvgpJ5r8kIi7UcXjE9ln8B
         87hH4ONJHHEhLre5GAQnImbllFKZkqdaI6ENPP/4SRShcb9n8FIAaxHR9faMsX0waU1h
         MNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835330; x=1785440130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WrsIEgKJu1x5XHgLFDMvH5f6iCy+GXxJv6Gsh8HHl1Y=;
        b=nXNYQNs5MNY3LxkolLrsH2rT+D8COM23umwSbm7RmMy408s8VR29J2PJ5yADiIM1zZ
         NnDJhR6RIdAGfV9JLbjbL6cXWlcmpvYHxwLlKkh+1ZwPc4LSEaebULY+mUgda9c/D9N7
         YWqflti6ZZ4B/ag3KWt+StWY/iIxoY6g2FT92V2+pEAsfTZ4vfpcXS4MlfJrsIzw7u2W
         r/nTzar1O/6yEWAFmE5M07JR//rJOaAGRX1KT+VeiUNiiTiZ+b/FDqPMU3CxOGNNK0xc
         7gKWnZk0mXkkNWc8JrI20x4NQtd1AwvLzmiz7YGtXne/D82dppUhSxQmm3Okc8VDwoKz
         id4w==
X-Forwarded-Encrypted: i=1; AHgh+Ro9z8xRy1Of4W1QyRLang805RyD3oUSE7Nk/HxAUQtvtjxqdxQnM+XA6MGfSjwK6Nvi6dWI1WGMuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEjeJ5GXMLKFHG1tlHN+zDxAI6SA5owBgB2U7S5RqUXrwqQ46
	IieBGLiQQHdFFHFFtgi+FVMLEviu9AJPRLcrLtiPfv3qpeUvoaoRAbL9Vn6DfhciJSH7GWBbPNb
	bgbjw+vPWXMnu9k8VkvCz3qnfwHlSMiZcU69I3f8AGpe5bk0vxpPrg24E0llJZA==
X-Gm-Gg: AR+sD10sNHDsPZScCaPk5jYHzQ01LkoHf5yjjFD0WmjgMSppZN8kfoqNkv+a04eOw9g
	U5hmEewQeU3tj5hsLif4whHGoyATaDEyU5C2t7KNUBmkCWzRt9tcy/91vilZ/1+QhPVM6GEfqgN
	Wi6s5m5JZl2dkX4b5Pw4QUHa/qX4wEUXeYMIjGHMOIq1yMYJmtWRoEEnVtmg5L8dr+LTQem4EKN
	eKdKdSsOws3VTwBysCAwk+XzRG+jztlVBxsqAyYioMXN5LGXYEamC7auaJrEWNy/VQj8Hs+ZCS8
	iDZ2T8Hnrvw/7VkW81ZItDqGJ4zX83Le1ub7NSIPwVrUaH39hUByQyL6Q1cT6NOo8qYsutlFx6T
	opx1I3oLCw6OLPzW3
X-Received: by 2002:a05:622a:3cf:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-5283df78e0cmr41422661cf.69.1784835330254;
        Thu, 23 Jul 2026 12:35:30 -0700 (PDT)
X-Received: by 2002:a05:622a:3cf:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-5283df78e0cmr41422321cf.69.1784835329705;
        Thu, 23 Jul 2026 12:35:29 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af914a9sm14828835e9.15.2026.07.23.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:35:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH] power: sequencing: pwrseq-pcie-m2: Drop undocumented QCC2072 compatible
Date: Thu, 23 Jul 2026 21:35:26 +0200
Message-ID: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=tJrprejrY8l1UjpwCqwWq3AmQAd9qV4z6/2T7isrbJs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqYmz9QdaqlWb8r/Apq0oPwaPVc1y4dSjT0IDL0
 +8oGZO3zrSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCamJs/QAKCRDBN2bmhouD
 18eTD/9Bb5rCRFSpgabqLKfHNZvx2rEm12Wlcb7bj8/u8IKnxyRY38DvkM527kXtdlxFSVc3nCE
 9AZmkwPJXeRSwVVZPqOGOqQn57jNiPWGo/r8kZFHi0qdSusexpTMXTdsJ05DpDSEGqenHqxJD+V
 P814eo4uMrUd1fH+s1XVz1cNb5SSS/v/BIFqRWh06QWKpN1mhdr7I0vFs78PZnjQgaEYgtSbH2E
 vspHRIfnSw0lcLz2WRb7Kmf8FGTQce4Ap+Plrv9jK0mCPtWmJRMwRP1NONNNaPm1UGjWkrpWVnR
 ERRTUaS/Nfn3XA2mo5/su1bbzbrByrnQIgZPDr1nPDPti2GdQAnBm2ONYFrhfkzzItc41ApxITL
 U82ML7A1z2NcX9ipYWD2/QlReEsrqJIil2SHykl8+DkQD3Cga3JURKDosrwe2cyW2RvhkQhgEpU
 rUWFM5BuRNcUDVPoezXJvhcjZ0PVI/kE95HNMfq7f/L+njLYvqCm37N7TreRm+wFna1r/pZA0kQ
 cCI1LgAi4VEKgwk168lIQWo4SxjfCeiqqn5NhzFX8FF4uogT1E/TESDDEcl17MPMA9l5Gkz8Su3
 ekA9+paThrFmZ4I1jkzQrrL4rxT1FCRf/oL1LX2xt5Ido5YoHoPsH01nmwAPtYhxxikDBxzyQOH 1psyDM0F2iTDl3Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Xp9dMcQyx2N7gsmwiHOYAb7Db7Z8Npso
X-Authority-Analysis: v=2.4 cv=L4wtheT8 c=1 sm=1 tr=0 ts=6a626d03 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QUvU_t21zGBOGVwEnL4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5MCBTYWx0ZWRfXx8dF2TULVXCR
 2Guz+Tdb2VXKa2vJ9OHTd88Z3P57qNWWyeIp8mDXfGE1dVd60nbHFRfpJ2aRsJZmtjUai/XWwpO
 VOKnOZjsuewmCQMLS/fsPnH90TGjKdcQGIkNGiIsiXt7ImqXRgV9NC7DTvjqLi/EZGa2bKWCMgB
 KC1IcQr9HsvBJ9F98BO/5ydPkCJMFYfrNPOQt8f9TRcHGWi2bDxhEwrbcer7LTIfWJi91loanLW
 Ba/CW7MDW4D2owFmuIXePwAhc2FXR6v9bQavuIsGZPOQIy+jVX9YHBMhVNgAwQW91Th18lT2yRL
 lX2G3hFBMhNf2Uf+qDWWCpFvnGHI7eNQKncJyhvUec6pDiIhUvCTEzN7mpsjUvI60G9+RbON+XG
 Km67L8fgw9VCmoiP3EjZqTiki+Gp1jTabwuA77XF51/yBhOg68Sr/Lny31uiMEXyN2fvjzM1G9h
 Hh7oIb5wVyzQMYhYDFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5MCBTYWx0ZWRfX2MK5a1bzv4Dx
 AumuGONV5d1KPtNkehXHCwZTZaBbtN+u4RmbFhN+3+P7nMsYqOlyHaaBPWXHA5X3CVoTvgwkMoW
 mrUdPqs7S5NsU8d02+np5ytKUCrcRV4=
X-Proofpoint-GUID: Xp9dMcQyx2N7gsmwiHOYAb7Db7Z8Npso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230190

There is no such compatible documented (thus allowed) as
qcom,qcc2072-bt, thus it should not be added even in driver match data,
which later is used for compatible matching.

Revert commit 162ea02941a9 ("power: sequencing: pwrseq-pcie-m2: Add
QCC2072 BT PCI device ID").

Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..168e915f2c89 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -195,8 +195,6 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
-	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.53.0

