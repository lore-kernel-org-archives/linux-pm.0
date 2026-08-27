Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66734BC003
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853185; cv=none; b=I4gfkI/y1Im0p/JUPjcsEvFvPitu4XWWguB09huemEkhTXP/sDTdAOz+lLFgkjAj9GZsLalILxYtFiaxbx4uRbSyYKCDwRgzwDKgpbVwUDpPMIUAHhjl8so8GnG1OtKgM3+6i3U3tAjEUVXmfq1QLom4GBpMvpz+pOLyMXYy/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853185; c=relaxed/simple;
	bh=+/+CnJFkK28UfCOUz91D0FsS6GYOqD6AEiwdg9UDtAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYk8H6FtMz9rrSAZgpYAImC3gDl+7Eb9XyPzbx/VsIeYfX0BB/MvlmutWEm3cNd/wHXPXELQmsGs85MEaKmRRs/a0+GCi/gBCo2yniuhiRZoe7cWJhaJ12WDcXEI1eeQUR98rZkrBExclYXCDhKKT4gagfhdrG50hp+IweuAVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XveKuayk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dRWcldDQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XveKuayk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRWcldDQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHYHjd3613847
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=; b=XveKuaykkN0fyFu0
	oyzT6oSjYAB1CC8LaAlXMiNGzxKK4bODPslUpyRn/9nO3Kf/QBwXzzRvR7ddSitD
	UIoK4dEm55z0GU1r1+2qSljuF196tNvAi9zQS7gh4FPvYUppdo0DVyPz4FQ7mmk5
	jxIH95dYG1D4Zc1D2sdeIUJs5Wf5ZNMibzEES444Cpib+vFG7MlqyKjtVDLTBwRO
	yUjBy5BeP6my5z6ISXHM0M0rfOs3yiDQoiddXcObRTvE3WzBNT64Ndb5aUczdYSP
	8/h5D76PWHQCn9Q3M3UlYJTnKjox8D1QWQ3NBdethPYFzjgAsudHoqDfmtJuEyxg
	Drh2Og==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t3x5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa55c9430so1096005ad.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853179; x=1788457979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=;
        b=dRWcldDQlJI+HqvNLey3KHeQbbt2jP2S/GOyDeLVho8zLcECDhpIvpAtYeI0SfW6C6
         kkf2zBYMbqdCICQ2o8+r64+uvgOjM4XIKNRNoqTFrU3UrsW3y6V18WCySQemJ6cpnDnD
         +hfnOssj1w/vD9LFU2AhirQBQcrKazVxz5HKRXfHzznM2JOfT6sRuxU/wmEXzBmcRkdM
         5g+V/lUczGdVplEjSLdVV7tOFP0golZXrvEGAXKLEnB2Btd7DhKdEnH9w/jQ0jOdi8Wv
         js4e/rVmTX1VAUR5u9SnIiw0klZ8J6Y5hBs6fbFQL3TU4TPPMnmCGPEcG3vnJR8XN/Ud
         5nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853179; x=1788457979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=;
        b=kpgipqbdN4fDXpfATvluQu6gE8vGKMVGh1T45CVGsZE2nviy2c9pGRgyc+6DvhuPs5
         8yP76wckjZszQfTkLW32d+ih3WMLWVgAduGtCnHz6iX+lKSekfEWBdj4i9Y06qbqreez
         hiF1tC7xkk51cXs6j2syLAovgG9t/4NyKUpQs03vIPR1TkBUItqR1RUFuKj+i6t8KEw9
         zKw/L+IoMSsYQgwY6nlzRvlUMwL9+vMzCSox//cZDJDAvHAnxvtMmCCcaG85aeqncNSP
         xx+kRYHNLBs7NRa46Gkf4ma4o/5oXI8gaHA5VjtEVxO5EUTiQDR/SP9GTJDU91d8Nwwl
         Zk6A==
X-Forwarded-Encrypted: i=1; AHgh+RpWp8zfA3rJpH+sUe4ca83tRkZNM54pxjoXNB9Rw+BIpZ7J7alWIwwVEbcrTlLDvLBUC2jdZxDXMw==@vger.kernel.org
X-Gm-Message-State: AFuF++lBFx1fLteAli7Iihp9Bfq/02dz4zFTN7LBXlz/eTpbVJYMNCOY
	b14JpLfVa4jPdhYc9hKeBBsKyCtMgyXfOExbOKZaIb04rZ+3xBhRVC5BfQfuKSvhYs5SFdSTZ7u
	+/0HuYJ+QlhGCxzjEx10E3D0BdVikyq7ZcI7620eJw9mlBXwqClJeKCztyySFoA==
