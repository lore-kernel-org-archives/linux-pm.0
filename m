Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E10371CEE
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081516; cv=none; b=J/8nBDbc+LBh1qgXhYK6Hekvk954l0haMh+O+AgEd8VKOPLKitnfQgNTMn45Yv0W/E7I7CJ7b/jKp8HMZnyuWotnkT1eI2iKQmEpDhJLSa/XDUrTV5j5gt9EAotzIQMDhRltCjl0135qkS2p1YTywuMmisXjDlLBr0g26XPdsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081516; c=relaxed/simple;
	bh=li+NbwI6HgC/D5Vcy46y0xJkab8zM/VOUj6ekoSZb7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WenWLL4Z96QfdZF4GXzcJmRHNNaLFEO7K7Z0LAupiZaRiMYaLdpqloDur8umFI2P2+O14No1/UyC4gxDP4dhAi4XmcX/kkr3qhyVSEwTx3fZ5SCyUJ+dlyW6Nyf6rgPTHroUWsfqcK0evTWnArEIdM82y3pcIsu28DxLZuz4m1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0Y/QksB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fAmuy5OZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0Y/QksB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fAmuy5OZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7iFNU567768
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XyT0TY4z2OZOw5ThFSYxvj
	jXVzi8sDq5C1yLXvz+KdM=; b=f0Y/QksBH2hP1H2AHM6S4WUilquMQajIhCfmU3
	GYmRDN9PJRF7sxiOt2Z//uj3oyPVlQ2UGNU9tZHLiAlDobpCZt+loxGvdfZEwPEu
	FnwYnApNVbnB7ucpFHSaPVl9a1/S7GHycf03ecnmdPtHWX1Eg59zxExG+kIfRgFn
	C+Szcd4aG0JrPKrvHbEqG4UImJdKhqO74pVDD3oO5Fldw0I9CfqvuID4vWdFk0uX
	io7SVf5/ZTdYNS/7s4LOwz6w2lB9+PqBS4H3R9shhmbDoOwgXNrvsQ40RZrd7QUy
	m8JmA+2RrA/KddD4F5ccJ7pdkFoSPPODnBvxqNoQAjl+seKA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jwtnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:51:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso67314285ad.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781081513; x=1781686313; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyT0TY4z2OZOw5ThFSYxvjjXVzi8sDq5C1yLXvz+KdM=;
        b=fAmuy5OZF5pB8LSkB/NbU3aRGgWfQirxomOGkloJ6U5E7POAkGEHvxhxsHNxQS5yhU
         Nq1byq3Hwfs4SlIDNC/z8z5dkSDMaFkwWiE+X7SX8k8CU7XIl2pFOXcHZ5ru9uU28Xf9
         cxIhadXtpDUZ+td5d3RWBKSae2Jepq3hwIdFENdAVOnpaPKRK1q20mVAtAkDAQn1rDuD
         ihjYnehupzO4lmv+C91o4a7oSKYf+Z/r0AzKAuQsgQ4bFsJMD74e9G5zyNh3XruodAXi
         I+FOCzcZE+GgyodudlE7ufPKHxKsIGDe9NOSzJXmTyTzh5lDwGf7oUZj6nY1pFqOKUag
         MIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081513; x=1781686313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyT0TY4z2OZOw5ThFSYxvjjXVzi8sDq5C1yLXvz+KdM=;
        b=qoGvcykdhl2sRi9/vux2xhUjnlQrAklqne9kCaSp3VOKkqs8rDeOP3iH1jJmV5KDTk
         maS3zSJh9BQLU0JLPK7OYfvm1TxixFERyZJQMG19tC/yBao6jqgnjrNfIHWOkx1P0gy3
         dQNROzSEpkvcF1TCf5ibwcOJWUCYCs8g6h2iCjXZYmV4deLPKQW29TCuunl4mLyhQGBb
         2TyRPdHa+FJdSoaH3K0dcip+GhiE5EP1oF0KQAfHZg08NDVB8Qcs1eZdupdHyzQb7fKf
         JVisVUgLCIuXUOxJwIJtACd4d2xLdqbhSeK6+hVyFELF65S0Txqj7Sq3KVi9qAmcJemc
         /WVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QqV/T2ii7fTTaLzl46k8Yqc1C38uhlTbOYUnvYAs6T46Gh9l6X3JVKliFwkslCUXaf58DYRmbUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeie3s3GFYyMGnvzSEyaIVoUiGeA8hi4lQusrj9NVcrSuUYGbP
	JITfu8AC9I368Zj0jMSVduSfzsn+O6ZBRi2WbOhqPUmLDJXWwgcC+jhjaBfK2LvjlxlqEDSNPqM
	nNa33w974yyUaGm13IK8J0io1X9MkDVscWBzbIUUPpFOgWusStZHLjkoIopMDqg==
