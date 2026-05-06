Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F862E1722
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092735; cv=none; b=DgT6qq8Fa7w6i0e6rPuBgjt8eLJU3fJIQCcBPXp0+LtR9vXZaiXebOIw0nkcgYQcHY0WDO6HRUuW/tSgmDJJg/OZ1ebdNf4sAMFONFlIu6yupT+TsFyM6u2GqfscHHaZt7E+ncQHLnGYoROjEueVhet4QiWsn05SKdWhnm+NQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092735; c=relaxed/simple;
	bh=96jOQ38DKHlJwyQEUSdRWVCI2RgSf5udNbyTMFN2/pg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RUrOsUWuWXsSEJqTubRhiopobkUuyu7EHKg3mX6DrY+Lz/OyBAfjfrbP+WwRBlotp+fd7JcOTBCwkapSEdT7kBUB4OCjEFDI4qI/tfSOUQrhZXLQhH59xKw9BWWbJHxxKgpcESl3NCtAlIp9lsEagN9lkHqW/A46KQQMV5SdpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PzVnkXD9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R61mfW34; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PzVnkXD9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R61mfW34"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C5Ntc3036585
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 18:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u5i73O2TeW40M4e0REO3mU
	O4IV+MciKckhAqv2Nzlgk=; b=PzVnkXD9hjtghoCbgomISbLX4MPW2knRx9DGpH
	MOMAT5ueFuKxzpuncFbb3m73ub2TTo7JIu0Cd6+D0WEnmehjEubRgbABWY2CidI4
	dWmm7fJT0mh/l4FHZk7g6aUx4QmTbF8of2/SilFjRqkujnup/l3oaCDn8g6OoM+K
	vAEqpJTF4Htt0fV1kVFGjGTc968iMYKuHEbKI5GcajCZMQpenYGe0xl4WEKfcJge
	LBx+OXnPFrWU7dt5LscWE+iun2i4ecR4eaoecHgenPH/QM/alBP6wmJZd+aT2R+e
	PC8IUtzn5InpS5lAN4ldbZvalUoyDoTfIYcKEUS3kq7mdczw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf1gb3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 18:38:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c16233ee11so5723eec.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778092730; x=1778697530; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5i73O2TeW40M4e0REO3mUO4IV+MciKckhAqv2Nzlgk=;
        b=R61mfW34mJYjFBv/0Wf8EUYsO7N8FB1y3bd8QX/KsCLLjOrTsbbsfOLyEGT9VG1CAz
         Lq/nRTdg9cRw2gL6uPAlsYE22aE25TYFvroaoC3UsXf2bQ3BaICE1K4t6zvhgtd1WzvE
         a533LXmo2l12QNcnpJEU/6NC9EhtHrRA/KsfA0UPJ5xpBvXLX/k7+p+sSARYbjhYJDiO
         hiNQHSEZUzzJtgo+dJnYdToVry2kjkl0pctJ0LppUgaJNOJnZ5UFyaNYwuiIaXP+rZL/
         WND5DaYKZFJvfw3xIxyAvunJfTrR7J23vspbbKGyVYg8nWKgbQmzs6heaURcRgfkkuU9
         8mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778092730; x=1778697530;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5i73O2TeW40M4e0REO3mUO4IV+MciKckhAqv2Nzlgk=;
        b=g283FtWJ56MFj0ypNR1uJwCHhvQGpF63qfsof2ekE0BKBqTigw40skIt2RJQ6qjEHm
         nSvB9zPEg/rlyunz9nPcXxljd3MA2jZnMfaEij6RfuvLr9juWXDiroF5ZFTjY3H+gpOR
         ihD4qqlmJ8hzDXSJUogDATMbV0z4oS+FM+XfwgeprzFNVo4HOjLP0FVgh09+PASWPEsj
         9+miNYwU4x6hA3Xftm+NJJ+oefHYx4nIPsUWHYHgqk7FzgWK0mp0lTVsmUXg7Qq66ITk
         yr71rB60ldvaXhpPZlrmsza5zHUZuHqbvc2sI8LblP3Fkd/MjQ8wf4Bk/DrbQ1GikAzk
         e/jg==
X-Forwarded-Encrypted: i=1; AFNElJ/nBKZf/esRko57Q4bRD+sCoa9uEi52k4lll6wjWE8dg36RPJ/Y8hFCRg/16+BDg13Wzd52Q/QkXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7hdo4ZBjE71aAz8lOJlcHntqrTIEfF6ltf72lIH7PHrPOeMo
	U9Fju99anjQ8wVoZIpM50mASD32pc6OqPLYNVpgFgq2t2qzN+2RKTJ0P51LL6Om2skWzi0Obea/
	betTEdj9E6PHr5ILnBGc7ixj693I9dgZuIrdT4VXa5L6s38Bjjj312pey6C0D/A==
X-Gm-Gg: AeBDieu77dkKbxgoJDvFCrUn2yS3QdfSCjhTzKiw5VKCTLlmbMrQB2M1zQ+8Mi+A+fZ
	RUMgNVJX9djI5xOHGleoCciBQ8QEbkKWzFYb96JkZxEwA5v1/qzUO4DZAkvXnUFSqpXCWM4Y4Pc
	mF/MMSVNFn/H2fghOvwRX305wV1Qoe9Fk5ch7AuyOm2ZoExh6xdxWn3Bp9xWrVNwENefv8H/z5d
	HYmoCpqYAY0+sugxzwOxMJgJbzmEfd8afwsdG+Crw1VLCrkF7hHxxA6gZpQifu9g+uRhSE5IkZz
	jZYUH/6CLkdLg8E7R7LD3ni2ni6nYoC9jibnJydeFOa8goCvSgtB2iDN61yjTycxYO1zvXkK3Vv
	edTVM6Z2B69iG6Izj/PJabpcH9Bl0R+jHYC3XxQAL9ZzyPa6Coeanl6zpIqBDGi9ubzsJevxwca
	nrDOYlp4EjeSI=
