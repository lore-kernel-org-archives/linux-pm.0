Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247B30171A
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211694; cv=none; b=HMJliIxbTMAvE3GNx3D5GfC9BVSvzhnp5++NEcBd5cqqHGDOpnICcO4wZsURBT3lktdIU2k0Ww/PSMItZ3rkFIHV9MWRu5+nCyAPeF77/a00vn1z2+41lyjIMaURTBuxYi2GmsgMLXtjk3EduNvAYYdggprqkbKgFgTTIcoNNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211694; c=relaxed/simple;
	bh=MwhhvygqegwVnPDpW9RwHJgvDzXcoinmHS7+DbYP/MQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K8BNrk0y29paVFwvA9ZPv1RKAeMniXaYErgYZWyu/ruzJjNiX+b8PljaVrva3MWMBLg3/Zp3mymHzvB4osW0DeRBbdXYWtn7kHji/laN8bQvHZBxhgs19Q2/gk2dUnAeMCOWZPpEc9Th2cVAznlxY9DqU6WAWNoy2jthggGYOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GdtTGntS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOp7VLOA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GdtTGntS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOp7VLOA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JExJdH341460
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tHNaBqFD+p5JbhQVWdOQk/
	1p1Uv02C32Qb3jlwthWN4=; b=GdtTGntSyMMySfd6sAFGASYMI9QlcqLr/iLcLO
	GYYuzeNICqrWW1lBoFHG2IgbHO19rSwNtTQc/qgAjcWeHqQrhMi9F+1i7j04b52h
	L8blWH2RnHv1hWKvHxI5sLftCbgt1qudLF7Cj89HOBzyHZKxYCVPdUtdBohX3LpE
	iRxrBRe3kCeWyqBgvulOxJfd7yavwK8xOuVmqeT2JVJAUKiYWEMt1O+plwas7KEP
	wZ0LuaXumJrMXvjdTz0sEbJ0Vir8AytpEfwbv9xicFptTT+awlkbnE22gDpOAHis
	HyGwsm1tnp2jAXXbHPdExFzkxjEdDN6czVVBrYbhRSY+EG5g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3v8pfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso57815565ad.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779211690; x=1779816490; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHNaBqFD+p5JbhQVWdOQk/1p1Uv02C32Qb3jlwthWN4=;
        b=JOp7VLOArKaomnC9bsjXgInmOqmmXpGpgW7fOOd49Sp6kFad1vo2M7WwOHoLoiYgxT
         FkSCoSWQ+wcslDNrgGkZMETbPmSUutbUkJgSLsDPfYvPQ69sUQi7YsjVIxxX+10YhYu+
         6wptjci+d2qwxzzc37j6+226eJ8yfnVNO5yaFtPtUgFMLxU/kEDpjXPtR450nHLwcdD5
         JlaqZu3iqwkV1bmYgIEQD05yONAyU9uQ6NifS8FzSGGEE7tw/GVFohSW2Hm/3alYo+mr
         jeYXJwnz3APiFVicQyeka5PuopuIQWVz1gyNmXaoSMrMI6kHznU+5uyFBKGRTij743xO
         QJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211690; x=1779816490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHNaBqFD+p5JbhQVWdOQk/1p1Uv02C32Qb3jlwthWN4=;
        b=jGnYln0jCz6HXmiBaro1zXp4zt2LiHSy5sA54QYKHV6iAwSufsW5EEZQTl/vvp5Nb3
         WOs7U1erh7E/dXujBGmjS5WwyW+YS+7mvqbuWWCHyyJvJoyKZBn+3R+DqxH2/SHzji6l
         EcgH9p9jbNtTaL3z7Ez0P8RO60l6L+0nbNbwbMp2hvCewjzUuc3nJje03cbYXokVcqwZ
         Nr73NF9PENKmqaBAj8oHYjQWf+F/4EwVQUZXDnxsRGg1gRxhD8CwyubdDMNpoJBXUihG
         FcU4FSMywguweEdWEuNiyDLiDPOqR4g6ZsJ1xLdb9UGMjmcsf5rHJu7+3IZpaJyY+hbN
         wB4g==
X-Forwarded-Encrypted: i=1; AFNElJ/BsnCgEVzgFv6yWbwX/Y43QQMHC/nG9oD3DvGm6h3GDsjPIorzxHoIHyL35UQhvo0eZXuP2yrckA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRPfWHG16v1CWfAhTbEaIEWt4QzpvH6lgH7fKSK+OJ/O27Piy
	ugaQYki6TH9MiZBqFGt9nkMyBNilMO5nrWFW07ZTG0yeJKjn61b2nw1eotpBHTdQurnzhm45TO5
	cLZLoaXbO1oaP+wl8AWbhMuligFufDxZoF5xYgH4YqIViY3eRJbYwGNL2kcHqkA==
