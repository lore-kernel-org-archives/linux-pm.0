Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511761;
	b=VkTVR+BN5H7mH+LpwxGBcyrx3SJUF8mxtviB8AwyRO5KfceLFb+6sobGLPL4j5Ody0b9
	 AaWwwaw13hZJhoheMItlkOlgRKGAMvmQ1ydKu1GY/jYkRTBlqnoV2P4S4erjXIgJoS3wc
	 RZ2xP3xj0R2SOqi6iRBkMtw74HGNwlwf8IiHhCfaH8UdknA2FT53/iRuv3taiZr+ww0OY
	 oBeV0OZEa4FbNjGm8S8bRylk52luOHFRQ8LbqN9yTMV4u/D8xBpVSuvr63ZMkZEDWJegB
	 H2I9YFtN6+pYjTKIdKiqMHQW1SZWz3fzUlQkY4mjO31ny0bUivhadwN52JXX4IhJBKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511761;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dqYoJREBt1bLcGHI9N6tEVrq0M37iQpxVsxlfBNiSFw=;
	b=TZdEsjLyzO6UR9fYeJvjW/HwxBxHxBf4F/SFzGswdbQwxTTDnDTmHt++vtCVpNpDK3AQ
	 6Tv4jDZ4vmm4i8l2Y3XqnGpmVVc7G+Uc485ung6ZzGQIz1iqu49pMuRCZu5+BNJ8HUmg9
	 XxJoM1EOd1AwrAE8t+Uwi3jmk2RhIOBuaHLxtiq1e2SChllOChJuiiDF74dYFNiPiNfLH
	 Hpt6RFETgVBr5K6YPtrdr7QdKgpi0U9H8wWtWs/jr8KLKXyUWS/KRVtTmelCyY8oSY7pY
	 UClxu0wy/ny7/S6pbLO5SBErWLF/i3ApPxhCp2WUJOwBXWnrWsCDw+4cflhRKOZ+c/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lxGS6a+E;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C4LgDr67;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C807606A326
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C807606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lxGS6a+E;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C4LgDr67
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8WYP52209288
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dqYoJREBt1bLcGHI9N6tEV
	rq0M37iQpxVsxlfBNiSFw=; b=lxGS6a+E5EMIxMX6vdtL2OVnDWJR2RN2B6eoz0
	P+7tbDzY63jsyUDvXS+Sq/yX4gYUFRaFseQtveYeSONZtnMPbRGFnfMc5XyyIOup
	xelESyQfhknh/1vh/hAPzfHl0POTusonpItunAUcq8E0jGnfFZyYOXP4RA1MCjon
	ogmVvmi1VdbkpxAxf6lj3xSxk3wJoIyE7dx21wONB40VBN1+wAg+3I981ee1v7Kc
	4WpOvKOLO2sETMK1dO7gYn2XBis0KLbRIOwN7nfpwbrhCqB6lViDsZPMxPKXQYwe
	GsB7LTHpO2QyquSF01xP6PXAZpQNgYtPzwa6tqqzuJ338YBw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy11w02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cddf142187aso2055286a12.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795511759; x=1796116559; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dqYoJREBt1bLcGHI9N6tEVrq0M37iQpxVsxlfBNiSFw=;
        b=C4LgDr67aYxaPNDlY1gssuPOXJ2EqGAZ30NOLgaZwpOOhHwDAG9bJv+1edt0z4oZo4
         Pw9A+Tsy4azMtQIQTi4CpofwrLJQczoiFEX+OxqlOedNUSCmrgoPIe8H9eN10rOSsb1N
         XMDudvzeHmYeNUfZhogXbWPKHFu+nkfJ1I0XRefikw1Lu8K9LHZfVWTZHzZXG0eub4jl
         vhzJYMA3sCKBfrwJ3rHo/3mp9WaoHQmJq+N5qEr1mGfQHjxZ/lTc1qwnBGn2IGGkp7/T
         g7DYL+ONvQDvUJenh7gn4D8qWAiYkyHocH48hW9tZkPHGhpURqbU2k8U1Tg1IiwlhO27
         bUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511759; x=1796116559;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dqYoJREBt1bLcGHI9N6tEVrq0M37iQpxVsxlfBNiSFw=;
        b=vh+h6bzyod4BOL1Nvy2jsJcz+TQH74K+sJ3CHoQL2y+EFvTMyLUI44yU8h+9AAztVy
         7JTkeidnywHBe2JqIE/KJw5sImKhp2uhlcXJfSXKMGttEZGyqeDpKrQWyTUHEkgc/Lqs
         F7NjzTdprUGdB7cuekjr8dVYxhbpRNSy4gwOAcb+w2hVsoSwOYLPRgmqjW145UtRCI7T
         SnpEA4dGOY3zajMJhaGbihcaj8WDuZLKXNmzrhRElL+RHnO1GTeUeE/wM8scNmmpeTtx
         +PdWEeeaLdrk6JmTizGCKP4uhl66+qNUMCggKY/GMbLbAZjcIi8WJaE1lBuGNBO+C4g9
         AuuQ==
