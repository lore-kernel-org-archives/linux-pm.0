Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9A3F1045
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037580; cv=none; b=ee79TwAdLFfgBR0FbknXjw5t8o5psql2+UtlcMsLmvcVBLgzgWDQndtXC5qlsPJp933NFBK4apc5xtQ3KpHlfKR9JL1VTbTPmYBtTgHc6Bnh7evE8h8ehFyFfB5on1kGRd2aasb7WMOufUFSNMuaDo6yIbDgkwv9H9cpNpQ9c1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037580; c=relaxed/simple;
	bh=afn1e/fW2PzgzGse86o5DRe5vliScLobnb1hHsTpKUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkBL9gN9HUb3g9bcJlaMng9mwTX+XIRlzPVsGyNvGtc2tGS5/BA8njrzzAI9PlqIXJfpZx89kGADf3Y5BrVVnbZNPvf1sn2W1YfSCuFTzVj1M703fYeZcHPhNpWLgh2fPotm9D7nbI1URe8lUtG0D6oeaPTKNBuFmOZ5obSrXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SCDu7F9u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KayJCsGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCDu7F9u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KayJCsGK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3xZNP2738645
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PsWl1HZsnwl
	MvuPPgNIxzplQvHxqyYwW76yfoJtMppM=; b=SCDu7F9uMaUOTP2iJVV7P6AAwjF
	kyJH9D+yRvU5gRQ8JQ+Te7He1P3ZMKoKGOw9ijbNqMyqyPedHDuC//Po4INnbrO6
	/nRZ9yc5r0w38hZ6FohjSwWagGOiRjJWhY8fksupWXcRhhkMABVzeNHelcgad+8C
	Pg9wIUN+fqOEl1taoluKcE4kEKzelMGrCLyBUIUboZuOWX5ZW7T/JpLD5JkwBrFY
	4wBtDKLq5Ax56s1vCcQcP6LjP9q/ejQUSe5t+CCc1XvTIJakbonxdL1KRx/XQWQK
	9C9CiIXgwGjXCIktEsS7qhDnCDKqXoln+2iEfVa3Iaek4sdTIiT4ncnZXxg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds81fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:12:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac94f8df66so135372a91.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 21:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792037577; x=1792642377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PsWl1HZsnwlMvuPPgNIxzplQvHxqyYwW76yfoJtMppM=;
        b=KayJCsGK3vVeaLMa1i/yNstfdnWxFdDh684j0dwP2ANy2WgZwmdXtgc6meL8Iw1+oI
         FuObDny6fYER8AtaTLhDJ0p4hTszVhZ5dEk5ttLazsezbVYFX/a6P+VAbonyE9chFCNm
         V+dO8McnEAPMJur8dR0VLihWzYutGkN+AMQqIxvnzHbto6EFpWJjCma1sPtTTGdMRkzb
         Q7GGGldyZ5rMBPtKLCRY50CBb+CGvPG2ylnJJp1o665J9HmaPQ1RuTOm1HQNM0YvsNQJ
         Bwc/868OsdCTZinauzUP0au1KIIiS/8sVqQ4uX6deQ7LNqdmxcggl4QcNg/dXyS++W34
         4veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792037577; x=1792642377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PsWl1HZsnwlMvuPPgNIxzplQvHxqyYwW76yfoJtMppM=;
        b=cO83S2DW/HJciximF9nGbvyk35ZM16819EE/311DMdX64PWAQKGpHwDTTSvvacy2ck
         tGvxerFv5Nu032I6TN5jl422M9UqdpNbEzN9CscLblJ6vKbIXGRL/jmGtQcB2qaQ7yCK
         bgWAzcb8W7Zm3xKxEMOLagSbgAa0/qXWvMl4xQpsKLUMbm+iT2ULZSNcd1Z0wRpHutxF
         xAqCe+EYbAJ8tb07v3B3FXLlyghzdHKoW6b4O1OJRXdLrwPnRwMitOrRQ1EbcLaMaVos
         T8fpHY5qXkMkvjwd8L0KL9JLZ0JBFf5oZ6MYRtO1c9TX4c0rlxY40AY+3hqvNsB1t1wh
         W7Zw==
X-Forwarded-Encrypted: i=1; AKwUvBxpV2pNV6345xTLGS5j2wGJKjECAHfUeLXv7mCSvv9NAliaQEgTrTGFPkPrw3VfRfcD24fLxCVN9A==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+rV1044VQYfGMcaAF1iOhoYctzGQ5j8KGqVScmkq56ZJRfXoH
	i0Ez9FYKX6ouBZU/V1gIUyBeqio+tiKClARi7IL0ncplQSdIFFWk3hJkTsCB2eLeGrWaYXqZrBQ
	sRnk6P/W5lxvxyFGPhO+/SMZZPB1LD5W645d+KbNxREb1RMoziQBGT/JvoJYLyA==
