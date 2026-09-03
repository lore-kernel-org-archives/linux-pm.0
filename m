Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327341A551;
	Thu,  3 Sep 2026 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429459; cv=fail; b=S6zP0F0qV7uXwApsBT9QC6LWlj4mEVH5qIH5iz2oAWzQpYt1lX2beRe3yJ5leItEM1c0zi3xtymR5v/mgSx1JtL8mpoYhNtewDNwKzVa4vY+aWJAkQIcwJWOrXZ4/AJETx3FryMEkcg+vCxo4yuRhXqP8jL4zpotT9xLuVasdNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429459; c=relaxed/simple;
	bh=u9CYl72zPnr49+MEUdIX/IUUePIbIYPZA7sD6fkCp8U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h/gCMUKy4ZTfqBzJjY8AvedXeraP9wFTdpkuvpyGZNH9Xb3FRxk0YmEvKBYXE+CiRdQlBp8qcsTJU7z+CN/1B5+OeijjIMGmPUy+S9YJYW/6PkmXpRjUQJ4HLSbZxlnDOOSFUpKt6H+Nwjgj/85QnCDmUjtAq6OqY1cZ9MzwMlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAk6P2Fg2kQ1WLA9/biE/nK8w02R5CCvTZprNLMkGt6YTBH7WolST3kGfGkLyeVKpv5VlzROrjQNU2h+XTBTLN0JAxTBugpJOiUez8394NqQDZWZiUtXYA5XBnZgROmLG4QSLC3FDOp/iSMOIopJpZSmdG1N30Hb5hPBIs6FR+Ype8J4JDvdsnDXRvjBliu/D8egX8FWPX6LhjfDE3o0nOk86urZs1oqcINSAl2dNnDlcz+KGYmYeLii7Js2jDap3B/jARzs2UM1yIOTbMxGMrBLBMrFIIZjFhX8bMr5dnUPnCNIy4+Zg/XqwvcqP6CtF9INRmCkJYD2D7sQZQQo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMruS0DsBMc+0PRqon27vmlkJBSF+gr8MB/aLN/vEcY=;
 b=FMVy8j23+aFemY8uAK25uFGMsz5vUczoGiwzEuhIX5hGdu5FK6O2i0Ud9ZmEM/nTm63VUWFGcspM+vyjG30KiKO6sCffdQZA7pCfuj9n4ZSib25is457E8LXuMhTfLf9htdIHvyCLPrIxlL7y230hdQ8IjiuhZ09SCaO/DcJsjpcgPglHWAFEFwGfv/VZjR7TZ/trRNenaymu9IcyhLyOGHJa2npI612yuypY1hXWB/AY9ykIl+O4XaWW4LXUSUBrj+/WwZ9ho09syKXLRGsOxhqMDBy86z/91v6ZUMf63wHbNJEBHKGP6BftIoEfZ3KfZ+lFO25iAYW9YVHvIaP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0680.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 3 Sep
 2026 09:24:12 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Thu, 3 Sep 2026 09:24:12 +0000
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
Subject: [PATCH v3 0/3] Add RISC-V RPMI device power service support
Date: Thu,  3 Sep 2026 17:23:44 +0800
Message-ID: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::14) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0680:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c9f20c-b4a9-43b1-4bc0-08df099d1d79
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|23010399003|3023799007|921020|56012099006|6133799003|38350700014|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 /BfshWynTdfswspCyP8kkJ57WPf//XsvUD2jFztyfQg7vJgCV7kpTw03DNQtlhkNhRKYqmt9Y/1R1mI4DQ5Zl05qsH7Fv+2qUKwy0cvMVUWOz7oKi8HHLvDUpqYGEuBUwj0idxW2aAcmACblkOpJ4e5PTfnWWzC2d44SGLFHgMGTnMbY7uH2iQ7Kxdcf6ShNViK4fwatG5ptxPWC0WJ5dB4gYEC5wJP7k69o2IINZeB3v3GlyQt2enp+ZtE5XhEdst3oHU8DuWV1NvoJdcD2eF2kfozV2yIS1KIOMbnBV19XmRaROJOoRYQJgZqkYLp2YCjVxfHFmX43HxR1emCPuAj3QFdV9mq6F+0NJgNk7E5j6rcLNjHQYfetWyGp4NxMNNh95GUnHC3qmMAs7H7+DB2fggE1zFhUMLs6+g2ICdFv7KS4e0QjdnsaesXYgcWEwK9beVwMsjc7bCYypCUr882ZBG+SwtZmuiD+7+bWOgXQQmYvquqihchQF/UUaWj/VqLp5bL0yL37ih434YcS7jPqsjFA7g0XQfqzeiOhzRHZkz+b8NxpfXSc7W/UfjYM/rDae81Cf4jb95IA4OXLDw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(23010399003)(3023799007)(921020)(56012099006)(6133799003)(38350700014)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?FwGCT4ts073G7kBuRVh6NTOA71/HUJDWui4nteJNsE3jghEThTlFEOyxpr/U?=
 =?us-ascii?Q?vgOZ7I8ZOWFtDtUl8w0U+J8RF4E3D36Ebry3lyn6iGoeYp6qEgCqO+k/K2M2?=
 =?us-ascii?Q?h4ifpqBFE1nBcCUKWIWwuWnKS/8rfPfVLtijd93BazrUEs4HgmWKk+r36G0K?=
 =?us-ascii?Q?3EGyMsvW1a6EE6jyMnyIzVu808pgxDdOUGORmgbbQp2M/cu4SgVw28/EAMv9?=
 =?us-ascii?Q?OXlH6KvKX3PCAl61ZTgpVPUQaDhu5YoV4/r3jPLHbc3iC0bAngtVDmFT+5zE?=
 =?us-ascii?Q?5dRvD9tZoG9WvuKImRP/HfHWKucNqkUt2JRMEH9tlXsU3GyRrP5NENbU8rpE?=
 =?us-ascii?Q?gR5RwFLUU0WqQwsTV74Vlwp4f0mvK+7vMvIEKWOEJxvpHNi3v6lmQERhNRqh?=
 =?us-ascii?Q?CmI+2vSxL0u7rDffzwOwXTO3LQkQMLLvNyK9EsiFb9IQ/mOQtoiuM+7nHrMq?=
 =?us-ascii?Q?V+aTPqx5oRD9u4HzIvqTDyzjpjeFgqIC15PvLakKHlsbukiYxJFgaW6uzrjS?=
 =?us-ascii?Q?Tn8TLCahGvnsJOZc9YSJzS9wAb3IT92/W+6ruqVhgn8GmyEo3LC/3SlDEchg?=
 =?us-ascii?Q?iupPJCmZ1Xty5N5r+gkHJbb9tbjDaH+RAib4PSG3qNCzUHkAIb21UCZvaOw2?=
 =?us-ascii?Q?CepM4vd4CK5OfdsxOT2uKPHvcx4eX75gVR83EjEbNbbaQMAH/VXdMD5XKVJc?=
 =?us-ascii?Q?vMz/Zs992ASjnO1JMBknCsMsvudjm1V3n2+bzyLoeZ16sWko7ffykKalSsgq?=
 =?us-ascii?Q?N/8tFBFlPmJraPkbAf9XVoOl74U25MYTH9gZy1lWAGWRy+Vk7hrETO7C1U28?=
 =?us-ascii?Q?jAlz6KVMBsgwdRkk12G3xVU0o+31hvMA2chflLGtja1UBUQTGCVIrp6aA8VL?=
 =?us-ascii?Q?m0xP6lY1ZA0gMtIRTsgu1zIrSoai5trpeEV+f/fztUW9c/Dhr9yjqlDJqlvI?=
 =?us-ascii?Q?PR6v7e2BOEb4QCLcmZLV9Kf3KucrXWkKlxloIuY9tyIPgaJgVDf4Qc0J7Rez?=
 =?us-ascii?Q?6lWUBAM6BlIGlCJQCYGxHIhIYvZSyJ3INb0ZJ3e7nK/dyUTObvyvZyXSluWh?=
 =?us-ascii?Q?vEGPWmNnlklrZIMrLcl+r7vogZPr/4RgXBPkEIuryI1FgM9XL969qVRc6JuY?=
 =?us-ascii?Q?VjiXVXUsW+OnOq8iVgc1nxo9KoybivHElQLI4tNxM1M8OauD7D8ztdFmBByo?=
 =?us-ascii?Q?cL7Aq7WiwrGFB5TJYLTMYTqG0R/a6OarGiPAKWfq8O8ojpskTMSgJQlErXiX?=
 =?us-ascii?Q?BUwmry9yQizYnqLvCYc2xXw72CFXbGOdiQtEkNT2HDBvccm+3e5GOkjwH9Iu?=
 =?us-ascii?Q?9GfdxUzbF8vHvW/tS7wI1gigVisHw9MFAwdzsTz2oKCSiWlmBhZc9VG4SrcR?=
 =?us-ascii?Q?66zkrT8XwoOAdbz4jC3reT4hNTJINfPgD6f0+4kFH74EVazNZVmQASNXzL3N?=
 =?us-ascii?Q?RKtFRHrHwXFH+6WgRDyApRS9CSQzp1WdyRJs9wluWiGmxUBml7CO8JuiiI8/?=
 =?us-ascii?Q?9qIcqdEHR0kZuFMYGBFWvEf5BkaEVKFXVXAgGh3ynum74F7z5V2Za6ZejMKv?=
 =?us-ascii?Q?QaEg9Sv7Jw8j9naUJJPHo4BFrzOI4BIVscVMuxuRfVV1b7ZeAoRVDNSKRPbD?=
 =?us-ascii?Q?vcFgs4C/fCeqmJcasgWqWb6TILO6Ci3bFLTzbbEuWToCeebBQ+jftnY9Em4+?=
 =?us-ascii?Q?l2sYnhAL2QnhZeT4gakr16+mbbOTThWl6eqC69CrGX33zDiGhAXXsXozWnxw?=
 =?us-ascii?Q?Hu/faHQ1ZKIDSICkYXupmEYj57F6nNo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c9f20c-b4a9-43b1-4bc0-08df099d1d79
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:24:12.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtcDj35gWScB+w49pmKQeKz5UcFPhvAuQyRCTtD7olCpHaPMVfaL5j4Y1qQ0ReaiXxhg3gkXe9QcxMFNFFoIXWGbjCFA/kLMr9cbGo+4M6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0680

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

