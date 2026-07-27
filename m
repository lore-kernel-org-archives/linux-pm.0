Received: from outbound.ms.icloud.com (ms-2005a-snip4-5.eps.apple.com [57.103.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E82356D9
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114868; cv=none; b=Pi98CMxdV6i7eXhQiTf3TvSUVwHd/lErmHudmEr/kVF4Q2mdzFt4YqhCivp00N0pIenu2hVAXfdmT+BZGgIpj6F/QpIJbd8dvZaM2p7jp6QNK1rzdfRq7v/9ZJGc/5+QjVerVmnCb63CKJmzINTDy+YkcgRu0D5OvuTJH3s9mPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114868; c=relaxed/simple;
	bh=B5juV0+USfuxKu2dNpoi1evoQRLm5bmww+Kl8YFnm5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcXxko6+5a7jH9Hk0Zay3jHq+XNIGT0Lo5UCTeLnElooX5KVRU8kiRsijyPQo2QdynrQUPdcHoNq1N0QQJD0vHYI/Pk7td2uyljlbNhqLXf6vGUgoexaSLzwwWu8KsJKXTEjdzNRHyEZueeUupbIgs+VtDJtEmVtShAxxsAG8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WkXAIv3u; arc=none smtp.client-ip=57.103.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WkXAIv3u"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 0E58D18000D5;
	Mon, 27 Jul 2026 01:14:23 +0000 (UTC)
X-ICL-RepId: 019fa123-2963-7da2-9dcf-08ce36ab65a9
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgNdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114866; x=1787706866; bh=skkBRN1axDCVZJrAgayJDGSF3TeFFHt+WTJDCoeRW+c=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=WkXAIv3uCFY0nfRo0XaAmAlFEKAu0ItKcclXKPcW2dYiLq4vhuPo0VuFQ91Z9FTyofYwTjOIAMCZw+uLihu341Pg3IdznDCztXRBS7WmyKZ/crWzMWJD4OlgTePM1M7mg35bsxsz5wG/Qf6fO3E9Gx6dvsUChUVAYqxVBdAmgOASa39+dytj7S1HOzGfNL5Ab29PbCGCYMRduCFIOvr4utptZYTS3zrRmAi9f+O5usI1R30FGBXvWO/qdGLhdv5ss9+uySKmjEEOYVjQxPAA7AStuYETO0lzlQWtPWFY4KpjdG4NWu6kaFctfI3L/Jy8JsQlLrG5GPXaldqsBcPQhg==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id AF56018000E0;
	Mon, 27 Jul 2026 01:14:15 +0000 (UTC)
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
Subject: [PATCH v4 00/11] power: supply: initialize MAX17055 from battery info
Date: Sun, 26 Jul 2026 21:12:58 -0400
Message-ID: <20260727011319.621794-1-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=SZ/6t/Ru c=1 sm=1 tr=0 ts=6a66b0f1
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8 a=OKJ5i5EShb3blUtB8gwA:9
X-Proofpoint-ORIG-GUID: 50uDuiHodASJ24jCTLvCM0ZrBk_-4yfu
X-Proofpoint-GUID: 50uDuiHodASJ24jCTLvCM0ZrBk_-4yfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX61fj4GPqxr2Y
 Yp8oiFIj4VMS1QN7zAHUATSF5ixCv9S/5WD18LerbMyuhhz85+/7oEgpEFaQDBN3JUCL/CaVvBc
 YWHoRg8D49cQ73HJOjf6bFBjWYrYNQAtEkxgdOcX2zbtqM5+RnvBwbWqoTVRmu/CipMFwsrXORC
 I0s9hZdXKYTfH7X6IWNMQIpmJz5SAoxsNw97gU4ftHHQ4LEm8JfVC9zub/+TTW+xUaw4u2DawYl
 lRssEuZ+AhrTpC95wsO/Y439D75KppPul00r5zt4VowxEZ3bGqRGa3/7SaE3Di4Kh8ukxz2Hcat
 2G8SUvlM+aHqJu6unETiR0Gi6xZpW+HWgEMIXIKpywRncKtyfCIVHdC/AgBl4A=

From: Vincent Cloutier <vincent@cloutier.co>

Hi,

This is the remaining unmerged tail of the MAX17042/MAX17055 v1 series.
Six v1 patches are upstream, and the v1 cleanup patch is covered by
699f0f71ac98. This revision retains the requested registration callback
architecture and splits the MAX17055 driver work into smaller steps.

The power-supply callback runs after the core parses monitored-battery but
before device_add(). This lets the driver validate and prepare DesignCap,
IChgTerm, dQAcc, and VChg without another firmware parser or a
power_supply_config handoff. The callback remains synchronous and cannot
start activity that accesses the power supply before registration
completes. dPAcc is derived later from register read-back.

The MAX17055 path waits for FSTAT.DNR, saves HibCfg, exits hibernate,
writes each stable battery register once, and verifies it after 1 ms.
SoftWakeup is written directly, and Refresh is requested once before
polling. The driver derives dPAcc from read-back DesignCap, dQAcc, and
ModelCfg values, restores HibCfg, and clears POR only after the complete
sequence succeeds.

Driver-backed properties remain unavailable while initialization is
incomplete. An interrupted transaction restores hibernate and retries
every 10 seconds without depending on POR still being set, so a transient
startup error does not become permanent. The delayed work continues to use
system_wq, matching the original work item.

Positive DesignCap and IChgTerm battery values are applied, while zero is
treated like an absent value. Supplied positive values that cannot be
represented by the hardware are rejected.

VChg remains a masked ModelCfg update. A voltage-only override reads
effective DesignCap and dQAcc and refreshes dPAcc for the selected voltage
range. Zero is rejected. Exactly 4.275 V selects the low range; only values
above 4.275 V set VChg. An absent property preserves firmware's setting.

---

Changes since v3:

- split the previous MAX17055 driver patch into initialization extraction,
  init_complete type/access, delayed-work conversion, STATUS error handling,
  retry, EZ Config programming, POR transaction, and battery-info steps
  (Sebastian)
- retain system_wq when converting initialization to delayed work
- explain why initialization completion sends a power-supply notification
- treat zero DesignCap and IChgTerm values like absent properties (Sebastian)
- make the registration init callback's synchronous lifetime contract explicit
- remove the redundant power-supplies binding declaration (Krzysztof)

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
- allow generic power-supply properties in the MAX17042 family binding
- drop the Librem 5 battery description from this series; defer
  board-specific battery profile selection to separate work

The series was folded into a Librem 5r4 kernel. A temporary test DTB with
zero DesignCap and IChgTerm values booted with the MAX17055 registered and
no initialization errors, confirming that zero is treated as absent.

After restoring the positive battery profile and performing a full
battery-removal gauge POR, Status.POR and FSTAT.DNR cleared, HibCfg was
restored, and ModelCfg.Refresh cleared. The driver programmed dQAcc=0x002b
and dPAcc=0x054b; the live dQAcc had moved to 0x002a after initialization.
The other raw values and sysfs properties matched the expected 4.2 V EZ
Config result, with no MAX17055 initialization errors.

v3: https://lore.kernel.org/all/20260721185904.40756-1-vincent.cloutier@icloud.com/
v2: https://lore.kernel.org/all/20260720011144.1280219-1-vincent.cloutier@icloud.com/
v1: https://lore.kernel.org/all/20260406205759.493288-1-vincent.cloutier@icloud.com/

Vincent Cloutier (11):
  power: supply: Add registration init callback
  power: supply: max17042_battery: Separate MAX17055 initialization
  power: supply: max17042_battery: Use bool for init_complete
  power: supply: max17042_battery: Convert initialization to delayed
    work
  power: supply: max17042_battery: Propagate status register errors
  power: supply: max17042_battery: Retry failed MAX17055 initialization
  power: supply: max17042_battery: Program MAX17055 EZ Config values
  power: supply: max17042_battery: Follow MAX17055 POR sequence
  power: supply: max17042_battery: Initialize MAX17055 from battery info
  power: supply: max17042_battery: Honor MAX17055 charge voltage
  dt-bindings: power: supply: max17042: Allow generic power-supply
    properties

 .../bindings/power/supply/maxim,max17042.yaml |   4 +-
 drivers/power/supply/max17042_battery.c       | 365 ++++++++++++++++--
 drivers/power/supply/power_supply_core.c      |   8 +
 include/linux/power/max17042_battery.h        |   2 +
 include/linux/power_supply.h                  |   9 +
 5 files changed, 353 insertions(+), 35 deletions(-)


base-commit: f2ec6312bf711369561bdcb22f8a63c0b118c479
-- 
2.55.0