X-Gm-Gg: AYBFou343eRlJpq/+jDCxNYbzqeUQJQ3jWxC7t5CiCVesXYp5CJ/Vtkd72am7z35x48
	z5jvMM21XgCPqXYyQ6PKVtZcWn9F/CAzMfAbp+FfIm67YWycqOenGupFm4SWwYt2GVRVD1WBzSi
	+0FHUWjFCI1UMoZNiHI4mWoTLiA3r0yMs/bbMRF79KCdFLnSw541YSScmzzZ9Jp+v1RfldM4x+7
	S/2ANGoGnC7qaRbWqCjsdrSAr8Vbxl29np2jMbfJ7qru7KtEmQ6AS68/xVJdx3jUQ9QOt1FQbbi
	e/pPtkQbl30J8MREQjT9rWdQXgUfV5YoI8Fv7qFf/l2iqchyqd1Z96EWVv9jl6t8hKSp8msyvn/
	v9NyA7Y1nzV6UCpwQJdFm4L22tg9M
X-Received: by 2002:a17:90b:2d86:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3ab3ad0fb5bmr23884483a91.6.1792037576564;
        Wed, 14 Oct 2026 21:12:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2d86:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3ab3ad0fb5bmr23884443a91.6.1792037576053;
        Wed, 14 Oct 2026 21:12:56 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944af2f1sm2267762a91.15.2026.10.14.21.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:12:55 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [RFC PATCH v2 1/3] dt-bindings: power: sequencing: qcom-wcn: document wakeup-source
Date: Thu, 15 Oct 2026 12:12:39 +0800
Message-ID: <20261015041241.2186521-2-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MCgqFWV_Q_A1GEcvFhEc-en6cZvmo9SG
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad052c9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=brVOnVl_E7YOJ4RIXMgA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxNiBTYWx0ZWRfX/39tT78f2qJJ
 Glmngon6dF0zWG9LM1WOFOtsbjt1KeiVK0L7Jb6DWYuOH/eUAqu2WjqL0OITfoMnBbeAcqWqEUQ
 z69FbvU3yGGtA1I5K1fLXayBKOs6h9lhEo1GK+U52ZkwukCbL/c74Sp8vVbeXDG/n0cU1o1EnB/
 wHskMIY1RFN5UUXjoKTHhAmNXxS6ScVEu6v5rAWtbcn8h3K1N1s20BXHKOKUlB7dL6suFFyewgO
 ZI+LMoVpMH65tBmuktUl6QGsaqQt988skBXjd1zzjZEWAbhxR2x/0+z0XVyICAfE5VHF4ZWG782
 +6Yl+tv51AKAfswhh0RAn7mvPtYiHcsPwJ8U8QlVTZgh5fQcnvE3q4VDhmJg1IAHJgSYCKDYh15
 uS3j5pLBJlKHZ8aL4daTkxnXERUkxEhgpVNjnOLcu6Z/xSppv6uKiJRZLowJzgz8Mw/RN3RXbyK
 F5X7RWVRPUh3l/W66jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxNiBTYWx0ZWRfX4dNe3sbRBqf9
 EkK4Mp356HY5xFKZabivUZu7EK1Vcl6RaU4p3dphF+6r63slAATzQp5Lc/CyFwhpwgTPmN914sL
 mTbzsPjQN8jmx9U9ngma8j1TnqrYLBo=
X-Proofpoint-GUID: MCgqFWV_Q_A1GEcvFhEc-en6cZvmo9SG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150016

The SW_CTRL GPIO can be used as a wake signal on platforms where the WCN
device must wake the application processor.

Document wakeup-source and require the existing swctrl-gpios property
when it is present.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 .../devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
index 9a7abc878b83..f0372e28c99e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
@@ -42,6 +42,8 @@ properties:
     maxItems: 1
     description: GPIO line indicating the state of the clock supply to the BT module
 
+  wakeup-source: true
+
   clocks:
     maxItems: 1
     description: Reference clock handle
@@ -67,6 +69,10 @@ required:
   - vddrf-supply
   - vddch0-supply
 
+dependentRequired:
+  wakeup-source:
+    - swctrl-gpios
+
 additionalProperties: false
 
 examples:
-- 
2.43.0