X-Gm-Gg: Acq92OFdovK8NyWZm1Yxngj/drtB29J1VCmLTvBz5oQ0ywIKj9aMBI/Q/58XQL9UuyD
	iyPXPJIkskztCN/PQVh9mPSmscmEPcFAMQEboUxPxZjebjU12Oym2UIvMkXTffVjF6jTaKVc4/v
	PZU7YcyLkB+DPn+xurizlEQLk5o6ZbtJg/SoLzTkbxtqEu2PKy97opBpZ4AOSEabs2EErZRo7Q6
	ze0vkD8S1OZtA7BE5kwPpulQW36uE23KgOguPy1OnB3dDYIgAKHKV38WMV+/uUc/RvYtixAt7Ar
	X5gw+Af7Vlh9TrTSb6RNJxQYVCxXDK2i8pKdST84dSIYkSSbt48l6IG72v/4NIDZUKJebxZmur3
	6SII+EPqOba3LHvNLPjGIanH5ydeo2EIX0sUASIXoaosBnKabfrnF
X-Received: by 2002:a17:902:d311:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2bd7e7e4ddemr148525565ad.3.1779211690401;
        Tue, 19 May 2026 10:28:10 -0700 (PDT)
X-Received: by 2002:a17:902:d311:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2bd7e7e4ddemr148525305ad.3.1779211689906;
        Tue, 19 May 2026 10:28:09 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d125159sm182248365ad.76.2026.05.19.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:28:09 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add cpufreq scaling support for Qualcomm Shikra SoC
Date: Tue, 19 May 2026 22:58:02 +0530
Message-Id: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKdDGoC/3WNwQ6CMBBEf4Xs2ZItFRRP/ofhUGoLG4FCV4iG8
 O9WPHuZ5E0yb1ZgG8gyXJIVgl2IyQ8RskMCptVDYwXdI0OGWYFHhYJbegQtzDi7YCfBRnc0NEI
 7V5QoFWKhII7HYB29dvGtitwSP3147z+L/LY/ZY7yn3KRAoU5nesyd7mqS3n1zOk06874vk9jQ
 LVt2weQOtXVwwAAAA==
X-Change-ID: 20260430-shikra-cpufreq-scaling-aff690130063
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: b-IOcy13xPHDdyYI0iz-lMDc7gLq72Nc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX8por/yyKBNQH
 gLys3o8eJzPpm09Pg7NtOhAICWPJX3xPDRVs5ogd4eig7OBvZKBOL2HDL2yYmfbGBpPjB3WUfBm
 VutxSwIs1D+lWbPu6L3AgH/GM/1Kuy3oZej2Rbp2MaeYqIE3MmTZZWeOHupjHbyPzI8eSvBn2AC
 hMYfa6m5eO4KJN+0HQu8Ca/8kJraZPpd8U6RzWw9SQ+B+kGuAGomDMHZwUQYK6hnnwahEsit5dZ
 oyKdbTcOav30brFr9WKEQfx377iZA8Q1OoGQpJKWVP+rcS90OQ6exGUUQeaS9Tas/IwZOJrDjKY
 0+OQ1jWI9jEACwF9Jk6YtlPQ367PDOwiul841WuKlO9Ill7XK8Tww1v7Szo8WotACDhvWJ4e9XT
 xl/MSj7zSw3a3S6LQsf1WItrAtWyw5acfXkxl7XusS9Tknl+EmcKtalVVkUxU2ECgBFi6vePdQB
 5Kdzl6fZQBCSjV0TfOw==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0c9dab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qdwp8Cu8RznD16sri-gA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: b-IOcy13xPHDdyYI0iz-lMDc7gLq72Nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190174

This series adds cpufreq scaling support on Qualcomm Shikra SoC.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v2:
- Dropped the generic compatible approach, and introduced Shikra
  specific bindings [Krzysztof]
- Updated the driver patch as per the latest bindings changes
- Added R-By tag received in V1.
- Link to v1: https://lore.kernel.org/r/20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com

---
Imran Shaik (1):
      dt-bindings: cpufreq: qcom-hw: Document Shikra CPUFREQ Hardware

Taniya Das (1):
      cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC

 .../bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml   | 133 +++++++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  23 +++-
 2 files changed, 153 insertions(+), 3 deletions(-)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260430-shikra-cpufreq-scaling-aff690130063

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>

