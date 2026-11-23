Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795423388;
	b=cGI+yi+d695PLI/f46+XuBTZ6iM+xjkpnapVwjYBZYnL9wa2AuPU3VOYoXjErjjy6MS/
	 tWNoZzfW3PES1NsBlGTAJwgkqAndXUq52/egHXlqRD2XTg5ssYNTN3OR9DBL1wMGwgVcI
	 HlP3sAYqvzLke3H22w6gwFcB1FJlTV8abOIEinW2kGk0obuVPnxuVYFbogLZzrZbY6rb2
	 dFw+Jg2TIlPTRlXG1fb0/dRWmvKtM3/uATcDAXVVTcj6Vq6LdQQcwqmkxGtqLqwTMJ7Ab
	 2DaaIgPEuxtkgy4Z4qfKJAahDA3vEZwMe5hr/O3FT5/u/IV1xO8QsYvHBFk0P2qrN1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423388;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I9htYT813Lde6l9f5mbhJYwyn32bqYsvj6jbaaxYBN8=;
	b=KTVRYfO9nnwMV6NtZtTxEgutJi6xTjTbmcyjCMaDV8dFCXyqFoXAL6Aq/YM40Lfs+Jfh
	 k33FxvlF2fv9ZClXm8db5qONCdxRJIUzrYerUWv/RmSn+Wh4tpQkAi1413IFZAigage29
	 z/ZL3EAX3h5mLWCr52gZmFzrCipQlPP7Fm8wdnlGRgMYDRe45Z5OPPmgHpBFVmPB82aZU
	 mboStDpGoUeiYdOz/k/wOaMy/T0vmNXsv5SbChZaFNNs3UoC16+KPvLBJXiZUwBuQ/X8Q
	 BICRHbsBxeJi13CgQN1mMTb+oq6KZtVacDaCm6EOsEVUp94BiDtCx2pfS67SdnhsS4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PSODbTgD;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CYRSEwIn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94444606A321;
	Mon, 23 Nov 2026 08:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94444606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PSODbTgD;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CYRSEwIn
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN5100F2373120;
	Mon, 23 Nov 2026 02:43:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=I9htYT813Lde6l9f5mbhJYwyn32bqYsvj6jbaaxYB
	N8=; b=PSODbTgDeC1xyM0GbfDYRguJJzIoS++9qOv5nM4tj1IWTSL7TXqOcqOwY
	EX//smHdxsRaAEYT0PR9zNUzwSsob7O45dx9o7aHWSFr4nVAl87dbKGohROzVUWK
	q1Y6b8Msuf/j4hiY2DQCotW2OD6zxSL+rgo/3KKR4b61vnzVbMX22ptZN6psPnJY
	0sQ/rmICbx03EGgE2MM/j6q+8DzAlpdeZ9PxqVlskr8lAXH9UztEZ3my0wPO2u2C
	i6kUg9Ydaxr6giA4uKOJtCyuCW3bsYMBX/HAbsfygwFtkU7MJqRxgujkVCc7xJx0
	w6ChXcBcEYoFvmzuFhBAahdkbLLUg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j3uasmxgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 02:43:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9g01rzQlJvYdMV/fNmYKlrpzuH7I2SaZ8b2wlKB1enx8zpiTtiR5K4E8PTemdJ/Zu5TK4bHy/x7oENmf9l5BRnAf2J/+Fozf14o/PuTJVSQ3W7gABn1glZwEnPIXnogJoU5vjX6RTMgqQMkFW7qsKqLxfc5BzYcmVNp8jMEP1WU5jwrDIUJFeHmnsVuLdtK628jLhAHeh1Ytq8FjlK1bfFb1wEi4+WJ39grF28TJJD3iGPBHdL5u5oR1e/sd76wClNRuEEf87KwmtH284n4mPKS7pw+whbsNg095vnz1BZ3uysCCpzXE2Fa2AgmOAHrjl9N/OZ1RIawt9XQS8Zb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9htYT813Lde6l9f5mbhJYwyn32bqYsvj6jbaaxYBN8=;
 b=DNPjbVa4b7t152sNrWGb7tdim552vgV7kzT++pVKBifKkFaiHfnoJQ6MWd6Sd3Segzwa8wvqp/8c0zRFHXUuHgY1H0wT5hIq5v8bDyL2ec6SyIg+xDspVT3o8lGbUZce2EMF6Yvwr68BtCar/2QIQ1MmoVMtRIE68QaofW4i9/o/WXZO0Z3uNxlgDn34VH4OUQIqHUmrkoz8AyGdSmeyxmnoaw0srzCssM47CmGlQ+WEOOhd779lZxCFAbjIQsEAzjxHpWMU/v2NcxL4tqPMUWoQisAXN/lR5Dc//yLIUCaRLEChUF8TGpbOlQ0gVXLdpCVIIan2+cd/BRWSckDqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9htYT813Lde6l9f5mbhJYwyn32bqYsvj6jbaaxYBN8=;
 b=CYRSEwInGrK7QRkAw8+ukbiMz3pzjKk8xgBwjesLyetAJZkLUjqIxtIW2/RTDu2qhXkdngqbmSv3yc+eV8kn4S9v07sAdHaeT4zRoH08/aA6EwbHw0wmG7ijBjjkL2Y00WQPoOtMpB4ejQxWz1hUT3BHYL+nvgzMFVywN/p6Y+w=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:42:55 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::53) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 08:42:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 08:42:55 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 02:42:33 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 02:42:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 02:42:33 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AN8gIfm2298779;
	Mon, 23 Nov 2026 02:42:29 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>
