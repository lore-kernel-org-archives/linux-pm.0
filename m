Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608636;
	b=B19vt6SCJnE5XopfCSVag4/kdALc6cTK6S084r12sSucK761McxPSWmattKxdKardMZj
	 +xIBXoVZiX0Oc/ezd0ifUzw9BbWMCyozP+Kzn8W7CA/QB3c5ZJaM3xuQ/BmpTMjzwtmRt
	 fqawG0qkKJO6rU+wIAHW8T6H+Q09p+mPPpkSfQ+FtHJ4cbaZcjfyBW1ZkENSEm/MFjvdN
	 0EqIclIRaiHi/lY/ZAIZuYpMQ6t0Yi4FQqjMcdYZPMSDGb87hNtjdz3uHQ8RL3bgHsSzq
	 cFsU4r+lxSl7FMz8q2k3DekTOZ3817Oa+rZhupSTsHDrJXtK/5AEe1RWxHubLra8s/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608636;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=q5+9ChIdKx8Au9fqttZifyIR4dVkSOON4tDmDlSBxaI=;
	b=pTDiYBzA7jrgXznNrmkV9GqxD2j6n+pQzUlOafnNpndxbtAnSZkWarar7EcIo/ScdXM1
	 mO3sU6WrgMKXyIuYtwAoK6ZenCdkoGD9DsVkkTwaS2lRR+u3q+a1xAJvjCNG+AUArePZp
	 jGNKRnucgDG2Gz3BSfOv5jV8Rqt2audeTPlw8Qyz2F8AJzl7KfDBEAY12VmNa8SIJcvV7
	 rVpZhRiYI73bBF2YI/nACsaW7VcaGjouUotjXYBjbvtwpnnkVODeS1orvSef4+xe9TfZD
	 cHsYo5+nwR6Vc33rx8yegfjmC93p44TiHLknzu/U0hh/FJYTL07MiVxAsLhPHC0thPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Tr7qj6+i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.56
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C59606A336
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C59606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Tr7qj6+i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEl9PI7OlIltPu/nFcne/7AX8ls6VpYGSznQetXHpFTJq4Fdxrm+9N0etFqNBpvpw6DIw8YJTE8h5rsORbUvWoUTl7t/PsUFHx7UFWzwX0BX8Rg1CBJXwSJgPVhaRcWs5FJGT2HP7h3zapgzoL0x3nQj8tbiW38fe2ScwQpdhbj7PZpWHjbaHfIbuxkZf9omwc1h3Kq/d+kMFl9imD96s2r27DXWSIaNve2nVqWHfhn5B5xWjIQb/WHrJ5zRhO5Y1bCQntzISwBjMnY/iVbn0aKEq4KEMWhli8YV7v0+86Npfy9YuS9nKmQChHm5A2cbGEmdFMy2voi4HBZ+3Nuqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5+9ChIdKx8Au9fqttZifyIR4dVkSOON4tDmDlSBxaI=;
 b=DT/dXpqchgG+kR3qtHkoVzJZ8H31Rhk35jBBOgt3bctEUnPVi2zr+8XD3rhAQJerKt2FEx+B5AaQcetdh1Yolictm/SmB1dWEq/KbCXd40wX3al9O5GmMF/pLqm3aM+qS3NaZ8UvWVKlZiuwyF+LvWbb9pzsCBmqlVv36IO4f1MHEO1AWC2B4cyxiagrNiFM1hj6ZZuqbeHuVOdO/x4PrFgPw+X46VAV4fzkz1L4QSSZE61fiP99lSc73/wJdvIyON6gRDuT44/0Koq3Q+S/q53BhNDPJnE2JO/BTZQjQ7QXlWAMC1TQ0zxmRTozjd98UlBCP9evq6PNCNDhVtbJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5+9ChIdKx8Au9fqttZifyIR4dVkSOON4tDmDlSBxaI=;
 b=Tr7qj6+iQ1uAykglYmJD1ga3+ECUKrCkWYuZVOkM/T65l/iS41xLDxZF2IoVd6qsC2uAwrwH451Cq/UESlxcLFIur/zL45KFKPrrDIdaGH/enWMHnt9FzCmCCX3THrdGPSFv5F2EQDL0Saq50899O+0TvtJFbj/JIm4RL1uU0T4LZK/jcC+JgvVn8N2kuRm/vHvOrN4BbPK6Rf9u/UPP3zuwaoIXVPsA0tdRsc5Jf5ldRDHhrSt6UpJh+EYZwl7fjX7Im7djn0gCy3nKgiwBp2fMvMV2iaoM7XbXJn83+JeKFPfGZOMPG3SbvEJjaSswF1T68J85Q4dNHsWIa1LpGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR0PR04MB904472.eurprd04.prod.outlook.com (2603:10a6:2c8:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 12:10:32 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:10:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
Date: Wed, 25 Nov 2026 20:07:33 +0800
Message-ID: <20261125120733.29433-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261122205136.138173-3-dario.binacchi@amarulasolutions.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR0PR04MB904472:EE_
X-MS-Office365-Filtering-Correlation-Id: b683a596-ef31-4882-8952-08df4aed1a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|22082099003|18002099003|261026121527099003|56012099006|261028144727099003|261022105027099003|10067099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VbP4L86JwqTcdH+/r+ptptezIQjjTNONe2hjSceQFuAOT5avn1fYehrpD1lRzijZcYlxpIqdDPlD4/J0DC7l1ZVF0NmiO7Vj/F3H3GKaPV1Ho26s6DtYpolla39udNWAIyHr0iiWmdbVwsEW3SWBxRWjbBZanubdy/FJA0znvaxnsmVu+NBDIOMLSeD6aj5on0zQursQBSGtj0EIOb26piBwc8LUHj9jGV6RZbzNkj0+0deAVrJO9SrupHzYqBFdcy5vFGiAp3u+9MXQnt+EpzrkN9REmD5Ha+SHUjXbCvSwYsI1JVqFXkaH8JjzAgOwbFTd/B7k+b7X5sDlDaQRnB4EfPaedzqbdCJcDH//HMZUmN/WMpziYS2NUOELiGteD3t3EWPtl5Zu3EJA8I7lJeePS41TXb3NA9lJsQBT9JEBf9Wi7SziLkbuCMOgw3AjHma5tY243L4C/Ytf9OA3fT6IHlI8oOfoK0hNqt31jCDoAaSMKOedVf2GpI22OjM35PgJXBSj5C2ATSyX/eYhqH/FMVCxB4XF02ymwddDDUd7DL79FKEDuX1HoMWgewa95CQoiL16v99wohNh5f2hI6rjUQ4XARFm/g/pDQodqiigqTwJTEFpQmqf98t01bYDhxNirkVwprDP28j2ylWoSLX2w6DZF8mCgsmAst5Pifs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(22082099003)(18002099003)(261026121527099003)(56012099006)(261028144727099003)(261022105027099003)(10067099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMN84BbruXBSXAGR+mYrDJOUMOgME1uJGmnU04zRJ2vJ6mx5YhhJDrCAVqkF?=
 =?us-ascii?Q?7ohnBE9bpPnJ8HuUjZ541/GIGFy44NMwdpf+paUvP7F0AKhrf8K5f1SigcDQ?=
 =?us-ascii?Q?Rp5Wy01xRiGofevmvGB6XkemhsCAOiHcGzQQina+BBkCkfz6lWIjlmbOvTeg?=
 =?us-ascii?Q?bUh2bWltZDndaYKg+kdAxkZ8hwqkm9q2MHy7fpZq/V13IVPcfpXthwcSv5WR?=
 =?us-ascii?Q?kXwfhAT5ubbRmJLXVLzIfmHVgyJhsb0YfKhhcfpB02kWCOegL/7JA/YtlsYr?=
 =?us-ascii?Q?ZPR8OXgNkwG7/Ry9tI13wZUjCwy4+FrvQMi3UXd1NgscT6ekulfDARi4GagI?=
 =?us-ascii?Q?Ckyh2j6p3OuY7xCVJttDFa27eE+B9RQlmgS6xAsU/Tz0eyPrJIk4uHjLdL5K?=
 =?us-ascii?Q?GhunwLTL2djTZ9YXYm6eD2hqVZBkkUy8S/c/ng8XlXOJxxtErCbN8d7wISB2?=
 =?us-ascii?Q?ClvNCTL8h0t+L1hBlrnxjE/fLx4qbsUl73KCvcmJQKBjAh8QNGhSq8gQPncJ?=
 =?us-ascii?Q?rpkg93mzcKl29OwCKiytKDSynXzM7h0rRwMOtX1edJiF4yEE9mr1/GMjZEbH?=
 =?us-ascii?Q?T7yz71Vgqk1zFz6fNMHr4j39PRmDRXFRfy6j1yxwUbujo58F795pPDLHdHZ5?=
 =?us-ascii?Q?krQpbSx3Ri/I2yQZwDdrE4z0jcrBEioRWCjdG+urYRZx4Edv7JtRS1UuIqqU?=
 =?us-ascii?Q?wAUJq2uPGLWaxNvOYOSNxVd8IbVQgR7FcvfuQV0XuM+uB82JbX9THzQSGtAd?=
 =?us-ascii?Q?C1t1JIuK74677X0MuLLnBLZb2enYngI2P2efEnraLSrTyvbTSbGO9RgE755+?=
 =?us-ascii?Q?BLcOA+FprSiT2u+aEgPdjqzRnqEJiOTznUp6Opbgq8C4O1YnKP1HFSSncj5d?=
 =?us-ascii?Q?oOgvu8HlJhRvjXe962UKqtpD/D8aKp6r83fIrSegndCWHEgbvbE4+oGgLAcp?=
 =?us-ascii?Q?1A8P4UsfcHGYfqICbj8XKgmhl8cxVoIA4qzv+BBUDgtVTdnlfKA+MoKYXAuj?=
 =?us-ascii?Q?O78MaXmOHbLtWrFnCwWrRMayq27g8VD0PgDAhVpNKw5qxizy8M7auhmegI/g?=
 =?us-ascii?Q?i3DILFeAGBotiszQDJSHUT9Bdvh4TEaWa8lPcF6HmtULIUPgW58bmZebAQCA?=
 =?us-ascii?Q?scvWj8V4wIbvl1zzedHoNIa8FU/AjxSHIJl7cfnxdJ/ybsjE9tq4nQImj+ap?=
 =?us-ascii?Q?J4Ju2BKEyIqn8Tt4O7vxShnCqoARFPodsXbQnYJ21E2x3rQ2iZTp069bfc9e?=
 =?us-ascii?Q?jZz0ybrKLojLNoxkMW+oWkKD2KyEVFtSre9vIbkNpplOEmE6qkWbzrJMb5la?=
 =?us-ascii?Q?A+R5eApxAKaF/IzUQEr4RU30VLAq8DcGzqb64is7sbnU8JPL0WEW+hNGjm/e?=
 =?us-ascii?Q?wlXR5v/hMiM07qBpj+5HJLpZu+/0NrKi+Ztl3EfH6I3J1LLdUsnj2jKx1ZZe?=
 =?us-ascii?Q?oSw9aseDuWais49FWEqykRYJghYrG3cVydZ98964kyZhuqoQpmvbrQuJf4MN?=
 =?us-ascii?Q?fv0h+BRbtQCO6f/oj4AKcgmcweWItuZ1F0jEl/6pxholnPkFERmFaPk60Ylf?=
 =?us-ascii?Q?QN1SrZOPEtVkV1x5H/7bbbGQ+WMHFcWN1YLT6IDgnGggdoehudgV+KnCO4lG?=
 =?us-ascii?Q?1gkYO/S8yr7aCprHNKeN3T9DGR5/Z3NJayE5ofXo0gjyu1gN4fo5RE9sUTDQ?=
 =?us-ascii?Q?4YHb23XsU6fqbGuACWsoY62F98AqwikMXs0I1xYR1GFIUcFjs71FHC403Yjt?=
 =?us-ascii?Q?BHgrcy65rH27kvvKHQcaQYkPBkTFmu+twDqN371mrEuFeAK/3O2W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b683a596-ef31-4882-8952-08df4aed1a17
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:10:32.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJSF6fqTB2SJ2bzhe5jg8lvXHpAy85HjTNACHcD6TM1AfAyV0SEzjvt8k7ja9GgKgQnKHg+0GK4ujpOCiRfbCVIiJ3518Y1vOUZDFw8JuCG6s5U2L/1RDQ9Pqf82LXjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB904472

On Sun, 22 Nov 2026 21:51:11 +0100 Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> The PGC domains are all registered as off, so a domain left on by the
> bootloader, e.g. DISPMIX to show a splash screen, is powered up again
> by its first consumer. On the i.MX8MN this turns the display off and
> hangs the system.
> 
> The GPC does not report the power state of a domain, but the ADB400
> bridge acknowledges the power-up handshake only while the domain is
> powered. Use it to register as on the domains left on by the
> bootloader.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
