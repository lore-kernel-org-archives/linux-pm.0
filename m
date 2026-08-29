Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34841D62C;
	Sat, 29 Aug 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788036995; cv=fail; b=WKjrUDucD560FTPNF+BhMUKzBEH/6I/ki/wde01jKKMoitR37Mdm+1Im61T94ftHEprL91JP0keMkTKr4hqN3oJlKz0UF9Wa+Ih1u38obNDhZeRM+TLfZkXCYOx9Qe8GVFHLUCYQkY9K9qZxOaBZL5+gjn94eFGGanMUibpBBIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788036995; c=relaxed/simple;
	bh=iQYQVlCy+IQySs0CLYPFxsWApvzPC8aFHf0hDISerWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PxgBxwRO199uM8CROhpJ/s9a2xa9SgddhwknVgl6pemdmpeibbQvciLmyqV+GFb7JCq+O4tGmVLA5IBd3yJyXh7Yl7cqA8eEYs4kpb3VKnNovUKnBqKJL77vl3oyQtNAdRvzKHBRhMiSbMqhRCCLmHOggLrVlDh8Mx3gbPkqOac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaCbOhivUIcLCgvxF9vEMJ9CJAWRoMPuGqjVOERMAQkh7JQ3rKgewXrj6LTTueiN2qAkIK3ukyJUQsiFST4Lm12b8j8pPz68VIIO2smRJGJ6e/RmqYbFxvd3/MF+sLlCf9NzrDphi5D9S3Zh80M/EphgGMLcfulr+mQfdDYg50+IDTqLtHjCUOwH4fIoYjhbx07LtGaXIsQfiQihBFqKhzci7xCbzNCexcZI5ZcxSNPBCFXmSSAYsf4jiwrLLW/9y9PpM9vQCBnpLTeF02XnnvSqxTqqf6C6kDrRLbwmEqlY9JpFd0IyEkoA5Qow9OfRmBO7/ssUBS7KywSnhwld3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9g1i6iTFbZ+gpnieiWQgYULXeGpVwZmdfuT/028Ql8=;
 b=YPp6BEa1qdF+et4nblwGZrzVg5Fk5d/hX6QmNqHpxRjG/jzI1V7fhDfJpriZOY+tErMLkFlvhyibvdXojE36kxrjSZZW3SeBGH81uFcVRJ+pOUd62SqE9ZYZ+4LHRwHjQzxk/bTzbmkw46P+roaHlWSmT+RoYiQbcYHLTlFJsHMVZ9a24qIONcBgqTVv5Go5s+bzWRqdniuGpdaScWEvdF24sg9FAjxApszcqY7IiHNm0RScmDOfRIMSPTBZn5cs1FN5ZeFbkRhvjHiWA7b84RrZg3J1FWYzUrV0qPJCyaOsuZILef9Bpg21V4IAKMk/DJyPWFDGhyQzeiLhS5KfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0709.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sat, 29 Aug
 2026 20:56:18 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Sat, 29 Aug 2026 20:56:17 +0000
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
Subject: [PATCH 0/2] Add RISC-V RPMI device power service support
Date: Sun, 30 Aug 2026 04:55:17 +0800
Message-ID: <20260829205520.1691-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0062.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::29) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0709:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1ff247-8f1b-4012-9d38-08df060ff895
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|7416014|376014|366016|18002099003|56012099006|10067099003|3023799007|38350700014|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	y5oABsVmHsj7QuRjEk5Bi5PSIzIKEOhM4RKB2K9UQo8azxMh1Mr9Mm4X1nBDWtmFOladG2Z9PbCIP+0ZjHdL8NkCqkVQCkOvh12AjRb8f9ju1r0DwxVbbmjGTjxPgMIbV0+81zSrZNXJzHWKrqVcO9e5rW2IYnUKeFZXgwjuqz/b6Aik/Yska/MOuEyTisX6FwcGjuKsiJP8XX6ww3IDIlvmkxUL7QnyL2RyDuyK9kaZJkQlbefGy35YWAGaTTClSs5yPLyqH4AV4qz78eetinCv9LzhD0FR7p0ynWrc7NgLyX7i6XFe2bjfTzjbDO1AScaorxCFr/rYgllRbwnFsuaj9mjR3rDXZkuX7SQ21iGj5enJpeJ7ZFSWxR19P3vkPllwTJS3Dp4QNiLYi09qKySBSQriFM0RbdozL5M1O1XuDEFI/QvV+1wIPpc0TY1v1bV89NdQVV5DiOxm41Was2cXwAVe+8Jzd/2q2D3Yf/GRxClXlNtH8b5uTBnLQsgzzc2pH9f22xrar0TX2NYxBJOWtk6lIRtIu3olTrq8VcU53taI/36nv0XSr+F3LRP85zTR1XRbEtUHVNMp4Yh82A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099006)(10067099003)(3023799007)(38350700014)(6133799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I38AFtD0LaL7nDffBVMCz5S8NSbL9UKFd0P4DXpw5SK0iQ4EAYeWeESCVWPD?=
 =?us-ascii?Q?NtzJ6RXEQ930sp0THU39JncMWK0RdrYPB+W/Gkj2K/VjK414PoQuuA53ysY6?=
 =?us-ascii?Q?binFZ5T51Xnh70+LmEsXfBdul+1V1oNPNVZBZHleDWYxWw+kyledFnd9wa6q?=
 =?us-ascii?Q?Lk2Rvm1L+hU7h11v1qQwLhVYtvXi3VHPHPkSJM6O3e9RarxiEFVA+d0rSfRF?=
 =?us-ascii?Q?YB3jE0QGt0tJasUjLHUnxBCjLATTjC0x18Sr+rfM2tXy3mnb2CxM5GvHGxGa?=
 =?us-ascii?Q?ImSP9yI5tzEdc+NKkqTLydXvynGMD18dlXKq/ZCORfyaemLlBw5JfMNSWdN9?=
 =?us-ascii?Q?BAx4J0GsWT4QU2vrb2YdPwgejG9+QdDi/mu859UTc6wQMS9xlobELw7onihS?=
 =?us-ascii?Q?M/Y3EuKw1aYyP3i2qpBbXQbww4+19U9LpnAO9mcBumUlmsPq8tGFh1gfCoLm?=
 =?us-ascii?Q?IXv+jMos11MUqTXVpBd1Y1g7KsJPOlecIvrA9rs16uhbb9i+4QLAjum1Z3ad?=
 =?us-ascii?Q?R72zxqovNcKx5FtxbQu4OsvUUEOkXuG1peN136xFAktEnYQ+ZO0bgqde9U8J?=
 =?us-ascii?Q?1Nmzl35cVMRcIQ8RFrGiUyz5ux/Jk4WrLN3opVDFJdbgS8DOnh+gWVoOIggl?=
 =?us-ascii?Q?oCCsqOtBcGiGQOt8ZvxFFky5Z7KeL7wv6uxX78eLNZItWaEa1X7NF+Ooj3Ka?=
 =?us-ascii?Q?nwuxkim9k5p6+dSGc6d9ZWaCU6Of5vEdWat12FhMSBi7I3LAOD4f3QoQE5lN?=
 =?us-ascii?Q?OovhwghQ+b9xE/SVtd86l9Y0F/Q2EW9ubV5+0yY9eLzqtLFfpxevoOQ3iJGB?=
 =?us-ascii?Q?PBhW+UhxhdPpeU7LeIJ0ofV9aGENhoIc6FM1CyeOt2S8aDNbivrK7q2aFgzl?=
 =?us-ascii?Q?MC7kikFzkDX6Gp6Htv7aUs0QGX0O3MM9hiNnLAAX0zx/mRYq4xWjUnmy2FCm?=
 =?us-ascii?Q?zFSDlmVvv7hHINN5Gvde+0zYbnFNhptrFTQAKx5Pov13919sZpY2EIrdf9Pn?=
 =?us-ascii?Q?jtDGIi8IEIhynJuGANLnP9QhKH1wcqaMeuFjrKw3aUv86xeYISiyLG1q4jV+?=
 =?us-ascii?Q?+cT/QqjVG8HMEeqFU41v6DJ3GLsAdHRjhFZo2hxs/e44NYv1xbQk2ehTpj5x?=
 =?us-ascii?Q?WE3EE54s8YyO2fbicmQh+nJ4GYg/i4vubtgqq3mU6/p7WXlxeHYS7vEDWrol?=
 =?us-ascii?Q?EfBwghSjCMLg3Fqn18MShvX16QgGEgbLyPpvEQrYNfU5uD0MJunUnL9O5zTi?=
 =?us-ascii?Q?ND4iCM+pzvgAvh+lntyERvkADUin3Xu8ws8F3TrkIPeoegBm7NczmhvZtygz?=
 =?us-ascii?Q?DJEFVmyom6S7adZuDqNmwuPAjtgqKcGuUfJfp8voqg5owYebLdoOC0raVuTi?=
 =?us-ascii?Q?IW3xSMg9uMPkcBXG8dtISNvdrgLJR0heQk0UBOkMY3gxl9GvNN6rjzT7CoPK?=
 =?us-ascii?Q?HH6U6n0oMz18PL/r1d/Llt6RtG9Ii6lLsIgldxUoBKeiduGVydT+rN499uBj?=
 =?us-ascii?Q?GgPk0G3sS+0+p7W0lKLvRG9uysU+AUdgNeipLvobwI5cirEFoKVH7Cazq8YU?=
 =?us-ascii?Q?Ae2dij4pEi9EdghWiT8q2t5ZtloAUeoGOB2vgdfRH5H2XckWFijI9bTLPAV7?=
 =?us-ascii?Q?WGH51MUUndmI92o2V/m3JkpwVpUn8xz/LOmabpMAx8fMVVPFOuhFVHKfqRfV?=
 =?us-ascii?Q?oZk2Ta42z3MNTZoJf/j1FSMQA8w7RbrQaHDOXPAm/4cYDNk//04w5LsSHcRx?=
 =?us-ascii?Q?dni28js0326+lJqSDTLr6vg3IYN5bxI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1ff247-8f1b-4012-9d38-08df060ff895
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 20:56:17.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnH/lc9gFpJZEAnKk8JZlLMDylbj6OZ2SCgYwnwjH2l50APuBf8jBs5P84A9+cZrsZdd0khuKIS0Kt5pYiqZ/md/RjNjyKCPiqNnjWiHSuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0709

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
through /sys/kernel/debug/pm_genpd/.

--
2.43.0
