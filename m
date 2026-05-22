Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B32472771
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463106; cv=none; b=PoUqUZUdXSeVssr+euQsAemDx0A8NnB/Jdu2dAiLxZ5v1H1Tm3OZKSSuoIpCoPxOqYYCftb1cRqd4SbcGM90eb/fuZg9SyA8VXDNeL5wCrhwixUZH8XgLoqrncFHIe1pj++K/0FTrxoBFj76n7CrhdjLFNSJIa8HlzDNVQ66xz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463106; c=relaxed/simple;
	bh=5xzbxVE4zky4rnTKO3zxGHdYa5RsWAP5zVmb3Xty3fg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jckVVGPe+9PyDIERvB3AmQZ0kgAB7pBbgMQMuS0ej743n1spQeIcOitzO4tim+OI/t3/p8y/k30B5WbjZjah4AQExC9M8OGIb5ItN3DkJ94HMN1oZxY6vnVkE8/XvCJc5/mbywS1ssXo2jn2I5Pwj78U7+4Sab6uA9orGdiAMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rn11n1by; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SEXaLWpJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rn11n1by";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SEXaLWpJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MC7Dhd1959980
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=b5qd0Jvl8aH9HRjSEREJvf
	KNf3cggNHxWlONW/RoqxY=; b=Rn11n1byuvPM5NlHFhX9fP0DCXRgTcB9f2h1qf
	BWlBWX3xeik2JrKetT8Dwg5oCh+1xwlVjIpxEPHSwrBmqiRopGGoXwJIwFjtFo6O
	Ry1Thj2ylOr/xYQMTA5oiwnHQR9/XhAGoofyfWdrcRDiW8lbuQLQOiYSQP5zlK0t
	b0ghlx0k9KnA//833tUtyUftansrq8wTzyDa+VAKjTr3N11X2DcSw1q2/D5CFwzn
	GRblcV3FOB5swi2g1dFJvWjh2RBwDxKj+sN0jqD6CNQ4Aevjzn2LMLBSCSWH0axg
	emV12i2+/T4mjOY0GyEH80qBTHEFbNTkOiiWe9UBeU9TJG1A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxet54n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:18:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-83536dc3be5so8520325b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779463095; x=1780067895; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5qd0Jvl8aH9HRjSEREJvfKNf3cggNHxWlONW/RoqxY=;
        b=SEXaLWpJzlun+HlqmuhaDLdd5Me5t6ZVehr3Mnf5adIvCHwipA4iwZWcm3e6IHWZ57
         q5TQSGb8qfvmxzXIM6jvREjnD/docbwCNqZZTy/ehfR9hFQ71Tvtqt7pItOJ7ttls522
         ggbfMNr5LVZN4I/C4PqXmP1uPNkQJsvFDTugYksfVGp1qlgKRAmusTppaffAVZ0mM+CZ
         APswmr0Bc39Poyvwst96PfNh6tZhnEnEx7chl+XWp+CHMFw2GlCaRb3fMmNFemiDowiK
         hLK9G0Ibdt390RZV/D03KS+rhyxuStY+LCKszOaRIPMGsBF9Ra++ZqIMR/b7HcIEYZZ4
         J7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463095; x=1780067895;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5qd0Jvl8aH9HRjSEREJvfKNf3cggNHxWlONW/RoqxY=;
        b=SXNrYuXHdobedR2ehRBZ2ruzSdW93CgmzrHXuRxNSgsBqZIgemKdn70d0Bo3obwBUZ
         R81KrdUMnWCcKMIrI6ndaCF/j+NHuwndudfqsbxkmK03GkWBR9bas92aUMRaupygYlfN
         L45wJoLQZNfGA5hty+JIefTdom4R7HdwqOrrHc6qI0ytnndqfBLRB6EO015r8ePXQPg8
         TRawmXRUt0EPMaLB8EllkSoD/WMTljgRLVEkIxcfj6pGOEgkHGQGgSc4W8ADnM9IJ/Vc
         FsXNCWjy/BktScsk0Z9rdcQ8wk6fD6lAf9il0bTtSq1TXCl23Ght6f9qa6vzp5AndM60
         nxpw==
X-Forwarded-Encrypted: i=1; AFNElJ+szv/P8EAfheGTy1iz0DcvBYieXPeCZSl4MrKXkSRYec4VlzZ+/2W3lf5YsLOOv5WCiFmTxX7iEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89G4lWiBp4SSBDeRD+OeNGxcK96MAwLW2kQMHwz5UR7bUCKOS
	7NdonwCsJ16C5px9xNCJMAycPSlCKiG0UUebmcwSfiLSs63NMIeU0rh4CqP3ZCJ2P5iYxYB2KDa
	OwF3xXwQ6FqPxVo2cgr83UMRGfwHP9gvpHdBscsf7SkE18cB1gBQncvzAQ7xLRg==
