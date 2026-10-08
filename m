Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A16477981;
	Thu,  8 Oct 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450707; cv=fail; b=JROElSR5tHn62+p6UeSLmjCjTKzET7IvIovMrjLMmkdyXWgvn9JokD0VOSNA4LwejtYd8Amp1XgLcLj6uiAi2i7KqQOoikbnOYf7l1vPq5I4LvxzhnrHzFADTbt85GrTrovfljh/Kvgp70umFrbvMg46dSTkqKnuBzsf2FxBgCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450707; c=relaxed/simple;
	bh=R3/iX6ZC4avWQp1BJlg8RYIzJInazzJ0ctvt6zioSKo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EKPEZFEwXOtLPet23aOoXfknCFl9b+Ppu20qI4gL8Dy36MKVUhKTsSMqMnDHY9ETwrkGYKs7i1dBO52kMf1TVDjHP/2VIOt9k7Ou++kMf7AXqBjA7skijA+2MTLkjgV2dbtUyzu1+GtjELHqOXV5cLfwj04F5HZDI6wd5lptsgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAkozTZjhWJxSO99mAKh60+UalrUGS5GRl4qE7NJN8AmCjv2de5RRPGzE1CWGzndbrjbs+jskTF688dajEnOiBeqkEbRbH38JYQc1fGfVLuqv7Ee3XGqgfVtp5yQBTCJ6XybwPDkYwe9JFOEsVgliBqqzsNB9o6ypsoLSdwkqJ3uJ01VhC/HKeBPEDsUsVa82bDDQS9QwbpbVW6/2ZcYoDubprOubjCvuw4jTnS8vU8A0T03p8LxQH5oxCxcSGxZKYdqIlct7tNB2AKnEehKCMyskImkxc8c5DyIZK4fuVr2IHq0YSe1XpU5mPgzgEcQWQ22abnMuoKJJVkFYtnMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GbqlGt3YchyV3gtIj30g2hW9T1pc+LU0E6nXL4yeTE=;
 b=Bxu3QiPD6CTRP4viowLtEa0SBRlzogimwxDotM+X8ZJFg1GW5+chzSFf9TcUmo6sZDx8atWTVCyTqGpNEitMkTEmzrxJoouSp5qs7rbPNAEuNAFbRLr/ClHpFoWAXWqUTO3ej50n67BOt66uqSnup7x9BqcmqNpTYRVFHMtx+Zf/6GRRr0tAiynBXSkUEdqZI7BuiEYGmNFUPDdVZpA890PQBpRJiS8V63n1QhkychPUyr5Jdl7/dsiuSv3+2OOkxpBpfirLvj9SVnBC+hqCbxActJTLtGCoc47nt9ch4yP/c9g02JNYANp2c6ZZiIRg72m40ZR2uUBqIA4yytpZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:11:35 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:11:34 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ulfh@kernel.org,
	rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add RISC-V RPMI performance service support
