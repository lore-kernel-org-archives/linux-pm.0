Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185502931C5
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206003; cv=none; b=s3b6hZg34gN1FyKjNVUMip8hMZRU5rpq5X+kHFgHHbpkYt408qiWzp1R8i+x11B63NbFKu3oucW6hvd87bsgNtwK+DgzTvbnG4F7tf/burDHDMwTcHXhdlPAazQcIcY2tDRqP1YDCiy3CqBKmMqByYao9pMC4YULsxPu21Ku3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206003; c=relaxed/simple;
	bh=Xb4UtLXs0mY4oYtWeaUlWcMDj3TO8AQU0JTTDu1tU1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R349Bhctt9EHiIaOU3g9jg5Ue6ITS4h4c+d05gSVXH02LeQdd4gYEC9r8RWRvUbpjkIKVU2Gq3QACDmaXXXJkci2RFsuCq3nWuMBDHfKlzxN9qNwW+oRrUmuyDQIrEYkYWAPFjnefTnF2qh80wL+x6LU4jdkf8QHK7tEF1d8AvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bl9KMvIZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LfkFRDC8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bl9KMvIZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LfkFRDC8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiOIa2518316
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0PjP79q3s+ptBA1TNA/wMMy2FKxZZvdgtZi
	oY7TXIFA=; b=Bl9KMvIZ8VetlpS7N0qpux8TqdeFYagH5584HTBM6ANLQxMH5TT
	AGJ5kBzxH2ZgSf0HKfIA2g8V/kyrLlN3a3ahFp5qZmFDi4KIA3DVHIa+B19FwSIb
	q4lCYRogsFmJOBfgYaA1qF0Aeqfo/TxMq6Ho3HUsH3YJK3kPgOCvqhZKlm0UHSgx
	nqqQBjUt5NP+FMOHVMy8IWL16I4QP3VvJYp2S0QTndVZR8F7BlDZopAaZbhMS2v7
	Xg11D+PaNsLLMN38hOJyigZRX4mIxqFLpHASvBfVDhkqbmUUs3CdKWRtLgQYgRop
	CoMM2m1h6PWrJZ7w5EwWBl9D1aL2k5S4RTQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv0u4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:46:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c19493ac2so115073091cf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784205999; x=1784810799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PjP79q3s+ptBA1TNA/wMMy2FKxZZvdgtZioY7TXIFA=;
        b=LfkFRDC8f6SFbj8oP1AwrcM2VvZhtmOZfPRCscIY2rGQhTGg7lSx1q1yat675TcG+E
         47joo94/TYM9WdMztES+Hn9oWIYX2p7dNj5Q9DPHz3ZNXfpg/3dTrN9RYRxfu93tJXl3
         N7npIBCn+jZ8p/xI4+uDyfklTQEWBxQ6hdgyvgj8l4PdsFJJxnNkaiTju7MB9pwmrNpp
         v84u4L3HJrPL/4Tr7RjctnCzzzeTUX2NqkTTtxt6npJkOVJTUnRNDkVNqo7WvXM5FU/S
         1AJDcqGl5xeogL822wX7Vjw60J/OegO7BMgEo/J5uabC105X3ZxbHRPu+FTlGE329B3K
         TbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205999; x=1784810799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PjP79q3s+ptBA1TNA/wMMy2FKxZZvdgtZioY7TXIFA=;
        b=kKhuFkv+8p5/i6o0iZ4z0n0V2ztwkE4niKO4EPsxG81Zx2UG7Ot0plyv9bKlv5Vw4A
         NpFs66uZ52dzNt1SLxaUei8GbhcXp24sPBjkRhH5ffv1i19C01WqMFWYMzSg4sRqRyZO
         htPwKMpvPtFk6EOZHxVQo00HIKZFnHfKibmJxp9wiHSuYeMQy4PCxljPuT0fVAMmt6eU
         RBnenlejdnLtaKnI6KNQ4Tqsk64RJXdSfjvm7Ds9fmjFeL4hwZu8MVtgNwpSbs8ZRnq3
         GpHhMu6GhIvRstEdGaVDtdEp1lemLgX16gtozd1LeotDFzqFNCs0otCj+YBKr6K9G4Db
         pVEA==
X-Forwarded-Encrypted: i=1; AHgh+RpK1yGhigxSFbnaKTz1q5SnCKeH1lOi0Zl4LQaNhFR7Ug0jNRncWicZpbpJyIWQJ23+dn5ZPFHFfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtTnoqGXBv3BlCW2ifq+Gk+MwGeS0bwf5Z+dkSqy41tEKZ2H2
	mUs1+72roj3J2OPV1Px/7we632Q5642quVNfaO3Q1LcyrX76Im2vzYA+GegeF34UUjK/sD/BqM7
	BUCrjYfrVljC/TAcZJfzUYpZT7It+5L7Nxk/yRL8QF1tLL4Pc93OXzOBP1MsApA==
