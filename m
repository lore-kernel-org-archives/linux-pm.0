Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E5393DEB;
	Thu,  9 Jul 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568299; cv=fail; b=RH0J9JuCJQ8Hxo4bg56+V7yzQs67NEYYPe/sek3CcDY0DzZzBE3ylAAeQ3vgvwhaI4w52lwC0k45Ap+HGKffLpUDlRIl08/dwLtQxyKq83sI7+MA9qWnBsgJAjVYkGA4A+npbw9EuHyr9cQxKJ2Xz8oTFHgkuvcLoTEz3dPrTzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568299; c=relaxed/simple;
	bh=nyYfHgztVMo70S0Kk1gzTNiGPXCi1p74ThNZ5SJpeag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sd3pyNbK9xadDsNWM9vSleYYa0Q9L3YsM1eYsvVViw+KQ6C4jPBXaYtO6/i37nXQxMWJW0kkyU+L0Kje0qyOP2UL1FO98ymA7jsZ5O4vKgIcpW9e/QikejCVsNUU/SKEpSxGnsvSpGSSV3vmuERp5MTnL4F0zHidwU+P1ATFpTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nA2+KcAj; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nA2+KcAj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAS4UMl6qx9xezKlnjcN2pZb7ljuxaybnap9hvjTOkGVku8z19qrlY4GWLO+zmq3fU1kZuKQLFI9SbIp+WH/mt+4FOGz9JZT5ykQvYXU0tVRuqVaZ+rABkRxeq25xP1pTV2UEfTuInZV6i/CF9DFa0Z/V70Br5B4ven24ZhsNgwFj7GxxRFegVgvWjIIESVxiBSGqM8JYHNOGPjwBGOSlrlav/ov/xe3U4bo9lP9fhVQjvBShfCbZhzvmBTeRB882um06gTfleeIQSqvcSbck5zyU2s0awG+JBWTnYHwW/b+nTFby6dHJC0saL31BRPdx8+ASXTg2PYPtdJXk4ISXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z+GRB+cuZi74CAJ6wLQ+p23nwPo8BcaZondDmM9XbE=;
 b=IjETZhU85macvNvRHJKGKdTE3s767h2uM5k3CSl5vKmVBst7Qy2cE1SxTt5VwXF3Lx3FOJgyV5eokEppXDTNschfMKI4b6z52eTRCULYswM4DfXm7WzZcJw+0Y5hQjJsCcbEpV6xkX6Jeoov5Nu76gfgiSoqY6rtPdTMrz8GTsRot1GSFLbb3hXfP2Hk7Adm5QoiU2sUgfBXaLo5pAIlyxF5y/TTH9FYb1PulfVXo3KyhDRrKWJi+Uzw2ijAdxYUmLQoXxOC1U7UC+60Wzj+VUEa2mWwLKxllu160MQn6yLsVGDgurH+iiPuwzhHK2Casc0XlunJbWR0YmDze6Bv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z+GRB+cuZi74CAJ6wLQ+p23nwPo8BcaZondDmM9XbE=;
 b=nA2+KcAjjIQPX6gZT3YzyhEvrYuPtkJNP0+j3fQOv7uKiGDyH1GjNeuK1JjUBZRLedfnD+exUxNCl/POGJldY47QFDAYZXmVm2u/2rN2Eg3tqIzR/3Eggzdvfcsd1489PZCe42GpOf9oyqcXxWgcdlvIIZsk3uw+asyGqHJXTUXa4mCGw7amoBWQETI18vnzJscDtoNWcDyhq1XJBRX1P8LQm/y8mmccUrP39t+sukc5KY6H99Ey8WbiUHHRSncHwNmI/hqULqXg+8CChc9H5UwDZq7SAjbWwf6VHJxsu1veDufSz4BzMAICqs4gnc/+CWSTZ3qHF4CD7iSmjm829w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:38:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 03:38:14 +0000
Date: Wed, 8 Jul 2026 22:38:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/18] thermal/drivers/imx: Remove redundant dev_err()
Message-ID: <ak8Xm0taDauxMsIZ@SMW015318>
References: <20260709023048.599150-1-panchuang@vivo.com>
 <20260709023048.599150-6-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709023048.599150-6-panchuang@vivo.com>
