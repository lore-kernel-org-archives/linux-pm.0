Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545746;
	b=zcoWvGcbVxkFqz7qNmeSyBYlH08hP3ncnugDgIie2UoOZUyxmqRs5mMUtJ3zCxdc9x4y
	 9hKLEv/EaGLrl5Zb7tZQL7kgcaEh9BK83bKPSn+xn78rwH0B7PO3FzEn9TW0eJkUb2lLo
	 BZM1CU6/3txnduWtL4ayRHoH/UQQYwSRT0YiYiS1ekd4A9PNtxjOj+8z+64opceESxe+9
	 to/WKfPZbVyJ0EHVONDBL7DJ8P7xiNAt+mR1rqktbfIviGr1hcLRpaQkx706Ae53VNQnM
	 U8PtE9nOpLqonXD4N4mV59+z6oD8som6aOGYU8RQlxCx/Me5mUsq+ocj27mMaGYu0SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=B0xt8hWG1/WYmcd9Rnv9SnmFXfN8wIMxECEAa2dy0yo=;
	b=GES2dbS+YNFrf2GWcmBVCbIYpOMDxb80n4Wh2jFmtXDql4VvnZPW7CxwC54d/azMjzpH
	 pjpiD4mxg8811Iv8tVsoI4QBlBsPPsDPRBfWf+VeeBzXuSoPeh9q4G0SVXzeImikHsFEv
	 s9rNYFpnoyxyl7BkrauKu7PtSLfHCxWFfZIlkNfsEbpnkFTZykaB4Fngf0qoMBwL9lAM2
	 RF2OEXbv+9ifNPgaFgn0VSsiSzXwH8h+iCKOSp8Rtw4kBflo/WoCiPzqbKnf3pojuQXdK
	 CkOkzq9f8oDc0qK7u84DfLIRvwVpLUukvloFQZAdgbF8ev8BL/ucZ+nUzGmC9EkMpSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IBWHKYjR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESXWgKiX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004B606A321
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A004B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IBWHKYjR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESXWgKiX
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD2Jqqe3273400
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0xt8hWG1/WYmcd9Rnv9SnmFXfN8wIMxECEAa2dy0yo=; b=IBWHKYjR26/n0iWp
	tUtKanhNaxhdmiSuxM1CmeOgi8Jl0GWfQ2YsQm+/cThGLSJnrU1jm0MZSwVh3Qz6
	ReL4E+lqlQXpt+109sqtSKKRJQfC2QRwlqk2kTSOsfcA73gAVVONHQyzyfGmu45N
	W1KpNILC3s/+8+0iTfOqxHdWoGWKQK/R6c/7l7WqSmzIHCYHLRKy5MNhjjdymodx
	ZoBIiU5kSX1PjQm2MOpAC1TvSMzEz3CEPX0jTuuD3M0FTda8rUI7N29XZhw6JcRI
	HVWnEwZVthcBxy2flsuliM+O8gdedgRpw6qPsgItANPv3jKalNgnJSDGJu2k1pBf
	NSSXLg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufgruq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so406205a91.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794545744; x=1795150544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0xt8hWG1/WYmcd9Rnv9SnmFXfN8wIMxECEAa2dy0yo=;
        b=ESXWgKiXZ3kImN35leqHplE5cVOanwt18FYUQ3LcGpIYE3y4xEvRrtiMsisuFdOvc5
         gmkN8GeYKjhQKdD6ni8I7nq7DAlaG0d7ddLxVD3jbWRqboUMHSEsgInWf3M4+TxwXUH8
         FWXqTyIUerNWmkL//zLWKfVCf5F5SdSnZGUUyRAg0bA2CmjOoHWOz7wkIAn51aWEc8gs
         m2U1qFamHDVFqGUTmEomsXj35BnK4kFtZzqShA6UlL6Dgz01YfDgwqG/UNkc+D5ANeqz
         J229P/52P4a2WzIo7k0xGCoIUSOM8OrXNhGDAgt9xr+8p1shrnD2AmzrW84KVcbmgfBw
         v56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545744; x=1795150544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0xt8hWG1/WYmcd9Rnv9SnmFXfN8wIMxECEAa2dy0yo=;
        b=Dy9r06UddkAowZvCs0n+2zXBiqjxJ0eppsM9rkO4ScG5udd9N1ZllyjHEQEYGSOhpc
         XjvNhs4W9GE/kmZBCwr/fgQLcmVlb+s30oGzl0XtEyCsIFkEpgxMsogr3MyqqXY0WbM0
         VajkNfxYZUsux6uIcO8KoK9igOV03xQY17hoLXh0b89D3F02r+dkDvwnYZqd3tj+EC2K
         Ztb38ZF6y3Zrw6bHQjwxhDlyUIzscgC2fHOef2VIJgaD5t5GohYl9kQ33QGtoiuLtLK1
         s/jc6G0ViUSHnQi7pbbcCK6jEpW7xKmu/iFXLw93wLwBTAT5I8ar0/B2RojxxLUQvIUZ
         lKlA==
