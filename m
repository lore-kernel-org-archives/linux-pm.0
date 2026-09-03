Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C56423A66;
	Thu,  3 Sep 2026 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432426; cv=none; b=l5Ys6vnRhDGvPcH5HJaUSlU9poxuxN5EkyJYBcsoVaVp8Pb9Ca3BjhppxjXJW1DasxnsVqC49CSTe+ijnFAUkEiN+xqrnWM9Imkgz3Jq/zdLI/uxgbywvfrQz7XLj0ZZ8joQsdCm25CrvmGTQHsPXalDJgco+eSP3Zip0HoYCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432426; c=relaxed/simple;
	bh=JfIpgP96Wc2NdCYr2pjAPyjBffukEzjgHe3EGxwWMqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2QCO5qWus+QOgHP1RaiUT+ROqt6s9cmGaXLjPfylVMGLKEsV8W79vpjHSBK4B4AA/OksVkA4Hznn58fCtWEJGbbXZgJaWqk5h249G3z5QlHqqzTyQ+wPlMm7nL3ngE0YShN0mN3qWE4RMKzZSNJ26/k0lEKt/ib32A/koggH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZU0xT2VL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZU0xT2VL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AFDVm324776;
	Thu, 3 Sep 2026 06:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ycr3g
	MBwdHKANUdVM7Ogdy7oY/t8M+YmWpeSgJMT3f0=; b=ZU0xT2VLJxNcZ68Xi7K+v
	Nh43YPXB1xx/TiF7GJx+G5kNKp7oTmCV9s6PQcQ90H9N+TmE+bciOE6IJaNtyhjP
	U1+qf4vz9/BTUhsiNcVF7x28IxtCvACtNOV+oq95OViF36XLjzqsTrFbDrmXbS6a
	Up3PYuIShnPUzA0Rqmrvot8d/DICovSC2nzh4AUGz6sqE+3fW1v9X7Uo2GrCKudp
	2zdLzVt29fzcLakJ01xUSeyWBlhp9RxB7JEsk3kgydhGa2vedQl5ZMHRwZZyV1Ib
	tZX2iXjsoUZD5Xhr48bmozWutb0h6Q2HXSFRQ1GWUzk9HI240Y2F2zzfI031Mci/
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1rqjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:46:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 683AknNl059055
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 06:46:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 3 Sep
 2026 06:46:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 3 Sep 2026 06:46:49 -0400
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.223.216])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 683AkdDC015001;
	Thu, 3 Sep 2026 06:46:42 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <robh@kernel.org>,
        <sre@kernel.org>
Subject: [PATCH v2 0/2] Add LT8491 driver
Date: Thu, 3 Sep 2026 18:46:35 +0800
Message-ID: <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a99501a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=hjHjPmoSjb45MO-3BuAA:9
X-Proofpoint-GUID: q4Cl_KiR9QT6MnC7QdeoTd_N02D3CAEM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfX6AzZIg2Fb8ni
 xKbIhTAQ2he+blhA6Zls+WQclL3SnCkpkLkd1ffVpl1WLCrHaQV6ul1vw15YPkff22rFWWZjP3j
 CAzqc1qfWz+zS7qTy6pP21suOlOzxhay55IkZj5+FGfHVwxi61dk
X-Proofpoint-ORIG-GUID: q4Cl_KiR9QT6MnC7QdeoTd_N02D3CAEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MyBTYWx0ZWRfXzcWLuxAOHr1d
 FpZ7P4SxoS8sUbJlROMrSkz3+404H9+FtfK1/c/5ujOaPYu3e16xcUDt5bPytf7tA3FJkkdEkfQ
 T1JnUMBS0F/hgKZQug00n/4Zux3jT0uZckp/HnBKSikixltAmpy0WhRs8WenJrSV0UXU5innjYZ
 MMpnTxzFGctBn1/iQJD7ukT92h3Ah+wHBs9Z+gPGhXwVtwRtCC9VUuCQNgj4FBmZ58AJm180bVC
 gvWz75Y2C6Hts9GAFFXpSb+3kFB+PD1fOOQBLp4eitzc1HWS5wX1OcbVqWVjy737/IScQaUilTQ
 4gy1nsjShXH0IyVWIkXsReVHNc3SfMpwaVwhfaKidMvsrAgorUawPYswI9giXlgX7KdtNxk1dLL
 PYV3G6AEyGTLIKJFPbHbF6TikJ2fcQcKgayCk24zvX7c2NsLAJ6OCdJ1Z1X4xSkB04cec/HNeF4
 Ezi1FIKJHT5qsg4998A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030093

This patch series adds a driver and DeviceTree binding for the LT8491
battery charge controller.

The LT8491 is a buck-boost switching regulator battery charger that
implements a constant-current constant-voltage (CCCV) charging profile.

Changes since v1:
 - Add a reference to power-supply.yaml so the binding inherits the
   standard battery property.
 - Fix serial-number error handling by using a signed temporary array.
 - Check the return value of devm_mutex_init().


John Erasmus Mari Geronimo (2):
  dt-bindings: power: supply: add adi,lt8491.yaml
  power: supply: add LT8491 battery charger driver

 .../bindings/power/supply/adi,lt8491.yaml     |  92 ++++
 MAINTAINERS                                   |   7 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/lt8491_charger.c         | 412 ++++++++++++++++++
 5 files changed, 521 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
 create mode 100644 drivers/power/supply/lt8491_charger.c


base-commit: a888754e51e915731c8974c4d6d62709facb35d3
-- 
2.34.1

