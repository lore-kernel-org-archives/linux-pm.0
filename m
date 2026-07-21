Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE615445AF1
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626342; cv=none; b=EMorNFqy6ESPjHaJevyZ7uc+2HLcXgiK6vfckbG/4VcZs7D1hNfmLqNCISjrW292Y5rIXFIrocBTsb4GF0kd3QrvihEtldE25R4FUBmZWjK14xxCCcaE680YNLn8ULTqMaso+7DGmGiKGRuqbiwvBsqktIujjUb98Qf5WKWEsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626342; c=relaxed/simple;
	bh=frRZ0tu6AqPX/0VbOa0cA1iFkH71llk8yLCIG3tFrN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JIKwnhYosMaO9pLLDMBSGR7wRs/Lq5XbVoyzrEABjnnSpMKlKhWUxDwWlrCXji2wjl7Dffen7ML3fUnzvdhZOXDMFJUWDavZrRM9JY2DOui8akLV+AgjKK3CcJ2HYGjh1TagtqPqBj3aAniTMa02+N03oA62ZxJltEqhfycH/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KcECY40t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S6b6W6y4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcECY40t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S6b6W6y4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L6Nbuh045396
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2hrPn+kSJ9X1wZ8n8IswgR
	vPdGLpuJP7iOmwY3fILyc=; b=KcECY40tVdoKFFvIT996fiJY61h4tJBPiyzgSd
	7F1yune6DANVNF4HC+oKVOgvQJVXe04n/b9gBjhHr7sVIAnWIEflaFGnxuw0IQE9
	TefC5hUmzxEpHJIjlbFcn9UgRdU16WR+6oyufg1e9WeK1f0dMNMyjPl1XOW8PyGj
	+gWFDGOJxCUgbL6hV6CiTEspbSPQsvV0toJPJvwdAJTLz5GmbiTRuPt6Qr899Ox9
	OcpDS7SARnYdj2Nx9YVPGSsfGKwHEf9GOUJeqNV7twMONwLlAtv55JYaVQGTUgGq
	sz4aVPBPYMex7fPMdPiGwPFxkPL05MBNaNDK1EWw8uTHuYjg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5upsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:32:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso15176467a91.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784626339; x=1785231139; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2hrPn+kSJ9X1wZ8n8IswgRvPdGLpuJP7iOmwY3fILyc=;
        b=S6b6W6y4E6thCwwvpne6q7baG86S9KTtriJimwyVjcLvwrqjLn40HsGUMyZ2AlZ6yc
         OcIY186dNe8fJDgS2wOX8d82R0cWF8+QVh3LOE9n1i7OtAauHYwvP9PkWIeJABdpkJgc
         3De5XBc0vpB2ntcibuHBYtcy36VttpJTnFEzvJUflrWpEYtRo7BVA4TCSPDyDGr0vCNk
         huF7n66OF19MUgNuSHoHUm2/Rd66XuyUs5DNT2ABmTqvQbcly3000oDWIPR6wpjscaLF
         Iyf8Msckr77Rvcl4zG/we9AEfwnhxQdPwuPOYZfQxVhn0pvOz3YJ5OBUSdoJTZQe8cn0
         MCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626339; x=1785231139;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2hrPn+kSJ9X1wZ8n8IswgRvPdGLpuJP7iOmwY3fILyc=;
        b=EblvWFuHAMkY4oIqK87Ycio6tQFzi1qZOYSxKdIW/mddihmTsRaxTQKicLJQtutcW6
         Fc4K4HiWzcicxT84qY6OWZLiYUI8OFoomIQvRWmWuHNCUr+43SsuXMO9uKgIX7jpee0C
         1LXU+NtMMQJteprEiLM+T4pOiUP74InHZIWD/+5sqFnYbIk0Z9Bw3eTtzO7Yf5MY42Ac
         9TH0D5WoouSOqqXHV1UXh4BuSLLMyLO+DI+v+1q4+OIjigrh6Vj2P1jlymK540SmEJXc
         god/pTjAGc/48iSgnT5uG2G8JBCA31QJAaviYGpmpu1ABbdqMZH2b2G6EI5dT0kvx4Dr
         D1nA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5Qkipcdq3rVR8HeyJ86Djz0pfDJEZWRjQUwnckJ2ZCS+GLIumOrVGzCz6XsdrixWrfzRDRAEw8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0mWeShXebuHh55LDmUZHZi2FuwS1i4dCf1IiD531uOS4MBAh
	4jMC6Yp08Px9h3VvaQOJjDbwAg3ZN1RxegNdbX1gx7QuO5GTjtmi2FZQO0VudFrBiprFjtOCId8
	EqdM2OzhyPuHjyHrmjFWwa+vXJO+SRrtAjq8lFxtzkdnFH0f/wU4/EiUYt6pucw==
