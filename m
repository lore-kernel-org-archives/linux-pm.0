Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954C441618;
	Fri, 24 Jul 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919455; cv=fail; b=UvvjeLvxPOpZTIvsjG4fWLKuIns6FzeJaaTfRPDZvBHbDHPkbFxHfqZ3G9Hyp7q5nc1n4zUGfoU0SB5DTkgkTTOC7JRkTOJoBDbzmt8phKvgctZ87WvsbTUobJuDoVCxHtp8eAkI/2NBDTJvlB0reDACjnlrDeOsUu/lvMwKeYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919455; c=relaxed/simple;
	bh=OdlVCRHx9QtAK4ZLdH/EEoEfN18PIrvuLUzpjM4mA2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X+UqUXYfbOCPBW4aPhahYwkPATzvRiA3mEEtVcHu6zoRr12C9JcmioMKgdH8uk6GJdpxMazHtR8abFoyoKXqe01Mjl58yBNjRk78bu80rGC0FDqiQyuhC7tM73a8lstEEmlPWSqKcXVs7+O/8FGwZdAI/dN9tx3yBURHyR5a6/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dxMERHFe; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dxMERHFe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa4fjy6hAuwywlIw3mOQ8918lQve566Y8IpS1kQIHkuQD+rZwDPrVHxo95VTY7Gzb4cCv19N14RzTX4nzSeJ0H/IIEvKU0N4SLfXMj3v2J2e2S4Ia+Gekqppa+iCdzpFo2lEoa1PW3iT71ACRINh+Ew0h2bymSPqQabvHQu1R0lFvb8XGN7g//mgElT4dWfmiy8XfnJAHbzwZkfkTOZFiBvdMDBhZQ3OeFW1BcSAuGf/el9t1V9Gf0oYg9NQ4/FgvpirruqltfmYL/EwYWGpRQGGFjjoWpr3ERDKuA/NuaYGCjTNHmWSyoY4AX7su8yFRmPJhwLp69DHOnz016dvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hDj74B1+4HoaDj4YX8nLE4lDaPsdj7ueoPZKc6sO54=;
 b=IWiIwRTEIhj8Q12nYjG5z1Ol8tA9myFqhSYAskVY30C1kuFzfpLqDC/cXPgaQAR3oXLyqM/uDRdQmH19Kkn3b8KmfBUWbOT8pRx8o56ToXhrPXJqcvM4Y2HGQJ+ZKYLZe3T5ARX0r0O0Uz3Q3ZQ/CmAjBn3kmnMC3wkst26KOz17O+DmsmlUzyTYfdcPhRNkJOmCrXLnHnrZ8+wwYLwZ1tRn1To3eJsGV4mDDs028VIyYFvBkvSarP4quaTnhsvouKzA6fJqw3fnHhtIsqneusQeNeRtqiguNlwm48Yf+bPO3QnGtUmivd/2xlboXvPpr/ilca/stCyzWdO5EuSuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hDj74B1+4HoaDj4YX8nLE4lDaPsdj7ueoPZKc6sO54=;
 b=dxMERHFe/8ElKOTR7RV3RT3bw+W6CtnCEd9wohIByMzoqwHHzvCbGhcGJduIFoDBb01HVbCyBV6oCiqcKd6Dvk77cr2yV2DO4ICJ4mfDgS7qYTOM1rwrt4UrrUbIR4JMEnW+HMH75TH/0+rfGdFg+l4HglAwFXOkgwWdV8WLFsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH2PR12MB9495.namprd12.prod.outlook.com (2603:10b6:610:27d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 18:57:26 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 18:57:26 +0000
Message-ID: <6d2dd243-7ffb-4297-a1ae-b82f7c7c0348@amd.com>
Date: Fri, 24 Jul 2026 13:57:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] Documentation/amd-pstate: Update dynamic_epp
 documentation with new behavior
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <20260723201228.22584-7-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260723201228.22584-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:610:54::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH2PR12MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d56efbc-893c-464b-3e42-08dee9b566d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|3023799007|10067099003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f3C1AiL4a/PDcK9Hqscp60DV+UFnFerrNY0y0/YPa6dFOAASvMuL41yFqcFkBfHgUQKqizcgyOvv2v8tQOtSSNTwFqsBdxQN8Ba6ckZPqJm0r4a4Ehj/pkZhNtwMgvTAjKzbfSl58KsRG4TBEHLLGI7BkJ7wWJcYS4NhOGP9dEXN8vVXRO8Pg7FHiqA77ZmICJPCw2+D9/8CgKXA0Vxic0jhWMQoixrqGjGZ+kOzJnhtgazRWDAIx7kJQlTpaXEMsWCJ/F+Ui1DpTw/N4rig4yZAcSdLEUJh+wAzHo3+Zm5+8mHjEYWWv/yXNijUF3d3wcnu1i/ZcckB3G2yc9C90CBzXfNy42R+X4/w2uPyV9nvEABmuqL6Q3vAW8DxfPP/175hTutu9hpkJphXDleKPplQjeF4hGXWWG2kZ8+nfxImLsvaLawPU8NR1e/Fh1HziOYoCopLX3rARWJOicQ37EmfFTwT7LIPFdGiOTRp40PK3AXVE7cnU8TuK+BA5ffrNSOJ5rOuDhTLK+DHcjldeMF43S/FZ6npu0ySC82Z1FQsbJMibnUTJ29oIPm1RDzeKEXHfBc6wpC1elZWOniZMq9A50Y4udcrFvoSOUxoZLTEuqbDSUvd5hdyVXfo4oHNqfWfX+x4zsOmqAo1NHdu9TFCNbKdRR7tRYKD7RneUQA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5BcWJlNE1nMEpoWlhvVytNQWFIK3NJQi9SUm15ZXlpS0JuZzh1eUJaeDRn?=
 =?utf-8?B?QS9DVVhtS2ZLRFFGdGdOVlJ0QzN3cXNRYTZTM0pRdTA0MWpTV2FKdjU2b1ZT?=
 =?utf-8?B?bk5OR0RocVhsL25HbXJRTWZJMURxQnhsUFBJbnJuUytkSTNtTFE2REtIVklo?=
 =?utf-8?B?WEgwMWFFaFNqY3M5ZkxnYTN0b3ZzTDlGMG8yV0VkZzBESlhacm5LdEowZlQ4?=
 =?utf-8?B?aW5QNTY3eVZ2NXhLa1Ztd3VHbFpwcmt3U01kUHRXVWpSNkNZSlNleS9NVHJG?=
 =?utf-8?B?OHRXSXhNd3ZZNlVGdmwxOEQwSnVlVm9JRnF5Si9OT0FId2lobnlCTFg2NHE2?=
 =?utf-8?B?UEdkbjJES29ZVStmOStsNSswaDVuNTYrRSt1Wktnd0o1REViNnJ6RFpYdFdN?=
 =?utf-8?B?dzR2NzVITStHLzBscU9wSHVKQUxYWVRxcVRWTUNsV2hEdSs1ZXJBLzgwNVMz?=
 =?utf-8?B?ZXYvWGVWK2xrdGZTZ0R5L005V0JvL0RzRG5uRUd2MEM1QWNrc2F0dm43MEp5?=
 =?utf-8?B?eE5CaW1lSFB2bk94QTJmdjhxUWo4eVpiVjRVN2lHdjU3VmJVYU1aMnFiNTk2?=
 =?utf-8?B?TVNDc2NFK0ZuOXR0RnFGQ1NENDB0TUM0VXBiV2p2VmdYNzZldUprTnJ0cytI?=
 =?utf-8?B?SHgyaFN3b0NFRmxubGgrNHgvd3RBU25EOEhwNzIxbTlpYzFkMVE2RjNpdmE4?=
 =?utf-8?B?Wk03eXNqYUhhODVUbXdJTSsyN1BxL2ZXZVBXN1JaRmlDUjQxMU5aVHBmY1pp?=
 =?utf-8?B?WWUvcDg0OVBHNFNQeHA2NXc2K1F5WjRPK0J4Rlp3Y3I1MmNBWE11Q2YvNU5u?=
 =?utf-8?B?RHAwK2JSYks0VDYyTVZ0eU5RT2pXM3pTU09VczBvM0tKS3lmbXR0Y1ZTRGhX?=
 =?utf-8?B?dXRGS2pGRmp3Um1MM2YvdXRpUXNqbjNEeStaT2s3MWVOTHdDVVlhZWpwZkp6?=
 =?utf-8?B?T0ZWZkwxOFlYNlF2YWdLM0QxazB5WDRMNlo3ZkMrbHVTZEJyTGU4czhJdW5Y?=
 =?utf-8?B?OGwwOEV4cmdVbE43NmdyQk9jdHBYWFE2UXBRTUc2ZDU2ZnVFeXV5OUI2UEpX?=
 =?utf-8?B?bHB0KzI2MlJxQm5GVXFSU2UyUEgzeWpwNG5Gc0VlMmV6VXFnaEhmRFBDSVNJ?=
 =?utf-8?B?UlU4d25JZzBEL0xaVXRIaHkwTVlXWFRBRE1oSkJuaVVXd2dkY0hHOU5aaFNn?=
 =?utf-8?B?TjArUU4weEUxRkh2R3JDSWI2aWx6SXFaOXdJcDdsK1ZqeEY2R1VmWEhSU0lD?=
 =?utf-8?B?bngreUNqSno2ZXdCaXpldG1wemI2c29JL3A5cE1sdnE1V1Z5Y1VnZVNRNG5K?=
 =?utf-8?B?YkMwR1VMOUNyL0p6ZkpGQklzMkRRNnVCWmdGeEJkUUFKTC9GQ01aU2J1MThV?=
 =?utf-8?B?REc3NzAybmV4ZjBGcTg1dk9PcGN0Yml6U0FkMmgyL1pyVnYzUzdJaUJVZ05E?=
 =?utf-8?B?S3YrOE9wOE5MbjVJenlBWVFUSWRDaVNLNkxxRFgxL3F2WUxRVEVtbTZ1bXJq?=
 =?utf-8?B?RmJhYmlEbFM3aUxTYnZvN2REOVgyVTZBM1J0OXlhbVJDVlVQN2RGYVUvODhM?=
 =?utf-8?B?WGFaOFFZS2JSdFg1NklQM0ZHZnJVWXZYL2R1Y01rSWFaRHZtMExCRUlGUlZ3?=
 =?utf-8?B?djhnQ3RWa3dUR2ZsRjdqVmRWNm41NFllSncrU0h4M2VOZk5WNWhjVFRVUTdD?=
 =?utf-8?B?dUJVT2xRcEpYRDQzaUJTR2VMbnE5ZnZVZy9aMUJXR244VEFlYjJwZEhiSnNI?=
 =?utf-8?B?VUVrdnB1eDcrVUVIeEcxa1lTV1hoQnNLdllqK1A1bUFQVmR2NTg1Y1B1clkx?=
 =?utf-8?B?dTN6cm1LaFducFFIdHl5Z1pOSkRpNmxnMmh2VE00VUVJYlFIaDhjSlFlckY5?=
 =?utf-8?B?Y2l0bFo3TTlEK3dIVkVVRTlZbTR6NXgrSGg3b1M1RmtHQ21iR05nZ3BiQ1Yw?=
 =?utf-8?B?ZnFXNE5ScExRdW8xTldwM2lCVnZRaGJ3UFlYQzJwZTlPbE1zQ3pTT0xGaFB5?=
 =?utf-8?B?VEFoSUMveEhCOUJwNzI5akRoUGV3cDJYeThIcmNpYnVRb1RDSDMwR1Q5bnRN?=
 =?utf-8?B?TW5DaFl6STIrWXc5ayt1a2J2NFhHTy9CeklqVGdUTjZhSTU5a1hlMTVaRis5?=
 =?utf-8?B?VEdXaXJINTRZL0U3eW43RUFKMW9ubEJFNWh4dk1zNTlUWVlwYW1TcHEzeDIz?=
 =?utf-8?B?TkZKRVpaVHhBeTRGRjM4WmhmaTAyNjFHSjQyMGx1aHUyZmxxd0llakZyWnVC?=
 =?utf-8?B?cXgxVzlGSXExUWhYQkxtYlFFL2FWdFIxWnNNZ1FEcHhjTHp4ZXM4V202Z1NU?=
 =?utf-8?B?K25jeVVTajNBOGlGN1lsUTZodEJ2Q1daV2FmQ05VYkhMTlVDTHduZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d56efbc-893c-464b-3e42-08dee9b566d1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 18:57:25.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cga9i9yOSqPzCrC1s8niE2zr8mMUj0ZLBA4AMZcmBu7Jk5PGJpJJkIP6LfAhDan7J8eGA7dw6DCbr4edZ+BM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9495



