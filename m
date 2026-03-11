Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A63CF037
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225376; cv=none; b=XZbfl+9rZXMcGB+fCDvSmu3Jon3GPGpBZxdrqVxxwgKjdbJrjBLUoXU9I8WEJAkVe6o+NxA0l9WgxAlnz7h4n5brs6LTxAEnNTwMbZUUolwn+Ql1+aXcwesjVQRyuDqe/2TI/LL41vdf1DNDqc5t1xJO9qSRo0ikTIqjY3h9cTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225376; c=relaxed/simple;
	bh=V4X7SQOiKwWP/Pa3MnE0/qdRZc1SxulGZjvcaX8/aAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/LSGt/zcUiT1z5Rnux2d//cM1Idhj8VkdgEEV8UaEXWilEV4A6M/K5aRtxZkD1xLhTi1S+FZbEwdEdY6Fmg7x/oqOpgZwayadBhgyP+U5Zhpj7KQsyi+coY9jGV/DXvFHU2slt897Y6hRQIv5/HFqtWunND/KcB9JyxzYGB90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XCif0+eq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hIDyn8hL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XCif0+eq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hIDyn8hL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA34SQ2038153
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tpHlvfxHMXkkRB+NxUG0hcSQhE/rKGHsEhV
	os89NpKQ=; b=XCif0+eqM2oNx02Y1VJxOBs5OCZ28od8dKuytWK0Dieo9Ggq480
	mznpFLMNYUabdFGnEZ6Pj0q70O/EMgdbdPdPW5WJpEymTT64Er+XH7fZrzTO0AKt
	tayaIZrifKaBkOMGLVnskvrmZTqxJX2W9WPf5jbsIo9qdhlpunuHzDjr2qMtw/le
	HRjyR8BBDqurcLPRz8Z8dMDNWpe6jR5dj4kHmGr+rbI77LijC5XZWOUMRGO2CaGb
	ijrA08AQpi6fW9orwpYvfQnu7WolfPe3tbQNOY5FbhPkvlhm0BdLn+O/YMn3Y8Um
	AR60ovqbxlT9oTysmyPXSPYY/WUW7+J2NTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6a5g4p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae4a6bb316so107312285ad.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773225372; x=1773830172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tpHlvfxHMXkkRB+NxUG0hcSQhE/rKGHsEhVos89NpKQ=;
        b=hIDyn8hLvv7MFFcaUUDJdeIpGXlJX4aE62ysJvt3j8a1WQ+31MHSEsYQ1svPSN3rw1
         Ww7qCC9rVV5jCC+Ak8tOVNTtvnk/wO2GVh4zXU4UezpquXbZeAPECpxG9+ke9Uh0DGJS
         +lTz5mx2zzz5tO3UdKgW1OxH2wDn0jZTdZ/DF1NnUOsz1N156sNCaMy0/XXmJOaXcFs/
         WLheANabRVXEA8nXsvPJpc1XMpc1KOZRyjzZM2dRBqINh4ooYVLAql0T9hh51awe0gGF
         qH1WXYhJZ5T1jVJXjHwv//z8yVqrts0BMGzXdpqe2ELPE8jEvkamtB1kF+ld1jqRyQJO
         S9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225372; x=1773830172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpHlvfxHMXkkRB+NxUG0hcSQhE/rKGHsEhVos89NpKQ=;
        b=hKugsD46bnW6Y1tkDMMaP9D2C8AL7gucx7k7A/8IsnJlQdMSMFYLJeLoodvatDlVxd
         PmyOravMTc+1cOwOwcDLUR956gALJ7VqALvSjLMzVJpUwGahGjRSIDhNje8MURF6UbqK
         Wdq9M7qLrLNeOF8KG1JOdOvi12ZDll+fcN8XMPA7ulzCiep6Fh847NwbPLArQfGF4FnS
         I00EL4WaBETlIhyg4xBn5VDVtyNZY0GxUGd1MzWmG+ypkb85Ec3NmQkTNWOl1mDQxA0u
         cxnGGiwKIOvke3K8sjZJaGvVqxEw8CFt69S57gxbltnWimXm5E13pjCRD3H2mNOW7Msu
         YDNA==
X-Forwarded-Encrypted: i=1; AJvYcCUBUpx/YADtn/jde8lcXQtLQUzmnX97LQnEQOOv5hNly07oRtMFu072O+InQZxFRbjwycKOR6cy3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3obe1fQU9HePswg8+5ONnaMIhBc/pzWFPX29a8wvO6M6VRvyK
	cJk5w+k+F59LAX1YoZejUMZWEjN2yiLwkkXuaj7RWcdk3cSOVh5+pgG5pZMbFMvQUt11KoiQEP7
	IW8kj1BeCVvTsgPznvXYE1jVpufYg2crcIu859FyJDixDP5kMfUOYZaJsh59Glg==
