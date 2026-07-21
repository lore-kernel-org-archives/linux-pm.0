Received: from outbound.qs.icloud.com (qs-2002k-snip4-2.eps.apple.com [57.103.87.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CB332913
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660377; cv=none; b=hcL2WQOc+amJes5abV5LFcB/eiDnU9LcMT3rk77HZMl3pjmz6nxCE8dJjDpt0l4/sI//CPOz/ElYXeWmOs2c1EN1VSXCpLCx/0Q/L/UunGhLyT/wzgssSkqzrMcVvtlrx3O5R7k1b+rWJ6ZtrEy/d9ywJRXdxX5Q5mJkEXg4re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660377; c=relaxed/simple;
	bh=2mbRi8I5KccqCoH3Y/cLJYp12aILgnKVUYvZ/muVGuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbLO3dsmI15HYRKJbL5GabR8xjEwvigAqvihDEh99OtRcB+wtpG6Jacz4XO6AikkxZBr3v4/ELgO6NO3qW7zxLViOq3h5F0wa4OY8cU4IMf9c0Z8qjpARt0BjcXIZA6VVW7LN4nggJDrJuWZ7rSP6PiCfMABHUIISbUBZr8fp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NlElkTXg; arc=none smtp.client-ip=57.103.87.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NlElkTXg"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id 33CA1180015F;
	Tue, 21 Jul 2026 18:59:34 +0000 (UTC)
X-ICL-RepId: 019f860c-32ae-7de8-a06a-2c6759eefed6
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwBSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEEIQAZUB18cRAlPBlsaWh8GUBZQCFkfHBNVF0YZXg5AMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784660375; x=1787252375; bh=I8zgonQWzDtuk0Lo7rQW0S2oMlPo1hqxrWX1e3WEqMU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=NlElkTXgm5CPj6XC/TTkgq4emV65UBfc9ml9hD4TiDmiYIw7oKMvcD2TOt+fsnY7/27sotRkpmREdhtjJ3zM5K7j21OoBqcDgThhZmNIO7Ar8+oic8pfu/EfLJgIidAODtjGE2y436WVVrgh13h0ts//+BVUEP721w6eXS66PfeeSV9OUlluNgDFgMbkXXJwlAlbkJhgprqdYhTymTGRyknLvN6tMY6sQZkS1FqK0nFGyE1V/nMQtq1ecOlH1JGlyoDRHPU+Z9xWM7sRq+i4qZCYc1yAsuvJ6/tf21LsvqC9CJGHKmyRD/GRwe4yxoRrjKI3UOkTDUbfSwrH26JYVA==
Received: from bigre.localdomain (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id 7A08F180012A;
	Tue, 21 Jul 2026 18:59:33 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v3 0/4] power: supply: initialize MAX17055 from battery info
Date: Tue, 21 Jul 2026 14:57:32 -0400
Message-ID: <20260721185904.40756-1-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LiVy6YYji-5vwheTRcKIxfuZ6G2A_geo
X-Proofpoint-ORIG-GUID: LiVy6YYji-5vwheTRcKIxfuZ6G2A_geo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5OSBTYWx0ZWRfX7T0MHy1UvWWU
 /Nrokptrppq59JaCVcmIcShmkHtypK3EcTGPSFw5tKQc1RRz2T5dagBmCU9uikqXERgW+KUuoF3
 e5Ye+8DWRC5xzdjpsjGnVDRI35KoAZ/+3UbKWlfGonR/k6S21vcQ4kxsdvz0OwXc/kYFqUvJG2R
 /LsO+vX3NYc/tGz/xc9IiwRw3dmwlVOETTOLvNbXI2dSOWsgFKF73ilHN6e/DmLmB1uuyPdexW/
 ClT1xYX9ZryChacbhbjIi6bnj+NG7i6uXeYMFoPbaQQowNVH0l0pEktmcQz6EVjvKqvp/lvwVRO
 5s25bNsKWQ9Z7j9/I8z

From: Vincent Cloutier <vincent@cloutier.co>

Hi,

This is the remaining unmerged tail of the MAX17042/MAX17055 v1 series.
Six v1 patches are upstream, and the v1 cleanup patch is covered by
699f0f71ac98. This revision retains the requested registration callback
architecture and strengthens the MAX17055 POR sequence.

The power-supply callback runs after the core parses monitored-battery but
before device_add(). This lets the driver validate and prepare DesignCap,
IChgTerm, dQAcc, and VChg without another firmware parser or a
power_supply_config handoff. dPAcc is derived later from register
read-back.

The MAX17055 path waits for FSTAT.DNR, saves HibCfg, exits hibernate,
writes each stable battery register once, and verifies it after 1 ms.
SoftWakeup is written directly, and Refresh is requested once before
polling. The driver derives dPAcc from read-back DesignCap, dQAcc, and
ModelCfg values, restores HibCfg, and clears POR only after the complete
sequence succeeds.

Driver-backed properties remain unavailable while initialization is
incomplete. An interrupted transaction restores hibernate and retries
every 10 seconds without depending on POR still being set, so a transient
startup error does not become permanent.

VChg remains a masked ModelCfg update. A voltage-only override reads
effective DesignCap and dQAcc and refreshes dPAcc for the selected voltage
range. Zero is rejected. Exactly 4.275 V selects the low range; only values
above 4.275 V set VChg. An absent property preserves firmware's setting.

---

Changes since v2:

- use unevaluatedProperties in the MAX17042 binding instead of declaring
  monitored-battery explicitly (Krzysztof)

Changes since v1:

- send only the unmerged battery-info and VChg work
- split the power-supply core and MAX17055 driver changes
- use the requested registration init callback
- wait for FSTAT.DNR before programming POR values
- save, exit, and restore hibernate around MAX17055 EZ Config
- write stable registers once, wait 1 ms, and verify their read-back
- issue each command once and poll ModelCfg.Refresh
- derive dPAcc from register read-back values
- retry interrupted initialization periodically without a POR recheck
- keep properties unavailable until initialization completes
- recalculate dPAcc for a VChg-only override and reject zero voltage
- allow monitored-battery in the MAX17042 family binding
- drop the Librem 5 battery description because its user-replaceable pack
  cannot be identified reliably from the board revision

The series was also folded into a Librem 5r4 kernel and tested after a full
battery-removal gauge POR using a local battery description. Status.POR and
FSTAT.DNR cleared, HibCfg was restored, and ModelCfg.Refresh cleared. The
driver programmed dQAcc=0x002b and dPAcc=0x054b; the live dQAcc had moved to
0x002a after initialization. The other raw values and sysfs properties
matched the expected 4.2 V EZ Config result, with no MAX17055 initialization
errors.

v2: https://lore.kernel.org/all/20260720011144.1280219-1-vincent.cloutier@icloud.com/
v1: https://lore.kernel.org/all/20260406205759.493288-1-vincent.cloutier@icloud.com/

Vincent Cloutier (4):
  power: supply: Add registration init callback
  power: supply: max17042_battery: Initialize MAX17055 from battery info
  power: supply: max17042_battery: Honor MAX17055 charge voltage
  dt-bindings: power: supply: max17042: Allow monitored-battery

 .../bindings/power/supply/maxim,max17042.yaml |   2 +-
 drivers/power/supply/max17042_battery.c       | 373 ++++++++++++++++--
 drivers/power/supply/power_supply_core.c      |   8 +
 include/linux/power/max17042_battery.h        |   2 +
 include/linux/power_supply.h                  |   8 +
 5 files changed, 360 insertions(+), 33 deletions(-)


base-commit: f2ec6312bf711369561bdcb22f8a63c0b118c479
-- 
2.55.0
