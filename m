Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525A4B404D;
	Fri, 18 Sep 2026 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721387; cv=fail; b=H5H+APR2CWLSuSMfEygTERxmYCgXqo5J3c26ZU8n0ztrluxjypVOIDj1cXgE+YWiwPof4Z+DpUnL60mPYoNTETfq/tcVH0F4TuyM4sGllPo5XSbTUWyXPZkDjhsGNU/xtvWSeJW2cCiTOJE4cG25Vtnwe6FMOOdbxlA2xx9wl8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721387; c=relaxed/simple;
	bh=tHyYJo19+DWKA9r89Jif1Ef+VBZeK85rlZH3/HDs3yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=btNEkxWwFgb71YW1So4pvpWQwOcKBlCItpCriM3MYa3qkA3CU5+xhg36G9QtwuApq/M3/pD2Lncz1vLBblZgUq1Bd2w1OJn7Ufy1w3VrH39fFqAFL0GaP9DLiwRLiIihBo7G1R2lfjFHL2NWekGSkdYn0Lgbo5VS9V8Eikt38SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=b3QGZVvl; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="b3QGZVvl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZJo6eWjE5I/gNzVsBob62izldljXxQYgSeVF4A76bWT71JAKuxp8K06CTFyUtZosG6bn3rBc4R3AYRNhzR5ujUsfWPmtetSaSkJ/DKmL6mFjRAeYKchzYE67Icps9u4QFpzuQDWU7zxG8Dyp/YXELeC6ExCf7S09iBMGlHqVKTJIMa6xDCCd3s2knqlDO9srJXmf2I3vpO6T0QEqJIQwbDQzCRnX6PUHLLCjQMa8oLQsg91Y1e8mPsRln5Aqzx0mFBXqCrQ82xjP6cgBqEF4zR6U2Az/+rXmkchJpbC1Pp8+CFs2Gkwv7IbLS5OnZJ51LfdCZEbKT9Br1ky7TnVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqdMHQBzAluLCDDANsE6LWi0m/ZRN1c/5WSU/24dE8Q=;
 b=DfvZhl5B/yEx72oTTtMASebbmtD/1b8SKIzESWC62HZFjgnXGcU8ZoobAMEJ8EekSfFmqdJrdwh6FQJsj241Qxy9naBovUtsj+kYtpKLsmEtX4g0o9sirhhjqLk1e1YXA0dTAEtZXmvwWaStzaSBAm+K3I1uDrB+C+WDVDK4xLBhpkFL3VHg0tVGVdBJ7EA/rlO2L8yjpVfsNi8lbx2dhyB2/9Oka4Khl+azmW7VlW3gEs6IfqcBSN/uFwrP2c1vy8K28En7e8UciW5vB36hXYPOrlsPak3c0EuonL7LAC3OgLN4LUEYtqKzoIZ1ywIWeyRH6HY99RHf4jA6tbjkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqdMHQBzAluLCDDANsE6LWi0m/ZRN1c/5WSU/24dE8Q=;
 b=b3QGZVvli49bkn5jmdXQ/dLX74mGUlP8puF6CIO+KMkT5cuoocAN7SV0cvbtumq4FdBLcSh6gcNjs3ctH7cYj0Q9dlnauZJQz296tc+K8QEMloiBP6MpznaBr9lD52VMwwettZFK7dCk/lbMEzjNHPq6Hw4w2VzVb4yXFtKBOw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by PA4PR02MB6862.eurprd02.prod.outlook.com
 (2603:10a6:102:f5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:49:38 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43%2]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:49:38 +0000
Date: Fri, 18 Sep 2026 10:49:36 +0200
From: Henrik Grimler <henrik.grimler@axis.com>
To: Alexander Svarvare <alexander.svarvare@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] power: supply: bq27xxx: add model name support for
 bq27z561
