Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C0397331
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013014; cv=none; b=h9fEQhdvK+NZr+dLccjlirxfz3mhzxo9shx/SldV4WQQxUg8vA/tekmUCQuuuBge9Hh25XrgqFf6U2VsZZ6xHpjQPfjE0VKzn7HeuGy9LiAeu6U9mS/HD62Pj7BDFzi02ShtK0yrCmDZAy7CGSd0jN0/xFEAp2a8DbyAxNzXeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013014; c=relaxed/simple;
	bh=f1kW0KfbOBwzfyvSB6qRsv0wRsKse0k48GBqyG+Gu0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHNUoLFahFJwb/Iw37SxscfJg40fvFnT9LF8SeaCUH2X/N17JpVIGaXYYNNHcpmdoXy2M1I0EBZa9yKlvyq058BtaUQQ8fi6fq+K0Ce6/ubQrCjhsP76iSybE4sn2S4Sz2vSVGU6g18hOcrSLjdG7oZX9D44rzLY0fxMRBm5KiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PD/G9MX6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aa+ibTxH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PD/G9MX6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aa+ibTxH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3S2j549149
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 17:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4LjwJAfGIMwv4JvSBnxIJgWfBxcmgUQORx2Zd1CjIe4=; b=PD/G9MX6RYrFDIaY
	iKo0vYuQdqDFW3yDhh2meMjy1DPJkhVv5WGSETjk1F0NfjMwfArK3u38fL+YKzzX
	aLgtqeESvTbCrDJvZ8tNyMVjBCmYv8dOK/S5kbWI/lM32rwyyo+bcoSfWdg+xLpr
	tBmELcuEiUmpSsauDhiLxNu4p99cy5gg2D4sZhtiuRp1ugH3azLvNPnHtkeXJ7xR
	qZGt5dOIMg02UlssOkyEhtZMpclxfVkNgfmR0HwW1kI3O/g/yyqJSfD2z3WMJ0Se
	gOIRMKO+vxrnA8kaziAV7lgJjocaM6O3yZXaZlmJVLeQQLsi2V0mchekjzmjsrP1
	wBSIlQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98jyhm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 17:23:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so2946095a12.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783013008; x=1783617808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LjwJAfGIMwv4JvSBnxIJgWfBxcmgUQORx2Zd1CjIe4=;
        b=aa+ibTxHvMxHUro+87PX01nYss19HbAQQxOFQ2dJyv1OlIEUeQll3ndk3SF/LHjnan
         SOt3MFL+ApMkqRwHmUSdQx/UqGg5pchV1GZg9yAGwYEEfBCQmo+3nV+eH5DeQ5nMLnml
         grTJ6v37EMg/QHMd4LkQDUeGmTS4SMnprQaCZkJMae5mnTtiqSGJmBXhjV/nNXJ8Kylu
         g/iVTLWl8JuIZVeGq1L4jQdqqmmGqLRNihvjdBnR3CqdIPGzLOYXBA+0M+q+r15LV703
         9c/1Mw+oO64qs4hkXS5HPmYj9/Olea/YinY7+XFADvrsLgcuE5eKXd80bZrD7ij34ODz
         5RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783013008; x=1783617808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4LjwJAfGIMwv4JvSBnxIJgWfBxcmgUQORx2Zd1CjIe4=;
        b=csKppaz+TFpdY8nSBYAFdTVf3hCn8pjjJ8fkpbBhBgCjtdzv8BdbEJ0R4u+4OMegHX
         F+1X2XqmSVJK0xPT5xaakCKlGvsLD8k0t0D0AmcQq9ijE2LY1anQxwbtTe/p5mHCSLgt
         jQOakQMVr1dMDCg8ylzeTvulTJfgpYg930ZAWUc6Mf3d6lNUhH17X9aL/tza5au2ZBIC
         cMIAw9z5DR0MJ3VFo4koubjGswKSyhDZYx06SY+T83ajbAfggr3sJMLdvzNNYQ+A6txK
         tw+gNsNVlS0kSi3nqLIH8SHfebQmF5SDBRv/z6T+FQAj3pH3PK7FwydmHy//vRIVJoV7
         ehEA==
X-Forwarded-Encrypted: i=1; AFNElJ/34MgAHeyrSvIBx05AcAdpFmmLGHAbDLJ5LoQ8WJGOSNtbnO7gFPs96bonCvTEBMCV/ZUBE2oDQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42Db1P3XHnkhkfes72b0FHtasznNZFTGTH8YTqp0mPgtNntZ+
	CSl44kBPKwiaE+rT7Kd1G+Kqp9M0HKpPybcO6JULxLXAjhE1L/ARlNDymvxiNt5HhwAbBhIB8aD
	aZ5pNpxzJ4TJvrzlw8NLRPRE7MgHNNmQgmZlmMhVGJ8nYxwk32wC3zHJE9i2Iew==
