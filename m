Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58A3E2760
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765801; cv=none; b=onV2utYgGu+a/KxoM+/5PuPaVwkcLhKv/7zgwFNYJWqdTXWoFeWAq/Ide6rOVMkszNwU9z/+BsAJZIwu4kFKuZgLcaHPn2F0VD/uehJBF+460P3gBXJu7UnquP+AiXnMIqPTCU8in0/aayxy7SZgZ676ciTpWWtL4k4AOQxUnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765801; c=relaxed/simple;
	bh=yL3azGaR1EG+jke4+Oh/J0WuVZ/IphsbmycMKWmVH4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGV0LRn+psDocxzVepxH9PM6/U6lgKUDeCvwFupx7g9QKUdW3v4bjNNH8BPeVoZFb4AkVyRdRE3vrMu3RCL3bcC7EOVeVp2sdN86Q29YtvtK5GHRMt5yD4p6lYAM6AiboPtYDO4ORK/JmM8k6RqNucz3qhqmUTivJQSb/vXhIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dmqJx1Tq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CsxDOp/Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dmqJx1Tq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsxDOp/Z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeQoA3951584
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yDcc5y61Vn2jGS2w4NPPGoXf+bnUp6m4zNxFe/LeMDI=; b=dmqJx1TqiEwNLOSt
	hmvxY5oqGf+0f/bHjnYV/JKIg+cEtJuxZumC35xNC27B6a4eWluV1xO8jLfaFqo5
	iXg2aCArSPerB5HG2B8j3KlD8qJ2m091VGN+jpIBRXF5OV8ul0eQCqz45g6Vi52K
	CQ2cB5lEQNwTeodm10uSvSNF/oMfo45dpoS1hiO9ih/lO150Yh3aE0UxRVHPuA+1
	Dy6lpdMINkdz8/fu/4Iv4j2Yu8k6Nbmel1ueEFWJTnzU9aBcD5np3cn5PmX+EfMl
	J5BBkCbrQKqDm9cc6ZwLNhHu/VG0Mi7aWUFqQqqumYKMy8lYyczU52u9CAnC0jv0
	GV710g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57kssqh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:36:39 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-636fce7dc8dso1975339137.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778765798; x=1779370598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDcc5y61Vn2jGS2w4NPPGoXf+bnUp6m4zNxFe/LeMDI=;
        b=CsxDOp/Z8kt8fA7sTUyyJX+ROjO7JuFKUjD9OyEDmfxaxJZ/gvOzyPY96EhOld8dul
         xuHv5r5lL9NPEs2/xDMYCDxb+o3RsmO7XkmbSUU8lhGpYzo4HavCZX8FgbO6UH5En/EG
         ryWoDeJmOWscsT/Gxf444Ev5jQQs6JEWzvM9zXV9mrGwYKAOUxKUxsF3JCb/8/FF9K0R
         biBEsptlOOPkKIfUDJVkAlpNvspHsjs9+McR7I8aGQ/JZP+G98qTQFy1iBY4M1CWahNB
         wOwMXOOMBJbnXwnlQASgnqJUDaUhb9hyczFbGorVfFnCW8fvZmfCGvXTu3aIUjzKb98g
         mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765798; x=1779370598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDcc5y61Vn2jGS2w4NPPGoXf+bnUp6m4zNxFe/LeMDI=;
        b=BOE6sO/OPQntFNtLUyvYQ+9icglj19l9E1qHBPUJP5Pb6RnuA+jHw3urtaeG4xIvIP
         M3c7sgH3I7rNHrtwDvkLDAam2F1k2mOk5hNVsFvMwS24blN/tF7SZuHUm3dX+19JgQLT
         v+7QlD8r8RReJGNjI+p85LSrL0FuEnYAmSeXUpzIL9jhJjBdFt3J8npY4eaebe/LIG63
         DKfvu2r8RRMSRb3q55MekCVEX6083FXOUZO3eXbO5HF5CutPdBTOTU3l0Ir6tI2do6NI
         vSU5djmHdeOXMbpKjmFFV+Lhz11RY8wlgoUf1BUoKrRvvcaNJNhs0gzQF9IcQSEc+Xhq
         7jMw==
X-Forwarded-Encrypted: i=1; AFNElJ8hTqBf9jTkcqNIZa6351JAzLXrIt9ynlFDxCWXvAixaqPF91LmhMJAdo2dX5+aQyAUR4KwMQ322g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzY8/fs5AYxKqxzTnKse9zkfdeIZc7SyeRxHnNg6hb4JQG2hZl
	gOmAvzcyfuPeWjKw2TGhCJOoRO+V3NRssT09xV4ErYF0qwJ5Dk0ut9am0efjSP1hbWCco5VW5FM
	yqQrpqXgH7xb75JEvebGRn8tWVE22TVBWXnM3cGzY2KJ+berM0OH+L3tOCuYtGg==
X-Gm-Gg: Acq92OGflhEiAuKVNseOVtzpn7SSyPjNMkWjjb8zDIxvOdZxQj0ZE/xpIxHGWNIn4Wr
	5OIodxTwrN0G2QXpHQxGHLVsQA0ZxshtFvTN2R1zJk6wXUYadjAnA3aEGNwym5q7sogcgrbBeyq
	3t3wKoDxC6kRiCyw4U0nXPkSeIPTAg074WQqYCOUQ9JZxLL8NN+4yeajiLOSOnBzK3Bj48+kSkX
	MeonOofgXWov9MPWumb+Pe1fGSGDt9X9qFjSbylng+cbn8Gdhw0AUzRcrk6BNWajGdmL4r/+0Px
	k8wfsD7ffvnKu80mkjvTJyRk9K3MNpExExGjkoba+lSDvBcBKCVjg1xhAdnyRL97vAaHoikhvBa
	E2EdVVcPLUqt/MHab5u80Bvi6aRBgLQ==
