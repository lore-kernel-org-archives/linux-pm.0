Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2272DB7B8
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847086; cv=none; b=m8e6sbfOKtqd961ClLfTAawloKNe0eWci4kbbhY1OmjqmmP9eYJc0mK+FK7MmYIokKhj724pyMf1/RGxxYEQx193PPeoDRKPIX6tEz2YNEwDElPKIa0n4eMi4sP9x6ythSgrLKV7HA73R97DY3tUNWNmFnd0IboVa/2CoaLdToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847086; c=relaxed/simple;
	bh=XU+CHlOt5PhDYuZibmrNgNvf5AfVAj8geaBn/seH7SE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CnMLN7TohmI5lpWqwRVs496vD77Nj2MdZX7ZBiWkNLzxAGI/gUP3/vgqZXFeBVe8+WyBTMclw9pKQa2uHpzeTNWTj0jn5CO60HZR0XxzqpECW4IVm6Sv+pA8oYaIkEbQetdnHZgGcI73AiqcGuA3/HzHLRIMQEAl+OFkjvOWXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bomZHud0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMNYyji9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bomZHud0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMNYyji9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F98VJd1715409
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sSkmZYTIXecruKnIHKGbRC
	08I5nsUev4oLNdqPbSV30=; b=bomZHud0JkdOHRFEvU87X9Zgqe2H2ONXINNV5g
	kmVBvv5r25s+s2mkfaVLx2uL2H4/sV7RPFh9x+pjpqVr4Z8UtxFrL0tvD54OcPNG
	0vkFBkpGhZjpOMfCQm2ZCol9dI8CLTBSO3FKADLKvdksjsRx9mKu37TPbxYmfUU2
	5P4pzmm531mEDJkgvuwHpbciQQbGDksee9GGRoUVx+pLmmWCF84aa46t/siUfVrB
	m7whUbVSyWikDx0cFy4QPBn07VB/42kK52jInNAKgHDnMbLcRljBKZcRIL7zHxYc
	1C7ugaCtFlD5yvNi/f8FKL5UfL/BkPzw5S1LKXACie/AhqsQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxsxvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:24 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95cf2f6a8d6so1621183241.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778847083; x=1779451883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSkmZYTIXecruKnIHKGbRC08I5nsUev4oLNdqPbSV30=;
        b=TMNYyji9YotrgysNWNI/TJgjfcm+EqYP3qdFKBPdRygdhdxT3/zMvMisJJlvfzbJq3
         hPfgXJDepeHnjfsKuHl5WAQDVDDsYAM6hmyWYxLsmxkZjoMlmkNS0tj4hBbJyzuCFXWU
         xB1H3mavf0XnVM9+UM3AcCMXairvYZBtUWK43dqcG8eir8CqZNnIf1OvYU4VhH4u0EmE
         oaXKiUplFcpWMUiomqHKsOybR63hiXcRUKKw2kTj5AFW81jqQvmBXDOLpHxZqOFuPSyl
         HOSDf2K9umnHVsehZOQ9eVcU0sl7wZZB8YP3rMja0lPlj5QqurgGGKOoZSU3IfzVUsDu
         o3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847083; x=1779451883;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSkmZYTIXecruKnIHKGbRC08I5nsUev4oLNdqPbSV30=;
        b=g0k99ecMob+X1IZliDotxWa3KKOhExeqqEzS5OGBwipXbBufxIAUMtsXtKIk7Z8ELR
         UnEeAqUhODDx3l2Xzd5SNqHsqAbXt/v8pgD20yaQ2p1IO8bfkWjvhGCyxsiaq5l4BbdF
         nnNbmwPJuLIVfidp+9GOWanot9IW2hidBHw/aRyJuZAVk+Izq8vMFj6RGwt+A6AOBdOK
         mkqefiGOMI4JUaheXfGSopxNxeLJUaqdPI2SZBBAVByeRMOgTV3TgDAmG13s+sa4zTP8
         KjNYmQcBhuH89AkF/zHIDPpHMkgrIUVG9S0bZ38coilUkHvfcDJxJdPo3JKZ5IECSiVp
         NOlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OALrsAg+QYqP97Zx5wW92GNydw8NuRCQe1PsYvaZS22Eg+adwX+Zt7aciNgNeZq6FggOWcBpuZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxihg5KAl9NQigYpCqu1aOKOCMumjQFJH6Xg25XX7hBkfd6/tn6
	+mds9BfENsjihF7TEBr59pWsTQuHyFMNMMU8Iam97YWA+jJowdXERvA95MoRLUGkT2epO2LWLWL
	x+w+qbhKwbZ6AmMeCzfmUAQKAmqDdpe+QXSODh0a3uHJRnsBB8BrbUPaZ9u27nQ==
X-Gm-Gg: Acq92OHz7MshHqXcVzzPzs25hu3bRfBM8aonK//eZJd/w8/FxNEjafRlCeaw2F2WWPZ
	qGtW1QTQnF7BHaUjBwfQGrdW9j5DFNumY4kHR2QfOcAlaFv3Ts6QddcnfF4a3aro1PatwJtjUUN
	lwglIvek1f8CAtKFnMt39exAFxWWDws9mrGjohSu6Zz6hdIlqjks6mM/8Ks2OjtsQh90X9IVCL7
	3VmTkld0zaZ99yv8eTDkqUcvnBB8rx+YZZq+tjyFs2ibwUWIxU7uasxkFpJlhTfTrrk4Bb0qZOI
	JaOPLaYK/crVC7pQvRb58hmFJcVPU8jALgYhLfsxfjNpS78+Z0ZtmXAuxNaUqzR4cssvkIoMSPX
	xgzRQ59C7Dcq4SAkjAKI+cjQA1brecakkTpkmELc5w48t
