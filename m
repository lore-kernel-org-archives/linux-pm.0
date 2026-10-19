Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD354DF4BE
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419177; cv=none; b=b8Z9xGWiV3z6Bu1d1Yw79oLjaHeW5QO4jlvmCJWK9/FiIEM3xvm9feiS2xGKWy3CSywCqh8kvlMrpvYv8jHg0JA/ZIsY4f9PJTVwZ0Sxq4GnqeWF4M8dojnATHKTDrgtvu6rmgMdskyQgVuFmLu2H00eKT7f+B6OpD8s5JxsJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419177; c=relaxed/simple;
	bh=vRT2w3n7Qrb+3plBNb2bRDxhTNqysXhGi2Bc1Yyvx0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BsZoIf7xBqXuZbbpixYsxigJKQek/aAIHhjVkNjcibVK+vOgopZ/br4GY71TJz4hHbDpfphj9AuUnYVs1O7GzHCnQnq9TUiBrHD8vPZ7dSFxthjI5p4iZsr6+x7XJj1khmRpn0ACa+buqnGx+EkVMTO/5J1ufF/nzBtBYA5k138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhltfZtn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heI4Dc8m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhltfZtn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heI4Dc8m"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0CJ33990548
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cnfM2y8WvenQ9GTazeyc4m
	QsxsTJFDmVyLPzApM3Uhc=; b=VhltfZtnjEBK+aqL0/7NSSBF6CM+F729IKcnNi
	Uf2Y0gILccbAIU3H/mxsuvH52YBd5ALrzgx/dkVyzMv+a5GuUeBL6C4vUA9VWbCl
	v5jbzxOvJJwxG9Rye2XdeQ5Eu77cqXN1tcFCiphwyqWCGFkFcKofMkhV/QoidZtI
	Yo9ZcaGR9rpJIsT14TrHw0MT119utwqwHSow/zkDmTDeSBD6Osk2OV/GQHtaf8Nf
	Pw22KV9Oag39sMcouTndqab1HSh3nvnL95tCnksxTvAkUhFj+fLtvidU0EMu4kh3
	cHa/LfOsfUhg4QdrGYN5PcrbRGVvPPKlBLo7aOrudeF/3NIw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f9jam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:12:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a3f673221so827628885a.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792419175; x=1793023975; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cnfM2y8WvenQ9GTazeyc4mQsxsTJFDmVyLPzApM3Uhc=;
        b=heI4Dc8mxvMhcJhuIAuXJBf0hJWWDy0PFLAo07dtqQ7s7MLUWdoZN73TDa/1UL6pmq
         nq1TxUHNhRKPLc1CeSv+qHF6Aj6cUIOlmyOBa4Fb8qgNsEeIu1y0meF80JLgiOnByK1N
         7K046i8pCs2MLSdMbifR+o83tcdlVHJwXb+EIN3Tn1oWrRJBRcEJoNG7et0UwvaXPXZJ
         yrfIepQsp7b2lpR0SD+334AWdVk0etm/qA9Zn1J1bewU6RAG/CcaTsBjt4ENc4d+3d2W
         XfoOwFE+DH86dpv2JT0I++yEQSACEOhbTnJO0LBWSbNE/sKab4fEOihtSsEltS3zjaOn
         n1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419175; x=1793023975;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cnfM2y8WvenQ9GTazeyc4mQsxsTJFDmVyLPzApM3Uhc=;
        b=PPii/PYGKYGsA7SBVcmmU9Ase3KJ+STwcMZLOMD9zL470vyfSeSCvZbNt030rVYyjZ
         voyTolLp6ZJ6w+y/udW7+EvVG1Ln4NRsVG4kkY1+S0NYOeqPQAzzAWAWefXwZ2C8mPUB
         2FhGGTpS8e2Gwk087fN0IKlRYXr4KX9fMsoy0A+3R2H1ZUKZVMXNMA9NB/IO0h+LSJdI
         q8AHIicWxrRm48PgVajgwiAvgjWY/ZJSkP4jNdjCVwH+pnHMsDXOBIbVrSYIzUoM9WMu
         MQFMYx/rbpGHWSSOParCjro9F+UXsx+ff4oG1RcbRZTvrNsX9Csevx8mmf+9oSldSv7A
         owZw==
X-Forwarded-Encrypted: i=1; AKwUvBxshxkmKiKbhhuPoxnh3+iedH9I4b7mjnQgLzxlgAX2WFHXQVTpqTENp6O/dO+FY9fdMQhoFaNOhw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKFwJ1KZtIUnS7wsqBuS5aT9i3J1N+78YisgxRKBW7GdWheHKXF
	yjD4GaOAAT+Kkynd5wC7IfCEj4lSWaFYwauc3BVi5FsRBXJxfAK/RZOkbdAHgADyYaJwahgJHOd
	Df6er4ZFJN3N/hpWf+vzVvmYjBhje5qPLY5jcRkABvw0xNMVS/UsRF8BE80L43w==
X-Gm-Gg: AYBFou3grWUsNSKd+afJTV8P1Ip4Yhuv5T8mNVQWUBZECxYZAnRqZlPvD14GpreI/HO
	HLD6uXXlsiUqxeeZDHFLo1w5Jm0Oxw2GY6qFmS3jidmOH5C2aXSQxmuhR0y1Ta7uwh7eUHFqJx0
	R59GxfHmfzxsIpN2Ydip8NGdNjWQ8Nv7BY9dabI8mFw4kt84IGt1Juezd/RE6zbkqYUuWbBlvBx
	UQHCt/vhelXXGMlPZYpeGoqBPxNF9dsEmKPVYTNKklXidyPnn8X+eM725Qg2pitNqLAtr6lOMfa
	7jiVLfet3JWZ7YJEwWBkLGqp3O0zC1dltN9S1rEedk6vbH+jq0ImDgLpn5RlwCT13hrRYQP+eqR
	qN+DpSJ1+xLXYcCyz2dbgGzFFv+bFQm5+UQvJlWMsoMlBM+qnjZzEUDnahE41RXLzut3DusCeAD
	FyUqMJWZ217JFC
