Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC5379960
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318529; cv=none; b=S85uPsvoEy9JP+oiKc0uNxoM/w2hJv64U3hhW/21qHn7DdLbl3/UIbWkRtjmS2vYVL5kKUftqve5J2YeKcW1msI01g0P3RKWlp9UTCtI7d5L5rBhEHj2B8MH9iZiTgkyQ8FA/rz6UJEuKMcM2GLhWhfPxjHTU0feJ+Uz2bcqZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318529; c=relaxed/simple;
	bh=mjrd/5WRTtizVxAileTEcsI3Pcwm5BCTvACtsLVlxwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=La0jObam4HIT9pkglFw7HB+qwCHAUOnVXmV1bMq4M7vsPNVNid4o3ZqEeExoZbDrnR2HWmTzjtwtshG3jLW6cBmxSnKygYIFcAdG3WUwl0PLf0WsQZin0i+quM0UJIYHm1U1NhEmZ7ZvMcI33nF9G4uIqcilxNwDqn3n2z1XvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3W2EEyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dg8DhFxu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3W2EEyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dg8DhFxu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Cc0pu599894
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 12:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=; b=l3W2EEywH4eumlFf
	+JtME6yhCjU88SpknDnysTzaxerik8WioEnysNT3e4pIOKqOO88e7GY5JOrGfakQ
	feMtEeGBE0dGgQWNRVMwjbPjnmjA8TwS2LxMfm74TD0oQNnOhgBreGZRloguEz9V
	EDahYCUOf8jIheSpdrosz7n3yw0WCvhPRq+df/dnd78Ds1CZDv9fh3d2+SsQdMrz
	J81QxeSIVRLYqWRDOZpyjlWrU3BDLEGwPqha9OX4Xv0FqDX0yRwnxedAVfRwMBpA
	clPDuw3rHkZ+fd84LxPRtJoWgmjAhP0Rf88Z0j6iLPTZDe8iw/Mediv7Kh1Dgw93
	dyBO7w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eha8r81qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 12:55:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso1810378a91.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318525; x=1780923325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=dg8DhFxuHiVtj+Vtaqc20hopSbe8OaCbHZJ5BQGxja3waT2srMdCpG3c4Ru4XqRSC4
         lmbMJ7yjyx+xAv9XROYT6k0WFcRFwJa3FnHGutQ/ZwpTtethDeZJ1u4/Fh+PIx7mT3Hi
         bek4NX2h99/iwt5UFcQYdM339KZRAEK0R/Hq92396b+rELMy4Nyg0CStgtIVOSa8TkJt
         laHqAye29xyaOzUWpkS+5JJMa0EIjwPzoJRfv9Ve11aM/HR81WfRtLyqypJ5Jm1rxdFT
         s8/pyuPd4H7z3mgszadljxislt2epJ0I2Y5G6rY/DEKToyCly7WQgkB9aerRqiqNv6Wz
         YX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318525; x=1780923325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=JbzrSniqI2GZFRO+AqAlWyDtzASdEZGDXZ4VKXf9c9HlqmHJl7sD7tBuIZakS7VnOZ
         QlLpPCNM+6ce6pcSM7+xyZMNl6GoW5GljTIVw327vrM4hltdxK7oAhzCZznJOpIv6ifh
         lsMirI7NqVtfj71oNOBhki0G1RDhgNtgI70xORNTOc5JTIJZ9m6bEgpGCFqGOuK9zCNk
         WQBZAJ1d5g8YKSGW6Lrvby/c1JmtFr0mzzD8KmajyNaIdV9wI6/4izdQlaGHFutWI6SZ
         32rfZWdiwtGOIi6cfOUQ5h4gfFzxQgXA5l0DfoY2S0/AEp/o+3tEeiUnTmm0DdHuw2ac
         1+Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+8OojjHD0ltGFAMOqjGKtaYsBvyFJftO1QLOxAZ7O+OAp37GaxNyji7wRip0qJ0Ta1Xq+vlppYQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyheSj7tvr6bXzyCXGPHiWup/Oq3+xVB0KN4T0vtP2r53wwoQMs
	dcmYZWXbhUTxQtxy0zyr9WDf+OPI/0ZSYoTHR6SgFRnLpFRktT/2QfbarQrmi8h1QkgzOJt6y34
	4KkL4RZPhF78YmUH5jrQIz+x629Nm9orxLXF5D7Q8TCiLUE6Jm+PP799o4A/Meg==
