Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B643B14D5
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910233; cv=none; b=LVZLjwuyGDn/D1EWKO8am7CyIW119XJmvy9+eawLF9aVMTgrBOP3weDlIAE1fXz9BTMP49XWk2EoYUhrCE4lJG4uEdkcvitAbIqCOARuYaBnJVLljOkvcaf5tE7/4aV6c8Dul52Qdwz9OJT7A1/bAHzn/U7oN5VHiAbdY+aH0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910233; c=relaxed/simple;
	bh=5l2djtNbAKG4yz59Sy0TGxxB5M2aM0T1Ix6YMc2Rlxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laQEFgSGZg6RoMLJCCm5SjcZmua3QywLs8h48GP7PbTKh7LpgponxQXnNiHpnmUvcM9Z0lyniU6kCethPuy6/hMxnTrGydWXOmZyzpiF3aZ0eQmqh1iYG9Qb8XkYO3KWkMXPtLgJhC0WPbXcrFzOempBxvn8Tp4Mpvvqi1pJ+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=clyMt8TZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4R4WlAV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="clyMt8TZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4R4WlAV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OlS72801776
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 09:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9TQChVoZGJE1ujfnF3D1YTCmrzz01p+wDC5
	U6eyAgsA=; b=clyMt8TZ9PBMiGr6oQ63qZiAEfMD750Be7MXNqRyIJ6k9WuvfD2
	eAzU0SJ/10PkBWQFZvnPx6UUXmurumz+J/4WE/5TfgPW8D3kIEQY8gNFbhnQJT3W
	KUPVJJZ0eF1WjixFVCtgKDX+msGmYCHp1XpROWIVoJFzp/caedoTiNTqDnmT1Mxu
	Zc6UT/xfqCHqcmVltzYSALh1/2gZITk8EYOqw5aZCH/UoJIUkpaaJSqtMEWwI3sm
	2e7I4Tu4+Cl6v1JNo1YrjV9+cqPHOOZfc0h/eh56Dzi4+ShBQQGByJ8Sg9vqQFWR
	BmKSYvPAP0eWVb+PjkRt437lXHvJw6ov5qQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3qeg3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 09:17:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137dd558ac5so389787c88.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910230; x=1781515030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TQChVoZGJE1ujfnF3D1YTCmrzz01p+wDC5U6eyAgsA=;
        b=a4R4WlAVHYjFgjivj5e7q1Z/gF5dR29Bhoqm7NM9dvG9BB9wL9zV6hU6V7zEpKms5m
         LatT/Pjgn4DZR4yw64Bk/ULZwjZBojSIWiSL6DpJZQ409TgL8PJ6ogJ9ket1sSLaq/WV
         TVV/HmgCcjt8h/nC6FP3gzabX5RZMRPsAkSxEbX5N8XiHl7LHhHCh1AqRkxIPsJmpefC
         ShoojDcux75ss8rUurbasp/AO66+xU12n6BtXJ4TcdAseDBb8/InHr4g61F73hcLVu1I
         W72oJisrnGRCE4an7ov1+Syufg7k80gC38NqAGHQDYqSwi4Mp/ZVD14U/gNtfhSNmIUE
         xu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910230; x=1781515030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TQChVoZGJE1ujfnF3D1YTCmrzz01p+wDC5U6eyAgsA=;
        b=lT57qKMiWWgLGinttz6xFVUh+R8xy8qa12D5E6yRNEdRLx0tZ1hdSCEDN7qfG0A8fK
         SxtM2W6bds/00YTyDRp93SGSCMbTZWtbEKIssQKa4+Y7CW+HMmCUQiSab/HzrUxnqrUS
         BK0h2rHkzjfSfFptz1/ZYZ8TTeQU3O6LEvlyYS3mLJn2GS1SpnJD8m3tDUu8fv+j5ujC
         WBPwvMMPyI8N36RR6ZOwSZIX2o7RwlzvS3lJBZ2HrEli8dyh8JXPCMnDOPBDxs7anfRS
         KD+COPOTs0hNMgMbJ6qKdtm2Hf+JTaSyx1ou0opVtFwMQJCNMrel0iEbA8/sUmuSw/mD
         WOmg==
X-Forwarded-Encrypted: i=1; AFNElJ9GgEeH1qFU1N9mbkrNg4ChfrHanl4ouLlftTnEEwzec6HUqVbpsqTlXg8Qc3hVO64+BX/yrVvFog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNiCDYIiDg3ynm3xTpM0wqGjv0LZ3/YuB/s4coL0f7fARMkd3
	FQ+mFS4abYZhyHlPSO3jd4zZQVoHSQ9wJLc6nkiP9mdkDOAweNjcS+fNLJxzL4qubEOanm+1pTW
	9mrZaAxXcCsWHuu9Gx089yw8Y4JUQHIS/MFjNAvcumJxq1vhmAGj12Kb2ECoXTw==
