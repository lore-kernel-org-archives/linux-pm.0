Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798339E166;
	Fri, 27 Mar 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593826; cv=fail; b=bp5wl6DSgJuyAYg/7Kqf4rn548uxPxC9vPGg4FVjm0rypp69IJYglwC8V4mEVzCY6oe5b4bQLqZdmDnWJdlXNYV4Cw2nsWrJ9eteChwtbUtrvcvhFjaoebrgPJcRywF/qmONAYBEWVYOdpDEUcspQPYPWdKtkOBfKcAobrYtGyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593826; c=relaxed/simple;
	bh=+uqQ+H2SvZXJr6zVAo70feUnZTBvMbrN44Y+N/ZddH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AT/EsCrX4hMD4KCpj9NHhPuzb1dE7kXRMvy/EnPzzGod+pxhUZfq9cwHMad4CZsrGU5QgYEfU3MXN1QTvuAFAxixO6EGUzbIie3oXlm/fSRkOCkrGjSqC2GRdfbsnFHHlRxfo/sXr99jsc5lv6pwSEtsPj25/UHpcK9VLtvgBe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=udOqGK6q; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="udOqGK6q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3G7la7Bu2bx26J21jkv00TMsjiFlRbNC4/LhsIlLs8wXA0pwBe6M4zCXt1mserkGvrWG+hvmv2RZ1vj0n3mu+FaDJ2FCTDHJ3fgRjKrmNxIsHhex2XAxpAaTjANdM6GF69yw5eLeLqyNUoIwLFebbjfnRq+fffhC8d+rYroejAU0OOxDknu9wzphCiR9a5KYbM61JXfALTBEsDbjdohQYN6/j6Ejz+7+IxZAg+Jf2v5maMYXNhXBdqNCuoC7sjyZnb1EXPdWIPWGIsExctc46PuKEAaAyoLn7OOKAq4tAMhKM4PlxvDDsdmQ30EtgcwXg7mbT+Jaja9i3DrS/2LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knje3DZ5O8UVhMJwhR38wyK+KKaiNrI7f/iqKR6yLyQ=;
 b=i+dZRnJ7EHYzsptdaSCgYnKn7H0MaGFvEnoBrC4Hp3Zh9B7gnerClAtRJ3hIv6hGF+r/HKkOUnQqhkUBoTFumMWx0kbne6sifBbP2lsZvG7LI3ThZ+1X23euDdzOy7Dn6tdbQab4iuLGLxbCjCPo/W26vadSoEtjtUvEd7bt34NstzWMTEpaWhwQrcUufMOzZX5PO/FVsoy+NPXxaGfGEsrG0pDKPuQCCkpURgtt+if+35NcYortHTj4jTrANnR+fT5ipfP9wkDS+9fVRYHAl9t6AeQMMXX1xQNv9HuUk866mJXyn55Fg+50VkPbxJ5C5im1jO8FDdvyE1MZ3bCWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knje3DZ5O8UVhMJwhR38wyK+KKaiNrI7f/iqKR6yLyQ=;
 b=udOqGK6qq0AsY5VrNEEmuQbfDRSGKuu6oE13WUCC2Go3DZAtWYPPx6po/jiaiD59qdLwVQW8Kna2RKFNND+HD1nL5wKgLgU7w775ci67iYoRtdW008Smr/UgAtnaJySoRTahF4hzv68cbtYbTFNrE7vR47Xk9eWFoVsf4JbopVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Fri, 27 Mar 2026 06:43:35 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 06:43:35 +0000
Date: Fri, 27 Mar 2026 12:13:25 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 1/5] cpufreq/amd-pstate: Add dynamic energy
 performance preference
