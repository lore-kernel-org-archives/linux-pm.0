Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAB4D98EF
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546820; cv=none; b=ZNzIpA2YLXiKfYcktYYeIN8zY04r+EAmwuZlHrPJCugtK3cF6Kd4AkbtW+9+gdTzHLWKAvE8CvSxvleCIRQYtprCPge7bmGp9dz8Y2cbSuCJqx7gDslw7pPlGHLL4rSE2OxmEUcN0hvlkvogFrBpBN4KRhtpPLVV1RvifcEMI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546820; c=relaxed/simple;
	bh=Bjyl2X+mH6fIScoNVkJMiXDTc0kRmUoqxKGF9RTavgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8mRvaal4wUZM4m+LrsKinGAPPrEc9x4z5AFT1TY6Za32Fi6L/S/zN+dwYYMJkrpS2FZ1+xz3Dq+Phbu9pPgjq4BFlTbClvJbdy1BF4Gfx565Hk+hISai9S8/ZG5NZvWajemCiWRCBK/rSlG+BNYhYftKz3x+5/eMX+8PVmAAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NF/0yA8y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4eEWKem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NF/0yA8y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4eEWKem"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699BdCiW1687114
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 11:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=reZfXbmp6yLaHEWG8SUuHXTDZSJLk3XotPV
	TKdZ5Mp0=; b=NF/0yA8y72lafuLfRe+aIJVxJwV4iHDwA6XshihHLm0Gfa7fda2
	gHhAthPpb2hG0jsu5b8t7N17UAD79tgft/5qU5A7//1cNGEpXF1syQeQfxk2Bk7i
	G5yoRU53qSynPSQ1aIy8LhNCOjBq7HWgmtNrQRkQtOSZebd9qGkqmaXrYmShCZM6
	KFXofxPNzKHLM8HXneo6uSCg5wFkiTR4/Jb5Rac+DVxyssj/40rJASnA8no/tRyi
	wa5bENRBdOclPa1lTBVbJS6bRIEYb22lHkdM9N4h4jDS4Vpi+JxN+kZDt+3Pmxds
	ZPGw6ElMx5sjYbrMagkuklfo+WeTizRfEFw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6yk7g1eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 11:53:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so1285886085a.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791546803; x=1792151603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=reZfXbmp6yLaHEWG8SUuHXTDZSJLk3XotPVTKdZ5Mp0=;
        b=L4eEWKemhXqR0wrMG6UI41/DcxSJGVZ2uXRY2VqR6Om17ssW0ArEiq6WeKxJcR/++u
         4olJ+XezjNP/yndTExb5wHmyJv25mWix2uJRFLbxHZ81IQB0DP9uvBo+M24QbPG1+PWO
         dCkjHN/tJoMqKT2B063XAL1AfIs9lv8fSCUWo//GQIFxK2kwHDqfPQeSNuv5Q35bNAMq
         Sig2aP00g1XDpfwSAZV4X3xwUI75xZzozxWcVS5MYZPt4+xlOf3or3mALiDhBa7NOudo
         weSA9+Zpe5wzb6FmSDOkkRbkjU0liuc08cC96hu4lqIl0DP1mBJbewR3GtWyDRlSNCUg
         q9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546803; x=1792151603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=reZfXbmp6yLaHEWG8SUuHXTDZSJLk3XotPVTKdZ5Mp0=;
        b=OqmUSYVT+tRlHAfinjXh90FtCQc5ti2qnwBbg5qg5U/mitzZsx1lrQcvle0APPsP75
         9/ZX2WqDn+8599v5rHQeBVoDCS8x0bvEp6x6HrB5niLrZtDztRtcidcStduQd5p+hid7
         hBctp7baR4iCBuVYHsrdCzk4ujoGdQFbRO28e5nSAtzO38/JSMJDIo7A57cv0iKRFDeP
         YYkyJlMkA4Hkgmwo7p7ZSyMfIQeA52VGzjE+9elr+gDIASojbR/kCf9kEyBkac3ApIVh
         +XQ8Jgp0o8s7zrfeZUxEgS8La0uBY4QGW+bgMB33sp4j0VKo1T3k7JTtnGO0foA4D0zB
         R1FQ==
X-Forwarded-Encrypted: i=1; AKwUvByEMkOMI/IT/AMtS2g41HswI3UPVee2A0RnEAPv0UHWmkyt01UcGRZbKnXtdForRqCtPEEpFApYdw==@vger.kernel.org
X-Gm-Message-State: AFuF++nnXsTOiwayioqEWqBpYdg84OIoWU0oK9hBQWi3KDchvqz3b2r1
	ZLJ3dT8ZzUhMcvRNgNAoE0z+4aVObC0ifrbXJSqU5LnAh/RaeBfCOUBbqJf3KTQejsxFdgnaS6n
	y5WW+IoJsJRm1r8TsXmjK8nNaLAbjvTNu5OLNjfBSkmgnpBbiKqqPGKXOke72hg==
