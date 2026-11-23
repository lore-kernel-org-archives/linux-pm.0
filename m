Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429538;
	b=fuUogeSqnIR2ESLfQ9CkmfYG6ffIAaLcu1YU5XvB/nGtQ/2TBfu/1ySzjk4Fo53Nyxpu
	 A1xEqBAU93gHiau37bDL9G5iYsUFR3mwtMltsGDLJIZQ9fFJTd3OQ2SEJniN1/nvA/twj
	 qRI8t7s+Ltv16UiDN2o8VvEl6H8rFduwEFvP2idtims4itE5132uC6PTHy7DFY6b23XSa
	 4O7t2NgsubqzILdK+6UIHc/Q2H6HvogLHXmKbGyutY5g4fwHlrSpmI0Mz3SvCM8p5agUs
	 7QSEDqjUszwuVw0HN2WtqhOIcpeJIGV/2M9kOUHybiPfVgipXof8KSw/pKjSAUOBRlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=THgzxQz2Mg88/jMiZP/HsQu33/8nC9mZNRYAzZhoth4=;
	b=GZLvaMjVLzRloUG6WYqc/Vm2IFQKRYKjv2/bz4aCOYVqf3mA3nJx8RpGyIdglPDi5ut4
	 xY2Hso3XsaviLJt/B1DOw2QUoEmms7tHcpbh4Gw+1zCLMK/oWURDOyxYz9MxaFNh9Xfj/
	 py5AFUvbiG3c6swzjxo3xuhuEMYRxW3+/EYl+lxM+CYVtwEwzcmsvT5yerka5HPw/HVi1
	 b9D5q9ak86RjnZZf/rYaxwNxHMxcBu//Ql2Gg5+i8LTLYdc7+ZUvFWXEATKUYvx0a4AB2
	 2goTXS1g/U5ugzLRdoUy+TFUlBGjD+7aufAplxDlQ+HDe839+v5K3XL0PqshA1U5jJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="GIl0rVX/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kq8B4sfn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA78606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA78606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GIl0rVX/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kq8B4sfn
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9GZNR150166
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=THgzxQz2Mg88/jMiZP/HsQ
	u33/8nC9mZNRYAzZhoth4=; b=GIl0rVX/4v3uVNRqPF5iLinhOXxWLRwRC7Ck9A
	hDsNJis/zWGyZjg0bZGO3Wd8zhqo6REYFqU7pEyb8S971QKRvwCT5vvjl5A5cQa8
	fM8ra+lS/3I6t+fSQ0L4qBVMSitVfdfQoHuC7VtLmjHb6oJ9qG3wj5wl5Mk3PUDP
	fM0PcDWhjLA4VmSdcZ9S3TR5jKrE7VefCo6vavbTwkVzeoe6GshH7TlKDxGHgXji
	Gd9ZXgf6CSxrF2SE3IaOg869UwzpGbblLs9KQ7kye+4Wjc6WQ0/k0ncCu5LKiqrM
	xVvNvVwFtyAf4uZo7iUyWasxKlpTwYP3tUncKixpbEAuJreA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34fk66vp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92114c39cadso61982876d6.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429536; x=1796034336; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=THgzxQz2Mg88/jMiZP/HsQu33/8nC9mZNRYAzZhoth4=;
        b=kq8B4sfnSesJ6FsVn8IZsTA1XWt36SMq0H2hrIypn505PDhMs8LErgpgWuMLmKAmyB
         NzpAEgxAhoSHTeqVEIQsjY2s8kUgmL/avmYyg/HtWFJuJsruUiEvqw7QvPrFuKgHl9Me
         Evq0lv9WdzVYeC1e22IZuXwIYojS4G++I1GQ+NvxTdGX165R3fgyhjdVPGlMf7pz0PSr
         mo0CLMvFdyDn4PSf0plcrGWf3LzCJ47uyTrM2mqEigiKAqj+duvCXeKeTEWcUqy4ueDP
         oaxTrlp9x8FQS5ZnnBI5+1jxdDvHDAwuz3m0oR3Er7bdtYiNkz/g/5i+wQeOIYx2Au4n
         DUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429536; x=1796034336;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=THgzxQz2Mg88/jMiZP/HsQu33/8nC9mZNRYAzZhoth4=;
        b=AIq4FIOrd2Lrb834uidYwjrcIvkTo3kR6YujQ1rWRG6Rnueal7ieGecA2EF/vBoj5d
         jl5A8H5e0j3MZTgKMwuZFj9GhcX7Q74SQUl6iPNlIkmygGAdPOrKnPo0Ea+RzATtZRQ3
         CNuj7d+l1dTAttd9brA/n7RJ/uCiKpq2Nu3jXSAtABOxCRBzNGU0UZ+yWbj6OUJ9U8ml
         IxRKQOiLgZBFP2hCr5RsgBuNKjD5C2XZFdAF1y4vZAe2XwfwAfGnUdX7ZB4J9MaI+SaU
         Nhn75HUPh9i3u/WXG5HqOqkWS6D6x6ImhLs/coofkjUI+7aePzkvDTIzH3GBUSQ2IVlt
         MyLQ==
