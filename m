Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62A2F6591;
	Tue, 31 Mar 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976504; cv=fail; b=cNIeiw2HjJrvnO1OP5+KMNqTd4xjSQu7hv+Cccb7WtEIK492hPu3Wzr3AYsbE+FM5FlejFjr6E4Ab8kKysB3xzwdQ4gYXgC5UGidOYeDO+XmdJjiGTMv6C47ZKbmCjwcj2P54NnVHfCp5xYdCD8a5+kjiH0n20K2gabo538Vrfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976504; c=relaxed/simple;
	bh=AkT3fxxYocUrgjLUYt3tWrET2/gmu+PzMNbQLkijx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GMF7vRqcxxY8aA2ill5ejiwFLRSaCw7KDV1rUkuHGNjBTleo97gwGLyMhV1Kvusx+ZuVuVn4lHc86D0Gxi7TA/l1DmW1JgpHLeXluCEflTF/hp8h8XHxFn9OWW/MZ9ooxncUX8PJvdirufypmzz1gbnhxckpAJo6JFI5L7MQXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJ63KjWF; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJ63KjWF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnCE1M6DD5tFK4VN1lWZmq58aZGDNciFnbiUUpnOz9Rcn9pKuIjSPaIiq6b3H/Dx4fRpYByEptfRUiLTRKMZjYcHuNDBczd8HFxFqFU6n0QsKxTIhDUztX3Q24uhMLroD9vl/uLnMmGT/WhX0/VvljUaAkpJc+565r7WLMNHJDZ6jPf+8osZYPPLYKNe4W7u5QH/PEu/nu04mXPMef/mJiZju3RGx8rZB2ExYFW630xExTIooFlRG8pFlJm1MXPmeSk1rPv0ma5Vlb6MQoqC2QTxNzzHtcrTdZRgbQugc8a4ZM+uiJrl0hExJh092bl2zD5ckSNTALUgNnpm9aQ8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEachX8A59xbnbTQ9NewwCR6uX5mGY3D/ND7LDsFxb8=;
 b=o2h4lI3Nhc3X6HIqVVFkdpVjnB8WvbFkdqepRSxis1OMlG6WgPF7wvG8h4V1IAxeXOs7Mt4l+Y/+BriuEVF4ZlfhvpsSIhk5cIJGLeptpiNfwHTQH3YAVXmxhVmvi/J9E6IgxB4xi8W6FcTSWLQlm271CAbARthdxzYeQfKK5ABBPaYeStcpO/KofL/AJN8eSxcsVUvyjymr8fhNTob41o1XjHY8fpwCPXHsNy03ogpNMfpjhDJQEJOcnnLkCvTxVTrPlf34a//YS6AULI5S27/H8up4BuU5h+xoDMncwnuiwGPlW+MGFrSp1Ddsx6s+tg3OLL7v5U2wNSZ5vnLRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEachX8A59xbnbTQ9NewwCR6uX5mGY3D/ND7LDsFxb8=;
 b=hJ63KjWFme39r/8UmAb+UQdZJoG852VWmSVG96Ms+P4eeFHWRv9rF88kPFxUOa07Qwb8UgpAaS6JK59HzF9zjPPHQDgaT4YnhTWrJiMxupMRlugXhWV3xSOLpr0ALb8Uz3esgbrszyb2dkRdWgcr17jasvAMII6PEVxm1xK+r/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 17:01:37 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:01:37 +0000
Date: Tue, 31 Mar 2026 22:31:30 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] cpufreq/amd-pstate: add kernel command line to
 override dynamic epp
Message-ID: <acv96kz8bdTAv5zj@BLRRASHENOY1.amd.com>
References: <20260329203811.2590633-1-superm1@kernel.org>
 <20260329203811.2590633-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329203811.2590633-3-superm1@kernel.org>