X-Gm-Gg: Acq92OEPT4+L3mh5T0i8TBeuMTJ+Ppfm58JVAEbPLvu5Pe0Q/+0+ZUkXrY90+lNPhmo
	HPyBZjZWIND2ROw9EUHQjWI9plZ/hvs//xsI62ujDqPqSeTI95uwUmUdxWr5PmSdrS99mrm8kqp
	SCQkXsQO+KYoWr3ElYwA7dNSKWszJsr2eduTpXFFoUJ2ZvUZEF7VclxW8pLlYzOeiPTXPIO2PNZ
	h1hf3LEzRxmMyqoE2rrtf+VBWnEj7lHQ4LHirKY/6pHr+vQJkz8LuCfuM4a6vcoU6mYXC9SS7uB
	NKKwQUudujA/RqNujs8fDjdX6BEg/6WU5brUQat3J8QlzAuQ4IiN8KpwZ1OEazZr+lWF+QATUg4
	KBvuS0oJ5dtcJ+sQzy+MzS/+8SvmcyArcVpi75RFFBMv0fFjOupT5whvtQQ5AohFysRRPzQfqiK
	wv81N1OVRfpXr/0/yKUA2ie84cc9NjQESM5/Bxl1FBSHw69TcfqehblN/fMoE=
X-Received: by 2002:a17:902:c949:b0:2c0:cb90:1e08 with SMTP id d9443c01a7336-2c1e77754d7mr284761995ad.0.1781081513261;
        Wed, 10 Jun 2026 01:51:53 -0700 (PDT)
X-Received: by 2002:a17:902:c949:b0:2c0:cb90:1e08 with SMTP id d9443c01a7336-2c1e77754d7mr284761465ad.0.1781081512683;
        Wed, 10 Jun 2026 01:51:52 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8acasm114618175ad.45.2026.06.10.01.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:51:52 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Subject: [PATCH RFC v7 0/9] firmware: arm_scmi: vendors: Qualcomm Generic
 Vendor Extensions
Date: Wed, 10 Jun 2026 14:21:27 +0530
Message-Id: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAlKWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0MD3aK05Pgy8/ji5NzM+NzU3JzEEl3jFOMUg2QDC0uzFBMloMaCotS
 0zAqwodFKQW7OSrG1tQDvBGyDaQAAAA==
X-Change-ID: 20260610-rfc_v7_scmi_memlat-3d3d0c0896d4
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, Amir Vajid <amir.vajid@oss.qualcomm.com>,
        Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781081505; l=9506;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=li+NbwI6HgC/D5Vcy46y0xJkab8zM/VOUj6ekoSZb7I=;
 b=riygExv8QhFqBmkG2ACzxVz5l6MLkC9mC9CCke/IVm1r0Y8YjBBIaNv/FPfVfmQT6z12IJ72G
 BChJ4HJYUreDfA7xuQIXD4KRK/WD+UKAnnC08EnXEXv8gLmKAuRJ9vR
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-GUID: j1fTZ__016wVWRUW7mdAxu0w8SImnyEe
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a2925aa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=I8QHn4yjjamTqNr_CmAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MyBTYWx0ZWRfX+hqVPVaL15bm
 QCVcBaXQf/RjTzs4WTAL12o7VJ67Jnz7qwg7KYNv4emzOsr95LN9bDxKmSBhtK1uebrQW1m55Ig
 bsnMFwH54wVhb5F4WU0MMuTnZTqnVX4S7AlIEJ7cNGFF7c4qPkjipux9NfWU0qdwKCHk+JzPh1S
 TCs+jRK8UnLYDQO0WDxrZCsKJ0I2XSET8b+dba33+s11O8+uj8dJ3T2splA7DNlrnjgvFlpSOie
 9NadYhmoERTvsp8XLOjR19d3uzrWlvNvbd5BA51eSpCPj8HfvdtB8NhdAJ4aFGa9xTMc1pS3qyX
 S3Dazbgj1xQyuFyjQjp/ugD/laZ868VbIn6g9DW6ciXDkbGYDcv4o8Lul/qNAn6Vb42uUOPH4cm
 A1FXq38DEutT5nmamW97TQol6ofFLpCiiW8Ehs9slNPN8rLQxjn0ggWloVqAXL655+SiAbOKQHu
 PpwKQCOkxb2wtxsBNSA==
X-Proofpoint-ORIG-GUID: j1fTZ__016wVWRUW7mdAxu0w8SImnyEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100083

