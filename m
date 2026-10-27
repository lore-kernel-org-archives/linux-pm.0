Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.103.1.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793116410;
	b=I3HGFiAxCDdAUPC/hh8UtGylhZvTU4IwwlZZwX/f3CrKbN+T505fdTfq81cqal1j3UKL
	 seFULBgFL7PWmzfZMtbFIZX65BtgtGTjHgMBmyDmwfiK+f6dxNaNg0ep7fsMzHiCaV079
	 YLXvXHySN3rISCZbDZWDw1ufR5GX/mIvwPZ+uND8pN8RG09NcjqhfkLfaWigU8BOfYasb
	 32BN4OZdo39oQpWRAkqaRvatq2pjSnjiDd6WdFiXthbdHC5RzJ5NGw0eTFUvkTdJdbqsK
	 Ox3xN5wg1DsAZylVSuip8zvepiiEE0/NTBxrFa0xpow0f/j1GRGH0/Uh4ix6ea/X7/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116410;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=konxJU976qoZ0yxO4+nhaqQz2QtbPOQcpPs0YjsHpfM=;
	b=ug8uJvHoYXtxIhvUUwDm2IlCfJN0Fh9JIQaSVSIPt5kr6NJwmv3cttpDyxLZZaop94jj
	 A5C5WTm+EBjZt1JdPKCC6KsZP5raXmmZ1lBl6ney97e4L7dpvoVoNb9PvPAXCmS+kvOh1
	 7vxGCwYJiC8gm8ReBMdduZFFMjXr5ETiYHShE4LHRaSTfl6jOQ3cU4K3A3BWqrrAHpQOj
	 8ALgh2+7jbh8B3voSVEm+RPkPyjcf/vIRF5qPBivVHMBVvz9hsLcZoXKoN+adE3i3V2Q5
	 iXkrR+wHB1G5zr+EXYG+LAq/zXYoEzvc6HKdeMUKszt1CiUUUXOAzwj/uG+4OVmeuBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=fail reason="signature verification failed" header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=r+DckCIK;
	arc=fail smtp.remote-ip=52.103.1.8
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011008.outbound.protection.outlook.com [52.103.1.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A8606A31A;
	Tue, 27 Oct 2026 15:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A9A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=r+DckCIK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiF7LuWhFKq3ts8lv7t4f2ugvokhl2A0sLTb387QOUmwKWGf9c5YlU8Fq8sewRNotzesiunkc+zMuK5ahQr2T1452jpqS9j31jmuG0+36S6xm1S2kHgtwGC6soXiZ3ClWvhr3OnpXQoqpxKeWqebbOXnf0nbDdsn4HO3mc70I/DvwS3dx2ulfv2PtoXUAEarejk8IQXwie8EcDNZSGwcqhGv/eUO4MHGmLyLIYh79R2OKEQIzSA/42m5r+V9z7A3s4rCDRLnsW9c+szVVm0a/0ZvOGIsMwO0TXC2/y9g90F2PZUrkltFxi3JxpH3vWCNoHjp8e+Ti7eHdOXBtAbTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZiHW65TeOd7AOKOoXpskmDgDhaZbDRcGSWXfItqLB4=;
 b=dtv7PtJCwcxBYYwnkha6EQvCK7PCih1smazpkVwsoLB39gOwmRZxTVR7L8Zpi0A8gSA1vjOOC2fc3YYo3VhdWjojrgAnyb26kfNhlmCKFehfY00oUnOWnE/MzlbWv/A2oESP8ZCCoalXgfzJNYeXKN/mOKreXmfywskM/Z2nXBUfm2Te62JUT7IqiGRan+WiNVOaP60sZdJazAlyFs5dhOt7Z1MIi3NRhqLro+lMHKiSUllUSW0BG61wIOVYY/AXI+pxm9qW0mTGqO2CTOON5Y09XYdwEOp/2IPmsFFx3jNYHt2s8YimYI2mG39psZ1dr4CH05BYQk0d/O4HGNYdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZiHW65TeOd7AOKOoXpskmDgDhaZbDRcGSWXfItqLB4=;
 b=r+DckCIKpjbo1b2P+z8sr/oeGqTkxp2S6Mr1c+wl91IBvNPzT6ioB8BMwBZZhblYnPy54lmIf95J2XZGlVQTkeCp9LYhNEcmgIiqf1eanqQHJBUTZYOnE9OsKpcfmq9DQQEoE4Nz4vScvNuQA0l07kHFs9agLOcNq3Ls/VKEWYNAyI9CK/xe9sUcWjzNa4pxlLn3eWO/kX6AG/MLn7haXFAnyA8Za6vOrkniy8kBu7aHR1qn2q2v0EMZsfFhxkfcVs2Ht+JBOCpU82+sbsAiXSklet6nNWzhSwpQXlwj0Ii4s0h6ZNjaO2X2BL7ga2RpAMNgJqJmXAtDLdOQVB6yiA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by MN0PR19MB5825.namprd19.prod.outlook.com
 (2603:10b6:208:378::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 15:53:16 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:53:13 +0000
Date: Tue, 27 Oct 2026 10:53:10 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	maccraft123mc@gmail.com, zhangqing@rock-chips.com,
	zyw@rock-chips.com, sre@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org,
	Zetarancio <zetarancio@users.noreply.github.com>
Subject: Re: [PATCH 4/5] dt-bindings: power: supply: rk817-charger: Add
 rockchip,gate-function-disable
Message-ID:
 <PH0PR19MB997338FA74EFF7CD338356EB88A5602@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
 <20261026174834.1652309-5-macroalpha82@gmail.com>
 <15875856.JCcGWNJJiE@diego>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15875856.JCcGWNJJiE@diego>
X-ClientProxiedBy: SA1P222CA0075.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::22) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <auDI5gkxXtt5mzK4@wintermute.localhost.fail>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|MN0PR19MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd21063-dc09-4080-9c1d-08df34426856
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6cUe9t9Fs5HiQGsDL5YS4QsptyKcqXRh+vuIcx4PlC0CpXHolmQjVX05kRmoOmwDQQO2zPq0knh2DZNiHr5hIVy3AXgkWiITE2PnprX7Wx1XgdNU+8kuZUxqyAIQXwNkW6VEVBSDj/tvFjpOGm8mI2igv/zr6sIdeBFCqGswsRDVGw4zhJEI0VmZDbK9cSdCf0UfCuHkvY68mtVKosKNt5bFamaRKN/Pqo/5URTGYwbYqrOqCFEC60Cm3mvkyGClbUh0OtGuLEB6RyWrj1SRzN+Kw30wqwnUI7EBM/mueuSyiBwPRx/rxdPPL0q+uFmC/6LP4H0TZHSdE1lRx94ietRoAJOSFiN+RXFdzGJhiW95jjy1dksRyPtf9oAdluOjv89rUfX2jyrx48M+5sFDv/OIxwCOVqTFvw3mxJjoBUqW5dTvtqohhBO8Xc0kpaC16bos01kvipOl4nYkBqloQ2f61uCoaJo9s/tyIgX6wDJiNvdoPWyjb9drv1TjC2TM/FGpVfa66Rd/fbnRf574fuEKmpJaMyMmEzKNbXxMTTt0KKYDPHTJ1ie3tExwbsgIGZZRt9krv8zrVUN/VNyUFhcm97T39o2ROWsJxPKIets0g+vKMr/mezrAzd03I1V0wwFHWTcXv13R65WfxWJ2dxIcEJS00n4WZ8SThGkhiRKRAf+emFHKRUTbNLoPXp6GqKZ8PDWE47hPh8L2mixoUKCnaz2rHvXpkCHagBqrKnqA9MCh84F3q6wGzRbFLJQCY4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|25031999004|23021999003|5072599009|15080799012|6090799003|24021099003|19110799012|8060799015|55001999006|25010399006|4140399003|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?A/70FDamXKuShdiz7QDWtWv/XEOHPvfsWEWuGURqyYaZXhCOx/ST6hJyZO?=
 =?iso-8859-1?Q?mRcqbhsuTbfv8ExzeEBep44x7XaEdkQpfnZvuulMdBMN6u8ZBjfkV3gvf8?=
 =?iso-8859-1?Q?BVymrzvYIPcx07B654H9KbBbB7JclVQnjTllKhYBqIeFvq2LucCU/UH+YJ?=
 =?iso-8859-1?Q?7pQQm1KFyvffOTt7qyTNHd0kaAo4mIeRRoHILkUQ/9/iLSfJ/qkIoyo3Op?=
 =?iso-8859-1?Q?IJ4pyr4dFYDGHsK9J3funm6b67Pld7s+dcvurFpfLu6kLDNagJMPls9lnb?=
 =?iso-8859-1?Q?c5oQIBqv5ziDgaj/JH4AX97XPqvAiOvLu7iLFpRk1VxAqUK/MxqvM7a394?=
 =?iso-8859-1?Q?VsWwggc++QX6RZjr6mtlMPT17iZ4ULEnuOvLwuACclY3W/3ZUxKU7XpxQt?=
 =?iso-8859-1?Q?6retoTy9ODtnOZDEPRseEFkJfaggF1W9lGEhDwt2/QYPebAQ5KxMtNLQmH?=
 =?iso-8859-1?Q?hrKq8SR6zH6zywkozj9qQdDSD6Kz5Aybwvgk/7EYaXO4JTaj+CkFr9yAwF?=
 =?iso-8859-1?Q?OSGN0N5e1XAX+vxvGXUPzj4acXqE7jgEm/UVJ5cKntonE7tm7mFPxdLtCV?=
 =?iso-8859-1?Q?N3rqiRdvInGOXriTtrdVxS7InTdjb8oIDLt94ckz3L8FCVkGczIgF4P8Pb?=
 =?iso-8859-1?Q?m3XqO23d9Jp4ir31kLlsWlFwvGjW5nmsp34w1rIUS1BWqLJDTUnIhrBkdj?=
 =?iso-8859-1?Q?FIiI2DmwTtVBT7SCBGhnlylkcA5vEoe7FiOPLqX1Ntcpx7XjFAe8wxpSuR?=
 =?iso-8859-1?Q?lEeVLpza60pePcky9t74jJk7aBx36m9xg7aH95zOQFXIQoEp19PjfMNsCm?=
 =?iso-8859-1?Q?FSSpRnSMmU/1NV//U005Ik9kqvq/cVXIvxfUgDsUNMtvs+wEZXONSE/uzz?=
 =?iso-8859-1?Q?jv/68CrNZEXVbQHbnl8RIzUQE0N7DjhFzvMh7okB1mA7kFDOZscKR43zBh?=
 =?iso-8859-1?Q?Cy8Q75GZQ7X3R0pCtF8LHRsBviLTlD93iY4y6X0iMf5AyS8RuehsCXhlkr?=
 =?iso-8859-1?Q?5oAm9hK2GCsbXbH0aMGjwm2/Kc2+7dXHnPFnK2WcuBhJpKQPV5Uxy01my3?=
 =?iso-8859-1?Q?qEybR4OzViX8xSNceqkDwRydrhEqQCTTTyJWo68zR/sL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rbyzyM7u+O7ffTGsSMKRtdXRlNZp/0vI4Z4xTlSpegi1Q7f0mzyj7HGd7f?=
 =?iso-8859-1?Q?oTM+6yhYxyA7sK127UXKNH+TR52qvxabWzupBuFLtctDOGRQyA/gueJYKC?=
 =?iso-8859-1?Q?FgxSkfr4JZji/h4u/v0Yy1psD2Y1pHue+cMYf+M+xs1hhDXwZfh/3hU/kn?=
 =?iso-8859-1?Q?WOJMPc86CUKNNGUvT5L+SbFz4vNsAtq77F+Ke9g4UNttw2rpBfOWmPfT+7?=
 =?iso-8859-1?Q?lfM8s0m1Zfqyx9iCwYXhwBWNKXl2GPPYoCfcWuJmfnOZ+1uHU/b6b+Pd1R?=
 =?iso-8859-1?Q?boqiqXoFXkjWuO86GCsxB+CE0ejAGrjAPfKGtJTDxmS/8XLVlcFYhchmbv?=
 =?iso-8859-1?Q?KOJJbIIlgItPB57LRvPDjkXTDQ1xhCd2oCmPrkrHtITiFE472CEbnvUpPL?=
 =?iso-8859-1?Q?QVq/jiC+RNy7BXQi42/R1ofznxsitLehOnKTw/E9i14e2SqFFyHPRuWjNT?=
 =?iso-8859-1?Q?h2SBdC69UanouvD4l894mjAhxz3fcYyw9RdiGMUU5e9yX1vKoD8uFBpzxx?=
 =?iso-8859-1?Q?TgzYcWpfVwmu0FMvyFmUqKqdaKDOVMK6o62E0izTSfHQH9j03ktXRUR8u2?=
 =?iso-8859-1?Q?9FKf43dEaTvbCKWNxPMkRcUZchNNqGHH/r9pp4ZSoaXu3FZJ/u/YixSPsM?=
 =?iso-8859-1?Q?r2/dg/z+g9jxmQ0c+czfpOo9RUjgL0qP5QsVWIamMlxg9rBO7g/6WuNrl9?=
 =?iso-8859-1?Q?e3AL52yyAAr5nB98cZWPnbi/jlz+p2k95VM7M+Ky5z1iRDtcQknHxTMkuq?=
 =?iso-8859-1?Q?vXvgr29zYEFiVMO6+QnKf3EsE21J6kIeLCaaHWo2KGu7LhOR95Iux9e6Bx?=
 =?iso-8859-1?Q?2fHJv9LcOMM5WHYb/wOag1kCIHutWnlkH5goZ1CjQqX8803it3CLDbJbkA?=
 =?iso-8859-1?Q?albyERdM4otH5O6ICVr3WXWVGAx5HH1rHVGCTKwnCtflVc0sx91xxMy+iM?=
 =?iso-8859-1?Q?LIADpZqUMOjAOdymx0qKdEBrdYdBdS1wjKB/G3ot/el7cRmvvIepqmBCRz?=
 =?iso-8859-1?Q?bxOcB4S4IENmh2goWkYV/NTiKoRjQNBTBoPdOn4ZwEj3QjVBG0mgXKm7C/?=
 =?iso-8859-1?Q?7H97bYP6NAfV2NudKuIM/OL9mxrExRb/Hia9f84xhICrg45QypND4vkXRL?=
 =?iso-8859-1?Q?vGnI4HxtdqHfV4BbQcu+mh8Q6Fn+eB8AO8MMsZfXaPSp8Cms8n2c1okS6a?=
 =?iso-8859-1?Q?Zh+VhaYaf8pb0nhV88t/oIYHhcqJzjnKw0c7Rpze9G3ZCk4kFXCRkCmV7o?=
 =?iso-8859-1?Q?82nCKodOUwA9aEQ0PeC9rNvSyUndX0saVDRqxAVoVbNui0tWD0qKP2J2vM?=
 =?iso-8859-1?Q?K9luvReZISGEhJY1L3q7MSoy+SCrVi0EZ4CAipE+e0DH+Co0hL6UZkcbd2?=
 =?iso-8859-1?Q?BA9NAw64MoP2EPluFfu7BlLQmjJtrPGSefBVIfcXgrFgWKA4StxJZsOaq9?=
 =?iso-8859-1?Q?CzuQSo0z0FFB4fYH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd21063-dc09-4080-9c1d-08df34426856
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:53:13.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5825

On Mon, Oct 26, 2026 at 08:23:40PM +0100, Heiko Stübner wrote:
> Hi Chris,
> 
> Am Montag, 26. Oktober 2026, 18:48:33 Mitteleuropäische Normalzeit schrieb Chris Morgan:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add a boolean attribute for the rk817-charger to control whether or not
> > the system power is shutdown in battery off mode. The BSP kernel sets
> > this value unless a device-tree attribute is present, and this attribute
> > is to replicate that behavior.
> 
> Devicetree is supposed to describe the hardware, so your description needs
> to describe the per-board property this represents.
> 
> Just because it's in a vendor-BSP is generally not enough justification :-) .
> 
> This is especially true as you wrote in the cover-letter that no known
> board actually needs this right now.
> 
> 
> Heiko

The datasheet describes this as "Whether the system voltage can be
shutdown in Bat_off mode" and the register itself is described as
SYS_CAN_SD. Maybe call it "rockchip,can-shutdown-bat-off"? Or given the
fact that I'm not aware of any boards that would need it today, should
I even bother with adding the devicetree override? The only reason I
am adding it is in case this "fix" introduces a regression it will
allow someone to set this flag, just like the BSP does.

Thank you.

> 
> > Fixes: a592aa3a2a8c ("dt-bindings: mfd: Add Rockchip rk817 battery charger support")
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> > index 2cb6d176a84c..4cf987fe763b 100644
> > --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> > @@ -148,6 +148,12 @@ properties:
> >            Value in microamps of the sleep filter current for the charger.
> >            Value is used by the driver to derive the sleep sample current.
> >  
> > +      rockchip,gate-function-disable:
> > +        type: boolean
> > +        description:
> > +          Boolean value to prevent PMIC from turning off system voltage when
> > +          battery voltage is shut down.
> > +
> >      required:
> >        - monitored-battery
> >        - rockchip,resistor-sense-micro-ohms
> > @@ -381,6 +387,7 @@ examples:
> >  
> >              rk817_charger: charger {
> >                  monitored-battery = <&battery>;
> > +                rockchip,gate-function-disable;
> >                  rockchip,resistor-sense-micro-ohms = <10000>;
> >                  rockchip,sleep-enter-current-microamp = <300000>;
> >                  rockchip,sleep-filter-current-microamp = <100000>;
> > 
> 
> 
> 
> 
