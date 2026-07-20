Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330737E5FD
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574219; cv=none; b=T9hdSURXvvTGAweSMOPgdFA8U7r+4OzFdFbRtzDi/tkpwnQhYroXzXznxQCiHamNfuqCdpLZULof0D9QcudLIGPbMXpBN2Y0IHqi6JumY6joyiuZelqeLk8IFhaKGpMYhUo0LYZclqrQL66mxyBhJ20jOXah+utMLgtSa1T4k2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574219; c=relaxed/simple;
	bh=M49zLdCDFwEnulcdNvR0e/0VDmNXymrGOAhAWO4iyOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ARbND9A+JwYH8gV461MyGVUZlmz1nr+CoOIHn6/oQU5vBDhLT9SRkxYQ3/vJc9i8Bv4HapytEL/CwIOyux5Z2Q52l42rkxFCvapq+XHySxyCoGOaGrdsHoAqw4EJ2VjWg/K0kInoCFv4o4geOsxzk3tnSDvJ7SVsBOoF2jqb2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kDFTjjt6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HdFayIUH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kDFTjjt6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HdFayIUH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KH6a5Q2962612
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/XC3AWRQ/CjLCQYpJHT31h
	Zz4Xd0vJM30eKPvD0LiMw=; b=kDFTjjt6k3/GLepGJVfLM4Ru++p/vQb+xfkuHl
	r5bv7yC4iwT5ts2NVc7E5VfHikpZ+mWFs0eshYozgpzTIdsgjefcXcbWq1y8rUCM
	BAT1kzZzfZ331ARuAI5n4seQYdFeaePrMfHn52vqZ4aWjPaZKAThMjvzF1naBdkC
	9gDJ7YUeDLlcq3n463naxmAburNldi8kp+ZfTDE6QWewIheXqrNDZ9gY5WFw0FQw
	BNiO5xZAbO6os+VEQ/56cGBCGv5Vw1MrJGfsr+3kyDn5CwM0dpLBlSrVZAhh80qq
	HFMwDwKX86B/Idjwd4vLTaHBQ9JQ3q5RoK/nhnVcTVx6KeZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y2jf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so204811241cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784574217; x=1785179017; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/XC3AWRQ/CjLCQYpJHT31hZz4Xd0vJM30eKPvD0LiMw=;
        b=HdFayIUHjLu1BkKflKfrPT6SHe1yfSWalKx7B8J3PGxZ8JAVtflA/jlh2C86CWlGyc
         hJ7bSnecQsJRvzJJfj7f955IE1NIyWdQNUIlxqTYHg3MNBI7HYeSEb4sDd3VZa9l5/q/
         5EXCFa2udltYLuY4MpoQXdzupTKJQLRlo2gq1Ek2n/c9EXZjRr+pM7p2SxXv3MCGKF3A
         +DoSBNy+eyP/QzvXpQqZPklO/PYpTc1d0oNoKxdzuX7UobbpqYiLx4SX1Rytc9uV8zo6
         byq9du0S6Kjl1ywmBlwKN1tXaQEDMM61YCJQb6loEZdn+LZpNY6mvKor3QmHJxXI8OCV
         Ja+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574217; x=1785179017;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/XC3AWRQ/CjLCQYpJHT31hZz4Xd0vJM30eKPvD0LiMw=;
        b=eB/0HrdGLlFXgBwxVy/YbPy5KqkTAJpkW46K5WUVSoIdhVtWMHtfTc1ABRAhFEvebZ
         9RjoJOiSKWxpWRWSCzHnaWhoYW/xn0dPG4E+DOgAkpTUTzCW9ErYDqvp3ArhWl8bh2oY
         3rU99AurFYR6/xf3TPMEpViLFuqDJKjdxWm4PKBb6/jtURbSGL1WWmTCbTScc1JKUrjr
         DnBNVUX6O6y+FPieuk/nUYkqpQ2y+c8WckjA+BzrmUFJsaaZoMg9hSgjVsS1Uw+2tEyn
         2h4aNBIguzLcNn0/IdD3yPaZMZ151tGeUdbXHYIg0ELTeS8xOqJ8sqRPJPpxVdJ+dz39
         2erg==
