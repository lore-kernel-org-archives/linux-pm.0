Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EC175A7D
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540411; cv=none; b=kArtM4TJWNefNop9Kin9gfo40dQA2Tsg8kyhS4chRISCZJxaz9c+mQ9Cyy9YBCmAq802+QpYBlKUTAjz/at7oSbwTrnV++scbEQdAXkFPrzgQMYlBaEOTUpie2mMXFuiaZth2HtQf/N7Va2wEBHl4hx3UyJ87Cqnt/UbucT1UB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540411; c=relaxed/simple;
	bh=vxzu1BItgDG+upVzuIGSwS+AnHAB1gz4KUgcXze+JR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d03s2q4yIjRPFU2JH8NBVSHDUb31nTa13CPFETQyPHMtWzGeoO80KphinufwBcNihMFJkS54XHb4451yuQjwMMqu8VMYVWMTLs7dwqqrrbRx01PC8Pzi6jTZFx4zMxjxn/rWILWwlCFteUvQAHMG/81Sq7AQIYJ4+5cj7c2K2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AobkrJNr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jYwI16/U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AobkrJNr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYwI16/U"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQKkY2549972
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 05:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RbjEEvlADdmXHSdeRe1aD+KWqgQivbL4+PD
	39XXNeow=; b=AobkrJNrNnC2K3VbPa3H4hDT4F/vv3SCMjV2KXYAttoXfaoLuyB
	b716soX0rn8p0pXkzU0gkmb9gPrX1zHy4guRb4Sg5Xu+Idx6c6HV+2lrozuXUWSp
	1dfSx+J19305apmtzCs2CgepndCa2DX3aotkGvY1OYFw9KkezZFl6FLJDZj1XX2e
	xuF4gZgCqHMOUgbgic2QeMttIuPDd9CgUrGedR3NwXY0gVmk8+uizrbGgw7yNA6B
	kUFmvTUWGmGx1ZLap4eWXyEu64pkVWRwFbHhm1yZ7W7OadaFt3E6/Gf9yqfk7itH
	WlOSmq2tpOQW5YM2Iu4/aoJEiH3/HQORUAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmre977g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 05:40:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d826ed6f9so55155111cf.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775540407; x=1776145207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RbjEEvlADdmXHSdeRe1aD+KWqgQivbL4+PD39XXNeow=;
        b=jYwI16/UkI/xaua+OdAbUo+/eZDvvRpHHDKK3vh1QTXG3coT17/3UCsMqOIXcNhxc+
         X1YAl5Ct2S4bKH5fBKDzrLBl1nA2GLPVoKMXLdk34d2QGR4fxT+eIugT2WanNYDHw9Fa
         kvXWBPnQypB8uJPLuoIbs5M0M+cGJRhMpy1j6tE5g0I70eL3jAoMDCYo1rRfDU370tnD
         lq9CFfog1shTDRSaOjI9xpKCCevCquYnfjy4FV+leIwTanbGpuUTzBYu3GfN+dS8lj3j
         sY9D8qb3evhUfhn0mixYqnfutw2KnGXxyrXZGcqF92/EvQ+keaQHpwkN1QF1KqXZ04uA
         E4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540407; x=1776145207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbjEEvlADdmXHSdeRe1aD+KWqgQivbL4+PD39XXNeow=;
        b=PdW36JrSH0BeU1x1S4rDsGXyO12KVPCysrnn8ucRKue+Iv0bSyiXwhpuX1KRymmHhN
         xYLc9DAYu+LC+492U1cn/w+UifXUwC5MnHAJgDxozayjZsdYJWF1U+hf/1eRklM0+4Ze
         4gnlrUECBG07uCMxKdIx45bz4ACJfXRM0jzYAe3Zji6eV9JhsOa3f3NVsTkBpbwYnKTQ
         nUltQSXKjou841l9hgqVHV21ML3EUst6g3/MDuapzBzHJLwwejnUDteTAEdf8xEKSEWj
         4LUcop4jKu6d6x1qjsvFQiVsJH00GIi+bM4eT7EqykASoy2iuERoONkq1149hgsj9lvC
         CXYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZjIQcKzR+kGk6mpC6JSFBHmS0TeVtpV/afiQkQuwzmNtyQyny9vI1jAzkjcq60J/a8UMU9U4d/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7zuhqX+YDRytTKzJwXjXN1fNN02F+RQz/QGxdLkMFRtX4CZ+
	iMmzBgaIUejIxbeOaiw1vhb1ZgfFsnZGjvZZ35M2BFV73wnI5PQOojZmQt/+2QUl2cxC0I1xSP4
	XdNP/YyiYSV0uv7yWFBn0LOvJ30l0ceIhXoSvbQgegkS0U9XHEmf9ih5DUFn/dX8OFvaf4w==