X-Gm-Gg: AYBFou3RwtPf+v36p4mKOZRL0I/V7fxaJAqEJg6m2SACDNhbr67Jor4rzY8QObbxZbs
	sWGDvGy+ZrrfpjiVkEbarCoZ2RHPtiXJS0FpsJZziS1LfS2WQQRBpCIU3J2Lbo+J9zN8r3578Hx
	25WlmiYmGihA8xbuG8MwG9Vo4NGJn0NAa9HuwiyrLL8SlKUslV9qFjNxw1SSJQofzL0LqcbUjT0
	OrloWUGnwQh0oujx2XdaV8cqn/plIZg5z+vF5H6nUna+qya3EtEtFLpxvuG9LcbNpvhZnwPy/uk
	H6DOWkdPRFrzIs3cB7Ctrtlw1Mvm6zQrwkm67I3pxHFakq7UWPAuXDrjwQUnTOFyPScVQKkrXPs
	debbxzQaqwmE3JR3/3aRRFJHXZrSjWnLIxFR92cRdXC6v8h3CEc5iIQmNaw==
X-Received: by 2002:a05:620a:3711:b0:93e:9292:1bb0 with SMTP id af79cd13be357-93ebd0c08e9mr211379485a.3.1791546803148;
        Fri, 09 Oct 2026 04:53:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3711:b0:93e:9292:1bb0 with SMTP id af79cd13be357-93ebd0c08e9mr211376785a.3.1791546802609;
        Fri, 09 Oct 2026 04:53:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a7cfd8sm83244166b.44.2026.10.09.04.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:53:21 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.3-rc7
Date: Fri,  9 Oct 2026 13:53:17 +0200
Message-ID: <20261009115317.14472-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D63SufRj c=1 sm=1 tr=0 ts=6ac8d5b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=0s-mVxdY99Q0NorlSv0A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: _gf0U3MaJYVgeojeJiN8DzS6027_6ewo
X-Proofpoint-ORIG-GUID: _gf0U3MaJYVgeojeJiN8DzS6027_6ewo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NyBTYWx0ZWRfX4+I9MpI+2opO
 ZiZi002bBFyVlUYh8fYKXqXva0+G5W0XotL60ahFvjz9tJt5rQTZZCn4I/QF8GMC1X1b2HfJWC5
 gCkMdSfoM5TbGWrIr1AhMMSLm4KchuswMXOQfhk763WDTmQe0ibb2OrKoXpBj+dxT91qJTGHafd
 bizaaHhxUa92zSac0D/9cfy+jrAXQOcoBrCwh+JI8LCu3Cl3GaDYP7wIJ2OBQ9CWXiDRUn+inoz
 neiIq2aS2ks1HhM9gNHAg8IAYTMBUVZn4yFvqyFY6ZgBnL3mpftX5FzMgGskXkuFSRoQVlwJKGb
 CGOKx/v5aNtjErbnpGmpxDo8hIrn208luuVQ30ffTHBqWTRYRxvfK74x3GogxAjnJH72lecMSxg
 ZelN36e9UgsoBzPVRJDuq5H7kYpMt25M/M2OSfH/bk+k/DAISCKFtOElEyMgnjXsM+3QfKyhOcl
 L/aGaLxZLOYws8/1vIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NyBTYWx0ZWRfX7jDTQ+a7Qx4H
 Fcp+mF9VNq2s8YvjZlba+mg8nju58soZFScaxJI+UOECEV7hBiCKBhs2niAeGOr6lCuxufPafMq
 b6VmqkL27eB/jyqYsfM80yzLUGUStQY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090047

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.3-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3-rc2

for you to fetch changes up to 4c66c423593e26273ea0d644906ed007630c6f6d:

  pmdomain: rockchip: don't ignore clock lookup errors on attach (2026-09-28 15:36:50 +0200)

----------------------------------------------------------------
pmdomain providers:
 - imx: Serialize power on/off across sibling domains for imx8m-blk-ctrl
 - rockchip: Fix a couple of errors during probe

----------------------------------------------------------------
Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Serialize power on/off across sibling domains

Shawn Lin (3):
      pmdomain: rockchip: propagate subdomain add errors
      pmdomain: rockchip: fix clock leak on domain probe failure
      pmdomain: rockchip: don't ignore clock lookup errors on attach

 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 15 +++++++++++++++
 drivers/pmdomain/rockchip/pm-domains.c | 20 +++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)