Message-ID: <acYnDaMzU8cU9tjk@BLRRASHENOY1.amd.com>
References: <20260106051441.60093-1-superm1@kernel.org>
 <20260106051441.60093-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106051441.60093-2-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: abb59e2e-38e3-4035-6ba2-08de8bcc2b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1pAl2sKoP/c9q4BPYJSbFmtgLoIyuJ5DmCBeoHdyBhgtlmo8BoJgpH3byFsdvR7UUpoWxhm9JWU5adAtfZTEMKLXYab4MDRhXpgpP7y6CfrJYX1mpxYee7Q8Pq30H2b3V2sHRFAtTTwZr0Zfdq8OIK7MOv1yzkG1aeOUI4bfBjSrP3fNFDTdJyaPItowd7xyoHqeLGijLRYdkpkFrsw52xBpD/F8oQCMAHPkk/eAs6XcpM4Xj094g0x4/00qa9uKkmOo0DBGKjKLb+VETiYCQEkhL77nTYOurHa+cVifaFFt9ovs2uI+KWV1BWHtyp5eFfpuMBM2AaR5/SlU8px9T+IThV4cdhksiO3ID2Kmt7XTDO5MnmUagGZTdB+HDTLAVKw0xnTaQn4L/mg+W/oY79YGMrOyIzgAGBJyRnOsQJVcEF127IJe8rg3QkOGMEK+s90/50a8kLRfI60486pjMOFttjfeRn4vKLMzkjLmgJ0DV0A1GPoI1pDRb6rN4/dNifIc6NLlg11zgU/BiV0W3t4m1fnaqGnLp58QR0uAj6zhlVn0hmEBtmbla87WhrkXk4QAi8GXEjMKHjti3aNnew4/Gk4sYLHcWPJmPWOBRC0LC58Oc6/0Ld16Bt/FXCbLgp9y0y7xFlAC93g9rkgOcaOx+s4dGwLLqBcX2K9j9jEtoyyPtL24nYAk2u78j0Llk8mmf6wNqjRYvtV+pD+8vgVC1ScqOIejlx70jDgIwoA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9Nft4YwJnNkmvA4FSHTAgxNDSFXzjCVW/5dtoZGFVWVH/OnEQSxuSNznt2m?=
 =?us-ascii?Q?cSIE/g+htC+DqZsH6sdXCEDbPSlHwbKptcGphXum/ZrbVlot7SHh4nm7yfb1?=
 =?us-ascii?Q?dyWNGmw774BSpK3UDYIaM9R2m83EBXrc2mufOGW38nVpcW/4FtCEw3Pa/1c3?=
 =?us-ascii?Q?8CkbmzeQJEPXbnWwxSDyFrhD36J6Ga0qsBCTM9e3pInI5V8mbfRTu+zFyPl1?=
 =?us-ascii?Q?yhGUBmNPDMetsIzJYDbTFaq1FDiOtbxqrduEAGoC5P4ClstTbeBtQsJw8mPH?=
 =?us-ascii?Q?0VGxBZ/d91hPxB55CDpUTGUutxlenOloDQ6CP8viQ1vBBnkFtCndAp7K9wwv?=
 =?us-ascii?Q?+PoVvzygtM3G9zF+IzVtI9UKblDXywnCHX0H6U2QE/h1tjGwKirkHMQKuzI8?=
 =?us-ascii?Q?StL+JfbC0bm0e32xyrPUb2FgqpjAOAZbdovn7x2wo8dNMThvgUU1ggetayaT?=
 =?us-ascii?Q?T26woESAtgkgM27kll9pjf19Urv7rx2eeJ7KuYK1NIWvBNPWNmVfL7tb+Pw5?=
 =?us-ascii?Q?J9ReaUpcP9fx4JrPgtgqFsQTL63bXLCsULBQtlOIWq/Bac/FrYAinwlN8txY?=
 =?us-ascii?Q?4gx6Y3Duw7NzyuEKfjqy4N/+8ebMoErkENq2viGjvJqzUHZPGpNhVhoIwQQu?=
 =?us-ascii?Q?VzdCSBkhINBNwRHXBRHlgRWi7GuUaHYxmUGWIRpoU06B0eaLJMZ3DQf1QP1u?=
 =?us-ascii?Q?lCmANZZtekhPaLB5gtR6SvZwd976KimpiKemLBKcIwt+l5rUvxTimf/m1RpT?=
 =?us-ascii?Q?RVWrBkRKnGSgwXtnQCBvjc+p/0Uhgk/aWaWWuRqUOrT1aHzBqtnkP3/hyuTd?=
 =?us-ascii?Q?Yy4Y2khN7DabNNWV808MOIZQKEcxtb0G2pKpi3AY9W28wOwVnO+8s1MugXOM?=
 =?us-ascii?Q?q66Kl87Da9eUMpX7IvbMevtpTyQI0AZNtbJIGYUMFA9AX1UuSf57em7bknS0?=
 =?us-ascii?Q?MpRPh72uCvnu8EUCbeB9jqWhXQ1C53eRZ25WZDKuP5/tGRMw2riow3r/ksfQ?=
 =?us-ascii?Q?0njAMRPzqEJX+3QOIekM3U6vW/8wjvxCrIVBUX7tVP4at0Er9ysRIQNRXCLO?=
 =?us-ascii?Q?qfHUAw170tpBnitDJioro1n0GI0yNlmaAEJ9IHyjIPFKXlznM7ax8Gigiu/3?=
 =?us-ascii?Q?NHLut8If7QFlK8zKvGLYlbmKeW0+54M5HIYFTDsf/ZoMyvRRdgvY+UuKUSOi?=
 =?us-ascii?Q?r9iNvLX08nOvvPysLmI523sx2LmH0t4zOFTlP2pybHU42RDfarlRQRNDDPDv?=
 =?us-ascii?Q?oA2NqiakkSXzbmTwiY/QpzHZrlmOYsOZABhv/6SM5ILyehfQF33bn7ygcxiR?=
 =?us-ascii?Q?tRIhoFNVzpTX+gPw7ZkD5q5ebJKQHQwhbzZHVzEFOe1GD//tN/kk9V7EjhAc?=
 =?us-ascii?Q?t3kXRtZxIjSxbCuPiQaDcMiJSaja9cpsznZn3Hrvow+pjmzJ+fNiMoZj8wm7?=
 =?us-ascii?Q?mlhhGdj6NjPjgU5Uqzs2sdENVToWpKvPEIL9k/dUplWHS3RU+12vKiql2ImJ?=
 =?us-ascii?Q?ZYFKkKCI/vCcdfTU37aWNTycZFSYhHLW/zzUKAJC7pp79j1mMRDSP0lZJcWV?=
 =?us-ascii?Q?b8gbCbc9hRNbGImTw2/JxcpcZKQKLfFwRKW7Np7sfXycuIvIo1oVFNwW8wzO?=
 =?us-ascii?Q?5Pf6P8jBCFIC72fdnksA4hCfcwX4IceK9fzyqk8zku+0ELTO7HDpqJQUfYDS?=
 =?us-ascii?Q?v3LnhtNtrf1ZiMgnagOJu5ngAZ9xPo7f8wNxLZHJu3P/GsoG5XaQ7FnaZ+VF?=
 =?us-ascii?Q?SgkEWAfpjw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb59e2e-38e3-4035-6ba2-08de8bcc2b4a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:43:35.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgeYu54kgE7xixpDzlV/djWmvO/Qx3mfGpWPgx1XunI0bE4Zvs5YThQoLtcSOkuqbdn9U9hlKUQkdFOIlJRz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

