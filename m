Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A63D9048
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314208; cv=none; b=fwAPnRS0BjUteWotJyJmsz9//QJoEH8x6O4u0B3scraw5+EFKLyKEuDt961/Oiv6bNcwPzQTzbAmu+xx9q/dBN1KHYssEuiaSohxDhd8bH+dsQJUNB0Ch7aeoAhR+G+INl8o+2qa3zZWYKsFvNnhelvT0GmmXVZPa5WDFZe6txQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314208; c=relaxed/simple;
	bh=YkWiwMK2UL7nJitylE4MB/TTR4aYYELndcelMX3Lh34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDCKbSo+eY845lk9NRZUYjTFHFDrgTRZ1rMsW2C0iQGh0O9dvTGXQ5JmbG4qb+LujlEYbB+jDBaIkVdgV+idZibwqiEXKPG1JXq525i72ykjJXULeOAD7+TQsamBLMU5ZtbTpGmV1/Vms5h1huCxQMmrNNCbMtjrmqJGIeXufII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HDbuKv0u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3CedNts; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HDbuKv0u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3CedNts"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RHw9Us1237549
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 18:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7gtoBvIM0vtUEFDzhqKijfXiWCi/e0CvPeg
	0D8zQXCU=; b=HDbuKv0uptQWGIjR4a+rPf2SX82MviCTbDH8Dlgr89V+w04+iXq
	0OFlBBumMYwN0M7sUXTkdvpAdagHJy+kpsN/0a4dGy1A5KFwLvXgYpjQRu8vAobC
	F3htVrjqEysJovZezoWAPN49u/VNKlr08EhM61h8GWTaLFD8d1P1EhXtJXTZLBTr
	P6iad2IY43xaVg9Iv+BmjDSQdPfQvAL9HXQg9hTwO/A1dOYN2siGVLn4Wd2r2bTf
	E1L+AiXaHm9/KC0mn9QYJwMdYkBgbhJkvqadtyli2fduHAiIFqVfLWpOUwyn8kYi
	boXVuFc5zB9DG+BECM5dtLS2NTNKU/g2myg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4hmk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 18:23:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b258636d16so104765395ad.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777314206; x=1777919006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gtoBvIM0vtUEFDzhqKijfXiWCi/e0CvPeg0D8zQXCU=;
        b=A3CedNtsyaZwpepRufyNtsW3HmEKPLbPuh4NIPmPxfYhTd4VlMZ6eEIA8prEcUGD1P
         AeEUicuITo9EK4FMl7XOxP4baGzTq1GiGJIBR2w8iMI5S3coI6Fv8AOLLcsqdYG0y8/w
         JbfqQIQ5q9vhE8+cYbD2k6iJS7/luEQXtLqGoKSR9L7mvKL8nTR2zElCDwqpk7Gxn6q0
         IIL6wAngsfUliRrS79z/hheASy78xkKbfNkh1SGGB357pm2U1r3Jp04QN69QlC6+zTxk
         h1bsMUqMYCKOT/H06EF9d/0ZeNvC8f9no98sOhp6M43RXiTgNgNXb4ggC/UWGv/t1tSY
         IeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314206; x=1777919006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gtoBvIM0vtUEFDzhqKijfXiWCi/e0CvPeg0D8zQXCU=;
        b=rEAc5IT+/AjDYwouf6XMZ3UHblbnWXk6cniAmf3RlRF5ibnErwQQJyTqORlj9f9VaH
         6ufCXAzIWhe6hveHZovCmqtgnDetYyMm+jIABTlNzIBu3jGWy+/7p6046dQGz5bwiqWh
         a3qO3uQpWJE13zjbdl6R7a6GbSvyvFoG3cdBBnLdhRW5JldDcECd5olHQJOSrQ5UgXch
         DO+qCzEdSYvd+poQpoZkJhdsz77u6BetT8v4V0xA5JFdtqWn0XNwUp9M7/iGUDUy7jSu
         Hzt7Vb70vCQ/Rz83kdb4VCpiZt8ZGSDl4WghiKZP6KGg7f9Twed2B8+BS53DbQxLrztj
         ZPnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hij1wR9T/VgrIb0wyMQPQ0FbfUVJuqg3ccfNCYqlLyBUs+67aCxnodpVgnBaLb0XDQ02bGwF3OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxoIyBaMb4IKpl2xLF8jsq6JvqNlpdOofTjXGVPqGkEkTwAuF
	0g0eqF6MjjJVrm9YBBzzDVOrO41e90p/uqkCPHxsO1rIdN+3gk/UQj/5iKMXVxLCF9Nqwp/rQgz
	LqGZTOh0bB97H3ev5zbl7VF3qj013Le/jistvwr3nmdye7PWQ/y46P78XpMIybw==
