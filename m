Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259041;
	b=tY8pxPVXQaXEl43fhs6HMEd/7bh2e5flIUrVyqxRTRrhPPc4xrFExdNdqzAF15o/gfKb
	 lNBCmLRkggUdAVMB7K1ZmNV2oZ45vi98d/OXHD8mMhAC8ALEP3rYmFUUcxILkJlB5GbIO
	 D9emYruaqrfPHAWf6Z8Q9IiFe9Ruzsljf3Mqd61eQmdVNln8+VoXb2xlPLE4QgBglphgK
	 FVxE5wSoJPFfJesZl7Fhcd/f5hPXecvSAkKBANXNU7UqeEv3Vmrv5j5m7GM45TKiyLvsL
	 xENckfZ9VtvKIhthctWnz+/5DgYmviEhAhnG/zacJw7wicIstrmfMpZH0wtn7IiRgSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259041;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nsiAxT8KKUIacP7cLxTvtwoJBZfMQ+Oronl3f0pzRwM=;
	b=UOid7CiKtgrUwpb72HI1zIS6FSQGUp28PsCTIntkAxp3DF/2iSklPjXcFRScBbyPpXQe
	 uoAp/zb8sFMMcVF48maWHDWH9UF4tTuNF3ThNX93N3RsevJ6qfHaaSnR3lvLZIeNL4DTg
	 ZvWUwH7NLlZZH+6T79bGrUnOhC4fCP3i+G8VgigoanfyP8x2oNzRzyHntQQpEUhllOabO
	 OcF1ndrE/SWG4qkNQC63u371hW+tvg1XNdjB9JLnz8V85rvILlUqv0/EsSle0F4DB++q6
	 0KrndrasSFGSkk6rWpuG6QCheAc58dpnh6raCwosIiGFVFYYVM9TAYUKwL3+AgJEw0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=imuczH1O;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=OoVrB8CC;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B157606A31C;
	Thu, 29 Oct 2026 07:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B157606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=imuczH1O;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=OoVrB8CC
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T71Psb808314;
	Thu, 29 Oct 2026 03:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=nsiAxT8KKUIacP7c
	LxTvtwoJBZfMQ+Oronl3f0pzRwM=; b=imuczH1Oo0sXrM1+lq2+L49K8VJETae5
	IDwvnl3nOZ+g4mMNg5SwTxF7tMUSnzQnJPaaqrdyumDehuLWghTNfGJS9LgOQjIS
	9EB708nnCgXGg54QSB9TTtJBFiPEG/rdkNRFU9dDNgXCmTv7BgRCTRQk/grDFxZl
	n+/9rk9MDoBSJ04E0U/RTWK1cnvK4Ji6C1DfAdrf2Zk9obZmZ2ygTXPLH2zBKZE1
	NNNL4kC/ApcmLjaX9u1nrEN96d8h5Os44275Sa+t9N+QvhRBaEvlmhsVvd5epZ77
	3Qdb0HzrhKwtLwl7ZY4qh/ziHWYhRuyKvaYXShAgtDP9/yvyF+k+cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=nsiAxT8KKUIacP7cLxTvtwoJBZf
	MQ+Oronl3f0pzRwM=; b=OoVrB8CCLlrA/LnCPBj58foT2aPfAffUSyzAh0XpcBv
	vd2sdL5q42k8mkg8CkEDCdNg3IOK96ZHP8rphEB1PekM/plEmJJhh7UkFOn1kxqK
	376xLBjAL3MoSh1sMzheIxXGHdzT7Ad3X1V0QynvjVqE5RhubVBMPbnm3ZXZkKb5
	QPAl72ZqmKIzbYSkxTMtTrBUWVBo72mYDezuaU1qat3aVRjTiFLXkDpUCvagW+Ud
	IbhctLvFhkodQZYQMrkfvDZCL3VzcTows1vT1BIPboZRNENaZ6KfAsNsIMGSFoJ9
	YQAjuSE0NADgaGC590M7IfDrNWN3xvSryYLEJj7YLcQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hm1d0g538-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 03:30:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69T7UUMm044468
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Oct 2026 03:30:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Oct 2026 03:30:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Oct 2026 03:30:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Oct 2026 03:30:30 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69T7UKMI010624;
	Thu, 29 Oct 2026 03:30:23 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <sre@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add LT8491 driver
