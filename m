Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F527F18B
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311689; cv=none; b=ufWKCAFaMNn2SzlV+Ky63pJ9bV+9J0+z08K+qF4gdOLuCmDVUEFtAaD0q/9NFGhfooUB1IX4lMIXjosdBHqIJdhhaENFe8MANvBM8YRlRvvBchIuRPzp56SCneAsMxTeh8GW1V8bcRbIzzQ1HZeEiRpCXqE5QG9Cb5nVWVKfhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311689; c=relaxed/simple;
	bh=zPhGhaxgIP/ykoIc8bmxAEn7Z2Y6uZJLeMVj4YnpUL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KdCYYtrURElq2lpEDnWV4yQskAMj3WeD1RYWWRVeV/CUru/FoBm6s0MNhZgOa9gnih+UgleD3qzSNPhn0KzlcLy8fyLVpuwehBJNbHlGn5Qu7lTJWCgeEBWERqPIKpWBgIzNQBfzl2Ft8ax2VTR5hE3iysnDRur/94utiTWXz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4RkX+J+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jr6pql9g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4RkX+J+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jr6pql9g"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6519Y1ge3372598
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 11:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+pNvkCmcFOTvEpSG5W0JyF
	mCsUk5a9WiJCwuvo1GWUs=; b=Z4RkX+J+5lYBRyqJiJOWN1BnLaapkIWT3mhmo3
	JCDsnYQ7Pg9H2CfvhmtV8e/tC/d4mBCOfc+UhZEQjfeI9nyn+WSvM+KIDd2XqOas
	eFbRn1/CZn4zaIwe7YAMEFjpNroX1ju08/jyby7RYU/tHktvpQ5htGZ3BW7EuCDp
	2CO0uavp5jI6Zmq9RV/EMay3OyWA4LMKFefEmvDo4ZgGxbZh7YS76gV0vpgAscHz
	oweHfxTIMer8sRNk8uKTXlAtJoJxfaDhxWkx2mtJjhKrKdQjSKKqzMw2kkSYpziA
	rIt1gfCVXwowEYJ4b2OnaQumOS0YAkmii4+APisa567yUIlA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh7jh8bk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 11:01:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf0453031aso56565525ad.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780311687; x=1780916487; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pNvkCmcFOTvEpSG5W0JyFmCsUk5a9WiJCwuvo1GWUs=;
        b=Jr6pql9gYoC4XGXqnMtgFg0OERhyDvOe9RVU3xF4F7CskkNNjNYE7Nw8k/4OisqrWp
         8yTsrtCK6jPdJ9nb2eb6AB9Jo+s+GDqx+C1hFZDhGsdewgVwbhqu5wKd/QvdUxvu5vam
         moEYC8RWxvs3llCJeO6TKN43BUrxcpoP/Uy4PrdYC2hYx/knTZ/k+rEAPdLYqR7UReod
         3JhfpeO0Ngyyuj16eKnKVt/L7uWn/r3xiV+D+oR5sz7woKL9WTV4TZv6tdj8hg8UrDtb
         h4eSAY2j5jVAXvwGI2xd4++W0k2cey1/uXxVvsZ2SZ7I2qZIx6q/Hi9ApwpXQ4GPiUns
         nzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311687; x=1780916487;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pNvkCmcFOTvEpSG5W0JyFmCsUk5a9WiJCwuvo1GWUs=;
        b=cDkx/RdiEUjNZ+SbPAGE/vpR+jkey3MaQGI3sQRbSiQP0aqnMmoBBN74ie81/ipVXh
         2G0XNCZnv2wjN2SdC+KTk+1erJ3iGQWKGap6CmgkNxxRnTzWCkp//w96uk+Rq1fs4lKc
         1BzpWgy17BJxz68likRpd4oCWH9as5yF5Fbfoi+H5bpoDjYfRpsd8mZ6OSMZdyw1skLq
         fCS0/iE3BAzySMzprLM7rgYnZn86/wycOSpKvkZenHIAGiwcGvyaBe093hP7UijfJRju
         /4huYZZFdhYfs6/+V5ALB9TVm58Jiy8S2wfRrUfQCV2/7VVmhN+wbeLOt6b6Xck6wFwc
         NmDA==
X-Forwarded-Encrypted: i=1; AFNElJ8qmiyKWKur4ypxQh3U9aobrnIXf15z+W70xPH+ciLIpUCenX6Hj4L1xXn5FspmOQ6DuRvgEpOWVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUVbgSndLlAGy+hMf1yIr9UEP3GkjomJ2fOlQwf+uE9sMbru7
	ApSy0f/w9tRlgr5d/yJinUaAgashhv2O9J2BQXywcfBG37fI+pFWiEY5XVxSiXEIo2ZaaW6CjWd
	O+mMgFj0t4fL24FaEfvmhoT05iPRsUdRbXjubd8JEWj/YoREoUZo/Tdbg+14b3Q==
