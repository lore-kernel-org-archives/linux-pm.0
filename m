Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFF3822A5
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687153; cv=none; b=QLY15KCulGh7wbdDjKD1jEk7yPxTQZF/FTy+YO6JVckQOajiA6s3pTKG1PyjOhXVkgg03EJc0vq2S0r3AGJ+RNchaN9BkLFNeA1tqjhyTJIN28OKs0F10TD8GgHxDdcJPIrxaKXmObNnSMgtaiyPl29V6DQVaRM0SASu76/r9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687153; c=relaxed/simple;
	bh=SYvr95hMjk7k+WDGBXWB0glzSsq9A5+rVo3zMypggTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4JhNrFhcxMcKCx0RyhrfKWIJtqBNwOemQGJbjE2tqw+X1ZTGFl4QjEZ63BWNldcsgXgNtobzB3LoAc+Ch9wfickzu7BHGTSrLrXdQYsURu3YS6YrhNCGHun557tC9G3XPXZZuXQ/+Sf2bqglYULIJZCCTfG2kxBNOX4LF55Gn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZUo0ucU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5MYkO4+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZUo0ucU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5MYkO4+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UTCW3273499
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 09:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pI4CGEA+hKFhDAO95+0zHDrli6x/L2VFho8
	GH0qHdYc=; b=YZUo0ucUklMHOw+nFSfwsm1uQEWPgbK1lU5YUM5PobMIxtgLggE
	mzIwaYfClJCg0lOzalMEPdnltFbiSoZesPO00T8cpvDIjmhRYlIHxrsuVDTna8fa
	DdmHtjMm1CrWkzNqCR1vA8lV7lpwFV9nGrmT+dvUaUuXxdYsWCZq7vb2wHfEA4k1
	254226aWsQFu1EbOhEwqKtsodfbvyVU7dCKmjSJHGkw+DtC6mZixNOu0mdpAZSgQ
	bvRJRZ1MQ3kNNKRgB7wFKqfT1Nd0SeIA/Im8gzXA/nAec56pN0sbNZUN1wxd4vg2
	Pry6AKV/vhFTj3a++rfbnGAO7PyQgM4pJSg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euefbtb3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 09:05:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9157f1be083so926397685a.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781687149; x=1782291949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pI4CGEA+hKFhDAO95+0zHDrli6x/L2VFho8GH0qHdYc=;
        b=P5MYkO4+BT19gfXjfhSZtigm+sYyBnPaw82++xNuGVx90k4K6hMnXjhLD4nTnvhqU1
         o6oNzDxdm5jfITQnqVUcNZffwnwBzLHG9AZLvq+GNyd6SZr8ShuZLxbWf5wa5bKcYGMn
         dXSphXWmNlKwPURnmMYFa4QwTL92SrX+lvtzNs5z9ZE5Rmz7U1bgBKOCocHGvGVg7kYj
         Ob1Dcq1irp20vA1xiDtDKfvUHRmofuzoezTftWMLe45Oplj5AmPnYcsxbmgjt65GYU4l
         +pTViaVw/rmmVSsIvNI1ExSqwmjn0KjU6C09OtfV9z3b7WY66cUHCSw3d5V5tUkDkHZm
         hsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687149; x=1782291949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI4CGEA+hKFhDAO95+0zHDrli6x/L2VFho8GH0qHdYc=;
        b=mH80O/b4jfIlajyv4YCdePfs71TTUmgeKI0iPOXMazGXP6Jokj46RBnIoJcIfEzuDa
         qxcM5xqFwPdxj142d3dvZ8tMF5RkXfmvocyz3XN4tqvyBkk05EODG6Sxx8xJXl/Jee5l
         DxBvTnc1HD/Ki3c5m17IDYplRc18Z2mV68b4xEUPxxNRGzcVmio+4z5dttiGacX8Zwrk
         rWNhpqDoDROt28LFLqTYPryRpCnt5nf3FjpYUff0rf0Rjpplssv6uizWh+Hz3vlpACge
         6EQBT6BC3J8MkRMHSyFtzus+0KV/Tq199+a/RDxW4udKdpL5TZwFLy+PltzfiwCaQbFP
         8V4A==
X-Forwarded-Encrypted: i=1; AFNElJ8O53d/K0wUVzR5G2MigaB2aIuz+rHewEG8y7k98Ne7yc5tOYrZx29wRNHmPKHq9Hb2ObKCMQxBIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybe6UlVklRHyIqVnlbevecoJwYfBbIje/8kuQKYcXXA1Yv00T9
	uBl3lGFM5wtw4Cy85rfEksOKlE7u2Bb+6ClVmikuksWkpD5iE9goUfnjnOcNCZja+XglhPR/KPh
	JzteTUBG6SlAcJqhoBnxyHQmb/3x5TSZMJhQ0bhZdio4m440XTmr9EFNPsxyRsw==
X-Gm-Gg: Acq92OHummlEo4pVKM7QhJ4Lz+HMVyKyFQ4FVvshJdchrzdAD+11+eazHVK1yfuOLgi
	jGMyz+OilrWRs8XZqOyc9O46Gy4TuPe8OXGY6MNb1PW0E1chCcfdyUhvYBxtFt4Ed75n4FdIeLH
	JeeXFvJNHklOQLFWXZiQEbjO/Jxvt8g5hpMqhQtJ5bmJRV8FAea6fHsYJbe7KNEkrxSjclUAE/a
	pAhDsxhiC/F6Xrmd7XggC7gnok7SuDKLQSU+faUzYACleZU4Vnsyz8keKDHvgNP+xXeGWtUbErv
	EtZk6H6/f/4qvaIqgjGxh3gQ2ptvx2qoa4/eJAPAh+W/OeOCxAjhEpBlieV1+gVHmsAY2gL3Cwq
	wW5+flN4LjdehJBWYx83i5HRUKakL2YsciRBeFeDW8aqk3oKLA3V2tNpb3dAhi+x/eVXt