CC: <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 2/2] driver core: platform: Allow drivers to skip PM domain power-on at probe
Date: Mon, 23 Nov 2026 14:12:18 +0530
Message-ID: <20261123084218.673382-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123084218.673382-1-b-padhi@ti.com>
References: <20261123084218.673382-1-b-padhi@ti.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ae587d-1877-4060-f0ef-08df493dc50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|10067099003|5023799004|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	K0VmcTOl9zdt2l0qxNvhhtBuOfc63c3MFsW+ojDVUxlnlwq3q54urvNgp8qQTqwsWDI8OPekBLP4i1FXafMsaTaXJSxXMkHriDfISfxnkcXEwLaeojuWgKetrY7zf4CzO/Ym0URtsOuZVnTgvTV/QIrVA6izn2t30EkyXLVQAj6jzxuHCMI8wUeWYB+EEynkWChPuij/y2ur1nAEeSvLCabzfrumKqYYD1timFXdNYj8jC+JW/Yslbb7seafo29xabea+91BYDYbIBzvLDA9YU1MbsFSL2hoLlbEJMxaD7Emn7rkogBrmXwNPCEhcWK8lQWltayZUfrD+wwRV4cdfk043jLVa1VK1s7XUDkTj/YEjOtOYzOZah6DxImUdkQihxV+YQKm3wWZ827MBWFgLN9srmHsQzcTpOs+Rj5zr9Ki0N2UJrpjABHnqTJXbWgzDnEJ7pODMU654YIua77UVLfZyHO9H0psYR5tM8ytgG+dYIbu+eAK9/XV8zxw/MGk0NlZ64o2Tb35aYEBipewZHgBOY+6Aa3QAmvflFqva0umhmt3QP4y/UuKsZsi+QK1w0dog6LwBugdlbKk9GmubcfXzyQpBRkP0inyRU3HO4Iq1oFDt8kk4C/GojEBqdA0aomBRKZM3rZt1OaGE3R+2G7hR9kMurNOanxosKY0O+4=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OWZaS7mwii8Xjudj0WzeRQ3U73FRe+/TQpMJr16/P7sOdaxsU+suWd4UuKYBugLIDE+rsWgbrG471sfVUHtTOOzjM+BcER0fHDQm408yUXkGtMHTKj14IZerKAfU7uQG4rDyS83Nrd/nGafuduULmOaOFTux6Ss0I1Kw2Bh9f407+eAA2zUHfVahBlb3bxec1Gg4tTrBM8ZvNeB7qSk7KrRYGYHHS5L1dvc8h17WKzrJoWWORsEeF5a0j4/hZTkif0Mj0HvaLr1rdBbZGYyTiFiUworXnBFGTc44lhRxzZ0G1IzhJShyiLVpBDw54vMJgIBpPOgbEAZtSXcbASRNMF9Hnc3BTpIRqnVA/H4V2Ros6HmXDjDhMjC9ghjF1O1Bzr12s50J1lBPHuJIcaf590pLqOXJj2GzaGWjZSp8tYNq/OgOO3EuEM+82vNiC9Nh
X-Exchange-RoutingPolicyChecked:
	oUN/kOujW7Gb4e98sbZU2s+tjGnsIBVNyDXVQSqkEkHkFqi8U1Jfh0eLosQjX0/HMusMoh4dDWTkr9xLkFQWJZ7LO9UuGj7wli4wRwmQsQ07JBDIigP4g6gjpRAX9iMP4+Ode965BfIA+GGWTtkA89AB9CX75A1LtTeugck9h9ALdBNzyoHobW0FBlRf0rwBVnpB71hVdTvNg1oFQvmguScN4DAFynev1fmM4VVCUBTeRmu1VUsXQOTwuVk85vVgLcz4GfSfO8aPq7ZEB3nXvm1oco5mUGJLq/dd9dQNt6uauvih4g8EygWjjuuNboOx7wyLuVMdhG3SLpV8DBm6LQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:42:55.6220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ae587d-1877-4060-f0ef-08df493dc50a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXxnJIUf9RfGmq
 2vc/M74RiXM3X8V803efhJSBQeGO/fNPXLjlE0n6RKxIfkZ8OVpZKjJWf1jbTRiOZqNxXv960o4
 XmoQUcQ8mW4/F9bk4S2FmBOKtCY/Mj3MGdmyfGdPps35e4wAPckuDscmOlDIfvn52mM3Ecd5eRI
 UQvYygEjW1ZlFFzk4WwS/9okjwopjATFwLjwoGx22VqaDQMRsxklM5ejdJkCAg5mQB3KX9SiDTX
 15zLHcEI3OyOhpEFYr6ipSeLi0d+yLgyPsl8Y9zZcLxRHV1SsaEwp4FfF7jUjBOfoee+sbCYA3Q
 usqLqmKqwoEME9ejfleBqz7+USbuemdhjathJZMzbieVdCa0iBPdBvqq2ktuzGiC+YYVAUtX7EL
 Ai1NfcII4rSLAdUqD5dVgDftR93iLvYwyypfXlTGN8Sop4WJBrXZf53CurKzxvg5Ne/bQKJ00Eb
 MQ1nPazT51Exz4xwyxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX2Ky7M3P3vx5n
 jCiMB3PLtZDnlxXCsKIdI2GuEy+pzikD7ylxLrdaiL1wilKALYCZ4rHTi7uI38z748pRMwjvxI5
 2DSHgWi+G5g68cLuxBA4rrLBsHtAwcQ=
