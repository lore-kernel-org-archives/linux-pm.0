Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEB2D2381;
	Fri,  9 Oct 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518450; cv=fail; b=LmmTAXqLGp1NfPcMwvP0RMcj6kwpDsr5Z5Fn0wm1394gnqnjw3C3mXDbk8luN7j1DWm1afhHSzKU94fhno4M+Z8L4rWme0KMD21qBQuqdnzbkDc18L4hoGvQHPFZUYepKaROs/nT4JJZsrMNEKZmEiJfz+DnoBw8SX4gj/QWCFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518450; c=relaxed/simple;
	bh=11D6sT1ufmxCHyuKFBfy4NrdN1jUSVm2z+xZHyNfHBk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=aYh4ZvYmMUKLQN3qqnGcZ/5X1mdbPV/WGpbKuCkgA/EiGgYEfcfp5eR1kUxpi6a7SdXP9YqAyOUcC8Vg8taLfmGUX8LRh1rC8ZvzTEMkT9N3Vx1/VAFUCIknLDXpWQKQ9oRLcH8QV/xmNWEZU4Q61Z0Nl7m1xuCz9wmXs+kPT6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mKH2CWQy; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mKH2CWQy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0dfqZMrZ+wuGjMO5NO/VAoM1qYrSlSwhvCf1v+sqxwJbdrjN2107ESkUknoiHsRlm2vky0RU3QO6wY7U4BOTKN/hghoyNy1kGFwcHeIjvDPbGl1H/N+uw0OpoDCTImihadHBjdRBMTQL36Xdt/aKklIUw85u66TFRYQEITM7GN9G1SdzS3r+3RLEtXQKAdFtdL4/WMhxmOAs70Wbvoz8BhXbJpeVzN39N3FdR0oEk570whgjGcHGDzTy5BD3Zos/phFSUI6M+ElW5zPVbObtoFZU3e/PQglqqzDOmooIIQHE7axyOjy7+C2wTl6PWfRwxnjWxAYIsLGiYhuwIkXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj2aOik/B9GOzAeIYWcnaoepoqrCkSFyQZ4gZ6vtX58=;
 b=ApvEtUcS5DlflUS6fECIGEBrRllHgW8AeoOxtZ6u7WMVjNa7GAyC5FOKrkrHb49sPMSI2ULUg8T9KV1vHtagKFLzAarr1k8O5e9UEeK+45Nb+zTyGTnrvkH44IdywtYhqylh76uRZTHrFSBhRhDLvF4WwVzuF6Nyn/sd6uKxCv1i0ui9LYS+9CHN9FvjBSF/IbdY/Gjss/q+pKL6BtwV4DGDF8zXHaTSzsqlYRXUMT/5eZ8ui16Wk9L3RS2apumUhmuntHALdU5OYTwlEJxrH6WyRLtEIgDedfMBwBsMMOvMzAbjelW3Mh0zlQVupVXuCnkN6fcyQaFZNYRi3FCMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj2aOik/B9GOzAeIYWcnaoepoqrCkSFyQZ4gZ6vtX58=;
 b=mKH2CWQyvobCPib6pAEmkajYK+aoxkJSj6fW7rrHFFCVGthcNv53A5c3Z/Tw1b4Fzl3Vu/f7Wj18kBsli2LXl67dNJ1vUa1iceqcgkkr7HYD/X9mRMUHDg1l+3qRFuuKVLaFGJ1uBOvDiiYhNsQeFRpG/Ad8x/bpq7QbLoNXCfw=
Received: from DS1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::17) by
 SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Fri, 9 Oct 2026 04:00:31 +0000
