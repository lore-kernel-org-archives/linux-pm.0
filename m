Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7538F951
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516693; cv=none; b=Hs6C+0No2SuUrSa/rIbT79JM0Q/WPMQiaSpcuuwsw2c0lpDyBcAHNo5SRlZlc5WDDKBTXPHvKL6+F++O8cDuM0L++o8CwKQb2x4ui/Ez2qEkwxWopY7LowftChWJ4RMh9Ncu1gv2DcN5VB1/kbujjtKu8NHorxwn3hFYAc2QG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516693; c=relaxed/simple;
	bh=PQ6kFlkujbjEumz0+/YOBAnPDDNcW8WkaM8HVaueoDQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aXKBezIYL/5oRemg1LFBTOjZvktxxoUWeYGey6yLWs5YHBSegv2QHCK7rKXOwxFFTiSG1EK5qgqDb8r9wyQD1AKAHxE5uhKpZU3jft23b9eNxfq7N92PWIfmoJGGKLncBla7geCycDKFpiJp4x2//M+tAP7DdlOee9/vjic9m8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1bpV+1U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZ0XwRvJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1bpV+1U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZ0XwRvJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQwED494121
	for <linux-pm@vger.kernel.org>; Mon, 6 Apr 2026 23:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ow0rpNiShQqftCOV3v2c5h
	yeObiaytexs3/f9bNlGQU=; b=a1bpV+1UjqNKQ1uHNBcnpoYZeno/N8U4aJ3nMM
	qIQj1u1ZW/QRxG/a4UtMBevi4wf7xx+9dBvh2Co8mlLusdKEzxg628uaAq2b7pbU
	7vX6StTq5+bx+5u1DOqGBITExbwZuORW2lnUv9fiz6aPBoQmmkTUfE75qgR53lOd
	t0cRbTneZal9tnJwU8UMv6P8Ih0CNa9IOWnX4ga/cZHZRJiYFbsNy5kndRXqgQpl
	LErfTLPT6b9kYzwrF1AaNA4F3BHFLUzAivTPddBhtyIFJtedynRetfI/p/Vta+pK
	J+iOVU44Jb1P7k8Y56eaTsM/08jwyUHoB+2TpiEKx24uP8+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8r6kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 23:04:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ceef8e793fso4696752eec.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775516691; x=1776121491; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow0rpNiShQqftCOV3v2c5hyeObiaytexs3/f9bNlGQU=;
        b=QZ0XwRvJ4oQdgAdE0gM9udl4ymjRS6iXzrNjCtM6fHpeWe0w5GG6nMTedEZU1ESl09
         atBRQP8/xAA/icgNGm2zJ+ec9q07jTdHwBYFGs3nSasRWEG7qSrBIAn5V5vI+WRVhh4/
         smcJ8NDgcZtabqysB4svKPGGM1rgFYHonUSjOzEp/u+p6HwbY9W8deqUaOmC4uiiYQBD
         nTdBgH9d6BIxV1pfnd3DVo/RoN8nfO6c89wtj5MtU2tLyOxA+x019bQsWSFZFyneZ9B7
         TjOXAxNfduDCSuKYmqPUMxFp8Gl0fAnspAEQXtleX7ocHmmTnEdJNdy9hEtTCaxB7MLz
         paDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516691; x=1776121491;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow0rpNiShQqftCOV3v2c5hyeObiaytexs3/f9bNlGQU=;
        b=qf+ZOZEeMXlaGBcyrcJ8luo7NX57fiCXM14PmcsG4RwmbYN+aBFmhQkm/gviBmeYMG
         pWf3I9aWA1hjahjvuDKKx5cH7GT/VWYrgKrDr1srM1IK6pUvCK9KSfp2XhmbkkeetT7Z
         lNjDL+92vqtlZYUZCq1J5SViYBIIr1bu+8BekGZ2EL0pJRnwucwv6SpMz39oFan3Ddy+
         +D1YsO2SFoXbPrRhZVyrIu+OliaAO/RgT+ghGOLcV38PbyP8jMHZwk3QrczAAiH1pNfd
         M4rw+ZUejBEoYfQ6mI48uSXCLHqxbX+fclk9pqgPIdGZUY5/aB23qXDCNoMJoWssFBrN
         gTXg==
X-Forwarded-Encrypted: i=1; AJvYcCUS2Zmg9Or+qwRHeJxmarcyX4d/jhfOJepmpoONmpse3MMMfeAahDhid6R3/rvCICHkLVTnAgINyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxInDD3ivl8BiNS8MCI/JPMus7ZNrjcElmTk3/mnUz6mfwoHadO
	yMR8Pqr7gvbRFTWY96xzBQMpzCm+AGimPSWRytXAwSX6gnezdt+/FKDcl6aCQQochYMHtygmkwK
	jv52Eg0k5O3ezDHK2E73DbjMD4bBoK8MLZc5dKvvd7lbh4HvvCeEs1p4xcrfLsQ==
