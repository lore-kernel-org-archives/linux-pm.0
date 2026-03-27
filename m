Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545253BF69A;
	Fri, 27 Mar 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593976; cv=fail; b=YYvHhJ8b9K8HTBduCJtgxIHWrgSg1uq0oRb+ghlfVC0CpKfXFyWBJlgEn6O3dyJb3JrO2+y2hK32FLcjE+9WDVwzyEz4LdVoZUraYUXNciadGpXs2HaJqzZ9bzSQjD1ThHFxL7DLq2q4IW8kJIS1EE0pqQVq8xSXE5UrW0rdWSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593976; c=relaxed/simple;
	bh=ooLK2sZV2cw5dfA4aDJwJe9CdB9Mkzva8JkYJaQOjpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZDhMR7tl4lfv10SsAC+hwtTvmk/9N/W71zxZDKNDqgZSTAU0lWOZOrekVw+uFPzR83/RC8+qg70bgaKe4kxjj/R8MUnwrjYRHanpdsmrzocPj/SnfZ5EWV+hO/WQy0gt4dTWGzzaV2fk6OAdFVzAkinYSUQ5vImdy8WhIinqj/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N1+n1DuN; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N1+n1DuN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjowD47OeFW6hB/whjbFPN7GLBLb3YamfzGnTfpFuVd6vuTsstcLeeIoYutO6CfXGqj/Ypz6DewfxWlNK+ZepnTBT1Y5yzXKAqwsx6Fx0bgTCx1DE+DnrlmUGaHRlpWegWEAGAoJHF1x1NiP7sFtCeyNFf5nft7j2wN1fOltO2fvI0hlXK1qyaKqOmjzIKOQWT+z97DafN7ZRIP5XmQOv9CpJJI7mIqC58RFeiNpieChJsgHuVE2yk06wuc3/IGhQ/qxjPNwI3PC/nkHiJO4DJ3qqZOXhSnviSvbWdeS6p4an4WUqKUvw6N0bwixGYgS8/S5qG+BRPl2wvCGwQocsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CidGQT+KhgfyWXz20FdnwHcRfXnX87rGC5PBMtB9kNs=;
 b=ruwyFKjds8dAcY5/eXsia4bAOCZFUC/EYjotctTO1GAPTT2/dtxh4bmuqDlLjlpCconziaXhnUlLvCODMy5Fk1rOhPiMMK+P+kzj7Tiq1XqKjPeXvY5evXD2nXXkeH7idcx9I/xBvKj0HxzZcqjzenXjQgvVQ+O3vD7TnbmIn3GB5W4UJjm5mH2Y6qLxviNLlC1zTKN9Z+yXEK2WneOSzbmndB//E3SuYZhH56ty+ove5+AvyShdnJfrOY7tORGv4MGbsZe9dIKJROfOBffLWE3tb5BxqnK6Rz3sHA4CiXVBDLCbTykRNiJ5N2hzt1rev4R4tJKwrw6vXJBtvaWjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CidGQT+KhgfyWXz20FdnwHcRfXnX87rGC5PBMtB9kNs=;
 b=N1+n1DuNPSruszi4C6SI08qdLEO7RYxNw1DOE9C9z62rePjsJocMhYXPzREFmKeLKfg2I64JlIGjVCHeL1++Onc5FILJ5A5kHAtI/+qYO4IYM++3KyA3aSf+lb3+sIgNEq9Kju+IamU42voJO0GlgxXWk3WsUCniWWHrH33rZsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Fri, 27 Mar 2026 06:46:01 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 06:46:01 +0000
Date: Fri, 27 Mar 2026 12:15:36 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 2/5] cpufreq/amd-pstate: add kernel command line to
 override dynamic epp
Message-ID: <acYnkDqC+v8AYc+R@BLRRASHENOY1.amd.com>
References: <20260106051441.60093-1-superm1@kernel.org>
 <20260106051441.60093-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106051441.60093-3-superm1@kernel.org>