Received: from CY8PEPF00000052.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::21) by DS1P221CA0020.outlook.office365.com
 (2603:10b6:8:242::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 04:00:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000052.mail.protection.outlook.com (10.167.247.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 04:00:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:16 -0500
Received: from xhdnaggolla50x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 23:00:12 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
Subject: [PATCH v4 0/6] dmaengine: zynqmp_dma: Per-channel reset, IRQ guard
 improvements, and PM fixes
Date: Fri, 9 Oct 2026 09:30:09 +0530
Message-ID: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpmyGoC/x2NQQqDMBBFryJZdySOqYSueg9xMZipBkwiE5EW8
 e6NLt/n896hMovnrF7VoYR3n32KBcyjUuNMcWLwrrBCjV2jtQVygWAN8PFfoOhgZYHrGXkB4cw
 bOItIrTFkuVPFswqX893oh8Kzz1uS353c22u97do2uhTME2uDXYsaGog0cXRC9ZSWhd4UXD2mo
 IbzPP8HXPy0ugAAAA==
X-Change-ID: 20261008-adma-pm-fix-and-per-channel-reset-d822a344a8e6
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Michal
 Simek" <michal.simek@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Tretter <m.tretter@pengutronix.de>, "Harini
 Katakam" <harini.katakam@amd.com>, Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <git@amd.com>, Golla Nagendra
	<nagendra.golla@amd.com>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791518416; l=4446;
 i=nagendra.golla@amd.com; s=20261008; h=from:subject:message-id;
 bh=11D6sT1ufmxCHyuKFBfy4NrdN1jUSVm2z+xZHyNfHBk=;
 b=fFvKej+zfwSFOlgJlG1TXU9TNwx97Ot3WHdNN4Jy8CaczJXhXaN58HZCpZa41GR2QgdGgU+N+
 U98rgIFzDXbD+zmfoU98ySpmr4Gi3C5jQM/xR0jA8YZysicLCH2bFZF
X-Developer-Key: i=nagendra.golla@amd.com; a=ed25519;
 pk=pCRGj/0mb0C3aDMpVVZeyBqOIQZUKGJjCKL4QZTu7nQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000052:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9146b1-1fe6-423a-3cc9-08df25b9dc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|7416014|376014|82310400026|921020|56012099006|11063799006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Yp0QXW6QTSc9VUdtnX/ZdFMQi/TIrlN/tUqrd0z3TkfUvTpb+h4UuWuwrDTDuInwe7HFruQamrHsLJg6C/s6thiviLR+kCuq5fTx3ROvh31RVsze4duvwC8ZncqOBKwSpysAP9hcxcoC9sxf9srOwhWFTfLkr9jKlXXifnN/LV7UJ4xl20vKbYvbWApisCUEraaZoNn+jJ07bkQ9K1qK6IZBUJ/SZQxWC0v0iSGKbtjck4d3nsRY2vDWCi+QDt8ZJJ1DA8gYP8S33miv+4rwuiJWHU4MVmv8dqDJc2ZYhKiLNOCSnhoKiFNnFT/UT++aqcMs1VeqVvf+xmqReXJm5dYCJZ6kM1IclXBGm4Tofy5oQnTsEREniHBnJNVtWUBjb90Cykf0ooP+N5MSZBdlh9zdAMhRXy9ffc3gJx/RC0IHkSoAmI5GYvcg+i3298tnb10ZkK3ZtojedBAvWNmssrLooFyRbDrRjyKncFTnwNZkxfWGfYZL0j9m7/WVNf+MToEuIL49dzqo1Hfs+CZKARF0CI1/1nGN425ukxTJnXBb6CXERcOQU8G8nifi1tRHEeX/r/BBLxvP04hZwv8N7lbu7y3IcFd+1e3eABFWDbJO1zAUG5i9u5HCFFTJCWxN87otf//LRJ5MYE9DfiLJjp74oU3NjMVL9kR6+vn2rli36Z1BIevoWoSc7rpvqXpDDcmimrQaC+hZPgxoW3H1w2GrS6v8iJj2FZUin080ZPG8Dyp/jpfB8B568JpUVA6I
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(7416014)(376014)(82310400026)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RVfLe9/jF0Jgpo1fCZvBFPUpMW2dIJkbyYUugopYESt+tyivsQm/KvxMH88t6xg3pQIMXZQ9kE42YRt3kQNoIfjsMyLaAZ2Xq5ld7OlId/MbehYGFdDC4BETBbssNprloBt7JMbQQNnDeWfThPH5lqzc8iPXfkXHqGZ5y15qmwaR5JkYCY84rHkzTRXOgrxPL4HARvCdUyZ63A3lQO7pMH2a8dt+IiFknNJ9yEQXgWRvY3la7KvTinUEOWkhR91MnPvzyqf/tuZn0vDF6CBp9qG2Ig3n4X1h59QRGvIAP00BIfQCKLDqiHf7UTD7B3TEgwMKHoB7vk8w65Ho1Ojre3hnZpTsmyuwk/z1TZFTVIEk3WTsaSod1gLZh/UGwndRYGPOjOt9Xpe/4wmzt5Oai2yVC5WBw1DtMl/OSjDEezDOVX47MQe669H9RJQv40RP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:00:30.5739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9146b1-1fe6-423a-3cc9-08df25b9dc64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000052.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066

This series extends the ZynqMP DMA driver with per-channel reset support
for Versal Gen2 and Versal Net, improves the runtime PM guard in the IRQ
handler, and fixes probe-time runtime PM reference handling.

Patch 1 replaces pm_runtime_resume_and_get() with a scoped
PM_RUNTIME_ACQUIRE_AUTOSUSPEND() guard for the probe-time runtime PM
reference, and adds zynqmp_dma_probe_pm_put()/_fail() helpers
so every probe error path releases the reference and gates the clocks
deterministically instead of relying on goto-based cleanup.

Patch 2 adds a pm_runtime_if_active base guard and its _try conditional
variant to pm_runtime.h, used via PM_RUNTIME_ACQUIRE_IF_ACTIVE(), so
callers such as interrupt handlers can acquire a runtime PM reference
only when the device is already active.

Patch 3 uses PM_RUNTIME_ACQUIRE_IF_ACTIVE() in zynqmp_dma_irq_handler()
to return IRQ_NONE when the device is genuinely runtime-suspended, while
falling through to normal processing when runtime PM is disabled.

Patch 4 updates the dt-binding to add the amd,versal-net-dma-1.0
compatible string and restricts the resets property per-compatible using
allOf:if:then:, making it required for Versal Gen2 and Versal Net and
explicitly absent for all other platforms.

Patch 5 adds the amd,versal-net-dma-1.0 entry to the driver match table
with a dedicated versal_net_dma_config carrying has_reset=true.

Patch 6 adds reset handling in the channel probe path, using the
has_reset field in zynqmp_dma_config to conditionally call
device_reset() on Versal Gen2 and Versal Net channels.

Changes in V4:
- Patch 1: Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() instead of
  pm_runtime_resume_and_get(), and fail probe immediately if the guard
  acquire fails. Add zynqmp_dma_probe_pm_put()/_fail()
  helpers so every error path releases the reference and gates the
  clocks without goto-based cleanup, and pair every direct
  zynqmp_dma_runtime_suspend() call with pm_runtime_set_suspended() to
  keep the runtime PM status in sync with the clocks
- Patch 2: Bypass the guard when pm_runtime_get_if_active() returns
  -EINVAL, covering disabled runtime PM and CONFIG_PM=n, so interrupt
  handlers keep servicing interrupts instead of bailing out
- Patch 3: Remove the IS_ENABLED(CONFIG_PM) condition from the guard
  error check, since patch 2 already handles disabled runtime PM and
  CONFIG_PM=n inside the guard itself
- Patch 4: Move the allOf block under the required field
  Add the new compatible string and the resets property in the example
- Patch 5: No change
- Patch 6: No change

Changes in V3:
- Patch 1: New patch - split PM usage count fix into a separate patch as
- Patch 2: New patch - add PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard and its
  backing infrastructure to pm_runtime.h
- Patch 3: Use PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard instead of the manual
  pm_runtime_get_if_active()/pm_runtime_put() pair from V2
- Patch 4: Use allOf:if:then: to restrict the resets property per-
  compatible with resets: false for non-matching platforms
  also expand to include amd,versal-net-dma-1.0
- Patch 5: New patch - add amd,versal-net-dma-1.0 compatible to driver
- Patch 6: Introduce has_reset flag in zynqmp_dma_config to gate the
  reset path; PM usage count fix split into patch 1/6

- Link to v3: 
-------------
  --> https://lore.kernel.org/r/20260810100452.426320-1-nagendra.golla@amd.com

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
---
Golla Nagendra (5):
      dmaengine: zynqmp_dma: Use PM guard for probe-time runtime PM reference
      PM: runtime: Add pm_runtime_if_active guard and conditional variant
      dmaengine: zynqmp_dma: Guard IRQ handler against spurious interrupts
      dmaengine: zynqmp_dma: Add new compatible string for Versal Net
      dmaengine: zynqmp_dma: Add per-channel reset support

Jay Buddhabhatti (1):
      dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net compatible support

 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   | 34 ++++++--
 drivers/dma/xilinx/zynqmp_dma.c                    | 90 +++++++++++++++++-----
 include/linux/pm_runtime.h                         | 27 +++++++
 3 files changed, 125 insertions(+), 26 deletions(-)
---
base-commit: 2576c937f7b442df7de8e39332ff585f08b666b8
change-id: 20261008-adma-pm-fix-and-per-channel-reset-d822a344a8e6

Best regards,
-- 
Golla Nagendra <nagendra.golla@amd.com>

