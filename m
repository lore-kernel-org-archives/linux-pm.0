Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EC3B442B;
	Sun, 30 Aug 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103728; cv=fail; b=MI91SvzngevvfRCpcmmBJRXIeztu+4ivxZdBuKPgW5FEX9NWJuiZYCgg3eiXtRRtqv4yv2oNNghzI+vqTrFm6XiPk2Afids5iFGXIHpciemFi7if6tC4sTr82SvdBFTJdaFZpKgsIccSNEgqN6iyaaRN4HemwopRPNDhKiQXuCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103728; c=relaxed/simple;
	bh=1VOZhv+UIqFxdMCH8SmxP9xV9NXO8sm7V4/D1ub39us=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=foEjDU4uCQsYyyECbjQzVAjQgX9xg6bcWePt8vDhgHLAphj8TZrJfuuk0Y5rUHVe+47HdxfIUcX9drgUxHs8nMxZD1uRrOiHy86CAHdjNQRSKJL1CgpqsN9/P/RTsFySZufuvWaDDyRo8pHAHNQMDaONim0b4K6XJHGgiYTmpiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qevw+yDOFVyDIQdvMrX1OQ7OUd3OpjN7/v7rj4oeg6uiewHn2taY/cQzT0MK+guxk+F/v27SWKBEk23ncoK6EDp2viD3SDWU41hkO3dsH/vx/CxxSPfghZsRCeK6ANKh+R/5k3FmfQ2hEoAnf2fZWUGVrYI5IOmyxqeBlodG/+GbgccawmCjPxpyczZCyC71k30X7VzIZQV6TbAJmMgvC8qWBu5MdjwaDHBgZ9gv7hEvz0EWe0vmBXz0InQqoRXyvju3tjmqJ6BOJ6N0FT483IpW5Fq/EVLsSUUTN2qYT+SKgi9wLMd0lc6RdBsKgI2mjQoM90UvV+OeyJx07gufhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J3yj6W6f8jJj3VR6IxxfR0zk4sGMs8NtzBZ81frLvQ=;
 b=C2i+gcwQK4RmoPUfD4TnZ7RwsuQhxGKza7nH5fAH2xY2yqowy7JuAQFO/vqN1vwayaIR0KM9N/3fIfkNKoHwB4LekoaSvBuDUd9+rWeZ5/jmJ6nNQqCT7UF9ETV4A9l7cYF02Pw66y+JmXjVpCgl+wYGegtF0Jd31LXd9qqsSOGXhd3wMT3f6uw38TTUdoLSRlzs5S5tn4uiLm5Rh24FxMLMKA2+UPpwW/caOxan205H/y+AYh9Ms/U9BwFLm8O8uj3MhC8zl9dSmyBnif3L5M2z4GSN6WTOo8pXhJu36LsS1q4lfmNhVX8MpM8YWkqgJX2j50JnJhd71dYo9A6qvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0821.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sun, 30 Aug
 2026 15:28:33 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Sun, 30 Aug 2026 15:28:33 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add RISC-V RPMI device power service support
