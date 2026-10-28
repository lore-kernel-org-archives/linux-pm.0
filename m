Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227176;
	b=myS+d9HcufhhH6AVP2DU7MuYXjRY72YCqLKMqYv10mJRp8t23sNGPRCaOYSN3L7Ec2Xz
	 ZCqZ+AuaLbe0QSer8r1cbBgIzD2H1sXZXrm3HOBVszE3HbS0uGC1cMydcP/MZyxrNMR4L
	 2/Z5vcUCRuswPmuNy0s0KNsD34NKzLIU8TAvo571YXls2LStLNkfuAUvuc8ZXzvvbB+0/
	 hVQMzW5wZW04ZnsKpYWsDu9Zkvetqcn1DfKlrvXDwVaB/8iTwGDRzv+fu7k+P9rQUxzGG
	 tpVDsn3W4d6nelPVftUcPCm42VBxDpm18MCv/NdS62Iyug7vrYJkbna05WsI+m1B7sA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227176;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Eh8+ZDdduFYMhQA+IczEamazusCV5JJDBH8iGc23x9w=;
	b=1ctzq6E01z5f/eiWpQVO/DjFXM4qYmy+SLcymYFhmjPJKKCJ9EEed7BhXEIIrCwSRK0h
	 WaKQRLZ7TlL1vzKkaaGFYI1hRMhrjILbMzQHRKwBjbMeje4ktMrww/xnIkX08XEV/aKt2
	 BcK/CU8yY/9VJiZyhxnIYDpOUKXwMLF39aETjyMMbTMOaIJ6kZ+0LC4awPBkwhBrvx1/P
	 dzZjDdWMwsXsQrTTnQQNV2t22bLCWSv6xjkutqnr+f9QAU7sxQnUxr4TNT6Zf2SvyIlVj
	 /3h4k4i7ih4RcCDeQMXdh/CGj7hWdmemN+iBdNgoHOQcNYaSGrxyf8qxQD4rsPwtauA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="Lv/G0hpD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEFB606A31C;
	Wed, 28 Oct 2026 22:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Lv/G0hpD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oihVbk9+7Z3liMRGC5/dP3Iu8fnk/5ABuyRv3g3njDSsqzLguepv2eCP2IalA6FpQFeiAv9CHWlmB9VoDeYxeQc8b5tD8dGdyRnhkgHJfsRMvdaWdAyUQZ21hAfsNNVwpsueHUqvCEvxp0GlBvDbBy5+qH1Fmn6GhyKHLxzvCtd1s6rax1ZxMNcA2zhYWQGBchayyZIYHOHW+3m42tjp6Vjby/Mu1/K0qq8hTwhzUEWEeJ/3Qvx4j0bj9I1SEkMrAK36rdiSIBMdaiJPj5rIgdjvXLhaVdUt3QZCqUyjcDQtapO+ulVU9+jmyGpud8w9wQCiyx1k6CtMxZcnISJReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh8+ZDdduFYMhQA+IczEamazusCV5JJDBH8iGc23x9w=;
 b=zKBSvncglzhqr7p0bpzd5AEGhwhDqYe2WvB495tEfLwwPoCTO2tZBiiqhIi2BcB+H4WRfoy2ftSyviz6+qB0qmpgJqXtjBCN10s3lVShnqdC0W0jbar2xZaE686KzZl7bACsThcHyg9rbVBysQhClkFOVlDZUdhWCE632UiyKaXv38qdUpLq+qVIiB9FCKFa/wwUDyKbTb2kDU6QUEfpw6jeq77aD2lgVa/Caj2B1JshgeXREDBTtGQn0GKVZOhEgrs8W5xHdJy6fmrr0M2cLmIquMB50VML2vilV7b8/b225XcuvfbNaAyJ3PtQybaC76JGUDLhgYPkPbg44nua8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh8+ZDdduFYMhQA+IczEamazusCV5JJDBH8iGc23x9w=;
 b=Lv/G0hpDthGji38TVHLy0SmPEnFljWtApMEWRLBRjh7qw81wtD12uVOzW5RoMCZqhSObQsogV897NbXObk8soJ7o1r7r0MJ0Krhqv4wWiPPdEykgJS8UZ10SYhAgVlAvMAhcP+zTJEsOAO9JVTJYi6g/K5e4O6/81/I74AACtu0=
Received: from DU7P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::13)
 by DB9PR02MB9730.eurprd02.prod.outlook.com (2603:10a6:10:45b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:39:31 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::42) by DU7P250CA0009.outlook.office365.com
 (2603:10a6:10:54f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:31 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:30 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] docs: ABI: power: Clean it up
