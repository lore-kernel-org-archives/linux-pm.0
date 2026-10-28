Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224581;
	b=dUVmXrx23A0eSZzmlgU+WIlACU8mU8YkrzwO9sBbEhZEGQKsCHPn6KAj5gSZ0hPp4GKW
	 4Hbfy+Oc7MdvVDhrKf90C9Oz3dVigZboa9X4DWIHf0fYA48V3oR3mVAIVFMbm3VxFvhOl
	 I0PcUZgMowmCa9HMfO+AnvXjuKSYG/fyahBBrqeqOd44XSAvR70GdZ5xY/11+9Lqeiny8
	 mlVjg9nJ2W1phed3UNZCwzDy8y7iLKyBoZO4Zu8BJMAol+OTwifGmsqWiYYxZunTDCwAd
	 n+uPEs9el/iSv1r5RAvMeopBKti7mNF9hTB6591hu76crgSZ3bU8UgOB24zA1Slp0lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224581;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rgX12NfxsH4GQV1LwZx934SHYcg4xukhwGnwYahhwJ0=;
	b=liyHQfLZynhd2a7R5LmO4IfXUbBAgN2VVrpaMP837FFcimIqre/sHEM+/wysEkd00EHy
	 hshfcET/08yMsdSm8OYw5YIaUpYTyc9ReShPC1WyL6tUY4HlZGSUEtCuQjDJPm54judn9
	 gby9hKsgufqLvEJyJCL8B6omyqOWhryqZGxS0C0YiloC0eeuv+5GXXhAZyKdAN0ZhHjaC
	 SThYuB74tmG9d2Fo/YsM9fui7q4Q4osFFV8iVGRHsTmUzz5mUbL2KcTUuAMJsLVqBwkoV
	 aDtO66aspVWkp3Qec6BoOn5Vz4q4xxB7npSYeaIgiSleo/sDymOol49C8gnqRyLc12Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=inLhCjDQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.26
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70612606A31F;
	Wed, 28 Oct 2026 21:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70612606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=inLhCjDQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/VF9Rkh2g3hu5GAahsBKBSYrYtL1KfjPWOn5EoSmifBfJWceAZkXux/eBn3Gem8QQdd/oE3JAaqZdjqbJxxo1p3aYNjS8HfC/gJiOfTIREW4MGCu5f9GD+7fO+4HVm8YBuWZQN3iRxpX8pfhzl6KUUQTQ8RB22G5xWi+nFFT2WBZu+MNpiQxF9Nd5XNy2wSjdFKzZzNjA3fPl3Zna+1XmCO8CU1n7O5PUclc6KlO9NFytXPS5oEVNvGxkWCb1tC1aJtbbwYisKoPo3Q3WWS4dxRpY4ayUb3dNrMPfUg0vBZbj++Dw497CAsjljazoknKlPMhhK5WKUDJNohz2pPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgX12NfxsH4GQV1LwZx934SHYcg4xukhwGnwYahhwJ0=;
 b=ow3eJWXcFMynRpTwL4OIZFOKswbSGzNENF7WmoATVeGGerqKFt4aIvyWbUU7rF4S6GS5yBhagOQhoq5JF7dTcZ+teXmOzXz2IeESliI5MIrctRZhNeGQ2i5TFzsnnNcUzM7cjzwMNiUcUS2LBnq1AiAO2CAsHZMYsveho/qY+XI95zbois0IwkmCA09Yktww9qB72Uxk9qw2UEHmYbGNNA4odz5qcGtJE2lEFf/j4922KwWsh1X2/SG5aXrQCPN+BGkVUzZjlrfRJ9Lup7efxqFy0ZykdxiYpUdBp4qGn8Vo5FVsGeMr2/+8VmVkNbEVcCzTNo9ZlolI9WBggRlmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgX12NfxsH4GQV1LwZx934SHYcg4xukhwGnwYahhwJ0=;
 b=inLhCjDQnNmJlEefVDaRkl9aPiqS2XEwylF5c6+DBfQdCfd1Cxww2dd2eKrM/GlRoNwPZZDvzAiYpiTl0oJakbk8Wal1cerfmA9yELOjErSJchea0xf0B0NrqVZCtaG7e32bYlC/MQaDyielDZtl/CDIphnS48SbdIjMZj6K3xo=
