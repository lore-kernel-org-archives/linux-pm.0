Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614790;
	b=BSMXFz3oE3xTMiFanCMcZbazm8g+pzwNVX8zWYDv7FusMZYDNuBnPUiAA0QrcUMTQ9KV
	 BAVO4vaOKrS6T0NMKMBEq1vFfLv/zlOvG+ac0SndNqLhqG2QfKZh24Y0N8XiHYL22tly3
	 V5WbesT6Xd5ATBzb/I5rc7n8TWcyVf5d6HsWEbIfckZVPPMUdsbvbzKQ1yZYlmYn3/bEa
	 WbrpHUokzbd25gT5s/oGq1Q9yqhDNLShG93Z54au3WtHFM6b5qKHRmOKr46Dr/PERiIQ+
	 oiCzw73igZBZRjFAaiaffWn+kZRMDZVHyKzZ1Joj9HuzWgu3eFIYFGnmB8IxPMF0DJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614790;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9Zh+yv1nlsdK+S2n8eg9NTBHRSWY5/jKEctsHSHvNAU=;
	b=EP+rXDzVal9Ce+przHETqAsLfSawf/B/yUj3knNCAx3iC04HPvUtNioxf0al4D8RuBOh
	 UnlxAiw+qaI7OmAebZTOgpgCarRH169SMym5O5bR4kwRrTD6a8+gACBzCYTpNj8D8nBJd
	 Cdjp4hUY+GMLFhPioq6UZmJf+WH1skmV9FP83PQ/IyIvuWLJHy1OLM6nSqoWImy4DWMYN
	 FuTomj1xSiPQiZ6xwhISismStI8pm1VmyTunW6rfmxN7Pc9RsDzSSxGVJd4O3uUx1Ym7A
	 9kOGcUQ2rwB0hpduX71pRxTOAhDjCcpAPvwO4ImN7WcVXSoYjPyhSRP4VzmdI+Hae0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=jrfl9KKO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.15
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCBE606A32E;
	Mon,  2 Nov 2026 10:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCBE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=jrfl9KKO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQJ7jESO8tnd5xasC6ji0cA3AcvyQmIyN17Zc54fsQrpwCID/sEEfMefjroJ0g8hQU9AXQVK61ZnDR59HM+sqdyh2dX3P6jeu5Q1c7Q7698YoA2L3lckLaM4ZQKyZcuLknGZ2EPkjRbOjzCI0+aNjCbFE3x0iv7EXKrwgrPkO4GzZWHecOESgaUDOO2QnKDT1S7v7bjPH0ESCeYlnGPmQU1AACJ34joaRaErKfWQAVUT2Mjo3D8LVf2bQIu5RknwBwSCqsLvjNkumuBNFNsaAcu4yykcUem6nwZOk6d6ls+VZhnxJqqSkFzgz7f/VhlDs93PSY5WgRpl0bHcHwpf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Zh+yv1nlsdK+S2n8eg9NTBHRSWY5/jKEctsHSHvNAU=;
 b=OtLjTFo4i3hiZ7kLX+hdOF+ng1ediokdOIbpocvaekMhRaZLDJRMHGu7hHlGToclFx4ofrxhbsmeivI8tdvP6nEeb9M58Jo0r+6cFS4iB0x/yU4oJcPP97TxrSFvyn2At5pQk8hrYAbfFKbfmbr45BVlbNukzIyMLCgy7tlWYtlp+OKifvpYEyyfj3i3lU86mrVqcVaYSc55R4bF2vtVG4E3KY/zLPjA3uYph5YrP3XRmdiGgaWGTvhzSoU98cRV5uDJHWlRg4jBsIacQqh+MSD/qcdEKAqo6mEM5+soh+Zt3ADwBRc+9ZB/nuYgGDFfZReXXlXo2FuN00RDkNcPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zh+yv1nlsdK+S2n8eg9NTBHRSWY5/jKEctsHSHvNAU=;
 b=jrfl9KKOA/gyjySop+UpLh/j+81hFkdkjLTwK3OGAoTw6Ph9Vfoxr+A43IY4b90UkG0LKcMkzUQFIn89egdZjFQwpoUf7/2KWut41IeYCqyHjYea67N2akCvilSpl1Fcap977cN9sneLaAyHKfRiVWCMsn8APlBUisHdZUfWjlI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by AS2PR02MB9367.eurprd02.prod.outlook.com
 (2603:10a6:20b:578::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:19:46 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:19:46 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 02 Nov 2026 11:19:30 +0100
Subject: [PATCH] power: supply: bq27xxx: drop dead data memory update code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bq27xxx-cleanup-v1-1-8810e411dac5@axis.com>
X-B4-Tracking: v=1; b=H4sIALJj6GoC/x2MQQqAIBAAvyJ7TlAPpX0lOqhttRBmSiFIf086z
 GEOMxUyJsIMI6uQ8KFMZ2giOwZ+t2FDTktzUEL1ssHdpYZSCvcH2nBHrswgvNPWGS2hVTHhSuU
 /TvP7friUjWhhAAAA
X-Change-ID: 20261026-bq27xxx-cleanup-2970cb8ab981
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com, 
 Henrik Grimler <henrik.grimler@axis.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3213;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=RVljIr3i2Ol9lLMfqm0Wa2UAqQ1Lv5tScTBKYNWfViw=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBq6GO8qNS4GGciy1Jq/6Ehfbt6EVXOEIWnyCmtv
 khLb1Mks6KJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCauhjvAAKCRCwB25JC3Fh
 a9VXB/4onEIbq9Yj/GCAXrJliMupayiBU0aCZNfbuRPr7WGU4qLazMDfw5ICZ77rnVDQ07tE1fe
 2mCF2qyXGGoZGHKA9KEHGKl8BFoIzPpeoDXKgiIyw4gJpeTCcZ6T5hotpbByvtaTMdWKojAK5oy
 6dbGmq+awHNzxzJ7oUBqUdHTl6N5zxRcz0Fg+RTfiFf6WQiPhL7c/kZWiJGLqgOv04/9ComP7SL
 8vMyPSrytJZI8ozlc4GbFN6Td+54h5sGWcAeRuRy/efXXyt+kNRQ0xcyCAs2b6a3Q73AUei+z20
 opg2XVLSZLjkGz8VAaEGPdt4Tq+SV4SXKPdi8xGCsZM5W0Ce
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: MM0P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::14) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|AS2PR02MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: 270acd75-fc20-4b3d-f348-08df38cad0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261028144727099003|10067099003|11063799006|261009223027099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oQt8hXjgVRnZJjC9jehJ3sZoalkMDESiSN05uMnw6aAcYO8LTWibEr0N6m9Okoijh13AkoFD+knUvhNp06yyVXjpNk/yKqdpx35IuFdqXSmms1GIwIX2pyrsJxK3ytwaWrXpFcCb8tzPD452uGrNYTjYwIzEtfzGA1qXYzt0F5Id6msftR9xqT4zmuy6mYFq2aBWVLbmijzLgP9kuK8lETyq5jHgLGSaNtwopzt6O/z4TaA07GVXtfERAub+KwLo9ojoc99pAj5v6iKVjQ7k1iK/wFyj7h2YhOT5IiZK4UhKu0n/fkq6glQtLrIwTvxiaMhPWNXleThvDRhH87N0XHgQ+JMOpGVUsc/SWO92ysebgxEnGEJASTy+aUT154htY+Aiwb96e2j/OT4uWgciuug/BJTQS87NcCZcCZdG+OcHFBPMjxTWtTkWpNq7QR8bFW3hac/n6dxaK2wNWXR6luaBT9MuasGNu41huvb/ueozbJwheQ5YpC+cm0f2y5w+xfFBrsJsWsvzjTyEINYWzLikfydXPHWbdEWT5qfZ42H+TKGSybmbhbquMj8G2kD0Gbn5iq6iQZ7fhf4NTEivxHEIz35l73u07sAf44lYvHMBlWnjs8lc2C6FsVyA4hS7QIL2EIv7iKFkufwc8Y3ORAC6lfI6Bxdl1jpU8M+PH/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261028144727099003)(10067099003)(11063799006)(261009223027099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFJRQXhSWU1oWHlhWm9XSGxvcCtVL2JybXdGcFV2Z0pwTEVNYzFSRnVmN1lF?=
 =?utf-8?B?TUVEZ3pNSEJhMjRvMlRsWmlSUWJDZ0NybjdoNDJHeURNZmxnU3l6TEJRTGZk?=
 =?utf-8?B?RlJmZWZqOW12NWxheGdhRk5rTFkzU3AyS1FBUUZEcWlYTzUxTlY2SjFRVnpJ?=
 =?utf-8?B?ZWFqeE52M00rT0ZCcDJaQ0sxd0NzMDU0YjJyUzMvSGtVRTZFdG0vUlZSS2NF?=
 =?utf-8?B?V3g2aHlyRXFkeit2WkdNaTI1WUZVTG94aHJUZG9DN0c1Q3FQQldQUEg4ZHNx?=
 =?utf-8?B?ZmFDWjkxYXA0L2RBZ2M1aG00SVlzby9ZUTB4UDR5UHlZRGRFSTk1bU1hK25Z?=
 =?utf-8?B?dU51SGE2S08wQkFLak5PNFFETDF4Y2tBSVpvL2JCM0lJOUNoV0QrblVoM0o4?=
 =?utf-8?B?cjhDRU9mRlhBeGJRKzc1UDFjejdML1c4ZExHdFJ3TzdSblVrSWplR2sxYk9H?=
 =?utf-8?B?Ym5XQ2xxVGIyV0cwdDV6ZytMRHpxRDJZMlR6b01SNlJvRzZqOUxubkd0NDlY?=
 =?utf-8?B?RjhTSTdhNDNWRDAvTG5jc2p1TDdid3NzK1kxbjVLT2Y2ei81K0U1Q2FxZGZJ?=
 =?utf-8?B?RG40K2dYcUdkTG54dkVvbStPNnZrZDJrM0VCcWNValRvQWdNZVZQdGxxdmZt?=
 =?utf-8?B?RzE0M09Ha3NZSUdXcnFhUUpZNHFYZGxwa0lWUnRFWDJYZFBCdjJqRU5vS1lN?=
 =?utf-8?B?b05BTFB2WlZWL2tQNkVJRVY5dlpyeWlLcHI2WHIvMERRbHFhbUIreG1jYmZG?=
 =?utf-8?B?Qm40cDU0OFJhbVBLMmpVbkEyaDk0c090Zk1FT1E1YUhETVAwRDl3c3BSY1Ez?=
 =?utf-8?B?QWoyeGk2R3NuQVNkTnN4aHJJdE5ZMGFNS080eEJMMmlFdW5GTWhmTWE2V3FM?=
 =?utf-8?B?QWpNLzd0aU9wSy9oR0dya2dXZURPemZTZTE5T0UwMzV3SzNIT3d0bUFoV3cy?=
 =?utf-8?B?M0JJdGNVNjZMek1Ob1dNUWZIeUprNFhVZkFITW13NjdHS1hpb1J2TTJzVEVy?=
 =?utf-8?B?Uk9zQmVBelRpamtvcjNEdURpcXN5b011YkJ0MEY4RXc0amFpTXNSR2RaeG9O?=
 =?utf-8?B?Q0hONi9oZHZ2eFJaSld3LzN6b09wd2svZDJMcDlmWU1lWWhlSXJBZi9oclI1?=
 =?utf-8?B?TUVzT3JqWUJ6WHlGbDZ4RVNFbXJYNkJmeDQvRkFmcGVHYzlvTFBmMDROaUVu?=
 =?utf-8?B?NGQrTzhIODQ0TEU4bVlPOUpocHFTZ08rbDdlZExQVUhnVFUxS3kzZlZydE9o?=
 =?utf-8?B?ZnRlOWVnVVhRZGNDRDV3bTR1TW1iU0hPaUZ5RmNENnZUM1M1aDYyQVV1QW8z?=
 =?utf-8?B?YmxKS2lDOWs3UTh0d1grT2paN0lNK2djcC9ra3IwV1IrM1VDeExhWmlpR1Zt?=
 =?utf-8?B?R3RkejFvT0Y1dERGNHRuU295RXlkcmpxM1pBR3prdW4xRXltSWwzV0ZZZnBv?=
 =?utf-8?B?SUZsczU1Q2FDQVdKY0JMamlOL01paU11L1BxUEFpS0pXbVNuRGJOY2NJM0Vr?=
 =?utf-8?B?enljWllGUzcwbzAzdG9SK2lsZVdsN055UUxsNDBKZnpHWTBnOCtnYUFMNFBu?=
 =?utf-8?B?RkYvVktwUFpWL0Z4bGtZYkgxelhZQm1oaHNNakIwYnk5YUZ2ZG5jV2t2b295?=
 =?utf-8?B?UnFXRjlRRDRmKzFNcENsQjlzQTVDVU9kQStOMkZOeXc4OFlTU05wcWgzRkMy?=
 =?utf-8?B?ZmY2VTYrSG9raUZZNWxMVTV1YWdmL05XZVliMjlsclk1SDkzRFZ2cmJaTjhz?=
 =?utf-8?B?bTNWczRMYWJtZzFmMzMwNkYxY25zMjZORlBWaWxIT0x1SWpXVCtZUzJudFN6?=
 =?utf-8?B?WnE1OVZhay9WT0tlZzVqOWhodXhPQTFLdCtSRXZjUWY3S3FweDlmOEpRNThz?=
 =?utf-8?B?bFUxTENmUzFWM2JCYjJNNk0yK0lrTHB3VGxCVFo4dkpIRTFaYmdSOXNJOFU4?=
 =?utf-8?B?Z1B2Qi9QRGFxa3BDelZUb0tZWEE4RHlqVjJoRFArL0tYSjB0LzM5eG45STRa?=
 =?utf-8?B?MkNvSE56QytCeGNVZkFSMnc5c3Q2S09kREJRQ2ovWUd2R1hXVzR4TzlDNXZo?=
 =?utf-8?B?WkxBMmprS1VXZ1R0YXlvRVpjd1p0OWVYRDB6T2tlb0VNazJDT1dRNFFiMVR4?=
 =?utf-8?B?d0lkS3hzZnNIcCtPNW1wQXFDMTI3WXhtd2preWJrRUo0Y1dNL2R0dVhGSHgr?=
 =?utf-8?B?S1hzZUJldW5ETlZhNDl6RnBIcHZmblUrcjhITzVBTmNCV3RYYTRaS0cvVlh6?=
 =?utf-8?B?Z0VseE1PSUxtamZxbTNnN3Y3Ync1dms0OGhnWTFzQ3djNUtOVEN2cjc0Vlgv?=
 =?utf-8?B?Z1dqTHpiL1l6TE93TXBTRkFnNHh6OW8ycWdxdWpBbjBNYmF2NEFkQT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270acd75-fc20-4b3d-f348-08df38cad0ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:19:45.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBZEsQxB+cCUVNiRQEKM2E/2pFZ2nJYFvy+iMhiSp+e+QHTxJSEIKCh2L66C504fki57j4o4p7x+UzCleAsMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9367

bq27500, bq27545 and bq27441 had some work done to enable data memory
updates in commit 05045379b274 ("power: supply: bq27xxx: Enable data
memory update for certain chips"), but it seems like it was never
tested on the hardware, and the code has been in #if 0 .. #endif's
ever since.

It has been around 9 years since this dead code was added. Let's drop
it to give a cleaner driver, as no one has apparently needed the code.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 36 ++--------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 09272249b4f7..0238ed754e94 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -922,20 +922,11 @@ enum bq27xxx_dm_reg_id {
 
 #define bq27000_dm_regs NULL
 #define bq27010_dm_regs NULL
+#define bq27500_dm_regs NULL
 #define bq2750x_dm_regs NULL
 #define bq2751x_dm_regs NULL
 #define bq2752x_dm_regs NULL
 
-#if 0 /* not yet tested */
-static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
-	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
-	[BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
-	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
-};
-#else
-#define bq27500_dm_regs NULL
-#endif
-
 /* todo create data memory definitions from datasheets and test on chips */
 #define bq27510g1_dm_regs NULL
 #define bq27510g2_dm_regs NULL
@@ -949,19 +940,10 @@ static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
 #define bq27531_dm_regs NULL
 #define bq27541_dm_regs NULL
 #define bq27542_dm_regs NULL
+#define bq27545_dm_regs NULL
 #define bq27546_dm_regs NULL
 #define bq27742_dm_regs NULL
 
-#if 0 /* not yet tested */
-static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
-	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
-	[BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
-	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
-};
-#else
-#define bq27545_dm_regs NULL
-#endif
-
 static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0, 32767 },
 	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
@@ -986,22 +968,8 @@ static struct bq27xxx_dm_reg bq27426_dm_regs[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 10, 2, 2500,  3700 },
 };
 
-#if 0 /* not yet tested */
-#define bq27441_dm_regs bq27421_dm_regs
-#else
 #define bq27441_dm_regs NULL
-#endif
-
-#if 0 /* not yet tested */
-static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
-	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
-	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
-	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
-};
-#else
 #define bq27621_dm_regs NULL
-#endif
-
 #define bq27z561_dm_regs NULL
 #define bq27z746_dm_regs NULL
 #define bq28z610_dm_regs NULL

---
base-commit: f0f400459bf6a037e70768de623fff3f8920b8bb
change-id: 20261026-bq27xxx-cleanup-2970cb8ab981

Best regards,
--  
Henrik Grimler <henrik.grimler@axis.com>