X-Gm-Gg: AfdE7cno35ksZYE4EqmdaKbY/kzwDVuVKlcO93r7VokGGAXwnPf0WoZ0R+8yB9gBaEq
	EGGDxPH6ayhyrjIe0ezM9mCByxSUZHJYIxrguWjmGu2imbZohM5TdgqWmzXSS8nfWOe9gRdtg9/
	h+h6GJUhOzM0/U+sA7F+bvYcerowD6qVTh9m5G0J/Xozt90DHoXA8VuLLjC+HSdvQVamEqaR+WW
	LwvNPoKrALWBqIzHceAXyLggfAS72dI8VAd2JW3utrQml2oD6oCR1MVcWR6yFwRp456SrcH/Xpu
	mn/iEIBfdEPRveH2QADAG1cHsb+hFznq3hrpYQSYwMWo2z2teGB6+ItH1JmWSDweMuoq1Pq/AOD
	M08VL75GcSbeH4I6FKikz9MVSHeFLysu6CTU=
X-Received: by 2002:a05:6a20:7487:b0:3bf:6c05:ab with SMTP id adf61e73a8af0-3c3ad9d632bmr19205531637.58.1784626339129;
        Tue, 21 Jul 2026 02:32:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:7487:b0:3bf:6c05:ab with SMTP id adf61e73a8af0-3c3ad9d632bmr19205493637.58.1784626338650;
        Tue, 21 Jul 2026 02:32:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm49420949eec.14.2026.07.21.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:32:18 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Tue, 21 Jul 2026 15:02:01 +0530
Message-Id: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJI8X2oC/22R207DMBBEfyXKM0brS5y4Qoj/QAjZu2tqaGgbp
 xEX9d9xEoSK4MXSWDtn7NnPOvOQONeb6rMeeEo57V+L0FdVjVv/+sQiUdG1AmXBKid4lz78I08
 vwkYNtrNBWhnrMn8YOKa3hXX/sOp8Cs+M4wz4nhj4eCoh4zpWH/yI2xKxqRxLoBhYW3BGInkED
 eB9lFZL49qmcY2Kbk36cUVGZJAt6EYGHwEwcBdt0KBIEkdDzoUQ8bfLtUgWg3FNJJKuGIjbkm0
 ajlqx8VZ3jG5x9ZyzX2rYVDdrCxoEjVkccd+vdYh+PIi5Ek8kDn3CLCYppIim4CC22HXhbp/z9
 fHkd8XVX5fjdqYHn1nMN2ncVISNYxPZO+rqucFtyuN+eF+WM8mlsOUF5bsXeyhRIFqrjDEQqLX
 0J2qBTeoS0F0CVAGUbKeMRQ5e/gM4n89fNONYhywCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784626333; l=3073;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=frRZ0tu6AqPX/0VbOa0cA1iFkH71llk8yLCIG3tFrN0=;
 b=BuhS7dwlwhM6jlIekOWi4Hr4hb3RnKnmL0yCeAWScHF4nJSYGXDH1NeeoLSZb1lM14t7mt7+x
 d9Y1LL0oHX1AS9GDTu+F1tVz3rMKFiGcQbPXC8pCH99vbJRqSmfUa/z
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwMCBTYWx0ZWRfXxqkXm+ojApnU
 xB7rBSKFrBFDoTm4gEKQzd+Ss9ldRZ9+er3zTHf69yluGd6SGkIAOjAZNABmO1JENRKmYkiUJgR
 lVYB5R8/hdHngG0UzfcljD7DaWrw2zVddWdqQUTVYKnYC2HTTXwg/SA994jUAMMloPjaOliGCex
 9p1RZp+occOGIbJSUcu2PZfEmDeayqQ6SQiSYDnN7snszGK5659r2l1Oj6YBBaJffmZQas/FIMl
 YtJME9XLlrWQndO7tRzG9XHq51qycRam7XtJAnMJ5zzP87rNgN34k0cjE7ypGRCyb9q8A5SY2vl
 NiDbs/xfpz5DtoeRAwwrxY45fGyV8XONyE8+SiYWe5JjuJ/UyNYTuBTu36EZgZ6McDf7cAHcb0Z
 a6a08cqRNb27GfW41N4wg3wyqFFqRT9FWqtlaeD61nWOPESOqDI5yaEaGNRZGRiHWeQWXvbMeVP
 DTKRSOCehK0pqya3qKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwMCBTYWx0ZWRfX4MQ0GVry1aIl
 0VZ4zgtHnErYxMV5xMdZqjPcUH9dSIpYePZgOYUp3SljGAh5izVNTY3WmzSVyqpgoAWyLI526Fu
 9erPBNbloa5UQpXVnZAtXfF/u1rMDSo=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5f3ca3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=UUeChs24tHZU6zr2FsUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: c5IcsoJBrPAa7EmsIl8vVcbjnP9n2XGm
X-Proofpoint-ORIG-GUID: c5IcsoJBrPAa7EmsIl8vVcbjnP9n2XGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210100

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

Bluetooth is enabled with this patch https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/

This seris Depends-on:
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
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
 arch/arm64/boot/dts/qcom/eliza.dtsi     | 414 +++++++++++++++++++++++++++++++-
 2 files changed, 641 insertions(+), 2 deletions(-)
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