X-Gm-Gg: AeBDieuVKWebfL7iltHLlCAHFK+zbu89eCvoXNzcDcK6wP6qamvZgEslTIaYihheCLh
	hryq1aSRDbkEuxvQ+f5zchsn/jRJE4NgxgFII2R4QNHu7/DJqYT+MjrBKB0vQw/f1Ct2T1UTwac
	PdGi4KJvWQFzIXV+1bDRIwsBQc1lZPc8kwdUsrbUqa+EODFjf8dkfX6JQFYeQWW/cqD27SVpeoM
	6jSky/vUwc9WRQJ+SuqS6M1/arEcaG/D/N6tHxQkNzAbktJ7fksfkPCQrx6gg7PpNTXT2vVlgiq
	qH1vKE4kMq03kvqh7nPLuuQzdKL4uzRSZoX+Rj/1WwbNgjhCKHQ1Nd06LN6/39PVMvFlR6Kj2nl
	STGljYVi76yrGkew64FMZH21NhMEcBHUTpv+UuihedTxOfqYCYZ+Ba2q6Ujo=
X-Received: by 2002:a17:903:1a2d:b0:2b2:9f45:2266 with SMTP id d9443c01a7336-2b97a9336f0mr3015445ad.21.1777314205604;
        Mon, 27 Apr 2026 11:23:25 -0700 (PDT)
X-Received: by 2002:a17:903:1a2d:b0:2b2:9f45:2266 with SMTP id d9443c01a7336-2b97a9336f0mr3015125ad.21.1777314205010;
        Mon, 27 Apr 2026 11:23:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac8d066sm1224745ad.67.2026.04.27.11.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:23:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Hawi cpu-bwmon compatible
Date: Mon, 27 Apr 2026 23:52:55 +0530
Message-ID: <20260427182255.3649922-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1R9ZAXUjfrZdKNe9z6rZHSKKrU8FIsXO
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69efa99e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fFZ-BlF9OTnTLI8sbqgA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1R9ZAXUjfrZdKNe9z6rZHSKKrU8FIsXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE5NiBTYWx0ZWRfX16zTbFhjP+b5
 tmqGXVXb/UHlnfgnAgZ7GF6cId7ZqJG6cj0fQO6P+OW7W58XgqHrHrOSD0CWrSaBCMtJfnkPMXH
 5lottMGnshf1Ct0dt0KcpvM1B4K3fRURGnmHPnlQe2zQnWcY0A7qh6zEtUC4hA+UHq+R2601Fwt
 r4XYi5u7Iku2lauU1mcPxoDFr1LcHrnDNd9FKDEstfvvNw8Njm2xcEHrARAdy2EtN8yK0fbAVpz
 0i9z0uZskFiD48iVkJrWHk52k2xrrSrwZ3fpCuS/OdBQ/a9+AA1XaTerB+tbob/4SsljHE8WMdQ
 TAGXQ5v3j8oJob0sTBK3pgCupuOfyzBCVn6ecCRYLTfyfR/vlapT3qfG6nsq/jpZODriis85laC
 DGkThr44YE2HY2cewYETjIVNLO6Cm2gsQqAdgNm8PrBQMLJWBSYFprVCxWn42usjCekcy84Ns40
 wm7/3MtQ67iRVJTiO9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270196

Add the Qualcomm Hawi SoC compatible string for the CPU bandwidth
monitor and there is single instance present globally to monitor
the traffic from CPU to LLCC.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ce79521bb1ef..82b1d94d3010 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-cpu-bwmon
+              - qcom,hawi-cpu-bwmon
               - qcom,kaanapali-cpu-bwmon
               - qcom,qcm2290-cpu-bwmon
               - qcom,qcs615-cpu-bwmon
-- 
2.53.0

