Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117BE3CBE84
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485981; cv=none; b=JgKWlhFLJArh7fGL/a/f8dFukuVqJW03seZzycQZIvQQpLtiTrWIgp41tBactt6eFUOPufPRVIfQNwAGZeLj1XKE0wzK3MOf+1GAsFKNUgcp/2EdzEeVCiVolZNgViuBCA1dxVeM7ya5eKXF4SZmRHNVpG4kaF09As9c+C4ml5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485981; c=relaxed/simple;
	bh=P0gP3G/IWPqITK42jVKRXDA25rwoPd2omiKXW4QQQFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mUK/O/XSy8fHqGBtJbPWnq4nSdsRcTj+oN1j9v9MfhDYQaBfvp3LAtFoiwfvTWeXW48v2yqVSs6DWY2v8PADbAhHdFbs7xlR0Iox9stAZOrFenN88La2nMgqqGt5PZP4o57X86j+sRXDv3pdyLHaxVPR0T9ff5JK6EpTe0VWPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QfkMf92Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdVDilt0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QfkMf92Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdVDilt0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537EvDZ1956498
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 11:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i6ZuTkqLJTr+Zb68NOePOg
	D5Ckp3vOH2IUNNiD17b6A=; b=QfkMf92Z8LYzDOd/Fhtm34KDgwb4OzrKTpqATN
	rSp27mdf+vNni+iERepy+Byle9smftsnMz4ED+BpKlO8Jbcev6WCv55QMwJ1v91S
	//GoVQcpKWlAnU75+4+z65M2G0JEjYCk3ng7Ctt0oqcoBlMCUrkZXzydcaEC42Ed
	zqdv+Wx//5BDVJca5782DI+/sZShXHu6zlCyBo0v6HoyjqZKIjAAogcfmSsYvfuE
	4mRV/ksWVtmd6bjRW8KmPcnHXCrEOhRWVFXV0ywNommbySLB3ZUO4fNIoy1ToTbS
	7UJI7ks/PP1tT9/Wcbz9K3eu5RQfV/LSntfRJBQOOMRSlzVQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc110v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 11:26:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b35fa876so46727235ad.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780485978; x=1781090778; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6ZuTkqLJTr+Zb68NOePOgD5Ckp3vOH2IUNNiD17b6A=;
        b=AdVDilt0/5158MAcsCQ7xG8XdrBfYqJTJSsuH8RWyJBT08VYLoi3cjTV4fgDK9yxvX
         8orYC4IofGy/rYh90ZnHpINlk8njXLA2EzuPQje0iOm/c2g/PX7VOdGpMNHqrJ57+inZ
         VS8NyO0l6RwZzaE4S/F8NRBXg/hWr1zmjy7xtTaj5IQZWVk16L29SsdSNxSvpqy1lZ09
         feC/34GnZkEIelY9zS4PfGuss/UUArZF9OLWdYUTpXUY77tbEqa4mZ5WsxMCH6IknKt6
         gO+ADHlzVV4yFVc5bogbEAjJ7ySRRWSF18sAYgseMWsaVSDXyC5AyiMhtYdMFqyuxYmv
         1utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485978; x=1781090778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6ZuTkqLJTr+Zb68NOePOgD5Ckp3vOH2IUNNiD17b6A=;
        b=SwFnmKin4sxHHiZdJOC8QQssZ5zqWKlk3kihJm9Ctgs0SmXzxvC5+Ti1McghXbfqzp
         DEO8z5xy0y7kpergMM7tC/o37HepPd+p5Rz249KDHJHThB/+BdPN6I2HVxaK44gIjT04
         qHrsR41+CckrtzoRkpJ9fUqZfARJ37tqLDZ5zWcwxyXfFUSZRexsIsQtymUD5j3qzusi
         oCWQnYyzPQSMubwwd50bLm50kWP+ywzAtSzTNDuspcMa8rk/5642G4+uZBbErFzGewxF
         FiM8e17W0UXUvTZRH34ojwkgSmm7GGxrsLR9kEtnk0V0/1xevg2l6FHmCI0yCtq80Eqx
         qXLw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ji8KfB3elM7/OGoHaajbeBPyxZgGbQqentN7IVIT2i1/y+w16WDgMSlApujqiSayXJL0oKIaUpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YynefzURwkZgpMZueiNzLbkcJwd83WQZQlWWOdFHgHCKIZ0t/RT
	JmyH0rRNtwOWKwklb30//CW1PiL85bPf9RPJDISeKSGfOTEAamc8ZlbRiqq+fyn3YKTNndExmK7
	ZJH4egdpf+jHIWsWnxY4a87rh4Bkuz3PW+CiGgqkiJjnofqf/Mh0tgH7vBZeMVUcZKZQ3jA==
