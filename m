Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ECC368D79
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175962; cv=none; b=TAwI3PVweM7wPcYzsSG65A0S2f2pBUHeXbJQ0y2tN5tuhYfG1NkHch+dsvszPb/Qhyy/jWta9uD9rffvxvtimR2i3ZLXWgYlG4NEgVMMxIHKIiQqTOm/2Kyfoe1yMy0jgA74r1tO9FzV4oFBoooQET7BZMsBf+jd05AcWhLS7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175962; c=relaxed/simple;
	bh=e/2IWJXQ4pXtFhb2UBpCb1MnwDLIjq7V5YDi4OiUeSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDwu9/pyAbY0mK2CU17seM9X4JH4J2sMDeaxwHIHAaS5ZBFascSjMKQz3lMqXdrPhyQ+gITFxNFWXJuLEtZYTODsjsLf6EYOtvgsP6/fy6n3dbAdmD1pseldQw4YXlFuXV8eH/ix20trjX0uDt4eZzlh+BJGrF5MAmuUWxSkDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0dYYf+n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=geimCA2Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0dYYf+n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="geimCA2Y"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA10JE299632
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 11:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=J231KC1aQjcmbD3JTm3vSADLUXjToGVijXU
	/j/EQC4Y=; b=O0dYYf+nBPnmVAdfVjkHTGXsA8uXijN6gEWkH3BGAgzrwhl/fQW
	WZImp7ezDN5r+ULQKDP3zPvoVcpdhjmmAg8PDNoe79UMR/rUgpMCgHwAVbRv+F19
	c3RGNupYCB3nNTr0Mn51+514deEeJv/DI4/kTwGzr1NBGge8plP4zxAwAEVTOdw1
	AsaGdL+gdEWlfVJ8acnBb2u6gL01G7IU6fkNRQjhn1ozZ/b7fkCCNIlFMucWrKET
	a6AcE4ZY5jfw9AQNqOvMao5c6PjWLfp+94hxdiRUDW3XO0yxEbGM/bCdRHQ5/Riz
	dL35Y3D1sooqQZCa464zWQD8kYjpiCBjMPg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe7031v5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 11:06:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6751c50552dso863122137.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781175960; x=1781780760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J231KC1aQjcmbD3JTm3vSADLUXjToGVijXU/j/EQC4Y=;
        b=geimCA2YdqqHw0iM7K+q3x+VPNm/A6OAMPUlDYvWUScsW48rmNt5hfEZsynAsRYzmo
         6ZIYt5/ppHNXHwk8eUFVeVfXoOdD+qzxwqtw6UQM8Y/IWuqEv0/kNZpAMm/pzEaf9OUJ
         8s/myiksXV4SObQXd6EPKPtJpNn5AId53jf41XM4hacFApeZGxOEHceuC2iSFPyQxn9G
         9WBistDPM45dEexTRVJy5u0HbvHakE3Hly1er1pULPDdh6yI9ewUr0H0Ls5VfhBgypDb
         rsGjB4sRV6r3UDdmemWooPiTxYz5rS/m2SlNA8DLnO4DAviskrbHSGbspGbyfanZ1GQB
         lVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175960; x=1781780760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J231KC1aQjcmbD3JTm3vSADLUXjToGVijXU/j/EQC4Y=;
        b=iX/rM/Le6ZaWrcpf7zhtqfTKCfCVUz5BQmmNJ9f7mkk7DknGbqwFVVCaCbNjd1bcST
         BeYMyJfv6z5wAzEaCut/A7tsp40vB1HAfKyJdGn+tYNIBna1TBaAG3YhVXnAjX0KuL1e
         iOwiNqEZsn7uWDKJ9UtoueQVyPgYzF4rN5gTUbCEzMsPRIACwtKNORrXIq6e7K3yJFVw
         w++ZVphZF24HzMkiF6FWOrZ8naaw/S+4aGjovYgdZs+DoHEnC4mEX6rX+XvNNmdJlanA
         42w+FuEZtxK6pmohJ4fidMppjPgmWU8hzd/UzeWMViQ4B1W3nPvJVb3MwPITZAz7M9md
         R3xQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Fkhnsl0U6rwxK9IDYYR/JFiYwzDbT31xlLj6nrQ9kRfQCOTIBjOs0djJN17IPMC/P8Y+hQ6H8wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw08h/vaSsAvz3KpbQUnpk6Jtie0zoVSwNErFQ9/JDrtQaeKMa
	uxvYeq2I9bUvve0iyumD01Y6UYdo7n6gmaYTzZRmHv7N9H/XGS8JKAheyXVgjtpW1fBWm4kl0Kj
	Au7BkBFUD1vZv0wmaurKQBZQJDSN0C2fMNCUSw+US43MzlG8nEohMsTxBpt0DyQ==