The QCOM SCMI vendor protocol provides a generic way of exposing a number of
Qualcomm SoC specific features (like memory bus scaling) through a mixture of
pre-determined algorithm strings and param_id pairs hosted on the SCMI
controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
mechanism to control the various caches and RAM is hosted on the CPU Control
Processor (CPUCP) and the method to tweak and start the governor is exposed
through the QCOM SCMI Generic Extension Protocol.

This series introduces the devfreq SCMI client driver that uses the MEMLAT
algorithm string hosted on the QCOM SCMI Generic Extension Protocol to detect
memory latency workloads and control frequency/level of the various memory
buses (DDR/LLCC/DDR_QOS). DDR/LLCC/DDR_QOS are modelled as devfreq devices
using the remote devfreq governor. This provides basic insight into device
operation via trans_stat and lets userspace further tweak the parameters of
the remote governor.

trans_stat data for DDR/LLCC/DDR_QOS is now available with this series:

     From  :   To
   315000000 479000000 545000000 725000000 840000000  959000000 1090000000 1211000000   time(ms)
   315000000:         0         3         6         6         6         7         0        30    143956
   479000000:         2         0         7         1         1         1         0         3       356
   545000000:         7         6         0         5         5         0         0        10      1200
   725000000:         3         0         5         0         6         1         0         6      2172
   840000000:         8         2         3         2         0         4         0        12      1188
   959000000:         3         0         1         2         2         0         0        13       272
  1090000000:         0         0         0         0         0         0         0         0         0
  1211000000:        35         4        11         5        11         8         0         0     21684
Total transition : 253

QCOM SCMI Generic Vendor protocol background:
A lot of the vendor protocol numbers used internally were for
debug/internal development purposes that were either highly SoC-specific
or had to be disabled because some features were fused out during
production. This led to a large number of vendor protocol numbers being
quickly consumed and never released. Using a single generic vendor
protocol with functionality abstracted behind algorithm strings gives us
the flexibility of letting such functionality exist during initial
development/debugging while still being able to expose mature features
(like MEMLAT) once they have stabilised. The param_ids are expected to
act as ABI for algorithm strings like MEMLAT.

Thanks in advance for taking time to review the series.

Changes in v7:
 - Minor bug fixes and documentation improvements based on review feedback.
 - Significantly expand the QCOM Generic Vendor Protocol documentation
   with a dedicated MEMLAT section covering all param_ids, payloads and
   return values [Sudeep, Cristian].
 - Move per-SoC event IDs and hardware type identifiers from the driver
   into the platform configuration header.
 - Poll devfreq at twice the CPUCP sampling rate so every firmware voting
   cycle is reliably observed [Lukasz].
 - Add a devicetree binding schema for the Qualcomm SCMI vendor
   protocol@80 node.
 - Link to v6: https://lore.kernel.org/r/20260507062237.78051-1-sibi.sankar@oss.qualcomm.com

Changes in v6:
 - Combining vendor protocol and the client and moving it
   back into RFC mode.
 - Introduce target_freq attr flag and TRACK_REMOTE devfreq
   governor flag.
 - Add basic remote devfreq governor to give users data like
   transtat [Dmitry]
 - Drop the current design that relies on manual parsing of
   device tree data and move those into SoC specific structs
 - Add Glymur/Mahua/Hamoa/Purwa support in the same series.
 - Link to v5: https://lore.kernel.org/lkml/20241115011515.1313447-1-quic_sibis@quicinc.com/

 Changes in v5:
 - Splitting the series into vendor protocol and memlat client.
 - Also the move the memlat client implementation back to RFC
   due to multiple opens.
 - Use common xfer helper to avoid code duplication [Dmitry]
 - Update enum documentation without duplicate enum info [Dmitry]
 - Update the protol attributes doc with more information. [Cristian]
 - Link to v4: https://lore.kernel.org/lkml/20241007061023.1978380-1-quic_sibis@quicinc.com/

Changes in v4:
 - Restructure the bindings to mimic IMX [Christian]
 - Add documentation for the qcom generic vendor protocol [Christian/Sudeep]
 - Pick up Rb tag and fixup/re-order elements of the vendor ops [Christian]
 - Follow naming convention and folder structure used by IMX
 - Add missing enum in the vendor protocol and fix documentation [Konrad]
 - Add missing enum in the scmi memlat driver and fix documentation [Konrad]
 - Add checks for max memory and monitor [Shivnandan]
 - Fix typo from START_TIMER -> STOP_TIMER [Shivnandan]
 - Make populate_physical_mask func to void [Shivnandan]
 - Remove unecessary zero set [Shivnandan]
 - Use __free(device node) in init_cpufreq-memfreqmap [Christian/Konrad]
 - Use sdev->dev.of_node directly [Christian]
 - use return dev_err_probe in multiple places [Christian]
 - Link to v3: https://lore.kernel.org/lkml/20240702191440.2161623-1-quic_sibis@quicinc.com/

