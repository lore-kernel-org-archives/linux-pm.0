Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925F455617;
	Wed,  7 Oct 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396525; cv=fail; b=UxIV+miOMVq3NT3VWmgr9dVQIIWYfzp9uf5sOVHSfCyHETNZEUl4N5icZqN4tpcplJnVpzjCA26ioP5KCgQXb+sYb2ouUiv2WmDDlQGsxF7NaPuXg2BM6tVSkGhCPVw4okL845Zoh/zNNwDAjhNccromMmF94EbYioIFP53ZeGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396525; c=relaxed/simple;
	bh=aX13uE6DEMyudACUh9lfjxfud1sr/qPR1q8UiaMpQDw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4NcULkB00Zekcz3WgHSWH5AKBxmufhD3yixvvaq9SCpMQTX7KdeCm6iyB7bsRitYhZE5UzERye35Dsy2seyIgy9pSFe1XMFr6DPdUP6LtQ/mdZi7+4bIsRk7SB7CxXhGSWm45wtjigIX9ZhZYKqfCWcSkwsd7t0M7s/kC64ZLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L64qsr55; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L64qsr55"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVSovCLKewM1+SJjo0ojOpiSSweYikLDityqdWSsbgJ84NjkgkYt1UgyH8qE1jdePPevb58MMnU7lRUUjzcQe0L6AHf+CH9TzQ3fx/OtAxNZWpyKK7u5NciYyApUe7uoQ8zQHavH/G7JpV7URitU+y3O1X0moh+TCct/NOTVwdz8Lg0rDGHF+0Sjl2wvS3G2bI/OVCW+vzAmkThTfYosl/2pvYpq/oyokgUbNkzKmcDkFSf1quoHXdK41DRKQiklVUlhkzvjWICmx0syTnm3TcDOMZWRgnxbaTsA0L8VnQ5wsZwMa27wAcXydDrs96r5XXidTNwhzd9bEnHxwK+Zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3j0k2IvlOk5GN9i07cp4kBXEv7496+CGVgVaay/TAA=;
 b=MWOjJnz1xHCHGG+sfCW+Yv+1z6uisleNXxMBhXKpmXmi6/JnVeqyqBTbP34/VMK2VvPRLbPzJ3CQEyOehsRwh00RkLba4q1Bgv3Xzs4iWpQ2RZY6IkeswomuNxiq8O1GZ6Bz2XWLsc5EGQS06avviiUVGoy6LlZUOL9KVkp8Vj7oXP8VwTkrXd2J3sjjxsQKuS0LHfrYR/SYZTry/EmAPRurLArOb4aLAXfcwoZpBGfv5dCCJGuJgaFh8Mix3zCzdFeO/snl/30TJed37QFoPz/81stHQWkI870HhqqnmpRtyc2OMoxsGqeBbyKT3MMFDak/sVHr6veebDTyOQpLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3j0k2IvlOk5GN9i07cp4kBXEv7496+CGVgVaay/TAA=;
 b=L64qsr55TAuGAqYwQsrxDgsqog8kfn/yg24Xmjjd80u677g0i7yV1bmeBteV920ARUwjp/q2bgGyepXvwQGo0wuWYYmOd5s9hCYYRSB1yecYihf7NceghbBlX9q4CzPxZ+U+i540DN9/yb20G2CFZkCqe70kW6RKehhRB2XnNZc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 18:08:37 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:08:36 +0000
