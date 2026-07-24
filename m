Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60534421230
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888077; cv=none; b=ohMjOFvNO4u/IJASQEcF4yB0a97e29FpCYJdre7PAMqdDjnbjGc8DEWNrBkXH/eRuF9wQ2aEnDYC1ne/paOJ51N5pVaXq2f9b2DO1zY7UHXbF/eJnWNlQkWmA0NrSW6MRW4IxrPmwqL3ZCP5zxX4Ft5s3/LjAlocPKsYeZ6gdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888077; c=relaxed/simple;
	bh=J0OxQuXtmCCGQsk/6eJnqFwNhphujcL1r4uiZyDxkws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yij2H44XHdlC4/wKg6Ek4asVmIZ5GGBy3LsBS/IRRfuv+is2V/yh90ImFgNQ3vsVMHIVgX6iL80RKSLTjmaBCOA9VrQ2Jv0+yVFrOZLbPD8c3c/ib5o7ABLkIi6f8XI0pOIE7o4bsxCeKiBlPMo/G/sPm9M0obiqbyisN+ORJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ildJ/Mri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dd7n+lrD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ildJ/Mri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dd7n+lrD"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADW1a2875687
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 10:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6IVDocxZsiM9rmlLcikvDLE8daLnUfQKF7TLjilQN4o=; b=ildJ/Mri/ib7F2E6
	aGiC2mDLwqeidF44q74ulXHF1rnIXo+qSpxDBupzkSnsysqKZiCFHr02YzR63c+L
	ZFWPv5cDWmlBNs8R0lTIvnHILMBg76gKQoxrf9FTJyzrAPGhgi89kOennQseOayj
	D9gW0IJHM1e/SVepirrtDsiLLu/oCkShzQ3/YWi8CXjLdRXpgyZhwGytb0wtNCa3
	OwqckVaW6UXbc8ht4pQEvvm7rg/ody3DJn9WzKUWVA6GnxV7OV0/rAuP/ayuAi10
	gnX2RWlfnpjmWtLKWfXRpefq8U9R6bZIyPb4FNoq+D2FGw8+EXE900fK7ZQU2P++
	DmI7AA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5byr6eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 10:14:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cec4226c70so5254565ad.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784888074; x=1785492874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IVDocxZsiM9rmlLcikvDLE8daLnUfQKF7TLjilQN4o=;
        b=Dd7n+lrDgirTdEeRJHqqSYWroICzDBOCt8pIUB6MIll5fK71glO4SzObFzwzvelwf6
         w0dKFGmaiwJmL49l5TtthTJo9V4VW2prJbFjVWZwd8MfHkCpoU63pDsknL61wbLlSYeF
         anKftVVS7/CSeK/72mCXYIdu/rHFLbeLb8BTir+5OfYn0qQTsL5kDAlGoTKDNoSVK4xy
         SuT2V/ulq53GnaS1YrhvpMREykeJ0RuHOXU2jo4e/lfZk86DtwdKo0Ml1Iz7awHj3ISc
         mWj48Fn0GfVyLfZQdrSKIvkdmU0RqmN70505rZfCX4QzdRUU3BU7wyxZCMMY3QIiPrAV
         vQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784888074; x=1785492874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IVDocxZsiM9rmlLcikvDLE8daLnUfQKF7TLjilQN4o=;
        b=tZzSUKBp3xd28yrzMNjyFQiQSwXfMGvcafzSojd8CuveFyEa7LwQGren33vFCTTLIe
         3rTfPtPmAR8G7ygwl4+hOd5we5hDxU1dejbpaXQgTL4iPrtpkvlFSt0l2lpDikIB2dB9
         7djE2WkDT7MgAwlXD9o4P3eYcXVKabjhCCBeiyehw2/4s1wAA4lifsacgnQFbeJ4mGxg
         vVHK15e2InLM9CrcIE3wM5ObLubk3eYA0Z9FGexVwxZqVgi7lXfhDfsWRb5it/XGkOur
         ddkM/apaLmM360kQXtopm9/HEjETReoY81LQO16TouyrDac0zFmQa8Vwp/LxRjhEV4xo
         rkIA==
X-Gm-Message-State: AOJu0YxvL7/ume6cCDopjzmsKNLp6XUZbrPh2317KE6zzGK5SjGDjPAx
	dcF33k+1QwkJxnUZUGtyIJ5cg1PK09NTGzHGfa/GA2mqLa9SnKPNEkWV7mjQEHFFNempaIS1RLU
	hbkoboMXaPsYhuq/NRhsbvHxMamrylA/EKzAuheoxxc3gbAR24lJelNE0AhJcKEIMYt20