X-Gm-Gg: Acq92OFkHUlu/UWy+/JQEsV+QCANcxhHBOYu/YdVNL4e5HLx9H1gVQyHYy0mWpHcQ/4
	hAfVpAvEtjMMNphFqMSzxNKjvGGfQFTnXdcTpv7goRM5jTwc4v0TsufCKCMJfZILxx/XNIe1OBv
	JEfofa7GRZvtz1sRQ9CRu2GHhdQWl7vK6qc3RrDQp0uF/Yx2jtQ6/bT56THYwVomz+XsQb7KrAx
	MLqGhESZjy7egEu6X/wIg5jVD1mSzBpN+L4MOGedTRTKqs4gtuxOuvJPrmGH0KWaP0rSkI/8CNw
	uNIhG1a/E4MMAhMEylMGm4ey1Myo2qK0nUfj39MFCPg5cIgcca+OVydypkk7BDGMWIWHMpUdgi2
	LY6rUsfh45W0Xo0LfYCiGMnDhrcgOqALf1ueZ7NJGaDwmyjiFyDXXPH9ucDZT4fm9
X-Received: by 2002:a17:902:e849:b0:2c0:ca93:1303 with SMTP id d9443c01a7336-2c0ca931ab7mr60176455ad.6.1780311686875;
        Mon, 01 Jun 2026 04:01:26 -0700 (PDT)
X-Received: by 2002:a17:902:e849:b0:2c0:ca93:1303 with SMTP id d9443c01a7336-2c0ca931ab7mr60175665ad.6.1780311686257;
        Mon, 01 Jun 2026 04:01:26 -0700 (PDT)
Received: from hu-sachgupt-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd6edsm126239185ad.18.2026.06.01.04.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:01:25 -0700 (PDT)
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Subject: [PATCH 0/2] thermal: qcom: Add Qualcomm SPMI MBG thermal monitor
 support
Date: Mon, 01 Jun 2026 16:31:17 +0530
Message-Id: <20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1mHWoC/yXMTQqEMAxA4atI1hOoBYt4FXGRatQI/pA4MiDef
 aouv8V7JxirsEGVnaB8iMm6JOSfDNqRloFRumTwzgcXXI62zYJzHLBTOVixKD1RLIgCBUjVptz
 L7znWzWv7xonb/d7Adf0BjqHVnXMAAAA=
X-Change-ID: 20260601-spmi-mbg-driver-582aab5aa6a6
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Sachin Gupta <sachin.gupta@oss.qualcomm.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: T3OkU9LxUUJGJlbbgWNuo0JB0cDXqq5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExMSBTYWx0ZWRfX98vwH2ATwRbE
 1wE38XnO1L8YMaukG2XOzLt+0NaAR9BX2VxANJJlouiZj9Tiq/t1DQJ3NCgy67Buje+hwJEqge2
 P2Z5ITj0zv+3ZB01kQK02vJ0aChfnU8Az7Ly9kvydl4cZHEHbRbMhA30SIa2Oa9H2kwyRpCXgb7
 gpztpBi9M7ml33aT2+FjQCFe16wg+pwfc3ZAUYi1UzrdTSff80IjptPCaKdwmD9lMwDGQl3wzkM
 ITVjsvMsH1WhVsaNv7/B4r/QGN/YvVi+6k/q01LxPukyrpMUmD2x7iBPKfzWUTWGY7eH20e7zyQ
 FBDEvTKYJDCa6eLEKB5dod2YK/gYwQnpf0cVD9F21+do8aPmt7u+M4btx5F7JY5j4YBPAOYLqqO
 q+7yZI+Ai3rjZslc0b93UHb7sxhafDGckCp97QpUs3DPRi3TsRPUZw9ATM4U1VpJoc9YkScdLQy
 hGdTapLmKEUFdSxeoww==
X-Authority-Analysis: v=2.4 cv=YuY/gYYX c=1 sm=1 tr=0 ts=6a1d6687 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=iUTBZumk_BVKSr9I0GoA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: T3OkU9LxUUJGJlbbgWNuo0JB0cDXqq5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010111

This series adds support for Qualcomm MBG thermal monitoring.

Adding support for:
- DT bindings for the MBG thermal monitor peripheral on PM8775
- A new Qualcomm SPMI MBG thermal monitor driver under `drivers/thermal/qcom/`
 
The driver monitors die temperature alarms, handles the MBG interrupt on
upper-threshold violation, reads the fault status, and reports events to the
thermal framework.
 
RFC patch:
https://lore.kernel.org/all/qq3cggafexwpdrv46eqijxfmrdbqusl2vpbuswqmcvshqueaiw@r4mrmap4nwkt/
 

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
---
Satya Priya Kakitapalli (2):
      dt-bindings: thermal: Add Qualcomm MBG thermal monitor support
      thermal: qcom: Add support for Qualcomm MBG thermal monitoring

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../bindings/thermal/qcom-spmi-mbg-tm.yaml         |  72 ++++++
 drivers/thermal/qcom/Kconfig                       |  11 +
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 254 +++++++++++++++++++++
 5 files changed, 342 insertions(+)
---
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
change-id: 20260601-spmi-mbg-driver-582aab5aa6a6

Best regards,
--  
Sachin Gupta <sachin.gupta@oss.qualcomm.com>

