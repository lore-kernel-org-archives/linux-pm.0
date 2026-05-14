Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDE2DF13E
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731547; cv=none; b=CdPgHFo6qpjEhxMr0ulUW4fQxAzhH9zszfp03Sy637W0RcCiib61/1lelFAQFinxcJ3T/bVp5hDyMwxqMkXpNO39s4fAIVxBTe5kub3WyY8TKV3pW8cuKiiXoqPTr0YNv00z1RkPzckKFivh2Pt36HA82gTxqMvpCX5qMkTBFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731547; c=relaxed/simple;
	bh=un0IRtFtp9HGA/SAnUxGPXD5R1Ixbj7GtriN+lXDHmw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t95BZ7uWOxzdF5EqZXYQvO1k0daU8OdvJmtPgJiJd3T/7J3SW1qBhj8uoWo+nYZTxZaITUEX4xgJhNjLckM3lws4V+Fz/FAljVeZjTOJqIIa4QVQhEwvAwp9ZN1zcXBVIhr5eD9QDYBBo3hU2MtlxAwuYv56pp0orkQSOWJXNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IXjueYvP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OAB3tZ/2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXjueYvP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OAB3tZ/2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E35Nb61096462
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AEoBtD056KIOqMNBS6wtuX
	6v1ARlOzo/InY0Kh8om3Q=; b=IXjueYvP2nFtyS1pkdpLJ8NzxjE7bdNF9C8a0+
	CdSrb8r+tjLbww7Yo8r5hhl9cpftNHLHSoNFZzKjWQZ4i4T1moZXo0Q5YHwyhtoc
	8sdsQ1Z6Tvt6+dPPZB7v+VE5L4ahg4rXt1Yay+JdSlCPzfTgsyv2/hnB80o0rtUa
	WgeVdoL49axhsU2wtkKCgli3DOtlK1jo+hkJ3iN+nPaT8Z5W94c9G17HT+eUiw+s
	SQpKbeGkSBIGRm8a5T1bkNe7DfV4l+JBS3wJydd1c7r+89jJpjNrFquUt+G6FDKJ
	Qeg/BzQtoHl3iPrUlX+ByP+iRmFH7rPOahGEOhZR5OM7xutg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bg59k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:05:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba6fe41283so85357865ad.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 21:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778731544; x=1779336344; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEoBtD056KIOqMNBS6wtuX6v1ARlOzo/InY0Kh8om3Q=;
        b=OAB3tZ/2cbBvIuy/CWsgXZIRmNdKqUthveTUtTXhBJF3DspCKL4ZD1WN6cv/IgMElm
         QXAVdY1hEb4SVqZCAJoPYblViAza2GmwBgqAcdx9BmJVGYWI05c6Gql3ex7BcnA+883V
         YZQSPxKpRbyOl+51kBqsrYqxUw7EoKtxHjq/Y0oYQdjnxx/cdHdSncTFZLO91jQq1Y6f
         vzvZmsxK4YdaYiby4O3QYxEH7a2usORP0JC6esubEtyOA4zYn/Dyd2wrhQQzx1+c0EPV
         Ld0J3PJiJErbCPEYOVe5T7HPRptlNZBG2tcL531HL2s/knlNbsIEdUYWFTwrsg6XThqF
         7NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731544; x=1779336344;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEoBtD056KIOqMNBS6wtuX6v1ARlOzo/InY0Kh8om3Q=;
        b=KDtN9KyRf+j8WXXPlMHRbrmivLDQW6iBybhHkxmeenVR2rEcjP/IuqhSKxRhiWNKOH
         rNMEVDEDqbGPW5xq/ervbBOb+0j3UU08K0BLXd1p9Dp+KBrU33I+cbf88ApxR10yA8fD
         jC0VkQ/QPnjAzvMw9fjLZbaWbOLLgqCjv1S0KX1rV0blq7Iyb8+QLtDKYINja5b29/IO
         kw65DT3rbikWqfUYyFVwQ4JOFygPzfuaMbnYYKos/hq0Fyj80lN01YEsIoaojmgx3UZT
         PEsSo1Btu4lahC7qzFPKAWwkdL5fzB0uTrZ75TcLAT1lAMALaEJX7guPWLt+KEGNWETg
         qSCA==
X-Forwarded-Encrypted: i=1; AFNElJ8oED5nFalLbpdFl0myV+AV717xBOzPbDMOcATWIG4OQoIo4fnNYGPfgcPBpdwdfaJ5ZfMF7KRk3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzumWqrmkuXG5Ry7/oSDFs/JO8o+0R77y+KZU91SodRornR4y5m
	AceX7xq3Ooo5yfUro9u6cRBDjKslQMRise6xS7DRphla73Hrb+Loa94z9KGH23Or6UQVCLJS2Pp
	uiqkLk9kI7XcCrJUeL24lmj8iLYb27brNQexnDtgIXLol7FEsay7jC8l6SImUcspr+/6fNA==
