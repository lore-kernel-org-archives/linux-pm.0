Received: from outbound.ci.icloud.com (ci-2001j-snip4-10.eps.apple.com [57.103.91.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02818347C5
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509932; cv=none; b=VuisSraEuZ+iEwIsnBAVpdFJqMKIlo4Bi21+zBEnX3w4NTRjlw757CvQvj+vltk1MRoBOTJit6IA17W2x+FSMsEeMeFkIzxga26r3hJYQyQbTQRwqrBmJ3Y13vgqSZASk3vdwpB1dWNUijORaTW1eFdd2AsorWrS9Qt8XAEiTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509932; c=relaxed/simple;
	bh=QTUHH17IM8SB/hPnUVPJzAlUyKmx49FL0ablGPEnzws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dgfhl4YJArDG1jexeOiLZiRcJ3gI3toawy7EDt9Fsjaantk+xabLLKdcSKnVtwdfCItsN+tpNC85+KwevTcxqYzTys+MiUMqKFRegBGbNhdGh1orUxBtsLhfqzL2ii8QMhpjVlvSTSSt5g8LYtTnskcZcd6MGatzcyeKxqkXvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kkCSduQ+; arc=none smtp.client-ip=57.103.91.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kkCSduQ+"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id 4953A180013E;
	Mon, 20 Jul 2026 01:12:08 +0000 (UTC)
X-ICL-RepId: 019f7d14-9328-7a13-95f9-98d494ea7b4b
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEAJSQJcA18cQQtAA18GUh9BFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784509930; x=1787101930; bh=YtuRh7FwzlvGfUMEnusH5ua3lj8sw28CCBRzLHmwjsU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=kkCSduQ+EfJQ11XJ/DRDGxyQ+OWDZ8eJUQlVpGaBip4n+zYA1i2qboTu9y1QxJLkzCWvdWRxJJJLqEeG1XB5LIqVHETPDETqNELJ4YNUihvRc+8T7lt8oniUURnkA6dfnf0nE9hiz24BpWS3HsEP4rC9i2fRXLTbRdRRLLBClrrVkZLiODtU5F9TZuH2Z9mzA2uEr2nxNhG1WWUWxbffpM9Z1+V8XO2FexJijjTZufmFj0eU4Qfnfe48MmiSgq6oalKpaCJxk1GTAx6dkOO83b8CuSEqX7Vw4pjIOM9EJJ+cy9fTk030CjsuSrjYLT3cSTCi1NUjz9Sjc4QP4qKrqQ==
Received: from bigre.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id 34B0C18000EF;
	Mon, 20 Jul 2026 01:12:07 +0000 (UTC)
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
Subject: [PATCH v2 0/4] power: supply: initialize MAX17055 from battery info
Date: Sun, 19 Jul 2026 21:11:36 -0400
Message-ID: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HH5EhCp4UJEkWnJLSaMY570pr95lCmnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwOSBTYWx0ZWRfX7ZquFG6db8CI
 /x12C948SCjWNVUYhe7bq5BX2vdcMTSXybZ//x+NXHDxxhyy1EIiZjwEHjRDB0oyvFMhvFmRGBI
 thwaFj9Xx6Dvnzap+IULwFUdUobODMKDHWoH/iYu9sWfB1HVfG4QQV3dMz9kb1ImStkXf8BECKr
 bkFnSZd2L761yc5riUeeqp5vjIc0gU93cejhsHOFJdcQ5TYsBFKmxXco9PkUrM9MvM0XSq5lx/d
 7iNYkg+O56rNu2wF93y0ZCzxzWqxbs7kkCWc5LSAghTFn7BwZMCfj6NKUD2Hfwqk1M+wICp1dCP
 BbBEeLok2IEW7a8fiVB
X-Proofpoint-ORIG-GUID: HH5EhCp4UJEkWnJLSaMY570pr95lCmnk

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

v1: https://lore.kernel.org/all/20260406205759.493288-1-vincent.cloutier@icloud.com/

Vincent Cloutier (4):
  power: supply: Add registration init callback
  power: supply: max17042_battery: Initialize MAX17055 from battery info
  power: supply: max17042_battery: Honor MAX17055 charge voltage
  dt-bindings: power: supply: max17042: Allow monitored-battery

 .../bindings/power/supply/maxim,max17042.yaml |   2 +
 drivers/power/supply/max17042_battery.c       | 373 ++++++++++++++++--
 drivers/power/supply/power_supply_core.c      |   8 +
 include/linux/power/max17042_battery.h        |   2 +
 include/linux/power_supply.h                  |   8 +
 5 files changed, 361 insertions(+), 32 deletions(-)


base-commit: f2ec6312bf711369561bdcb22f8a63c0b118c479
-- 
2.55.0