X-Gm-Message-State: APuU4Z+gEUQoomNgvq3nTKc2u/evvOzydnXZUuSlnJl7nmhLv0TP0UZo
	fZVETdNZZ/kDiWR5N0VW9TAVIy7GBWOsKxnnqIPGmtUnKXch/Fqrcxf96uuvewXgiGl1JJN0zHD
	AjcWeTO4IVYQYFUPnAUHyDprHHpvvTfbAp4RGuje/NhOo9WOu122K2iKPPZ7yog==
X-Gm-Gg: AZFdTZf94iYB/DKthMC1Jfq7KetrxdhwycwXTjIjBFPQQvVghqIqRWi/kRyIJQlOmVB
	54MGk+qeys8GDHwlhmPf/6OGFFvk1/iDcV0F75xwl3WYLFv0BExY/kpttzp6Hi08a/fky59n79n
	+6pmYzFDeJ7EaMvd4R2vzgdb0aUP7g3R3oPCOJLhoDYp3SMRGtngh6cel2sndtPOCIiHwB374TC
	DMHcseNl+fgmKKaIalSraQ0efxJdhpguj4lNeI2+gxk5p2VZQRAqHYVWpVa82GUtJz2jGIbpt19
	cjtzw7JUqQAJ0YZaAUmZmYFe8Bam0jCrKnNjHbTLD515GKVA3S0L+lvklji4Na52KN3PRmQhMGH
	PrmAOsnoj4MZGsQ1FzBEHU4O4w+xbzSWi1BJ5WuY7RRxjNQVutREiLYT/97n7BvKpZPxA/zlRpo
	M=
X-Received: by 2002:a17:903:3b88:b0:2ef:e0a1:1015 with SMTP id d9443c01a7336-2f03f1fe25cmr125521645ad.27.1795511759346;
        Tue, 24 Nov 2026 01:15:59 -0800 (PST)
X-Received: by 2002:a17:903:3b88:b0:2ef:e0a1:1015 with SMTP id d9443c01a7336-2f03f1fe25cmr125521415ad.27.1795511758834;
        Tue, 24 Nov 2026 01:15:58 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c72sm66371825ad.54.2026.11.24.01.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:15:58 -0800 (PST)
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: qcom: Add SMBLite charger support for PM4125
Date: Tue, 24 Nov 2026 14:45:43 +0530
Message-Id: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAL9VBWsC/z2OQY7CMAxFr1JlPUZJmqRNV9xjxMJJXIiGUhq3a
 CTE3Qkg4YWl9y3957tgKplYDM1dFLplzvOlgvppRDzh5UiQU2WhpXay1x3wFM55JajXcqQC41z
 gOhmlLaRWuR47aa2WohZcC435/13+e/hwoWWrjvUTiomY8e0YmpdB1QE+5b+CsGwc9FeTaIWbA
 gkWffLKR+eC3c/Mu2XDc5ynaVfXyxqQ63c1yOvQjAqjMbHVMWDfY3I2RYrJoO68cyopQ751Von
 D4/EERKh08gwBAAA=
X-Change-ID: 20260827-smblite-charger-for-pm4125-d3168a705520
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raj Aryan <raj.aryan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795511753; l=2114;
 i=raj.aryan@oss.qualcomm.com; s=20260507; h=from:subject:message-id;
 bh=aVuiSjqEV1YfiTymSW1N6mxdxrH1RhDp+PZHYkBZdnw=;
 b=oe347MXBW1vvfgfDoGY1WmUX887vFuPSm0pywRhooiMMQH2KypR8EdvYmdeiKt2dlqthWHX0d
 oR3g4AoeLlUBthPpjnAqofDgrom1s3E5We+DVZ7k/uXdpwEymDSlJW9
