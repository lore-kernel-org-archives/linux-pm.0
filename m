Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA53B19B5
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895596; cv=none; b=txgkJvog9/bTh72gnK9RmKAkKLU1ruFqxcNobgPf8tFrwEzrUoS5bUrS15pqpetN50dm3uX71u5HZNYp3494D9cq9/PUeQUcq1kdI+jSYmmsUHp78KDeTHFM7jmmL/YYxjGDwDoJpb5lILV0NTXqO6MBHFAZOLxNWDK+/t+5YNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895596; c=relaxed/simple;
	bh=LcV03W46H6g3SUm1iaLCXDNF1twNf9lkDV/Hbq5M6Jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EhQqBt5vh03QFXBJvrBW73/MeUXiEeS/eN3KycDw4+Hb9nP5pAYINGT3zNwbr95QyXFTe7Aeh8tpSonvxpySJAhFzr3lC0jrhBymXWRpEI7opxp2H8h1Xv+uR8Mkpabgynf1whH2dAiaNijAWbVdzhuxQxrOSORYU7I6YLhOkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxTwa8I2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YrLjeaNY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxTwa8I2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YrLjeaNY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618G3mY456082
	for <linux-pm@vger.kernel.org>; Wed, 1 Jul 2026 08:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lP3vinKQxRygXko5Q2tIE0
	8DQYBGJ0utHSduZUN2bnY=; b=QxTwa8I2cnjQnvsCCOWWO4mbf+tzTQypQNfMWl
	xFOOEfkc64hKnH64WCIze8Adjq/fylI1OC/gBIVVLPnR+bslVDVEE1m1ICwIOu5/
	y/2jHxO3y+5KvageeJbKw4ZrutbxjZr4EB0txR4wnVx4HVDNUxN9mtc60BKK/Fm1
	CNAuLsC1LEwausxbw98t7NK2G8XFAeNgWZj0+DbNwpKzXFLzKqFDp/G7Zzjg9Phv
	OB0/2CUasRtlz5vH8aOifa0SSXE/wITgYcjMqi29rJOlMbhsfNMAUouyf3e85pZt
	MxnlN05YMxln0c5KuKRvDG9ugsk71QWqor9tv0bZb++Air4Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwb3v5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 08:46:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ed664e368so463767eec.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782895592; x=1783500392; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lP3vinKQxRygXko5Q2tIE08DQYBGJ0utHSduZUN2bnY=;
        b=YrLjeaNYRvi1a/ObQw9A+dpvW67gJ80E6N8Hg2vljqAdXg+LA47OWV/6xIK+FWEyj5
         c5SvpfIn2GELD0aDHRi4vBJWdjYMzN2nHnMu28sMGKHGW0SNOwcp/sCPSJklBAKYNIj5
         J+xAb0rElqF5XCl2mECnnj16v/Qe2KoApZXPCi3YPlMooLYKXDwxpDPENUg5OeDoyesI
         Yn/NhYfrz8U+2fr8ngqlcASHs8/MvF2MhXWdgu5uGnR0FjlsBgRUFGXEFgCPnI+cr0vd
         +0NNyRdFC7rhx7itAwMA7AJwm9f8lAXrtYLHm0bUJFuwnbnjIymD+GcQo3uVfpTFOexk
         B6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782895592; x=1783500392;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP3vinKQxRygXko5Q2tIE08DQYBGJ0utHSduZUN2bnY=;
        b=GbpPtHXx5mS+nRnXGWmEmkivBbNlzepyz1aN0EXWHeH2rVlDgKYYLucXk22nnMF7BW
         tU71E90VEaqar84hr7Bt/Um20IIeHiMUjD1tQZCxWOBENlqq/NboGupB7xr4LHJROpRG
         8Gd9xwvAonh+CMb/JvqalqEXlMpHts6ds+BlSqEjZFUBXzqKFJn5QgStAYjzEdCdY4Gk
         0VZ/GLdKjQx/neS5cK/lVVayM3O40Zz3MAKn44o+AmwR4Gl+gtAm1lHT/X8Z50wUBr7I
         KTxx8ghBAu6S1eWwyri3nD/1P5mw8DkL1IhOiEhVihazxsCcyID3UVUOiJhfzVyiblHG
         bs4Q==
X-Gm-Message-State: AOJu0YxujP8XlgDoK8bRSZMy9ogTDLwU+Tmz12SM4G23UX2kf2SQTfbZ
	ZzIFpJ06pQFGuojFxMglB4ScUcoaXyLdm6ZEzESz/Q/CFthtK6tMxONiUAgGalyN9m2/qEyyzf3
	IeLu6qwdaC/x/ElciRFVpVz29wWk1ZK56+/Me8PBjdnxmtrcMzPARAJj5JYTqdw==