X-ClientProxiedBy: MA5PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: f8315165-2472-4270-8876-08de8bcc8286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j1ASWcgOtC3iwuo19eXh9pmgHV7dLs0G6ZA9I9A+WNPdAyF46AuljD36q2G5l5tV0H9HwR3DboNUIiI5/W2DtMigc5Rp/QGBAr19TKEqX5EUvOLDemRQhuGtDSYtt9u2rTOvN5dd23PqCjLxS6Xsb2Q07gjQpsnJ/AoCCoQ4afUUanMSswLZgVp5Cd4I/IzuR66sI66ymL/q4g0C+0+QOOwNXRzeGNKDsQnDjTLXifMm2HDy48TC97JMkTrosD63+FXQnwM8fiB9rFB3ix7HxigD6hsK0xMtX5yaD0qRNaxZjXUcgO+gWg5SE75jTXpsPZ7Pc+px+qvR6mNwvHkwTDILcRWsq6Z5NENzxcoJYz1P8er8+RMKK/ZsUP6Ng6qhi98umqjjnlbLAeB6FQ1HrAn8+C1smSOmtpNdFh2s6YgIMq9F8btR/JYBky2TQFJ5fTGhhaxGD1McsgbilAkwzHplBi7E+nuZ7uJ/Re6xBroAuwGlHPus7xt0yst2aXqqHRrDq5nlMMi7nN0OpocbfxWyQrt0rxwLqcaMkTo8J2XCp06JYj62RWfjqp1I5eeev1qz0X0c34FPO2G/LQV8GZfYkUa8ksNB/vX0uuagr0ZZscwKYRbuQhda8DI1sCQzwrK5bs6rQ2KYQQUTomoS02GQICqbhQNIFqFlseinmoYje2z3NGmO8BhJ4MIEHikqJV1QEg+vUTywBX43RvKYpPX5/YfypSspsDyiEw/O8co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqc3VWSq1wPh8RDNatREjOr8mqDKhl9hXSMCDyX2fPezeBchFYH612HvOqFD?=
 =?us-ascii?Q?MdQsxBqpW9k/FAFEdT5ErV9Sz/a15+NJUPZyExLv/LfPd5rQoT+EtcPxv27r?=
 =?us-ascii?Q?lyUgseQQPnWf34MuV5Wmi/iwJSXHysRRRPD8IR+SO46hbj/0/RlVOMK+RsDh?=
 =?us-ascii?Q?njyyIRnle+PySuCUBADubWkI4AlcGlf+MQKGn4gJrzeCPrV41C5e+2b9EgDw?=
 =?us-ascii?Q?cYdmQP9qU0BgFbiVcV6zVEjskZwZxtxwIPPR0+VctQvGoGMmZ28WudDjGgER?=
 =?us-ascii?Q?5s0WXF6jOYtsxGKsn6RVlpRNhIORnGQz0Z5YHy3F2qntg9AuxfbtC72Krg7U?=
 =?us-ascii?Q?DwEYjVlvTVRrz8bDwB7DigS7WRDj/3wuzlsOREEDnK2S8+bRxvCo78R0GLLm?=
 =?us-ascii?Q?JZ8jD2+NpcCjUvpU7mrvFgRzDDzUeHj50wEQXt6lw8S4bSW8R1gaQcDqBMbB?=
 =?us-ascii?Q?zbdR1icwka9B2q67PcNXiYeIkCp2QkkZrWVl5m25DsreLroniRg4x0r22qwU?=
 =?us-ascii?Q?bJp+SeNWQJmmaZIFFQKD1QrhE6WQs5jhLR3EwzKCAYuok+ij73wSaK54mMIO?=
 =?us-ascii?Q?HR2mDB9mHgmn2ZWUflWbwowtXqDBjGxR3rDk18pGSPKkV62j+HxZfVCZ85v/?=
 =?us-ascii?Q?j0bMB6TdPXlOQc4PpfjU4PqSQJsDfBW5oFnZJDa8tmrm6FXuqC9HdQs7C6Cr?=
 =?us-ascii?Q?d2x4gkjbIL1bB5prIosgOxgpSMldq6eENu9yNsRFJAsHg5pQSx5968pyMeS3?=
 =?us-ascii?Q?TwRSsHSc5/bH0m7Tsa9b22xNsTtJM9GhpPZfObJbkiVBsuIZXGTf69qa7oj/?=
 =?us-ascii?Q?OoS02vdmzP3WLZzf/TL7SK6vx+9aEWp6bx/SQRYXrA7MIzEAr5MKpClO6ZL+?=
 =?us-ascii?Q?dhg1L4Q8K9sC2lXRNrMvsEcUwo2pBdvcBnu2jkGeDfoqDQxzIQDkoH/V2D8C?=
 =?us-ascii?Q?3xhCU9T1WjjRT0hNcn+k3Q2kYZEsKG1vMIutQCT3DLnRti/iM3fJ4miN0+Vx?=
 =?us-ascii?Q?nV6JNwE1bVBsRf+BiUj8S/wXkXpyt6fd1Va+vf7NH7jCmlQWqQca68cohstV?=
 =?us-ascii?Q?H+4k8OxZZyO065fdWBg83YK98nCpvhIDHU2btdBerBvDr45zRpSKU6JaHe6x?=
 =?us-ascii?Q?nqfCKDHM4Wxt/KmhVnvZEoqs9+3x9KoWjjrzA0XBfaFJ/CAgZSBRvGIGJ8g3?=
 =?us-ascii?Q?WvC3Vyp3Z87vA688/rL10O8+v+RhLr07Bl/5Ylg7TsozAK0brknbsWvhFKXR?=
 =?us-ascii?Q?bLXGDXbi+zomed0uXwKxb4Em2Me/9P5KW3Sotyoqy8XbCRbXxfZ/AHeolPF6?=
 =?us-ascii?Q?L+ADH4RndJo9PY2d9kQhDSx2jAM6uniPuEiGN5PF5nWJGxugvux297HdTv3Z?=
 =?us-ascii?Q?eeMf9NMd4K/hKdhlA6o+XBqXDSmbpOFtcBc35vaF+/k5XxUJcU1I1sB8qMeP?=
 =?us-ascii?Q?zsU6gtBqth84HvAsGeD1Xt9K437L9yDAetdENsbqIgHeURboBy/h540HnSJm?=
 =?us-ascii?Q?0ff7Rb3DXlfxk7H2KD0xNUtj+KKMvb7Fdw+HevX1CX+KrIxQGLaRP33eWd8v?=
 =?us-ascii?Q?3Yo/8XzSFsnIgqWBHL4GNS9s8ErMMFDEHSTH9aHO9ef7/slCunTtMWNTLhKK?=
 =?us-ascii?Q?2z/5FJPeEjtNAYVKyEKtaRaC5GCUOyjiuk0ZT1nkUON3N5A5zxQ+3cFlA7TU?=
 =?us-ascii?Q?OorJMFi6KTAVy/tWlK9YZWoCS9JVoi7iqAAOyRiDkiKw6XLNTVx/XRhkTwWi?=
 =?us-ascii?Q?T1SYIcZXAw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8315165-2472-4270-8876-08de8bcc8286
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:46:01.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af1G4lHqixF0b5B8kHvC99gX5F6GsVWgMriP0ACmnJ5OokDpFyJ9LgEVaCr4RLZYIfnZPSzyb9qP1cDvbB1tiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

