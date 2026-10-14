Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FF4A8A08
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980363; cv=none; b=ClIs44Tk9OcaL95pHZ8Ysrb9yelAgQY82QxV86t/UpkleIe51vk7Kph6H2Rj7rVJD9u6nC9fzD8YshEraO9C+27O9srA4l6t2N55f5i4CG3ZDE+qpRBIsJqykmrGGobhQfR68EwZQ62YTOHTasdCcGeqTq5uHWQBfI/kjwJNY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980363; c=relaxed/simple;
	bh=qhS8MNkDQHRfqbTNQhDUBpErJ9biaMj+d95Ij1s7z7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahKuEH54/GukS7Lrv9ZI/SuBmIfQ/QgsTCALQ9mgtwYBu7ojfSQV9ynU8fSXGi+0fva4NFMlCPiONndHE9m0QtiyQRzcNE3IDZDo+xuLbUaeLaa79NFaD4mVp/vf9utR8Sws7aeUZZ/bWBAXe6EmqLxfkK2X9IEy8eg2+t5U+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PUjq6TUi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gx4yXjba; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PUjq6TUi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gx4yXjba"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9hhKR2222381
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Jq90LBuDnLYVMzo9xa4WUu53RzmLM94/Z9r
	DW7XH1P8=; b=PUjq6TUi6UYp1s7mZcV6KoqAy/UJilYnmKEM2RNGg6SZOkWvXiD
	XT3bgtn3fPYKeSFqMKlj6U4Nk03oo57yx2s3wSIwRMTI8aQJTzFvrJbYjfSEqwOb
	1PfgTaFvbGciEVP0CYN6u5fPjB94lj2xR0rZBMF8KzJ6iareHPsn/wsQRX6rPbOO
	nNTQYbcYs4GpYwG9NqFv3Mgzc7VHG/sJLArXyVMo7QzGuqXPKdsc+zfmADAZpnwg
	PnzK5MqJw7PMIGE3mZlOoifwvr3cs/xidIqGnIpafk7GOT2+M9vnRY8iHDEOr4Hz
	64sYBX8ZdzT5vRAKq28recKC4Wqhiqed7JQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txsbj1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:19:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc764579e50so524706a12.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791980359; x=1792585159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jq90LBuDnLYVMzo9xa4WUu53RzmLM94/Z9rDW7XH1P8=;
        b=Gx4yXjbae4yge0vxt6SKWEjIif5kEU/moLyVGYgo+/dM4t/ZcyPtXk96KXK0EUjOvt
         32xhV+EIq3SsvWSzthqZn6V9qU860t/27IsS45IH3u+MC37stxbwfFUQip70EoXTjIHi
         P4urTxFNHHyMHCDSI4FrB0QlnY1Ix7Ymz6F7u27kFeS8Dc2c9O7drk04JOdcYyPy6+qv
         yzsrXVCVNACdviHYJ7RefHOrHxltgEi2ZfB/FDTcc/mobaxiKx/Dbh54b03UcAcFcFvi
         3w9BIh21HIEIyIAPFz0vo4Pky9PWxJ1GtGb7prtOFNz59WR477twL0ctm8W8ThQKXPzC
         fHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980359; x=1792585159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jq90LBuDnLYVMzo9xa4WUu53RzmLM94/Z9rDW7XH1P8=;
        b=AbZZczteEANP1v7e7HtB8Ns3ZM2RxHoTDp2G9Krjc3srjcWymaNWTxl3YowQxRvO+c
         ByOXoafRrV2q4p5nUkFgy5pRt/qX5l4WPoeuLR6EKPv3seizrVwqBc7B4YPRXhB1qUMe
         KPk18IalH7Z1phIX9l9X0/5TuADq26cYV4q4515QaRI4qed+XSWvsVd9wtGCe4HWlKOh
         da+CwOmLG5M2dKStyV5SJ7XqTZHmnO1WZ5WOwBRBI91UhpL71v1Px29noEfELlYZtmZ/
         2vt0TLw63NGhYySlxXOl4D704Io5zetaIjOxvI9JaOy/9S560qF4exMRBaIX+vOKA4AN
         /d0g==
X-Forwarded-Encrypted: i=1; AKwUvBwkcs3ZXTGACj1GtU1Tz3IrqcmFJCFdaV4J36WTaJvtfXulQloU8CcZJWQBOeivDYxrpdrdg60A/A==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6okSm4kkbWALTLLYjtYSQhNBJMkbWuLqAZQAy4PqWcjg0VZq5
	HekUKR89js4H4zc1lBn+EwC9bJjWkUiThwEu+SRS6rlUF8aBD15LBnFSuS4F/+RoFTSzDIVS8UW
	yaJbIdaZkj94cV6ojjJjeOIcwLZ/CktORXDTMx0QrOTqTFfuLr3UEDMsV+lhIBg==