Date: Sun, 30 Aug 2026 23:28:10 +0800
Message-ID: <20260830152812.312663-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0821:EE_
X-MS-Office365-Filtering-Correlation-Id: 81928ac7-7c2b-47a9-9105-08df06ab59d6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|7416014|366016|376014|1800799024|921020|6133799003|38350700014|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	HyZaw1S0h/gULFkqvOu2beyELQtAprO1pnl6UHfB93w4h8Y6+FsoeJmxzTP0C3PB45ZEgRAiKdyANu4kqkjL+jyQO3e6CoFpRz8gpWZA2xhAeMjOmB5Oe/l1CRG/23xYwc2KQVyE3h+s1nWCpRzQUtqr93b94+ekzWWsRY71tRzpsNWPxDRJR6KDJC7l6BtVaEL/5R11sJkn1Rzf5buNvgCMGd+2PN2GXHJbxBPicdgDhPTdVw9yTkdBPPIsn+MbF9E0sWR/0ymWxRQQ0uMvQ01pIdn/djLzDj4y5bflEN8VQucpKyQx7m/4xY1yjI5rCjnM4aY/xW4tL1iUuQD058rryST7zTXLOJ+ItYCu4Gpn/oa/eHDih6GLS39o2ZE5sUwaX8G6Q6791mUKFIzNPkyTygSEuglUgwLG0Ntedt0vWwMO6U8IZ8r1R4bSz5VJnj+Gh7QdOSRt5A7gHwnJpM84Ow9MsUdujnyY9LH/2HUJ7zwP6ukmQAeO3iq2oitkQ/k6Ozhx4sKWZXM/PaWjKkbGoy0efVU5DHEUKx2pFtysE64maFQE/tqf2YClFDCCQMR4YUjWBWCf6EZghgy4xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(7416014)(366016)(376014)(1800799024)(921020)(6133799003)(38350700014)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eY/unVhVrmaCwNfGSXrPdZlIa124HSNvjLB0zzfrfZeM8QE1SNE3iw9ePJN7?=
 =?us-ascii?Q?18HjBGn8Rn0Sdnd4mwn79B3ZLR5SZPQaiPLOzc0p9jd2laSS7gsFE1bYew50?=
 =?us-ascii?Q?Wki7dhUWE2Ijxx21Ot+FrcfdJEiuj8abQaT6t1HFwAWfRcyglylHNU1TGd8n?=
 =?us-ascii?Q?fTzl3wnxqOoke8lLfk5OgAFG6c/D2Mda6eySLYkQiy1R0OfaBz3OsAPpM+SP?=
 =?us-ascii?Q?n2d+bDRxKKbqpf2a3MRt9kYwqtHuePL+rHuMOzOBVFyEaVLJSJoNaV/LdHsJ?=
 =?us-ascii?Q?Vvt4PghuZdTI69AGDiNGz6i2sK+zPmSprJqwKLG3C4sAjvrkEs5I2TipQXul?=
 =?us-ascii?Q?WjKZRrW0mPh2u2XtBhRAylGgv1vHq80sWyczohFlcMTS2P8Gq0P6hWYIoiRA?=
 =?us-ascii?Q?xAxifNDXv4p5hvxeJTTAZy3UHT3+N0IEf0+PXLU3vENmRYVnlg3TkRMWuvI/?=
 =?us-ascii?Q?KokNOel7xW/G5F5YZqL+ep9SNOaXUfBzo9eDMYbFqAWSmFpLQybRSgNsxyIf?=
 =?us-ascii?Q?hvUEMks6NEBgunWu0P38ZFDSaSf1bS3NuNOD5fijfl86cVYnT/4Y+cklzxNU?=
 =?us-ascii?Q?pbk+M16M19YDEVxSJUQftmxhCyXmk5KL3U5aBxJNwpHz5I4xHEO8/mxsFTlF?=
 =?us-ascii?Q?VO8IHv3sPAhc6a5hXcHvQ1a9OPP1AM/TjvuZrXkAztwNTn9m/oRrmOC06Yp2?=
 =?us-ascii?Q?5mFnQsfgvaTWX7HEr3vUH0643m+ifp+vOMtBlJLc/Uhi8uY3b3yJOrvQvR7u?=
 =?us-ascii?Q?jgMtFkDPlRQn+E61wyDza4wPAY+2k2qptZJ2oETIlMGMqm75Pt7DTHs9ey61?=
 =?us-ascii?Q?5W58flfnWHKsgEImVnJIZl7dPbNCXPLLLHgeuwa2/SwtYgGs4n19M3VEHmPj?=
 =?us-ascii?Q?JyGZba96nkInLU11ImRLX+zQu49VtfOcUHRudb1XWiOXn4/J24QUhFYG0r77?=
 =?us-ascii?Q?QA8QUCBgUcmceG+y2Xr68YUY3mDsMTypBXRugiluKbzVXUyqNyC/0wftJZXU?=
 =?us-ascii?Q?ceh2Vog9dOisgEKrC7q+rIhcPIWSo6BjZHyJxTpDkaDLC9LF/o3DytSCr6OL?=
 =?us-ascii?Q?7QSczyWZwxpq7mkSRuC0A3fNqZX1rwOdx5V+H8WO7X0kZh+iEjuhcrFp0fBR?=
 =?us-ascii?Q?hyJFzZaEUlxQ9AkWkgC/Kerqloa5zxuIMg5rlG++T3BwRzylmfmyGIS3VoLz?=
 =?us-ascii?Q?Fn3nbEtrQnuuAb+VHZl+v7uB0xWl6nb4gFehM1AtEWylcc/xpLX7eodmmKvv?=
 =?us-ascii?Q?jwiFh6EzDj8FYIBwBA9mOE/RCFlWTNi2HLTB0CHwRcBBS0qq2eQ53GL005N1?=
 =?us-ascii?Q?NHNlHDXesHM2S+xmH0fhKme2JWC7aNt02/ea5+BjYQai9H3PcOqQhEdoR6TI?=
 =?us-ascii?Q?g3P5EQbul8CQWGw0MUouLhf5a8mtYKhyJqTaRrIl6Zxo4SiHI9wCE3n5GDrm?=
 =?us-ascii?Q?bWx7iRqQeDrH/z/iPy3VLgWPbqVO1GC7p+qgoNLSRj+toJ85v7pKOnIQr+OZ?=
 =?us-ascii?Q?T3bEdpH10VqxuwlGM9H74CvuuTE9qjrKYdW37zy60tW0GlE5LL6msPPSgRvA?=
 =?us-ascii?Q?MI/6rytt3f8olVX4G1vXh43MVcKoEXd4WfYC3aWw08gzGIDqCYc1Jh2VTaDU?=
 =?us-ascii?Q?30iPCI99Ar0cR/pzKX4XwyyAWs3xLWJNOaPrXtqqpqxy2LfYH+kCEdhXMGrG?=
 =?us-ascii?Q?CsP4cYbX7ehyz4YrfFeKky8F6eP9jHXcalwuB/Ni28LOg7DC+htxl7jjeayk?=
 =?us-ascii?Q?IJAfvTuxE0bZpqmLxOLkbLBsFxZjnyM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81928ac7-7c2b-47a9-9105-08df06ab59d6
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:28:32.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO5j90VjrDVVBbgAz1k+pWRop7PUSV7EeoLeND9fqcKWSu5OsFjtfatIuPeP0gar83nOY7tKOwE5VSQMdO3M4BrdMGOg28nvW65yzsTxiS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0821