Message-ID: <1c6ba221-a73c-4793-aac6-b38d6e573295@amd.com>
Date: Wed, 7 Oct 2026 13:08:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
Content-Language: en-US
To: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
 <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch>
 <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com>
 <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch>
 <DC1J2LrrQ6hdyQJ_ThQRfGrnzKLI5qCCQYGA5I2LhASN8j8MLcpfvJ2T4Qn_8xmO2TB4MW9Sl6LyQKkuANWwowWXafKbEqJ8pXEBEnmE2yA=@kylegospodneti.ch>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DC1J2LrrQ6hdyQJ_ThQRfGrnzKLI5qCCQYGA5I2LhASN8j8MLcpfvJ2T4Qn_8xmO2TB4MW9Sl6LyQKkuANWwowWXafKbEqJ8pXEBEnmE2yA=@kylegospodneti.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:806:122::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c0b929-86a5-4867-ba46-08df249e01fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nG+R+5Y0mPjYYW0CtQzp4PjDeipR+mV9lfy7U61MWHdfvRPVHlHmtKXNz2gzIH8sUvdpiI4iU6w3DL3t/wEBPlYakspwfgzhWRxwxrfGXZL9QyhU4KB74bzsysbz7Mz//hgKNMIVFRQYSiU6vB3DDgOK+WyxZu3s1BXLCoTiDpwwWtYn3vM8KmGtSre+MN1oKg7vmuGuGA+Iw5mzL+lVeJhPDLGrwxNxzqlO1KPrntnauT71YjLHTQY3/CJElub5Z4uRbXp2F2GtQfmHvcqMhBckgynH+QQSs+CHbP3X7Qs9NxAme9iN/uG/uvyGloxoZ/sXSsN0JF1epZ/lmmoPdHJfSj7c2IAX6OvmQg/CKKMW0WZPwQIvxVQ6h352djNzYr0nwXoND2dTQ54hNH605wfW6US6q5OhNWA3sYay2DNmDMLnIkdpLtvhS0wiVvNtq8Zpe5IjH3km6FpZyTaM87WZmKZiNlBmzHfFwCSfqLhTKtcxJsNGCPg2rOqSWd7mc20OgXcG7qQ3wjeeOrvmiQqCpkzWYCPHUG1Bh5rsbQm2SphqrEyRH10hXZCNOsIeZkuyd7NDl9Upn+U3FsXyq0nJONLN7BnWxRsZcfKNR8Iuhrco49i49sGPjwsuKTE3rvOMH1qQ8kaTP0NUIhLPWPsIQkaYjDJV3PuZmzuCwDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUJIMVFtMndmbmpGb1M2TXNtaHl2NTQrazRRK1h5dDE5RnZYNVZOcU1YdGJu?=
 =?utf-8?B?TU5aVDJzdWxpVDUvUmVGL0NDWEdYSkcybzM2L2QrRWNncjZBZGVoYy80Rm0x?=
 =?utf-8?B?dHdmL0k2MWVnUVk1L1hWRkNBWS9zNitCbXB3RTB0QVlybVcrcnNROGZoc3RC?=
 =?utf-8?B?VjdXalJIQ1l6VG9qdGZJNXpTaytDdklKeGI0RDBYYXZ1TmlIVDBSOXAvOG96?=
 =?utf-8?B?V0tOdVBxY3l3UnF0bCt0WjNkQkNuYW96a2YrVHZXWXBiMjhCQk4xbXdoVFNY?=
 =?utf-8?B?UnNXOU1VOEhIYTd0ZWpPNkZrTmpySG1tNE9ZTkthbzlQeHBhejFDdjlQTDE4?=
 =?utf-8?B?UHMrcFpNcEVJb0NJdkRFN0V1QkFCak1uZXFMd1d0Zlk5RUQvKzFlN0sreHl6?=
 =?utf-8?B?bmNkMHZPcldmV1FnSjZycVVucGphYy91NEh0T0pWb3NmUTFzY3BQeWYwNlRU?=
 =?utf-8?B?RWFNdWVRM0hIV0hiMEZCcmFQRUE4SUo1YkZlOGtNQ1lpYXdOclB1Vlh4UTRG?=
 =?utf-8?B?WDI5eG9IeGttMUI5RWRoQXorak9tSXlVWExZQkNLMU5pNE83RkRGdFcxMWR0?=
 =?utf-8?B?Q0w5bzNheHR2TE1ucXhJaXpIdWRwazQzdnJHSEVydWlOYnJJUzd5YkVxZUtp?=
 =?utf-8?B?R3doL0ErVnJialNDVTNhNFlHVmdGQUNxbkduQUFsY2hyWGpDYlpjTjRtMEl3?=
 =?utf-8?B?eWt3TGNlMks1TWdJeWVQV1VOd3U4OFNiWDdjQmliQ3RZdHNpZWRINUFWZXU3?=
 =?utf-8?B?OHY3WG9FZm83K0NYdlRTNXRrSG1jMnRnZlNmRWdCaXlyWm1NWHQ3MmRraDJO?=
 =?utf-8?B?OXNBUTJQU2EzeGlucmNRV2ZHeFdjQm0rLy96OElPa1VHb2YxUk1VYUpxVUpB?=
 =?utf-8?B?RWVmZEw2ak90ZkVTeVZiQ050RDZWRDltQkZyUDlRaUZyTkhoY0I3cDdSdThT?=
 =?utf-8?B?MVZKWkFLVm0raHVRTERzaU9YR0JuczM1SWhNbEZaTytjNlNieUE2d2F5ZjdS?=
 =?utf-8?B?bVpkSU9yT0NRSkxkakNTR0ZUd3dFVjlZbGw0SzUzTmRNK285MklsVDQvbmk2?=
 =?utf-8?B?TXlCbld3b0NrcTRuOW9hOWZ0cTNqNUUvem5WRGNSd0pPZ0x0bDI3RWl1Zm5G?=
 =?utf-8?B?VWMvWndzS0dFa2hjM0pqR1R5U0ZtNW55NWV0V2ZJQUdaS0lrRGVOaUlCN1FZ?=
 =?utf-8?B?U1VPSkVrMUN1bzZoUENoM2lOaTgweUt6YWd4M0ZUbXlzWnhVWnZBY3ZXeHJp?=
 =?utf-8?B?SXhJMk1oQlZyUUNna3Vod3JtNkVBd3ZOVXJCQlNLYjB0TzVUNlUxdGIvRjNl?=
 =?utf-8?B?c0VIdTlJeWRpV2VtRVo4eVVvWUtuQzluK3BQZXpFQUNQV1V6L3ZTZU0xcmdv?=
 =?utf-8?B?SEJ6MWNwa0JWbHErYkpnNkVvSGhvYkp0VzMyV3J5YkNlV3VVMzFRSzhHV05D?=
 =?utf-8?B?OVV0VUkzZm1Udmd4WDVKclQ5dVF5bWhNUUxvT2VwL1luTGRoVld1aWZHbWxB?=
 =?utf-8?B?TE8wSnhrM0x5TUVoUEJOd3dMNjdBbm1UeFpTNlE3Y2NSSVhSOFlrUlQrV1dS?=
 =?utf-8?B?Q3BvQjVTL1owZ0NwWTdJUDVFc3FjUXBxUk1XNnhNWWl4UFk2STIwODRtczFo?=
 =?utf-8?B?bnBiRlZPOTU5UjR3UmUvSXdZOXAxd3l5VndnWFMza0hOekVMSHZzQzRrT3py?=
 =?utf-8?B?M3VBVVNLNlI0a3UvcHl3YUpwUnZFVHdweXZMNW91MWkvWldUTTNOMW1Yb0dL?=
 =?utf-8?B?UEtRaVBGRVFncERKdXdvSDRJdElNRm11WGxIem1jS1pKbmNRVnQ4NUpINVRo?=
 =?utf-8?B?cC91NHFhZmw1S2RpZ2prK1JSUTNJZS9QYWdEd3dVVFZXeUFta2UvcnhMNm96?=
 =?utf-8?B?Ykx3WVRXRU1SRHBkY0UvZFY5OXF3U1U2cDc1bFptcVZzdFlaVEZORC9OTnF0?=
 =?utf-8?B?aGVHcmJXWnAwT29Hd0dkVmxlNkhvQkQwZzdHRWs5a3pyNnZzOEtwTlBTWWVs?=
 =?utf-8?B?Y0ZMUHJoNXc5bGt2YVF4cTIrSkExc0szSm9YOTEwNlQ1Z2V4RVl4eTR1WVBz?=
 =?utf-8?B?ZVVFL0VEZnlieU9WUmdtai9vVEcvNm9QZXg4bkRVY3gzR1hKWW1CZTlKdzJz?=
 =?utf-8?B?QS81VmwrSCtYdytYTzVTbUx3Mk81aHBZRHV3WHBpMUovU2lkODEzSFdTK3BL?=
 =?utf-8?B?ZlVEYm1rY0JQY2xld2t6UThTbElmdkxWR2s0NlVTRHNpSlNlWUdBS0l1dCtW?=
 =?utf-8?B?NEVrYURsYVBoSGVvT1RObnl0Qmp0VFBhamZCbkkzakJqek9PWUloTUFaZ2RP?=
 =?utf-8?B?ckd4WnNVS2d5Mzc5N29VS2pwRjlXZGRMUXVDd0owdElPZjRBc3NJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c0b929-86a5-4867-ba46-08df249e01fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:08:36.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qI9qo65tq/J7aGLmMRt3Ghn/MBdMVcKFvbctKnKHxTI/t4yk//c7IIMZcydbBou0a4lrDMjRmhir8V0wQr0UeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

