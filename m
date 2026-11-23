Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.40
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451566;
	b=JlMTrgPWQ6JWe6uGHjjbSlImi6d3CSZP6YAcTT5MrJlQPH8U070mrS3HACl9zAOXIy4B
	 EXNClekrBhpuwedoxy4ExS4GIE7h5obcw7bykF2XPiGspPerJuDqFkgFWNTo0BXt2SOAP
	 bL50NvHzC3E28p4JBRqXF/twkB4kDX94lMYBNrqbuPjMzXTo4FihmIM1UcMe3bmvev/sd
	 n/xA6BK8MbvKXJLTqn4hx/F5HPHrNYx8NbXlNelWmTOB0Lj7mo7FX1TQhM/RFJvrxetjX
	 VXRhMBPLs/LFWc9WKTa6OoxYh99xaCJTPBxOrfWxtyW3D6zPH1Vm/k/2v56X6IZF3dQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451566;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=ukqc0yo5gEQ2tKvtY9Dgvfl7A+uDQRYxK9GV3vIi8YA=;
	b=5EBRguRGPqBzlfz0pGdjVeZZHjwztusLrQL82FcYzxDWABo07+4x+nm6pWurcQbTci3I
	 W6XhOKVVRjx6x11cAXddNdwawygR7L6JFVD0BV3YsgFiopsWuEMO7KSmAp/KE2Kcs9sAK
	 fdgCHiFAryfWcL6nueRcYu7SmjrOC1ZCWX2I57LY+gnIGlnJ9HPFEBZOUXi4GOaRIVow7
	 Dif9QFybqJAGXpinnL7yK9GGCY4rJ1F+XMTLkLHny/mkvftJ4AadTg6b5ZviBtapxRXpp
	 mPgEvetniExFktUInD+1ZLWtvl56GgAaDjRyz+GK3WPZPSJ7qM937I5+ico/CjUpPZA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=YENNAgAN;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=YENNAgAN;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.40
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74285606A321;
	Mon, 23 Nov 2026 16:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74285606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=YENNAgAN;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=YENNAgAN
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Q0t8fIalQk0QruvLWzdngxX6i1X2eiCYmwlzOfJvMqcnJ8b6dUfwwhdCqNjgljBGeVAMISuLJpmyr4YmtIgsjy0TudoqAFBgom03Qo9z++Im78tgf4hAFs3W2s1Ywj18sQ9zNFsP4Z52Rw0A9DQMOGMYfQHaceesR/2SGJJRHcbmdQ9JK6M9jCqSYvvVh1UvPaeTY2xIIy+gczK9/xpam6EdOrcY78eMLEjUz5dk3Btxby6dDwEulZNSb2oglnOE30GOy3nWD7cskrmakLiSgYFS4vWJd6ILO86fFC9wRliLuoBy79cp1RS4uKRyS2lNJv8qgDS+0/Hi/yC2ldQArA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukqc0yo5gEQ2tKvtY9Dgvfl7A+uDQRYxK9GV3vIi8YA=;
 b=ITEpwucdgvY67M/6BdSLWm0+ZD85Q2EDoAoSjb6eIxc8TbtKlGUfSEWcQHwctJ9O3dseQ/kUakxG3vTNhibfys9/S/0te68x8CteZfxdW3PyCSq4e2tBn4lUOXdVWhEtW5NRNU7brjYX7nxFhTmVhmaZX4wO6jqHo6kCg4rmOXuvrm5PnfFyLZ5A4rJ8uSh8bYOx1SCcPkfDVqnNk2lXzVrh0erUKDqZn86HoRrwBJK56FQf+7u9Qu6H+q38MUoHUpV5qcpWZnWc8IzuCIIZflJw+v4QYntgX7X4SwkeD+vAQx5dTPUN+XRVSOvSFV4wWgu9VpGGQi8Qige9xdJBPw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukqc0yo5gEQ2tKvtY9Dgvfl7A+uDQRYxK9GV3vIi8YA=;
 b=YENNAgANAn0nmpZPP1Dnl0qDS7Vrb9DdCb25HLn27mLcRCOBlMcpFZly4Ml4yPHvujoPESFPECu+7yIYKJjk0MSmFnZ9xZdfHk/rC726dIcPoLIPbrM0IOi4K5ZtjmbzwYzPjginqE4kCipYeWhp8FbH7WJukAFINXhpAOF2i+c=
