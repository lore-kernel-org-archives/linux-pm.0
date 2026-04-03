Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5223C4FF
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176578; cv=none; b=ZFE86lMttu18Q4JbBOEW/oGCm8r4JF6wUmDY4p6ZAgE4rUVwwnLo19FJafl9iwzNDr68ga5StkjH+ZeFUaj2piLrEaVuaVrqXP+1xvnaRejSTZRBK80dPjOnAiFxcKcpHScUJxuV2vJpIjJEwy8RfsTnxSyM4LfHZF3JNEx6ot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176578; c=relaxed/simple;
	bh=8+zQnJVyiAurgkjhPC0Db4ho143HWCzHXfzFv1rHJrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IMpYLDqe2RXuUWdolhbiNdmJ104OyqP19V/CHgdy3gcWI4/HnBbqXs5riQkciC3nkerU+zY1GAT6c0v3FOmTF8kbaR5X9bJtaIMZHYnEU2SfqSimy2DureXqbyPtutoL7twvjV4D6D4TFVX0DfN2mtlLrYHGcOzjiwuzyBO6364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JqvtFzVw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ch6efdQi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JqvtFzVw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ch6efdQi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4YBW1562155
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 00:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h5UAAm/txxqbelO8VDP+Qh
	NQZ0HfLYdusAPKbzIIshs=; b=JqvtFzVw83pb30qhKk11CX19n+zsm/7MBeiB7G
	Xf7s57mq+7OxjmXhIeLuU/U8REts793Gr925F2Mfa2IlJDJ3zOKv4mCiq6bZ3p05
	LbHKyuMc2uyUtZERnzcVNC/AoSeHtiCr2SzlYrhNkUYrHsYzC/tqSdkAVvXC47J0
	iKXT2BPJ1iTkKj2G/ze3ZiVgYf4omp5Js7Ob4siHpWrgkT1Qjp67sj8L5otXMxzO
	/6dAODC3HfD8s0i8DjdYqtOpTTdL4aY46RqEnviGyzXkGyXuucpAHCJ8E/zSIh85
	+gr242b1gQhbLvWjjffF+NHntTuxmjtq54Dy4+S2zsHN/iYQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9um71g9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 00:36:16 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1270dcd11c1so2426967c88.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775176576; x=1775781376; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5UAAm/txxqbelO8VDP+QhNQZ0HfLYdusAPKbzIIshs=;
        b=ch6efdQiu3sYGbtS5YrzKM5iYKMbTrr4cHCnhVhu84pGGBGWqcoMrAbg6aF+MjYJc1
         Sg4vKUpPFTyGDCLhUyzxuLvUUjIaCFheU5y5I3dC1H+suGHT2vGJE9r2pCHrF8F0nW7D
         lOXDe6Kv8LvJ6RqZZRVz8vmiPDfs/DRXCRLyCxjYkW3a8bar5bhmrUbuECH+iRN5iLa+
         hSAcamTELjXML7TSqpv+1XHxE6adMDIl4rcAVQadypb4fZ29CqoSerNnxGiCwz2WGUSn
         nZfJJbYYkSadccXS1Fi5jAV3YV3lpixd5xc+pxxRjeCa7q0LbTmEzbHvN34450EeJFhb
         SFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176576; x=1775781376;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5UAAm/txxqbelO8VDP+QhNQZ0HfLYdusAPKbzIIshs=;
        b=p7HOB6Aze4DEprxi7eoX+c1kTrbP/jv9PfDWjm9b1vHcNjSi5LZfo+9X8TSLxEDWV3
         6qxLpQEEBx5yJq0LUaosMBIFOtNRW4QIXaymBzPM63zzWbsMx+vZRg+J6qYttux3LoHK
         zB9hkJv9yHmRe5XYglPh1UJRzcEpAmQvE71XjnUwSNNOdgDRvwPcvSZjWjBVMO04rxlv
         PRVHEmoYXbx9RT/9dGnr7NJLT3W1AK9CLrrPxlNUu0umytNCkghSZSTDhuKKQqSkD4wi
         TJ43LzqwOPgIpPiKtaZgJlA/yRkC0fb/YHupoF0digttEKwk0tLPoMFx/EXl83+hDkFc
         mYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGatZVOfr05fLPNFDB+jzrRJIvtS4VYLU2cEFFqXUBBpfrYzOP0EAr4XpE4IANS51Qs+Tqo6H+3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyotY82Tu6gnVBA4kjNvJ68r9n65mG9ZbIPIjF9A4fVDObRWaA7
	+/4bhnLjCBS6UxP+zcRd6hGmOmoo41O7/uhbVlNk0ZQvwGbwX4BQmTv2u3PZ9ch5BmFs0qlia50
	4GMV5bSiDjxxZBJ8nj4VdITNAgp9iodnvZW9f9dbGtNlmSbbon05tRm89RQHNaOHBZWoUog==