The RISC-V Platform Management Interface (RPMI) specification defines a
modular and extensible messaging protocol between the supervisor software
and a platform microcontroller (PuC). Among the service groups it defines
is the device power service group (service group ID 0x00009), which allows
the supervisor to enumerate the power domains of platform devices managed
by the PuC, query their attributes, and get/set their power state.

This series adds supervisor-side support for that service group:

 - DT bindings for the power domain controller exposed to the supervisor
   ("riscv,rpmi-device-power") and for the SBI MPXY channel that the SBI
   implementation uses to expose the service group to the supervisor
   ("riscv,rpmi-mpxy-device-power").

 - A generic power domain (genpd) provider driver under
   drivers/pmdomain/riscv/ which talks to the PuC over an SBI MPXY
   mailbox channel. At probe it queries GET_NUM_DOMAINS, then for each
   domain queries GET_ATTRS for the name and transition latency and
   GET_STATE for the initial state, and registers the whole set as a
   onecell genpd provider. Domain power on/off is driven through
   SET_STATE with the generic ON/OFF power state parameters, so devices
   can simply reference a domain through the "power-domains" property.

The series is based on the existing RISC-V RPMI/MPXY infrastructure
already present in the tree (drivers/mailbox/riscv-sbi-mpxy-mbox.c and
include/linux/mailbox/riscv-rpmi-message.h), and only adds the device
power service group definitions on top of it.