X-Received: by 2002:a67:c490:0:b0:643:80f1:350f with SMTP id ada2fe7eead31-643812e4be5mr107681137.21.1778847082914;
        Fri, 15 May 2026 05:11:22 -0700 (PDT)
X-Received: by 2002:a67:c490:0:b0:643:80f1:350f with SMTP id ada2fe7eead31-643812e4be5mr107661137.21.1778847082312;
        Fri, 15 May 2026 05:11:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm66855685e9.7.2026.05.15.05.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:11:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/3] interconnect: qcom: Some defconfig/defaults
 cleanups and improvements
Date: Fri, 15 May 2026 14:11:05 +0200
Message-Id: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkNB2oC/42OUQ6CMAxAr0L2bQkbiMQv72H42EaRGthkBaIh3
 N2BF/CnyUteX7sKxkDI4pqsIuBCTN5FUKdE2E67BwI1kYXKVJkVqgJyEwbrnUM7wWj9ALZH7UC
 HoSxAo220lnjOpRGx8QrY0vvo3+sf82yecXeP7kZHPPnwOR5Y5O79e2uRkAGWxubtpcpVY26eO
 R1n3UdzSOMQ9bZtXyNi9CLjAAAA
X-Change-ID: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=XU+CHlOt5PhDYuZibmrNgNvf5AfVAj8geaBn/seH7SE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqBw1fnQN2uhVGsdrXzzWL3kI11Nw4R5g4iLmrp
 +q3qgumbo6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagcNXwAKCRDBN2bmhouD
 16GFD/kBR9A7nnTyl5hGs+7KbFU0oSLm9bfu5Z4ddAgbWejcuDPTCNsv31UXfqZe00Cqtg5V/pB
 4cbri1iSDhMcFlt6ysA/WFKljgxtM+MJJyVbRaLS8nMSIVlJ/d53jLrsMRLp76JOSCDVFlylQJ9
 zQnYS8Jh1xouIzRw7oqxsk2+hGQpaYYOuoGvn1LIwz24WqMvconuIcs6xHRr07RK3kTsA8CSbYo
 QGdpQ5hHWyWAAYK31x4Aa+kPzi4tyaj3qCo5pPnkRP+Iqf0tzh80ZA4RLNp5K/zfDPU8FUx/Hsp
 nyUjZ5zk4PG5DrBUfb7socXqOPUxPSO9JoKbiqdGSwiSRqrg5TewyXUCCIs9Ft6RK67hLCkZYfA
 CSVQ7Q6L6apYGoQll+5HdAXVGE9XczIgCRYYcb10hcWaJX84JFiezRenCefmD3TC0dvquBK9xPI
 aJv/2f9azbiQWOaxRXoIrhaOtOBXGj47t2RxjvYjAN8hJ9RoyFs8UHkoG0LK/Yh+pxP2124N7zi
 UNmdaapBoFva26d00DCVcbdtfMgkHIwd6ycQ8+Dd3dxDvUt68tOZhfSwT8A1ImE5Nu0YM6jjjgK
 pc+dpCejuzJIqUxrlJvTd0ZZY21NZfzqhDbjiLhZEib6aODrwWtGw1YTSMwC9nx5UVvGTtIXQNn
 PxZVBOBPpdco9OA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a070d6c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=baCi81C_hZCJqKNWviwA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 0q1f8o2urlmKCKZk7T9ivnSECa9rGtmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyMyBTYWx0ZWRfX7WGMBOWl9LLU
 RmGXNybPf6F38kNZXUfFnAo+28/qyuKx4fdTNOKXj0pxxcCqckekQSkghztPB022ijbIBxFQSSc
 t437mA4pRf4e/mhHy4+PvYQLft+MqCYNA60+GnBNVetKMO5nGaYhgc5n1uizkROhEi8YF9/g4q+
 uOvU2A2z5M7lRCqjvy7RSeOAX2dP28TvHECVHf17j5VZcyXUcH536xvN3HDDj6yM6yS2SlNY7v3
 DhJp6Lg+rELWTFoGdmB08o18VTqTcKhedK9ef/913OkTYY0po4H3j+2YqJGynlSukfFDng7xcV3
 EUOelUHbRMTlOp5F87PDos9YI57FUxhdqXj5OwA10Gscio4QSpcENYL+eMfowWuIkpbYXpwTTqB
 4qlMzoZIqujyOlw+gY89C9Pxqgn+vzOmqcBeXHfgFzXym2GmSmntJdsgI7fexbNtxap5L9ioDYY
 Nt4Ec3V09ppGlm9036g==
X-Proofpoint-GUID: 0q1f8o2urlmKCKZk7T9ivnSECa9rGtmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150123

Changes in v2:
- Patch #3: Switch to built-in for everything, with explanation in
  commit msg.
- Tags
- Link to v1: https://patch.msgid.link/20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com

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
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