Changes in v3:
 - Move the MAINTAINERS change into its own patch, and add a new
   "RISC-V RPMI DEVICE POWER DRIVER" section scoped to this driver and
   its bindings instead of adding an M: entry to the existing "RISC-V
   RPMI AND MPXY DRIVERS" section, which covers drivers maintained by
   others.
 - Drop the redundant trailing "bindings" from the dt-bindings subject.
 - Compare only the value field of the RPMI power state word. The word
   also carries a context bit, so a full word comparison would report
   -EIO after a successful transition, and would drop a domain at probe,
   whenever the PuC reports context as lost.
 - Check the pm_genpd_init() return value and leave a failed domain out
   of the onecell array. Every failure path in pm_genpd_init() returns
   before the genpd is linked into gpd_list, so the previous code could
   hand a half initialised genpd to of_genpd_add_provider_onecell() and
   then list_del() an uninitialised list head in the unwind loop.
 - Set GENPD_FLAG_DEV_NAME_FW. The domain names come from the PuC and
   are not guaranteed to be unique or non-empty, and were used verbatim
   as the sysfs and debugfs names, where a duplicate fails device_add()
   with -EEXIST and takes down the whole provider.

v1: https://lore.kernel.org/r/20260829205520.1691-1-joshua.yeong@starfivetech.com
v2: https://lore.kernel.org/r/20260830152812.312663-1-joshua.yeong@starfivetech.com

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

Joshua Yeong (3):
  dt-bindings: power: Add RPMI device power service
  pmdomain: riscv: Add RPMI device power service
  MAINTAINERS: Add RISC-V RPMI device power driver

 .../power/riscv,rpmi-device-power.yaml        |  65 +++
 .../power/riscv,rpmi-mpxy-device-power.yaml   |  65 +++
 MAINTAINERS                                   |   8 +
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/riscv/Kconfig                |  15 +
 drivers/pmdomain/riscv/Makefile               |   3 +
 .../pmdomain/riscv/riscv-rpmi-device-power.c  | 485 ++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h    |  11 +
 9 files changed, 654 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
 create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
 create mode 100644 drivers/pmdomain/riscv/Kconfig
 create mode 100644 drivers/pmdomain/riscv/Makefile
 create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-device-power.c


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
--
2.43.0
