Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F43C5DDC
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512344; cv=none; b=AFhF6LX3Z7IPTag2W9T5rsfBZJiio0P9GnRlwmu4p5Fm46P/oa6tF+GK+GjFWxB22v1yn8ZNSUHy68pDgxUd2duIddpaDtz+8HMZXKMJ3mqO2P9bnL/Sr+INvHle77aUMpiPPULY6ZpZprCR2sDXixpR79pIQ0qZIOBKLD3V2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512344; c=relaxed/simple;
	bh=AjOCAa4nx7+Kkyzs8ZQpU14vQOo90JI/tH2aveljqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPSMDFZ4xJpx4MboAAPmCUsuWV+xRf57LfggHdoJIXIq78k9n1nPuSXm4e0GFteicgz1DwoneICAR8jWypZ/Jq+Iy8DYUblCWHyXY8XC8+dOMTk6Ow2+gjmxqZPsdclCwlt3Op2DA5P3Onq3YIocz9WbZKsl8sZyj62kTQ2bN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Id3QI5ro; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q7nj5eCO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Id3QI5ro";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q7nj5eCO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6IvMr3332583
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YFlGS6iJLNMJwy2StH8DPd0GZdnxBbZ2ysJ
	oKGEwRtM=; b=Id3QI5roL5/APdp44cg54MVW7B5aA0I/mKWwQzHHYQ9CeP3Gi2X
	o6tVA4sOCj7K+7t/u1HGshP5lzg2Oi6y71qV8dBXznRSmQPez3jyWP9A4tbnCyyS
	Im3KAmo6gxqYTPbnRegOumT1EpZkRLoadOuNypwgOwQzP/nfcHAKaN6fLrlVYuaB
	ByMEcMeLPRA8xyUpDjhfokx36jyBfUORHEvHv/bn8Zkt0p43gtVirQbWv1/L93DM
	xNChK+xt+NoHMvlVN82mIJq/fTlpdeRq6yiXScoJQI2IoeknNKpKeIM/CpB4pbwx
	RfXvai3AhQGTPQAptPb2HhM1CXAiMHsV2fg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye16fwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:32:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ced08f46b0so80854216d6.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781512341; x=1782117141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFlGS6iJLNMJwy2StH8DPd0GZdnxBbZ2ysJoKGEwRtM=;
        b=Q7nj5eCOVijui0wWfdubyDPF8BHskzeRYLZRB4y/YVGd8opZ6D57FWAGVuVA/i7Y3P
         mepT7Je3SmFbZws7N91D+sKm0rR2nLFFyaAewXV9C8BG77LRvwdvi5SJ6xc87OMogURJ
         jgf1c1hceLYP6zhYat07ZGBxYMEXHT9DiuwfRo2xYi0LZZHswHquLbyLMosXmfAm3jwc
         LB1mpL9ZVl3n7xnpRlLlXrEeNA4gaZqU3hX1LgcxuDxzB5nUXKwl3ITOgD+dOG4If0XS
         +2K2bMJzXO/82MruLdStLBtKE1A7vGBZpT4fYesLD4pKzVFqu0GtTOf9NJoHG0pBSnFm
         z24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512341; x=1782117141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFlGS6iJLNMJwy2StH8DPd0GZdnxBbZ2ysJoKGEwRtM=;
        b=HiWnXwJ+dkJxgdbGTkvapJs7D5JkmcbOqeQRl4lmN3BuQKOvbHVdE/ukvkvbhDuUep
         xjnuule3wpr9xOGn2JOcUYN0dIw2xrqNNJh0iFjlBNnjd7IWJ/FBMMZttuQ3UBSaTadY
         AG+a6x8O6ncUnvbyYeGfY/+gEmep55DhlQuc1P82+PbWUMfgcKaJE/v1aIWVHxZq/DLY
         8mzTou5XbW7ITtW86TLV9X+wn7s9N50qQYTrRdYYNEtPA9NWpgTYy+NybSiWlnis3pbh
         qg9iUMzrCn4bkR24dfNrTp420P80+Grkrl5LZabGKqGtv703Fbnpbvhz5KfRqUmRHS4Z
         o+yw==
X-Gm-Message-State: AOJu0YzU+FnNOGxlSM76SVlm98A3qyGsIOyogZ2u51fLnMn9Vckx1OP4
	HcxxXqdn+rcfzHsiclgm0wssXK3hI76Z97CO6MA3K2BMiSG4Nvbvqadk76gbsYJtU0NAqUSiai2
	4r0M20P4Us9yLglzQDxRWfGF0yARRIcdKtxuiaoTmYPZk0+wP4os+bwCGr9TRRA==
