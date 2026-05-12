Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D57360EF8
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588346; cv=none; b=ROoHpfcQxBNR2ajbMUuRrdfy5BCD78TjVO3UWSEBr5jSxkGfsKwgZQc9l53TZjPDMI5B+T4Xs3h1n34kgIMHFcUw1ZDqA0hIWBUT/Dwm2EAGGohjeFODhqU4XNON66irPDYm0xBedhGAgP4pvZpwC5qTgwtbbQmXY127/5mW1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588346; c=relaxed/simple;
	bh=vPCIcZFi/ehqDMtx+YOdbyRuohx70UKLjM+qLnmTimA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sd88/Ipw30fEKscEAHQ32m7YPOQ00hrkQUrvPdPoowSR38J6s2yBHyxFwvG8qFqCNEUApx/TMlBebFxwUGVUS1xSNLylDAycV7Ka3F9xLQ4Cr3VGMkfDxCSotu2mIgUaOdxc0+dsPdo9Z5UorwQ3Hz7KkXRaFL/Yc5IqeDL2LdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YyCtMAVp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZsPlkJXq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyCtMAVp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZsPlkJXq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBxIpk128807
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=moyklA7z93lE8+Wuu04kiP
	zAGDGUtPT5ReFu5vay3+E=; b=YyCtMAVpcXYZaegOqCD/WzIcY1xdppeceIyD23
	Baq40TiD+iYkyQBjMr31Q/+dLaF/jvdtOZZd0yPAmXobzs0rhQ+Oziim1NgafAI0
	19Nz/xfIwN56kjsmjyzTeVbejJkz98TuD/y5GZOleF1VX7CdlgThUMRSGr6rzyhS
	2xaNmoTRoLpSJiHPMSBuVI7wQ1sVTMhXC3GdeF7iUHIrFaY3naAzWIgdSsNRIMp7
	WABQ5a+2n16/e2QEyr01jMOTjI3JiMz4kGPWbiq5u/b0XsAYH8L/IYdBzzfbTIkc
	mB+XHFK2mIImDNb9kZx29N7WGibHTWX19m8GggMbqtudZz6w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43tn024x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:19:03 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95d25cc8f5bso7769063241.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778588342; x=1779193142; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moyklA7z93lE8+Wuu04kiPzAGDGUtPT5ReFu5vay3+E=;
        b=ZsPlkJXqAycLUbjOeg+y0KgMcrHYQxGsZ3KZ5kTwOcXkTJ1sNDxWrFitpRN3hBqoN0
         ffh9tnEaBnZfUw8yRKYuWGDq9tNvozZ3BNe/CBVozwv2XX5GerXy438LPeYD4asMCKF/
         MlLQyCyu1Nyxc7S3nUxF+BnLT33ur34GYlIsMSym/GAGOUputffseJFyTDJ2UMI7fL+H
         1rZjHs4XPhE98oDSEqF0g68rLc2kKxp0sZHBPk1zw0EupD4fCwusEbhq/hqFwJgpJZ72
         JEWPccItniSxpVYanfgSREFhiEiqOatDmAFQGJ5eIEKJ8s60iFtrytcWj32JyR4dlO3p
         uKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588342; x=1779193142;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moyklA7z93lE8+Wuu04kiPzAGDGUtPT5ReFu5vay3+E=;
        b=jj1d01WcAxqrZRf5lHxcrZU+LfOM2b1l3xsp2Zgyl8ZRLy264dRCzUuuXOaxpXPwGj
         j8qpMxW6P1jdFK9bDn0vjqz1/xtz2rnlQ+zVCKNAXiRb5QqXxKGeuQkuWVQ7e5a9vaxP
         6xvFR7gXBeR0AaCQKD8C5pu0Hhi4THcCSH2gvfetvLtfZOkt8WWkIbu8ZQyuxA1hhyMD
         hW4jqGNEUAinYP1i+nP8nr8c9FrOcYZVg2P8sCNuxiwdazRnUXuqbWS2IVYBcgfdoKEp
         R5GKikJQCyDs6jTxSoq74zEHcsVhtZlABgBLtTcpWR++XJiMGL/eBTvOREY2hZhhTVbF
         Bubw==