Received: from PR3P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::19)
 by DU0PR08MB7638.eurprd08.prod.outlook.com (2603:10a6:10:31f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:32:35 +0000
Received: from ZR1PEPF0000E45E.eurprd04.prod.outlook.com
 (2603:10a6:102:52:cafe::ae) by PR3P189CA0014.outlook.office365.com
 (2603:10a6:102:52::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 16:32:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E45E.mail.protection.outlook.com (10.167.241.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 16:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk8SDaQeOsReVJYZM6tI3Z6aKkhnJ9u9zOQx08ozZUQYSsHO7SzWJOHx5+nUKB6ezbjfsM62DXGE+zynvhqjZ/xdBeG8a18vvfSyP7ODB4OjteOJrPhyGEHtYiCZ72m3FzbAFf8JD7Sh/iuCALF70G0qqGpxDomxlMhu3oFk1yGMUgz1aqTVxYZD4c9OnWhLH0sUd54e22+rLU/0w491wskO0ylSHXWYobcUTCElWP7aO0r+O3LOZuzJPX7/GSns7+ynl3tT89Ki9xl2I4ogCh1dH0LY/OJfhKcfhSVbbfX95+zCvie4jCwvFh4eKp/6s9vG8VizcQDGGuVw0PqjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukqc0yo5gEQ2tKvtY9Dgvfl7A+uDQRYxK9GV3vIi8YA=;
 b=JsjR3RE+ZYnDQOcpCZ6gxIGM/1UccFpf+aGWgpULEWV4OwGHJHVDycdTqJXfe4vKOUN02R/9J8A1ay0dgo/8Piq0+xhEhiyILahd3zQVutcxMNVoFSLrpeaWsaETqDXbuLc0LLmW3kZaihfKYvY1tQUZmjRlFdNmNcpqh9M7EGhtRZMWpjjVGWc2KcFnNR5bgMxQXSEj55fhl7YNnJFnYq5pLnDTm7c0nFlPhOVHpDIX8vQ4ZVvfalvvvWW5T+d63vxVjQPtpmvnQL8lJvTrbgjNSxzZBvLfKOlBoFtyAMlqxbaDrIXe0bQreQA8dANAEOmbdmUGBF8xBggCh0qNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukqc0yo5gEQ2tKvtY9Dgvfl7A+uDQRYxK9GV3vIi8YA=;
 b=YENNAgANAn0nmpZPP1Dnl0qDS7Vrb9DdCb25HLn27mLcRCOBlMcpFZly4Ml4yPHvujoPESFPECu+7yIYKJjk0MSmFnZ9xZdfHk/rC726dIcPoLIPbrM0IOi4K5ZtjmbzwYzPjginqE4kCipYeWhp8FbH7WJukAFINXhpAOF2i+c=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by AM0PR08MB11829.eurprd08.prod.outlook.com
 (2603:10a6:20b:744::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:31:59 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:31:58 +0000
Message-ID: <e78bdcde-9a06-47b9-afd7-e03ee10b395a@arm.com>
Date: Mon, 23 Nov 2026 17:31:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to non-boost
 freq on boost disable
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Oleg Keri <okerixx@gmail.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <auhMD2-5FD4BqImG@vireshk-B250M-D3H>
 <avRiWsxCEAuBouBZ@hu-anancv-blr.qualcomm.com>
 <avwtsmp7Mqacbbtl@vireshk-B250M-D3H>
 <av2aFWw3kh11U68A@hu-anancv-blr.qualcomm.com>
 <av5_zDI4bg28H_6e@vireshk-B250M-D3H>
 <6d6a84bf-29bd-47c7-9243-ab0b9e2d7f32@arm.com>
 <awQT59OrWPyMzxtc@hu-anancv-blr.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <awQT59OrWPyMzxtc@hu-anancv-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0171.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::14) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|AM0PR08MB11829:EE_|ZR1PEPF0000E45E:EE_|DU0PR08MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3236911b-70ef-4d33-5c22-08df497f5fca
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006|5023799004|261009223327099003|261009223027099003|4143699003|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|261026121527099003|261021135927099003|261009221727099003|261009221227099003|261009220027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 lSwzFYjC6/8G3bi3zjvMTw7ujasEMazk8XGKJF8PwjdR4CI81g7OxDfnhB1VR6nrixW9FTXVuxVWs6CDDyATrul+3rPVH8WMJ8IIzNOywVWZJIoXTN8vAj+K3Q9AZRF8x3YpgXuVTh4jaxoSwoSBdLDJKAwfCZrSPKn5vm1mkw80hxI6i3FzX4o0GhQGrUE+quusYkKTKRO0btJnz97WajcCIcDOIVbHhnVBXnVYPCGNqUZUy7rBnK7mifmP98quDTH0q08ApTFqTtXhSihx/L9J6Wh3TswpTxji/tufwKTtzXyX1mga+qX6zKYW6+t06MUw1nx1PSF8Fn6rA/TsrO1bU+Vbe/GRsCtKpVcPKIjnGODIVhvA/dldUFCF+F+nv2mnhBllDI7KwW5E+az+zfc/yVuHDQKcsm7gAgCxvqxndcka6w0Px+LCKQQalHdfCVQr1qtV9zFDAF4lV4s4tp8+YAkmhj+Pv70qLANpseqgQ5cXM7cyw/W2+kIB/OQoc94ei/5I3XUquv5q4oXJ9+J6qoru7db7jtTxLBfayOzm7r9l4okDEVswYoid0aeo7cpXah2UVMpB87hPa6m7iKD+xWy9AlYiRvZcll8kxfEkrlSMDsT2geyLwsoXlxkY
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(5023799004)(261009223327099003)(261009223027099003)(4143699003)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(261026121527099003)(261021135927099003)(261009221727099003)(261009221227099003)(261009220027099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 M73FCe0Rg9FWNgkDcqR04YSsvqVmn/UFL7TVP/1a+Bzqx9apR9+loNOMoHeloL7rrWZfD+Lf+hMeXMuX5Txs2EsNffKPr/jAyqXJT+PgH1SdL1Xa8g71OiAVzvM1XoFol2ACqPc/+9KCV1vncoj1r30vZatfFBP2mpQFsWIChyZexoHYqmqoVbhPrtBkkezKy6UzEk/JMahhJl6Eksy2FheghQie7pb5oJRHt/mrDUuIEGSJbOrUZlOKMVuKr00ucUDRIL4yc5DQ7P91W2z4Xcu0/dKglhSS+cjYtnY2tjv53YZUXfzY+gNMRdTyRWPvzDSafDj1y2kxnZ5X6SuXkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11829
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d42df55f-d48b-4d57-9314-08df497f4b7c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|35042699022|1800799024|376014|36860700016|23010399003|82310400026|10067099003|261009220027099003|4143699003|11063799006|5023799004|56012099006|261021121427099003|261021135927099003|261022075727099003|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261022105027099003|261022115727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	XDUvKBpYHgQ1GyI4oSGHwiwcjG7Oe83kNcDgvvtKPMCOV9xiAeAKvcUvMM4DsfkzlZBcrId2dluKtahqvkwj8zde8siOPcFd+vQ/jUVV69bo5ZTSTCZXbx5dJ1kHgCrDbLQVaGZ8Fgo0IAHwcHrjY5OKTtaWQzJaAH0SfLefZsahjl5p/ys01KOQrsLeJ6V7eAqzKtULYz76vaO6NlufgUrBq3FJ6mToo1RzeBEdI9In7prGI6s9HeBfJZ93YfKXb/OGan6c2r7VUyYqQxc0NRd8PggXyHal4R9hIxtfFs4FWceSxE5u429f94ZOqZuw61YNdQwDwMAo9pI2TWTEQSBlyHHrdHoGNCwPYWR38AWZ+LVFj0+oHdANJBydDpFxXvEjQZZEFDh8qI/F7BBB/Hp0Sh6ag9DAeisk1g6LE4+NIRy83yrd3cA5hxJB6lnxqxVNMTBw5v59CI2pRDNYTFadpK7t/aevIDYXzVZvkQ4TzUXcG2ywtKs7PRwi82m2MoHW9magb9155c5IBD5nGuDv3IVgTaj8a+w2t0Sw2OyGDo83j4IIZrw8rSUFmIQQgPXtFRlREHpsxYitAv9BrgYZaQzl6qXT2qmIKjIwF+iaSEP6EdiG2k0sMbt0gasq6BwhN9c2zLQ2TXfjjBowRTsKBQ67/8HE4qjQfYcgQ1Y=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(35042699022)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(261009220027099003)(4143699003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261021135927099003)(261022075727099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261022105027099003)(261022115727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mvtW3YCV6TkILZFrfUThGJ0FH92e/4UT18gH02DQIr3g1Pfv/feAwGwPeTwKlAX+Md2NLUtVjbz/QDNv0vnfPloIxrod24L4X2zsXR/9BSIx39e0XaJIsx39N7rwyZBa8emmw5GGVgPnXpKRyzNM1edhnX8uPZ9yMtDsTbE82I0pacvhR5GOUj1SjEwjx31xtB4YstWE6iCo9epMKgQBhxuUC0QOp36c1ruEsNnp2zkXmQGw0FAZ3DRsuD1ZQTMW0XCVIB3qxvY1klSdPRD50gAmI6kXt+GLtVMq4dLP0YIedlwteBYQeAwBDxaEBSIx08QJeSxS3XoGyFXpF80xyMNJA+UGaDkp05GtldDM5pVCUowunZC0pbpKcf+GZah0JvvxGkPJ3JfYWAAVr3AyXUwMj0VR9tSxX4H7vKQjj19VfW1chjlKwbPqUu1k4MOC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:32:32.4897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3236911b-70ef-4d33-5c22-08df497f5fca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7638


On 11/23/26 11:22, Ananthu C V wrote:
> Hi Pierre,
>
> On Fri, Nov 20, 2026 at 01:08:01PM +0100, Pierre Gondois wrote:
>> Hello Viresh, Ananthu:
> [snip]
>
>> Sorry for the wall of text:
>>
>> cpuinfo.max_freq is used for various purposes. This patchset corrects
>> some bugs, but ideally the usage of cpuinfo.max_freq should be clearer.
>> cpuinfo.max_freq is used as:
>>
>> The max hardware freq.:
>> - cpufreq_schedutil.c::get_capacity_ref_freq()
>> - arch_topology.c::init_cpu_capacity_callback()
>> - cpufreq.c::cpufreq_get_hw_max_freq()
>> - intel_llc::cpu_max_MHz()
>> - windfarm_cpufreq_clamp.c()::wf_cpufreq_clamp_init
>>
>> The max boost/non-boost freq. (i.e. without the user-set constraint):
>> - processor_thermal.c::cpufreq_update_thermal_limit()
>> - cpufreq_ondemand.c::od_update()
>> - cpufreq.c::policy_set_boost()
>> - cpufreq.c::cpufreq_update_pressure()
>>
>> cpuinfo.max_freq value depends on the presence/absence of boost. It is
>> thus hard to know what the field actually contains, and:
>> - PATCH 1 adds cpufreq_frequency_table_max() to get the actual boosted
>>    max freq.
>> - PATCH 2 allows to retrieve the actual non-boosted max freq.
>> are trying to rationalize that.
> Thanks, cpuinfo.max_freq not actually being very clear about what value it
> contains is precisely one of the reasons why this approach was taken.
>
>> ------------
>> The following frequencies:
>> - max hardware (boosted) freq.
>> - max non-boosted freq. (i.e. nominal freq.)
>> are CPU/platform specific values that can be computed at init() and
>> which will not change merely because boost is enabled or disabled
>>
>> The existing. set_boost() callback implementations are mostly
>> retrieving these values to update cpuinfo.max_freq, but this could be
>> done from the main framework if we stored these values (in cpuinfo for
>> instance). Similar remark for cpufreq_frequency_table_cpuinfo().
>>
>> It seems there is a lot of code to re-compute/update these values even
>> though they should not change. Computing them and storing them once
>> should be possible I think.
> Right, that makes more sense. My original idea was to not go trough separate
> iterations when freq_table.c already does that, but it makes sense to just
> keep it entirely seperate and avoid further calculations of the same. As you
> said, the values should be constant anyway, and once calculated they should
> stay the same.
>
>> ------------
>> A. acpi-cpufreq driver
>> 3c55e94c0ade "cpufreq: ACPI: Extend frequency tables to cover boost
>> frequencies" added a synthetic entry in the freq. table to represent
>> the max boosted freq. as read from CPPC. Entries in the freq. table are
>> otherwise fetched from _PSS entries.
>> 538b0188da46 "cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost"
>> is known removed the synthetic freq. which was added in the freq. table
>> as it reported the synthetic freq. to userspace which was apparently
>> confusing.
>>
>> PATCH 2 "cpufreq: fix policy max not returning to non-boost freq on
>> boost disable" modifies cpufreq_frequency_table_cpuinfo() to handle
>> this case, but maybe it would be easier to tag/flag the case where
>> the max boosted freq. is not in the freq. table and handle this case
>> separately. Doing the following for all drivers makes things
>> complicated IMO.
>> ```
>> /*
>>   * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>>   * it as is.
>>   */
>> if (policy->cpuinfo.max_freq < max_freq)
>>    policy->cpuinfo.max_freq = max_freq;
> I take it that (correct me if I am wrong) this generally means we don't
> want to go implementing solutions for this in every driver and instead
> should let the core itself handle this (which is what the current series
> is trying to do)? A maintainer call on which route to go will definitely
> help in focusing the attention there. ACK on simplifying the interaction
> with cpufreq_frequency_table_cpuinfo().


IMO yes, the condition above which seems to be only here for the
acpi-cpufreq driver could be handled in the generic code in
policy_set_boost(). The max available freq. could then be obtained
with:
unsigned long get_max_freq(struct cpufreq_policy *policy)
{
   return policy->boost_enabled ?
            policy->cpuinfo.max_boost_freq :
            policy->cpuinfo.max_base_freq;
}
instead of storing different values in policy->cpuinfo.max_freq,
which seems to be made to describe a CPU capabilities.

This would also allow to remove the responsibility to set
cpuinfo.max_freq in the .set_boost() callbacks and factorize it.

>> B. The new CPPC spec [1]
>> The nominal freq. will be writeable in the future, so some additional
>> synchronization will be required.
>>
>> ------------
>> This patchset adds a cpuinfomax_base_freq field. Maybe we should also
>> add a cpuinfo.max_boost_freq field to make it clearer when someone
>> wants to get the max hardware freq. If we find a way to know when
>> cpuinfo.max_boost_freq is a synthetic value, this would allow to
>> solve [A].
> The idea was exactly this when I went this route of calculating these
> values separately. The previous revision was doing precisely this,
> by adding a cpuinfo.max_table_freq field (fun fact, the initial name I
> has was max_boost_freq itself, which I later changed to max_table_freq
> because not everything is always boost capable :p). But the general
> consensus was that, including the reviews from Rafael, we don't need a
> new field added to track this value. And even for the max_base_freq
> field the current revision is using, the general opinion seems to be
> that we don't necessarily need such a field. Now, I am personally of the
> opinion that adding these two fields (and calculating and storing them
> once as you already mentioned) will make the calculations infinitely
> simpler. What route should we really go?


I also agree, but also Rafael pointed out that this could work without
new fields [1]. Maybe there will be new elements in this thread
and the direction will change (or not).

[1] 
https://lore.kernel.org/all/CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com/

>
>> The new CPPC nominal freq. should always be lower than the initial
>> ospm_nominal_freq field [1]. So an additional (struct freq_qos_request)
>> for the nominal (i.e. max_base_freq) frequency might be nice to have
>> aswell.
> That sounds like a good enhancement, but I'd prefer to work on that later
> once the current issues are solved, these are bugs causing some decent
> damage afterall. But LMK if having that also is quite important at this
> point.
>
>> ------------
>> Short summary:
>> The patchset should fix the bugs, but IMO it is still not really clear
>> which max freq. is stored cpuinfo.max_freq.
>> I think we would benefit from also:
>> - adding a cpuinfo.max_boost_freq
>> - adding a (struct freq_qos_request) for the nominal freq.
>> - use cpuinfo.max_[base|boost]_freq wherever needed, to simplify
>>    the .set_boost() callbacks for instance.
>>
>> but this might be out of scope if the goal is just to fix the bugs.
> Thanks a lot for being detailed, Pierre. The direction I have taken for
> this series is exactly this, sans the additional qos request for the max
> base freq. As you have pointed out, the current goal is to get at least
> the bugs fixed. So having the maintainers make a call on what is the
> direction we want to take in general will be a lot of help. What do you
> all think, Viresh, Rafael, and Pierre?
>
> Best,
> Ananthu