X-Gm-Gg: AYBFou39s62x75jwKUfD9B1ZZsm4Q7MIn4VCRlnzl2zek9UakeQZQe2fToXn2Em5rZ1
	gcGkEt9BX+S/vStYaLt2HqaT6WlznBl1J58HY2zGSoQIB1vlASW80cqtJyOev1sXRwdUO9UQihB
	N5xmQbwzkZZy0kpaxgANPZ2HpLj3MLdHfLcW3C7oJ2ZlZEiewwb1EXsJkyoYMbRxjhIwzxCg4mk
	ivq3Rukns5MFwsYMsFtyt88JkLlXkHEaQpjOihI8EVIbi/SgxfM52dDQnhBLTfIW3rMc5KeqVSk
	kDGjwWu2Oya0h8M6+lP1N4yXVuzUxLTwMq5OwAZD5Hrtz6unUFSahWOGgHE+pGCfCmSby9IEmkC
	+TxZmdj8xsuL3z1St9Rc7+fj+ZmUg
X-Received: by 2002:a05:6a21:8285:b0:3de:50df:7faa with SMTP id adf61e73a8af0-3e16bd47a3cmr24640040637.1.1791980359372;
        Wed, 14 Oct 2026 05:19:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:8285:b0:3de:50df:7faa with SMTP id adf61e73a8af0-3e16bd47a3cmr24639989637.1.1791980358858;
        Wed, 14 Oct 2026 05:19:18 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804ec645sm1016990b3a.43.2026.10.14.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:19:18 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [RFC PATCH 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
Date: Wed, 14 Oct 2026 20:19:07 +0800
Message-ID: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX7SYSgoJt1kvi
 r3DC09TDSOY8oOQDSt1l1LIxbReFMZUaUuPhQdkUxOlaOxS7hw91IdLI9pVqhKsJ9OS+UMGOFGU
 MbJoML67vtsXwhz3OD2Egm0WoI+IA2KnGhmPZMSgE+2pym82hQcl7xXsHRUl8RVsWkuJpLgIc/f
 Yit3XO84i3N1Ycu0Tilp6TihXerMt34NMKu4zk18XKMF/Cw4ABsaFugUIlD3uQpCMV6a/b2vuX/
 FL9r4pFE057ZnQLuRUoRsR4cEY99EHFnOPcERYl9AM6P6/8+iAmBRJjwIVf73VmOFTlHnR61HiL
 8eqjgIoosTxGlRD2ImWsAf3X4DemvGphXSC7CUCdNRZ6Nxx0ITeOnN7/o8SNzjoEJX9UvFbkLpQ
 dv49tIWJMnmtD+UHSIvv5QvE1CuTwWD8rnFOSgfT8VUwWH2cjrSOpXBi5Q5p8jj8q9L9rm6ASVE
 KEva92s2fdsr7t8df5g==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6acf7348 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=LbSbASDYXwb1C5uybScA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX7noiCriGYqlv
 YCdHxoIWaRDwmV0UWmfi7bSuM9lB6y6rvakALQt6a1uP4sDpnFPU9SDUJy8bfuZH7z79KJfOaOm
 bB9nZ3p77VTkJOnN3EqxdKaOBhqXYjk=
X-Proofpoint-ORIG-GUID: v4DrJ3uPX9a-uLMmlBVD9OMqABM7IUdi
X-Proofpoint-GUID: v4DrJ3uPX9a-uLMmlBVD9OMqABM7IUdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140048

Some WCN3990-family designs connect the SW_CTRL output to a GPIO on the
application processor. On Shikra, the WCN3988 SW_CTRL signal is connected
to GPIO88 and is used through the MGPI/AOSS hardware path to request the
required RF clocks.

Qualcomm downstream kernels configure this path through
msm_gpio_mpm_wake_set(), but upstream does not provide an equivalent API.
This series models SW_CTRL as a dedicated wake IRQ. Requesting the GPIO IRQ
resource enables POWER_SAVE_WAKEUP_ENABLE in Qualcomm TLMM when
WAKEUP_PRESENT is advertised, while the PM core keeps the IRQ disabled
during normal operation and arms it for system suspend.

This is an RFC because the intended hardware and software model still
needs confirmation. In particular, please advise whether SW_CTRL should
be represented as an AP wake source using dev_pm_set_dedicated_wake_irq(),
or whether Linux only needs an interface to explicitly configure the
TLMM/MGPI power-save path.

The series documents the named wakeup interrupt for the WCN PMU binding,
implements dedicated wake IRQ handling in the Qualcomm WCN power
sequencer, and enables it on the Shikra CQM, CQS and IQS EVKs. On this
base, CQM and CQS share shikra-cqm-som.dtsi, while IQS uses
shikra-iqs-som.dtsi.

Testing:
- scripts/checkpatch.pl --strict: passed
- dt-binding-check: passed
- dtb-check: passed
- sparse-check: passed
- Shikra CQM, CQS and IQS DTB builds: passed
- QIPL validation of the equivalent qcom-6.18.y implementation: passed

An earlier experiment confirmed that requesting GPIO88 as an IRQ changes
TLMM_GPIO_INTR_CFG88 from 0x942 to 0x9c2, setting
POWER_SAVE_WAKEUP_ENABLE.

Linghui Wu (3):
  dt-bindings: power: sequencing: qcom-wcn: document wakeup-source
  power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
  arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup

 .../bindings/regulator/qcom,wcn3990-pmu.yaml  | 22 ++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi  |  4 +++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi  |  4 +++
 drivers/power/sequencing/pwrseq-qcom-wcn.c    | 30 +++++++++++++++++++
 4 files changed, 60 insertions(+)


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.0