On 7/23/26 15:12, K Prateek Nayak wrote:
> Update the admin-guide for dynamic_epp describing the latest integration
> into energy_performance_preference selections.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changelog rfc v1..v2:
> 
> o Updated documentation based on current state of rework.
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 46 ++++++++++-----------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index a95e2ebce005..b0f1626bd783 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -317,7 +317,10 @@ These profiles represent different hints that are provided
>   to the low-level firmware about the user's desired energy vs efficiency
>   tradeoff.  ``default`` represents the epp value is set by platform
>   firmware. ``custom`` designates that integer values 0-255 may be written
> -as well.  This attribute is read-only.
> +as well. ``dynamic`` designates that the EPP is modified dynamically
> +by the platform profile and the power supply status. 

Although this is true, I think it's very likely going to be something we 
forget to update as we add more criteria.  How about just saying 
"modified dynamically on kernel events"?

> See ``Dynamic energy
> +performance profile`` section below to know more about the ``dynamic``
> +mode. This attribute is read-only.
>   
>   ``energy_performance_preference``
>   
> @@ -326,13 +329,11 @@ and user can change current preference according to energy or performance needs
>   Coarse named profiles are available in the attribute
>   ``energy_performance_available_preferences``.
>   Users can also write individual integer values between 0 to 255.
> -When dynamic EPP is enabled, writes to energy_performance_preference are blocked
> -even when EPP feature is enabled by platform firmware. Lower epp values shift the bias
> -towards improved performance while a higher epp value shifts the bias towards
> -power-savings. The exact impact can change from one platform to the other.
> -If a valid integer was last written, then a number will be returned on future reads.
> -If a valid string was last written then a string will be returned on future reads.
> -This attribute is read-write.
> +Lower epp values shift the bias towards improved performance while a higher epp
> +value shifts the bias towards power-savings. The exact impact can change from
> +one platform to the other. If a valid integer was last written, then a number
> +will be returned on future reads. If a valid string was last written then a
> +string will be returned on future reads. This attribute is read-write.
>   
>   ``boost``
>   The `boost` sysfs attribute provides control over the CPU core
> @@ -356,21 +357,20 @@ Other performance and frequency values can be read back from
>   Dynamic energy performance profile
>   ==================================
>   The amd-pstate driver supports dynamically selecting the energy performance
> -profile based on whether the machine is running on AC or DC power.
> -
> -Whether this behavior is enabled by default depends on the kernel command line option
> -``amd_dynamic_epp`` is set. This behavior can also be overridden
> -at runtime by the sysfs file ``/sys/devices/system/cpu/amd_pstate/dynamic_epp``.
> -
> -When set to enabled, the driver will select a different energy performance
> -profile when the machine is running on battery or AC power. The driver will
> -also register with the platform profile handler to receive notifications of
> -user desired power state and react to those.
> -When set to disabled, the driver will not change the energy performance profile
> -based on the power source and will not react to user desired power state.
> -
> -Attempting to manually write to the ``energy_performance_preference`` sysfs
> -file will fail when ``dynamic_epp`` is enabled.
> +profile based on the system profile and the current power source in active mode.
> +
> +The ``dynamic`` mode is listed in
> +``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_available_preferences``
> +when available while running under the ``powersave`` governor. The ``dynamic``
> +mode can be toggled on by writing the same to the sysfs file
> +``/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference`` when
> +available.
> +
> +When ``energy_performance_preference`` is set to ``dynamic``, the driver will
> +select a different energy performance profile when the machine is running on
> +battery or AC power. The driver will also register with the platform profile
> +handler to receive notifications of user desired power state and react to
> +those.
>   
>   ``amd-pstate`` vs ``acpi-cpufreq``
>   ======================================