Message-ID: <20260918084936.GA1531069@pc67698-2615.sto.se.axis.com>
References: <20260814-alexander-laddchip-patch-v1-1-1624d6725108@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814-alexander-laddchip-patch-v1-1-1624d6725108@axis.com>
X-ClientProxiedBy: BE1P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::11) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|PA4PR02MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a54633-e7d9-499a-0ea4-08df1561c552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VI5JUpg3goBjUubUpI4NOtCCOsFnUpz0fk6WrEm2RGytKP2v2JSYK7IJeJ/Q1hDxJAwCrcrEVp6+fMKgVNqzMM11LRLKY/q745jS2W9jLBgYMNvRguueVKRB6vich7IK5UnrAEUg+DXdPhCaLJ36XPzRZfxDuuumQDyFN/HEElAzVBUPVdgDXYnnOAOqMKJF4L4yCOMOlaJ3/vo4rwgc+7SdSFM80TjV1uwUxpMkNICQTZuIZUQwqSIBABNNz+C2k/CAItHR3NDrV3r2gqKvbYmYF9xjpN1UM0iQflVLxJ98fISh8pko4b9C8jtWFl+lrsGPmvyzLmwHccMHCuQhwCqxtwH0vVBdWGEmzOKs4hto0zDxw3mUq1QJcCks0YIJ9vX0I7+vze6qyRIOTbzQSydG4RfEuEwvW6g6CoeOnR8+cHjh7MgKxMgD92goDsegiD+uLR43iximR5gsFLzS7JXU2P7SYPxwN0aC35ZiZdZeix3LfPdEHeSO4UoV+Rgm8BHb60qZGFOmruMEJZhisYvL4Ech7gEzj4JJ2jCL+aGW+myF4VNK7XAkqJ84rLDTHXrowxUwBGjCXC35adLCH7HXuJyYnH+BCXnUxJi2g7wqqmPNgHmMmof+jJjydxqM7dy7Rw4ycGvH2OAzv1LxPehj0cxSvbf4A3P/Pc/9e/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENINXZCYkFKeWJQZzdnNU00c0lDUWIrY3hiVDd2bXNTNGZTd3hVRXFlcXRW?=
 =?utf-8?B?UnUwK0dwMTUxRGtHeUZiY1c0YmlMUWFLTWpVOEdvUkpTZzZSbUdRb1EydkFT?=
 =?utf-8?B?SFN2U2JBenJHVFFkOEw4eWpHUllZTXBxTk1MZk5wbHJ3bWFhcVVxVkZBVU8x?=
 =?utf-8?B?QjRIOXpIdkFEbC9RSVd0NWxLb243eUZMZlBmZ3BDcXNsUW9aKzJVc2YwVVhl?=
 =?utf-8?B?YUw1QkRJS2g3RU1DRWMvTW9SOS9UcTF2cWovNGsxaVU4TnRmN2NlWWdZcGRG?=
 =?utf-8?B?NE43MXVsVVVzOGkrNUF1K0VSSG9sTUxmc1MrL2ZXM1pUTDljSGN6T1FFdFZr?=
 =?utf-8?B?US8wbWNiVGVIQ0h1Zi81dWlWclJYQ2NVZ2dnN1BMMUEvQTF2YXNITGVFOVNh?=
 =?utf-8?B?NXcrWmlGNGtYK0ZGRjNaM2k0NWlwNEp2Mk9CMkpONXdETlNEZ3RVWFBDTnpy?=
 =?utf-8?B?VUdMVmR0QzU1a3B5Nkp3bVRqU2ZBSWY0Vit3ekFONXFwSWJlcnpmU0N5RjBo?=
 =?utf-8?B?QVhRRGg0SWNZamcvUU53SVRLZWlDRHliclJ1L0p1M2pOVGYwbm0vMnlIWjJt?=
 =?utf-8?B?RWFWK2hLalpVUnhsYW5TWlFZN3NqNVdoTWd1aHI5MzFweGFGaDVPRkc2RGNU?=
 =?utf-8?B?amF5eG5oa1Nsbm5HeWNWb3FpYnQ2ck9GYS9vcktHN2hkT1RyTGx3VnRBMENW?=
 =?utf-8?B?TDFnQjNCOUhsRzRHU3dwQkNhVWppdjZIRTVnZ0NXTUdsdUZvS2wzMEllQ0dp?=
 =?utf-8?B?dlZpOXBWSDdRQTVJbUFNQlY0RjNnbWdDaHQ1ZkVZbEhTZkRabDNBSElvcUFY?=
 =?utf-8?B?dGNRcDAwRWFkSjJrSDJaOW1HZCtEVWUweTNjVFFVTGEvaUlOeXdkME1PRHN0?=
 =?utf-8?B?bE5tekhQZHp2bzhzU3pHTmNQaVRsTGlqV0MwQmh2Z0tnWlJLMW9vaHlEVUhB?=
 =?utf-8?B?UllRZnI2WWZ2NVJIendCZ0xVSkVwOTFqZjR5bGRuaHhnQVhtWjN5TC84RTdS?=
 =?utf-8?B?L09UKzFTWVFjWGxYbzUzc1dsTXhuV2pFT1Z0YzJuamN3QUlZc1VOOEtKWmRP?=
 =?utf-8?B?TWdTUFZ3c0s0d09rU1ZORlp5VkpadmYxN1VzUEgxSTlOd3dLeFpISmE3NGVp?=
 =?utf-8?B?T3A3TEt4aWtLS2RMK1ZNR1ROa3ZkWUZWY01GQjRsSUxsU0pXVlZ2UUx6K0Fp?=
 =?utf-8?B?YkNuNmZ5MkNXVXIzM2t6WWtoMXEyRmphVmVRMUhnQ3BicjRkdW9HNmIza203?=
 =?utf-8?B?ZkdrQjNjNEFhK1FySXRBQm04V1ZxaHRJWXBIWkc1UmZpNkxLV1VkRlBsWTEy?=
 =?utf-8?B?Zk1PNndoVkM0U24yUGFpZUN2UVh1VXpIc09GbjM2NjNwR3R0dmdHUkZEallI?=
 =?utf-8?B?elllVGY3dllPY096bUd0TUVmZndFdHlicGxDK3NtcWpIYXdzVnlKYVpsb3ZQ?=
 =?utf-8?B?bVRXRjJGUzFFY21VNFdQYlNCczZGUGpHQmkxcGhnTmVTbER0d2NpL0U2N1FS?=
 =?utf-8?B?MGFCc2tEQmhvZjAwU0QwTWpRUHlRZ0FXRVd4R1RUVzZNaUIyZDFLVW95MzhD?=
 =?utf-8?B?WXhLS056OVZ0NXByWDZpMkhwQlVrNCtEenFxSjgvVFFTdVZPMUxUWitnZHpx?=
 =?utf-8?B?UnVjSnZldEJpY3ZnNTgyeFZiNU9pVjdUZTFSVlgxU2ZMQ29XZG9HcSsrV0h3?=
 =?utf-8?B?T2ZDd2o2NnhUR2U5WjhQdG5VMlFFVUxwbUZYZVAveWgwRURMYVVHR0RKaG54?=
 =?utf-8?B?Ynd1S1VsVTFsSFo0QTdJK3ZnWDVLVU50ZEY1K1Z4UWh4SHNhMXFrOUphT1dG?=
 =?utf-8?B?cHMyeEVmOHVMSWN3RkFLbU5BTlFYSjlHcGErNmlKT0lRVkpDTWl4UlVkdStj?=
 =?utf-8?B?L3Nqa095NWJVUmxISk9qQU5KVkxtQ2VVZ1Z2WGd6ZW1TUFZobW9Kak5JU0tF?=
 =?utf-8?B?cnl2bVVjV3VVNisrVWJBRjRqN2ZmN1g2K0NWV1BGUWs4ajBUSVdCY0EwcGUy?=
 =?utf-8?B?bGo3UGV6aWM0NlRubW1SVXV1aURoZGVRSW5yTGJqRlg5SnVBSmtxcVlTRFFs?=
 =?utf-8?B?VDliSGVUWCs1SUJoME5BYnAzNHJZMEUwaWpid0N1Tm93QUZhRHI3SU4xUjJ5?=
 =?utf-8?B?VjdybnRoMTZtVHlMZzY1cEsxOFBVWmpBRGdMQ2syZ0ZEWTFvKzFzME9ORjN5?=
 =?utf-8?B?U2sraDUyc2tTa2tUeEh5Y1dzTTJOcmh5bFpsV1JGZ3lMQ2V2L1AweWsvdEZi?=
 =?utf-8?B?SE1vNVV6ZFgxdm13bWVSMFNBQW1jUFBaS21LWmdQUWZkZEpIYnJ1aWRiVlJS?=
 =?utf-8?B?ZXFRSUpoKy9GdEZuNUNMc1U3QkxSbTBBbXFxQ0tmQis4akNpVml3UT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a54633-e7d9-499a-0ea4-08df1561c552
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:49:37.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzuPDSCK0DGrCrBcTlx7Zd1XQaK103ZKeE8XzUf4oy5eY0e70FrcxjKRAJ0o1edJPnLEg1jwvnzNK0M7D996FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6862