On Mon, Jan 05, 2026 at 11:14:38PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Add `amd_dynamic_epp=enable` and `amd_dynamic_epp=disable` to override
> the kernel configuration option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`
> locally.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  Documentation/admin-guide/pm/amd-pstate.rst     |  7 +++++++
>  drivers/cpufreq/amd-pstate.c                    | 11 +++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a8d0afde7f85a..d7d547bbda430 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -490,6 +490,13 @@ Kernel parameters
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
> index 5aa9fb77a078c..df4607b6a5f62 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -438,6 +438,13 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>  always be advertised by the platform. But OS can choose to ignore that via the
>  kernel parameter ``amd_prefcore=disable``.
>  
> +``amd_dynamic_epp``
> +
> +When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
> +autonomously changes the EPP mode. The default is configured by
> +``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
> +``amd_pstate_epp=enable`` or disabled with ``amd_pstate_epp=disable``.

Do you mean amd_dynamic_epp instead of amd_pstate_epp here ?

The code and kernel-parameters.txt both use
amd_dynamic_epp, not amd_pstate_epp:

drivers/cpufreq/amd-pstate.c:
    early_param("amd_dynamic_epp", amd_dynamic_epp_param);

Documentation/admin-guide/kernel-parameters.txt:
    amd_dynamic_epp=
    
> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 26a8552581c57..7dd50b5825d78 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1992,8 +1992,19 @@ static int __init amd_prefcore_param(char *str)
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
> 
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.