X-Gm-Gg: AfdE7cncTxHWxNgqervHj6qmJfhlkILalJVFNs3FptjTcua5FqvnRPB9Vsz4hCU1el+
	9PyuIdC+TcnAPLAAhwI6NosCEvvAU0W7fPhv6iypbpGVDGZOySmwMBZ5yMyLa1KRtiPF64iNQJj
	BO86c64+xVIOAXLzcLixbGY65KMgGDtDhi3s0FUMFYpr/5EWXFWee4nDqrCvWa4Fz6ZBvy51X3b
	bM2OBOEyY3hk/ZgHfv8+akDeNMvCs8m2O40d2HWsw+joAaIwQ6KRG1RKhBIEiBP1Q6ZjhPwrdCI
	1fnazsKpczLywsZyg6y9g+n3TL7icWZ9BxVOIyyfB9x/HKkO3ioUi6nB7D4SjrtYj0v+uJ8zPGr
	5RcKl0FX8WSlW1Xa0WgfArMRipLI20DIPlUeK0kCXNg9iH34WZfkSHNgIOw==
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr112099011cf.65.1784205999104;
        Thu, 16 Jul 2026 05:46:39 -0700 (PDT)
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr112098701cf.65.1784205998665;
        Thu, 16 Jul 2026 05:46:38 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b9382esm44428681fa.29.2026.07.16.05.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:46:37 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.2-rc4
Date: Thu, 16 Jul 2026 14:46:35 +0200
Message-ID: <20260716124635.45302-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX6Lb3+1/ozn+k
 /Bbv1pBjqCau0WVcQpVApricvo5DGgUBK0IgD3IhL/dso0n5Lk15OyCpVC8/7V9qfQ/90HeKbr4
 3882zsjDpLn+4y90Q9Wmg+/3K1Roks8aJ+u7E+xn/16Qz1Wow0XyhG3KRK+s+agw3/iDlmdCBrH
 7axf7vnOTtq/ZjsBCk3GjhhUz4Vbn6cDyBXulJ0ljjIFFqmSNyQDICAwMtPrvf2EkEr/z2WoL/+
 urU7/ZE1yseI/Azw2uylni5C/SgCCsldQ7RxP4YR9KiFfg6VChjE/Aq3h/FQ6TNpb8O0FSIBZnI
 MNC9OGSw+buIlgDeLDkD9WdzH17biwMN/j0zCYkAPKsXer1Lp9ZN/eiYb+tliiTyJ1hy6Iag2mU
 jTVHN1xCNVqekep2iSeyJgN++bMmnjeG3ocxKFE/a5v2FRpGTaTmJdLdG6RcpA9WH8dqo6uVzp4
 1Sk6LKF37N+6AcIzf9g==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a58d2b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=Yz0eIgJFi14MpISRoE8A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 2fVIuQir866Ulnmx7Be-IVZsHet3eIZf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX0IaeHa4dEPsI
 M6kmYnY1O6hf1LUtimPljyKEY5YP+fGsTXpumXnvOwsigEF9dt2A0RFXmfbmNhEvYYQscpOGZm8
 hf79YngTvO4ULFMiFZ7n3V/aU61NwOw=
X-Proofpoint-ORIG-GUID: 2fVIuQir866Ulnmx7Be-IVZsHet3eIZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160131

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.2-rc4.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2-rc2

for you to fetch changes up to a4876f11aa1d076802676e23f8af500706e780e3:

  pmdomain: mediatek: Fix possible nullptr KP in HWV cleanup/on-check (2026-07-13 12:42:17 +0200)

----------------------------------------------------------------
pmdomain providers:
 - imx: Assign child domains for imx93 to prevent power off when in use
 - imx: Fix i.MX8MP power up sequences
 - mediatek: Fix possible nullptr in HWV cleanup/on-check

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      pmdomain: mediatek: Fix possible nullptr KP in HWV cleanup/on-check

Guoniu Zhou (2):
      dt-bindings: power: imx93: Add MIPI PHY power domain
      pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI

Peng Fan (2):
      pmdomain: imx: Fix i.MX8MP power notifier
      pmdomain: imx: Fix i.MX8MP VC8000E power up sequence

 drivers/pmdomain/imx/imx8m-blk-ctrl.c       | 46 +++++++++++++++++++++-
 drivers/pmdomain/imx/imx93-blk-ctrl.c       | 60 ++++++++++++++++++++++++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.c  | 40 +++++++++++++++----
 include/dt-bindings/power/fsl,imx93-power.h |  1 +
 4 files changed, 136 insertions(+), 11 deletions(-)