X-Gm-Gg: Acq92OEp8Lom1iTAdcHYcvguDL/9EK4L1oxZyLhvZzpX58KfhC/+VLZ3ErLdkviu/ML
	erHlSnHp4TtUk+dGD4m/9T3g7ZT8+vIjSRY0AE/N/gOc1rjxi0SykOLUSY7TNCHOCGjMNDl69I8
	0bCFTdgEJLKmPX7qw+QA/fjLiyfbiLW/dtPWWE1dSS/qQ+pVKZT2iu6nnOsvriM+kDSPrIBceRs
	JW/ZzRBUu6O6Bg2qy84SGHXdIZ90oGCdA8T7eCNa42hwaOXQHBuwZZ/xvewNMrJaYkwvV3PxuzT
	DVuzD4tRKPdjW01O+7t0pWbsxihp2K33HqstfGdj2wSsa/XTJlnOsXELoAr6ApNxGCDQcbwls75
	J6GNnujz047nkh+1iI54mqqnbkSPkNnDqqUhWnt+dq6ovNAW37g==
X-Received: by 2002:a05:620a:a408:10b0:915:e8fc:153a with SMTP id af79cd13be357-91619e344e0mr1209996885a.14.1781512340852;
        Mon, 15 Jun 2026 01:32:20 -0700 (PDT)
X-Received: by 2002:a05:620a:a408:10b0:915:e8fc:153a with SMTP id af79cd13be357-91619e344e0mr1209995385a.14.1781512340435;
        Mon, 15 Jun 2026 01:32:20 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d677:3f6f:b288:3b60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb511b8aasm422182766b.24.2026.06.15.01.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:32:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing updates for v7.2-rc1
Date: Mon, 15 Jun 2026 10:32:14 +0200
Message-ID: <20260615083214.38846-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fLYY0JGSSbtZSG59mAqFYN6_fB29_YrE
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2fb895 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=BBd1ikKXGVq-GrJu0XAA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OCBTYWx0ZWRfX11JFKY1lRwII
 I2D3gtRJ8yRLRKPuQMKOcNVLyU4KXTVp0lmKViX/rqc8FNGXGj7sT0wh1oEVJpr6mR0x5xGasA4
 G+YveW7LDOjy6PThfV48O/pz3BzB+tI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OCBTYWx0ZWRfX8EpE2He7KBvQ
 4MDKn6uACQGAhrsij2I/hwRIbhSRuQeAwqezpFX9tp8ZgvEgvwBMlfZQVIWAW1d8HQsoGItkYfN
 Rn6Ui4hGZuY7JUhCdVK1cLjNuU5h67qTCaYKOTX8p77eB8ADT328FSCNx0zsQM4s0F3uaT6j5fr
 fGlia9nafJtnk8HiDQPN1/ImoS/JIzT4/HhquSBegJaFLiSpol2CXXsXW+N2llS4jlKQxr6+PmF
 T55Fmlv7dAs5pLHUEVvQ7E6LAx/O0U3Q/mZdJGaf6dNGInuNxt5burP2F3gWIEV+RA/BjZDzdl9
 XjoOvvAB8QfE9Fn2txM2+m3OYDsoMEBd7EPNVHG7DrL7ntvUFZ37cmLAhc0cQ6qLNZwyOB6feSv
 Y3UaNkNoYnCnqmPt9AacGyXsegwwvavEctGCl/GmP5Mh8sCvrbgbgxjddHfkg0ZQJ+eExVBuyJG
 oO+t5vf5Wwy7iNOgfkg==
X-Proofpoint-ORIG-GUID: fLYY0JGSSbtZSG59mAqFYN6_fB29_YrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150088

Linus,

Please pull the following updates from the power sequencing subsystem
tree for the next cycle. For this merge window we have a set extensions
to the M.2 pwrseq driver allowing it to work with more cards than just
the one from Qualcomm we supported initially. There's also a tweak to
debugfs output and a new function that will be used by a bluetooth driver
in the next cycle.

Thanks,
Bartosz

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.2-rc1

for you to fetch changes up to 2abcfdd91e6acc9999c1a38a6a077835a9db380c:

  power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth (2026-06-08 16:39:43 +0200)

----------------------------------------------------------------
power sequencing updates for v7.2-rc1

Power Sequencing core:
- Add a helper allowing consumers to access the struct device object
  associated with a pwrseq provider
- Print the power sequencing device's parent in debugfs to add more
  debugging information

Driver updates:
- Extend/rework the M.2 power sequencing driver in order to allow it to
  support more M.2 cards, not just WCN7850

----------------------------------------------------------------
Chen-Yu Tsai (1):
      power: sequencing: print power sequencing device parent in debugfs

Manivannan Sadhasivam (6):
      power: sequencing: pcie-m2: Fix inconsistent function prefixes
      power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices
      power: sequencing: pcie-m2: Improve PCI device ID check
      power: sequencing: pcie-m2: Create serdev for PCI devices present before probe
      power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table
      power: sequencing: Add an API to return the pwrseq device's 'dev' pointer

Wei Deng (1):
      power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth

 drivers/power/sequencing/core.c           |  25 +++-
 drivers/power/sequencing/pwrseq-pcie-m2.c | 234 ++++++++++++++++++++++--------
 include/linux/pwrseq/consumer.h           |   7 +
 3 files changed, 208 insertions(+), 58 deletions(-)