X-Received: by 2002:a05:620a:1a14:b0:93f:1437:2e58 with SMTP id af79cd13be357-93f29d70c5emr1305337685a.56.1792419174536;
        Mon, 19 Oct 2026 07:12:54 -0700 (PDT)
X-Received: by 2002:a05:620a:1a14:b0:93f:1437:2e58 with SMTP id af79cd13be357-93f29d70c5emr1305333085a.56.1792419174039;
        Mon, 19 Oct 2026 07:12:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42ade9sm2015922e87.14.2026.10.19.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:12:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/8] interconnect: qcom: implement support for MSM8998
Date: Mon, 19 Oct 2026 17:12:38 +0300
Message-Id: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYl1moC/yXMTQ5AMBBA4avIrDWZEtK6ilhQg5H4SQeRiLsrl
 t/ivQuEPJNAEV3g6WDhZQ7QcQRuqOeeFLfBkGCSa9RWTTIZa41i55RBtG2dmVRjBqFYPXV8fre
 y+i17M5Lb3gXc9wME0m5xbwAAAA==
X-Change-ID: 20261019-msm8998-icc-8009da583105
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vRT2w3n7Qrb+3plBNb2bRDxhTNqysXhGi2Bc1Yyvx0o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iVZq1byP3JEG/VsBMq2McMM9ItBJLdbJG9KD
 1EnxfRLVByJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYlWQAKCRCLPIo+Aiko
 1VpTCACxuteC0/lUC0a2u5RHTyHpnMe0Tn86fLviDV9c6y9XgElNukeemcQVBx7pd/hTDsDQWwn
 W4vwC3KgMqsbLnlAcFbC4SW06eHUwRTOkssj8BIU+TrN4SKOWk8vRDiYpUMj8StWYy3JU5AygID
 aBt+cwgeX6GR6nldQZoitAAtkO/cFwG6xdyyl8xRugFfFb+O0TMicQ1qNjK4vmTaYIZJCEkEhwA
 vVvklNhAenQt58vrg8M9y4AN3ShFLbXDT6XPjHOAZ5Dbg5cNQ+j4BdAcb21fnFhQ1nk2ENJOO2B
 8iqUerftm4N5vjGafl49SNNk4L4rYI1rfZTGEb6nVPRT2al8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: _hCde180YteFszshA1LMLeqNOyZeOEsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfX5fqPukhxSS81
 5iXV5qNvqm378LVfZlR+0LFVzFgR2syg45qzwxyqCK/PK5KTTIRdqBH2B32hLBNU3aWCFvHnK9/
 aGdj7B4nqvYFACiS9knm3hdyK/5zgHIkkYtnd/9cI+MTvVsOEtIHmnSZBHj7AUlkXzQoFMnNstu
 Yo6qYsvgt+w2cjA4IelpQOAcsmqs1upYnlFaZwjtIxJUSKnWIySc0rRvWvFynCt5ZxnVKv9aVwR
 4Am1MiI/Y5rZ3RimQr2MhWbKyXw0JsYKB7JdOXgghStxdHSaSoYUqEWT1L8gqaJhscPfyO70E6u
 xO0U+CkJuw0cYCicGHp/4lde+tJF7YC8zQGj2y3SBKaIcaL7WAwckKCgKkhKfe6RWAQgjuvcpGD
 y4XPLnub8xBPjHxGFDva+8u4u3bAhORAiRPet+A/NpkBw0Nal06b6JxuEB2sAyeU0TC9oILE9o1
 u2viqoLd4p+0QsyZJxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfXyDC2ysPwqwyV
 m4GRDPW/afrFFcPO8tgIhj0yC431glx7wQ3bFPgKnfccVCe9GHhF6Mq889RJl5xhEicWF5qk2QE
 doatbp9ZNhsMa6w3guOXvhwsEdp76Dg=
X-Proofpoint-GUID: _hCde180YteFszshA1LMLeqNOyZeOEsC
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad62567 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=32IeBcnPeD8AdjLfFjIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190056

Add bindings, driver and DT bits necessary to enable bus scaling on
Qualcomm MSM8998.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      dt-bindings: interconnect: add Qualcomm MSM8998 NoC
      arm64: dts: qcom: msm8998: add interconnect provider nodes
      arm64: dts: qcom: msm8998: wire up interconnect paths

Konrad Dybcio (5):
      soc: qcom: smd-rpm: Handle zero-length errors
      interconnect: qcom: icc-rpm: depopulate SMD RPM child NoCs
      interconnect: qcom: icc-rpm: skip duplicate SMD RPM node votes
      interconnect: qcom: icc-rpm: Allow negative QoS offset
      interconnect: qcom: add MSM8998 interconnect provider

 .../bindings/interconnect/qcom,msm8998.yaml        |  192 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  127 ++
 drivers/interconnect/qcom/Kconfig                  |   11 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/icc-rpm.c                |    5 +-
 drivers/interconnect/qcom/icc-rpm.h                |    2 +-
 drivers/interconnect/qcom/msm8998.c                | 1978 ++++++++++++++++++++
 drivers/soc/qcom/smd-rpm.c                         |    6 +
 include/dt-bindings/interconnect/qcom,msm8998.h    |  133 ++
 9 files changed, 2453 insertions(+), 3 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261019-msm8998-icc-8009da583105

Best regards,
--  
With best wishes
Dmitry

