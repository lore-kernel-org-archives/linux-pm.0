Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5543DDDA0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509542; cv=none; b=t0hloydyhe4jcgijxIgGL2io4Fvt5h7CYFaUMW26b3BhUE9/0oR5UgB14/jYPBvDMUJhzbb7RWd7B1bBS0beP52fbOVXd5MDBeu98CZMmFry25n4ao1fdeoulU3VPRprMORD91Hf3yiYbTBfYele+3JzNWBpU03sPh24eJmU1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509542; c=relaxed/simple;
	bh=ji+1+eoWr7g3B/Fu80eL2dpRSbi+oZVwM3gbBGOFmIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RafxzAOSkLUMQaAuje0uPoMkygX5BzcPZvplrG6MPa0CssUPDmNbrX8fkeVDSGC5PTXg2KW74qxLCyu0SDcm90mrlJ6lKNac7ZY8P4RG2IaVtHe5Qz1BSYz1FWBNd+LsBbPfHWdgcNF/ygRjvpnd+P+sPqp7IgWRHLrS0vPY0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3ySIlDm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TV36WcT+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3ySIlDm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TV36WcT+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mXuv2838284
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 08:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fYOgoHy9wmPlB6HPGaAQVHVyL9xOfEZSABU
	zx83Oli4=; b=i3ySIlDmBdIx4usUIXvLrhWx/UIFqrKhGJXQ6pmL0KwGFP6HjUz
	z5+1xGXwvsgk0kGhZOjgjFR4BqLUeruKkZ0G2Vr6dfAQt3cla8IrPamp6a6I8ms4
	OB049DsQ6VZxyphRrGThr8NjFf1oQuZq/0EaZVQ9ZMWIRnSUoLae2wcEM+ZZ6EbA
	Hs2nW4VqeuZdOVjj6PwxjMsc7JCP5Wl1V/i65dxOO/6BAf+zYwiVAczE7f/IbXcv
	/GcHzUBBY3FG0gV3RUu+TPb20lr33mkCpWj3L9TX9xnlmslrj9yEQP7sANbluvK/
	+qCnS40Mbwrt+feNvenI5pgqWcBAkdDsywA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrhc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:12:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e53b8a302so141275185a.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788509539; x=1789114339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYOgoHy9wmPlB6HPGaAQVHVyL9xOfEZSABUzx83Oli4=;
        b=TV36WcT+AEPsvX/oked2aUkrsi/4eNWnbEW+xINUJ9k7g+WDeZ0C4pqDczl7SfCd1e
         AaC2r59jyTIoj83jpAwMku3cHbdWp5d6TobWLptmAnm0ib5juDPTbEWar+bor80ammpL
         /IjEq9VMjnbyU0pqWboQWKas5G6SFY1KaqPWrxzsjVLrH6WO4oOhGs4GnT1ItJLpK1fs
         8N0OkCVrf6LNLRbv8wSvsNLrhp9JGAR0MmKkLUjW9jl5ekUTUP990WV9Van5qARtrmjE
         mAuoS5V6VIL+BjxqwjYCoDn2ZAc2FJb+7fnlHTMsHb54YYSFTznrN03bw5CA2HeP2qr6
         eKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788509539; x=1789114339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYOgoHy9wmPlB6HPGaAQVHVyL9xOfEZSABUzx83Oli4=;
        b=gDlwHKZ0dUZ3zTG13mm9/HNLo8hp6GrATHWqzh3hiNZ+ejhFkvpexCDrfm2phCg8wH
         DAc0qnn/pMVFIDDZxXXDTXltOYy/weDbOP4D0igNVTxP+RkQ25hplgULsz0qzmlcGaem
         hVk/v2PaPMRW2an+vtod7/ZTPtaR3rUAnlbt5ZB9uoyt4OzuKGLQv2CFfNqnqp7mpbB6
         m8q7fRM6f6F0I8zef4zA8YLZ+3STgllXoJrd/aDa1dmhQ7QhM08RLZp+qqxLB+jWKp9m
         Qf21UJhDNWFu8f5QBJqQq4H7kXOYRh5hfCyowGlwLkCS/Znb2pjVJjH/Qb0mDCOVpNBk
         vwrg==
X-Forwarded-Encrypted: i=1; AKwUvBwRXeSp73ko4Rb6N7SyVU0+IMHV2tRJ9+T5+IKOdbRKwBv7z5MikWBO2SDdcUSHzHo7+LIeD+oV1Q==@vger.kernel.org
X-Gm-Message-State: AFuF++ljQEpr7DF66gJ3hplkF4GXU+FI5iVzRu48IIKHTzIbA8sq3VN+
	tu5wB83GuUW4E6fWtXuSnWXjERakrqdReg8iLBwzaicKOjtzSoUJ39+nhVVM6NdIU3+xY54ekyt
	itGA6mutuSeSi8zlpxqJlR+QEvIYjhORDB8IQkx+zFI6YHMbGCZ7ESQXvIgnJdw==