X-Gm-Gg: Acq92OHBCxfWZR7PjwixU9QhjFXlWECoDb65+iye8pOIL3skMcqB4e19uvwCVR8xs1M
	IyyLFBR08ASiHNL7zATG0As2A9FILogOGAQymzkwmFVxekDgQb4ObgWa7KSuDMmM4nvg89LjfkM
	Jwxdvd3ZqieUGu0q6IVFcLjfaBNB1Ig1hKMzviY0sfsFU/v3dZpydcpOWmJqkRBtjwMqBKU1Cia
	PzFKqRqKweiUf5pZi54DAcM4mUoQXiNaQ56zTEHO7gKsdbeXxMKXkkifjEBFOgtNIV5gUz3QIiv
	yZqs6HiHxlMUm+4yRIGUrqLueGeEOgkXTV7mCVWBEE+TClEGp38fmN5O7PO5N8Zz8erGmfSvrLO
	AW0WdrgHNyIhXxaTxaZnX0MaCtm3LYBhSepnEAMD1YvcJsZRSOFzj1O+dwaYiW9PIKW/QRFteAr
	4J6YVMextdvwFGKg==
X-Received: by 2002:a05:6102:374c:b0:62f:39a9:ae67 with SMTP id ada2fe7eead31-71d5ebb6737mr666492137.17.1781175959853;
        Thu, 11 Jun 2026 04:05:59 -0700 (PDT)
X-Received: by 2002:a05:6102:374c:b0:62f:39a9:ae67 with SMTP id ada2fe7eead31-71d5ebb6737mr666441137.17.1781175959414;
        Thu, 11 Jun 2026 04:05:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991ad92752sm3687631fa.30.2026.06.11.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:05:58 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.1-rc8
Date: Thu, 11 Jun 2026 13:05:57 +0200
Message-ID: <20260611110557.120619-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nFJI5cNeaFFaAK5KaTFG3FsmMAzqjqiC
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a9698 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=TUf28JeNPSodCt3kalAA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMSBTYWx0ZWRfX+e7QtHWZfF1V
 QUZ9M2rmfItl4EjgtZ2sPBUwIIROA4Ykrn9d9C1SKwBDq6rRSo5YUShybIbN8MK3cLCbuzBY3tR
 EAxzd8QvDXZ6sm2wDludTxxC8orDOa5VYOEvZm2hA/qlXrgYtR8TpA+Mco531rY7WYGbzwKAQ68
 FSQHyxCi/jvERkhCPeNc2WijEnp7t/nH1e4qJky2t9GnBtuYjFNbdLNRdJ7bWzk3rvOATerYaPN
 Rhd2vzK7F4YJvMPaYMwsQQOJogftYlBF5XOHv+jC/emD0nOpxyHpAjhWCwiIQAgPNayPyZ9szym
 kQnH3eZ6UZNLY7dS7gdlhZSd0OKCHQhPDxxWbE3TvP+ZaZUaxbkZDa0xj9Mu3fz7GgGhUobE+jC
 hTq2DyRXMwS4JwPu/udsfc2NWIlQMbVnHyQvSWw0JJCXO2oVgE2XGyO8HQCtb38AHZML45Pa6MP
 uXsC2N5kASY7DO8vGUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMSBTYWx0ZWRfX74oPR8xb8zIi
 7vUE6o9NJnp7IoS7sM1WfTU2O9y1IsCC/7scf++CoPn1wbzEzBZGC6vfgDrKMKmc5ve9l0tBPbY
 GQ6oNdDaeLZUd68GJ6kwEiQ4BE7DdFk=
X-Proofpoint-ORIG-GUID: nFJI5cNeaFFaAK5KaTFG3FsmMAzqjqiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110111

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.1-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1-rc3

for you to fetch changes up to fba0510cd62666951dcc0221527edc0c47ae6599:

  pmdomain: imx: fix OF node refcount (2026-06-03 11:49:37 +0200)

----------------------------------------------------------------
pmdomain providers:
 - imx: Fix OF node refcount
 - ti: Fix wakeup configuration for parent devices of wakeup sources

----------------------------------------------------------------
Bartosz Golaszewski (1):
      pmdomain: imx: fix OF node refcount

Kendall Willis (1):
      pmdomain: ti_sci: add wakeup constraint to parent devices of wakeup source

 drivers/pmdomain/imx/gpc.c              | 2 +-
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