X-Proofpoint-GUID: xapmbwKIAirXf0LhJf6F1yG6M0Vun842
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6b03fc94 cx=c_pps
 a=GRGg88i0IYp+MSRJKvRoYg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=LTqVseZ_fjbzjx0MZbUA:9
X-Proofpoint-ORIG-GUID: xapmbwKIAirXf0LhJf6F1yG6M0Vun842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034

Currently, platform_probe() attaches the PM domain to the device and
powers the domain on before calling the driver's probe. This works for
most cases, but would be erroneous for devices that must be configured
before they can be powered on.

One example is the C66x/C7x remote processors on TI K3 SoCs like AM62A.
Such a remote core's local reset must be asserted before the device is
powered on, otherwise the core can start running bogus instructions
whatever happens to be in its memories at that point.

dev_pm_domain_attach() lets its caller skip the power-on by not passing
PD_FLAG_ATTACH_POWER_ON. So, add a pm_domain_no_power_on flag to struct
platform_driver by which platform drivers can opt out of the power-on
at attach. Drivers that set it must power on the PM domain themselves.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
No changes since RFC.

Link to RFC:
https://lore.kernel.org/all/20261027140751.2465743-3-b-padhi@ti.com/

 drivers/base/platform.c         | 7 +++++--
 include/linux/platform_device.h | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 979593e5cca15..6e7b803a50ab2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1482,6 +1482,7 @@ static int platform_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
+	u32 pd_flags = PD_FLAG_DETACH_POWER_OFF;
 	int ret;
 
 	/*
@@ -1498,8 +1499,10 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
-					 PD_FLAG_DETACH_POWER_OFF);
+	if (!drv->pm_domain_no_power_on)
+		pd_flags |= PD_FLAG_ATTACH_POWER_ON;
+
+	ret = dev_pm_domain_attach(_dev, pd_flags);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 3bd0f1f0d8704..4d1679c4ea78e 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -292,6 +292,14 @@ struct platform_driver {
 	 * to setup and manage their own I/O address space.
 	 */
 	bool driver_managed_dma;
+	/*
+	 * By default the PM domain of a platform device is powered on before
+	 * the driver's probe is invoked. Drivers that need to configure the
+	 * device (e.g. hold it in reset) before its PM domain can be powered
+	 * on must set this flag, and are then responsible for powering on the
+	 * PM domain themselves.
+	 */
+	bool pm_domain_no_power_on;
 };
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
-- 
2.34.1