X-Forwarded-Encrypted: i=1; AHgh+Rqoxoew34Opf8pAZEHOlfj6WmN/rWJwyXhB8mC/0628HbhcPD1NU4Iod7PDa8ilN/wUXPx/aD32zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmunD3jeh/g8aCfuAi+O4mI7KQdjcCOFj7+5/aC0yri2RNuCMV
	50QuHbTyK+ZS+P11JT2W/uVxklLCiCzxsAQ+eddkBbACOlh9Pb7DW0Q5ZC22maB0cW0eHNYnaL5
	AmamViVd9rxTZgpSJDd6oaLd4d1I5zBCuAc4LR9tux+IR+OQwaceMLqCmzUWZnw==
X-Gm-Gg: AfdE7cmgLEm147Q/QNGxnXs8MFW/FoOKAu9q9QpzOrc/kQ5aPHyPpUviRST/TbuF44C
	8SAWvBQpAUQgkr67HSX268EJzXEXr6L105ifuy7KnxsVMTK+0RLWHUXXomaNxFKAKoHQw/Sr1WC
	nSj+eOtaQLRvWCMaSwdEY/PK/9ZcPq4lzZVS+MUywCotIJ6pxmHetobFO3k4eolM0ozdG/Uemih
	Lv5hVZ+Gec6/3XqtAle43YudUqI9aOlT9lqVVAe39L1cE2krquo+1Sbu9WTGistdeRovnpqzAli
	P61VKbD3xu6ro9vdtIHYcgYh3rn0QfQzgwUMvJUehigkfw4BXLHbaSqe7ylZ0KNqtISsdkQt8oo
	8uuY1h3mjhsnqdwpv8zPKjqzm
X-Received: by 2002:a05:622a:588b:b0:51c:e14:87ae with SMTP id d75a77b69052e-5213c7e69e7mr135591561cf.34.1784574216765;
        Mon, 20 Jul 2026 12:03:36 -0700 (PDT)
X-Received: by 2002:a05:622a:588b:b0:51c:e14:87ae with SMTP id d75a77b69052e-5213c7e69e7mr135591011cf.34.1784574216289;
        Mon, 20 Jul 2026 12:03:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954aa1a231sm181509845e9.1.2026.07.20.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:03:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/3] interconnect: qcom: Some defconfig/defaults
 cleanups and improvements
Date: Mon, 20 Jul 2026 21:03:26 +0200
Message-Id: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTQ6CMBAF4KuQri2hLa3oynsYF/0ZpAZaaYFoC
 He34MKNiW4mecmbb2ZGEYKFiI7ZjAJMNlrvUmC7DOlGuitga1JGtKCiKGmFrRsgaO8c6AH32nd
 YtyAdlqETJZagjZQEOCMKJeMeoLaPzT9f3jmO6pZ2V3RtNDYOPjy3Byay9v69NRFcYBBKs3pfM
 WrUyceY96NsU7PL00DryYl+UE74L5QmVBoApfeMH4T5gi7L8gIwQ8cmOAEAAA==
