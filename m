Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D043F8AC
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609683; cv=none; b=sjhp2BSrvlebmn0q2Cpkb5QCR69rft69wQycmjj/qqIlKvLB6//9IQ8vmwrTEqlOkQlghu/VAT29ADhoh7hCoDXZvorG+fQACqibT5fy4i7go5upDXqomz8pR0tIf0wjMruvVua3kf4HX5pzltjE16nBphkWvufzclWMlSjZ3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609683; c=relaxed/simple;
	bh=omb0xxX9WWWs0Tp37sybHqKwIpNthJSWcqJT50/slac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksdcApEE4EFL/kuiIXlftzsk8j90/oahowaGF2eZ3Vdy9I4hqerYtQYlctIqp2VHgaHQzxtxxGw4ZCp/e9qpHRgKzFyMFElH6eym7rwEf34d1legCqtQEFba6cB+1c4HzVuswX2q3OcG6wopX3OY8usO+VlEqmoC1WRxOusi66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEaHdvV2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VidjVvV0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEaHdvV2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VidjVvV0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D5h2km2189882
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 08:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7wAEgT3K5zweQK1mqn7wjCd1TULWdjYn6Oo
	Pqf4yhUQ=; b=bEaHdvV2eKvR3fyUTVNecKj8ir0npzHAZfXnY2hXrMCYuGGkEfJ
	7BO7L6URvZzJp/nUpCyDxH+MVS0fnkTL4ba0TW0WoKzq0kjwRNUCZLhLbGWufW3X
	xsfEgVzcacd/sRAoOOf81tZxJVy1xZcZuZ9NOauBTwZ4hD5IT/PY/JnYSGOSqM26
	QN8Yv2soCCp/4NWZyA0F4G76FD9OtMYEB04wJj+PcGbFK+IbnbRZHNsMelKNNEtc
	COptYzHDuAz7Q/eVo32kck2tNgewP4MpB1hgdAoxWClOFhezokDRfRp7CeDJ+z11
	rEmgnvC1mBoLBGFpyJhhwb28K/3I5mNCy5A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18180mk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 08:28:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c26012cd0so3865801cf.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786609680; x=1787214480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wAEgT3K5zweQK1mqn7wjCd1TULWdjYn6OoPqf4yhUQ=;
        b=VidjVvV0O77xgaivDpshYppVLunUY+uP5CNuhRCJfOrkNlsArrKMiqrrfnY3SSb5hR
         W8kdoOdPGgfh8LgGCp5sXKaJ/KlzxNB8oQBGznxEDQciY48/SsHxb6uxEZoV4qhJyKxy
         3igH6ucxFGtp5SL7wRDT9kbdzrkx+jgBwYTuTaVwznCkIJ/STaxBn77Hl1KymHKCRLcK
         dtB1RrIAKQdCa1lpUxS7jxoBS0h1N8muyDjWnZsxBLfkcey7zGDEZ14d/1mjVA5Cj3rH
         OuQsbtl6CqenJ+Lxn2H1uPmZ7Qi+IxV1OxKvXNa7Qc47xeD5/rU4/nep2V1s8G8lXmqU
         +T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609680; x=1787214480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wAEgT3K5zweQK1mqn7wjCd1TULWdjYn6OoPqf4yhUQ=;
        b=gA45c1wUsa/5WytIaMXOCdbdt743yVxDE5nD58c5sQYJ1QXvpPIKAsvvtoph/k5yNm
         0IRwgJ3GKAeTjF2BtMKvflT9aGzfEf/XIsAXnbaWE3XFb+qmjHWkA9um8x+hzfhCOjsM
         FuEoYzbgNphX2iZLvi/I1S2s87kjpV8kJ5DN1pDSvq4zCW1Lv53feNQd4z2JGA9J+TQE
         DDRSCwt9qpXEbli3aNOo9VQa9f0fsZuBwsjwVz4/wJK34/uYu8kS0QH0EpP9/bbcux6D
         L7LdnopArxao4qrMEX0FtEnyEGsE6xQad9HkOjala05ajaTCzUHCIUW4fjYCsiEhT7hk
         qOzg==
X-Gm-Message-State: AOJu0YzmSVV5kUedISMjf742c+DcmWmV8QARuGNsHP9vTVtOOBGpXrvS
	m7MICEZB3e537HtSpQ3eR4WUY4MwIf5Jg8ffm+1yGeQDkHW0r1n+IIcQYBQWiUyvJOUj7MxYYTW
	2V2ZGZfSZaA9/AZste+83p78t3w/HaamUUD8IVqiVaXMC/2ZBcRFqu9t+UtVpqA==