X-Received: by 2002:a05:620a:1a18:b0:8cd:b2e9:b964 with SMTP id af79cd13be357-91d88b5043dmr572728385a.10.1781687149586;
        Wed, 17 Jun 2026 02:05:49 -0700 (PDT)
X-Received: by 2002:a05:620a:1a18:b0:8cd:b2e9:b964 with SMTP id af79cd13be357-91d88b5043dmr572723985a.10.1781687149075;
        Wed, 17 Jun 2026 02:05:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f69sm4338451e87.4.2026.06.17.02.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:05:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v7.2
Date: Wed, 17 Jun 2026 11:05:46 +0200
Message-ID: <20260617090546.18688-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QIxcIvocuL7zh_4XCphoJY-mZTHig87i
X-Authority-Analysis: v=2.4 cv=IeC3n2qa c=1 sm=1 tr=0 ts=6a32636e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=JbgBzRNRWi2L1-RP8WYA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4NCBTYWx0ZWRfX5toXz8aZJYi+
 e/Hee45BTezi2xRB1PKdilJgYPSf9GY645nGm1vlrCLsbe71n6KfDG+RDg1ixvd70obiiOBJktY
 Iv78LgieDCmQeyPFKyAHpe9XNrk+4jE=
X-Proofpoint-ORIG-GUID: QIxcIvocuL7zh_4XCphoJY-mZTHig87i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4NCBTYWx0ZWRfXyNeMaYnMaBe5
 BiHaE5trU3nMe6B6nj0SQd8fdXcVmh1seuQrDrP7V8d68ANLIlW6LwOAVA6Cgu8zHwwi8xnpupS
 v1OHak4xNe+70ZbLE6EHPpUnLHMrVl6UFW/zXLU48NMgR+Vp/hqKbhppeKB0XGhVyROaFe+wxuH
 MWsMs61TCCqofVkZSBm0HTz74BIISjSQqH+9TeBWvMQR+hQXCZ6rukrnLYXdEosjysMc4osnx7o
 avgIS9Vkam+VHooO1aK3U3jMRzZLCUFUo+768lP8TeQ9vhUYfKXBwd5c0/ln36BByFBGbIVBDqz
 JAFiW4JGoS672z9NQeVoATg4Mq7bnt7EnovXufHGrjVCKF/I33F+XiQhzMpEwO4T0rDNnCQUueM
 ZmPgJWTIXKw99Iaa8CfZ0ZyumLyiQ084NZJXFnsm1misV8aJjRif7/W2KCdhouzR35TdOnvSRjI
 kVp/GdE9G6vX/DGKmkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170084

Hi Linus,

Here's the pull-request with pmdomain updates for v7.2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fba0510cd62666951dcc0221527edc0c47ae6599:

  pmdomain: imx: fix OF node refcount (2026-06-03 11:49:37 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2

for you to fetch changes up to 528ad521a433cf873724893bda339df95d8ac1e0:

  pmdomain: core: fix unused variable warning with !PM_GENERIC_DOMAINS_OF (2026-06-15 21:12:35 +0200)

----------------------------------------------------------------
pmdomain core:
 - Add OF helpers for parsing the power-domains-child-ids property
 - Extend the power domain DT binding with power-domains-child-ids
 - Switch to use the dynamic root device

pmdomain providers:
 - arm: Add support for domain hierarchies to SCMI power domains
 - qcom: Add power domains for the Shikra and Nord SoCs
 - sunxi: Fix GPU support on Radxa Cubie A7Z by keeping power domain on

----------------------------------------------------------------
Johan Hovold (3):
      pmdomain: core: switch to dynamic root device
      pmdomain: core: fix early domain registration
      pmdomain: core: fix unused variable warning with !PM_GENERIC_DOMAINS_OF

Kamal Wadhwa (2):
      dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Nord SoC
      pmdomain: qcom: rpmhpd: Add power domains for Nord SoC

Kevin Hilman (TI) (3):
      dt-bindings: power: Add power-domains-child-ids property
      pmdomain: core: add support for power-domains-child-ids
      pmdomain: arm_scmi: add support for domain hierarchies

Krzysztof Kozlowski (1):
      pmdomain: qcom: Unify user-visible "Qualcomm" name

Rakesh Kota (2):
      dt-bindings: power: qcom,rpmpd: document the Shikra RPM Power Domains
      pmdomain: qcom: rpmpd: Add Shikra RPM Power Domains

Rosen Penev (1):
      pmdomain: mediatek: mfg: move __packed after struct name to fix kernel-doc

Shawn Guo (1):
      dt-bindings: power: qcom,rpmhpd: Fix whitespace in RPMHPD defines

Ulf Hansson (2):
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next

Yuanshen Cao (1):
      pmdomain: sunxi: support power domain flags for pck600

 .../devicetree/bindings/power/power-domain.yaml    |  34 ++++
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 drivers/pmdomain/arm/scmi_pm_domain.c              |  15 +-
 drivers/pmdomain/core.c                            | 189 +++++++++++++++++++--
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       |   4 +-
 drivers/pmdomain/qcom/Kconfig                      |   2 +-
 drivers/pmdomain/qcom/rpmhpd.c                     |  35 ++++
 drivers/pmdomain/qcom/rpmpd.c                      |   7 +
 drivers/pmdomain/sunxi/sun55i-pck600.c             |  31 ++--
 include/dt-bindings/power/qcom,rpmhpd.h            |  18 +-
 include/linux/pm_domain.h                          |  16 ++
 11 files changed, 318 insertions(+), 35 deletions(-)