X-Gm-Gg: Acq92OGa5SfVOzRjpGocwvlpoHoh5x7zR1zb8ziRRRxLdlEIZ6aHScBUOcauWWjqlcH
	qG8wqq/S0mEwBvYMb9armG4kBXnTUHIxlvpDQwLBIM5H04aB6fHO6YPsbsPPcYvS6gwME4nHpDk
	zYyN729GrtBmjRPSimWKj0D6kJftYO1D4aiUtGUEm4nrnEAt0vq/10UP2NBdJ2YFhC2Cum+o5TV
	RUDFp6V4yZ4LjQBKEMPMNRmpaM/vOzuIXRPyq1ouwZEYmDPA6rmbQIkvGgtKPfCywr4mdUcuIrf
	8Fcl9eDMYppSqehJ9mpG/d6AmnULj0sv8JY13mIQXb4uXKwAWI7Jgrt1ycbrq7Gf7huWVEnEp+q
	7q7QD1pQdN8jtKtFERfRIEl1t1LCZJyZQSMtR9r82o7/KleIbrh6QebqjUkW8EXSeMjxiaaQCb5
	4FsQnFM6w=
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id a92af1059eb24-138067f0b96mr2904767c88.4.1780910229725;
        Mon, 08 Jun 2026 02:17:09 -0700 (PDT)
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id a92af1059eb24-138067f0b96mr2904747c88.4.1780910229057;
        Mon, 08 Jun 2026 02:17:09 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm12178656c88.14.2026.06.08.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:17:08 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH 0/2] Enable WCN6855 Bluetooth on lemans-evk via PCIe M.2 Key E connector
Date: Mon,  8 Jun 2026 14:47:00 +0530
Message-Id: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NSBTYWx0ZWRfXwX3CgZfZpdtm
 9ak8KSgTjppQJRfuDsgxZYWRMTD2gDkFSKnPJ1dqhADbH2E4evDT5H7uoyM9SwWw43F00nJ1tB0
 hcDTdHRk5RsMtEVK1PfgqUcI7OoTeXoEWn8djCcVYYuM72E2axNZI4aPdUfF1XeQP7eB8Zj3MtH
 hOXVf4htC/fqBvtF2jmAKTYx1XMycIvssVanMjWJqcVDl9B2SdqxdAP5zMpDx1sXeFTbm/L7Yhl
 UlZsM5Pj/Iv6FOmh9buKWp/LPwEZreFZJDZDyqXw9XMSgH3/TNtsDTYFAvK1ezM3C//QZ+uC3mV
 h2HDJ3Nl74RT5nAANlYAsChGnIzHmuAyEXTsHsbh5ONjB4YpELGtHsUwphvq/gKt4wR86pqnAOn
 tbIXIK30gzYhlSEgf1D56qY8hU7pzSPcILpkJHqy0OiU/xKi1ix0BNIPGk6D+UBaer6Bq4ASzR5
 xBvTGSwPJPzgIrciifA==
X-Proofpoint-ORIG-GUID: 0Tnqcy6b8E0_ecwl1AJSY_phJRSzuWR5
X-Proofpoint-GUID: 0Tnqcy6b8E0_ecwl1AJSY_phJRSzuWR5
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a268896 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=g11dK_DTieeChMdKYl0A:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080085

This series enables WCN6855 Bluetooth on the lemans EVK through the
PCIe M.2 Key E connector + pwrseq-pcie-m2 path.

It depends on the "Fixes/improvements for the PCI M.2 power sequencing
driver" series (V3):

  https://lore.kernel.org/r/20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com

Patch 1 adds 0x1103 (WCN6855) to pwrseq_m2_pci_ids[] alongside the
existing 0x1107 (WCN7850) entry, with compatible "qcom,wcn6855-bt".

Patch 2 describes the M.2 Key E connector on lemans-evk:
  - pcie-m2-e-connector node, port@0 -> pcieport0,
                              port@3 -> uart17 (BT serdev path)
  - vreg_dcin_12v (12V) + vreg_wcn_3p3 (3.3V, vin-supply 12V),
    both always-on/boot-on, as required by the binding
  - compatible = "pciclass,0604" on pcieport0 in lemans.dtsi so the
    PCI subsystem can match the DT node to the PCI-to-PCI bridge
  - serial1 = &uart17 alias

Wei Deng (2):
  power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
  arm64: dts: qcom: lemans-evk: Describe the PCIe M.2 Key E connector

 arch/arm64/boot/dts/qcom/lemans-evk.dts   | 75 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi      |  1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c |  2 +
 3 files changed, 78 insertions(+)

-- 
2.34.1