X-Gm-Gg: AR+sD10/Sq1Vg96Zm+e5O7QnSz/zEdEfQsWFsHKQTGXdLkzFWmNiGYOnhvYDo14dWta
	2yHgx381daLbaxG/9+7gn5sOHGBa3Y+Y+qFDMLwO90tgCq5GAp1UZyjYZ8+5/eqRxIuzockzlYs
	py2+28oCwjvvOa4rgTKzRQfzFxuFy/J95i1VBnodzA4+aK8x1eBHCthNvQ/92ndFBASkEZJmoV3
	o8IdiyMVbo9TY3+dg0unC0dHGV4X1pveSe1yAcFOB3AMCHypSg6FHzFOGyDb8Fvj/L1RAMAQPWi
	DzTgcttbfw6e6Os9uLJ3aVh4GhE2d6Gyq6L9wKAO3zZfeejSPCZQ95+iD7wt2nBqQVSiTcikStr
	YazjuQkjPE6lHEvjvpVE3pBpbew82j6zbgveZfg==
X-Received: by 2002:a05:622a:1f15:b0:528:17d9:2d99 with SMTP id d75a77b69052e-52d73e65f7cmr42959221cf.43.1786609679863;
        Thu, 13 Aug 2026 01:27:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1f15:b0:528:17d9:2d99 with SMTP id d75a77b69052e-52d73e65f7cmr42958871cf.43.1786609679342;
        Thu, 13 Aug 2026 01:27:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:dc:7e00:4b5d:4abc:49d7:be98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981abd6desm52994825e9.0.2026.08.13.01.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:27:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing updates for v7.3-rc1
Date: Thu, 13 Aug 2026 10:27:54 +0200
Message-ID: <20260813082754.9972-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX1dTDmf/B93vv
 PXx8tsDy1YuZ1HsTlJlBAyQDnY4SvGqvH+So03zH9nyzY4riga4Q5eBjHZl2laT66Ocx5bL5Yo1
 uo5marDO92y3feG4+gIRoNPCDWfvnT8=
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a7d8010 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=7UpAPEAdvOdibW3UFE4A:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: VkqiFf8uBvwB_y5pEgVh_wnos-31mRoc
X-Proofpoint-ORIG-GUID: VkqiFf8uBvwB_y5pEgVh_wnos-31mRoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfXwM7z2s/FGAjU
 DQ5LZsEg58NYp4RhFYKiUXy/MnzmU6M4XmxyeJvxhWm5x8q4pumKUw7FBoKFFbAKpzrlcmyow1t
 zpU3Ga5DxglX7FGKdLjZChWS9oD0X5mBjx+JvRNL93/k3Zk86KOU7RWN3mnVYaiY0QeCH5V/V/H
 rFlsKiC+zUUuzYK2lQf50N5+KnVRER1E+Rx7W0e/PRNyPFo0WhVElFtcc+Y432pxlzNNfPP1jdK
 5l+COfqrIP8vdPBlGPd6quC4yuHNoLYiUnKaea9/VVtsub7yn+R/7eHT0JyOrjM2E0uPvo3I20h
 +PND4ahgvtnA8grRY0hggAwYPI+98xUadxDQQqh/38eUmfYl8Dnd4oYBY9SzU7MF7wSYX5fVXDn
 hWIpptuSh2+grStY0vm0fjc8ZpQ1TVSQT7WRXcOw5M8czVwDiOo5noHg6YE+no8PY/ej2rmvPip
 KjHe1LVor5/xrx5/gTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130058

Linus,

This is a very tiny PR for v7.3 from the power sequencing tree. It only
contains a handful of updates to the pwrseq-pcie-m2 driver. I'm sending it
early as I'll be mostly OoO until September.

I expect to send out a second PR later into the cycle with a single commit
renaming two pwrseq functions treewide but I want to make sure I don't
accidentally conflict with anyone who may be using pwrseq elsewhere.

Thanks,
Bartosz

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.3-rc1

for you to fetch changes up to a39ac4651e3b9d2ca78b6d3dc2a81a6bd25fa616:

  power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID (2026-07-24 14:36:39 +0200)

----------------------------------------------------------------
power sequencing updates for v7.3-rc1

- add support for new devices to pwrseq-pcie-m2
- make device matching more fine-grained for cases where the same combo
  chips are wired differently on the M.2 card (and - for instance - don't
  require serial device creation because they expose BT over USB) in
  pwrseq-pcie-m2

----------------------------------------------------------------
Bartosz Golaszewski (1):
      Merge tag 'v7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into pwrseq/for-next

Loic Poulain (1):
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID

Sherry Sun (1):
      power: sequencing: pcie-m2: Add PCI ID for NXP 88W9098 and AW693 Bluetooth

Wei Deng (1):
      power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID

 drivers/power/sequencing/pwrseq-pcie-m2.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
