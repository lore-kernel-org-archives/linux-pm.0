Received: from outbound.mr.icloud.com (p-west2-cluster2-host12-snip4-10.eps.apple.com [57.103.68.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A32BE65B
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509099; cv=none; b=g5Qp/nDq4olNBHtCVIB9ekaQv8xRPa8Be6j2WmKdbdN7U8gaAC0OOFZfDUpqks7RgrY2jTEMJAKKCxwvq0jMr3nvckg0OfZMbaq2pjVZB855Lm0CEbqDfZKd2hQMTWoNYcqaVhz9Tl5GBGdhiksWLo6/47SNpFGr+45SpseZpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509099; c=relaxed/simple;
	bh=vjpDDUqu0q1OuSXJcQG7IiQyAMD/OLqdN3k05PyqZsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4N23mEm8FqB/FeuVVYD15etP5HfDdjTHwffsuf0LkLRYHzp9Gfwg+UyghRMJB1uOhne0IfYRYRJ98YwS69re7wQDE/VuSYbHEjtbj5pCTP48w0xg1oShixE8qGqp5jWDTL7pupHX3Iscqnk7VvyEy4/774bd3MRDDnwNV2lkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pzzGGjk7; arc=none smtp.client-ip=57.103.68.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pzzGGjk7"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 0F6601800252;
	Mon, 06 Apr 2026 20:58:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509096; x=1778101096; bh=JkkfJFoCq0pJa8F5Q6jp/1rU49pogxgcYao6Gw2dDiE=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=pzzGGjk7cZM60y1dPkHXhom/jgoWuIBqBz7B5bqRcbIpOyS4bhJ95Mm66A4I/uLngB+5bTXl5XDSFnNqiGxl4oIS0RnRYJMKmmC78BxMBss9gfsMmPWTeSMU5PMv6mTP4b6I/kPY8uoH5hHlX8NfDZR6aRBgLTmnLUsaxwicuwVVKdTP9BlBm9Lpnw/g6secEBwNRNkgAiHmQqPEgm/gBeSAyPxZs7e3RYdmJY0Irw870zvwe1tpBnudWblF3/WJwoXU5/4r9uLDnT6biMpVdLoOo/oTo3eS1rQNgFYm1nnJsQCCPMOjOFe8KcaC98ztHBprhxB+5F9l0RWovy3CFA==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 6FA54180025D;
	Mon, 06 Apr 2026 20:58:12 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 0/9] power: supply: max17042_battery: improve MAX17055 support
Date: Mon,  6 Apr 2026 16:57:48 -0400
Message-ID: <20260406205759.493288-1-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UrdRb3gdyp0Sc6fbRyrAzrtKFl9fs8Uj
X-Proofpoint-ORIG-GUID: UrdRb3gdyp0Sc6fbRyrAzrtKFl9fs8Uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfX/gj8E5nf5OXc
 o4dqx+CndZDioikgkRGn2/McsoIWGrEE7xdhnLIo4ONSdL5DnRrgf7a2CVS46VsrAwu9E0T44ix
 xUUwuy/ryJDuj8CvR/iSogm7zxn8hxHOR5TY2xAfCWIszbWqp9Q1tKwCQ9tfRO2p4lwjPNOSs44
 5LRi7cx4cWLbkp9owGELQ3NXeutYrZ5Fx/Y1bIELCmadaFP7as2/P9+CAOv+x+3n4mNFvMZ+qz1
 ZsKzjA2KG+QvOQ3GpkqSuvBjyO74tFYa8q1o+nuZjA2AYbE9wngWJwSvfnD4dvRXwB8hTjQC2eL
 QAPlM6RNjsdjWujy/pi226xzPlm1rDlLEsNZFT+IuYvv3oCPulqA7RR2QNoSEQ=
X-Authority-Info-Out: v=2.4 cv=W9w1lBWk c=1 sm=1 tr=0 ts=69d41e66
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=XLd-czCsBCJP9l5d9uUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

Hi,

This series refreshes the Librem 5 MAX17055 fuel-gauge work for upstream
on top of current `mainline/master`.

Original series:
https://lore.kernel.org/lkml/20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm/

Compared to the earlier posted version, the main follow-up changes are:

- keep the original arithmetic form of the fractional `MAX17042_*_LSB`
  expressions while still moving the unit conversions into shared defines
- remove the unused board-file style platform-data wrapper from the driver
- factor the `monitored-battery` parser behind a generic
  `devm_power_supply_get_battery_info()` helper so MAX17042 can read DT
  battery data before registration
- keep `voltage-max-design-microvolt` as an explicit MAX17055
  `ModelCfg.VChg` setting so batteries at or below 4.25 V clear the
  default bit

The attribution split is intentional:

- patches 1, 2, and 7 preserve the original signed Purism downstream work
  from Sebastian Krzyszkowiak
- the remaining patches are cleanups and follow-ups on top of current
  mainline code

Tested on Librem 5.

Sebastian Krzyszkowiak (3):
  power: supply: max17042_battery: Put LSB units into defines
  power: supply: max17042_battery: Use Current register in get_status
  power: supply: max17042_battery: use ModelCfg refresh on max17055

Vincent Cloutier (6):
  power: supply: max17042_battery: Use dev_err_probe for power supply
    registration
  power: supply: max17042_battery: Route MAX17055 SOC alerts through
    dSOCi
  power: supply: max17042_battery: Keep only critical alerts during
    suspend
  power: supply: max17042_battery: Remove unused platform-data plumbing
  power: supply: Read MAX17042 battery info before registration
  power: supply: max17042_battery: Treat MAX17055 VChg as explicit DT
    setting

 drivers/power/supply/max17042_battery.c  | 428 ++++++++++++++---------
 drivers/power/supply/power_supply_core.c | 188 ++++++----
 include/linux/power/max17042_battery.h   |  33 +-
 include/linux/power_supply.h             |  10 +
 4 files changed, 393 insertions(+), 266 deletions(-)


base-commit: 46b513250491a7bfc97d98791dbe6a10bcc8129d
-- 
2.53.0