X-Gm-Gg: AR+sD1341ELVFyV0V3vP6bed405VsqEjRFxm1npFmdS4RRfn5J69kRgi86yuBW0aA6e
	BLKQc8aAecN8j31nc5fVlLe1LYYgbe+v7AXVNWCF5lgDnxFL+DCfciU8oNSmjQp79nciXqQN7qL
	FYg5grK9odukQloDm4D7Ny/i4SK5AlOXBebVikTdygoinRzCuUN4zE7qyCadiDSBDLhANC57l+0
	odZ0F77Es4mo0yxjVjqdVXxPnJ+AGUcOvycPYuKrIGk1+aIZYuFTtwCr6gfbqsEAWypO3tgVIAL
	6MDeIPaT14e9t9t7nBcRfxeHjpEt+exdxxmP0iFVMqyUSR+if6KgBtNysYsjvaDnuCzzNwHdcaH
	X+VbDxYVdOl2UxZAGltxCSFXTNz0xhw==
X-Received: by 2002:a17:903:1666:b0:2ce:ceef:661b with SMTP id d9443c01a7336-2cfa6c512a8mr73664775ad.29.1784888074249;
        Fri, 24 Jul 2026 03:14:34 -0700 (PDT)
X-Received: by 2002:a17:903:1666:b0:2ce:ceef:661b with SMTP id d9443c01a7336-2cfa6c512a8mr73664605ad.29.1784888073786;
        Fri, 24 Jul 2026 03:14:33 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f31f14csm48486575ad.63.2026.07.24.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:14:33 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 15:44:12 +0530
Subject: [PATCH v6 2/3] dt-bindings: power: reset: fix minimum reg count
 for pmk8350-pon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-b4-add_pwrkey_and_resin-v6-2-41acc214d93a@oss.qualcomm.com>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
In-Reply-To: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784888058; l=1086;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=J0OxQuXtmCCGQsk/6eJnqFwNhphujcL1r4uiZyDxkws=;
 b=Cm+Y0J3oGt4OotO/l63Wf7mCcNEH/uF5C2YxubMF/VV7f0OZKHANAWEwC8fcyujJ18MuyLzTG
 L4jexlFSAJaB1bosYy2AmqKfqCPplLKA+YB8OOsyfvt3DQRWshDZXJf
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: -3MftuQDpPD-39b7Fk62zzDe69RS8ACJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfXzcrLqjWYiHrE
 mhDG4kmgpAwvy6Fvzs31R8eeswYSzR7cApCkQOoZPZNuam+otE168j8nkRK6S+21/wEH7Iv2hqd
 +Bxaz6baIdRhaUQ7EYQFJXjFj8p+nM0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX2YT5q9ITmmP7
 vtHPSgzrh6SeAlM4M+wJOWmXreSiRlH9Hnpy83NaBO91y40ouY5fYZWA5yUBzQppVC98R4fm4r8
 5UUlCPbjnGCV6PQoSLkt9Sy7auboEZfRqLTyDDQkXNs6xlZDLKxLR4dMm010BZG6hTdE24H41NV
 qbC8Eipt41rDNAySOEgCwvpsj/qkH6ruvmzMaCNMa5qpbMhn4BKOtK9qC8N39gtld3B3XjgGOe5
 qvotQJKm+v//aquqV+oHPShOieiZ7B2zy+4k0cbcx6QQJ6sO+9P5kKgbjtEjJpFAT6/HLvp1ncL
 0rD7OTAwQO+F/T/EX3UTnnBaGymp9uPVOHBJ3bvJ5njJrMmxxVFS4Gw4qVTGvPhwoO3t27B7yAi
 CujFg1IKADFEIGXKalk1ZGOoSqTNq/6DGK/5HAL1KkXBvYQMbqBwT1U71FSphqNym8rJejIedB8
 AQ5Ar9hhA8r5WPGzhbg==
X-Proofpoint-GUID: -3MftuQDpPD-39b7Fk62zzDe69RS8ACJ
X-Authority-Analysis: v=2.4 cv=GMA41ONK c=1 sm=1 tr=0 ts=6a633b0b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0lPQaNVJU3hVsN1xtcIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240093

The GEN3 PON peripheral requires two register address spaces: "hlos"
for the primary PON block and "pbs" for the address needs to be
specified to facilitate software debouncing. Set minItems: 2 for reg
in the qcom,pmk8350-pon if/then constraint to enforce that both
address spaces are always present.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 3d07aa004eb6..2ac84cc9d907 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -113,10 +113,9 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 1
+          minItems: 2
           maxItems: 2
         reg-names:
-          minItems: 1
           items:
             - const: hlos
             - const: pbs

-- 
2.34.1