Message-ID: <cover.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:30 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|DB9PR02MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: c667c786-d659-4db7-1b7d-08df35445559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|13003099007|261026121527099003|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|260925021911599003|10067099003|260925021311599003|260925022911599003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9JuItg6xJnS8cmKPZSGMak7TMUj2VJOqNEgMpuviSOzn7H3Pt1XMW76ddojVZR8oD4qNn8jQmjZ74dWMT7UTjtr9ORVI+T8V/2Ut51Dsdcjb8lLNWwgfRSGRyiL8PpxLuIcZXAl9NlM4jI8dgPyEmEtZiDySbp7tdG3z4j4Qqjdg3e6R6CDkKyyu2Y7Od8Zyh0TAWFEjMQryekqXvhxFQuAGPoHg2NImi1KT148Y8g6c8SNAlK6QAfY649vXyAmyzeO2umQNHIMqwv3WeNg5Vdx6O63eTmZqAeDdi4EB94Ju50Qm2BQhKLQP2C/IL4cE874/6xm8mpV2EO//oGxwo1qLnsjPxS8xGIL6RtfSCx4E3WFeHvblSsXb1moTajKkYeyxewcfe5rMcWGLJhdu6STfaZQiXFCAID8DqGhBWHfgZ4RUsKl/elhS0sJ9zLvq7/D0Di7bdSO4IYcREaBdS77ROtiRMmIqroR2Uk2u0jnbHYMp3jgZ+8W09Q61igt2MCCcssTeYAvp/0et/3pniu+vrgVOxXp4eHZ47eoRNZlZ0TTSzufBazucu/TLBdkoq2pwOChPzCRbiHZtshVi2q7OsZHeL9w5C+AZOsxact+hcEsyjfU75lgiPpIVkshqZHsssO4gnppMW2ybAlU/vI34jF1nsIa6OCjM+aljnyM=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(13003099007)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(260925021911599003)(10067099003)(260925021311599003)(260925022911599003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xt2KA699PoLJMiDyPpjQgM5Z5vxVoUPavDCYg7QyWU9m0tClGjeJyMHBQ+NWrdb3RHrqq/z6vH5qPwIMIPo5vahBWDA2wDdJ0UxLWGIJvpWpw08I5Htf0hVKQXbd+ZN5fphgMXr5MqC6XUQ+BeOGofLUKEXCFp8PFvrmDqDQLfIsuqFbSV3B4CVBdXvZ5ObIDWjewCgbH+kjaURnFxDt/yKZ3LO2wJFyfpwXMvLaOyX7M8/GPwMXu4/l5trDBUIoq+7di35o9DU3F8OAgfBZgcqviLdvGwW4Tik97Qa5ycEI/LEbdibWCYhtkqv5+GkOYgo4kdX+qTELDHhqxVppEUhfkjGqWTg3/Nr1skUWGfZou8QUG7RsQrfiSyD8qWD5+VseFlZNseSxiUsfrPlNk0nBxvILoTPl1aNdi9XnIE90lAGFcCRgxL58SL4UdJOr
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:31.5354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c667c786-d659-4db7-1b7d-08df35445559
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9730

While working on adding sysfs support for system load control [1],
kernel test robot reported some warnings. This patch series fixes those
and some additional ones that were discovered during discussions [2].

[1] https://lore.kernel.org/lkml/cover.1788290289.git.waqar.hameed@axis.com/
[2] https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/

Changes in v2:

* Add additional newlines after "Valid values:" (as originally reported
  by Mauro Carvalho Chehab and pointed out by Randy Dunlap).
* Rebase to latest linux-next master (and thus fix the additional
  invalid inline emphasis as reported by Randy Dunlap).
* When fixing mismatch quotes on patch 3, somehow the word "key" was
  dropped. Restore it.

Link to v1: https://lore.kernel.org/lkml/cover.1792965060.git.waqar.hameed@axis.com/

Waqar Hameed (7):
  docs: ABI: power: rt9471: Fix invalid inline emphasis
  docs: ABI: power: rt9471: Add newline for paragraphs
  docs: ABI: power: rt9471: Fix mismatched quote
  docs: ABI: power: rt9467: Fix invalid inline emphasis
  docs: ABI: power: rt9467: Add newline for paragraphs
  docs: ABI: power: rt9467: Fix mismatched quote
  docs: ABI: power: rt9756: Fix invalid inline emphasis

 Documentation/ABI/testing/sysfs-class-power-rt9467 |  8 +++++---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 12 ++++++++----
 Documentation/ABI/testing/sysfs-class-power-rt9756 |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)


base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
-- 
2.43.0