X-Gm-Gg: Acq92OHiSkOcj9rOiNp4TmXCd1FeurRex7Odq0/oe/xKiLw0UtozJwT67wEftr8FP8Y
	RAVL0pYIZ9h51SB0sLbJcpcumO1q4DfyWRqR/nqmXIxv03xgMoHgYnip98ULuDpfnGA8F4c6pXL
	3yjcmcZZV4mOlFgyN0kzEmYcwtqFuu+X5dumL32gpHX3QlzKPAzKnV2Ou4Ngl9vwjxOCZwqiKCH
	44x5qQ7jcJlx4zfCqoETPhgyReM/bD76eNglnz1Svspi2uLvY7NKGL5Tro9S3TkHFa2kTjbEO06
	z1xfr2eG8fWVQhcTdcSZJQqXdXg63OHTRuARPKq9aBYtDzbDuW2cdHEbsVnPyCHEP2QOlrXLq0F
	ELnv28jrOUTcN99Oqu3KV/M6iOjTPLAOmcK8OFRkM4i94cRzcsHdu
X-Received: by 2002:a05:6a00:ac0b:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-8415f303dccmr4421004b3a.31.1779463095256;
        Fri, 22 May 2026 08:18:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac0b:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-8415f303dccmr4420961b3a.31.1779463094724;
        Fri, 22 May 2026 08:18:14 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fe97c0sm2083042b3a.53.2026.05.22.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:18:14 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add cpufreq scaling support for Qualcomm Shikra SoC
Date: Fri, 22 May 2026 20:46:21 +0530
Message-Id: <20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVzEGoC/3XOTQ6CMBAF4KuYri2ZaQGpK+9hXJTSQiO/rRAN4
 e4W3LCQzSRvkvfNzMRrZ7Un19NMnJ6st10bQnw+EVXJttTUFiETBiyFmAP1lX06SVU/GqcH6pW
 sbVtSaUwqADlAykko904b+97g+yPkyvpX5z7bnQnX7Y9MAI/ICSlQdclykZiE5wJvnffRMMpad
 U0ThUFWeWI7DcWhxoLGchAGNCpRZAca32ns+DcetCzjCnmBOsH4j7Ysyxf1owL1XwEAAA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1MiBTYWx0ZWRfX+dJU2qyTDS5i
 kMn7ZG8p2pYzisaJ+XeRvkjPUQoG9zNUnNAZsiK/ploiRLEUJ93CnhVp7UPU9Bt0+oJdi9ri1Cn
 Em16l90s3A74kLbrhrr+F1KnR2HWUwUn65bKoK3qT4lYRrDg/lgnv6nvolPgDIktdl2bomuAWL5
 pM9HCuprZbIZxJDH7Gwr6QY8wroEofRFNlM/2DVFcAgdSQhBPg92LBdHV7dwpnMOYAvrLY6d8SS
 pKq165lHXfyH/qqhTRzXesv+lpKmqyhx0IJIIGpR6pnob8GEZhHhpLatZXGjpjqOEGKMfBpJXmx
 24cowpjvw+m8fGhGt1vqnAk5CKlyEz3cUlH5bvxBxpYsAptKAavubo905jk21q8WGbRrqNFQ2C3
 MDuTq3I4+Gb5gqxiYkMEZmbNfsVlS0jwY3nJ1O8nl/ZeVU2em5ps8bTcHPI8fU5j+ECICyFDSoh
 QmqKbprvtcLFrBGA3rA==
X-Proofpoint-GUID: KA-TnR6ZY9Jo3Tas9h53WgJ137G773d8
X-Proofpoint-ORIG-GUID: KA-TnR6ZY9Jo3Tas9h53WgJ137G773d8
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a1073b8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=v_g_bJvqKrPZ60Du8zUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220152

This series adds cpufreq scaling support on Qualcomm Shikra SoC.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v4:
- Drop CPUFREQ and use EPSS in bindings [Krzysztof]
- Update bindings patch commit subject with correct subsystem prefix [Krzysztof]
- Link to v3: https://lore.kernel.org/r/20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com

Changes in v3:
- Updated bindings as per the review comments [Krzysztof]
- Updated driver patch commit text [Dmitry]
- Updated compatible in driver patch as per the bindings
- Link to v2: https://lore.kernel.org/r/20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com

Changes in v2:
- Dropped the generic compatible approach, and introduced Shikra
  specific bindings [Krzysztof]
- Updated the driver patch as per the latest bindings changes
- Added R-By tag received in V1.
- Link to v1: https://lore.kernel.org/r/20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com

---
Imran Shaik (1):
      dt-bindings: cpufreq: Document Qualcomm Shikra SoC EPSS

Taniya Das (1):
      cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC

 .../bindings/cpufreq/qcom,shikra-epss.yaml         | 96 ++++++++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 23 +++++-
 2 files changed, 116 insertions(+), 3 deletions(-)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260430-shikra-cpufreq-scaling-aff690130063

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>

