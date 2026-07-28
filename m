Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BF3CFF68
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222399; cv=none; b=vFVeNQtxyw2Vf622rnMNSRMn5t2bPmkSSKw0dF7FOfAX12Mv6dijyuHbgxoZthiz6vwLVUeVLjXmb/es8PtEkJ24PuQaxHs1tVt8+KHlRbLDyUhgMB2BCioIrcv1nKdCh0BuOZOJsLYsCg+Tr+ad0grBEeoUoXDGmoG7JeL6Mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222399; c=relaxed/simple;
	bh=SGu2VEybN2k/9ZUBW3TXaefHtu25MIX17KuNJaGLcS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L70ANc+SRu2gXNrqV7W8PsGjH4atDeJYKnvXRTsxFSXWi1d1gE1D11G8dN+QYpkTZdPW3lXdjMNPKZ0sjb2ETMF8LA9u/RAVDzX4c6UJBnVmatDzJiVCvirE5Zv2Eo+IgD5Kw4d5EU40Bm6GocyA+1LV+WnNGiy+4bNG+6E78I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hB/dybVc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FHM4/3yq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hB/dybVc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FHM4/3yq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S6Yprj1824311
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0Yvq7P0pHVUHoibpjvNHce
	e4fb5G48fYm+WGei2Akt0=; b=hB/dybVclTuC2FBYsnX1voZshz1cATRVIwO6oj
	iWjwBkWjkMJujVw/UPtD/ODN7MbLsuKgdm97Os4oJ9H5+5UHthYw12zwGBLrKLT5
	2JcG89nxmJ9XqoC69k/j21BVP5I94CHZQ0FqyVtOxVS8Rnl199r90h+8nEDa5Ytf
	BF2HlaZADtDC5aG9M+9peB9C/2v7+tbc2OhmxPGxAxAj5v6cvIAJk8M8EhSTiALy
	NkvfQnq0b2ZRa+W3G4kNAOWj+LdX0puXyNlIAdxFBZRrW/jDHqkhal9DCludIuXt
	pQduMOzo56as0js8ZDHZ6hjhN5Ev3Qupqx+eM4L6WPFrcQRw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hg4g1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:06:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso3147574a91.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785222393; x=1785827193; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Yvq7P0pHVUHoibpjvNHcee4fb5G48fYm+WGei2Akt0=;
        b=FHM4/3yqVkiAUZRwFuMk7huyPsGbWFJbA0vrzOJhp045Hsmj9Y17+Pfh5HuLPd4YWg
         LGvrQfQ+O7bWd/Hjj7D+IaB4GuvRopbE59zY3DBrUrvoJN6l2CerMS4Hqx7mL2fcRk8p
         pNdHJ3fFCqFInyz4opBJz3e0HlksyD4xOABMn/XUfRpSy7PwFkmanAJUIkYAaagXFug3
         O/bktoA2cxeWcPLJV4OvbxYzeSsZfHErXl29nEFf2BP4aWAV5eo4qqSVB6GyMDrsqtJH
         2ILYHb2mcBoHlEFebiXdh/KpY5s4TPHpzPvfA+jQEbX9DjRsNk4+PK1bDzH/XrlwvIyE
         g9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785222393; x=1785827193;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Yvq7P0pHVUHoibpjvNHcee4fb5G48fYm+WGei2Akt0=;
        b=qQ9pUC5UkKKYlnMD4sR0Uw93zBu3A5O+mbwg97lW5GQ9iZuv9n2xUog+0gO2Tn4jms
         +B1WUOyi1F2Cc/eSO+hazKggqZFzAuluhlwsMLEybFYHkcKuv7GYvrpieB24MM7tRinp
         3dTO3HXkDnyVDFqR3MN7PPmLsI7oPxC04X0TjqLRm4NyvANepADv8LPDLcyqitmoVaC7
         Oy4oqqHFMYnyuKGtLcFZ/yLk1qGSfsBhcGjz/NjFQL7v+WzYnNuV0vQT7Bv2xLL08qqq
         Hq6ROYt2m9xihUtBdYRJpLs7vkL3cyhTSyZu/t/Cxb93sfZzitJ8+NHqh/6CmJybx6+L
         ubBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rod6yv5SJziMNPbFLGAbBfHz16kFOzrXBauXkM1/T+6uo8ZayxZTeDjXULOfLWiUpQ/mBfJC3mgXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4NQhNQmUoYeDWsnVHqGxx/oWizhLRh9E6avDUQ+O2ykOnUSI
	TpkSAEHkb0GFHBp/Fj6ofdh6Olxu4CDKR29FEkdHSIGONbz6lzVRKZFgpnVvxzlmRuPjSV0/N15
	5hG3kKY9TUplwDvUrDs656uGUD8i5p9hWpkPwiGx+mcA1NQ66g1MWErYQEeudRw==
X-Gm-Gg: AR+sD10+u9UqNlvrpWCD67SGk10i/PB9vlrgupyEiElc9tEg83GgaxVwwdlcUaOj/cT
	WqlIYezvNXKu6RBt3TKvrox9Y9rQIY9i5aLRns5cMPF02Au/I/s/lMtVVKea3lKVoViJXwpxB+U
	r6LRmf/dwR2UseEXwm1dYDml5/KDhuKV1bOgJFl3uDNxcncvjuqA/7ku1k4sozUBpUBtC4AWPtd
	/vhJynm6acEDmLGNSQDm8e0RWB+M69Im4VAqyI0JUFBJNSzhczgMf37NMQ9K/uv0sQJKsADppFX
	xLd9iN6A4Epj4ELGKACmBguNvFxFKNCknVsRIqveXr/5CasIjQSwuc2m6+MXuk6+r+8Va5uPSQg
	K77j8U/48XNzZzTsM/l6kM6qhL6sFQ59whjE=