X-Forwarded-Encrypted: i=1; AL+hErHYUqQS6rEYD5YIutqcyChJeJvzgsiWsBmIw4f/bN+V8EX6VWhyJK7ewoS9UkGKsjoNCvKKowW+/Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WZFB+5KWdSHqNgY28hdu/CZlcXRv2vCoJC/Fmm74GoCPLbVmn
	ta6883rAFwrf9bsZzpy77JEYxjjR4zYdCHU8JXP+guNWjM7mns5BVmU7HbD5Cjy70OPDkyPNFKo
	UFwQZTrXkf30VeNPBEpjm+qqqQCYxa3g8tnMg5suzSrM4yT/5pK13GBHkQ1R7fA==
X-Gm-Gg: AYBFou34mXiPpGYc+WqF0P7oTyO99q6o0H6z3NOdq43l+uFrHyr1Ah5oYJTmxa4iNdd
	EEymwKLxLFjMpcGT7cJZOadPCOv6sTQXqDrNzyD3yY56qX38azlRj0xx3zMtTuNXz25r7cRaS9m
	2V7tWba1Dy9megNS87u435i6Z+ykJwsHKBpsnxAc9f2fl3iXXXt4jMQiw/aG+p1oj9riAQDx4nd
	OuTXXT/bAoXQTJ5ReEg23itB9Em3zlDSQEXxxUFpVNJ9chX+zp8rhdsZ5BSrvcujdLBxnz+t8J3
	SV8L5YwGYn/tjjeK1Q3xgK5eeO4xGyxFbxmsRL134+KskTC7nRJ1hHb5uSfZVKFJ/35DDB7pihW
	gaJNtLRrx64VMvY5MS3gBPFv9EtsnUFCNq1Iy8aKJg2nufnMBQV/Ngy9f85tyDJmgigS9g7UpJ2
	jC
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b1b0a5030emr956407a91.40.1794545744298;
        Thu, 12 Nov 2026 20:55:44 -0800 (PST)
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b1b0a5030emr956389a91.40.1794545743834;
        Thu, 12 Nov 2026 20:55:43 -0800 (PST)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm7739875a91.10.2026.11.12.20.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:55:43 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:25:25 +0530
Subject: [PATCH v2 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
In-Reply-To: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794545733; l=1611;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=wdxVHUH6U/hkNef6ynp8u9yaYLzY92vvK6sKGzYVMG0=;
 b=odxJJpkblgPN0yYCR12PMj2iwhNkYi37D9oCcYCwazdfDbcoy1eTNIooJOFotBYEF2GlzuR55
 5iWFxUUu3+TDIuQpo7JlBqKpQ4LHHcXj4XfRvdf7HLdU0NS1MIZnilp
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-GUID: 79XMlmDyOdQBcDfSxIFIQbGCoYe1YOho
X-Proofpoint-ORIG-GUID: 79XMlmDyOdQBcDfSxIFIQbGCoYe1YOho
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfXwlO17Ax9mrZ3
 9goCZ0D0asRlA+Ot2EepuyXAjUrqSK40/RNYrFQyuPSIk9e4PdjoRckM3lyKP96svpyyipxa0V7
 PWbpG+yPyZKXyGQV2AGA4nKLXsxs4bAPoz14v7mbuglgSvNQKZK+CGcstD1ywQLW61EuY7cf9h4
 fNdN7oi4ohfEsj52MfkJUpoS2Kc2636+CVnBVhwNa7YK8Hp64LEozGgoD665yGZDk+QXT4t9LyN
 IuKOVsesmAlsmqBiDQxDfV61y7d8/kmOQj68ZNc5s3tIaJyVTmH7kOkMAB0jJ7GiVeQgVBS/HZg
 53fZ7LzTymhceSbTvZ+CfKcMTf32G0CA0y/Y9wdF4rV0UEcEJKZiJcmRceHsSexCh959tbHdocA
 Hgt2sQQ5G/PuMrThmy16L+8g4/BE3e6qdVRt1SLi7IzvgWVI62khefBD/o2f6Dx/8G/h+1bemNM
 BYxF0Xxir4FKekLNtGA==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af69850 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=Qyttz2GgRPmjqTwtHG8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX6rJAkbhx1y/K
 dC9f6Vf9yrnMk4O6rg3NeHzSUi0M8bi8Rf6402lIRLmbhXxbEYGRbmhmMdQg1qbiElNV15BJSSm
 BbC1y/VWvuUlk6rte65/mYGl4Ey6v8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019

Some domain idle states require system-wide coordination and are not
applicable while the platform is up and running.

Add a boolean system-state property to describe these states.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 .../devicetree/bindings/power/domain-idle-state.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
index 4dd4f59bbbec..b19952f6225d 100644
--- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
+++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
@@ -45,6 +45,12 @@ patternProperties:
           state will yield power benefits, after overcoming the overhead while
           entering the idle state.
 
+      system-state:
+        description:
+          When present, this state requires system-wide coordination and is
+          not applicable while the platform is up and running.
+        type: boolean
+
       arm,psci-suspend-param:
         $ref: /schemas/types.yaml#/definitions/uint32
         description: |
@@ -77,5 +83,13 @@ examples:
         exit-latency-us = <40>;
         min-residency-us = <80>;
       };
+
+      domain_power_off: domain-power-off {
+        compatible = "domain-idle-state";
+        entry-latency-us = <706562>;
+        exit-latency-us = <706562>;
+        min-residency-us = <1414124>;
+        system-state;
+      };
     };
 ...

-- 
2.43.0