X-Received: by 2002:a05:7300:818d:b0:2f2:5c68:5074 with SMTP id 5a478bee46e88-2f548e95c62mr2289988eec.13.1778092730193;
        Wed, 06 May 2026 11:38:50 -0700 (PDT)
X-Received: by 2002:a05:7300:818d:b0:2f2:5c68:5074 with SMTP id 5a478bee46e88-2f548e95c62mr2289970eec.13.1778092729569;
        Wed, 06 May 2026 11:38:49 -0700 (PDT)
Received: from hu-viveka-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd92780sm4958372eec.23.2026.05.06.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:38:49 -0700 (PDT)
From: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Subject: [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi
 SoC
Date: Wed, 06 May 2026 11:38:45 -0700
Message-Id: <20260506-icc-hawi-v4-0-35447fdc482b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWK+2kC/3XM0Q6CIBTG8VdpXIfjgCB21Xu0LuiAyZZSUlZzv
 nvo2vSibtg+dn7/gUTXeRfJbjOQzvU++tCmkW83BGvTnh31Nm3CGVdMAFCPSGvz9NQqi6BkpUs
 hSTq/dq7yrzl1OKZd+3gP3Xsu9zD9fiOCLZEeKKP5SeamdIUVGvchxuz2MBcMTZOlh0ytni8+Z
 2rlefIKK+d0YcBy+ceLtS9XXiSvJaBB4EaD/eHHcfwA0TyHfCcBAAA=
X-Change-ID: 20260311-icc-hawi-d6dc165f8935
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778092728; l=1559;
 i=vivek.aknurwar@oss.qualcomm.com; s=20260311; h=from:subject:message-id;
 bh=96jOQ38DKHlJwyQEUSdRWVCI2RgSf5udNbyTMFN2/pg=;
 b=sg4fhKMVcehnEw9zYXwuwp6i/tpPNQZfOAc55nKz+OfKKCSQqYA80uLGSRsnpCiSE7JbKwsQz
 viSptHDSwf5Dt6RDr3bJSihCTAuRPkOM6kJ7BGwo/Gc5dZJHbFzrBX2
X-Developer-Key: i=vivek.aknurwar@oss.qualcomm.com; a=ed25519;
 pk=WIVIbn3nJR9YRWNRyJiEbvpgoHhNyYrmVqMUXWqAIC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MiBTYWx0ZWRfX4FKHfGpsvLR5
 bqoltWbb2JfWtnOxJM4EnaKzpVklOCpG16/kOZN35JfqjSoOzqmFvH0cDHCPM2j8emUrYfC0r65
 UoVlpbn908Lb2X5ur01YtxQaeE+nMd4UcqAlfurR+X5oZwivLsKxSLcK1BNc+gpbZVGP0/eeWhl
 RFocuDJU4/B5ER3Yo/Z/leXsfXb3Jk22Ivw1YYpULqGMLSic3kbH+4lNuh22bwBALn0C0J4ZYB3
 cN/unUMmwu12DRCWVfZ1nGr7QD6pz7kQLSpwGmiVDH4FmquIrAWY3H9AOZr83plM2c5A3QUgVZd
 GMhqrqEzj2QSH6rOsgC7C/OTX4JgM3XU/1RuZm1LLRAjs3vuAW74TCsY/5TtOjv0xP/PbdsXVTf
 EW8tZxFdt3xsdQrCRfrvwi2efLe4WhycjFsIVnA4+ZMQ7HtBHv29YkFILIz1mAGnvMDTCxpJ+2y
 PsoyAQ/DFWGg7kEIpDQ==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fb8abb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZFe9A1L9f2-jg8me1oMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: qa73FiyMig5hvjrp6na1CzPhnJS1TWv9
X-Proofpoint-ORIG-GUID: qa73FiyMig5hvjrp6na1CzPhnJS1TWv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060182

Add interconnect bindings and RPMh-based interconnect
driver support for the upcoming Qualcomm Hawi SoC.

Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
---
Changes in v4:
- Address review comment by adding missing SLAVE_PCIE_1 node
  and corresponding PCIe path.
- Link to v3: https://lore.kernel.org/r/20260409-icc-hawi-v3-0-851cac12a81d@oss.qualcomm.com

Changes in v3:
- Fix alignment of macros in the binding header.
- Update binding header commit summary and description to mention
  Qualcomm SoC.
- Collected missing Reviewed-bys.
- Link to v2: https://lore.kernel.org/r/20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com

Changes in v2:
- Fix warning reported by dt_binding_check.
- Collected Acked-bys.
- Link to v1: https://lore.kernel.org/r/20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com

---
Vivek Aknurwar (2):
      dt-bindings: interconnect: qcom: document the RPMh NoC for Hawi SoC
      interconnect: qcom: add Hawi interconnect provider driver

 .../bindings/interconnect/qcom,hawi-rpmh.yaml      |  131 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/hawi.c                   | 2028 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,hawi-rpmh.h  |  165 ++
 5 files changed, 2335 insertions(+)
---
base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
change-id: 20260311-icc-hawi-d6dc165f8935

Best regards,
-- 
Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>