X-Gm-Gg: AYBFou0U4E5CFxolMkI2X/au+8aonGIwqC8jF5XI+W1NN2nFtvZ03QZu1qYwtOCAkKj
	SGdzuaIE2UZTmn7V6/LzXHSCZUmcgSzx/72AYyP6Xa1ek9SPqdsnfulkw0nra61HJhBtusIbxvI
	sCKrxESUlpfPmK706FYBsOukErnBDKAcC+PcTqtFNTmvgILiEOS9+AkiR+rfKZUttnGh+/TUv4Q
	Rm993QDa3vZpITKDw70QqTwsDd4Xp7fU3LpfQXFta2drmOGQHpJaTY5FMeZdAAwz3C/SXZ7gbGw
	XNo0RMPHYTDRi100fP7rMU27J1lIIW8bU8T8wHqIPxzO7ghHtPaC+vCYkSOUm/w3SVUVALe2USi
	l8HH3haBfy88Cfm4DtwFov1TSkOkc+YCrh0Dxz5ntxm7pMeVoroL/JrpxcQ==
X-Received: by 2002:a05:620a:290a:b0:939:ca4:4d5f with SMTP id af79cd13be357-939803240c2mr425009585a.5.1788509538960;
        Fri, 04 Sep 2026 01:12:18 -0700 (PDT)
X-Received: by 2002:a05:620a:290a:b0:939:ca4:4d5f with SMTP id af79cd13be357-939803240c2mr425005885a.5.1788509538469;
        Fri, 04 Sep 2026 01:12:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm71610666b.15.2026.09.04.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:12:17 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle fixes for v7.3-rc2
Date: Fri,  4 Sep 2026 10:12:15 +0200
Message-ID: <20260904081215.215528-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a7d63 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=mg6DjbED1CunOJUx780A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: IZ02XTOm6-IE9fo4cO0hEe_vqVuuUsd9
X-Proofpoint-GUID: IZ02XTOm6-IE9fo4cO0hEe_vqVuuUsd9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3NSBTYWx0ZWRfX7KSTvL9X/fxG
 X4pNXuJ7Fn8W20aiB+dvNIuDd6uZbb4Mo1YLD6jkc9YPBIMU8iYGT/2o1Mr1FuqIMZ29CANswlz
 xzNZ1Vs9dATYUgyV84BSmJuFAl/NjqM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3NSBTYWx0ZWRfX3ha58F1eLckv
 n2//TnYjcJWrkhB2G0wSen4V/qex/PzIIZwJxfH5JPSkMHOKlrRNipwAZxk9I8TF4hlQfcV+XmD
 KtK6vK5JxWJtrvYLK2FjzVetrropo5fHCN3Wy/h55d6dsAp5SWoOQCpxmKQ3AYJKa9fxHwbrZy8
 sme3F2N9i2fES0xCnf3Ins1/RthNyh9/i7xH0OK4+GpC7mR2l0osoSK3yRvCgC8ye880uKb6vAa
 aCECvvOK3vWC0jkqAo4KEBFJkNPeMVY5/tkHx1QzOBcj68Sg7MUhwjD6EGtk5uB9+W9X1jc0MTo
 4Dc+kCRwTAcJ3Ijyx4wtuPGdfK5ocxlVEwpxvWe9tyXAT3O4khJNT8LWZ1EXNLYoUUl/OjZwnuL
 zljlnQrMszbHF7znk2s89PfQRBHnM+IuvMQQG1EzAqDjq1Elstxsdkjr0wEM0IMOZArDCAEm/vO
 mQp6Njfw4PmUNIXPWRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040075

Hi Linus,

Here's a pull-request with a couple of pmdomain and cpuidle fixes intended for
v7.3-rc2. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3-rc1

for you to fetch changes up to 2b0ac85512b7f67479127b2713254490662eb13d:

  cpuidle: dt_idle_genpd: kfree() the original name allocation (2026-09-01 17:28:56 +0200)

----------------------------------------------------------------
pmdomain providers:
 - mediatek: Fix Kconfig for Airoha power domains
 - qcom: Revert adding the missing power domains for Eliza

cpuidle:
 - psci: Fix support for probe deferral by dropping the faux device
 - dt_idle_genpd: Free the original name allocation

----------------------------------------------------------------
Abel Vesa (1):
      Revert "pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power domains for Eliza"

Christian Marangi (1):
      pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN kconfig

Linkai Gong (1):
      cpuidle: dt_idle_genpd: kfree() the original name allocation

Ulf Hansson (1):
      cpuidle: psci: Fix support for probe deferral by dropping the faux device

 drivers/cpuidle/cpuidle-psci.c    | 42 +++++++++++++++------------------------
 drivers/cpuidle/dt_idle_genpd.c   |  3 +--
 drivers/pmdomain/mediatek/Kconfig |  5 +++--
 drivers/pmdomain/qcom/rpmhpd.c    |  4 ----
 4 files changed, 20 insertions(+), 34 deletions(-)