X-ClientProxiedBy: SN7PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:806:f3::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed38ae7-9379-4b0c-0ec9-08dedd6b81b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ubas3EzX8I2/3+Obj9IMWCj2wVZnOrdy4y4539QBcdRnUsh7TycteoxD2W5Ae1uG5BDf6IM9XjmK5CfprESOb6M190YXph2ea+yjoaU5LfeYlihC8SnNdhTMoT3ymd6ftIndeo4jUs7RXN+d3Vjcwg7OIgV8HN7JXHbntCyUp3+w8xZG9eigh47W0KF7KGs/22UveY8fbQwbfGijxKQcqxq/NWqlqeR+/SIGhVCixP5B8QliwaTXYuYju+y8q+ImvpVDcTG+H49+sqC3BatEpuNk09KtrLIIUINpmawX+2knWHSGVR6pE72vjlf1e7vqgRb613FhcXiCi2yNlFU07TOGmc57FruHILFZOpf5lIcO/Y0huxybIPWaA6yiHJAG65TadtX0Ff23Vtejd/dg8J9B8MeEgQs0yyKKpFT6bmRoUVeh5i/CTdWJRTWLCZH2mi9Ok9XahT9Clz00cPUpCS21WERERrklgpnhPIYJXY0hvKo6mTH+a8LMD/9JQvi+B9QnyIxrH1yP+4EaMEHcvurS8zEJBu8GNNl3cnM1u4Og6uqocyFwcMAbXSjfltOhvSgS2N2cbheUlEEFw7xn2mLPlis624LGeNXFxO6RvtN2e1zg4lO+QfesHHLUOsL7VJ3tADl+J00gZ3Iq0aie8R3Pu3hEXiYnyTsdihgAsZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jvz6IYfoTD2b9uJ85jgDBcv2aBPUv6azDrsRB7hPoEd9PaVcOcruQQhlEFV5?=
 =?us-ascii?Q?oZOkZ0rSGnZdqvhBynFpHr7Jjhh1f+2Tfzd2yyYv5firG42UCdQ2bNGD/bBV?=
 =?us-ascii?Q?XBzG4uu34+Xx1sUYJy5MhnDJQMeL/++kyBFKchlL6o3iHd1zp+Bh2dWnNSXM?=
 =?us-ascii?Q?4vMy3dP6tMAajqoR1e+ne7/xnS7e/Xs9nu68LaJGU7j/3b5unkbdffyex6IM?=
 =?us-ascii?Q?rqwdMGI0m8IW5WO+zm8lSp+BPOTAcaSabtgmayQewET9NdmkY7isFZ7AFc4v?=
 =?us-ascii?Q?yktivt/7XiPB04bEuMiDV+sP/58bxqLMGGorcz41AeSpEKwzL6jwK/aG5L+7?=
 =?us-ascii?Q?QkgqnTdgfa75JxKLAhN0DbDJE/dhbxrhBLEgGIeWXIj4VaE4mJWL6d79G3ih?=
 =?us-ascii?Q?eRyWtJ5DHzFgQ2M9jXsSWQLSIQ0dt+wdO4yNEjevHeCmfCVnZwqrcU2wfTC8?=
 =?us-ascii?Q?8r6H7vkOlM7BDcI0NvZM4eXa/lBN7YCgtCDlDHu2W65PUrs1BMWHtD5mrgW0?=
 =?us-ascii?Q?xo4mKuYBQq/6styvM4gyjNr4KH8mrkxY9sb+A5Kyqo/OspfoK9tl7p8AqJ5/?=
 =?us-ascii?Q?Cp1twskPW3Ki3r2SyLIqihK6Dmm46/mFMNnx4YZYR4E1YN+Oc41rLxJZ0DJ6?=
 =?us-ascii?Q?4sbLhhBBTf/aOZZlYgElPhLDzpDmDHQDJQFFO9nDl5hPJ0pGxrDxm1EH5Lxa?=
 =?us-ascii?Q?xI6QyooPaAszQrPj91Ehhvrkwe/Kcp3w4oAHT5dwfXJelo6u8kHTy7bcjo4d?=
 =?us-ascii?Q?ONELIEYm3XzSEFQC2EWYt1CFNuwGtV8sju4ZP/wuV92P32Gq8Y1pPSwMsSbu?=
 =?us-ascii?Q?XPLw47kGqU8QgPbYLEf0RrU+WL2Sa3FvOJOHG/wEf9e8G04YLTbw8miENSS2?=
 =?us-ascii?Q?MwQ1XXI+9xS371bSYQ0/yJqZFT809NOzDwM9GkzO6KTS5hly9PHis+mnGN5B?=
 =?us-ascii?Q?u3zqI86Y+7IG5rDRJtzWeKlneYfbIAaEsxIIYtBpwt+FdsonkPVxWkObtxJJ?=
 =?us-ascii?Q?nnx+WBnL4q5+lYrtG3se0YGHh7zKmc7T5ocQyg9/4X/eAKWdnkjM6Xe2XlI7?=
 =?us-ascii?Q?oI24CKtJgIcecymwm7vx+sSi4T4UKhPyAaWz7XRTlVvXM5OYArrI3AW2hRAZ?=
 =?us-ascii?Q?SLWb5+Xjt1ZhRV6vWLA8wwcphyYtwpvd1OLag5/c453M86y/lBIsdOlbtUY5?=
 =?us-ascii?Q?DkvNJfx4ZxlbCuh9oBqQm0yuOIpq8KVV7/fuNjAm2SPQ+AK2Dc8xl32uuOwL?=
 =?us-ascii?Q?AC0K8O8bPQUVqC/MdXgSDm7cXw9z8sKOUrOiRuXSIc76dRht+NF6+4TWrXip?=
 =?us-ascii?Q?9s4uuZ2ghLqiCwDIVTAUtAjUUTDCpVoLUFaDTXyXNZCgtSGyQKULE+YBc+R3?=
 =?us-ascii?Q?ymxS+U2PubjVrKmWmMckDKhTozT0mmuUbtUMYSyJuxALDaiSK+/qA4wNFRJh?=
 =?us-ascii?Q?o7vehPF+h/3Y/1oBBf2CAwSmip4tWKbJHu6X8WefHwAWiuLq+fbcCUj7PMBA?=
 =?us-ascii?Q?B275sketCaScNXE/LlDozV+BZi3wqL08RhBFKzRIzTBMOB/woZeMjZDuMrhu?=
 =?us-ascii?Q?UAutifTA4FAjsURtQqmhFKLiBO6H+n252X4f8bFa6r5NQ11tuLwX0EzK+WQw?=
 =?us-ascii?Q?HvIEkDO7ArCjSncu0CRv97UhDawe667EC/p+0+fZJZNVERiYFnu/NKUA94ud?=
 =?us-ascii?Q?E0JvIf7NUD3WnZfznH6kSAB4cFWsJqVq/NQ0caNp8rPRYvdM9lPEXLNyevWn?=
 =?us-ascii?Q?V3c3GrtJgmX/JaI00PSmJ8SOn1WqBy9vlO4uCnvK/Ob6abkTLdrY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed38ae7-9379-4b0c-0ec9-08dedd6b81b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:38:14.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCsosq0xUjoWNwqIoxnG28EcHRd+pls630BZ/9zD1EBof8mIDxtcGLSkfTyZFKWthKYuwztJRAo0vtrgV0CcT2/KSfrEobazfRdJhXB4SFk9GWBMWQkhlHQqB29EUbzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8093

On Thu, Jul 09, 2026 at 10:30:08AM +0800, Pan Chuang wrote:
>
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/thermal/imx_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 5aaacbc53478..416d89c6287a 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -732,10 +732,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
>         ret = devm_request_threaded_irq(dev, data->irq,
>                         imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
>                         0, "imx_thermal", data);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to request alarm irq: %d\n", ret);
> +       if (ret < 0)
>                 goto thermal_zone_unregister;
> -       }
>
>         pm_runtime_put(data->dev);
>
> --
> 2.34.1
>
>