X-Gm-Gg: Acq92OF904G6nmWdg0sYUHXnWaljk5gkSbNWfeWiawT8WAZ0ei1VpGmFZjm3g7l4bmS
	Zwl6/U73Uk+ebTkFeYKCXC/8Ms6C0sCv1/wK5e147NrbvAkB4fDBc99933Qf+aY1Jbn3a1c5dr0
	GmKJCsrW71jiw1yX3tk6rd1g2l8lXbwYcA3uMUe189a8Jr4hX6ueIX4U4yIYMZs7RCFk5mWayxp
	pu7MWpg4Ug8j2ak0NtF94SbJnz9kNdvfNnBnYaus3YLfnuXA+PxyvWQiNGwlizMfbMbv2d7JKEY
	YshvBltEzYxJ9EgonWv3maMrOb5O8S2LyH2YVl2sytvlgn+JQpogq8r/Pq20bQKQJlKm6UyNZ9L
	vvKfv/YBuYF6rhp43kcbtPeI+Mf/yroTjzS+mo0AphJI0pOG03bGWZOk=
X-Received: by 2002:a17:902:e5c6:b0:2c0:cb90:1e07 with SMTP id d9443c01a7336-2c163a12aedmr32539405ad.11.1780485978151;
        Wed, 03 Jun 2026 04:26:18 -0700 (PDT)
X-Received: by 2002:a17:902:e5c6:b0:2c0:cb90:1e07 with SMTP id d9443c01a7336-2c163a12aedmr32539055ad.11.1780485977695;
        Wed, 03 Jun 2026 04:26:17 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm22704275ad.45.2026.06.03.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:26:17 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add EPSS L3 provider support on Qualcomm Shikra SoC
Date: Wed, 03 Jun 2026 11:26:11 +0000
Message-Id: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMPIGoC/3WNyw6CMBREf4V0bQl9EeLK/zCEFLyVq0CxF4iG8
 O8WXLuZ5CQzZ1ZGEBCInZOVBViQ0A8R1ClhTWuHO3C8RWYyk3lmpObU4jPYCkaiqlPcSGkdaFc
 XzrA4GgM4fB/Ca/ljmusHNNNu2Rst0uTD53hcxN77K18Ez3gtjCysVrlQ+uKJ0tdsu8b3fRqDl
 du2fQE9BzMMxQAAAA==
X-Change-ID: 20260524-shikra_epss_l3-522afe4fb8f5
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: 2OVZpQxR4JcXOddaA20b-6QciUVSnqUF
X-Proofpoint-ORIG-GUID: 2OVZpQxR4JcXOddaA20b-6QciUVSnqUF
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a200f5b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=DWCbI4xYja3NA8O2gMYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwOSBTYWx0ZWRfX6L07m/rq0Bve
 6BRzP6YWiUPdAsDTeluMmBBhITVJyusZN2Idd/cntAhYyB7POFWSegUHq4Asr+nMSyT9iMbpTGt
 CsZKC/Qw/TK+RALZst5+1OhQJew+9shnlxVo6aHVkD3kfhtHlha9V8RJgjG7si0GXZts0NU3+Gd
 IO4ETx78P+1VPp1ZHLS3H/lDHiAVEFXo52SqzUelAMLEtx9UbIR5S0mepPUmSAsgzQIp8YPzrZM
 U8Guqj9QzZhqsKWopg7ZXVpKVQrJGU6UI23dhhDfNP8bqB/m3jry+ebb1qdSguXs5hqHx2D6/Xx
 yfLeQj+Y5EVmwBqShae0FOex77dHyYsx5JHHNYM11v9aUmmHN3yKNvz/5LBvsuqBgkHlxYlv1w/
 hy+X7VvgGG3mGzBlcgwbhW0zyD3Yy6Ci+5kCP5y4y738d69/AcTyvwWxCTERmiPLLmj9QKOBc9D
 T8/k3EvcVyKLAFAvI0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030109

Add Epoch Subsystem (EPSS) L3 scaling support on Qualcomm Shikra SoC.
EPSS hardware on Shikra is similar to other SoCs but supports only twelve
L3 frequency entries (LUT). Reading the LUT beyond supported frequencies
can expose incorrect frequencies.
Introduce new compatible to represent this constrained variant of EPSS.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Changes in v3:
- Update the commit text to reflect the correct binding yaml.
- Link to v2: https://patch.msgid.link/20260603-shikra_epss_l3-v2-1-480cdb5abc85@oss.qualcomm.com

Changes in v2:
- Use the existing qcom,osm-l3 bindings to describe the Qualcomm Shikra
  EPSS L3 hardware, as it is similar to other Qualcomm EPSS/OSM L3
  hardware. [Krzysztof]
- Link to v1: https://patch.msgid.link/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: qcom,osm-l3: Add EPSS L3 DT binding for Qualcomm Shikra SoC
      interconnect: qcom: Add EPSS L3 scaling support for Shikra SoC

 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml    |  2 ++
 drivers/interconnect/qcom/osm-l3.c                       | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260524-shikra_epss_l3-522afe4fb8f5

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