X-Received: by 2002:a17:90b:3b8c:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38f6a471784mr1302690a91.10.1785222392695;
        Tue, 28 Jul 2026 00:06:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8c:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38f6a471784mr1302659a91.10.1785222392178;
        Tue, 28 Jul 2026 00:06:32 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm59846776eec.4.2026.07.28.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:06:31 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Tue, 28 Jul 2026 12:36:12 +0530
Message-Id: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVUaGoC/3WR0Y7UMAxFf6XqM1nZSZo2I4T4D4RQEttMYLsz0
 3QqYDX/TtoiVAS8RHLke659/doWnjKX9tS8thMvueTLSy3sm6ZN5/DymVWmWrcatAOnveLn/CN
 84uWrcmLADS6iQ2lr/3Viyd821oePe13u8QuneQX86pj4dq8m897WXsOcztXi1HhGIIlsHHiLi
 UICAxCCoDNofd91vtPid6ffKuGUGLAH02EMApAiD+KiAU1ILJa8j1HSnyrfJ3IpWt8JEfoqIO6
 rt+1YjGYbnBk4+U01cilhi+HUvN1TMKBoLuqWLuMehxrnq1ojCUTqOuZU1IIKldiKA+nTMMT3l
 1KebvfwXFXjU33erfQYCqv1J8+nhlLn2QoHT0O7JnjOZb5M37fjLLgFtk1Q1z3coVqB6p221kK
 k3tFfVhts0UfAcAToCqjeXluXOAb8D8AcABqPAFMBXkcEMIOg+dcEj8fjJ8Co0NptAgAA
X-Change-ID: 20260629-eliza_evk-6f30686b161f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785222387; l=3129;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SGu2VEybN2k/9ZUBW3TXaefHtu25MIX17KuNJaGLcS0=;
 b=UBvfnUMHa9rJQ9ViUH60DGTZTFMeKgNj4DVnG4JmeNM6WpuBHYYxMahTxyZfx1sOZSA37e2yB
 0uGUlmo1d5yCkzMxFSsNq+1n4gECM6wLTVThDcMHAHfjUY2SbhqrH8J
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfXymkGLb2K1Gxv
 b+cHofp/7ccgpKb2CVOMasZ+ATjKZ4PC0BPvAt5IHFPNoko4naSiRXV9SbOtLkbBPlXZPGuK3K9
 A5qTfNTsu/c88gZEAGf3s1tnHpvqb6I=
X-Proofpoint-GUID: IyuQhkLK8Vc9O6vH0LyydDnRL-qNwgMs
X-Proofpoint-ORIG-GUID: IyuQhkLK8Vc9O6vH0LyydDnRL-qNwgMs
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a6854f9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=X5jSGUCEViCd_g8QL1cA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX5Ozz0IR2P/Ko
 IDaJaiSl8DmKIC0SEyCSrJtfifL+X6cjXkGdGa0HNYXdulvX48zY1SCxZb+ELbqZHfpKx5ddVXA
 RJAPpBfGOKjmYFJ/az3SHL1szkVEKN3uVvfUk5HKsyXAqRNftz2Nu2gdnbyUM9QF/7l7sSkPIlG
 ckwlv+YQBEXmm9Mnj3oKZnpx/rnGOknjmarmzxDqH39qSZv6ifBEFZvOIbX5SDzJF6h2Yxe0vVP
 k6gUAouNJjsj2t5cpTK5DW3bVIMubpCWtEz+sMYTt8zMllEFQKpQGHmW2p6mMT3nc5cs4L25zgr
 ozzZXu4xx4vEIWiJBtPNYJtqYJCl+TnTkUagY704BphsO4SOTrd2UPXSSNntSyni5BR7avFPcfn
 Mgtvv2u6LVTVjR46l/F2XYXT6exkuMGK6fBW9QK1ac4rjsrmgo+GHyDdr1sH0gs5Dj/UhrYGUQj
 LnaEkcwgEDVN2Zpzezg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280061

This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).

The Eliza EVK exposes two PCIe ports:

- PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
  via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
  (connected over PCIe) and a Bluetooth device (connected over UART5),
  modelled with the pcie-m2-e-connector binding.

- PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
  management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
  PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
  the RESX# pin. The iommu-map covers all downstream switch ports
  (SID range 0x1400-0x1408).

The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
entry is added to the M.2 power sequencer so the serdev node for the BT
UART interface is created on PCI enumeration.

This seris Depends-on:
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v4:
- Added new line and used pcie port names as pcieN_portM (Konrad).
- Link to v3: https://patch.msgid.link/20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com

Changes in v3:
- Clubbed pcie nodes to this series (Bjorn A)
  (https://lore.kernel.org/all/20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com/)
- Added comment for PERST (Mani).
- Extended ranges property for pcie1 (Konrad).
- Link to v2: https://patch.msgid.link/20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com

Changes in v2:
- Drop patch 3, as this is already applied
- Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
  and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
  pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
- Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 229 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     | 415 +++++++++++++++++++++++++++++++-
 2 files changed, 642 insertions(+), 2 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