Date: Thu,  8 Oct 2026 17:10:24 +0800
Message-ID: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1325:EE_|NT0PR01MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: 87540d22-10a1-4dab-769d-08df251c2653
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|56012099006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OG3e+N4HsVlsHo3pZdGZnXBec46zMZSRcOEnQexV3IEsgYjVvGyfZj4ncVTZ4crHleFJR/cPUd8Z+E2DwPXBJB4+e+VNvu4zzJNDn+CClz82NWkqYfG1Un2212Rm6z4ziyzEwczY3uzaq3TRy0VH3dGkUYjETipBPKH8kmXgM4pogV/nzvBJGDQnM0IcvsOkpfpg5D5Ab+u0SKcY5f8uAtrpDDriLClzgU0V2clEANOizd9pEW8JrptuDFK/IsozmtrnD5OkTP8PCHb6KJdsBTeEvqhdVo6H90x9friiobZ1I9TthUVjxeiGG0NeOsjU0RR1sotM+7kIwur+M0A8d1JsEAjd/mf/hrwC9H4OWOwp0onXY09BtuYOT+Hus5XV+FYh0NWN6YYvaiB0pFQORnFWK4tPMtCgNH+EzdHxk6K0l7Zp/0PHzQ+9pqvX9+9YLq+a3ORp41jFx9qJ1Fu+pl73pjXxx8mtbekKs+dGk/ssdMuIDttEfoLxM6TlIDZl5DOkJv0BT1bFj14zRJnaZqZDrlegc26FwQbh0m/YbQsrcfqpknxuDv3Qaw5JHNU+MvEUSGnBUX1YVDx+2/EUlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(56012099006)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5l+CtLTY7wYARPg1I/nNcxlaS+/EobFNKNz6gz/j/JL9ADV/ZwpSbQM4hBtZ?=
 =?us-ascii?Q?zS3ARrSlzFrjJchzAG/wKmfvvCf28ww60lYMWsjcGsv7eQccKRowDEceaIwF?=
 =?us-ascii?Q?vyuGQYLvytX3spd1VoWFov0145WVb/Nr2yCzlFpmOSN2m8hB8J5uecYm65ct?=
 =?us-ascii?Q?w3/v1x6sDGtQ/9ia3HPf4xJwTVYeWG0wEGrmpYjD48+h5VrbC+JK5Dky0NR3?=
 =?us-ascii?Q?107ovTGAVltnM+Mt0yc3Rb+i2kMw0fY4A0lzSMzhM497BIBCFWL2PFLnKCY9?=
 =?us-ascii?Q?m7h68XhQOKVNufQ+WrcMPqV80n7c6mO72+LmWgx6f5w0y1baN9QXgsxPFuJe?=
 =?us-ascii?Q?x/gcAI/RsY16baOhobOYCyRsK5ALvsf9m+7ftE8FV2Ji4WqgDkdQ1xJaoCrh?=
 =?us-ascii?Q?HG4sUMPiARvdEWfZEIjSSxq4YYYP0GTK7pyr6xncneh+v6auQqetRbkIp1aD?=
 =?us-ascii?Q?rebkpjmU3BB2OnzoUh2PiFMPZhm0/Vhk339iNRVPC+6Q+IC06+QEPV+mmDxH?=
 =?us-ascii?Q?sIu0MnJuZkHMpbu77fElKESFfHd1vdZnlbqlJjcl76euHLH2lFyuxABKsUNC?=
 =?us-ascii?Q?qEoWHV2OcAb23QN5LxQWZSLnfctD+SMR65TfZwT5c+fq2S+g507IZsNQ0J9E?=
 =?us-ascii?Q?roF8H2ylo9FFPD3sIRhkV/0eaXjNvCwhvh0Eb1Te5t2R/QbUjVH+DPmsFx8G?=
 =?us-ascii?Q?pALzoUUjsh24ze3xxAp9f3JEmQ4AsH35ReFykdVfSVM0NQeB6i/VZnu/MD/q?=
 =?us-ascii?Q?9KSodH1LXH6Z2vOgOBw/6n8SrySNx2leYFuxinyn5NEUoNDZl38hO3t0C0VF?=
 =?us-ascii?Q?hezYGidSZ7PSjlWieeXbvfWkxRWyGztF1z90hxZjETbhb0JJlRGkSiHMoK8k?=
 =?us-ascii?Q?rxqNIlCAerrQ77DLp0yLqPZqLXBodOeOwSBqCvOx0F4i9A1HsBhnsdGddZQ/?=
 =?us-ascii?Q?YlmFAeXAkKIH4IxZ/bAlLNNWm0ATV9F3pPZRBKi9f31zM62qx7XE9JkWXHaZ?=
 =?us-ascii?Q?35rKkfTejbT36noj4PaKMbGU0SOJDi5pGiSfQx4FMny4qpJn5MQUYsZW6fPv?=
 =?us-ascii?Q?6SL2HyQVsWRUCQ+yBLlmSs4EEI4NOVBRGajVPQ91XCOm4UXVrBb6fRZGCAOu?=
 =?us-ascii?Q?dmeKkvbiEExJ3G7mlIiybry3lIHUKZMG4PkDmlkSfvvujpe4pgRMLVNuJq6i?=
 =?us-ascii?Q?9aU/juAfKCWBDDScEJlF48QQ16G6+Sa+172uT7NqNZusg0a5lwUyLgwQXOiW?=
 =?us-ascii?Q?hGR/rcbsbHp44IuewwfS6Por9z9+cmfYtMTqlGCk9C7vwh9qM6YE3mtSo6JH?=
 =?us-ascii?Q?C3j2nhXaqw952VW3ESe5AAp+Y3ynNPNKAXGEY0s+sDpt3iw7V172WTZoAEKk?=
 =?us-ascii?Q?npcYZkxk1PtxK9ZJ2hWQem4ab4m4Hb6claCUBquFollMiQmaqN2j+vJQZLdV?=
 =?us-ascii?Q?5NLE3wxiTriqKV7vW65jz/+SdZV6eq9bBOk9oa93+xs8NCL+WPZKlDcXrNb7?=
 =?us-ascii?Q?opcfGxXyQy+b8dGO1CLnKqmxMcdocP+PTKV+edBlWaw3HJJVwVWSjSJ/GDnb?=
 =?us-ascii?Q?+SO54UWUdJwvsnWo0FzyRjY0FSK3oy0AjX+TNtglGFHR4UhwlF+RkD4qtNLq?=
 =?us-ascii?Q?ra53Sg0moc1wESfE4RaPTvXof5Lm7N2JsMEgsI/85J5Xxa7p2x3zVtIEMkhG?=
 =?us-ascii?Q?JkakdqQtHuW//XJr9iYMH7dtaWEULVQz0zv9QCKbKRgx7wGMLSXvoFrkF7Lv?=
 =?us-ascii?Q?QhmROHGpCyRwZBhVT6kRntS0OxijoUI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87540d22-10a1-4dab-769d-08df251c2653
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:11:34.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlvpt6xaGcFp9i3RBPmvHLHAwGRFoVblMdZYLf4o0lasCI+nQq+QQSDQuVsonVt7plA7FeFdShvkp1BFNxImQ3ZH2T2wf3WSqIkyukrrk+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