X-Gm-Gg: AeBDietZhvgjPGI/Dv2FN8WI4COmoNncLyxo/GJIK2Z4qf+4RYcf0Q3I53juaEXrNIk
	ZLFr3fF2mcWv+NMdCJPprpOtqiwsi0w5R1Dsph8I11t6gg0yqpB/onhlCm8ZfVICGWPE4CHEnJq
	DfcwcdoIPS310wOhVyXaRe9pH2cWRaftiSNsW0SH+GTHlF+nqu+0ffHJrGeV00JR3VjnadTu2A7
	NpBRcdkc4yrAgW50E9pA7GhFz2aFzD/Z4eGLn+mnP1Jdxu7Qs5GseEuuKAQ+QB3vQIKkGiJ0bZR
	tt3EA4QMCcTnstt9NmGHVis4voHJGlNNICrE1w1GNt/IDvDtnY4K3Sdfa8scCFjGd8qnCAleU5T
	5g91Xsl96lWdPBaANa6YwrfmuLLWfAVuKxNoM
X-Received: by 2002:a05:622a:1a85:b0:509:144a:43bd with SMTP id d75a77b69052e-50d4fa36996mr225853211cf.3.1775540407453;
        Mon, 06 Apr 2026 22:40:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1a85:b0:509:144a:43bd with SMTP id d75a77b69052e-50d4fa36996mr225852961cf.3.1775540407015;
        Mon, 06 Apr 2026 22:40:07 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887eb5aff3sm729034045e9.15.2026.04.06.22.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:40:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: thermal: idle: Complete the example code
Date: Tue,  7 Apr 2026 07:39:58 +0200
Message-ID: <20260407053957.10508-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=vxzu1BItgDG+upVzuIGSwS+AnHAB1gz4KUgcXze+JR8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp1JitM9m6FmCdpAl4tcyldC4e9XDYxF8e9uh4T
 CDQd5CJPZeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadSYrQAKCRDBN2bmhouD
 10o3D/wNEADz1F2K/i7fliKkKHuyOoNf96ZScskYc4LQv6YZcqrrby7nqR4GG6lFyf/4kBXMHEB
 tuTws2RILwOsBnZQh4UlEBIvsU8udXgWLo5R/lyC8UFkuSlMBFPshqVkXSdc3dfKMCBhSYZAAXE
 TOK+1e5Qq1NZQh1n1cYPnmi/Len8TrVTakEORgoWf1lSEQH3AXRAT9eWKC3XS/CsR8Qmnl75plA
 DaPupbhXXXI3YLhW+tTTblyBbzzjZlSAk3/TGZVnNl68Nj6D+LwnHDffHVp5QdGEyw8DodIwpRD
 31fjTy7MLRDL/5d3YvrUP/WqPD1vOLSfaf7hb7UL4nfb6hAdkeegln+/GetYvaMf9fkNY7NW59H
 2plsLF4Qc3Zfg+HCS6WadWKci8t2UIy6Z46IzVp2FiFa05BVDKrjhLkIdCsLZVGLNxA8ay4iDLh
 yKxfrq9fUltouxME3dritqhzMV/NY2aEmoh4rdHoMrnCW1d4xDRwCk4eB7oUjZY2RbcpiWhHTBo
 +MMoK+aRCQ/QxnOYod21ztCLXtmTpod6U+a2VzQJdVPRINRK1flwvFM5cHBt2Fc8VCHSvkh/fhU
 B5Z0KWEaIRwRFEl3weHXdj9Bz7qpEWGESCO3ddAR8teegE++2u3n4nL+Mfczp6SKEdZM9sbzV9q iSwDzrb32XOE2Yw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d498b9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=njFOWPmiop8x3v1vudgA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PYW77AxCSdZaCNsNdCVmbM6StN064pCs