X-Forwarded-Encrypted: i=1; AL+hErEYp/qvtxVI1r/Wjr1HMnMvTSPW0YHb5R/hc0FzjURqe/aVCuTQw2VzczdMtDsfx5fBmn/uLErPwA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8MNFgckVhDGIRLjtJLOV1DNkUyZexffDBTIJ1BDQsfZSF+jw7f
	Ziw5vprIgign/HtyBdZH3BKkN6NAkyr3yRiS0J+u4iDqq+XMvUIOjH+T23Cq4htBVvT0ma1TxkR
	D5ZhsAF2Whbw2+i9w+GuK2x0hf0x5eFLOmOQLg7C3gVFreTvbbwq2wakH3B9zAg==
X-Gm-Gg: AZFdTZdLYY6PAKK1pCdRWim/5TOVYdm/Ca7pekO1TmdCyEPFJoNVtVqT30zOT6SHUuW
	66dwGm+iJ1cyaTwV9rk/935iT0eaUU150x9pEsC2paZu0RSN9uHTuJRbdhPtOu/tm2HnGhodERg
	dk+zy1ecq5ErILkaI8M3eXyLvoqaU8Ua/L2uPYZ9VmbsmiHtsu56xPPRX2qIz5GtT8dlC4J0nLX
	v6XqyeSGhDJyQH6OztWhSlwQfTUKjiX3rkCJJUCIwFxmQK4LNzyHJnhF19WbI/RcIqEZyKpXIUp
	kBEB1a/sl9XpSr6Ipy2I7HodYjepLknR1cOpCkNZk4MdWmTipGqfVmHBjCLljSPBRpUoJ1irL6O
	duDFqPzxv7BAEo2D4+75z9FVmOUqwFGaA4HyOn/ji6gUDRTOzq6mJsdoL7w8Xxe34UVqDF7e2R2
	uNg10fLu5jkw8rEHPS1shhmXOWuFOz601qLQzmkrwvc8bzcETCu3fUra79ofFHKz2w0SBRTCYPY
	M+r5lbsKX6A1dCvrUr5/4XRm90g
X-Received: by 2002:a05:620a:600e:b0:949:569a:a3ed with SMTP id af79cd13be357-949ba7e422amr1784648885a.1.1795429536238;
        Mon, 23 Nov 2026 02:25:36 -0800 (PST)
X-Received: by 2002:a05:620a:600e:b0:949:569a:a3ed with SMTP id af79cd13be357-949ba7e422amr1784645985a.1.1795429535690;
        Mon, 23 Nov 2026 02:25:35 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:34 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v8 0/8] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Mon, 23 Nov 2026 11:25:31 +0100