Hello Mario,


On Mon, Jan 05, 2026 at 11:14:37PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Dynamic energy performance preference will change the EPP profile
> based on whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust
> EPP values on plug in or plug out events.
> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.

In addition to these, the commit also adds a sysfs toggle, blocks
manual EPP, forces PERFORMANCE policy.

Might be good to mention these in the commit log.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

[..snip..]


> +static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +	u8 epp;
> +
> +	epp = amd_pstate_get_balanced_epp(policy);
> +	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		return ret;
> +
> +	/* only enable notifier if things will actually change */
> +	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
> +		ret = power_supply_reg_notifier(&cpudata->power_nb);
> +		if (ret)
> +			goto cleanup;
> +		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
> +	}
> +
> +	cpudata->dynamic_epp = true;
> +
> +	return 0;
> +
> +cleanup:
> +	amd_pstate_clear_dynamic_epp(policy);
> +
> +	return ret;
> +}


Can the notifier_call assignment and registration be reordered?

The cpudata struct is allocated with kzalloc, so
power_nb.notifier_call is NULL when power_supply_reg_notifier() is
called.  power_supply_reg_notifier() calls
blocking_notifier_chain_register(), which adds the notifier block to
the chain and then releases the rwsem.

If power_supply_changed_work() fires between the registration and the
assignment, the notification path reaches notifier_call_chain():

kernel/notifier.c:notifier_call_chain() {
    ...
    ret = nb->notifier_call(nb, val, v);
    ...
}

At this point notifier_call is still NULL, resulting in a NULL pointer
dereference.  Setting notifier_call before calling
power_supply_reg_notifier() would close this window.



> +
>  /* Sysfs attributes */
>  

[..snip..]

>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1421,6 +1528,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
>  	&dev_attr_prefcore.attr,
> +	&dev_attr_dynamic_epp.attr,
>  	NULL
>  };
>  
> @@ -1512,15 +1620,20 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (amd_pstate_acpi_pm_profile_server() ||
>  	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -		cpudata->epp_default = amd_pstate_get_epp(cpudata);
> +		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);

I wonder if we can set dynamic_epp to false for Server platforms.

The reason being that there are Server users who switch to the
powersave governor via a systemd startup script to set the right EPP.

With dynamic_epp = true, this is no longer possible. The user has to
first disable dynamic_epp and then switch to the powersave govenor.

Or perhaps you have a commandline override to disable dynamic_epp at boot time ?


-- 
Thanks and Regards
gautham.
