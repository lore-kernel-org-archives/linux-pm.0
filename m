Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F323ACA54
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260539; cv=none; b=c9VeWJBTonnO+hPKkUpAS27z8hSKEAWxQ/VwDOaDmYKEJ2DDo36zvp8pkSmGCitrQ7XThp1QV7Q9/1+OBYtkuFFSgF+nzb6rkEHcWq+PgluSNEXncm4HhPjTx4Y6q/+wYTxpSgsg80gom++wU1QqLVAs1lWXgA92xVnms+m165k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260539; c=relaxed/simple;
	bh=ShbJdNxhiNfmZPnf6dsWYJ3gqd5GdF+vBe7gD57oqk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+R3KkFtn5XUoerJ3Uwa5nSoMtm5e8NOFe3DLHQLeBKgdgqAEzYcggTePrTROMx+b4cASzjQLw/E2KcnLUynEdKJkpiOM3fFR8xU6KoCofF386DxWvNMX9Zi+FQNhfGh3jtSbAmeMuMngZWxMixprG5jiVXd7emzbrZ5olNNvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jk3VwGr3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dRO/I3iG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jk3VwGr3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRO/I3iG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6795e1vB1905859
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FrHlfrJLtBq+FFJ7bu/RFJZvxXsDP/iyySW2sKS0mxE=; b=Jk3VwGr3nGTH08+/
	U1p8fKfQVXapKn0laMwC5+8/iWD2luACkl81mMyi9Z5C/DRULYQlLyOZJcKfkT0d
	ncKDesKx0PmXrd40jXTEW4PoZAKMLTNO7aYD0fltsG1CEw6zGj6EpUmaVZo6n8d6
	JUNfk4HCVi1uVEo9Jeo+4z4deBhvbaGrTAX/8gRJ/JynEr1ASTCFqVfdo3ZNRoQf
	rju7eVi8TBjPRPnXM4n5eaO0DdbJksBqsoD8RT0oiiS1vlQseUR/f5iW3udVHuM6
	w+HayEuuUygjpO6IopeOG/9TAdK+7zvQDsVJtN3SMLH/1OS8RnmLBLdil52dCbkd
	Yl7TQg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvhvafpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:28:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86a9ef97so20444135ad.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260535; x=1786865335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrHlfrJLtBq+FFJ7bu/RFJZvxXsDP/iyySW2sKS0mxE=;
        b=dRO/I3iGgfMgQb54n9xIIQpgPdWBcXGfX2J9di2WA5r6qYzgUsPsCXvjSRD2HQV3NV
         LCIptUsoasq6+ki4pptWc3UPU33tTFTdXuvX3mMR1gpemIW/K6U1iigutpZDSDQFnsJi
         JYhUDCjTNZrn6Cht0DNgLmpEjWUp19fhkFw3Cg4jhTCfLg796BdOIFERcdqnquuB3vWW
         AoCGOENMKTLfrOGnlB8ydN2cg1H64Vphau+UAABjXYH7pCOTCiF1Q8f31BQaVE0Gt0PV
         M7RW5ZAHrF77R9GG9KhoZMbQhQK4vA7UmOcCdU2NhVHIqB6W9FJyy60bxmeFnTIiB6Ei
         nZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260535; x=1786865335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrHlfrJLtBq+FFJ7bu/RFJZvxXsDP/iyySW2sKS0mxE=;
        b=ZIPEObLW0nwwcWRR0n9euIG+jhaOElwdcp2rn9IEvABt03g+YIXe9TgkbxecUQkajW
         HP8S9rYxmt9c5UX4Has3eN+8DdbmryDRA1cb24hn/qeZbAchKyi9J0yJ1dUNGhKwI/uT
         7lmer5mf7LnNDcMH+6Gtvet1MN0x1rZ9xUrKg3MLCjjFj1FmPqPAZde/fmok2mjATcMr
         XBO1jK7xsLfxazmWBRV2aWx6nspWi1jcHP8KXSmftH+rIV+UjZVWYEohIE49sZDukNoa
         aAEsq9OLb4EiYdQFvdU7VtQKfGZBGBf17IPLP9NXf6ye7l8SuHv66Efcxj1gszYry/d/
         6H/g==