X-Received: by 2002:a05:6102:5a99:b0:611:61d3:819c with SMTP id ada2fe7eead31-63771d8ea40mr4324024137.10.1778765798250;
        Thu, 14 May 2026 06:36:38 -0700 (PDT)
X-Received: by 2002:a05:6102:5a99:b0:611:61d3:819c with SMTP id ada2fe7eead31-63771d8ea40mr4323887137.10.1778765796521;
        Thu, 14 May 2026 06:36:36 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm7382462f8f.10.2026.05.14.06.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:36:35 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Thu, 14 May 2026 16:36:23 +0300
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom,eliza-rpmh: Add
 SDCC1 slave
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-1-13c03bc890cb@oss.qualcomm.com>
References: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-0-13c03bc890cb@oss.qualcomm.com>
In-Reply-To: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-0-13c03bc890cb@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=yL3azGaR1EG+jke4+Oh/J0WuVZ/IphsbmycMKWmVH4M=;
 b=kA0DAAoBG19EyQCVFVYByyZiAGoFz96g8/5+8KpDojp9w7WQjxhmxuFBPEaPQLAFHaVXnK3NO
 okCMwQAAQoAHRYhBE7z7hFOeo8qyqfRuBtfRMkAlRVWBQJqBc/eAAoJEBtfRMkAlRVWXOYP/0Tg
 sKIEnuYCq0v2K9HaquzXFu1KeGRMOvDFpKad2VqUImy5BW3J8GxheLTTIboptkEFym5qE0u8+aZ
 mRfSfdKkK+r+/8kybJZ+IjOOYht2yQo2ljiGHUc4hQYaaM+mpWkgoUzTHuakQr/lWi1EhXoydtL
 nQPf3cDxqHP21lcnFnAWUJNY81CmXKAgXTg5DCGoP/qU5yCKjnX1dgM7dG84FGGThzBNBj1QCtR
 kQns7raiab2Pji1gc9RNvvj2pW7e4JyK7GmulqDFQy/wb7qansC+LhP2Cj87vrdNa8uDlWKJBod
 1eDBgqBhg0g7k840Sx+ZlEN+Xz4bPFhTUpl9q1V4p4l6izxu8pT2XijUcB5wcjdHP/sjRmXjETA
 R3mF4igR+3ndbc9bAPmgFXKNeAhvb30KPby3VwvM7/KCsCswXrWZR/wFw4oW734A3O2sQ52cnG5
 I7WVaSbkuCqvSRHg2kJofQLkB+sRTN2HUfWH/i0UzXC8d5pUSAvLGR5+17Rs4z+TBMD3SNQVZTg
 OfBwTpCTGPGPIdGJsKa/v4z0Fle58eoBkonbXoDzZPdflGOs5ouIeMDGqCXKxWFkO2qLaZtaq/7
 Dfh5AY7TEvmJfTH3pq8rE6UBKs//4kxVyZtVDuBLq47KA5BXVJs6jjC5AjKsFTz2IhKl7EA4B6o
 oRFE5
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: smUqMq9OdQsS38rBW7VECgE4oVPhxSPy
X-Authority-Analysis: v=2.4 cv=KZbidwYD c=1 sm=1 tr=0 ts=6a05cfe7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=NtgjAHhJo3Q0P2g9Zl9R/g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GI54HwGG6_AAUWcoLvwA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEzNyBTYWx0ZWRfX5+5kiRH7uZs7
 Og5JCZ2v3d2CwrlE5Xpc22BwdBjwAFG85Z57QiwKVnDbdUJhDRc5y/bu9MK0plByDIHoZHnxa/5
 IYgmTpkkllV+ebE8RhU1b9b7QgjSGo9UKjAK3jDzHq0vqokKT9lI5kMWdhzMzPUKD1qUdppdEiz
 Yk1gkyrISg+vbD9bOi56eKBRg1+COreHkisow4ez6fRmZ4Oj3lx8mWHJ+AauUaws2Dksz2q4g8o
 msfrWtrDCHzZ0IZdU56GN1AUwBdaFXwE3C4cevh32Zv3JhVNcui/6GCkEoVeTVgYNv6c2mkUx/5
 sl1nCX+OFVxckuknhUeWLMKjBncFYQkg8b4Ubw28YD7lp0wsigWtoPr191MZ5cM48f5rGGvr6x/
 8TscLMU673SWFdhtN9x2GivclPfnRAsWrqkEjDyopj0lFVlHA4zLM3QHDp9fW4/3BPBMhIOcx17
 nal5UWFBzoXvSW98EWg==
X-Proofpoint-ORIG-GUID: smUqMq9OdQsS38rBW7VECgE4oVPhxSPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140137

The Eliza RPMh interconnect binding is missing the SDCC1 CNOC CFG
slave ID. Add it so SDCC1 consumer can describe the corresponding
interconnect path.

Append the new ID to preserve the existing ABI values.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/interconnect/qcom,eliza-rpmh.h b/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
index 95db2fe647de..dfe99feefb27 100644
--- a/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
+++ b/include/dt-bindings/interconnect/qcom,eliza-rpmh.h
@@ -57,6 +57,7 @@
 #define SLAVE_PCIE_ANOC_CFG			27
 #define SLAVE_QDSS_STM				28
 #define SLAVE_TCU				29
+#define SLAVE_SDCC_1				30
 
 #define MASTER_GEM_NOC_CNOC			0
 #define MASTER_GEM_NOC_PCIE_SNOC		1

-- 
2.54.0

