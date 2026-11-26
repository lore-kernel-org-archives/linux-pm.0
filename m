Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795737603;
	b=VUT3ETczaHTB7xyYdESoplopta/PdFTcPOy9q3vNNHQ2EhnQlleh/kCsmicD6aqKQWJu
	 kdzwFQZ0/RFRs1j81XM+LkJmLoL/x6grP9fqBdC8tbLyqqtoMQKlsvbsrVu5YfmiKYgjc
	 IIvBLCbvP22dR25TEptr/rB6qb34UNIKFLj4nSUVA5GflZx8UJzzZGpgTGtHP1QzUuX0E
	 hwxOYBUygjYHyMqPnb6v1h8T3wsJ5RLRqgQmepmZFRxQjMMRosojuMx+BD0P5Y49idPVY
	 Ja8dtBh/aa+eKNE9tzZEUzQqmK2iFZgvwX0D1RbbG4kmaPd1tijUIqpg+I6y/Hb/MVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737603;
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
	bh=DojrVhGbmbtpA+tsrmMQ62IfjxP+0O1AVJVjRmxYvI8=;
	b=1TIcwjvFJ+rDt2HfaXT197TzAf88Oo8mNraoe8lGVtlfr+dv0NQzcwLbgvz8Me0U+6vE
	 oG0iynE3djEJzXoTK1vKK8ruQ5FSlJzZucVtYb52s+D8dXX4+uMiM0eIz/QOJincHgpm5
	 3a95V1B7EzVVRvVfYfOdxyoD4JsIgqB9DCCrsz29gh741EDyd86VdKDVzp2YNUoTqeTfw
	 bil7WnDbiDijssPyiAJKbboA5vJD+HQ8fd6yjXfB7yiBzxMJfOHSTCfdyNcjUVeWb2SiU
	 V4/2ntK9HhFeIX8DuEbT7B79AzH0iH7tsr4q+MEsi5gcBDmHN0C7pDYFgU6Cky4brUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TTg9WldD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.59
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C0606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 00:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TTg9WldD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8S81SxrLSglEhzlp42a+9Kj96dKDkuISTrcB1JgXMzejDmKPRszvsvX0Do3oMtDWznpxqozEsm59wjA1xz5Uhz8e/RftBVRuzGcI64ev61v5EQpKnPCcBVRgPq3gW9Qjmuzdhl6sKP6guibJFdzkV5PwH4UqFPQhgkaQwrV3V3uW3uJWA+jQBVO9Q/mOgQ/d9pyF+cJ9H210JkFE1mESRKaVtyFKHgNitV/QNHevLMlCoVALcXp54tstGncFrHDCu4xidrrwuFGzOckfi/aKLCp6Yz/ocuGz2pAY+se31o74vJvdfmHms91KAqkQXtuamogMxQ3iTVzOLinn7GceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DojrVhGbmbtpA+tsrmMQ62IfjxP+0O1AVJVjRmxYvI8=;
 b=uILdHwJGKsmj1/gl3saBShQSMr+TQ1KAzwyCJL6DJO6Twqrmh8aDDMm1ShUXzIIJ+4P72L9IRjdjXVliFCSwPVCAuYZ/foV/8vb3Muh5K4CupxlI/gr4J4a17JDmPsC/HmWgqDx7Ohm2CMTx2FwmgyD3cYnazCzqzcPjvkDp1VJpa8L+e7Im5sLehxRgF+b1oe2B5scn7GRj3CiIjKIucbUkE0MdN245rge73HN+CrXuEJNhJZnr+cIMsOGwAg4NTyqEtRUAvecLMbL2qCd73kFKddt1CNZixtmAhiwBKpf2pUeTx+qBSiZnWmNhAtccPo6A+8bUkrZzgH82UAvpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DojrVhGbmbtpA+tsrmMQ62IfjxP+0O1AVJVjRmxYvI8=;
 b=TTg9WldDWbWxxubEPPcJWWzhObntxtjJkCt0QHo9Q0DEqX/oI4jcbgDnq/pQRmf2ehDcrhe/6y3lowAcmMBiYn6HaAbfbf/lbwLY9N4RclqsCnqGqGAoc5lfdIO7r06SEOIjILRSfp0+I4e+T8etmcOOkgjyjHihSAWiTl4p7FnYv/uV99zHeHm+n+x49GnGAg/SHKApZGhzPijMfBKv96y3r9hV09InNwk9I3l/tszqW2tPttfqYZIsrs0qZ39Z/RSKSxxx0felZZFM8r+ud2DnEizOfSR86R5FPqgf5HDQoGxk5vM6tG7VKPUTLI/E+9PlwDvT6t6PYOlcZ8u2LQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by WA4PR04MB803417.eurprd04.prod.outlook.com (2603:10a6:1d0:10b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 23:59:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 23:59:58 +0000
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
	Kees Cook <kees+treewide@kernel.org>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
Date: Fri, 27 Nov 2026 07:56:54 +0800
Message-ID: <20261126235655.92250-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261122205136.138173-4-dario.binacchi@amarulasolutions.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|WA4PR04MB803417:EE_
X-MS-Office365-Filtering-Correlation-Id: 073cea86-f0a1-4894-84e8-08df4c195fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|7416014|1800799024|18002099003|22082099003|11063799006|10067099003|261028144727099003|261022105027099003|261026140227099003|56012099006|261026121527099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	kK2prjnnuFvw/XJavtzUTd/shYuwjivBtofjZULiisntP50rIOiw9qUZ+ThG2MxK8s9sHStD+vRQdIjfOvbrXquBk2zVvLoiBKrbpKGcFLbnORAyIEEXo+Zsz3b924ujDx0CTX1udpLOUd6Rx3UMMCfUXQ8jgyOnm1q11ORJpDTZbvv6Ll0l4diWo8fKGJ8Q4k2qDfNWZpxnrtjg1GGCbm3cz5cd2DZmS4VfHXyII+qsNkBp5WpzRH+AwQseinw/cPVnz3LrNriWNo3s12an+ixzerivfVFQuiKvhElt9++xTZAa/K2SLLXOV9GgCS3wO+nURrizfKVt8Yr1Y28RLOXQlFymXcAwb9X/0XHdoi0gWYNoQnqx1J3VcVhfveVfrTXkSA/VrvOfns6crE2SabYUumI1V7K3o/lhAbZDoyEuudeZlYygmtnoUrbAHVvVi9sVWqAYqpdQozkt2xMoSY7ucDwxIjYnNd926cfctjsWjha+T+IpaLGGOeOPOP2LmhBvD8H0Z049GTVvPyaWpVd/X1BgM7jGzxylinL9F+BG8dW2MhaBE0VrFaPshJDXjsxkGJ/AsQGYMBNNv8pVWZqta8EdMnLk24g+ReiHBrdq1dS0EBXfl9RB2c58I/XkXvdupvLABv/HzmWVmYjjCX2cBpiqIdK2woiUrNbCvqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(10067099003)(261028144727099003)(261022105027099003)(261026140227099003)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzo/CZZiB55sUkgRkpmI0WRHeZJnXvAMu9abnMCcXnB63xsgw19ULY9b6K3Q?=
 =?us-ascii?Q?qaF837VeqMDS8O5TRDNl6MWR9JsWNOa5UwJx/nWLrluQhxJ7Z7aCKTd840OU?=
 =?us-ascii?Q?kxzobm+gyzBej0qE1ARLMEkkojxlbJdF/+wV3dxIP0a/OaBxHLmYbUQmU4NF?=
 =?us-ascii?Q?RSco3yARxVgJZEGG0RvmfctXMuJrikV2wlcO8YdEvdDnuZ/03vrB/y+YUuXq?=
 =?us-ascii?Q?OhVOaIxpt01e6UUIwnTiCOQ3uzr0BQpVemZ7A6XjVmccN6TT0eDTQWavGXuT?=
 =?us-ascii?Q?qD6YAJR3wjXXLeWEySzZXR+ipekWt9oinvqgZzX72MSBk3Ft6sscK2tBKDXr?=
 =?us-ascii?Q?SB1jdGzPe7hdPaDIDwK+a+GpWsyuBRmHXgLDoF8mVAZoUJphajRTdUk2RVG8?=
 =?us-ascii?Q?RP5AWAk++gikOIyyoGp6QEOdlB+MDZLu4bjljN6+FdDtgB1eBdiC64Rl/pNm?=
 =?us-ascii?Q?UA3K+v0xyb6N9yoFj+HT/yfqR4fIk2jjV0mU4LT04mnWLNNfZIDV9gE06X3G?=
 =?us-ascii?Q?zPbUfcmi+fLbfHFU8d4baGo1zofW0jzk+SNKqQs3Dt800rLjkrLtI2W2nK1Y?=
 =?us-ascii?Q?9Q9Bjt3Cdt/2JZMYMwY0yaTBPnHqvTOh7A8dOY1WgAOe6FkFbYzOqLKqAsRX?=
 =?us-ascii?Q?+VUB0Wuds22a8cgr0KOH+vvQiPWFX0Q8jXuvZwr2LfLh1sprCGjtorTCDCOv?=
 =?us-ascii?Q?R3eE3xZVavqU4uMtJAT6dsZdTJ7SGNqI+YuwH7hf3H/soERdBk5VteXFD1U/?=
 =?us-ascii?Q?NGxAG5P8kHkTiiaWku/TeMPojA/iUpqH0fDvohFJtINBlw6+5n10NSdWweYm?=
 =?us-ascii?Q?Di6DoM+zPUTm/BHD0uDC0LxtbGGHWl11MIabwS3HsFQAwlbyBxk6bnDpz4tW?=
 =?us-ascii?Q?3nrjj7sGWUtoFJRrSqS0vvZestBceoTUK941RRrRxSK9OMU8xBIlit6x1jlG?=
 =?us-ascii?Q?gUkYEMK3wuEwdyN5wpahK9+9KiSmqCSVZ2HMsj9fiDPyuIDlyEo5Hcds+GJs?=
 =?us-ascii?Q?GC2fZANDsKDpzJv5e+ctU5gfcIdIJQL2dCNklebpZ+Z7+e8c3y7Fo2weoJQM?=
 =?us-ascii?Q?TBoHGCH+WeoOevgZycU+zdTwDYRKv70dSKEqaNc3jEC49HX2O9BdD3y7k4is?=
 =?us-ascii?Q?75DTR2CYk9sNaECe46jjYxBE9WZZBg/xkp+nEjShxyINGoMrvifb8VHum9ET?=
 =?us-ascii?Q?Wy157G/5+gf9NlTO+ZZ7vh53uqEpbk4RD1jg/IPZbBFWTwT+mU2vssTaF+Ux?=
 =?us-ascii?Q?Tf3pO0nsW2qC+nbfcwyvbhftgIQMDHdTIy3cq8zlRxN3kFzbQ8bVtPZfQvvJ?=
 =?us-ascii?Q?b9G4USkqaW0lH5dqBlQq/9mIPmejd11Z8nQMvLT4TzfpFPiwiZnyKZSR+8z+?=
 =?us-ascii?Q?sxqWq73Y/Ic8wEQWb2B8nWyZv+/sFx/9JzY8/CsGL4EVHbT6eHZEtoxsNtal?=
 =?us-ascii?Q?1bhj0hnBuebmuDBVaUOsa5WOZwzyNQ3xaZ7UjFtOk7QQoE5AvHlSe/2tqb9u?=
 =?us-ascii?Q?tOQNAr1Wcbj2oEO4ELopKgAbTUd7VzxMqEhzIjmi9roHYP5oYT5n28o4gaG3?=
 =?us-ascii?Q?A/DZTmu3MUhWf+JCgTRLfHAo0kB7BQO3B1M2YW7q11lcPnVcUTjwkor54WR/?=
 =?us-ascii?Q?5yOdyBZH1aIxeaRNi3XKZFw+mKTP9f2zn5HMTkADKnYsnUklUbszw6B6ZDs7?=
 =?us-ascii?Q?X+jM0U7w10JabmVE7pbojIdDhF3lkRPH+9xIogNvVUUGKuRB3LO0p+WADpnv?=
 =?us-ascii?Q?fyZrNrUfPzDVMtk3K2y3a6OENh+LSrFdLSw/87oMKaYDSNCdYfxz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073cea86-f0a1-4894-84e8-08df4c195fbf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 23:59:58.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLAGMLo0XkhNSYHCFCYWXXk5U27D4VD8jJbwKHEyIws0EzsjDpatteuVIQ0Z391aQyvisuIdgOmmKf7WEOK5Tpl+MA38BeR63ZPj8b1w4QGoykjYscgfB1lhUrbqypcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB803417

On Sun, 22 Nov 2026 21:51:12 +0100 Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> The blk-ctrl domains are all registered as off, so a domain left on by
> the bootloader is powered up again by its first consumer. On the
> i.MX8MN this resets the display pipeline set up by U-Boot to show a
> splash screen.
> 
> Read the state of the domains from the blk-ctrl registers and register
> as on the ones left on by the bootloader.
> 
> Enable this only for the i.MX8MN DISP blk-ctrl, as on other blk-ctrls
> (e.g. the i.MX8MP VPUMIX) the registers do not reset to 0.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Reviewed-by: Peng Fan <peng.fan@nxp.com>