X-ClientProxiedBy: MAXPR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::28) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: f61cbc5e-7e0e-4134-ba6b-08de8f472b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ogCZF185y/V8WPqU6HXHyOKBZbbG/4/IkCprMe3INIgX0l98C+9xlISGHXVtye1CY1iQty/nnrvmhhqjLXnWk5rO56nX3mFFW9lS/W5sdRxKqsKnXoi45FQC0Ne5jpHgJpgGgs3RLSR1PFpEwB/xEY/KNJI7loMYIu16z2lTpc4A3y3pTBnpgwZx0nKgBsqN7DmXW2iPWsBWt8qjgmdWeG8dtPQls8pdgWU093ob8D5WJ3DiEGAxHHtFLegDxzj9DYJpOiccxW9OYjbCtgFTQOBiwfYZRtOvwm7900AcU4mkNiB1o8OD2qNWBHNA6g4J6MuNvU0jxkdolXqGoZLrU1yqoqMJ1pZz14prwnyzwVCBeNeeUp+uk7olicOHHa8BBbLXxRz3NnZywrvvsewEoEkm4tEI05dBtbpgJpnFuKh0LkXLhTPzdA6B4REB4PeKyKqc9xTMOO1BEwWwx5DyprrMbsyJfyN9mjOF8WLrWGuLX5Xg21ngbFHNfxylMd0GE8XK130SpkUQ++3u41Y0ClSTJum63A5FkMhKYXgBDKJr8NG3h0s7pfxk5zI4WcsxB7rPegyTqi6dU5nPOQrgct0LydNNg+FJ+058kkaP1SKmBM7JsGiUbgu9ww2kVmTM9lrknbPBPYtMS6mf2ax6CxjqrQN5Hy1TM0JY8eFNut+XnSDd/2JMsGCXGvxlym424P4tfGajFv84xrt7t9pNPXrBD/Q4yxjbYWZEYu+wb7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ITK8EJ0+fHtSUgk07dehSWl9tHEidkIg/qISRcmENAmWlW0KSJOh6Kx/8f6?=
 =?us-ascii?Q?3RFToek8cKf1zbDI1kStd3dOmh9jQTN6F0pa3W/d+5fYawGDni5YltdbbmCP?=
 =?us-ascii?Q?dxkyuLiMUN6Ex1GxsziJg5cdjFBGUbwP/LHoqq1isbKB012TvYr7tzMTnfhC?=
 =?us-ascii?Q?hqbxoTMA/yp6NMaWFBcEkP71EfOWPNjQdpi5NgpuxzBbHJIAR9TFmkmbRT33?=
 =?us-ascii?Q?gjs4SgcHiXS+o9Hj77XbfQaYoPlmfOcM7lrV07uPFyEVkB6N6QVRFaBGHyx9?=
 =?us-ascii?Q?iRM7SmBoX1SaOf+eP6KvY5arXJQkT80jQGcLI+vhLurndNyBagRJbXShFz//?=
 =?us-ascii?Q?5wkGpMzCRrRhFvidCsbh1b2TPrndJgBH4NrLl7MN4F/T27kJp4qZO5dJm2DN?=
 =?us-ascii?Q?gsxhLeWHpFmkCVKNgzTY7JcR1vwY9cVTF7KaYBCb1Q7VXbh6NCysHH1WPCMJ?=
 =?us-ascii?Q?D1Fe+kqGHeN/HiFgHw5JbD8xKQ4Rou3Y7TsQ1l2dTdX29cqf3Fsu6CBQoYQR?=
 =?us-ascii?Q?DQt3hEnQiV9kf+bSiJfwq3/TicQ4D5FUAzf5nh7lxo31aHOZOCckXNUkM6J2?=
 =?us-ascii?Q?KV5V9RVhtb6a8lHpZahiN4PrE+C2v0PSHzJvhn+ESIz9fTFh4SQ922LjHS6O?=
 =?us-ascii?Q?vrwvhrfp4RxK9J7z1tmeQM7o4XaWzXRtLDgaW8ZdLg8rMZ5xa+H2wxq4LV4h?=
 =?us-ascii?Q?IFBVdjdh0xyNxQINwjITfhkHAD/6VG9wMCsodm0JBPNGHzhxccJEbP5G1Scg?=
 =?us-ascii?Q?knEPgwnVeIVY3w2LoAFFrtFnuuXmmimakWe6zv+AEPuydPTdfLZF0Vd1Wmk9?=
 =?us-ascii?Q?jX0UrOdERyhls+5OwlmwRYzzRLLQeTWGOmSxGDEeEG2IALgN1FACZ90ukT/U?=
 =?us-ascii?Q?eQbvHdSOX7ue083+6fS3yPJptlgH40wz3+uucTzmuRjcDf86wXlI+paZEB0Z?=
 =?us-ascii?Q?ki1eLw1h52pIscCDu1JeT8KVuQ6qL9Fk6SdU7SXf9UnHkY6V8JQHfzjkCOLH?=
 =?us-ascii?Q?6jXgCHOAsWW2s7Nw/FUcx9qUNbaE8CaJFwLjSYZT32k9+/MgUNdaM86vevPE?=
 =?us-ascii?Q?KQp/XEn8sVjVXUvrAGM88dfGvphFevQidrtMl3cDKEVkYM8QjTaoSXDRQDUX?=
 =?us-ascii?Q?LUXceOZHVDK4n0BB8PuQUlItYNDwWLUnhGJuX1mGqaLkdb75LBNbApATJ9xP?=
 =?us-ascii?Q?Aj5LPbrAXyYKfWMbJ/vzA3TxoXugJqmINhNC2qWySeVsSSVniLe9HZ+1v7IX?=
 =?us-ascii?Q?R/pcxMCrNlAsamPEd1WL1vKncl74WwYb6pdrJO4YZfLJscbyI4Jk0kRhppHD?=
 =?us-ascii?Q?HsE6JUXTEFIyIKo6zaDKKbHdkr/jDCE1Y1sLwzZ0V+/d9f9rgZoa9neLqfjr?=
 =?us-ascii?Q?NrYceYKPvSHB7UKeTC9ltdJmgXEQQv3Xf5kq5+mlrIfqZd3/9pOoVPlpLGcj?=
 =?us-ascii?Q?q2VjTOBCepOLEylSExTouYoMbX2rD5Z5c/7QAUaV0KLggKSo4MsJMYjL+lAA?=
 =?us-ascii?Q?d/uloITzcbDZVmmqosJPyTMhr6bUd2kE1MqHSr71NrY8RX3rDKFpbOv+RvEh?=
 =?us-ascii?Q?U5ppH0s3nho+ZWzs/zkYC+w5dM/7GnnTxoC3n4zu9uGnTzpquJBrkqvs/sTX?=
 =?us-ascii?Q?i7YNKGvskQwRUlmBGUu7d1/M052NdTG2NDtfMmGJWqv1quuPz1tlpa3/2VwJ?=
 =?us-ascii?Q?IBLDMmtKqQ2CWLsZZmAmUDkxl8nowhpu75srP5IvVqZnCQyA4GvGRdWZsgwa?=
 =?us-ascii?Q?B3fywOcGDg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61cbc5e-7e0e-4134-ba6b-08de8f472b96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:01:37.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXjXaWNfnBuATr58PC6k6SpDWstghnKX30LHGfzrEByfZYmQnnWoxFkzJv9+kriKbutO5/7EMUr3TVn5K2ftig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

