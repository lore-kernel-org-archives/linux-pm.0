Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793598402;
	b=1GFBM0FNWTNk/Ej95qpdCQ50YdCR8AOLWhq0kXY1bw803uOiJ5qMcrvdnqpudD5z5zhz
	 E2kBpnMt6WhWJ5GCEeGnm9CgnpoACroVmb1x+m1aICLc2T7qd8vpRhPZLw/51u/HAZEBb
	 OqMdXmnV2MyqK9t2SCaOO1zHyVMqmiqpEybw7MGyk99Mhh1dMjfVBvxXJOfQvG8DHsShl
	 0TFd2Z18A606mzgZk6YKtpHqgrh2AjVcNqpmp5ijAFz9aDsdJARjfzRO+UhpjX1YWP+ct
	 FNVVjaKGnsVq3vPNGKtmWPu4BKILp8jr9iJSANTQXnAzTAF1e2nIldaVHIeSI3XT+7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598402;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=wuRbOs3XqpP0lp7sUetuLOcFRLOUYYFLyEsp95wldxU=;
	b=uJG+uVxNzz+m//l8PB/R0+mkcjI6lkDthyeaD44qrc4EjgEzQJ1ChAx1UL3X4m5VU9xy
	 Sc5pXpj70Zs2MH9xinBEFA6FeTOFtnI5oIousQU9E+E4rwuEwy/xuU0EtPrr2EVSgZtVs
	 mRezGd00morbVjEi5vGn9GXXj2XI2ZPWFOf63wQbHEoHFhCV5mzNbVrmdh+V41k1BtLaX
	 UNqaUZ9ecXVeaAc2cRLw68wBDSvBiDkIQlMJJHUyeoDXFRhWn8zb4idhQ2r7NKSdr3OUc
	 tbqQLbw/mMk8FdGhUbLB9Cms5D6pa6coK0eZKNh7B3BcfVUJEh+iVCFHpdMLq2DzJIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e36IkOyo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD50606A324;
	Mon,  2 Nov 2026 05:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD50606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e36IkOyo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYl2rHQSyGygaP980R9M3SXfyGkCwmO0/kx1p48r4tUPmMi7+wnWSe7AbjcDjx9yuFErQd1aMq1fbaIx7cJpui1nO9paye4PWEV8PZ6L16CtZeJRU2InzE1XmaQ5kNtOFyq/ziS96hFdkSY65kbtVIEIUMAWVZ585gvmAULyHwoGiIe+42wqN21bEYdtl6uzcJWQHRntCB3t9MzTa7ZcMzE+gI3Ust3JgPigtazvJeYiAasJ3ZkQ9xWmcMx+wesyIpQyiaGzUiDF+cMsg1XLjWtPuG3kAfAvD7fUZGKe/Sptyt2fGvjhM3L2mas6QU78/r/r+7k5KkZGXHnYqqDG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuRbOs3XqpP0lp7sUetuLOcFRLOUYYFLyEsp95wldxU=;
 b=FaKyXtWwWzOoJyhDjyV9Q/KDKGP8L5hcHR63a4rlKWGs/m5d2yP5MspoQ2O6tenHskqUW1qWdbJJz3kxnnbOAnjh/DpDqFZEMRC4aGSK5cDdgQust/m5puYoS77zN0yF0IzNLJIrNXB+wA6XzlV/6I8ymtw3dby70PodWCIpS+4GVmbDfm2ApdZB4oPIW9u4Z5N3riw8mmN+NrByIJmrNskW1U+SsQuAB/H/n7oCh3lEkEh5kvscrEt3WAVgEDOvCIsrxbs+5PXKSgViClbJQleplVcqSSW7rjvEc3wrpOxNCW8YlC93p/hKjdu8OEkaDaAtEWrRta9aCIODgzyqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuRbOs3XqpP0lp7sUetuLOcFRLOUYYFLyEsp95wldxU=;
 b=e36IkOyoV8aOyye5ZwvdvPS1PU6f3OotwWG6gov+9bM9gjEw1a21l3f6un06W7+zJU9SaxVsqB01zW3B6+yhP/eHX7mrpWFfQjWN04bEDL5jS0LVilVb4eQFuQD/+g8RTuEMcuwa1fsHrQl7sjXLjgztIp+FPXETmpbiMuarrJc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:46:37 +0000