Changes in v3:
 - Drop container dvfs memlat container node. [Rob]
 - Move scmi-memlat.yaml to protocol level given that a lot of vendors might end up
 - using the same protocol number. [Rob]
 - Replace qcom,cpulist with the standard "cpus" property. [Rob]
 - Fix up compute-type/ipm-ceil required. [Rob]
 - Make driver changes to the accommodate bindings changes. [Rob]
 - Minor fixups in subjects/coverletter.
 - Minor style fixes in dts.
 - Link to v2: https://lore.kernel.org/lkml/20240612183031.219906-1-quic_sibis@quicinc.com/

Changes in v2:
 - Add missing bindings for the protocol. [Konrad/Dmitry]
 - Use alternate bindings. [Dmitry/Konrad]
 - Rebase on top of Cristian's "SCMI multiple vendor protocol support" series. [Cristian]
 - Add more documentation wherever possible. [Sudeep]
 - Replace pr_err/info with it's dev equivalents.
 - Mixed tabs and initialization cleanups in the memlat driver. [Konrad]
 - Commit message update for the memlat driver. [Dmitry]
 - Cleanups/Fixes suggested for the client driver. [Dmitry/Konrad/Cristian]
 - Use opp-tables instead of memfreq-tbl. [Dmitry/Konrad]
 - Detect physical cpu to deal with variants with reduced cpu count.
 - Add support for DDR_QOS mem_type.
 - Link to v1: https://lore.kernel.org/lkml/20240117173458.2312669-1-quic_sibis@quicinc.com/

Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
Pragnesh Papaniya (1):
      dt-bindings: firmware: arm,scmi: Add Qualcomm Generic Extension Protocol

Sibi Sankar (8):
      firmware: arm_scmi: Add QCOM Generic Vendor Protocol documentation
      firmware: arm_scmi: vendors: Add QCOM SCMI Generic Extensions
      PM / devfreq: Add new target_freq attribute flag for governors
      PM / devfreq: Add new track_remote flag for governors
      PM / devfreq: Add a governor for tracking remote device frequencies
      PM / devfreq: Introduce the QCOM SCMI Memlat devfreq driver
      arm64: dts: qcom: glymur: Enable LLCC/DDR/DDR_QOS DVFS
      arm64: dts: qcom: hamoa: Enable LLCC/DDR/DDR_QOS DVFS

 Documentation/ABI/testing/sysfs-class-devfreq      |   8 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |   1 +
 .../bindings/firmware/qcom,generic-scmi.yaml       |  27 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  41 ++
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |   4 +
 drivers/devfreq/Kconfig                            |  21 +
 drivers/devfreq/Makefile                           |   2 +
 drivers/devfreq/devfreq.c                          |  27 +
 drivers/devfreq/governor_passive.c                 |   1 +
 drivers/devfreq/governor_performance.c             |   1 +
 drivers/devfreq/governor_powersave.c               |   1 +
 drivers/devfreq/governor_remote.c                  |  73 +++
 drivers/devfreq/governor_simpleondemand.c          |   1 +
 drivers/devfreq/governor_userspace.c               |   1 +
 drivers/devfreq/hisi_uncore_freq.c                 |   1 +
 drivers/devfreq/scmi-qcom-memlat-cfg.h             | 573 ++++++++++++++++++
 drivers/devfreq/scmi-qcom-memlat-devfreq.c         | 616 ++++++++++++++++++++
 drivers/devfreq/tegra30-devfreq.c                  |   3 +-
 drivers/firmware/arm_scmi/Kconfig                  |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/vendors/qcom/Kconfig     |  15 +
 drivers/firmware/arm_scmi/vendors/qcom/Makefile    |   2 +
 .../arm_scmi/vendors/qcom/qcom-generic-ext.c       | 153 +++++
 .../arm_scmi/vendors/qcom/qcom_generic.rst         | 647 +++++++++++++++++++++
 include/linux/devfreq-governor.h                   |   8 +
 include/linux/devfreq.h                            |   1 +
 include/linux/scmi_qcom_protocol.h                 |  37 ++
 27 files changed, 2266 insertions(+), 1 deletion(-)
---
base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
change-id: 20260610-rfc_v7_scmi_memlat-3d3d0c0896d4

Best regards,
-- 
Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>