X-Gm-Gg: ATEYQzy17JnamQ8bQzV9oT87glqhvG3uRL8JteYzWGZAihPGQp3NvJRNIbLtN5T2AmW
	/96FlNaFLZKkrAQHmhmhNo0zRIFjCqf04BimDOcDH0onUIYgtSd+VWg0j5W4towH4exUygodPBI
	Y9eddZgZL1hukhhzvEhzCPIgne5aqkVgMV24yooDHt3GSbs6YiemQFWWP4NgTzmNscYqJ1D5SN6
	fc/wxtseD3W3Qj8pN++HmodxLN+tpmmlkrWf7KHMMBKPCy1K/KmGX7+TH8wiux2UcBj2Lkp8CSA
	QeyDVkOV+xxPuYQIO9sw3Lac2FlWeNceLoZTDbC9f84UprFraYR827+ioC5txSz7mzgI5NdzIAP
	mBydKRi7qdAaKXMWpmA4XMVrDDs7/t9JdtdXxOuKSt4DGgccj/vHvryASOpRoi7EVc48Ejpei9Q
	==
X-Received: by 2002:a05:7022:6997:b0:122:3a5:fc42 with SMTP id a92af1059eb24-12bfb745a46mr543695c88.20.1775176575954;
        Thu, 02 Apr 2026 17:36:15 -0700 (PDT)
X-Received: by 2002:a05:7022:6997:b0:122:3a5:fc42 with SMTP id a92af1059eb24-12bfb745a46mr543673c88.20.1775176575415;
        Thu, 02 Apr 2026 17:36:15 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm6290550c88.0.2026.04.02.17.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:36:15 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v2 0/2] power: qcom,rpmpd: add RPMh power doamins support
 for Hawi SoC
Date: Thu, 02 Apr 2026 17:35:20 -0700
Message-Id: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgLz2kC/22Nyw6CMBREf4XctSXlER6u/A/DorQXWyO09gJqC
 P9ui1s3k5xk5swGhN4gwTnZwONqyNgpQH5KQGox3ZAZFRhynle85BnT4sW8G7VTrC+5qBpRSKx
 bCAPncTDvQ3btfkxLf0c5R0NsaEOz9Z/jbc1i7694zRhnsim4rFtUzdBeLFH6XMRD2nFMQ0C37
 /sXVTl4/r0AAAA=
X-Change-ID: 20260401-haw-rpmhpd-b40a68a3ce79
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775176574; l=987;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=8+zQnJVyiAurgkjhPC0Db4ho143HWCzHXfzFv1rHJrc=;
 b=KvoD80jUtV9+vyWUVroOchLMOdOoMkZyHR1Wbl3LaSjT1X6E6Z9yI7FcBnVPxBKAXZBbn7VWb
 kn9+4EewxT7DH9Ann9pWE/obgLWjPylMk+3UweVfu7sfhHnD4VxliEr
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=U/WfzOru c=1 sm=1 tr=0 ts=69cf0b80 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=q5vjKfq5BPxnf1QuwTYA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: SXAPQhbRm-kFKvDoxwDuDXMz3gJSLG_b
X-Proofpoint-ORIG-GUID: SXAPQhbRm-kFKvDoxwDuDXMz3gJSLG_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAwMyBTYWx0ZWRfX5ooyYbSBYGvw
 cM0s6I/6C24tbIa795ChMjQvArBpu2wfgtiruRyuX3xIbIu/hM2agNvGNZDAxanhuBMHra5BLpd
 xfqGmTEskUYzKXKf39GE0zITEpI3My+ELDtGcAqmzbVWL5PP12jO0lJNlftbJuewragj78kQGFy
 xkjfeCYhAJ7fGjKqtqJkoNlNM6yJ//7GNJC01vYcRdI5s9bLW003X4nfWhFR8zJjiKbdhEscj6Q
 NPvH6S7+crhjk0sbcNaDHOdWzOeOpI6cCMOrUl+zJRcuhZ8bBJlbUScM9xTHJYyE30w40DF2RYg
 UN1DosMS1Nljk6KBBFmrGbBJ0gXerLwXV9yr6O89yqBD9FWJCZM+F59Syk1b3TtDW2vwYfr4kLE
 yPE/O42cWMmciVxcVcV2hl0I7PfNh6ma0KXqMnVwBXvIe4cW0zWmTGaYKkzw60MMM4wEFYY7aK/
 I5928BWaq6D1proRQkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030003

Add constant definitions for the new power domains and new voltage
levels present in Hawi SoC. Also add RPMH power domain support for
Hawi SoC.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Changes in v2:
- Squash patch 1 and 2 into a single binding change
- Add trailers for the new patch 2
- Link to v1: https://patch.msgid.link/20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com

---
Fenglin Wu (2):
      dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Hawi SoC
      pmdomain: qcom: rpmhpd: Add power domains for Hawi SoC

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 38 ++++++++++++++++++++++
 include/dt-bindings/power/qcom,rpmhpd.h            | 12 +++++++
 3 files changed, 51 insertions(+)
---
base-commit: 33b1a2ee3a3df63e7a08e51e6de2b2d28ddf257f
change-id: 20260401-haw-rpmhpd-b40a68a3ce79

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