Received: from DU6P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::19)
 by AS8PR02MB7045.eurprd02.prod.outlook.com (2603:10a6:20b:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 21:56:15 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::24) by DU6P191CA0002.outlook.office365.com
 (2603:10a6:10:540::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 21:56:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 21:56:14 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 22:56:13 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] power: supply: Add support for liquid detection
Message-ID: <cover.1793223841.git.waqar.hameed@axis.com>
Content-Transfer-Encoding: 8bit
Date: Wed, 28 Oct 2026 22:56:13 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|AS8PR02MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: a5de137c-13f9-43e3-0642-08df353e49ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261026121527099003|261022075727099003|261021121427099003|10067099003|261021123027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	zGZTS+RUyjHe7ZoIOkIW6Nh5dbsgOekdID4+ySMpZNDwtPX2OL9tggTAottmmwVbjRAGPdLCYK8IZ24or6wSx7yLIWwSkGCVswDmOkf8Y3GdvDk5K29OA3zJSEXiEEVviDiuC+HOD3Pyjv867JG7xKkflP9PV7ouHL8V4dpplM9Byzj9IOrUjxQ/Izx9FlXQmZln4ye46F67kqDvVwBKoiXtrNluiD5LVtJesPMQN/CK7Wa4JBookAYCD2HhkWY9Obf6rVkH2IXcNv6epCb7lg3DmA/q8GZi2G49StyfU5Hfgdgz1GX+EWYRX4psPj7gfHRNlL+7qKOBLojzro5IRUkaGI4qGFsWjzGYNu+LzkXgLcKiQRM9P0CLUzFGdPrO6cjiaT4cANt15sA/FZYCH2tl5xVFvaxFr+NI6ukMcUvlG3eKVbXkNosRsO29Df1Cd4IdXuWROIXcTUL7RBIFkcK/IK1QyiQLTH9Yr3zyhgSOUnkFxgZVFn2a3GomXmfXdbFROoW27nDohfA9RMXhdUDrnljoJBKn73PVhr6XAKjekWiL1M4T+QegsDgme6OTuXqz+0uSJsu7dWlYWPoq5lpE1LmuXxQ32vL41PKjdjs11ZiQOmjK6tY2G20EmHKAZ3qQju9t0/GcsGzgvCKAWXunMFDcNAf1a4CI4NeUqRM=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kOFyP528AsNGl/fRA8Yp3KIsDhjwupNRvLWue2CzqSYWw/tUCP/vzgg5E7yErVc+G1piDibn4PCFKIMYJL7VmVS0r+aGSaZkuNeWvj9JIr/oUohKbf0q5WkRsVleKWHQ9bHXzIHehnsUu+OfUJCD3Gu5ooDuI0bvPHSY1ZdTs4hkKpA/JNWHhLtNcb6MNk9vbecre2SEdWmL6WtxKtYFO1cTsXALlcb0gSMWxViAvMZAWPl2CmIMuURaMC0IOhLMI8WXSO6Z/lBf42oZoofFETyKPM4nqax+2xhRrQgacGzzRmc3OhqT5BScjSQfo4HB4PIEQN38YPHBxYyrQW5v0mLx0oU3J+8NAjjON9nmez9+KtuTWfavqfnkr12AiCa9oNd7YujWGUA/qtNUKEa3IZLNGStI5Q9Gj22Fpei1IMW69oiMdDohH1Kk7s2ypTlD
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:56:14.9595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5de137c-13f9-43e3-0642-08df353e49ab
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7045

During discussions of the development of a new driver [1], it was
concluded that a new `sysfs` ABI for reporting and controlling liquid
detection is wanted. This patchset introduces this.

Since there are currently not many devices with support for this. ABI
for setting/getting detection threshold values has been left out (as
discussed in [1]). Hopefully when more devices are supported, a good
common way to specify this will be designed.

[1] https://lore.kernel.org/lkml/cover.1772201049.git.waqar.hameed@axis.com/

Waqar Hameed (4):
  power: supply: Add sysfs entry for liquid detection control
  power: supply: Add liquid detection to health property enum
  power: supply: bq25630: Add macro define for IRQ cycle time
  power: supply: bq25630: Add support for liquid detection

 Documentation/ABI/testing/sysfs-class-power |  22 ++-
 drivers/power/supply/bq25630_charger.c      | 163 +++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c   |   9 ++
 include/linux/power_supply.h                |   9 ++
 4 files changed, 199 insertions(+), 4 deletions(-)


base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
-- 
2.43.0