Hello Mario,

On Sun, Mar 29, 2026 at 03:38:08PM -0500, Mario Limonciello (AMD) wrote:
> Add `amd_dynamic_epp=enable` and `amd_dynamic_epp=disable` to override
> the kernel configuration option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`
> locally.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

This looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


-- 
Thanks and Regards
gautham.
> ---
> v5->v6:
>  * Fix the amd_dynamic_epp kernel parameter name in amd-pstate.rst
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  Documentation/admin-guide/pm/amd-pstate.rst     |  7 +++++++
>  drivers/cpufreq/amd-pstate.c                    | 11 +++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a550630644f..9552819051cd8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -493,6 +493,13 @@ Kernel parameters
>  			disable
>  			  Disable amd-pstate preferred core.
>  
> +	amd_dynamic_epp=
> +			[X86]
> +			disable
> +			  Disable amd-pstate dynamic EPP.
> +			enable
> +			  Enable amd-pstate dynamic EPP.
> +
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 0e4355fe13558..210207d301aa5 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -474,6 +474,13 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>  always be advertised by the platform. But OS can choose to ignore that via the
>  kernel parameter ``amd_prefcore=disable``.
>  
> +``amd_dynamic_epp``
> +
> +When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
> +autonomously changes the EPP mode. The default is configured by
> +``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
> +``amd_dynamic_epp=enable`` or disabled with ``amd_dynamic_epp=disable``.
> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2e3fb1fd280a0..e96f1da5c7b38 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2224,8 +2224,19 @@ static int __init amd_prefcore_param(char *str)
>  	return 0;
>  }
>  
> +static int __init amd_dynamic_epp_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		dynamic_epp = false;
> +	if (!strcmp(str, "enable"))
> +		dynamic_epp = true;
> +
> +	return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
>  early_param("amd_prefcore", amd_prefcore_param);
> +early_param("amd_dynamic_epp", amd_dynamic_epp_param);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> -- 
> 2.43.0
> 
