Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DE4C9558
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328677; cv=none; b=jhXcVNr4D5JmwwsuSH1qJtmEHdsziGJMrxL+d1CveYNLpTC6JE1WXkFsmF3WILUFQ3cFUf5JeIqKroJbtp46ibriiXIZQSsSNecZJinzeu2dwloL8hc3FYKYPiZCetN4zmySDDI2HeozrQXSMFqq/4gqxFaVIlkbOAZXlwEKT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328677; c=relaxed/simple;
	bh=9JHmO47xFcHiKwRcWRppqe+FIDEC/EmRY/1PhD8wx0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThGGvFWEuqBXF1xIFS/cNSy0MaAn4GjhROF6b5f2TV4mo/OpVhbl1bio7dOP5hPyrhoRhDqXD4QShJFwNNkIOPzycoceSeaoHt116PnOs3gJzGBCf4b9Tlqisog3+xhBYDRPafLwJjzwJ4F7nzknt07RPo6eZeb4kioKUIE+OmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d9XAmLb2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cDZBAIUB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9XAmLb2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cDZBAIUB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmcwd1641333
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=; b=d9XAmLb2d3tEemEY
	/SV0V+IgeXry0mDhpnxfXqW1JuUmV9keyxYmh2XiCUi7KJ1FHXQcEfrPWSo0cwv7
	3vu+37Q2Vzu5+aZnKCitDbG2XLn7Mu9tONdEPOv8C/NARtsoc6Sp5UclXYAKep+B
	Hhp/D+/Z5TpHpiBNJf58LQMV37uLM5NKNFx/PMKRAMETckK7W/JuYzELNhatVZsJ
	QSvk7ofCY16GqUI323X4Dlpeu0n34jtuj4ezj3RbQuj7L2XLxaDEy70Z1pMWB0x0
	C1kHPl7BWWggG9Fhf9PVozA/NZay7YJ/atuBya/jXZXKuwLQ+B7BlrrGvgovpYAB
	dvx+pA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebuttty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:11:14 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b1bc2e44e0so1983401b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328674; x=1787933474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=;
        b=cDZBAIUBgqxl4HxOqUuLwg8GfBYw2hWub2BwpvMWVMr6jRJKQViVXctVUaF6+bXusE
         B+++cTuJqx+UQXRoaCA+QksMNtq89OePM+ilox8t5wcBUpxMMYE4czESAVW/owBoLU9u
         wVDPQc8csS0eGOqPsUEw/dGH+fHdgGOZUV/XYru+b6aPvUeolW8VPU0Y1zj1dV/EKfU2
         ZWYk2+xmSvjaTWPmfphV2B4xdYLw+zI9NK3R2A6ZY5aaU7H4VUDZJsSRLPYzliAQYzQj
         XaVTo0Sy/QzzOu7PcVaECvvZbsssas7sshpdhv0chOmbJyL0S+aQqjyb24sKFI/6lRpy
         yIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328674; x=1787933474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=;
        b=IiUumZxVkViwx7lz6g94lt1VJHcEDYEXJBVTZMz+cfMkeffVLRAas1FKyFWrT6nNra
         8GoJQMSxENdLm2qfgQoKzFxGs3WgApOEGTwMuRaGQ1uVHZa6VWR9T7kNF19Qgz5nd0Jk
         K87ErIlvdotce0HAh7oCrtgGARqfX/pQCM6BJ5cjl+RV4L67FCrY4D7LW89kICtQetJK
         FrmjzN4EuKqZDiULrTLVzWi83Pi5awoQP7jwgLyVoT12XZ8WccXuagG9gHKqHrqvY4/k
         6F00wmk8tv+MyLXJJ75o9D0PE9+L8Tl0Y+qLRrfTv89XULUH4DdNCURrUJGct4w0z/JZ
         Xkkw==
X-Forwarded-Encrypted: i=1; AHgh+RqVviJMSvtCIWEJw5dYPUN4NwEbltrCXCf3RcmuHsFeS9xW3VqQJ/P7Z9++rNWwO+Lwl1zC+u/w/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbfVXQXcAG6U9dEQhniTreSNCc6gKx3kq2YgSXYzqALIEFRoo
	eUAoUzg6YJzbFxca/VFqiC0o5CdVIFxN3xLFBYd+rRwx+BT3d2uiTCgJc6h5naGliDGy54GhuzT
	QzVzfXfFLs5V5wFUQadLvAvI3iz1qGWeey6y8JUEZlQ4TTkunxWP0H0YHpBld3Q==
