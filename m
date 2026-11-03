Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742266;
	b=RfTh9Q1Cbhm8LkIBPS4yFZYt3phsBHaCBJPvFLRax2ZnwKc7Z4SUIhl2ZHuz5/ECRrW3
	 JltDFZ2L8PiYm0cDpPpVes8gIkfcrsrldF3Kac/XRN5EuaxINLj7r44oEA8uelcvBNZZ0
	 gW5D1Ck9+f1o6NKNmybJb63aaZNs/92LJ03m6Zo3KDJ6TrVUzegd3aJkjMyJbgERpj6Cy
	 A+SvuYMCVfKerkEB6s/Re51wQrRLke+dpsrE7B5JWR9r1iMVj/fqjVVEq2pCf7GoyTmxl
	 vfV5rwvuZ0lYVMMC2Cr9cI5aP7niwHD8jtPzs4E5iz9Pr0dOvqBRnFs863owKtBOdqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742266;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+++IlRx433pq80T1LDRVDnLL2Oso/QXyI+O9jAXqPXg=;
	b=bYYMKfXRGrySZsAv3B4vW/p2/KtF1ZdaTXrwE0FjUxfLTnaw7X0au/Uzd/fLSzNNG4AT
	 AkkuTdmlqAvzJ3jyE8vCOKdcygRHO7Nqy4NOWmlmgA/KQ3HflV+OAUHSLiuZtiZpzSiaT
	 YAji0jkNYtRuzhxGfQREgqWodtgMnG/X3kvGYKhxJC5E04ktzGGAomzkqUpN1DtqCbcsB
	 ucdY3d0KhmaiEWgllLZyKQcJoftLK/PUS+7qpLXTLzq8/n662UWd/+0wG5sfXOFUcFN5Y
	 BdX30xugCE8g7VUTJoN2ftSevxNaFAF8Vr1SCrOQx268c35JjyN9qYsjN+iv1lJbugg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g9ml9lev;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gh0FKk4t;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2E606A333
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 21:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F2E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g9ml9lev;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gh0FKk4t
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LKhJi3472863
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 21:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+++IlRx433pq80T1LDRVDnLL2Oso/QXyI+O
	9jAXqPXg=; b=g9ml9levk01tTILlao9CA8SRgQa9XKCvYOA5mJX39srXFuPMF2g
	lX1lVpSADQnqSE5AQWPZoPd5juDE3cEbEgfhhn45IBCmiHc43eDM04TDRSD+PV7k
	NsmsoLSd9fB1y/iHO6a+LiVwAGcy99u+5dfTXbvw5Gc0WLdJv/WHMP808xbgBaR7
	/TiulbR2XN3rcCGntbZfFq5GokWP8HWQ/Objqa0sZlOSyeMU3SkVndUL/4uwoiIE
	Z9A5AldIrugJejiNlw3cMruNILm/WVHAFvrXPeyti6zEj+g4QGSGl3j1faJqPIbr
	w+OHMyRf+idKiV//+HlOWAHH2tcn4uuXhnw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y0k5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 21:44:25 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99064f8c7efso34945241.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793742264; x=1794347064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+++IlRx433pq80T1LDRVDnLL2Oso/QXyI+O9jAXqPXg=;
        b=Gh0FKk4t7r72BI8T0lbhKQEvm7Ns8nM7Y6Soxp1fPn6RvmodjWZHHov7WnCpOcsDI1
         NaUoKsRqzXekVOUnPWfTu75IiF/f6jAanhx0M1Aj/i3g2DDZywvUZtTczUecwF4PgECd
         /n1PrG49WxUSy9bGo7WeBLxi6McyBgiwKxMZvPCHfS64bSpg296YVCUleQIphR6FGQn1
         ViwEJV+kCgDFq9QssAnt/9xEaNMaVm4MWcZ/PH3G0eiT+OEf4zkyjP8ExV+iFRUeleaj
         lUQ9riVyGACh74eVkkoSqrc3MFWsPzCMialNIPZF/Y81zobeAMya/vqO8E7G1tevgIse
         exQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742264; x=1794347064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+++IlRx433pq80T1LDRVDnLL2Oso/QXyI+O9jAXqPXg=;
        b=hREU5TjY7lYdmfikSoD+v3AJaDZvKFTeD4rZhBVRBKRzMAnDkW41fm3mkdUpWcc962
         sEr73cM7aouAGXUJeAYBLUPAQeMoOk5UGQj1PEeE7mlw0s+SzUxsAAFjoFN6U2j2Qfme
         7CB335IYmCTYIDx/RgoitAXy9b9veDiO6pDeAL5UFtB/gYnW+mpe9UIICUzD3FJ9nL0k
         jr0CaYtAHuZhECllikP1Up8EjfG0PbsscXRtFyxX6Gjhbiirp4D5oWAXCBfjIm0S/Mp/
         T/ma5mefAOOCqCnlo65Cil6Ovz78x8JF8bopqjyBMlMFm3agyFIBvkDBaXbshOydEs7z
         OXFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTXXEP4yABp2SUMAG/RvJAwqFHezTIQ1IDdxv+kbqRlA1ftR2AA5OJgsG6P0Aq6oxsx9kjxxRBPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zSci3ohYnR/m4TFOixnIy94d3vqHD+s0hIU5RBpeSeF87ATDs
	tp2j5oayyxbV6kDLNOZB0i3JUlxSEioWmv1JKHs2ZBLTYTkgMGPBUUTxMbtULsYnywPyvyvnO+q
	bGgb0AH5y0X85bRP/dOtqqIVHohxaaHl1UfNBozQhREOUqJR9HNXnvxCblWFj5a7fbDQ2R38t