X-Proofpoint-ORIG-GUID: PYW77AxCSdZaCNsNdCVmbM6StN064pCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA1MSBTYWx0ZWRfX87Whqzyi0z/m
 xbxB0hB0WQuUANQS/fPJ8FmOr8eiV+NHwlVXn6GyWRmVDHfWrWpcFsEVY3zLhe1yFfGq2sxGtAK
 R+8Aa6h1/DH3xMSS7p7jnLk8JI27+1X3oSyMK1HRoTU73siMh6OMCTIqXXRSEyDQW7U1WS0VDwg
 6+J6g3Gb2Gv3I3xozgPfV4J1Y/J/K1xlm22lNQY+yjwp0O7dhuKZ8+NvwsOqxL/eyPAf6g1zA++
 f4RZIS7yPBynsu4guWo2NpjN7+acUeADbu7xZ3MkQift7RZLCchRii4cAfSB5FZ/fAh+O7lN+Gf
 TSkTUhjjdJHerP+K3wBG/VJTB1/y01ApV8n5I64yxz3bjGBVtLp2Ejv86rDTtPjWeQ8edTLO6N+
 tgDuX5GLFiaF9PM3Swjz3Pe64kl+/d989UDTYPzS42yjNCcnyeaXVISTVGDbXHv3enJsdLIYLC2
 9IK9nThDwBWLJbQicMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070051

Thermal bindings expect the node name with all the zones to be named
'thermal-zones' (hyphen instead of underscore) and thermal zones to end
with '-thermal'.  Also DTS coding style is not to use underscores for
node names.  After using correct names, bindings point warnings for
missing properties, so add also thermal-sensors.  Drop fake top
compatible as it is not useful in this context.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Drop top level compatible and other properties
2. Add thermal-sensors
3. Rename also trips and cpu-thermal
---
 .../bindings/thermal/thermal-idle.yaml         | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
index 1b77d542a7b8..bd420545803f 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
@@ -51,11 +51,6 @@ examples:
     /{
         #include <dt-bindings/thermal/thermal.h>
 
-        compatible = "foo";
-        model = "foo";
-        #address-cells = <1>;
-        #size-cells = <1>;
-
         // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
         cpus {
             #address-cells = <2>;
@@ -101,33 +96,34 @@ examples:
 
         /* ... */
 
-        thermal_zones {
-            cpu_thermal: cpu {
+        thermal-zones {
+            cpu_thermal: cpu-thermal {
                 polling-delay-passive = <100>;
                 polling-delay = <1000>;
+                thermal-sensors = <&tsens0 1>;
 
                 /* ... */
 
                 trips {
-                    cpu_alert0: cpu_alert0 {
+                    cpu_alert0: cpu-alert0 {
                         temperature = <65000>;
                         hysteresis = <2000>;
                         type = "passive";
                     };
 
-                    cpu_alert1: cpu_alert1 {
+                    cpu_alert1: cpu-alert1 {
                         temperature = <70000>;
                         hysteresis = <2000>;
                         type = "passive";
                     };
 
-                    cpu_alert2: cpu_alert2 {
+                    cpu_alert2: cpu-alert2 {
                         temperature = <75000>;
                         hysteresis = <2000>;
                         type = "passive";
                     };
 
-                    cpu_crit: cpu_crit {
+                    cpu_crit: cpu-crit {
                         temperature = <95000>;
                         hysteresis = <2000>;
                         type = "critical";
-- 
2.51.0