X-Gm-Gg: Acq92OHxq9zWrcZa8JJgdlaxP08MXMlMgNblxkLn7TqctY5Ymlj7I1/IwaWFvdi2wkx
	ftsdDMWHv88dZ0BJWTWUezc2dA5qtaDO8jpaAa86a7I2XU/7ICSsIkUTqQd5+GVscJSZpGQrUQr
	EL/EHPXd6BlVj02YBIZqM2hroNNX3I2Ap/YpiUJlFSZ7kJy6ahrUZZ4hZ//HIPqu/Rk8LgaA6fn
	w55oXyhY1+dqQPX8Wq2Kf37+2t6NrmobT94Mj4g19NUcuraj36AOCn/lmJV1bOeLstEvVLdxUC7
	fTPg7jeWgiBM4y7AZKAr6UDx8+nfJ5qsN4n2v53v0T4LSJnqhVbJEK6nz4HIHEPXOgMRiR5lGoQ
	MnMdCplRaJH3HsBfo1qJsO8s+kwPfUEqEVB4qh1nbKASEXmY=
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr131391895ad.17.1780318524716;
        Mon, 01 Jun 2026 05:55:24 -0700 (PDT)
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr131391395ad.17.1780318524257;
        Mon, 01 Jun 2026 05:55:24 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:55:23 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:03 +0530
Subject: [PATCH v3 01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA
 engine for Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-1-0fe3f8d9ec48@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=857;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=JRwNa7gj/V38SNuXulP2MlFnweDp961hhJdbueICCwE=;
 b=PJGykc/8otHeCXe9kKzIIFTmtdyPt3eYq+7eAlJXMGu5cmG26SuwKenbdaF6UjwkpDxwV1StS
 s6lxCjxsHJRBZ/4THsyhk17175p4NnSgUAKdIJ0BAlve9s0LF3dcNTb
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=aKnAb79m c=1 sm=1 tr=0 ts=6a1d813d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jyTGefxJr8I4-3Pae4IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: pm9wbJmtvGOSHc70LEaYKhblYt0rBDOS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfX2HtP6i/zr1Oy
 MYRmg1kSbuOr27R6G9I1cv5pXI1Vl8qvSOrYtkG6S2NX2J2O4X9L1c9yp52viIsC26BlX21XOiu
 Hy3v7gRfugtgQSopx8B4xbHiEbT3YS6wWhHT04EIWd+Ss73tPnIWLgIFapP5dLX7x91dpDKti3n
 P9sQFVxYZvl+lGEls2XbW5iwEFxvrlJEQrPPO8+ty0y1YLVfhZxbcJdSV5F57udZC39ksw4XQs8
 wKfX5T23/xaSipOfDr+e372rpRBLld/lThaXIsP1/knVEXNkYDvjqQfFlVaV7gI8lh7w7SaSy8w
 YYsxxvFXjqb8DUd0esDgvz6AkG2h+qyWABnqwYtWBSzrtvToR2NKfLlkMUqP1GylQ0eY9MIa0Hd
 e97hgDC2VyyQmUmpVja/N1ueO9MRfkTlC1Tx3LUjy9kXeVBiZo8CdyQnhym6fgCIHZ6iIPn66tq
 zs+lAL9toUPWv0/1Z5g==
X-Proofpoint-ORIG-GUID: pm9wbJmtvGOSHc70LEaYKhblYt0rBDOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010129

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Document the GPI DMA engine on Shikra platform.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8f9a552fe30e..54dca623223d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-gpi-dma
               - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
+              - qcom,shikra-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma

-- 
2.34.1

