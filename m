Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B14BCAA9
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328591; cv=none; b=MY1vJ4EelSeJShX9c2SY6vrf58UoUYvDMkWyXmMr7JLs+rX/M++yqkDAZYpPqPRVuQuvmVETnMK0Sp7i9+xEI20fy7YSRnAj0z72Z04pYsi/YvJah47c2UCmrzI6WL9C58xFvzchZh0FFBqAkBRhuNPiXr4xUVZaa2DaKYPjpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328591; c=relaxed/simple;
	bh=PwVD29DtUH4dIGkOMbXE9qMjiF+K6OUxLIjMJeof/6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZw9llH2qLumHuq1xVYKrnRUOImP+0LwMwm0Kfpq17RLLXIui23aPlneQmHuMCasZP2ZZl57in878LDERKbwBpudAaiVNQFVzIIdaGkDlf6bZNeXO5c3aGWqyrwjGuvPaOmrOVKiohFz6IqNw9PUZxfd7ZzKtSv4w1fbQRtY8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvNWmG3c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fg/T6h0N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvNWmG3c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fg/T6h0N"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmVK51875166
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPYfTHbFrfi2XEod5q3VXPMVscV9WPdiBhHDyk/uC10=; b=HvNWmG3cGQB5SN1o
	4S3jxthaESGU+fyHigSOwfsTnZbKqpVnpCTbUecz1r5nSNMMinJgUXYolTR6o3ie
	8wT2ApfQ5/PSaP1GxDXac/14trJvUBgn9tAO7dg+OphPz6xc3jQIVWU9RdRzFIeJ
	ScK2Pz+RmxS2j1IK1IQfxdtwJTHNET+gP8z/o+9WwvZ/uyBRlg5yyMDl5RZGeNTn
	hiQjUdmKJb+cX8SYYCx3s1v+TjYuRbNCi5Fj736JNVVo6oqkrkthuws5OxUXtszV
	inVG5sRuw6mgdK9RC9i8TLgwY4HKQtOJXGnh/1YWyslE4VuCjkxDatf9JN/Dd55W
	10STMA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdeach5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:49 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b2d1eb484aso1940086b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328589; x=1787933389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPYfTHbFrfi2XEod5q3VXPMVscV9WPdiBhHDyk/uC10=;
        b=fg/T6h0N6gDyPrnZExDJ367aZ0Eg/Ku6g1Adl7tP5quVU9SJO9StKe6E+Dur94Zipu
         SPu8W3rIRpu6uuKTrIsUIdm2BUk9CF4ikPJrm3FYw6CRZl/+QWfvx69Y81p4kOR9sANm
         9cJNAve0F1idYot7jYPQXNJnxR/WDGZf46t3ZYbYHPoVRNWMnrf+xDzC3Y1UhshudEhf
         QN/ki9A4z6hqOg964g+QnU5Qo9RPSSzFlLPFOlTfhj34O46zmkRfoNXUFOKPpEl/RxuO
         alEIJQ/gG5csaycMQmpxLKwlidNzVSCmEZr9lZ05JEGkV97XbImuVTe16cQUHG1Ncmzp
         KjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328589; x=1787933389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPYfTHbFrfi2XEod5q3VXPMVscV9WPdiBhHDyk/uC10=;
        b=pdBpCQ6+fe1J5YyPfNJ8O2KVV40S+mlvSYlhtLXoNiuu235017C4CN9FztBcNAlmY9
         bzfP3C11nfhCraAtnonKmiF/Um0o+MCZJ2gsIIwrt4IGK2a1oxD4pK4M38yTbXEmqyRh
         c+x5y3B234Ci4JL3PtYm/iVOScU6XgRNMCrTCZCPtmNxk4gzymT6yTOYW1V1dV69hnKH
         +0h+EFmgg8MzIunatEQev+HPJk0qRZ+PZcWDVRV2djS0L8p7MxQWLQ0rtO6ClWpcXnrT
         LiIcudm+0mgUkRAaRlLKcKizpXCFm8zwT3kYFTMm+x1upXPKJo1wQJY83ooDoh7U1Lr0
         806g==
X-Forwarded-Encrypted: i=1; AHgh+RpzG8JYT8Ut4AjiqMuZtaTxJwJ83nOdCI4UETTLyV5EntY/KDJVRaI1f/A0D8Ox1jTMouzgan17GA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdcEjcRHbQ+QkXI9/yXyHoKs1WXS9wgaGG5a8d8s774VUFFYA
	SddeVW+QBXQ+qbNGMk76fC6f2uwPlsKx0a+q8Q2cdf6lX1N+UUKNmeIrF3KOYl3U94c3uyeQwQQ
	kMbRm6yj5Zh9xlvf+pUhUUh6MbkDm30v4zzkK3HKCryu7H1Jcq1Pg7lmfl4eM+g==