X-Gm-Gg: AR+sD10zGJSamMBau65mv9mCHmLd8yfLSMC4BAeNYnAMKqHKjReugXCEZbqHdGi4Yrq
	yz2MEUnDRmZJdeDrAtDzPdBLE1AfszEI7vnkb+lKY5B1X4G/jDa/bEmISNnr1YMsJbuf/WKSbep
	CkW7IatWm/QUF8yUSIpVnS8wvxNv0zgraZso7cx/gqNm8IciL8WfwiPkuQyBQwT02TLOdIRpkFh
	RRNjLnn5NgDFmtDxxB1AaLRU+k+aq8j4XrnuDAlzncxoOVNYodRZYb+a5fcGXn2OVBjOZMfNdgD
	tsMhrZX5b82GOJGfYD7UhsSEca++PO8EJLc/U5UKa0x9eT+KU809kWhm6xMjJgzJsuAPPUcZLTD
	mbI1601HKw2E93o5xUnnI5dDhBo7xnWA5lODFoHPSc1iFuDPASF69WiUDdrjfPVIY98otQ/Ojma
	SFSrWoohnYXv2N2EYLHfXzulw=
X-Received: by 2002:a17:903:15cf:b0:2d7:1aeb:739 with SMTP id d9443c01a7336-2d74e1295c2mr11086605ad.13.1787853179195;
        Thu, 27 Aug 2026 10:52:59 -0700 (PDT)
X-Received: by 2002:a17:903:15cf:b0:2d7:1aeb:739 with SMTP id d9443c01a7336-2d74e1295c2mr11085775ad.13.1787853178763;
        Thu, 27 Aug 2026 10:52:58 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:52:58 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:15 +0530
Subject: [PATCH v5 12/15] dt-bindings: interrupt-controller: qcom,pdc: Add
 Kuno compatible string
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-12-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=922;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=+/+CnJFkK28UfCOUz91D0FsS6GYOqD6AEiwdg9UDtAE=;
 b=5+UqgzWqWAt2y8pw+wO8S1gQhj+ILFb5zZykxqwlJVi4SL1guDDGpMcNI/73AXMXGq7fNAD8n
 e00Bc2sIs1UCSRq9bFhRuWIPh3sI+xeXRdBycjDqBUkKY4tQG6SPHpa
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a90797b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_KRvd0mH2JNXacczCDAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: F2p210gRdsdCOzC0K3GbljBvtxurGPFY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX/5uRVFdxvtuH
 ZL2WJ+mNodM3m8s5MkzlUNom9xtn5OsyiKjWJb7gxzfSop++aU+leSssNKnwMw4DMgm6eu3Vo1T
 SkFgsFTAB2xdHzK12A3eUIzxvpgP18g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX4yB4EJZzjtiU
 +l0YV6DoGGAB229inW3KTYhi4Bcq5J3JjJZ3fCAbVefKXzGZzp+8vKem+1/4UnAbu3TEu9/Y8B6
 zz1l5zBEjqiBheuRvRWf0j2wSMtdBDaAW+oCoUwh4mN/bJqF+a4yfRTmXo+kWp9TN85gqoh8fdF
 Hy2VRIm0sQ1teuOlbTB+RCo7CKSAMg5FlJe8vrquO3c/EBVFsnxE98TygYUry3HPgSgrbJ8soqK
 98J1HIDbZuhJrJfdldGbj0VYtsU+60QnsP4eO5P5X/IKqpixn3bSF78jepef1m5QmCci0QnQdZk
 OHpYjuQvGbSLB/PS5ZU7GAuOAMB4sZMi4XokJxizCNxrFWGZcP3wP2GmTekw6fKiCAt57fSBfA9
 Nc4iyqCmZQl2pYerzJG5BhmSGHFjEBUkVlRly5SBFXLEHn+eTaPwwD3IgPHFVLXNxJVosPRaYe7
 DEYBzy+jNfYXhETVkBg==
X-Proofpoint-GUID: F2p210gRdsdCOzC0K3GbljBvtxurGPFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Document the Power Domain Controller found on the Qualcomm Kuno SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d49a6..518fbf6b2761 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -30,6 +30,7 @@ properties:
           - qcom,glymur-pdc
           - qcom,hawi-pdc
           - qcom,kaanapali-pdc
+          - qcom,kuno-pdc
           - qcom,maili-pdc
           - qcom,milos-pdc
           - qcom,nord-pdc

-- 
2.43.0