X-Gm-Gg: AeBDiet7N8cm9EZWcNKpd3f+5aWfqgyF13COVZlIp5GDWRzryEEDM6R9zv0RhYceqNq
	11BKBBrsTW6p57nadKx54PbdanrHPmACW1j0xWDApjEH2fTx57r/rP/3+jvOtPdsXLuxV6rD8X0
	29eK75prPAO6yE2kZ44jXO+p3m5FB/rha9lqXydmFLsdRx8DAuEBE7L0raejZ5L5qsUs5qIwyRh
	OBVG/P6WxDva7Hsu2tkYhXCObNcHMDbNx9Bk5ZzXvUeKs9akcfz9VWnAzV57gNWF0ysp+1hy7I8
	hnY842heAAiYtOTaUjBNpMqBbP0mo/Rvt30k9uD1FvkdPpK6oB0JMq6aHRVNI1dXzqC7fv816JT
	hiTM5Mn4ocEire7l1CzWw4HXqqFqGfByItW82LW5YOCsxFOD/X2BEzBIRBO6gab5ELwI4mV3BeA
	jA
X-Received: by 2002:a05:7022:52b:b0:11a:51f9:db0 with SMTP id a92af1059eb24-12bfb6fbd8bmr7961174c88.11.1775516691178;
        Mon, 06 Apr 2026 16:04:51 -0700 (PDT)
X-Received: by 2002:a05:7022:52b:b0:11a:51f9:db0 with SMTP id a92af1059eb24-12bfb6fbd8bmr7961144c88.11.1775516690543;
        Mon, 06 Apr 2026 16:04:50 -0700 (PDT)
Received: from hu-viveka-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm14853281eec.19.2026.04.06.16.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:04:50 -0700 (PDT)
From: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Subject: [PATCH v2 0/2] interconnect: qcom: Add support for upcoming Hawi
 SoC
Date: Mon, 06 Apr 2026 16:04:40 -0700
Message-Id: <20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAg81GkC/0XMTQ7CIBCG4as0s5aGn1JbV97DdIFAZRJbKihqG
 u4uNiZuJnknX54Vog1oIxyqFYJNGNHPJfiuAu3UfLEETWnglLdUMEZQa+LUE4lpjWatHLteSCj
 zJdgRXxt1Gko7jHcf3puc2Pf7QwT9I4kRSpqzbFRv90Z0+uhjrG8PddV+mupyYMg5fwAj5mUJp
 wAAAA==
X-Change-ID: 20260311-icc-hawi-d6dc165f8935
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775516689; l=1089;
 i=vivek.aknurwar@oss.qualcomm.com; s=20260311; h=from:subject:message-id;
 bh=PQ6kFlkujbjEumz0+/YOBAnPDDNcW8WkaM8HVaueoDQ=;
 b=GLMWv68S7fULcidmATT0KBMV0+k1//HKKWxC70kzcqFv9TMdn0dS7em2C7bofGyNqqQAFoVmP
 NNjIKDP+q+JB1pKGV7aG7GxZOyLtwRaJST6ULWitoNdCJk+ZbYMreo4
X-Developer-Key: i=vivek.aknurwar@oss.qualcomm.com; a=ed25519;
 pk=WIVIbn3nJR9YRWNRyJiEbvpgoHhNyYrmVqMUXWqAIC0=
X-Proofpoint-GUID: b7D_N-WdU7mpjo3NWIp_hhEqhatt8foS
X-Proofpoint-ORIG-GUID: b7D_N-WdU7mpjo3NWIp_hhEqhatt8foS
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d43c13 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2Q3xDJHZUcaiZJ3d9McA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIyNiBTYWx0ZWRfX1AUT59eYSCeN
 zulAkG6Jna+uNLG5qrrVbqiBCMcngP5LkUKYzL5LIqodua3JhpnZU2wfWPwA9jkiLEyeDENoQ3V
 yT7KFu44GASnNjNwMmxrPQOIPbO52yhGvwARw3dHLZ4ActtSwPmcZWxqbEYCB2E5D+vEX8xUVXC
 eUf+lfhD/pKiYFEcZmUlugbgjrWUrQwj6Pk907hhFzcFckr0G2QhvQc0jB3MtS1wWTgcL63W72p
 f4tW21hxICjTs4n2h9kFfHUhAbqHXi/879UaRjXNQNOFWnsL5hAney/z8j7nZpO3kHVlwnEKx2j
 igjBV+cL/8Gh42ZtNjY65nj+/BAS/hZ3TfzOwMhPs5tq/gq6JdC8TvKqWQ9/qa/5Ez5lqLyO8fN
 vw+jejWC27/HF9KhmMUUHqv8a7WEnZ4P2JC41SZXSJly1Izm3oGZdl7qGJPvI8Knc+m3TWXn4is
 KAOg8lEgnMCbEcWGDTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604060226

Add interconnect bindings and RPMh-based interconnect
driver support for the upcoming Qualcomm Hawi SoC.

Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
---
Changes in v2:
- Fix warning reported by dt_binding_check.
- Collected Acked-bys
- Link to v1: https://lore.kernel.org/r/20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com

---
Vivek Aknurwar (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Hawi SoC
      interconnect: qcom: add Hawi interconnect provider driver

 .../bindings/interconnect/qcom,hawi-rpmh.yaml      |  131 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/hawi.c                   | 2021 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,hawi-rpmh.h  |  164 ++
 5 files changed, 2327 insertions(+)
---
base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
change-id: 20260311-icc-hawi-d6dc165f8935

Best regards,
-- 
Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>