The RISC-V Platform Management Interface (RPMI) specification defines a
modular and extensible messaging protocol between the supervisor software
and a platform microcontroller (PuC). Among the service groups it defines
is the performance service group (service group ID 0x0000A), which allows
the supervisor to enumerate the performance domains managed by the PuC,
query their attributes and supported levels, and get/set their
performance level and limits, optionally through fast channels in shared
memory.

The specification says the service group is primarily meant for devices
such as GPUs and accelerators, though it can also be used for application
processors. This series adds supervisor-side support for both:

 - DT bindings for the performance domain controller exposed to the
   supervisor ("riscv,rpmi-performance") and for the SBI MPXY channel
   that the SBI implementation uses to expose the service group to the
   supervisor ("riscv,rpmi-mpxy-performance"). A CPU names its domain
   through "performance-domains", documented for RISC-V CPUs. Any other
   device names it through "power-domains": the controller is also a
   power domain provider, with one power domain per performance domain
   and the levels of the domain as the performance states of that power
   domain.

 - A core for the service group, drivers/firmware/riscv/
   riscv-rpmi-performance.c, which owns the mailbox channel, since the
   channel cannot be shared between drivers. At probe it checks the
   RPMI and service group versions, queries PERF_GET_NUM_DOMAINS, then
   for each domain PERF_GET_ATTRIBUTES and PERF_GET_SUPPORTED_LEVELS, and
   sets up the level fast channels from PERF_GET_FAST_CHANNEL_REGION and
   PERF_GET_FAST_CHANNEL_ATTRIBUTES. It exports an interface to read and
   set the levels and limits of a domain, and creates the devices the
   front-ends below bind to.

 - A cpufreq driver, drivers/cpufreq/riscv-rpmi-cpufreq.c. CPUs that
   name the same domain share a policy, the levels of the domain become
   its frequency table, and the level is set through the domain's fast
   channel when it has one, so that the governor can switch frequency
   from the scheduler. An energy model is registered from the power cost
   of each level.

 - A power domain driver, drivers/pmdomain/riscv/riscv-rpmi-perf-domain.c,
   which registers each performance domain as a generic power domain
   with performance states. A device that attaches is handed an
   operating point per level of the domain, and its driver drives the
   domain through the OPP library, with devfreq on top if it wants a
   governor. Several devices can share a domain, and genpd runs it at the
   highest level any of them asks for. Performance state N is RPMI level
   index N - 1, since genpd keeps state 0 for "no request". A device
   that names a domain the CPUs use is refused, so that cpufreq and genpd
   never both set the level of one domain.

 - A MAINTAINERS update adding the drivers and their bindings to the
   RPMI device power entry, renamed "RISC-V RPMI DEVICE POWER AND
   PERFORMANCE DRIVERS".