Date: Thu, 29 Oct 2026 15:30:10 +0800
Message-ID: <20261029073012.1498-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Rs_wFsvi8CJkgRx7hb7yg5Oaafkc435x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX+1Gw7917DjTv
 bYLLgTSW/wMcEx8hMtru++Z6Ka0ee/TKtBo92fU9nN+GbSWpvV52VC7P8tQEMbuXc+QOIyzIrjA
 8UnHRoVNwFEf+Z1KsMXHOmnpKYhOj60prYnyZIieAyrZTGdV23UY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX1xDO42vgHE0C
 t2S1lXJbW5T0sEvOQ59nOjR2PCOq25LcovluNi1SeCKFm7crYN1F6Qmq4fkdfryfTO6CFadwrSp
 CqWqwnRRd6+fjVApqM+AGUhWcabn+zIeAa9NcybV7Q2k4LW/VeDc7YMBXAgzQLhThkibqPGDaDd
 CUn3XaEHwtvnHoRZ/tABQ74HYFUO0s223iy1dukVkDwNYVwNbDsSegz7olfL53p9z59gSv4CJc5
 mBbWgZGjYX5XYrI5lgKmVrBOjHpr01FgQSTLGMvojZcjmum0THZ/hv77E8VoaFDQVMeyKJlgRIf
 NPgCmMBZULmWCCEuL4bbYr6W9uEipvGCf22J/iF1FzuB8yH2kv+qR7XyEx9qwi5XldOcyvZrjtF
 MZaG2mdHK4jUF/dGJOZp7HeEiFgjADZ9h+Ywmf4AkNIQyHYup49Eu2hBoQgi/I4NZtT98ObeEHI
 PXgnHZAsSUlOTYA+sgg==
X-Authority-Analysis: v=2.4 cv=M7XYuCws c=1 sm=1 tr=0 ts=6ae2f617 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=n22vjvBVvcT7OZeQm1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Rs_wFsvi8CJkgRx7hb7yg5Oaafkc435x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290028

The LT8491 is a buck-boost switching regulator battery charger that
implements a constant-current constant-voltage (CCCV) charging profile.

Changes since v2:
https://lore.kernel.org/all/cover.1788432152.git.johnerasmusmari.geronimo@analog.com/
 - dt-bindings: use unevaluatedProperties: false instead of
   additionalProperties: false (Conor Dooley, sashiko-bot).
 - driver: drop the <linux/mod_devicetable.h> include and use a named
   initializer for the i2c_device_id table (Uwe Kleine-König).
 - driver: use an int for ret in lt8491_get_property() so readings
   >= 0x8000 are not treated as errors (sashiko-bot).
 - driver: register the power supply with
   devm_power_supply_register() (sashiko-bot).
 - driver: poll the telemetry-active bit after triggering a telemetry
   update (sashiko-bot).
 - driver: bounds-check the temperature limits and the resistor
   configuration values before truncating them into registers
   (sashiko-bot).
 - driver: write the 16-bit resistor configuration registers as two
   byte writes, as the device has no word-write transaction.
 - driver: report current_now in microamps.
 - driver: return -ENODATA for the temperature when the chip reports
   the not-measured-yet (0x7FFF) or thermistor-disconnected (0x7777)
   values.
 - driver: minor cleanups.

Tested on a DC2703A-A-KIT evaluation board with a Raspberry Pi 4B
(6.12-based vendor kernel) with no battery connected; charging was not
tested, nor were the two special temperature values above. Build-tested
against the power-supply for-next tree.

John Erasmus Mari Geronimo (2):
  dt-bindings: power: supply: add adi,lt8491.yaml
  power: supply: add LT8491 battery charger driver

 .../bindings/power/supply/adi,lt8491.yaml     |  92 ++++
 MAINTAINERS                                   |   7 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/lt8491_charger.c         | 428 ++++++++++++++++++
 5 files changed, 537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
 create mode 100644 drivers/power/supply/lt8491_charger.c


base-commit: f0f400459bf6a037e70768de623fff3f8920b8bb
-- 
2.34.1