X-Gm-Gg: AfdE7ck0IoAI9PypSozsmOsVYy7nLTJG6uIRSL7dF5qeWefG/517sMNcT/BHDousicv
	la1S2omeHASb03DcnbmQP4nYixKQysESGf0u4R0Y91+J9vJNSUASFVd11xZ+eTMrzn6R/9tGO3b
	rHmXhDpq+xfRoRWPg9pnuEyYFY5DyPcZYKhkYJyQQ1+lzojXi7Z2PnCWANj1YwHBWJh7mJUyrfo
	KhN/7TSMsBxN4j3Wnj1nfRa1dC4BNRtSjvysUeZRROeTGr4QnIlPHeTR2QcgIcwmVHayoO7LCyN
	W180i1ZO8q3zDyw+Wny63prbyV2XQPwHX4XGsLVp5ZnQxuBeErDTOAoxFcVYVV32ScDtmrt+kq5
	4HJ7H3VsngdklRXIazv4pGKYqmnhMeBMIGYmgDah8nQBHFQ==
X-Received: by 2002:a05:6a20:b40b:b0:3bf:b9de:854d with SMTP id adf61e73a8af0-3bfed2b3ad6mr7932455637.23.1783013007746;
        Thu, 02 Jul 2026 10:23:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:b40b:b0:3bf:b9de:854d with SMTP id adf61e73a8af0-3bfed2b3ad6mr7932404637.23.1783013007223;
        Thu, 02 Jul 2026 10:23:27 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm10564289c88.8.2026.07.02.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:23:26 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 22:52:57 +0530
Subject: [PATCH v3 4/4] arm64: dts: qcom: glymur: Enable SPEL powercap
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-qcom_spel_driver_upstream-v3-4-434d50f0c5b0@oss.qualcomm.com>
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
In-Reply-To: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783012984; l=1091;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=f1kW0KfbOBwzfyvSB6qRsv0wRsKse0k48GBqyG+Gu0k=;
 b=wmK6qDX3jahgYWIrKjsQYC/RtdfcAAJm1MmeDtfPeAyOAiPjjOoPupWkQkcyQnN+kadpTsN9A
 OvcQXq3+n3EDEwVxHdkDs3UBzJBsu1Pj/kYJXmhPg9T20ItLaz3aIBg
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-ORIG-GUID: N8g9CTMafslHEMXXq18MrYobMPv22Jb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX99O7UHzSk63f
 e92rm51euZE69txijsvQmak+72VgzfqkENW1SfhMK3xzlRdCu6ucUWj4/fgAmgiM5iQ2fWlHZ5Y
 cLIpxSvlBhgUc/QgA4O+d7KQ8bktWSCwRJ0DjE9wjA2TduLrTnr8JAWGfo2htMJnVwpU3WZWf8r
 NQ7yUqKe3RPqgeWkp2wa5OiTQY6noYZ9l3M+tTJom+gLqklI5qY3YqHPRksKNElPQYBUODfb0mb
 YcjvMRx35ufsFMr/iXHglgbhTv5MpZ0WyQAI9uOggXBQBfv9kajY8WqYrTMW044WcO1oTeVWLGC
 W0HOuOZ/3htbKIrqmcoxqGPK/p7Y27s8RAiSZ1jEOmTnXDxI6zocn+ivFLm/HjOz5+P9c624pDG
 5hc6DORoNHahr2C/vwUn+fCmOGAUUnJmyZ97Iv8woVcbwuf548SiFsXvudc9KkO1/6P8XYxvkB1
 ++VNXMmzURdhsYHLpKA==
X-Proofpoint-GUID: N8g9CTMafslHEMXXq18MrYobMPv22Jb8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX7/RyIXJ0jRdt
 La0eg++AFpWgvwJQ6r1E+jP6A8t+zMXqfTil/AWB8XD7JB8jmah0I2v8qSS//uiQiOC2rOYJZ8D
 Xj/+mgTVln0SeOFwo32NnfBhg/c3Tj4=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a469e90 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mqSRqqF8xmN81XtCacEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020183

The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
based power monitoring and limiting capabilities for various power
domains including System, SoC, CPU clusters, GPU, and various other
subsystems for glymur.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 20b49af7298e..9c942db8c824 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -5045,6 +5045,16 @@ spmi_bus2: spmi@c48000 {
 			};
 		};
 
+		power-limits@ef3b000 {
+			compatible = "qcom,glymur-spel";
+			reg = <0x0 0x0ef3b000 0x0 0x1000>,
+			      <0x0 0x0ef3d000 0x0 0x1000>,
+			      <0x0 0x0ef3e000 0x0 0x1000>;
+			reg-names = "config",
+				    "constraints",
+				    "nodes";
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,glymur-tlmm";
 			reg = <0x0 0x0f100000 0x0 0xf00000>;

-- 
2.43.0