Message-Id: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJsUBGsC/3XQS27DIBAG4KtErEvEc7C76j2qLjAMDVIcN5C4j
 8h3L06l2pLDBukfab5h5kYypoiZPO9uJOEYcxxOJTRPO+IO9vSONPqSiWACmBaM9sPpx9LPmPC
 IOVMEhyYwLoNsSGn6SBji1x18ffvLCc/X4l6W4iHmy5C+70NHPler/sgpo22AVgnJGWj5MuS8P
 1/t0Q19vy8PmcVRLIphYqOIophOAwoLFryqKHKl8O1fZFEUCC11Y2yAmqLWCmwUNW/UMYEQtGq
 9qSh6pTy4iy4KtOjAKKmVdBUFFqVlaqNAUXzjNFOikxh8RTH/CmdMbxRTFF3OigZAeNc9UKZp+
 gV+QWT2bAIAAA==
X-Change-ID: 20260520-monza-wireless-e6ce7f013f38
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Jesse Casco <jesse.casco@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: D5-MmGdY5r8eYAUArXz8RxIAt25YcEyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfXwQANouAemNJD
 Cvg3RPLqGeY5D+TBxXqS8MM6hgwzNt0+HX3b1aGVwRy4Kc5HoCKPPkAYy9pmPiYP5+UdT5kfBbM
 KS8cO/hnBTQ9tA+UHwF/altGvf0MDh1/BO7wRSPSpz0Y0cwmOk/Ig8j1Eg/1DJFul+EUjjcUMN3
 vzbbk7nM0cEyB8MWd9wFf1aBAAwP1DyxH6n06HTB9fBZtPpEcyIWuWXxqZ5/EApWk0kn1X0p6dY
 zMdWwWEqwB7nC2SdKanEh+zAgLKHoIXP48sGOuKNKI2e8v+dtsixSiNi5TsECrZ77vHljUfx829
 nXF3i8LMbpseWRi+na92hbXArNHuzNT0ilfNge8APrjFCTURd0graXbRCDiyQrY4XGfRKEjHz5D
 7Ua1NNVdmtI597PfRh0S6LdTPxF6F+E2Ox8L4+FH00K/Arq/Bog/3pkbBfYVQSkgJPyNNmHMALa
 ugUwxAE340J6F8+AVOw==
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6b0414a1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RV2icpplJW3WxIIO30IA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX3VG1lGg5I0Pm
 bObPC+2a0q70LBvRCO6RPEP9RWWUvrHeyJtNCRLGRyOOuY5l05JxfcGcpFXboU0GMq6tpgQeJ6f
 DGUguMqZOsYwkPiZn5GbHoDvsjPJGcg=
X-Proofpoint-GUID: D5-MmGdY5r8eYAUArXz8RxIAt25YcEyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

This series describes support for the onboard WiFi/Bluetooth module
present on the Arduino VENTUNO Q (monaco) platform.

The board provides LGA pads for a wireless module. On the VENTUNO Q
these pads are populated with an NFA725B module featuring the
QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
the design is functionally compatible with the M.2 Key E.

The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
signals, as defined by the M.2 specification and handled here via
the pcie-m2 power sequencer.

This series models the hardware using the existing pwrseq framework
and connector bindings, allowing coordinated PCIe and UART bring-up.

The hci_qca patches depend on pwrseq_is_controllable(), which is currently
only in linux-next through the pwrseq tree and not yet in bluetooth-next.
Hence the next-20261030 base, and hence the BlueZ CI build failure on v7.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v8:
- hci_qca: identify an M.2 attached Bluetooth device by resolving the OF
  graph remote endpoint instead of only checking of_graph_is_present(). A
  UART node that carries an unconnected 'port' anchor (such as uart14 in
  hamoa.dtsi) was taken for an M.2 connector, so the Bluetooth probe
  deferred forever on those boards (reported by Val Packett).
- hci_qca: bind the M.2 pwrseq lifetime to the serdev consumer device in the
  patch that first acquires the descriptor, rather than acquiring it with
  devm_pwrseq_get() on the UART controller and correcting that only in the
  later QCA2066 patch. The intermediate commits leaked a descriptor per
  probe/remove cycle and left a stale pointer if the controller went away
  first.
- hci_qca: use pwrseq_enable() rather than the pre-rename pwrseq_power_on();
  patches 4 and 6 did not build on their own.
- hci_qca: check the pwrseq_enable() return value in qca_power_on() and in
  the always-on path of qca_serdev_probe(), instead of registering the HCI
  device with the controller left unpowered.