X-Gm-Gg: ATEYQzwNfFQjLSqQWUagHYEemRWaK3C7Kms3IY5+Rm1XHph8tFLw+QqF6Ee/lBvBFRO
	oeO9WeiPX4IzzezIhBwpMeHi00OtwxzQ6SnPMYHedcqVDFKcfAS+oSBO+WCg81d4ckFlhk/dcke
	YEFm+YGPvCkBX5Qs+F5AHs2+2yZAIxeD3nE/KCEIRxOOyhll4rthT+h9XdwutNLhVgnOoutu4fO
	jJPfXkjcVhmQtnMk4AxOzoISVvwT/mtuB16Ql+82PzT3f0gCtvXDDA506gdxeglomAzbo/C0saX
	zoybTzvzBwiMdXY2H/yEAXVNVFye3dT1t92o0dXTI1o+gyB3Of9ZGd8lI+nb31p0PEWXWTLUftB
	/oiZVjGTnFlGHRACll/ji9DgZe8uR/6DGN1fu+jJhNh2x3wzL1JgiyxY=
X-Received: by 2002:a17:902:ec89:b0:2ae:55bd:1473 with SMTP id d9443c01a7336-2aeae876b3dmr19743125ad.31.1773225371996;
        Wed, 11 Mar 2026 03:36:11 -0700 (PDT)
X-Received: by 2002:a17:902:ec89:b0:2ae:55bd:1473 with SMTP id d9443c01a7336-2aeae876b3dmr19742895ad.31.1773225371465;
        Wed, 11 Mar 2026 03:36:11 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378a28sm21042925ad.88.2026.03.11.03.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:36:11 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Enable QoS configuration on QCS615
Date: Wed, 11 Mar 2026 16:05:45 +0530
Message-ID: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GiimPQYAah5B7yXVE25ijWFM7K5DwscC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4OCBTYWx0ZWRfX5vos2WLHUx2J
 5EYqudm7jVnzPshkFyqIwp3stL34UKB492ot0KbOjf2GQIvb28zm2yEzXUpbnYIEzkStN4Csv2P
 QBEa4iuqSvd8YuTAnu+vrqQSeGdl95ggQCXhSkgmKSL22hylTu3AECuVXD42b1vUmJ5rpMqd12M
 SCQDSHHAYRvWwqAD13ZCQKJiUzt6CkdzpzwmLAe50MVI00bUi5Eoq173YD39vAduAWnwog5a9Tn
 5R2KKu69HRRus8dSBOuLbPD+XnzL//7BCptJhk+Sb4CLZAYkT6rzOru8EZzspP7veaNMbcBKL3U
 VnUBp58rz30M7Ctc/xgNgb0tOpYRDOUACH4Ruk/4DtUQcyKeevsZY16Bhi5Y2nxw2ezHvfFNyHI
 5gP/ryoLUKsvWJXNl8H+FaUaFKkQIhA9wVYtiMUe/abh1QPT/JeLH/tAJagNrKvdz87A8qgxY1J
 lVJUQFZUmLb0B7nS66Q==
X-Proofpoint-ORIG-GUID: GiimPQYAah5B7yXVE25ijWFM7K5DwscC
X-Authority-Analysis: v=2.4 cv=TtLrRTXh c=1 sm=1 tr=0 ts=69b1459c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=hqR9uRmBdb12yu0oCjwA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110088

This series enables QoS configuration for QNOC type device which
can be found on QCS615 platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip).

The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Changes in v3:
 - Refactored the schema to define 'clocks' in the top-level
   properties block as suggested by Krzysztof Kozlowski.
 - Removed the conditional logic that strictly checked for
   'qcom,qcs615-aggre1-noc' to define 'clocks'. Instead, the property
   is now defined globally but explicitly forbidden for all other
   interconnect nodes except aggre1-noc node.

Odelu Kukatla (3):
  dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to
    enable QoS
  interconnect: qcom: qcs615: enable QoS configuration
  arm64: dts: qcom: talos: Add clocks for QoS configuration

 .../interconnect/qcom,qcs615-rpmh.yaml        |  34 +++
 arch/arm64/boot/dts/qcom/talos.dtsi           |   4 +
 drivers/interconnect/qcom/qcs615.c            | 247 ++++++++++++++++++
 3 files changed, 285 insertions(+)

-- 
2.43.0