X-Gm-Gg: Acq92OGtFKXAGASbKPs8p4a2GS3KGi6ogCPG1wpiCODuR9hbtiFWKxAMUM/5uzWufND
	PgR58VdCoS4L6iTob9au1oohdk9aH1XaiYJ5gbdLxbTbZPkW9h2T2TXuvK5v3GpRqmIPjEyRZyz
	lQWyO7pBk74dMOCH63BbUjX4r+kHYGBQjNWMh9McD+NvPx++d64AKbBWH4yc8Av2sZRut8ltuuz
	zlOqneOGG//s91PYdaCHowVxNwnwmk+6fwBshE+tExQkFN9sB3K1DLGCvmBhpbS5/I244QU05yx
	gW/V1+1phs7U5e7GbP8pbFUJZ7hnMD0fjTyDEfNlvrzBVEaITcZlCHRyZavTxH6bQedaV77lu9u
	7d9rha/so+XRGb7psz+X8EtAGZ4RU3QEmjnQvVvUSsTb/XPttKqgn/i5w6nBaYVKPNeQOWyx6oU
	vIX9GK1IcUXpuT19hYzJncjbl3SRIjfPDy2geibWnQgRthkfu+Ah0+ad0eCez1DA==
X-Received: by 2002:a17:902:e74b:b0:2bc:dc18:35a2 with SMTP id d9443c01a7336-2bd2fc24a64mr53203855ad.26.1778731543886;
        Wed, 13 May 2026 21:05:43 -0700 (PDT)
X-Received: by 2002:a17:902:e74b:b0:2bc:dc18:35a2 with SMTP id d9443c01a7336-2bd2fc24a64mr53203565ad.26.1778731543269;
        Wed, 13 May 2026 21:05:43 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8698sm8035145ad.40.2026.05.13.21.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 21:05:42 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable icc-clk support for Qualcomm ipq5210
Date: Thu, 14 May 2026 09:35:34 +0530
Message-Id: <20260514-icc-ipq5210-v1-0-b5070dfbe460@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5KBWoC/x3MQQqAIBBA0avIrBNGzYiuEi3MxpqNmUIE0t2Tl
 m/xf4VCmanAJCpkurnwGRtUJ8AfLu4keWsGjXpAq3rJ3ktOl9UKJboVTTDO0GigFSlT4Oe/zcv
 7fsdIHPtdAAAA
X-Change-ID: 20260514-icc-ipq5210-0ab03f3a3e83
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: CLLCeqCArtKsFHQVMJvd2a8CfydZHQPa
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a054a19 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=07cjT_76NfHvuXGZdNoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzNiBTYWx0ZWRfX2bQpn3gikWL/
 Z7fdcxYctd72kZ9cX8XQXS+kdyc1SOllYmDorpdHl3ZMdEdS2Pw8KJt/mUMLqqYy+v7BZCYc1Rh
 BzZGgnNMXpvNfeDsGCEIo3xEjPhLphGqgL2/FW7uBCLy+lbZ9so3KrBdIGnCJtVDCjtcTQee7Ku
 9TO6bk5igkKYrIPEUoA2Ki5/DMbcBk56kCAlW0syPiSaTJJt4EY9tlWiNHt6+0kySKV7GSxOht0
 Y/nYUH0s7p2WubUKUtUdOGCdqAJwXLgdqDrKXt+lpvlfhWXaM2DM4mv+4ieFN0PbU+TZwiq6Sp9
 PlGCJynjkkk6RSXC40lb6hr/2CvMHVEWu6oxFJRuCdVVkA1N4lmWX1YdGgco7jLKSoJ80J/oZbv
 DzLo/DtBPGwJC/f96LIGTyDWs9rK77NA/MBoOBr5D2npLsnoDuuwX0QQwBLv9xb+JNwt4O8K5vb
 4YvmIJeRbz5rPTaCC7Q==
X-Proofpoint-GUID: CLLCeqCArtKsFHQVMJvd2a8CfydZHQPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140036

Add relevant master/slave ids and update the gcc-ipq5210
driver to enable icc-clk support.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (3):
      dt-bindings: interconnect: Add Qualcomm ipq5210 support
      clk: qcom: ipq5210: Use icc-clk for enabling NoC related clocks
      arm64: dts: qcom: ipq5210: Enable interconnect capability to clock controller

 arch/arm64/boot/dts/qcom/ipq5210.dtsi           |  1 +
 drivers/clk/qcom/gcc-ipq5210.c                  | 16 ++++++++++++++++
 include/dt-bindings/interconnect/qcom,ipq5210.h | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260514-icc-ipq5210-0ab03f3a3e83

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