X-Gm-Gg: AfdE7ckOAki6YiM5PFT+PZr04hnA//eJove/6zhRwW8WOIlOCsJdfXQ6FxY59pi4HD/
	Z94ni/BeAkKLQJtEyhj15pth5CNt58iAP5Ht+P3+GtNEzD1VnUa/Dk7+yafyP5lELA39ku6lv9f
	q3734PNEAU+WH7hvjt287r+keqy8o2Ap1C3UUV7R8xnQJItow4GrXmgeblDxa8Pfq1T1z2Qzayg
	reVEJJl1uPIylmd4WudUYgI3RUQHQuIxB+ngLKx7tOBIrut1uhj0PQ2JaZ8PibfTqRF6SjYFu7I
	+LZJS2CjUaJsGpTiZ7uj74dz3A/WdmEb3/hH6i2xolEo24mn1uL6XKVosIL6Ga7pBeM8r9RE1Sw
	s9qxJE+w0xYRoIqidr8pkaUNJZbRuN26v/dPxmJNtvfzbntEsRjZieOWm2QRReqAyezCQ3IJrqy
	Brg0yZJ560+NIfXTp+nwCjKWp59uGZWYKXaivlm31d
X-Received: by 2002:a05:7301:3f07:b0:30c:ab96:7302 with SMTP id 5a478bee46e88-30efe949021mr955952eec.18.1782895592442;
        Wed, 01 Jul 2026 01:46:32 -0700 (PDT)
X-Received: by 2002:a05:7301:3f07:b0:30c:ab96:7302 with SMTP id 5a478bee46e88-30efe949021mr955914eec.18.1782895591825;
        Wed, 01 Jul 2026 01:46:31 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30efaadc5bfsm4891524eec.28.2026.07.01.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:46:31 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH 0/2] Enable ipq5210 in cpufreq/qcom-nvmem driver
Date: Wed, 01 Jul 2026 14:16:23 +0530
Message-Id: <20260701-cpufreq-v1-0-98656ad20ff3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/TRGoC/y2MwQ6CMBAFf6XZs5uUKhj5FcMBy6vugYJtMSSEf
 3cjHmcymY0ykiBTazZK+EiWKSpUJ0P+1ccnWAZlctY1tnE1+3kJCW++wFbX4O1tQE1azwlB1t/
 p3h2s2aLDckh69Bnsp3GU0pqItfB/eqZu378BV+/LigAAAA==
X-Change-ID: 20260625-cpufreq-4e017fc09de5
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: NvFzzDZXCf3tPz0iSVZT6VbLdEFJeIRr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4OSBTYWx0ZWRfX5MzV4hrtvomC
 qJNMnpkJ1oLdD5oqcXaHQdESbE+Nn8SiDLca7KH1jGNrdRNc+ZcBf3M/EQlk3XhKJKN+Nf1ZdqY
 yRB1oscWtrGmu2BKDyPeOsGHG/lHi9Q=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a44d3e9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=9X8JnDGoADxzNrPhSwgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: NvFzzDZXCf3tPz0iSVZT6VbLdEFJeIRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4OSBTYWx0ZWRfX43B8hcCTOFxj
 FyzAt4Qy/0RTF091XqEzqzkb0ZPnKHSpPIF6C+chFSTWuAAZKefOdf8UHpJTL4/h55YcF6YRBN1
 Cg4YNA/Q+9sFmEdtaJRWdu7kq23AGQ8tE6ZPC1+K9mQLKBrLBzL5mH+/coFxVGVbsQ2yZtaD7mM
 Y2honsPocpp8nWX6hDi7h/bfUZPkAkjG+hKVkhlekAmI6FGEHsuhVByDEqF9easOKWXZjOmlq3W
 Y/ve/j8xcHObBvvl88fkHqeu2SeTqZvB5Fwp7QEy0FfoR3Aa+LUtIIR8sO2MdxAavhUIConjRMM
 kFpZh7jwjKPdC0Fyp3mr2drHPZ1D8DmM5p3Iac2nOeqz0S4iHrEzsKvvp2uh2j+g/DuMc5z1rYJ
 8yXC1aI1P+Gqq6YQAuvB9sDxIB/nUwiY6Xxqp6G+uNAw9S82yI/qyI88s0sNz9SQXu4sUHyZq9u
 PSnN90x9QP9koZ6g/kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010089

Document IPQ5210 compatible for Qcom nvmem cpufreq driver.
Add speed bin identification and match data for ipq5210.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (2):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ5210
      cpufreq: qcom-nvmem: Add IPQ5210 support

 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
 drivers/cpufreq/cpufreq-dt-platdev.c                              | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c                              | 8 ++++++++
 3 files changed, 10 insertions(+)
---
base-commit: 533704f3c28c3f5f9e2542aa3a6a326c32e6f5c0
change-id: 20260625-cpufreq-4e017fc09de5

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