X-Change-ID: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=M49zLdCDFwEnulcdNvR0e/0VDmNXymrGOAhAWO4iyOQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqXnECNLZ+We35hlF8SaiTYUDxDhm0u0BBatNRk
 W40K36eDu6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCal5xAgAKCRDBN2bmhouD
 1/B4D/9RPovgqGXWaSu9V+Bebs0TiuffKmIzkiJtAPx4hSP4CkLwlfLMeqfFC8BhSTLoyRyS/vU
 uA437Krwo8leP4QeYndwigSrsouOli3k4c/ryg6NtoEJUvp+ZBqcMqeZkfqFlwBsra/sHq2GQCe
 nmhtXq/zYyjX4OLKirWsiodkbPkOaGRo4zYXMirzROD51tEFXcSl+sB1YACZmH+zk63jwAwAmUF
 o83DlHXg33UihM31/9kIJcm1+4+40AmIQn5/ssUel20WkOr/elI+z626ACBGahWvqw7PuXHQBHJ
 wUKjEEj6L/CLPcMW2lKZUjq3Kgp9FDFu60uidAawk3SRu1Edd5Y6aguC/obcLeoVtyvTcdbZDI3
 M7D+/Yocvx0SGsL7P1gVmzNc/MZbn3afA7GcdebR/z3kt5ixdrD0Ir1gWg/BLuqW5XnDHhUKX10
 Xhj/Fr4BwNssYEPycrdvj1Na/jxGl5Nz2qb7EaSC4uJwUubD3rdZbKLBzK9ObGPO2LkbteHIPjy
 dVdCwtReiuuqujVI43Km08cb+jAmFWL8usXzUnFCD63DriJGNS9Qy0fTD2uZdoACPG6Gb2oQkiM
 Av/9r3EyMfPS6woikp09wrOOdYahapuDnO8X2qjUtD/caRf2u3/i8n5xulXyIPg7794lYvzncEC
 3SH7AhA4RPmS8Ig==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfX3p79RPeSSGps
 OxTR8pRN8Pl4uVgyu65XZ3aAZj8zzzO5UkgYpFwDE6ARtcskCk80P0yTMJPcxs6CXLa4aLzEcf/
 8ZkOxtShCVZTM1V0fAV6gNYOx0ojZhM=
X-Proofpoint-GUID: 5_TnBOtLy09qcuBXOHVGxVP64xpEIKPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfX26nwbRgLXnsc
 5SmCV/B9mg/Rjk5u3yk9DjT/3PCusBNw47Q7FgsQQn303AiqECAYtKsF2GMxzpBpvgcBoEMvYEz
 s79oqmLFcu5Hl89J/OaiTcxFeSwhRjwL5QdIc8HG0KC+rJfAcqFWo8rbrJdXsA72g/1nQNVBIhD
 xvKO30actTupbP6RV4Rqj7+2afJ57nwJfaRcOrlBlUROPR2l/W9vHAljsdp7mKLL20bhtW4qSl6
 6dP3O/4w1O9eiCRVzgXzTFVXM6FX9/QoNAsEQlYKBoeqN3+cc1CCxEOy/fEkOEP7EOMMwBZDGeU
 hXIaP0r6dJgA8ZEsB2AUEzUBCWh2Em8O8CgOlDbJ4EJeXh7AKzjq2qCQ8W3Df1/HXp6MoDBQ8RZ
 fyDH4Ua/nRvzit5R3XCXRRtjbq0UEbIRY4wHS+Xo0YomsmfcYpD+x17DnDFNwLS4ZeX8//mzbrW
 0F+r6W3Z7xLQpRSp4MA==
X-Proofpoint-ORIG-GUID: 5_TnBOtLy09qcuBXOHVGxVP64xpEIKPu
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e710a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=tjA5nVWDIhs3vSZUhDcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200208

Merging:
1. First two patches via interconnect tree.
2. Defconfig a release later via qcom soc tree (dependency to avoid
   surprises).

Changes in v3:
- Update also Nord and Hawi
- Split defconfig to separate patch #3.
- Add new patch #2 for arm64 dependency for Hawi, Nord, Shikra and Maili.
- Link to v2: https://patch.msgid.link/20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com

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
      interconnect: qcom: Make important drivers default
      interconnect: qcom: Add missing depends to Hawi, Maili, Nord and Shikra
      ARM/arm64: defconfig: Drop redundant Qualcomm interconnect entries

 arch/arm/configs/qcom_defconfig   |  3 ---
 arch/arm64/configs/defconfig      | 31 ----------------------------
 drivers/interconnect/qcom/Kconfig | 43 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 34 deletions(-)
---
base-commit: 96ff9ad7f53e233e69f87f882b331bfddd903469
change-id: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