X-Gm-Gg: AR+sD10m6dLVOtMfqiQ0LyfOrfUK0puIpsk1UZ0qQp8G/dwYyTcIdv+gzHSbADsGGH5
	5vS9+6aguHVWyHrP8ZvwuR49JTEFOhWErZprdcntkajN/ovuPgvSLan08TB2EI8b4ld5xyaCKeO
	V60C8sSJsDXLW+jKh9P3q4PyM/QHbtFoV2Ds0Yo+7smEXtvQvVc/OgDiJ4xY+fskG9S0/BrVIe7
	VPxCT+oPOVYXFeHpnIcbX8J/DFERl0Fwn6zUfBoGAHyWltoAfMztW+qPFWUwYfA+wrNWqhFRFac
	NFxeqNd682bKRb95uq/JTPt0BMnIQLgbgzh9wqNpB7TM5YmH+q3bItStAESMvL0IUFIi/QB6ha4
	+F2f0+mnLmOz+Qix//AvS++6cA1zm1xjnauJsszGFQjv7Rx27H0MzNY62AR5G9sTz7jedWMogd/
	5Y/TZVw2Re7vCm4SlgW6az4iU=
X-Received: by 2002:a05:6808:d46:b0:4a3:26e5:cc02 with SMTP id 5614622812f47-4b2ef33a94amr7457128b6e.10.1787328674364;
        Fri, 21 Aug 2026 09:11:14 -0700 (PDT)
X-Received: by 2002:a05:6808:d46:b0:4a3:26e5:cc02 with SMTP id 5614622812f47-4b2ef33a94amr7457022b6e.10.1787328673861;
        Fri, 21 Aug 2026 09:11:13 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:11:13 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:39:06 +0530
Subject: [PATCH v3 13/15] dt-bindings: firmware: qcom,scm: Document SCM on
 Kuno SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-kuno-soc-support-v3-13-196e2b306368@oss.qualcomm.com>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
In-Reply-To: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=871;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=9JHmO47xFcHiKwRcWRppqe+FIDEC/EmRY/1PhD8wx0w=;
 b=Ag3di3btT/XFPjezWsEE6sVb9FnCj3hpe8zj0J0Q0SOouAab1EOy4dpmgGa+2+2q7vu1xOsD6
 WyI4wCSjoG1D/AfPoIgDEjP9SKXjtAhxL2dv3aPIUrCAfJUfwsb3ZKm
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: drJ-BV9XvDHUkfmAx2Epj_uQAWbklzGr
X-Proofpoint-ORIG-GUID: drJ-BV9XvDHUkfmAx2Epj_uQAWbklzGr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXxYREz7NZgcgS
 Wqlizr7yExNRj1PxwJo/KvSaoy7zSTBYV3ZYT7wjd8Nr4J40cDYzYuikRkN609p/aAbuj8DJXFm
 pBfw6lz+sYBSIQYIeW9mZceB3xd0Peg=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a8878a3 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=M4Tw70yJP9P6qS8g1QAA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXwAafQ788LgOf
 tRsfiHqe0pStJ8YJ8EMrBhdOIfn6Vo2/e/SoUWo865vvFWthztFOAeLf/NLjHqm8JFRL+uX/9B8
 QRTOnGVYCyvOySGxlWmpSNTPbga2Iifp+Q59nyggEvIHLRGYkkMlZHhrJt1d2omy1JHbcRPf5bo
 omlJsikwwRKstKxDW1ow34ush8n5UbONWc//o4HGqopn2YT2+ELE+hm49Je0xRSNB9APw48TxzB
 rc7Zwqa29RdSaT8XtYooK5jU39W1liyeRnVmLsZwHbetlqj2uJNi5dnlXRVzsjbXjV29dTDgKNG
 oSRqPZ1CQUmVqgCisooPP2TMzk1VKSgb9tns6KS0rIVuYDSc8b3F/0uZccJNyOJIGRl023JqwQI
 QnI7HKLVNukktR3rmadn44z466GnDx6A2/6UKLFQlzlqd6sn9/YI5xynoGUlil8lSp2N+UD4gQ7
 ebhr8OGi2KhtJi8sCVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

Document the SCM firmware interface found on the Qualcomm Kuno SoC.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f718..ecee5aef65a7 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,scm-ipq9574
           - qcom,scm-ipq9650
           - qcom,scm-kaanapali
+          - qcom,scm-kuno
           - qcom,scm-maili
           - qcom,scm-mdm9607
           - qcom,scm-milos

-- 
2.43.0

