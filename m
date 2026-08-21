Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEC4C6F1E
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328668; cv=none; b=HrMWj4o1Ahbg9M9TGUDxsUcqmrsxCur4VO73EqbaLcDw3CPUlRPgMp166eYVkzNQiu6yYkOfjLoducPhSIJlYyQlUzLi2OGHIMX6pvF1uwla5UOgyKl0P5kqt/AIj3wThJmSUOaH26MibMVs3suqufOXkeoXSnbta9wsX6uWn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328668; c=relaxed/simple;
	bh=+/+CnJFkK28UfCOUz91D0FsS6GYOqD6AEiwdg9UDtAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULgr3ob9yhotT9A/H2Mo8lwrSBOTLkTujuWM308Cj7NYBniZ50uhwvH6cWcVy+IbR2eg0HgKqfPTc3/K6lFKm4RTgQ/pti52QMQu2rAu7utkhu35qXGspboFzsFRBF1eLryNnOLokginKgoCzo62WYWSiyJfbK9DPl+vFTzr3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DcrIhoj+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/mKRU2a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcrIhoj+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/mKRU2a"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmAvF2645417
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=; b=DcrIhoj+gqo3VxAl
	tAgB5aH3Q1SeXxZuJe0u4LaSmlPLEOh63oYoo/ckaKBnJ3XJUkdDsz6hKN99ufzR
	4rfYJNYug5C7UvsvwIX45j1G2A5Hso7HenY0VGh5L3o8jqLhfMwBNW0gw0Bxaz4m
	oWiBlv0r7efT58Rm9tTWpn10p9fTpgNHi8glJjp1b68wNgK3pKQJV236uOh6K835
	kFQh+odBAX/BYl4UotEWrqXaCyYZ31Q3EMaFLpn5aXl5ww5RfZUBtk3TgWD+UPsI
	ay4aXM+IzfvcWH6dNW+zL4AV60tRtb4v3dUojZ3RysausmqtZ50bB0JwwOjw38CY
	H0eO1g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ecbasqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:11:05 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49aa4525b82so1781182b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328665; x=1787933465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=;
        b=T/mKRU2a+Fkwck9lx6vyWD/BcsiJ0x31YVTg+db9Rd9qDFOPoub38Ig6c4B+QdvwLS
         iDHzA1oagalSBFEfHBJGYidJ+L7C2XCpG7/JI8RV/dMhRtGiUdfOgMtjhS6dszWsBeGk
         b5zIdJyT6E9rNMwKW6JobxGrpdBQ5nkHqyUUmf5xv7mceOhbgxqfL/rp6vqKGlxaiAgn
         BuZWbiHWIzFmgY/3VanOVyzAglShZyLtbBcudHllnNBX8bIIBRBaKMzk72M/OXH8DTZH
         TZjsH7CuWq2llrCbkWg4Pn3u5NyJ7akqK63CV6nJE6u01ujZ91sXVGstICFMdvGot/KA
         fSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328665; x=1787933465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=;
        b=bLHHOIHxic0/uJ++QnAGBOiOljCA1+de3SD1yqqffipvWrhOewT18oe0QDtvWz+tut
         MmJbH7dR5dcxfK6iwKjQdwe1/IzyVxAkDykD8WaksRrpPQEhC4mimfV0C2/rq4IwlsF7
         jkVMoWUaoWaCnsAOSCzw72Yn8raqh903aB5gmt4z27Y+mbcXF1QdAsqZSdHGEITReKDC
         0FiuT3kteP1EBz33L/irFjf9RrqP0S23tuprgrWC3NCV2Jb6m9FEVD8fp5bCJoO8GU1t
         9ML3HBvSZsFLztl6kl7BOQjjoqORlhOZZjk9BdCwpIuA1iBld5GEtBka5t8zLp4kY/uh
         vXnw==
X-Forwarded-Encrypted: i=1; AHgh+RonrEw7HxnQXgEunhRYa4jxLxMgMPhH83pupd6L//euLQ3I1UZW4DSrAtCvQ+nFnOL/e/NxnHtTQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEIluncNjVlhE8HwxaonY4r8VYXGj98m056hsw4VoWYLeVWDA
	LcKVCRNrC7oA47EnrjqgLtDpnW6OqwrhJatrRT71jdGgUVZ9NYzkKzQvHXMbEwodXzV3tjhVc9W
	woxzYKLSRvoQT0wGTzqLeklfIXtCtuBU/at6LBk27dKRJrvLjOOegFmF+Mni+pw==
