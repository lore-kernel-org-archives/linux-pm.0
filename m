Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863C2BEFED
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471814; cv=none; b=SeVIgfW6feOKu2js2/Dl8xot01dQIZV//WnX0d9CsxpJDBj/rHWf0P/aZs63GdLkmjCQN2p0m/Pm8Sh7ElqrZ5axUBfTSfKuN9LaK/FV5qupvkS1OM3vNwK5woKUwOLCPZxEJDfUlX/8n1iWxyvqwFjLepf06chqBcuaQQGC+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471814; c=relaxed/simple;
	bh=UR2GNZzYk2T/Xx8WSgpWlEZS4x3FLBu7HRA8GCFdqEA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CK9S2xVaG+KB0H2FKUkYm23KT9jFUuizxzH83bHq+P4Ke4UQizcRiJjAH0O/AWAAlT8vbVesrNDuYqHJKN5jNBDZaAaxOLgsd9fqHOtijeCWeK+JxR7fKl6qVti159JQGB61SO370e3oeIkYSGoY+KoerKGzyPG9gF16fv2n+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwJupxRg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L78KpapD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwJupxRg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L78KpapD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ppf13752485
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cfUbqW3/7ZCsQRX+rilXrd
	6uWuepNjMmvDVbiiMvpPk=; b=iwJupxRgFzM3W9GgTgkn6OtT74IWuLjCfn0BtG
	V33Y05oodXq+g2k+fb1oNtZxuogEYjjlLgyykjacDZSWYzs91u64poeA52pydtxx
	lfVybZHhAUy7I9Ul4WdlGgJI6ZRfvVeR5RfveWNAm0xWO3TvP1NkmRJSZxc0XRmQ
	4vHdHPrT/ZYm7/+gtqhlT7X9SnA3CGuwRyAL6MNtkAqsloEa27P8An6frVZAeeJQ
	vWt6HUrQRKF6uW9Wz/O5/+mEemFNCZXq5n5pe7iH8Pvre1/PiKrTHO7w+9U7bl/x
	RRDm7S2DDUD9Se0cLefxkhVG8srIP9uxeHmsiL4N5fbp2k4A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1hug3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:08 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64956932a51so17668041d50.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471808; x=1778076608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfUbqW3/7ZCsQRX+rilXrd6uWuepNjMmvDVbiiMvpPk=;
        b=L78KpapDlH+uWacy7uqsbnUW3/FxIV4+cpf9ECFWv3WB2QlDp86dC/IVrFs/bCv2At
         VH1FDnCmaz/5ZfkVIlTRkqJ79H5wTipw6qZlmyZ2CW0V3VBxLbuGsa11zIMbsUFsb3tX
         vLN0yTwAXU8TeZAkdqllYAAoWDXCH54rSo/5zAIo4phpG4RbyBtjb4qWfZNodCh97Bqf
         p8mXktyuf/vcZ/wtF9AbRk0rzkRx0xTT4vYS4nm30iHfd4JJGP9rnonJqbd6hFSe/u+s
         ZXFbxbhIVhmwzCe1FcZOI0dt+7MtQFINTb3YPLVaFHAmSkBGEfQPHA3EeSKfURLTFl6e
         zKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471808; x=1778076608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfUbqW3/7ZCsQRX+rilXrd6uWuepNjMmvDVbiiMvpPk=;
        b=gWfmFfnY9H2NttNYAHhPvg4WPOUwLWsNSzh5tnszNXqk5pS9FtpO8H2TIDfXxR9M4i
         Af5jU1Xpseud06PuLU4/42MVEdA7xsUAykz/KDXsj+Kxzx9ckAT4EaOTiFpRNAlcB8bh
         G7ibCBT9MhK7KHqQUHYO8L92l9MBnFHawRcS0n8l0BZC0yedRfCovkvDsaYVnmwtbKYp
         aS8rrkqYwOHOAOUPMBBAAU9vt59H0zWKmrxi3I7TmTIC8XUWNEBVRK+4fMTL5fW5qWNg
         tZFY1sVd986KQEmNMERPr6awCyi6TsLt5I+jJAAPrkD9ot1lzHEyvvvwa9swH+SKtOrF
         8Caw==
X-Forwarded-Encrypted: i=1; AFNElJ/FLZyDTIlMk/DNscrnDmlQkLQDiSUtAx555eYgQtuKGvw1/H543cwsW+lw3VVNkaJryH+5m9eYZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYnjL2eKvkRQbt7QjtgKKiCUR2Jumy5As3D7F02mmN1rNf0u5U
	J+FX9g+Rz9MSCzU/tkKGRjnZUwdV3wTOM1+MluCZrxGp5Wr5Q39TAJnx/qXbcgPQTSL+PiQwZyf
	EtSqYTYoxV5mKuNYwRqb1qouKs3dBuFcLYDsukGqjdt9kk2l1u/kLlS+8GvJC