X-Developer-Key: i=raj.aryan@oss.qualcomm.com; a=ed25519;
 pk=NMkZ/eGFLSObYX6FfysQiuEElPoUYghk7+2Jtc4VEBQ=
X-Proofpoint-ORIG-GUID: IFkSDYXXz8Q1sEpokmirfarzuFfcK0tQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfX6c7QomhzB6xL
 lfN5GdttKR7Qm0YQVF4xc5ISiQZ95kXEIqfD4XEG2QidZNG2JzaiF+Db7yAMjw0MMu/G4+UuLxe
 tYT77ox7lDwRIO6A9gwN+Iaxw5ESbq0=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b0555d0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Ii2Fi2QEgfE3HPZJVlYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfX+oYiEgZ5/mvy
 jNV2uJhQu5s1Eb9Ch5qLBz5jTx6otYep+wSxyp50YqlnBvZKunLz2g8mrVFemHgv0j5g5u+GInn
 eekjq2QI10+KGYIxz3abrZXQQV4J4vrTM9gTANFl2+pCbPMbTwG/HWLTRmn4dEVpfsC0NCVp/7v
 QoPCjzNilkeYoFxeJK9ddrNuVvRArzYdEuFtp8qLhlHj2RTwczJELMlNIXbBcWrNorD++In14AC
 zkDGns7p03zmCLTbGtTVvmNtap+XYvJj8WPVCdfNDkAI4s8Dw7SJsICdhnL4cYZlPLxjoGRUa/f
 bFg1agCL4QbvPWCSSWbSsmJxcjWF9NcTlMjdjDj5VCCZKFlLxAjjLq5nHL556drUmbX2UZvgB5O
 qfmQzw9OXrWmNA9CQWtdSbQsYhLzNlTW69rQ496cLUmEETYVr3YPbl6kka0S9sAIsinI4mWSuwT
 zNR84fxprCIwvsIpYhA==
X-Proofpoint-GUID: IFkSDYXXz8Q1sEpokmirfarzuFfcK0tQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240035

The PM4125 PMIC, used on the Qualcomm CQ2390 platform (cocos),
integrates the SMBLite switch-mode battery charger IP. The existing
qcom_smbx charger driver only supports the SMB2 charger IP found on
PMI8998 and PM660, so PM4125 currently has no charger support at
all.

SMBLite is a reduced-feature variant of SMB2: it shares the same
SPMI bus and overall driver model, but uses a different register base
layout (five separate SPMI peripheral bases instead of a single base
with fixed offsets), a different battery-overvoltage status
register, SOC-based recharge instead of VBAT-based recharge, and a
different JEITA configuration sequence.

This series extends the existing qcom_smbx driver to support both chip
types side by side, selecting the correct register bases and handling
logic based on chip->type. This keeps a single driver and power-supply
class device covering both SMB2 and SMBLite hardware.

This series:

- Adds the qcom,pm4125-charger devicetree binding, covering both
  PM4125 and PM2250 (which share the same SMBLite IP)
- Extends qcom_smbx to add SMBLite register support, JEITA
  threshold configuration, and SOC-based recharge, while preserving
  all existing SMB2 (PMI8998/PM660) behavior

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
---
Raj Aryan (2):
      dt-bindings: power: supply: Add qcom,pm4125-charger binding
      power: supply: qcom_smbx: Add SMBLite charger support

 .../bindings/power/supply/qcom,pm4125-charger.yaml |  109 ++
 drivers/power/supply/qcom_smbx.c                   | 1094 ++++++++++++++++++--
 2 files changed, 1090 insertions(+), 113 deletions(-)
---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20260827-smblite-charger-for-pm4125-d3168a705520
prerequisite-message-id: 20261111-shikra-qusb2-charger-det-v1-0-5a9d919c66b5@oss.qualcomm.com
prerequisite-patch-id: 7e516155b3e55cfdf0e368296b467c6d89565b9d
prerequisite-patch-id: 85a40d3799c93e0ff515f7ae2f9642435acea45a

Best regards,
-- 
Raj Aryan <raj.aryan@oss.qualcomm.com>

