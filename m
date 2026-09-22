Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12C3F0A9B
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051632; cv=none; b=nrF2H81RJSV8/wbZ0srRMUiuSKbINR9v0ojKnCs6ErDpljdEU5/8wPzr/8rgi6oFHqDPAr8G25QIavKxWpmWCNcHDyz/Vpp5W7na2FHRZOkKE8t2BZHj4rMYcSR9GhxmYe1qr6VxiA3nFz9MUDajRS3UwVCeLfpfmzZZYXwfiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051632; c=relaxed/simple;
	bh=fUNMC3JGXhbiq9Y6lFVg/e1xZgyALQ51mRBs5zUcqVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBkYumYOp/FEdgVlQVtqkHwi+7aw5n7ghAWd1v8EM+VF8/syaCyjQ5M7HDRWc6ypaztBFDL7GQ8ab8/6A2rRQUNQ989vdPJsDDBXi3xeCTZTqw3g1zc338vBzaV6st8Dg3s2tbWgA2l7uLDTGoSwittGcZA9vU8/ujBZkZ9t2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nk+TSupv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGv9cpmU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nk+TSupv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGv9cpmU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M1AtHP2173114
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TY60H3UdmFbtKd/s2I1ukfh4of0UVPIOC5ssJn5IVMw=; b=Nk+TSupvOCDlxZ5n
	cnZC6kQe3QxOZl4qJQ1LD07huOMERkD633M7pbX1ZW1sikDg28v5d6zWXl8F1Wzc
	KyP9sbhOy9RYiSmgSo1lHzrzPgFd81S4of6hLjIL/tcbNaWWZNgwRWzwqpay16gA
	aml8YFyKrWSuSTyCj7AzPhfpWh6OWSL2ubOtR4djfJudWuZ2Tb8VuLvEExcS1FmA
	AF+NNQzZCg2DQbxyCg47+Ttha5/igmYfuAEPxuXabMJJo3+bzQzOkAaLH7hV+Chz
	E0DPZpacfKkGx9g7aYvwfJVJZsroFUBrhocY2QGy9LfEe6McVEDa9vNQAHdmQNKD
	vd1KyQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsq8kph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3734d06dso64440285ad.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 21:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790051628; x=1790656428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TY60H3UdmFbtKd/s2I1ukfh4of0UVPIOC5ssJn5IVMw=;
        b=GGv9cpmUcI84qInG/N3c4mCvUkkBc2wO+Viu9YOtMi/aHOOJcRXZ79I5i0G2X4CPCt
         /23oJftOdYfAIf6kMASFy9Da4ZJuqULlZ0UHzA2UN7hY/DZxCdSV/+vm3BNF/9hPON9Z
         JHaQUNEHutGXqcC0ENY+mdxFAtWF93ZUE7QM3tsArhXk2BoNBRNqOaznvjXLYphr+EYZ
         xLiR0UubfJinpVN33GOxT3IxYAJ81cH9ntVPcqhMwOeKWCrgcXlKckoxwQWrMMLU97Kw
         43iC0br0GzXTGsy4W2bxZpXyrypur/n3kxq/MKnwksvaHT3myfhnzJNbjNufMJNH9P73
         LItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051628; x=1790656428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TY60H3UdmFbtKd/s2I1ukfh4of0UVPIOC5ssJn5IVMw=;
        b=m+mRnmlN6fCBY2ipvYuqOPm8B5hRc3DEKu2Jk8V/xqu0qoMDFnDjgVOPoCjVL76/nt
         hgp+kcXINLIu4vNQ7hmKwbVlNI29M8eI4iidt8IejdHO2nRv1iemqfsAT62jnA9bnHzb
         u9Z97ap6LoW14XOVTvmE4pfUCTMMCODTPxWS/yJuihfLmenSLkY+dFO5Sdi4lD2g8L9J
         o9a0Gq0OTeZ61+yRJBCQKxKKybiMDpmzCZBrAZauZjY0BqE1//SIx79dqv+ryaKbE181
         r8e/I8YO77mkMVTIQKUg+aOX4SsmmvDKtwAiXOkQpojtbWBGgxTgCAjgiEPECDRANN1a
         c68w==
X-Forwarded-Encrypted: i=1; AKwUvByyrT0ebIaCpqTx/X+v/Eb4agVpnMPp2xi15h0YMFF0Ml+FYo4LeeideJ+9o59ir0+8DGNhu82YZg==@vger.kernel.org
X-Gm-Message-State: AFuF++kqVzFjIoQjKMZNssabCDJgCl/uXrUGzidpYOzzNy1jifuVypcI
	TnwLo4TIUsju9ybalVJovRERuN9I9XAHfWFo0RR0tlrFNwLBIR5suNNDAqQWOpY5IWH+QqiWJBV
	xrz/6iTUpGQ2u5zU2OiSk3RV+VSjzh/Q+e++prd5SVQHXwS2+mg8VR19O/Wn5/A==
