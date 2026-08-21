Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181984D8DAE;
	Fri, 21 Aug 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325796; cv=fail; b=cLxt7kH3Ys9UngH4VaT3yuOI50tcDoZJ5LgSKbuYEry+LvTjtDVJGqwgT7VsXKMEih7RXEqoe1chYaKaraT9akU6ZklNhWkiOavlPktaoL30G1E3kQcXLcH7czQ66qcUXG6yHwMdko4g3LIjvjvOgS1V+UqXvxByqL1JCmumyLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325796; c=relaxed/simple;
	bh=wLBxHb83XfW7ONV9nCf/f3jHO4PzInOSiIZFX9eQ4rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K2n5jhUNL+dgHVpRNA84kTs6A0ENYKf/7G4JK2z5xJ4NCrUV9IJNSPKhQ7wsUsiClhxYio2LnAQFKBauvqMXRLkPRpCXxg4LcPqB4sJ/OPvJNDUzIQVyoT+BTyex6m0AKyGZZIIL3HiEKphGoRUiJGYTEg0KRfLtAErEJhvYmSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j4sA81N4; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j4sA81N4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz634Fqdz2WMjZaR+ZYBP9pGwKMS30U2o9ed6KSSpYJCf/ER3VruAHL36AQmhyAagJRf45vjroud5ZPO84FFl45v3S/WkEqWoiv2r8dK0Vs2vXJUzBEfBGtoNnNSb2p+G9TPonrZXdweq/4z/szgx9mFI6hgqAC9FA0oH8ffb4Pv9ffj8V0AoiGylZDrCSf+oDhoviiplOCpLxl77qDxdUcWHgwqoq3Bahz0u+NkXbcj19vJ5ceXokQ+1wqPN4nrZyo/9OK7KDLhU7mNHVxDHlwV3PyZVc6yjzspny+wZ5anmyhTok8feSM9r0wT5PvpyjhcqJ4jgyZq3LxgGjSA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a8aE2FcckriduDC5LXGlYxZAqJaTXWfefcf5h3Mldk=;
 b=tIW9AgTVSVbr+hdBO+77gOs+wyP7egIISLJEi/qyf2Gn3F10fHTdJYuMh7aN6sp1OHwdfCQpOylv/pYQPSnI9zZrNWpft5xJn4Wwf/PNOnfSCLgjdVO2CalR0mTVVjpj/wXHJT8nxjEEGfnYmmR8OWzsBwHAX0mwZgwJTFEn4n2/s43SnxRe+l1O+AB7Vrg3/QUgj8gqwT1do8ef+GUju67bFjhs+i2i73+4WqJ+nnaEJb27SpTRXRFbWRP2UsNBtF3Xe3JZ4JJFaSm3hA6moGzreVZ6Sqs6YPJYWVoh21JFDdIQs1/ueMsfpCQYuRg3nILCAHbJ9FEZU0B5RjTPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a8aE2FcckriduDC5LXGlYxZAqJaTXWfefcf5h3Mldk=;
 b=j4sA81N4B/631ctihMrwj/iuxWn7MYAlV4piUswfmllWf9mFPE4JdbdYWe88ayjYnKXR0CQWZ7drr2u5VRndxjVItM12Y3q2qeSlKaNdPIf86T7orzsZs11VXuIy9DMcwID/WIa9ECfMnRI37iEsoVUaINg5P/UPWS0qbnMFzTNed2+yFIAIykMejJcb8ia1T88wIU2scWQ3Sz40C8qQLrzaP2yKOEMrhtkQ8laGvgm2v3l1zkGDrTTuEHLvs2LwTxStN9yRSVBrgTCwX4pedLK/gpO5IyaCvhxxF6/mloucVevUTvVa0bsVkg89IriuGX83nf21NJHkX0OAqtV0sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6867.eurprd04.prod.outlook.com (2603:10a6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:23:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 15:23:12 +0000
Date: Fri, 21 Aug 2026 10:23:02 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8qm-ss-conn: Add USB HSIC related
 nodes
Message-ID: <aohtVk57YIWkj05I@SMW015318>
References: <20260821-add-apalis-imx8-usbhsic-v1-0-fb93d73ead44@toradex.com>
 <20260821-add-apalis-imx8-usbhsic-v1-1-fb93d73ead44@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-add-apalis-imx8-usbhsic-v1-1-fb93d73ead44@toradex.com>
X-ClientProxiedBy: SN7PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:806:121::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d7062-973f-43c3-10f9-08deff981ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CRSHVhsSU9ZxpaChxvx280DEQHiXvxTtXBu9k9QvrIb5mv2Ovb5uTXso0thar58NW6gM6au4seAKy5R+Iy2sqTw8GCh+h9zXlBsos3oIgkaianGTIzjZxSE6kdMX/7UbrkQDDRfLEnCGU5AqB8TR3zkCxaI35331Qy+/JisU+EZ4T3mjmOCS2PXj2SN2w7DMJr+sAD7ChooRiPOIebFnPao96uCy0u2hW2/ejuGeHd2pg2Q6eDLPvcFcAB9LbEqVuz6s/LxQEtVnsh2hZXoLST7K1UWsU/X/EWFobNPKVqwifocXX3WGMWo8AnCclwFHbqgevPDQcRaFlm2lslvi+479w4Q4nyppEp3c6x6vvB5nWbGcIKOGHfQ5uOR1KysxXx1wReqHRBYrpjeQrN/snRMd7bZd5hwNJxL1KcMrlz2rTKmTFdhcIBA4ENese4EfbaV19tkh8a2WMKS3ODUl08Km2h97W90iU7ySOv7SZeB1O7+saOIXCFRoOaeudFaL4V4uiF7g3bgA+C6M3EHRO4PRg7/T18WXjNPXb6K0URclnUZ1UOwbX7CpToTOcuHW57hPWvVGyohiWPO8TepwvrSm9ol8vhZTjinBkWg/LwgSwOzLmkaSWWmxZKbd9wKgu/3Y6MdhNo73C3CEcIAt7+ihqiGV1GRtHO5foiU5VHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPXtbR0+3nNztBGOXCUzhzffPAJetHyuHq+GXjjwYY2qxUb4CAmLREQJ/mq7?=
 =?us-ascii?Q?uO0DyowYULkM/ElaxAg3CJdb/qVyxp4FPh5rjUruFrwU5/0tcoITYvqQyo/i?=
 =?us-ascii?Q?+UrBj21jQIomJjU+d/5sfRUljwLf/NaMRodZV6gmWpB5Ov2nCrVRPronaLhb?=
 =?us-ascii?Q?gVMxDQIqjN6QLksXIxHFq9w7Ghcdo/i7ADWIC8baRLa37T6aJ4wyASkYgd9/?=
 =?us-ascii?Q?UJ8iR/lL3YhVLodBJrzeyCI8gsbbOqNntuj+v1pz5bS5TDAdebhRh6q0Y+j8?=
 =?us-ascii?Q?2O8Qcd5u3KgGljb5/OH+34dooveb13aLgVnX83XdyO6SJLhazDQM+HKY5o8v?=
 =?us-ascii?Q?5l7U0rZOQXVPkvuYNnth+mlLIQtVGbAGaPEXbi2hqLJHYIk8o6m6CthPtJZY?=
 =?us-ascii?Q?BNB3KoSQKCiyL8p3D03lvc1x+vrSbLfy1nH05tlPfLSaUDP2O29nH58Z2PHW?=
 =?us-ascii?Q?7i+H2x36B47hjTSdoqNFmcU/BUet2LW3hHFQlRUVxtbDRX+3Rm1XFd2GBZc8?=
 =?us-ascii?Q?Zy/B39KcFpvMzTPdOcAtdajsW5+yqC+7Ou0vSBZSygO+7u/tZzr5/cAEMDJp?=
 =?us-ascii?Q?46hGxFyAJZz33mXnO6lDETP83xj9Y0ToMb6IOPkhbbXR9IVbuRjuE+kL55rf?=
 =?us-ascii?Q?XpsxHIy3cYScahI7CbRYRAMe1vJR9PpwLPc6nH6+zYmqf6P0HBWz4ZAgfkRu?=
 =?us-ascii?Q?V2oZUuxZ6hVZk1dIajQ3ZrVO+Hk4fPpDuW15LKfsLqhgVbDvidJuTlWVOQeK?=
 =?us-ascii?Q?SbeVoT3ou8kwNwnARdEExM2RYXECkFeNVD8Us/ZbgAbBwRS5RqatSv5iTdyL?=
 =?us-ascii?Q?0n7uzwvLkBBuXF+NBKcWQAlv4rctWk5O5pNNyBgOGm8PxmI3k5+F4M4bCPA9?=
 =?us-ascii?Q?EvakC7lo1Wy/YAxKYX6jkH+lUxEbkG/CCfZAaWwiaP6B9ISbAsMKRVVpDOpv?=
 =?us-ascii?Q?orF0Md1Z1Td+gmLNAWV5kn08bVpsP6VnoZyQIgN+m5OdD98b6jquqjopMIu1?=
 =?us-ascii?Q?zpV9ksPPGp+W4oXxbkI13kp1eJYcBbKsnGuWcymIsDlGt4jQS2lQKcn1pM3Q?=
 =?us-ascii?Q?JWsOSOhojp8d0EnbgaqnNEfL7Ub86okIZOy2xxwznVXUhL7OsvWjTnwONR/q?=
 =?us-ascii?Q?vf9sCYx4uQWYHWjLgHBtva8Wud2prL8uXAzJQjd9XZuSTcSGUT5T8+HTAEl/?=
 =?us-ascii?Q?FDENne8sExVxNY5DO8Opy9fgYBtInjwa6ZH2HjUAnvLoCR79VivXDpgkTtKy?=
 =?us-ascii?Q?nA+N3de6vBRzfUG/3HBzSurgtoccHY3Hg9iWUx2hrDAJvB7W86+EqKg4Z7DH?=
 =?us-ascii?Q?iMPJ4jTpFUx3e2e6tIW4v0/+G1YgZ5UjCvFhBER0pThIPgj7QMFR4cPxpEnL?=
 =?us-ascii?Q?9PP5RSOTklppBa69u0tBp74aAEZFljyZt94oFMlvcm8q8fWqYt7a2WYAAOJF?=
 =?us-ascii?Q?ZKX9p6BGt3+KyT/n2DjKnKvNmEVHC2Yrp4fn0pmV8p95oDfAe83ZDKpnMtb1?=
 =?us-ascii?Q?c0C2wQ47NMESUJK6gZivixl37FLWMKeQBG7RSMF6QIMNBBb0d2QVSRqqFte7?=
 =?us-ascii?Q?Vo9h+WrEXOSdqSUX3HpDtCkKbLCoTDa5ogTADAkHqEpCVpMt+ACtxDFGxpvU?=
 =?us-ascii?Q?vCQZFUUnVev4m0P8903rqt5hVnYiyrckJ07eiBpCETyrAHp9MatRPnYs3GOC?=
 =?us-ascii?Q?A7kRlk6SPSuwItvO2B5JdgP8FE/5zFVkIhD9EStu8e15YReoIC/sQdrkydU5?=
 =?us-ascii?Q?Qh1N2W1UyS/MKQEbECPDXh54cNdJrEvB0ESAr87sTj1pQ9Sl1xFO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d7062-973f-43c3-10f9-08deff981ce4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:23:12.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTPFkXSfuXy96a8NN4ZQOpiXbrY4Jmb5Y0hqJp8q2sjFrFiCNDFTlMTe+EDWc0Mo0KprBNlwmrVAMwoKr22s64hNakGEoAzlzSo3YJ2sdKIjX7V5i3cowMph8nnmPOB1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6867

On Fri, Aug 21, 2026 at 04:58:57PM +0200, Franz Schnyder wrote:
> From: Franz Schnyder <franz.schnyder@toradex.com>
>
> Add the required nodes to support the iMX8QM/QP USB HSIC host controller.
>
> Keep the HSIC host node in the QM/QP specific dtsi to not conflict with
> the address used by usbotg2 on the iMX8DXL variant.
>
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> ---

I already post similar patch at

https://lore.kernel.org/imx/20260720212401.C2BD31F000E9@smtp.kernel.org/

Frank

>  arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi   |  9 ++++++++
>  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 26 +++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> index 176e2e332f87c..44eee9abacfb1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> @@ -384,3 +384,12 @@ gpmi: nand-controller@5b812000 {
>  		status = "disabled";
>  	};
>  };
> +
> +usbphynop2: usbphynop2 {
> +	compatible = "usb-nop-xceiv";
> +	#phy-cells = <0>;
> +	clocks = <&usb2_lpcg IMX_LPCG_CLK_7>;
> +	clock-names = "main_clk";
> +	power-domains = <&pd IMX_SC_R_USB_0_PHY>;
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
> index ccf9f510e0f88..168f89eebeedb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
> @@ -4,6 +4,32 @@
>   *	Dong Aisheng <aisheng.dong@nxp.com>
>   */
>
> +&conn_subsys {
> +	usbh1: usb@5b0e0000 {
> +		compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
> +		reg = <0x5b0e0000 0x200>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> +		phy_type = "hsic";
> +		dr_mode = "host";
> +		fsl,usbphy = <&usbphynop2>;
> +		fsl,usbmisc = <&usbmisc2 0>;
> +		clocks = <&usb2_lpcg IMX_LPCG_CLK_6>;
> +		ahb-burst-config = <0x0>;
> +		tx-burst-size-dword = <0x10>;
> +		rx-burst-size-dword = <0x10>;
> +		#stream-id-cells = <1>;
> +		power-domains = <&pd IMX_SC_R_USB_1>;
> +		status = "disabled";
> +	};
> +
> +	usbmisc2: usbmisc@5b0e0200 {
> +		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
> +		#index-cells = <1>;
> +		reg = <0x5b0e0200 0x200>;
> +	};
> +};
> +
>  &usbphy1 {
>  	compatible = "fsl,imx8qm-usbphy", "fsl,imx7ulp-usbphy";
>  };
>
> --
> 2.43.0
>
>