Received: from CY8PR12MB7516.namprd12.prod.outlook.com
 ([fe80::b6cb:7a8c:fe0f:b9cd]) by CY8PR12MB7516.namprd12.prod.outlook.com
 ([fe80::b6cb:7a8c:fe0f:b9cd%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:46:37 +0000
Message-ID: <2706dd89-27c6-4225-9476-344fcb146620@amd.com>
Date: Mon, 2 Nov 2026 11:16:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dmaengine: zynqmp_dma: Use PM guard for probe-time
 runtime PM reference
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Michal Simek <michal.simek@amd.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Harini Katakam <harini.katakam@amd.com>,
 Shyam Pandey <radhey.shyam.pandey@amd.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, git@amd.com
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-1-55f5fe409c55@amd.com>
 <asmsVD1RP6FoMN9l@SMW015318> <212a4fc4-437a-409a-821e-86b9b8c7f85c@amd.com>
 <atoxRAVvHx1Ng2GB@SMW015318>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <atoxRAVvHx1Ng2GB@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0146.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::6) To CY8PR12MB7516.namprd12.prod.outlook.com
 (2603:10b6:930:94::9)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB7516:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0892dfe1-00ea-47f8-9ad4-08df38a4a954
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	J1tuJLIRLRpibHhzYn+AcvD1v2uxdhlw1V9gFL3qiAfXrT0ZliAd/0duxmqHuZmeXArfrr0JkxkzwgRvJSKbqV7IJslSpgsVT7hRsTsAehJIhDHDkmftOpDs2Sld8UyGop8Y7bHm240yj0ARmX8FwlUeKJCLNUCmAd40Uef0T+ifaThw/M8YApD0lddMWFMJXBfG18UWZM+uh9ZlAKQg8Eg9yNx4DHCQMj2Du1tJLC++xFqqxRZwvD8j+KdCavoK3ktUKx++CbIpCYyM+yh+TRp7J4+dK4AwAm5uRzV2qiWhS4hE834sJCCyh+gpTUf/IdNULiybwRuD+lLQ4NMseW6ExTK/qXby6WSv5i9rVoIqe3QfaRnVFD3a5syvqdaMrZGM/gIcos+LC8lDjYXDZDEqMhiT1vGzEq0FnadAgqTMNDw6P8IVwZ0RaSn3ZdvkCJuZA+d5xgXHkgaDXPPdmSuxCRY8gWbk0wDVwQkFST6qfGHK78CddCWXiXv0cwEWlRkwVUq74LzRkZa4SLR9nbiTXNpOeNRYqW8zBqDuZbbWcm71xkKN/R9bW1kxyUvbVz347+045KdShRRdhWGPM42GPJyvtHLlqJrGpFhjucdAaIeTLlTCHpLkSxn5zy34
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExvejdCV2ozZkxLUFNUaHZlWVM5VWlBSnQyanJ2YjA2UUE1c0ExTE9HVlVm?=
 =?utf-8?B?QStQTmVoSHpsZlg2enJEbEpGb09oeUhZbzRKN3hsSUlnbFJpU0RBQXpOTmZW?=
 =?utf-8?B?d09oRmNibGhPaTVYWVVhclBrV2k5ZzJqS3FsVGVPT24wSUczWmxrV1BIcnor?=
 =?utf-8?B?SHZIaDFHRkc4ZkFham1zRjVBeEkvQzdUZjNQWjlFSGFwTUl6M1BWMnB5OHFp?=
 =?utf-8?B?R2JqeEp0S3dSbko5QmNMSnV6eUhoR3hveXlHUW5NNDdRNFZoL3AxNGpmekt5?=
 =?utf-8?B?SVdwMkkybjBxalExYUtTNzcwSTg5SzdxbU5FeVd4d3FHeVh6MWJXbXlob0pR?=
 =?utf-8?B?d1BPampKMkJnMVVBQTlYK1ZnM3FpZkI1NHFCa0NoeXZYQzV6b24vR216TFB0?=
 =?utf-8?B?dGhxUmJ5UE9yTEt1bFZuYy9CTzRFSzczOEhCMzR3TzZTczJDNzRDM1JCc2xF?=
 =?utf-8?B?SG42MWNrU1BpYXRIcEhpQnNOK3pTR0pEMXMvQ0tldjdZbWNWVGVEalg0T0VQ?=
 =?utf-8?B?RmZmWG8yajRVRnMxcitpMUxhRFUyQkJjS21JKzhJZUJjaUx5bDlCM2JLQ2dm?=
 =?utf-8?B?ZmZMVXlreTlVSmJaQUFES3lmZ1IrSWVKL1ptNllPbldtYnoyKzRZZ0RHcFNX?=
 =?utf-8?B?YTZpVlhiaHZ5Ukp0aFZIeXpMSjRYUzE2ZlIvSzllOCt2YURTWnQra0RyMGJx?=
 =?utf-8?B?akwvZ2ZXQ3FqNlo3RGZkM3JGbnMxWmw3bHM5Q3NiV2VXRzFoTUNtMllPakFa?=
 =?utf-8?B?RWlFeVVjNEx1RTArWUZ0c2JLa29vbVlLeVhPbFBZV004N1hyMUZ4V044N1NC?=
 =?utf-8?B?Q3lBNkJ1UEpJTTZxY1N5b05oK0dCNUJNend0SFFLY1JpOThkSFZPd3k0TW01?=
 =?utf-8?B?Q3JFMmZITUVWa2ZJZ1BQOG01cGpOMTAwcUNmNFBRZEFwU0x0eldrU0trd2dv?=
 =?utf-8?B?dkFhai81YllzdUQ1UFRIeXk2c0hhUW5iUVhDamJNRFl6K2Z1amwwb25BR3F0?=
 =?utf-8?B?bUxBd29INU80V1VNRnIyQlZqVzY1SWkzdE01WEh6U0luYmJmMHJTTWJoc21M?=
 =?utf-8?B?ZmMrUGVQb0UzT1pyM3ZRS3hYa3JoMS8rL3VPUXhHcjgwRXRVLysycEZWdGtz?=
 =?utf-8?B?aXlkbnUzZnlESGxCcUdxT05HMW5nbnNaZXQ2dmJuanBocmN2OXpZMkQ0ZDFw?=
 =?utf-8?B?VlQ1b2c3aDhLR0F5dWppL3JPblNjcmpHeitFaTdvb1hUTVBpa1hhUFZvZk90?=
 =?utf-8?B?VnAxZy9HdWcwNEVsSHk3R0diTm1OcWtwS1h6SExTcWx4U3ZvWllIZWZyZ2lz?=
 =?utf-8?B?ZXBqRFpnUVpsRVlwd3lBUkFTVG9QVjhXSlN6dVNXLzhrRDdDSXVIS2lBM2Jy?=
 =?utf-8?B?b3F5ZDZtekVPaW42cURRYjNmcVp5WVZ1Q243aWdNOHNvb2dlVnpRbjdvN29a?=
 =?utf-8?B?WjlQYVZTQWpidUJCcktIU2l0R2oxSFBwUXlhY0k3Y2NxRkZrTHQ1QjM0UEtC?=
 =?utf-8?B?ZGVSWHlqRkMzUEt4TWI5SmtGTGlNcEtHNW9va0xSMDZ4ODBXZ2ZGeXBWNWEw?=
 =?utf-8?B?cWd1U0VyQnBFWkJGZmRaUXdKaVdLZFdkSEFrZVRuRjZuZ0l0QXEvdGphczdj?=
 =?utf-8?B?ZlN5bTN3MVBOdlVKUDRUYmdsVmcxRlN0WVg2bW5TS2dEdm1sYTRmRVI0cWNh?=
 =?utf-8?B?MExBdkNhRitCYVJlWlJzM3ZCdnlHSDBmYnFFcUd2aVI0NFVYZFZLTUNLTzRM?=
 =?utf-8?B?WlJrdVhUdnNnd3RkeUJKN2dlb3hUKzdIMkdrcCtaTWswMmNCLzVUNXcxSUFl?=
 =?utf-8?B?a0toV3hESDBCOGNodXdHd2VvUFd3d3RRUWZrcTJWUEFLNG9laFpPeUxlSVhB?=
 =?utf-8?B?QkJUZ0wycWdabGc0UzhqbVNDeXNvdHpUWFV4T2s1c0gwV0JjTkppdnJHZ2VI?=
 =?utf-8?B?N2Jvbmh6QVphZnJucnJ1Um15NEg4STNRdVFzRUJjaGl3azZmTWRyVmhXelQ5?=
 =?utf-8?B?YklnZTRqMnBFS2lBWWc2VDZXZ1BURmlScEt0WmNrUDJBT0tubU9jL2dTVG9S?=
 =?utf-8?B?Z0NSV2xMcUtJa2ZjYmNNSHlZS2k4Z2ovZGl3RUpXY3VTVlN1SlRVUW9tOG1R?=
 =?utf-8?B?MkFvRWNnQzIvditLQ2FSL3E5eTBFV2c5WEJLS09xQzdWaDZzN253bWl4dlkv?=
 =?utf-8?B?NllsdnZ5QnBOaGZER2NpaWJKRnE3N29zVzRxazM0Yy8xMS9mZSszR3h2ZU1R?=
 =?utf-8?B?azdhUEZUVjNScnQ2N0poQ3BubFQzZVA5N1huM055MjNoNzE0YzRJcFl6dGQ4?=
 =?utf-8?B?VUY0aEM4ZEhtMjlwK0RtMUJhMVN2K0ZLaDNmTEVQQTZsdEJGWnlJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0892dfe1-00ea-47f8-9ad4-08df38a4a954
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:46:37.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cldKaJp17I+uYkL/5+dMif6ceyMzm8enTqwQACxreckHUQvF0L5e5a1LG/SRkdOs5wppHZXbhVf5SBuUS/99kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

Hi Frank,

On 10/22/2026 9:22 PM, Frank Li wrote:
> On Thu, Oct 22, 2026 at 10:40:53AM +0530, Golla, Nagendra wrote:
>> Hi Frank,
>>
>> On 10/10/2026 8:39 AM, Frank Li wrote:
>>> On Fri, Oct 09, 2026 at 09:30:10AM +0530, Golla Nagendra wrote:
>>>> Replace pm_runtime_resume_and_get() with the PM_RUNTIME_ACQUIRE_AUTOSUSPEND
>>>> guard to manage the probe-time runtime PM reference lifecycle. If the guard
>>>> acquire fails, fail probe immediately so a broken device is never
>>>> registered.
>>>>
>>>> When runtime PM is not enabled for the device, call
>>>> zynqmp_dma_runtime_resume() directly after pm_runtime_enable() to bring the
>>>> clocks up for probe.
>>>>
>>>> On probe failure after a successful guard acquire, drop the reference with
>>>> zynqmp_dma_probe_pm_put(), inhibit the guard destructor with
>>>> retain_and_null_ptr(), and gate the clocks through
>>>> zynqmp_dma_probe_fail(). When runtime PM is enabled,
>>>> zynqmp_dma_probe_pm_put() uses pm_runtime_put_sync_suspend(). When runtime
>>>> PM is not enabled for the device, balance the guard usage counter with
>>>> pm_runtime_put_noidle() and gate the clocks with
>>>> zynqmp_dma_runtime_suspend(). Runtime PM does not suspend a device that
>>>> is already disabled, so pair every direct zynqmp_dma_runtime_suspend()
>>>> call with pm_runtime_set_suspended() to keep the runtime PM status in
>>>> sync with the clocks.
>>>>
>>>> On probe success, release the probe-time reference with
>>>> pm_runtime_put_sync_autosuspend() when runtime PM is enabled for the
>>>> device. When runtime PM is not enabled for the device, balance the guard
>>>> usage counter with pm_runtime_put_noidle() only and leave the clocks
>>>> enabled so that later channel allocation can use the hardware. Inhibit the
>>>> guard destructor with retain_and_null_ptr(pm).
>>>>
>>>> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
>>>> ---
>>>>    drivers/dma/xilinx/zynqmp_dma.c | 68 ++++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 50 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
>>>> index 3b7dfa53f972..a48106e404e7 100644
>>>> --- a/drivers/dma/xilinx/zynqmp_dma.c
>>>> +++ b/drivers/dma/xilinx/zynqmp_dma.c
>>>> @@ -18,6 +18,7 @@
>>>>    #include <linux/slab.h>
>>>>    #include <linux/clk.h>
>>>>    #include <linux/io-64-nonatomic-lo-hi.h>
>>>> +#include <linux/cleanup.h>
>>>>    #include <linux/pm_runtime.h>
>>>>
>>>>    #include "../dmaengine.h"
>>>> @@ -1077,6 +1078,29 @@ static const struct dev_pm_ops zynqmp_dma_dev_pm_ops = {
>>>>    			   zynqmp_dma_runtime_resume, NULL)
>>>>    };
>>>>
>>>> +static void zynqmp_dma_probe_pm_put(struct device *dev)
>>>> +{
>>>> +	if (pm_runtime_enabled(dev))
>>>> +		pm_runtime_put_sync_suspend(dev);
>>>> +	else
>>>> +		pm_runtime_put_noidle(dev);
>>>> +}
>>>> +
>>>> +static int zynqmp_dma_probe_fail(struct zynqmp_dma_device *zdev, int ret)
>>>> +{
>>>> +	bool rpm_disabled = !pm_runtime_enabled(zdev->dev);
>>>> +
>>>> +	zynqmp_dma_chan_remove(zdev->chan);
>>>> +	zynqmp_dma_probe_pm_put(zdev->dev);
>>>> +	pm_runtime_disable(zdev->dev);
>>>> +	if (rpm_disabled || !pm_runtime_status_suspended(zdev->dev)) {
>>>> +		zynqmp_dma_runtime_suspend(zdev->dev);
>>>> +		pm_runtime_set_suspended(zdev->dev);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>    /**
>>>>     * zynqmp_dma_probe - Driver probe function
>>>>     * @pdev: Pointer to the platform_device structure
>>>> @@ -1087,7 +1111,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>>>    {
>>>>    	struct zynqmp_dma_device *zdev;
>>>>    	struct dma_device *p;
>>>> -	int ret;
>>>> +	int ret, pm_err;
>>>>
>>>>    	zdev = devm_kzalloc(&pdev->dev, sizeof(*zdev), GFP_KERNEL);
>>>>    	if (!zdev)
>>>> @@ -1128,21 +1152,30 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>>>    	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
>>>>    	pm_runtime_use_autosuspend(zdev->dev);
>>>>    	pm_runtime_enable(zdev->dev);
>>>> -	ret = pm_runtime_resume_and_get(zdev->dev);
>>>> -	if (ret < 0) {
>>>> -		dev_err(&pdev->dev, "device wakeup failed.\n");
>>>> -		pm_runtime_disable(zdev->dev);
>>>> -	}
>>>>    	if (!pm_runtime_enabled(zdev->dev)) {
>>>>    		ret = zynqmp_dma_runtime_resume(zdev->dev);
>>>> -		if (ret)
>>>> +		if (ret) {
>>>> +			pm_runtime_disable(zdev->dev);
>>>>    			return ret;
>>>> +		}
>>>> +	}
>>>> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(zdev->dev, pm);
>>>> +	pm_err = PM_RUNTIME_ACQUIRE_ERR(&pm);
>>>> +	if (pm_err) {
>>>> +		retain_and_null_ptr(pm);
>>>
>>> Not sure why need call retain_and_null_ptr() here, generally only need
>>> call retain_and_null_ptr() at success pass if you use want to keep
>>> runtime_pm active. at fail case, needn't do that.
>>>
>>>> +		pm_runtime_disable(zdev->dev);
>>>
>> Thanks for the Review> If use devm_pm_runtime_enable(), needn't this one.
>>
>> We intentionally keep the nondevmpm_runtime_enable()pm_runtime_disable()
>> pair here and do not switch to devm_pm_runtime_enable().
>> devm_pm_runtime_enable() registers a devm action that calls
>> pm_runtime_disable() automatically after .remove returns. Since remove()
>> already calls pm_runtime_disable() explicitly itself, switching to the devm
>> variant would mean pm_runtime_disable() gets called a second time for the
>> same device
>> — driving disable_depth into underflow, along with any other
>> invalid state that comes from disabling an already-disabled runtime PM.
>>
>> If we remove the explicit pm_runtime_disable() from remove() to avoid that
>> double-disable call, it would affect the fix introduced in commit
>> 9c58a42c1612 ("dmaengine: zynqmp_dma: fix race between runtime PM and device
>> removal"),
>> https://lore.kernel.org/all/20260630064844.705173-2-nagendra.golla@amd.com/
>> which added that explicit disable specifically to close a race between
>> runtime PM and device removal.
> 
> "[Severity: High]
> This isn't a bug introduced by this patch, but does zynqmp_dma_remove() need
> to halt the DMA hardware before disabling clocks?
> 
> The function disables device clocks via zynqmp_dma_runtime_suspend() but never
> writes to the hardware to halt active transfers or waits for idle.
> 
> Could stopping clocks while an AXI master is mid-transaction violate the bus
> protocol and cause an interconnect hang?"
> 
> Is this one?

Apologies for the delayed response.
> 
> Frank
No, the commit I mentioned does not refer to this issue. This patch 
resolve the race with respect to runtime PM in the remove function . The 
old code first checks whether the device is runtime active, and based on 
that it decides whether to manually suspend the device. But during the 
small gap between that check and the manual suspend call, runtime PM is 
still enabled, so a runtime PM transition can occur in parallel. In that 
window, the PM core may call the driver runtime suspend callback itself. 
Then the remove path also calls the same suspend callback based on the 
earlier active-state check, so the device may be suspended twice.

this is why pm_runtime_disable() is moved before the suspend decision. 
because it closes the race window by  blocking further runtime PM 
transitions and stabilizing the device state.

this was the potential condition reported by the internal AI review

The issue you pointed out regarding an ongoing DMA transfer during 
removal is separate and needs further investigation. The commit I 
mentioned does not address stopping an active transfer or waiting for 
the hardware to become idle before disabling the clocks.

Thanks,
Nagendra
> 
>> Dropping it would reopen that same race.
>>
>> Thanks,
>> Nagendra
>>
>>>
>>>> +		if (!pm_runtime_status_suspended(zdev->dev)) {
>>>> +			zynqmp_dma_runtime_suspend(zdev->dev);
>>>> +			pm_runtime_set_suspended(zdev->dev);
>>>> +		}
>>>> +		return dev_err_probe(&pdev->dev, pm_err, "device wakeup failed\n");
>>>>    	}
>>>>
>>>>    	ret = zynqmp_dma_chan_probe(zdev, pdev);
>>>>    	if (ret) {
>>>>    		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
>>>> -		goto free_chan_resources;
>>>> +		retain_and_null_ptr(pm);
>>>> +		return zynqmp_dma_probe_fail(zdev, ret);
>>>>    	}
>>>>
>>>>    	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
>>>> @@ -1151,7 +1184,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>>>    	ret = dma_async_device_register(&zdev->common);
>>>>    	if (ret) {
>>>>    		dev_err(zdev->dev, "failed to register the dma device\n");
>>>> -		goto free_chan_resources;
>>>> +		retain_and_null_ptr(pm);
>>>> +		return zynqmp_dma_probe_fail(zdev, ret);
>>>>    	}
>>>>
>>>>    	ret = of_dma_controller_register(pdev->dev.of_node,
>>>> @@ -1159,19 +1193,17 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>>>    	if (ret) {
>>>>    		dev_err_probe(&pdev->dev, ret, "Unable to register DMA to DT\n");
>>>>    		dma_async_device_unregister(&zdev->common);
>>>> -		goto free_chan_resources;
>>>> +		retain_and_null_ptr(pm);
>>>> +		return zynqmp_dma_probe_fail(zdev, ret);
>>>>    	}
>>>>
>>>> -	pm_runtime_put_sync_autosuspend(zdev->dev);
>>>> +	if (pm_runtime_enabled(zdev->dev))
>>>> +		pm_runtime_put_sync_autosuspend(zdev->dev);
>>>> +	else
>>>> +		pm_runtime_put_noidle(zdev->dev);
>>>> +	retain_and_null_ptr(pm);
>>>
>>> You mix use auto cleanup and pm_runtime_put_sync_autosuspen() and
>>> pm_runtime_put_noidle() to make code mess up.
>>>
>>> Frank
>>>>
>>>>    	return 0;
>>>> -
>>>> -free_chan_resources:
>>>> -	zynqmp_dma_chan_remove(zdev->chan);
>>>> -	if (!pm_runtime_enabled(zdev->dev))
>>>> -		zynqmp_dma_runtime_suspend(zdev->dev);
>>>> -	pm_runtime_disable(zdev->dev);
>>>> -	return ret;
>>>>    }
>>>>
>>>>    /**
>>>>
>>>> --
>>>> 2.43.7
>>>>
>>