- hci_qca: stop dereferencing 'bt_power' unconditionally in patch 4. It is
  still a pointer at that point, and it is NULL for the SoC types handled
  by the default branch of the allocation switch, such as QCA_ROME.
- hci_qca: fix the continuation line alignment reported by checkpatch
  --strict in the struct qca_power flattening patch.
- Shorten the subject of patch 4, it was over the 72 character limit.
- Pick up the Tested-by and Reviewed-by tags from Jesse, Mani and Bartosz.
- Link to v7: https://lore.kernel.org/r/20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com

Changes in v7:
- Rebased on linux-next (pwrseq changes dropped)
- Link to v6: https://lore.kernel.org/r/20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com

Changes in v6:
- Rebase onto v7.3-rc1: drop the now-upstream "power: sequencing: pcie-m2:
  Add QCA2066 (QCNFA765) BT serdev ID" patch and adapt to the
  pwrseq_power_on()/pwrseq_power_off() -> pwrseq_enable()/pwrseq_disable()
  rename that landed in this merge window.
- hci_qca: fully drop struct qca_power and move its fields directly into
  struct qca_serdev, removing the bt_power indirection (Dmitry).
- Pick up Reviewed-by/Acked-by tags from Mani, Bartosz and Dmitry on the
  pwrseq_is_controllable() API, the pcie-m2/qcom-wcn controllability
  reporting, the bt_en_available rework and the M.2 connector support
  patches.
- Drop the pwrseq-m2-bt prerequisite series link, it is now merged upstream
  and included in the v7.3-rc1 base.
- Link to v5: https://lore.kernel.org/r/20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com

Changes in v5:
- hci_qca: comment why the M.2 'uart' pwrseq lifetime is bound to the serdev
  consumer device instead of using devm_pwrseq_get() on the controller (Bartosz).
- hci_qca: note that dropping the always-on pwrseq handle is not a leak since
  the descriptor is still released by devres (Bartosz).
- Link to v4: https://lore.kernel.org/r/20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com

Changes in v4:
- pwrseq: rename pwrseq_power_is_controllable() to pwrseq_is_controllable() (Bartosz).
- pwrseq: move the is_controllable() callback from the unit to the target (Bartosz).
- pwrseq: add might_sleep() and guard pwrseq_is_controllable() against
  concurrent provider removal with rw_lock, matching pwrseq_power_on/off() (Bartosz).
- pwrseq: clarify the pwrseq_is_controllable() doc (Bartosz)
- hci_qca: lifetime follows the Bluetooth device rather than the UART controller (ChenYu).
- dt-bindings: also add the "qcom,pcie-m2-1620-lga-connector" compatible (Mani).
- arm64: dts: monaco-arduino-monza: rename the 'pcie_bridge_ep' endpoint to 'pcie_ep' (Mani).
- pwrseq: reword commmit message (Mani)
- Link to v3: https://lore.kernel.org/r/20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com

Changes in v3:
- Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
- Add generic pwrseq_is_controllable() API + per-target .is_controllable()
  callback; use it in hci_qca instead of peeking at the W_DISABLE2# property.
- Implement .is_controllable() in the pcie-m2 and qcom-wcn providers.
- Treat non-controllable BT power as always-on.
- Integrate the pending Bluetooth pwrseq patches from Mani.
- Link to v2: https://lore.kernel.org/r/20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com

Changes in v2:
- hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, called
  outside the SoC switch; drop duplicated of_graph logic and redundant
  bt_power NULL checks (Dmitry/Mani)
- dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
  pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
- Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com

---
Loic Poulain (6):
      Bluetooth: hci_qca: Set 'bt_en_available' from pwrseq controllability
      Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      Bluetooth: hci_qca: Flatten struct qca_power into struct qca_serdev
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

Manivannan Sadhasivam (2):
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

 .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 +++++++-
 drivers/bluetooth/hci_qca.c                        | 179 +++++++++++++--------
 3 files changed, 175 insertions(+), 76 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260520-monza-wireless-e6ce7f013f38

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