X-Gm-Gg: AYBFou3uSPdMzpFr1mZoybnonLYmWkArE70/hUL2aeel8XZ5cpCkozXr90BbU1BkE0t
	Zgb2RlEU6hH9/17+yW9PxQ2pGLlPYWyLG5hKSBUIsa/ezzMPJ6agMl583LC4akpbHMT/XUuRQvO
	fQl5f6nEJCCiOudaGhp5FKhsldLtSPMki4qIxA9cVWlUH/vggz18MLRlwsX2/su1jVGQxqn/W6C
	shktksDpE9OYOlkqQ+VoGPBZo221uTFGONfPSYR2bUlBIhk041ZVaerCLozWpo1qgLW4lDYWIfU
	TcTRlsJoQjPkaUVpcYB+AUtrqAyCfALkpbAwHTEgvcmUi+99Wq7emC5YD9duUDzLWjmoIxxeDPj
	YRXfE+MZkSD4+8mWQMv5QocLSA/lPVk3+ZQ82cA8Muvn8aHHcfWNBXI1N1fpb27u5Ag6E7InZYp
	cfDuGvSnvT+uX6qAaMhRAdY9Ar90kFTdSvNXU=
X-Received: by 2002:a17:903:1a4e:b0:2dd:c053:c20c with SMTP id d9443c01a7336-2df5b26c9e3mr13235755ad.40.1790051628324;
        Mon, 21 Sep 2026 21:33:48 -0700 (PDT)
X-Received: by 2002:a17:903:1a4e:b0:2dd:c053:c20c with SMTP id d9443c01a7336-2df5b26c9e3mr13235455ad.40.1790051627874;
        Mon, 21 Sep 2026 21:33:47 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129ad40sm1906375eec.12.2026.09.21.21.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:33:47 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:03:14 +0530
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom,ids: add few more SOC IDs
 for IPQ5210 family
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ipq52xx_new_ids-v2-1-4b1a0f3d04b2@oss.qualcomm.com>
References: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
In-Reply-To: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: O20hPCZToG87ch1UEtz570o1pMiRbAKf
X-Proofpoint-GUID: O20hPCZToG87ch1UEtz570o1pMiRbAKf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX+4xuAdDZs3W2
 ypECCshuSV/RkhQFxEw794ymSvP7X0pt8jEiSydzPjqnSf5zS5C9CozPZBkYFcLldev2nw6Vxu2
 1rJTzOLPCf28I45SSe7uDgy2KidVc+k=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab2052d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Ieg599Pkg-FuY5gSfokA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX+4MzRY+ddjrm
 1f8LNNAzdob3k54Tnfw63FTcPo0K08tOYZCAYppfrWbIcozNkQMGsKDYYFu8QJEato1oRc5yN48
 wl/X/AFNuTD9OBwPUgCxpkYlT1CRsb8j+bnR3bFKFcqsjXVKzF7GhuYY9B1nADnlLLHXOj0SL/3
 pqMjWl2vRu06t9Hpmge9lwAhPaIsUpIFLKkpgD209XPkQwWqkRg1IYTcPNWhEaqjPJetiRK8F2k
 FnZjXCm5UGVTvt+niGJYPVydcUNZTyr3GOCQFYq4SH6xIaHOAfptD4xJMFuc/1bLsNUBTJWx6Sq
 uHJ08JKi8mAhQkWZpai5nmM/WH31zUzBxs9mzzkfnK9KEM3I0oWsAjMaRWIr7nBrKSOxvtsj0lM
 W4sPj+zpTpvOtTBokhgmtxEHLEDyRs2L35xaMiuld4FWtTvmMV17DAVv4+CC5D59QebqgcryOEE
 J+ja+LqlVt6qC4za8lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220062

QCF3211 and IPQ5211 are the new SoCs based on the IPQ5210 family. Add
the SoC IDs for the same.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index b63e4a0b8e54..f251d4c75612 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -317,6 +317,8 @@
 #define QCOM_ID_IPQ9630			779
 #define QCOM_ID_IPQ9640			780
 #define QCOM_ID_IPQ9670			781
+#define QCOM_ID_QCF3211			801
+#define QCOM_ID_IPQ5211			802
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and

-- 
2.34.1