Changes in v2:
 - Serialize RPMI transactions on the shared mailbox channel with a
   mutex. The channel is used in non-blocking mode with client signalled
   txdone, so mbox_send_message() only submits a message when the
   channel is idle and silently queues it otherwise, returning the ring
   buffer index. A concurrent caller would therefore see success, return
   with an untouched response buffer, and leave its stack allocated
   struct rpmi_mbox_message referenced by the mailbox ring.
 - Unwind the already initialised power domains with pm_genpd_remove()
   when of_genpd_add_provider_onecell() fails, so that devres does not
   free memory still linked into the global gpd_list.
 - Set .suppress_bind_attrs and drop the .remove() callback. The domains
   are handed out to consumer devices and pm_genpd_remove() cannot fail
   safely from a void remove(), so unbinding is now refused outright.
   Use builtin_platform_driver() to match, since the driver is bool only;
   this also makes a later switch to tristate fail to build rather than
   silently reintroducing the problem. Both match other genpd providers,
   e.g. drivers/pmdomain/starfive/jh71xx-pmu.c.
 - Use __le32 for the RPMI message fields and convert the responses with
   le32_to_cpu(), matching drivers/clk/clk-rpmi.c. The requests were
   already converted with cpu_to_le32() but stored into plain u32.
 - Zero initialise the response structures and reject responses shorter
   than expected with -EPROTO, so a short reply from the PuC can no
   longer leak uninitialised stack into a power domain name. The length
   is checked after the status field so that a legitimate error reply,
   which carries only STATUS, is still reported as the RPMI error.

The v1 review also asked for a sync_state callback, on the grounds that
domains initialised in the ON state would never be powered off. That one
is not addressed, because genpd already handles it: for a provider node
with a bound device, of_genpd_add_provider_onecell() installs its own
genpd_sync_state() through dev_set_drv_sync_state(), which clears
->stay_on and powers off the unclaimed domains once all consumers have
probed. A driver supplied .sync_state would in fact be refused, since
dev_set_drv_sync_state() returns -EBUSY rather than overwriting an
existing callback. This was confirmed under QEMU: domains reported as ON
by the PuC with no consumer do end up powered off, while the domain held
by the RTC stays on.

v1: https://lore.kernel.org/r/20260829205520.1691-1-joshua.yeong@starfivetech.com

Testing
=======

The series was tested under QEMU with the RPMI device power service
implemented in firmware.

Components:

 - OpenSBI: latest master branch
   https://github.com/riscv-software-src/opensbi

 - QEMU: the RPMI-enabled tree at
   https://github.com/yeongjoshua/qemu/tree/rpmi-v11.1.0

Kernel config: enable CONFIG_RISCV_RPMI_DEVICE_POWER (default y on RISC-V
when MAILBOX is enabled) along with the SBI MPXY mailbox driver.

Run with:

  qemu-system-riscv64 \
      -M virt -m 2G -smp 4 \
      -bios fw_dynamic.bin \
      -kernel Image \
      -M rpmi=true \
      -nographic \
      -initrd rootfs-busybox.cpio \
      -append "root=/dev/ram rw console=ttyS0,115200 no_console_suspend mem=2048M earlycon=uart8250,mmio,0x10000000"

The RPMI device power domains advertised by the emulated platform
microcontroller show up as generic power domains and can be inspected
through /sys/kernel/debug/pm_genpd/. The series was additionally booted
with CONFIG_PROVE_LOCKING, CONFIG_DEBUG_MUTEXES and
CONFIG_DEBUG_ATOMIC_SLEEP enabled, with no lockdep reports.

Joshua Yeong (2):
  dt-bindings: power: Add RPMI device power service bindings
  pmdomain: riscv: Add RPMI device power service

 .../power/riscv,rpmi-device-power.yaml        |  65 +++
 .../power/riscv,rpmi-mpxy-device-power.yaml   |  65 +++
 MAINTAINERS                                   |   4 +
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/riscv/Kconfig                |  13 +
 drivers/pmdomain/riscv/Makefile               |   3 +
 .../pmdomain/riscv/riscv-rpmi-device-power.c  | 466 ++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h    |  11 +
 9 files changed, 629 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
 create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
 create mode 100644 drivers/pmdomain/riscv/Kconfig
 create mode 100644 drivers/pmdomain/riscv/Makefile
 create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-device-power.c


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.43.0