X-Forwarded-Encrypted: i=1; AHgh+RqWJuD+kwmE8JrazmgHnK2HYNDQxt2x19vXKHzFEFC5z1iTkBprTcg2FDLdAE01+w2FyRTR8piEdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqW77TBxY7fEGm2pn1pbuRgQ6pCJcy9MDpWin7H0sAFyx+hbL8
	tGLPkn54cBIojj3t4L/PEKsevMwLFn7FsNxFpZ0IV7fUtymrL24BcyAbSdE0or74zU4MVz1iZaO
	lIYxwLX7MzGbBa9iHwxAUydJgl6tMY4aFbVIn28up0DYim5lpWoun98GPiYvpQw==
X-Gm-Gg: AR+sD11/1No+cZ3ygI6Bk70gVkoH9ztQEmzkyIl83fNo9myngzSa5kSURXeQrD6n3WR
	W9fBn2N8WnZ+XM0WUGhPpzgOYjVOCu5tvOWvJKJ2Y0p1dpIvpS9mTeDc2zdmqFUIXy4/PmolBp2
	ESp9QRIFgzssAQNUHT9BpyB4vWFl2JFeBcvtVfvGpMEi5XYiV6a06/NEEnaIqc74ZENnlnrTyOg
	ggKxXhWGRImPd7uW1NZ+fyxjUWM6XrQ2JOLWMLHRuJkMMZkTq3xtqUgZaatVjT3metJUxv/RRAB
	uBOcrHDT5fg6LeFn0IvUHcNU/SE/MHTIcFs3YBaSKYiMbILhQPs5qGQbZKOMe+AVN4zADwehrrW
	mXJaMnJgu3jjKtfKVrleABEsblRruDeds61uCfiMICqPpDc1EXDr9ErwJ55KXQ+lXNjiE520bv9
	IggicSIy7Tu8lhlSG/09EiYc0=
X-Received: by 2002:a05:6a21:6e0c:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3cb85f4e199mr42895289637.32.1786260535411;
        Sun, 09 Aug 2026 00:28:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e0c:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3cb85f4e199mr42895245637.32.1786260534996;
        Sun, 09 Aug 2026 00:28:54 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:28:54 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:11 +0530
Subject: [PATCH 12/15] dt-bindings: interrupt-controller: qcom,pdc: Add
 Kuno compatible string
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-12-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=852;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ShbJdNxhiNfmZPnf6dsWYJ3gqd5GdF+vBe7gD57oqk8=;
 b=NoKi1AYhyMh+IWtxrB6CA2rbeCilVTa7VjKp5WtbRISlpAzsbKIvFCfssQH8P7Uk7V1LquaaU
 sewzTOI1lhhDmzpGbxJYXNhj9Ps5z4O6OQQthjxUD7FpsW+8LUJfmMO
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Authority-Analysis: v=2.4 cv=eqbvCIpX c=1 sm=1 tr=0 ts=6a782c38 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=E7BvvrGlrPUR2SlizuIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: uCY5AfV1ecM-m60N0AmorB1kINTPecBu
X-Proofpoint-GUID: uCY5AfV1ecM-m60N0AmorB1kINTPecBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX3PosqJ0wy7Z8
 O/q1GwBpj3zkRCC8/JxkwfC1pUO3bf0PIDM7dUVYb6u+sm1n5ga1VrG3Cy0yqxQmIE+VxK/PQA6
 HoLjtn9A3sxgA3UA9NQ2X+mx1uPuR603zqHNZ+nxTl7qolTsEtBM93FrQ5iEgn3ag6uxzHG184q
 03FqbsgGS/l9mq0c5cF1zTJTTcX/ZumKc/sISxYzUj86fnhU7kNJb/VRN/T7wnxrKtiBhYZy04G
 3VuBOcXovJPXm9Jl+Yd4qCp/r1/7InS+M9oVPw3M+6jAyDbcGUguO5jU58Twq2R8WSDsxTjAJGg
 GXjOEKvTyXQR0xMQIJkFSJdLQzfHnLWLq2xpVahnjtvTs6xfqNsfm9vlV9VRMIhIMbisVtdEAs+
 Sujc+cUz2fjeHPhVFgf9T88EiG6dMjcxI4Aey61TT5aPNbq+2PqsWsEvcxg49wMMRV8mfJKG/vm
 i6X3mEANiqJCxjn83+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX+edOYmgTg7Xy
 LOAHserQxSeSmFG+ZnnfZ2MYr3Baniwxwji7GGW6amJ0MYN0t29jZeC/pR4eBtE60+X/IOh+KeH
 oQq/jQNmSrUf7QwgrH3C76oC9z0fdvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

Document the Power Domain Controller found on the Qualcomm Kuno SoC.

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