X-Forwarded-Encrypted: i=1; AFNElJ9nedGcIi1he7QaK9qvKRu+RRl7Ap62lKY1kaoDYIWDn42vLWpdrR91ZhDRFZWAP7zrjVFnJL5hQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrx+8xtuKEEoL+zIzjBM1LJhiJ4UQ96vPp/ZO+/3m2j82HOF9z
	dghAdzCaV6pxXxh3gPlSMhz+1Q98AXaOCdehBBqjLdXjtdfkVrZ+tLuuH7LyHkSG5oKfgdSR6kb
	7IbE7h1fkhvFgzHNLPgLW2WKSUwEEaoQtYOVyqXnKsDA9wx4N3abtvMu9eqiewg==
X-Gm-Gg: Acq92OHna9FvSt60fN55jKIYbktAGO+OnOnHV/aN2GKGEMBNeO5LyADrLRfZkaHg5ig
	eyvwLj008hJNEo+IDGEUyaoJbEaGhqNTNN8wLcWP78udWnjbRefje4JAUl0vnMRtPS+rviCmaKr
	YeESsw1mZhc9DLAES5Dt7QXuTI4wU1GA9wmAjXCKCd1vcxJ93GWj0+7c9P2IMNJwmhQf4WeackY
	OtJkKG3P5XY0Lu3Gzf8N7KpV+uYKjyliO8p1Mzr5GOjPmqcbnV6o/TOW3dq1p/GtFCOOK5RUBFK
	JTr67p9Gh89WHrvnVvwJvb5JJLAMq1UN/jf0lZfnd6bLQCTZNw+pTPZGjyVcAu6O0rSz8Efhemp
	i9BR16p2M3sixHoCFccp3VDNcgcdOnA==
X-Received: by 2002:a05:6102:3f8a:b0:5ff:e39d:9f93 with SMTP id ada2fe7eead31-631d9b1b51bmr5956848137.11.1778588342305;
        Tue, 12 May 2026 05:19:02 -0700 (PDT)
X-Received: by 2002:a05:6102:3f8a:b0:5ff:e39d:9f93 with SMTP id ada2fe7eead31-631d9b1b51bmr5956825137.11.1778588341662;
        Tue, 12 May 2026 05:19:01 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm33700213f8f.6.2026.05.12.05.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:19:00 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH 0/2] interconnect: qcom: eliza: Add missing SDCC1 slave
Date: Tue, 12 May 2026 15:18:51 +0300
Message-Id: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKsaA2oC/yXNwQ6CMAyA4VchPdtkm4GDr2I8jK5gDXZmBWIkv
 LsTj9/l/zcwLsIGl2aDwquYZK3wpwboHnVklFQNwYXOtT4gT/KJKDpzoazKNGNMCZ9iJjqiJSK
 PNsWVUXNi7FoXXDz3gYmgVl+FB3kfx+vtb1v6R+38NrDvX5o6h1CTAAAA