The series has a prerequisite: the RPMI device power series ("Add
RISC-V RPMI device power service support"), which has been applied for
next:

  https://lists.infradead.org/pipermail/linux-riscv/2026-September/099498.html

Changes in v2:
 - Split the driver. The RPMI protocol, the mailbox channel and the
   domain enumeration move into a core for the service group under
   drivers/firmware/riscv/, and the cpufreq driver becomes a front-end
   over it.
 - Add the power domain front-end, so that devices other than CPUs can
   use a performance domain. CPUs changes the performance through
   "performance-domains" and other devices through "power-domains".

v1: https://lore.kernel.org/r/20260106092117.3727152-1-joshua.yeong@starfivetech.com

Testing
=======

The series was tested under QEMU with the RPMI performance service
implemented in firmware.

Components:

 - OpenSBI: v1.9
   https://github.com/riscv-software-src/opensbi

 - QEMU: the RPMI-enabled tree at
   https://github.com/yeongjoshua/qemu/tree/rpmi-v11.1.0

Kernel config: enable CONFIG_RISCV_RPMI_PERFORMANCE,
CONFIG_RISCV_RPMI_CPUFREQ and CONFIG_RISCV_RPMI_PERF_DOMAIN (all default
y on RISC-V when MAILBOX is enabled) along with the SBI MPXY mailbox
driver.

Run with:

  qemu-system-riscv64 \
      -M virt -m 2G -smp 4 \
      -bios fw_dynamic.bin \
      -kernel Image \
      -M rpmi=true \
      -nographic \
      -initrd rootfs-busybox.cpio \
      -append "root=/dev/ram rw console=ttyS0,115200 no_console_suspend mem=2048M earlycon=uart8250,mmio,0x10000000"

The emulated PuC advertises seven performance domains. With -smp 4, cpu0
and cpu1 share one domain and one cpufreq policy, cpu2 has a domain of
its own, and cpu3 has none. A test device names one of the remaining
domains through "power-domains". Each policy's frequency table matches
the levels of its domain, and frequencies set through the userspace
governor read back from the PuC, with the level set through the fast
channel and its doorbell. A consumer test driver, kept out of this
series, attached the test device to its power domain, drove it through
the OPP library with devfreq on top, set every operating point and read
the level behind each one back from the PuC, checked that a level the
domain never advertised is refused, and ran alongside cpufreq without
either disturbing the other's domain. A device naming a CPU's domain was
refused, and so was a CPU naming another provider. With failures
simulated in the core (a domain that fails enumeration, a level table
returned in reverse order, a fast-channel region too small for its
channels), the affected domain or fast channel was left out or fell
back to the mailbox, as intended. All checks passed. The series also
builds for arm64 with COMPILE_TEST.

Joshua Yeong (7):
  dt-bindings: dvfs: Add RPMI performance service message proxy bindings
  dt-bindings: dvfs: Add RPMI performance service bindings
  dt-bindings: riscv: cpus: document performance-domains property
  firmware: riscv: Add RPMI performance service
  cpufreq: Add RISC-V RPMI cpufreq driver
  pmdomain: riscv: Add RPMI performance domains as power domains
  MAINTAINERS: Add RISC-V RPMI performance driver

 .../dvfs/riscv,rpmi-mpxy-performance.yaml     |   65 +
 .../bindings/dvfs/riscv,rpmi-performance.yaml |   88 ++
 .../devicetree/bindings/riscv/cpus.yaml       |    3 +
 MAINTAINERS                                   |    7 +-
 drivers/cpufreq/Kconfig                       |   16 +
 drivers/cpufreq/Makefile                      |    4 +
 drivers/cpufreq/riscv-rpmi-cpufreq.c          |  294 ++++
 drivers/firmware/Kconfig                      |    1 +
 drivers/firmware/Makefile                     |    1 +
 drivers/firmware/riscv/Kconfig                |   17 +
 drivers/firmware/riscv/Makefile               |    3 +
 .../firmware/riscv/riscv-rpmi-performance.c   | 1186 +++++++++++++++++
 drivers/pmdomain/riscv/Kconfig                |   16 +
 drivers/pmdomain/riscv/Makefile               |    1 +
 .../pmdomain/riscv/riscv-rpmi-perf-domain.c   |  265 ++++
 .../firmware/riscv/riscv-rpmi-performance.h   |  148 ++
 include/linux/mailbox/riscv-rpmi-message.h    |   16 +
 17 files changed, 2130 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dvfs/riscv,rpmi-mpxy-performance.yaml
 create mode 100644 Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
 create mode 100644 drivers/cpufreq/riscv-rpmi-cpufreq.c
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv-rpmi-performance.c
 create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-perf-domain.c
 create mode 100644 include/linux/firmware/riscv/riscv-rpmi-performance.h


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
prerequisite-patch-id: 907ffadca74a65c93ad38f428e002d2b34341067
prerequisite-patch-id: 5a4df94e66de2f63697891a0f1382fabd9df7b6f
prerequisite-patch-id: 0827a7050d08fea7deaab8e82f2dd16acdca507d
--
2.43.0