X-Gm-Gg: AYBFou04cFWoNZBM65Usm80a3RiWxaCjCIutjqwLSYcWS9XQV8ckejQp3G0f0QKSLVl
	1uRPcCJIT3obz4e445BWmtudc1x5sfPSBHcyJ8BJ/Lnb4qhoLHwgup+2f37h4gXPrFQ/Du70oQQ
	EjkpGuKxOZ5qydHD5lFtHTlgeTZ9OeX3jplpOgpnrNUjogBxmAscYW4pBESQcnHJASaSEj5o1hw
	92pZlOJCWTZyxHJXPHplinumqlSY9UwiShKtKlMBYYKkKro2XNhcDpxePefzKtDbq3NalOkP+lE
	KbabeB1YM5hEla5E8/dg1sh8nJEA7DmWpD27dbzjH1opyNJkOof7FeXw/0KhMfz1HcCeQP64khI
	SHbDEw4oyR+GhUKE/43Jtkac2KHFkUG1RfJb8CvtfIC0BMe+Z7ruRS74UMqYaA+/3C2Sdjs04NE
	0R
X-Received: by 2002:a05:6102:3ec5:b0:7c0:cdd9:31c1 with SMTP id ada2fe7eead31-7d072615564mr6302508137.12.1793742258834;
        Tue, 03 Nov 2026 13:44:18 -0800 (PST)
X-Received: by 2002:a05:6102:3ec5:b0:7c0:cdd9:31c1 with SMTP id ada2fe7eead31-7d072615564mr6302499137.12.1793742258366;
        Tue, 03 Nov 2026 13:44:18 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:eeba:6d3f:bd6f:18be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99a5dsm181674f8f.21.2026.11.03.13.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:44:16 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt-bindings: thermal: Use signed integers for coefficients
Date: Tue,  3 Nov 2026 22:43:57 +0100
Message-ID: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ay9VRHcdYri1rwWzXxEL9Ow6GLHi1zYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4NiBTYWx0ZWRfX0CsT9flLz/27
 jS+pfRsfVyRVopxq6sP/EevUx4jbmjKwD5y1NLldvgqxKF/tRxdlgNyVyWKCj37UJ66XDyVeiM8
 HMT9lj23hLQpXdwkoFb1cOb4rid3vqvR7tJmfQiGQw4SgOn3Li2IRpJDG9ZYqamd6hO4qLje3Oc
 cM1FSDpuzW330CR+hGlzn60Pxo+oHy4wejRjpRAKTvSUb93qJS4ZjATHqX4E5Xuh249jPYv//x+
 aeVMM/MK6qB7NV2oOxi4HRm9mzE1w3vu4XH8cFDYS1k23tJoSNwyw0Z3DxTlVCXluEnnlc5TGqe
 b1HMB7E3N5D/JTGaskYQXUHF0qJ4n/Vl3Pjwyg/EDZg9Dm+IVR5mnDtWl7+7rbbvzuRqoqxEWph
 yfYEWZCZEKI4XecWtAcaNBEprAWHOH0LTKdxXcGFQwPwjP8lF3mXPXLMK+drgp2Yjg4zQD+AQJt
 fwHjik2py+3DywsXQhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4NiBTYWx0ZWRfX/nBzzru7dlzi
 UhLuGoxF7z0+4TGAH720MG5uYZbXg8IShmu/Kl2g9z5tCzJtEiGxkDnVv+XPyKs7eZqDlwseg6N
 dmhylNqAahbMtSGKLwR7YFWNOajqVKo=
X-Proofpoint-ORIG-GUID: ay9VRHcdYri1rwWzXxEL9Ow6GLHi1zYu
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aea55b9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=W5l6zmR3omWN6YeRZy0A:9
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030086

The coefficients property describes the coefficients of a linear
equation used to derive a thermal zone temperature. Both the slope
and the constant offset can be negative, and the thermal core stores
them as signed integers.

Existing Device Trees already rely on signed values. OMAP4460 uses
an offset of -9301, while OMAP5 uses offsets of -1791 and -2992.
Broadcom platforms also use negative slopes. Declaring the property
as uint32-array does not represent these values correctly.

Change the property type to int32-array so schema validation decodes
the cells as signed 32-bit integers, matching their intended meaning
and the thermal implementation. The cell width and binary encoding
remain unchanged, preserving compatibility with existing Device
Trees.

Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 999ad40a20d5..72e419124f98 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -101,7 +101,7 @@ patternProperties:
           thermal zone.
 
       coefficients:
-        $ref: /schemas/types.yaml#/definitions/uint32-array
+        $ref: /schemas/types.yaml#/definitions/int32-array
         description:
           An array of integers containing the coefficients of a linear equation
           that binds all the sensors listed in this thermal zone.
-- 
2.43.0