X-Gm-Gg: AR+sD118EasOWb0bO1BA0S/uKvIemXayiTeacArp1ZNCmNqNs1M1ZhS5W9Pa6utZFDI
	Nbqx3yTDawFz7hrho4LSN3aUj2Z9h+gcqRex+997ngi3bspAWfHLnM8cWxGX8cj2DtZnISWIYlw
	SWtldbllNJSmhutqbzcQ6XgfIQjer5Pa4fGeuLO7DCNUfO/E3ixa1n9NQ0iCKcE6CZCuLhis1J2
	QMPCx45o6YkLqg09LRuAB3QAKqWjeDzAOghz1nARVdLZt/D4v22krZMjxF2s8jL5ctdOoErDQUA
	3FOMGWBqX6CCl3R90flwazUoOtmcsVjjpoc6M85jgpNDpqeEAnws9Ld9T87nM8V8jxTyP3WnYjr
	kiHs8oc8pep2hm4zr64Ce07/z9YQxNCUkbm8ZafXihRZChp0oEzNK5e2oiUbyYT3t1X9+o2hed0
	zS4GFNdWnT5yXcbThq1BdFgXE=
X-Received: by 2002:a05:6808:c40a:b0:4b2:8ea1:b9dc with SMTP id 5614622812f47-4b2ef175630mr7078450b6e.3.1787328588585;
        Fri, 21 Aug 2026 09:09:48 -0700 (PDT)
X-Received: by 2002:a05:6808:c40a:b0:4b2:8ea1:b9dc with SMTP id 5614622812f47-4b2ef175630mr7078344b6e.3.1787328588130;
        Fri, 21 Aug 2026 09:09:48 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:09:47 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:38:57 +0530
Subject: [PATCH v3 04/15] dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh
 clock controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-kuno-soc-support-v3-4-196e2b306368@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=902;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=PwVD29DtUH4dIGkOMbXE9qMjiF+K6OUxLIjMJeof/6o=;
 b=9IPV7eFcmcQy3YV7XduUDzVOHCb0O8TQeRqyjO8MMMACqn9sPoWMnZYcaAMUrzKUCuPu/vqFO
 PVRyy4d1nvKCgSpIwfSYSyxpTfHjH7jkE0NF+jGaoQYV7MN4Ry/ukC4
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Authority-Analysis: v=2.4 cv=BcroFLt2 c=1 sm=1 tr=0 ts=6a88784d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VE4QQHX-7aIn0oL__EwA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: OfcrwdWTPm2s4gxtJTsKRMRWLgIwh7rg
X-Proofpoint-ORIG-GUID: OfcrwdWTPm2s4gxtJTsKRMRWLgIwh7rg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXyo900IpwX71F
 UXpK+R/8a8yR0tq4MH5Rcmi+Sx7TkN+vNI0MO+UqhS9KqXxYFtNKJejOb8zXbBMNjHmbKBILeu6
 YOyeaPE5oNQjmjq9ChqqVQdQ1xS2CIg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXyxPMmgLWl8On
 Uq/R7pweGademPUpeFSMaY6OSKenGvuc+co9VjaTI1p7FedUTRdnFWok7YDDemlyT6IO9fpRu90
 2Kf1iJt2pGWaQXUM4zRcDRIM3RNQCiaNED5al1rwf1PyJtron2XV17IAo2sVdwt950hI0aGFajB
 U/2Mp9LOk5PRHMNZkG0ffEhYLx1jV7cA6ykkshlAAK9nN+AohvS5QCP37bKVj0MVYL8afe3sa56
 HFJUr1EpLkxJQuG61Stxv3giGVTZs+nOlraUh0xK+UEhvRp2N8HUSs+NVUW2ctmqkYt25+feMtm
 HeYaH9O8dVaN2Lig6y6o2+PlyL78QvKO2I68kGm0deNvhLlT4J7V4aDSlAkks5HjAGTWXkkSGnl
 acmB7m/aYJG+fPrWWC5jpm1iq/44C4OGIyitz/6Atyssd0+IoIZIpocAlc/bIFrhfbbLKT8nVRy
 zGJQN7ovq5lgyw2kejg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

Document the RPMh clock controller compatible for the Qualcomm Kuno SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 2b446aca5207..9d521ac9c33f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -22,6 +22,7 @@ properties:
           - qcom,glymur-rpmh-clk
           - qcom,hawi-rpmh-clk
           - qcom,kaanapali-rpmh-clk
+          - qcom,kuno-rpmh-clk
           - qcom,milos-rpmh-clk
           - qcom,nord-rpmh-clk
           - qcom,qcs615-rpmh-clk

-- 
2.43.0