X-Change-ID: 20260512-eliza-interconnect-add-missing-sdcc1-slave-node-65020a3b2ecc
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=vPCIcZFi/ehqDMtx+YOdbyRuohx70UKLjM+qLnmTimA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqAxqwsmKwv6hI8nmsmEy07nafxAoYoR0oMbBhB
 UNnqvaDNcGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCagMasAAKCRAbX0TJAJUV
 VsL1D/sFitC5CyqxQKs2qbWH6C6XyfO6B542sW9KJ3Q+mTe1GWX8GFtYlOgSYT9Q9tBimRg/xnC
 3xWGpbXvLoDWDO4wxkQTDNz4/ukDo7zU9VYeVhnyc9JE+WAYaDMkZIPdbxnc/PXWDhoQWV4FulS
 JSgW/VEQ0gWUR6SsucXuXEqIaJ57+ZUs0jz9W8J7MVKqyypu4aXCS4NV0SaTN1nnYiPOGM+4SZE
 +zrt3RAZ1QITl6YrkISiuIlTkSbP7ReiTP6ZS+YBn/yv8myxRpYX8L89c0I45+sYFAOtWNaCVfP
 q4Yk+rtsn16c2c3E5VWCk9p7ZNsb5Mx34G8N1kUyyQ02d5iH5f5pp/c9dOpFFOHCiI4220XWlk2
 8AHGaAcDVR1zbhRGCSRlatveLEaXgq5oFDyGfoLh3wIUl8EII1R+L7upG3D0mHs+voatg04qn5P
 IqsBjXfNMbU5uxbk8R61fOSeEYWE3kn/Tc/PV91s0tfbMr1cnVm9KEq+B+mrQe3xXDGOb/BAneA
 wjiaQEd0tCvQW4gBTt2QYkjKGLqpKQ8FzH5HBwrbcHIsccQ6/FJDPRBPmroFvyClKopNcGKtsGK
 Dxr9/nUjAOvOaO9Hz52LrAc6a9T5CMqlXKqJe+5QSifqgvpNIDs0tqWNelm8nvtAZpM6OcwMh63
 sY9pw+LKL5x6dJQ==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: DPB1j8yFsyHm93-chQCLvynT29_b4X4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNyBTYWx0ZWRfX/Tn1QtM2Yrxn
 HQSNVVWsYeGCc2cLldB1Y9vZ5okKZ8mVFDIVKu71Kb+OF5sGZ/iKs/VLuGUyvJguKZf5yNLq3z8
 oF0hO9IVIEoVTGDxbsUCljyV5q3hI1inPxsbVeKsKD0ZQ1WoRnm6vQCX9foThPgWhYkaHo4vgtQ
 TRZh07kOO28/umXCmkWeawoRwTvOaNuEzShjstAD5fIjjY4IW7aPVgzL2b74AeBRObc3s/3/gjt
 0DIXIUlYCLd6lzzn844n1UlNF9pLGM+NG+iDvMyQFn66haSBTIC+pa81hE72ITfnMlJ9nN5zVDo
 OyUBsZ3qH52ZBQhoPWOWrqLSnKC77D/v6Xb4HM5BB7QQNZY9nsDUTyPS6nyBD6FKd0CLQBt042D
 9f8VQXallJPhYjZgBNTbJ8AbAjVBaMUeruOKDEwBYC9KPu2AQkIyRHwyfqcbCtfAJkgI3yVRxbK
 n5i5zOnjbQ9xPxH2dMA==
X-Proofpoint-GUID: DPB1j8yFsyHm93-chQCLvynT29_b4X4f
X-Authority-Analysis: v=2.4 cv=Ebn4hvmC c=1 sm=1 tr=0 ts=6a031ab7 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=gcnggjyPzmaCdwFRn6A1TQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=rnE8NOWamw_VgadXKa4A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120127

Add the missing Eliza SDCC1 interconnect slave ID and provider node.

The Eliza interconnect binding and provider already describe SDCC2, but the
matching SDCC1 CNOC CFG slave was left out. Add the binding constant and the
provider node so consumers can describe SDCC1 bandwidth paths.

The provider change also adds qhs_sdc1 to qsm_cfg and updates its link count
to match the newly added entry.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Abel Vesa (2):
      dt-bindings: interconnect: qcom,eliza-rpmh: Add SDCC1 slave
      interconnect: qcom: eliza: Add SDCC1 slave node

 drivers/interconnect/qcom/eliza.c                  | 11 +++++++++--
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260512-eliza-interconnect-add-missing-sdcc1-slave-node-65020a3b2ecc

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