Hi Alexander,

I think we can take this patch for another round internally, please
see comments. Sashiko also had three concerns that seem valid to me,
please have a look.

On Fri, Aug 14, 2026 at 04:05:58PM +0200, Alexander Svarvare wrote:
> The bq27z561 fuel gauge can report its device name via the
> AltManufacturerAccess() (MAC) command 0x004A. Expose this information
> through the POWER_SUPPLY_PROP_MODEL_NAME property.
> 
> This allows userspace charge-management daemons to make more intelligent
> decisions by being able to map battery pack to datasheet and infer
> additional useful battery characteristics.
> 
> Other power_supply properties can be provided through
> AltManufacturerAccess(), so implement an interface. Make it
> modular/flexible since for other chips, the same MAC-command
> for retrieving a property may have a different numerical value.
> 
> Serialize the complete MAC write-delay-read transaction for concurrency
> safety, preventing another command from replacing the pending response
> during the required delay. Keep dedicated per-device storage for the model
> name to preserve the returned pointer’s lifetime.
> 
> Hardware-tested on BQ27Z561 using a backport to the product kernel.
> 
> The model_name property returned the expected value.

Great that it is tested, and worked, with the backported patch! It
would be good to test with a close-to-mainline kernel as well, as
there might very well be some regression elsewhere that affects the
patch or driver. Let's talk off-list for how such tests can most
easily be done.