OK, let's wait and see what happens after you upgrade.  New versions of 
FW and the behavior please.

On 10/7/26 12:43, Kyle Gospodnetich wrote:
> Missed one,
> 
> Release Date: 05/17/2022
> 
> 
> On Wednesday, October 7th, 2026 at 10:36 AM, Kyle Gospodnetich <me@kylegospodneti.ch> wrote:
> 
>> AMD Ryzen Threadripper 3960X
>> MSI TRX40-PRO-10G
>> https://www.msi.com/Motherboard/TRX40-PRO-10G/support
>> I am using 7C60v1A3(Beta version), I will update to the latest today -- just learning that exists.
>> dmidecode reports that as:
>> Vendor: American Megatrends International, LLC.
>> Version: 1.80
>>
>> I've had to disable pstate with:
>> amd_pstate.enable=0 initcall_blacklist=amd-pstate
>>
>> Without that my system grinds to a hault, takes upwards of 15 minutes just to hit the desktop.
>>
>> Thanks, let me know if anything else is needed.
>> -Kyle Gospodnetich
>>
>>
>> On Wednesday, October 7th, 2026 at 8:06 AM, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>
>>> Kyle,
>>>
>>> Can you please confirm more about your system?  System Model, vendor,
>>> BIOS version, BIOS vendor, CPU model.
>>>
>>> Thanks,
>>>
>>> On 10/7/26 10:04, Kyle Gospodnetich wrote:
>>>> Yes this does appear to be the same problem, thank you!
>>>>
>>>> -------- Original Message --------
>>>> On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>> + Kyle
>>>>
>>>> Kyle,
>>>>
>>>> By chance is this the same system that you were talking to me about offline?
>>>>
>>>>
>>>>
>>>> On 10/7/26 09:41, Giovanni Gherdovich wrote:
>>>>> Some motherboard based on the TRX40 chipset has been reported to ship
>>>>> firmware lacking lowest and nominal frequency values in the
>>>>> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
>>>>> Firmware updates aren't available.
>>>>
>>>> Can you please add more information about the vendor/model of the MB, etc?
>>>>>
>>>>> amd-pstate requires explicit knowledge of nominal frequency, so it
>>>>> can't load on this hardware. The driver already has a mechanism (the
>>>>> so-called "quirks") to accommodate for missing nominal freq in ACPI
>>>>> tables, so here we use it to match against CPU family, model, core
>>>>> count, and BIOS version.
>>>>
>>>> Yeah; it's intended for this specific case of really old hardware that
>>>> the BIOS isn't going to fix it.
>>>>
>>>> I don't understand why core count matters though.
>>>>
>>>>>
>>>>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>>>>> ---
>>>>>     drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
>>>>>     1 file changed, 31 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>> index 8bfd46d60843..532ff16dd076 100644
>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 = {
>>>>>     	.lowest_freq = 550,
>>>>>     };
>>>>>
>>>>> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c = {
>>>>> +	.nominal_freq = 3800,
>>>>> +	.lowest_freq = 550,
>>>>> +};
>>>>> +
>>>>>     static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>>>>>     {
>>>>>     	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
>>>>> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
>>>>> +{
>>>>> +	/**
>>>>> +	 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
>>>>> +	 */
>>>>> +	if (boot_cpu_data.x86 == 0x17 &&
>>>>> +	    boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
>>>>> +	    topology_num_cores_per_package() == 24) {
>>>>
>>>> Does the number of cores actually matter?  Do you mean to say if you
>>>> swap the CPU to another part CPPC works?
>>>>
>>>>> +		quirks = dmi->driver_data;
>>>>> +		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
>>>>
>>>> The BIOS bug specifically is lack of values, not invalid values, right?
>>>> Just want to make sure I'm following this right.
>>>>
>>>>> +		return 1;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>     static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>>>>     	{
>>>>>     		.callback = dmi_matched_7k62_bios_bug,
>>>>> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>>>>     		},
>>>>>     		.driver_data = &quirk_amd_7k62,
>>>>>     	},
>>>>> +	{
>>>>> +		.callback = dmi_matched_trx40_bios_bug,
>>>>> +		.ident = "AMD Ryzen Threadripper 3000",
>>>>> +		.matches = {
>>>>> +			DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"),
>>>>> +			DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
>>>>> +			DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
>>>>> +		},
>>>>> +		.driver_data = &quirk_amd_ryzen_threadripper_3000_24c,
>>>>> +	},
>>>>>     	{}
>>>>>     };
>>>>>     MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
>>>>
>>>
>>>