X-Gm-Gg: AR+sD12L/wTvuFFqNP68gXHTtYSklk1GlJWGAlsjD5Dw2ffFXlMzBXEkRaT0N4ru45N
	hsqTkaWiF0e6FerxNVLtSG3o7INGH8uiMMKMomgtDlHG1Sne/ioyRUDoepwLN4fTt2yopTQfnUn
	l9abQSxy5yT0qUzOoT3Sou1gb2Z2j4ADIm6Gr5OKbE0SG0PVQJudMUqwyTBVqn5IrO6yvzwQJyF
	/Cr/WfDXKBgxaztZD7GpkHh+5yyYGBsFjNzjnX+i1yapGVv1fspUPCj9G8tdU/S/8DNAmq23/PQ
	zZu6KxqCIXIphUTpMXFZ69vGvofRb5OdpQie2BkuzeWBvqO1rE/yycyhWA2XLX+44VDMZwwWH2P
	47nMltmC/RYpACXkHOTuAIV080Zyw/0DVEPYzxZmX40GAGHqEBEab6KCZ7LjvmZkPCIS9d8rcmf
	M09CpxS331ceXutf545mXqLVY=
X-Received: by 2002:a05:6808:6f85:b0:497:d1e7:5e90 with SMTP id 5614622812f47-4b2ef484825mr7959336b6e.18.1787328664802;
        Fri, 21 Aug 2026 09:11:04 -0700 (PDT)
X-Received: by 2002:a05:6808:6f85:b0:497:d1e7:5e90 with SMTP id 5614622812f47-4b2ef484825mr7959242b6e.18.1787328664353;
        Fri, 21 Aug 2026 09:11:04 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:11:03 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:39:05 +0530
Subject: [PATCH v3 12/15] dt-bindings: interrupt-controller: qcom,pdc: Add
 Kuno compatible string
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-kuno-soc-support-v3-12-196e2b306368@oss.qualcomm.com>
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
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=922;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=+/+CnJFkK28UfCOUz91D0FsS6GYOqD6AEiwdg9UDtAE=;
 b=2sItnI1/4L/9XIOYN3sjBKJAtfnUof413EvY0YP56XbV9w7Vj89ry+ko23SAtQezQt949xqJR
 aNNjt6EqrBDAYsTIf9MkOarrSc5KZaM0lgvJno63rZtiFUlIGrbWl9n
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXw5s2HGhH0G0w
 /eY/viSh1K7EvEa2DmCkfzo9DKvW6FhBfl8sh1zIHHQztWij1hf9lrooDOuhFnI70znlSh8pAhW
 37TQxyDCoFn4i8bXT9pjMBG4Nc3Rkrg1PRjHrWfky2B6CCcA2pO9R3mYdme+p3GtmwUSXs/HVow
 5j6k8/dSqxnpKVr/srRTnlIFqR2BU9KDNtOoQ29ES+Ty8UGy4R6V9aedb8Q162tdvxmjUJy3Alw
 R/hWrJQB/3Njbz4J1cmrauF9QOj4VzWaynRvHkc0nYzWEuksdObvJj6NFUUtBJQb75K775+3+6n
 NmZKoG0fImkwn7XwcLXwzJmsJnhhOZ8baVVIP3cBXWqJz+qeUPJhIMOEFn44wJfLxadcRZI7+DQ
 xAMNqjun6pdCmyZST3pig5EZfbRZRw88Limrz12rc6zNv/F9M7Lp1bOE1V/IOGR+My7fJlTSQON
 wXxYk7QAPROavbzWyTw==
X-Authority-Analysis: v=2.4 cv=e/s2j6p/ c=1 sm=1 tr=0 ts=6a887899 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_KRvd0mH2JNXacczCDAA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: aIViKDOrYV6KuhAwc_4N6f13EnqXydUR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX5i1G59Irg0YP
 8E306qf95VeZcEThLNoS6ciIyew5RxrM930Jra0fck03lNyAKGBrYS5T3kO1S8v5F2DXO1xJ4XJ
 cqMc0gNmltJ2vD7z3iVQqeye/PMo0M4=
X-Proofpoint-ORIG-GUID: aIViKDOrYV6KuhAwc_4N6f13EnqXydUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210126

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