X-Gm-Gg: AeBDieuKnzC4oZCsk9SxBuGlsXPbuY1j8DPkOtcXV7a62v/5+HR5yyzaJKzcvCI+Mzz
	NPmhWRoNp7sBHU/CGj38XimcKqtZbDTqfCYDoYcX14gZbvfj1xITyIZJgo/CyKQ9ZtteVp+oKix
	tGAVgG5pZ99PxlUPA/DZgpbmgVQhrnVVNCvKkjvyDWtu0T9WLU2IenWyKhsc0iLFv3xfd6J5iuH
	2hIlNtrdKE0rZ4z2Il3bEw2SlxduSUcYy+gA6WRJ/8JnX7CX30Qx06UScw/uSPJalmrLGDDKj6e
	0Plas/yB+ihn8mMKauS8yncF7x0KfCHL9kuHDVFA/TwqVMsFLp2yzbB+PQi7Ga4VWwG/L6pi6gv
	GS/kBSvS19Zzv4tnZZouVIk7L39NDUH012hbHjxcY0DFItNMSFnBMLeyRvr033w==
X-Received: by 2002:a05:690e:4841:b0:653:61a:2cd with SMTP id 956f58d0204a3-65bfb5f1d20mr3421499d50.16.1777471808207;
        Wed, 29 Apr 2026 07:10:08 -0700 (PDT)
X-Received: by 2002:a05:690e:4841:b0:653:61a:2cd with SMTP id 956f58d0204a3-65bfb5f1d20mr3421455d50.16.1777471807752;
        Wed, 29 Apr 2026 07:10:07 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff7ce720sm1286731d50.21.2026.04.29.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:10:07 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH 0/2] power: qcom,rpmpd: Add support for Shikra
Date: Wed, 29 Apr 2026 19:39:55 +0530
Message-Id: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMR8mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNL3cSUlPiigtyClPjijMzsokTdNFNzC3PjJKO0RPNkJaC2gqLUtMw
 KsJHRsbW1AIPyDG5iAAAA
X-Change-ID: 20260429-add_rpmpd_shikra-f57873b2fa7c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777471803; l=643;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=UR2GNZzYk2T/Xx8WSgpWlEZS4x3FLBu7HRA8GCFdqEA=;
 b=QC0TFLRbV6TUimG8J52sfoFg5Chz3LuycquIGqUzRedPuKXO7820cBx9z6ySXgwbGBh7WCFpo
 GQYFLhWseDfBYhBxQMBGRQy6GMpgirSX8L+8Zjrvex89YNWnXrulOaT
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f21140 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=w8gYdMrFLoSuhkYnXDgA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX7Wo9+s71Ceu0
 /USsQTjyFAj5rcziXQR21UdnKE89BVC5f+/uSa2wyJ0miETxQ72p30hkq6rKYmP3N54lULBngAn
 CnN+DXi2G1q0eNX1YYaHv1de63eExTxNrj/xjzjvxkmy09vJCEbXyUYwnnlh+ejErTy2n0F2P5d
 Ef1MbTNcfe00R2509Grs/a7A4bIzzeDTVPv0UBZj9eoyMFtUq3/WlqgG8zmBPfrKK2DLzN02+eQ
 iKigdNfHQ347Npn/GbgQsu/A8j0ZPZp0rYxW6kKkzsSn1xXgIy4Vk6eNYx90FDy+/Q0VJBpMdHT
 BltKdpZETbE6yN7Nbcu0BEbUWlylQDoOsBMk7i7PEYdbkxguWZglTMezEgIAhtzx71Z6YBj9v3L
 zbb+3LH7HlE9lE11FdtDRhhZtbPFlB/mOHHI41TQc4dFIL6SNXQfrzOQjkidodcgN6+rP6VUhY1
 ZNQWDa/NfEduOlWM/ag==
X-Proofpoint-GUID: 12tg1GCXrXKWvoS377mrSqDN3aOL7BlU
X-Proofpoint-ORIG-GUID: 12tg1GCXrXKWvoS377mrSqDN3aOL7BlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290142

Add rpmpd support for shikra Platform including RPM power domains.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Rakesh Kota (2):
      dt-bindings: power: qcom,rpmpd: document the Shikra RPM Power Domains
      soc: qcom: rpmpd: Add Shikra RPM Power Domains

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmpd.c                           | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260429-add_rpmpd_shikra-f57873b2fa7c

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>