> Signed-off-by: Alexander Svarvare <alexander.svarvare@axis.com>
> ---
> bq27xxx fuel gauges (FGs) provide most of power_supply properties by basic
> register reads. For the remaining properties, they can be read by writing a
> command to a buffer AltManufacturerAccess() and reading the result from
> another buffer MACData().
> 
> Since the release of bq27z561, six bq27xxx 1-cell FGs have been released. 
> Three support reading the model_name in the same way as bq27z561 while five
> provide properties supported by power_supply.h through
> AltManufacturerAccess(). In addition, five specify the return string as 
> 2 bytes echo of the MAC command followed by the string. This format has 
> therefore been hardcoded.
> 
> *Some* properties (varies) provided in this manner which are supported in
> power_supply.h are:
> model_name, manufacturer, serial_number, manufacture day/month/year
> ---
>  drivers/power/supply/bq27xxx_battery.c | 95 ++++++++++++++++++++++++++++++++--
>  include/linux/power/bq27xxx_battery.h  |  5 ++
>  2 files changed, 97 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 45f0e39b8c2d..2a24eaf1aecb 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -93,6 +93,9 @@
>  
>  #define INVALID_REG_ADDR	0xff
>  
> +/* SMBus block transfers are limited to 32 bytes. */
> +#define BQ27XXX_DATA_BLOCK_LEN   32
> +
>  /*
>   * bq27xxx_reg_index - Register names
>   *
> @@ -833,6 +836,7 @@ static enum power_supply_property bq27z561_props[] = {
>  	POWER_SUPPLY_PROP_CYCLE_COUNT,
>  	POWER_SUPPLY_PROP_POWER_AVG,
>  	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>  
> @@ -1010,16 +1014,39 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
>  
>  #define BQ27XXX_DATA(ref, key, opt) {		\
>  	.opts = (opt),				\
> -	.unseal_key = key,			\
> +	.unseal_key = (key),			\
> +	.cmds = &bq27xxx_no_cmds,		\
> +	.regs  = ref##_regs,			\
> +	.dm_regs = ref##_dm_regs,		\
> +	.props = ref##_props,			\
> +	.props_size = ARRAY_SIZE(ref##_props),  }
> +
> +#define BQ27XXX_CMDS(ref, key, opt, cptr) {	\
> +	.opts = (opt),				\
> +	.unseal_key = (key),			\
> +	.cmds = (cptr),				\
>  	.regs  = ref##_regs,			\
>  	.dm_regs = ref##_dm_regs,		\
>  	.props = ref##_props,			\
> -	.props_size = ARRAY_SIZE(ref##_props) }
> +	.props_size = ARRAY_SIZE(ref##_props),  }
> +
> +struct bq27xxx_cmds {
> +	u16 model_name_cmd;
> +};
> +
> +static const struct bq27xxx_cmds bq27xxx_no_cmds = {
> +	.model_name_cmd = 0,
> +};

Rather than having one struct with all 0 u16's we can use bits in the
opts variable (and save some memory) to indicate that a command is
supported. We could add something like:

#define BQ27XXX_O_MODEL_NAME_CMD BIT(9)

and check `di->opts & BQ27XXX_O_MODEL_NAME_CMD`.

I looked through the reference manuals for quite a few of the bq27
chips, and all that have Device Name among the ManufacturerAccess regs
seem to use 0x004A, so should be safe to always use that command for
that opt bit (if some future bq chip has another command then it could
use another opts bit).

Best regards,
Henrik Grimler

> +static const struct bq27xxx_cmds bq27z561_cmds = {
> +	.model_name_cmd = 0x004A,
> +};
> 
>  static struct {
>  	u32 opts;
>  	u32 unseal_key;
>  	u8 *regs;
> +	const struct bq27xxx_cmds *cmds;
>  	struct bq27xxx_dm_reg *dm_regs;
>  	enum power_supply_property *props;
>  	size_t props_size;
> @@ -1051,7 +1078,7 @@ static struct {
>  	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
> +	[BQ27Z561]  = BQ27XXX_CMDS(bq27z561,  0         , BQ27Z561_O_BITS, &bq27z561_cmds),
>  	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>  	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
>  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> @@ -1220,6 +1247,60 @@ static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_in
>  	return ret;
>  }
>  
> +static int bq27xxx_mac_read_string(struct bq27xxx_device_info *di, u16 cmd,
> +				   char *name_buffer, u8 buf_len)
> +{
> +	u8 mac_data[BQ27XXX_DATA_BLOCK_LEN + 1];
> +	int ret;
> +
> +	if (!buf_len)
> +		return -EINVAL;
> +
> +	/* Serialize the complete MAC command-response transaction. */
> +	guard(mutex)(&di->lock);
> +
> +	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, cmd, false);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to issue MAC command: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* 66-us AltManufacturerAccess() wait time, use 1 ms guard */
> +	BQ27XXX_MSLEEP(1);
> +
> +	ret = bq27xxx_read_block(di, BQ27XXX_DM_CLASS, mac_data,
> +				 BQ27XXX_DATA_BLOCK_LEN);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to read MAC data block: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (mac_data[0] != (cmd & 0xff) ||
> +	    mac_data[1] != (cmd >> 8))
> +		return -EPROTO;
> +
> +	if (!mac_data[2])
> +		return -ENODATA;
> +
> +	mac_data[BQ27XXX_DATA_BLOCK_LEN] = '\0';
> +	ret = strscpy(name_buffer, &mac_data[2], buf_len);
> +
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to copy MAC string: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bq27xxx_get_model_name(struct bq27xxx_device_info *di, char *name, u8 len)
> +{
> +	if (!di->cmds || !di->cmds->model_name_cmd)
> +		return -EINVAL;
> +
> +	return bq27xxx_mac_read_string(di, di->cmds->model_name_cmd, name, len);
> +}
> +
>  static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
>  {
>  	int ret;
> @@ -2206,6 +2287,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_HEALTH:
>  		ret = bq27xxx_battery_read_health(di, val);
>  		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		ret = bq27xxx_get_model_name(di, di->model_name_buf, sizeof(di->model_name_buf));
> +		if (ret < 0)
> +			break;
> +
> +		val->strval = di->model_name_buf;
> +		break;
>  	case POWER_SUPPLY_PROP_MANUFACTURER:
>  		val->strval = BQ27XXX_MANUFACTURER;
>  		break;
> @@ -2243,6 +2331,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
>  	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;
>  	di->opts       = bq27xxx_chip_data[di->chip].opts;
> +	di->cmds       = bq27xxx_chip_data[di->chip].cmds;
>  
>  	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
>  	if (!psy_desc)
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index d56e1276aafe..009ccdd6395a 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -4,6 +4,9 @@
>  
>  #include <linux/power_supply.h>
>  
> +/* S21 Device Name holds up to 20 characters; reserve one byte for NUL. */
> +#define BQ27XXX_STR_BUF_LEN      21
> +
>  enum bq27xxx_chip {
>  	BQ27000 = 1, /* bq27000, bq27200 */
>  	BQ27010, /* bq27010, bq27210 */
> @@ -58,6 +61,8 @@ struct bq27xxx_device_info {
>  	const char *name;
>  	struct bq27xxx_dm_reg *dm_regs;
>  	u32 unseal_key;
> +	const struct bq27xxx_cmds *cmds;
> +	char model_name_buf[BQ27XXX_STR_BUF_LEN];
>  	struct bq27xxx_access_methods bus;
>  	struct bq27xxx_reg_cache cache;
>  	int charge_design_full;
> 
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260625-alexander-laddchip-patch-4b565f9844cb
> 
> Best regards,
> --  
> Alexander Svarvare <alexander.svarvare@axis.com>
> 
