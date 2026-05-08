Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F83D3D12
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272413; cv=fail; b=tzIs/EaKKS4dgKhlcOpKq/q6OPR0Za6Fs5vjf2cq2gqQTXsX/ePzVfFRmPBD/vCYy562pSipfOyiH92Hwf9lrW5Cra8EobLDLGXF8E1C3vGdm8QauAP6of5irHhYIk9+UdfzEf6kzVO61LYstyLaZESuThn66HadMeZGJ1Qc7+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272413; c=relaxed/simple;
	bh=gK1FR9Rf6dJMwuQ3g1k/l3CNXRs/WN1aoDLcXDz7Bjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paBosqTfl86C50JfIGAck22AnzX75X4ro0ifyWez2DaqSgZ/gZg0GHBDijMFC9lFP3oXwYF/SHk7hGhjTDgvDPNIF5XBF6WzjOhRwd/GLE2ufrXYbxz+rV9uj9r+Cn8nsrHTfem9X/MuV10Ts0nPMRXE0QXl06ud4bFWX1jBtbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pGm7LyuT; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pGm7LyuT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpVLmcsPTfrCVcnetQBqBN1OwAoAmUZMNykbkShfDKBrZHp0klHjXaWAgMmZrKHF2oN5vKuKExOShA/kAZfseVav76Zxf6vnXwD5TH8chQvrxS/gjlDLADdsJ8h/TKHB4qDQgDjY+SlnSMLGYRvtOUeniYfKcDTzhRXbZsZanwaOTB5ay/BeoR0j5Io/+KuK4ShvSenVUfaKSa+O+e6aIig6VfjoQnhoz7eZQ14uwaETbIIRI92rnIBQzOfG5JjN13O6AREpyrbZdNbeX4fJuIL03NyjAbksO5sxThkwevKvdAMcQlf3BMUKlb3Xr2zckqHHYwqPjcq/NSIHSm/unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhYh2eNO8H3gtB8lGAHqGD70XgZXA68EABm4eOWUFag=;
 b=upIuhoJd5E+fpXi5QNySDEmfinSfPJ8xD04XP72N4G1iLvUyi5M6/b/gimYnkTZHBryXlHEh8IEuRd7bD7sEnzrasGwnA1YYRe0+oWaeWD+WVUKtwHIh//9UidGNKybF0IrsBvfBLeDq1D9GLnH17c8kHhIk5ueSh/mYL+IWJYuCfq3Trv4N35/sNVY27xGcMkJ4XNDoesDDXNuiuQrevJDPj0NGABXMOqd0OgtOUAh7DM7UezhRYH5SAsvbPRmJtvEUelkBQjhwmyjb1AojyI7hajK9ym9FAdCrCgYBMtTFNQjoSbsdjxq/30rlrsSPKGIP2T79iHwYRZb9/N9MQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhYh2eNO8H3gtB8lGAHqGD70XgZXA68EABm4eOWUFag=;
 b=pGm7LyuTT3jnvoicPL7v5e+q3UDe4aTYTaqEt/K2i3tlXoFFIdiI4G3M7cJf4pVHJGZeyYwfD2qdjM+P/s3mHpCdKYOle2UkpTAaEp+OTKz9mODO0bQeFumSNsJkImpdwsqmiJmAhxcFZIAJVNdg6fwiN6p1dgClJMBw1srX/XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 20:33:27 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 20:33:27 +0000
Message-ID: <ef887a32-652a-407d-b321-2d65ada6067d@amd.com>
Date: Fri, 8 May 2026 15:33:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Huang Rui <ray.huang@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
 <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
 <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
 <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
 <8c39f42a-f024-4f05-8d77-a95e7ca1c702@amd.com>
 <b5882c89-aa71-4205-ab25-ca9f038340df@freenet.de>
 <b2b60a42-53f1-4ee7-8361-2a07737e1bad@amd.com>
 <5fa4c763-bf94-4507-8667-f3dcb032b2e0@freenet.de>
 <399597ae-5186-4276-a585-acb1fd8155ad@amd.com>
 <abba6f26-b696-4fcb-addc-754b295deb4f@freenet.de>
 <c8b2f359-365d-4d3e-bcc9-3b594e92886c@freenet.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c8b2f359-365d-4d3e-bcc9-3b594e92886c@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:610:b0::26) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: c33c3e59-4770-44b2-2fbd-08dead410ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e00E15/0zfHVwkE49CqptHx3TDYNmxfUjnUXyP4yfyTKBPd0YUydN7eAm1a4ccq9gvKTrQdmY4omaXmdz2Ks6GvKQ8Vp5s7JC/5j8F0WoOnxvNNhoo0gaFCL1IqogIwbAPdaxbcRqaDzx651qcRz+eMCxeVoVSxjjqbgDTVHrsd6J18hn1YmEi2NhVx2gIkn6R2zD1n5b1tly8h14qosSGkZJYRldL7i4fkFGyjdPdF6Lfv/w0xIOfBbUg5+F0jKTK3LW/M5mcEFVsCtA+3kY8pNKJMpU7X73twXcaLIz9fafwPPfJ5xvm7ZHsA5+Zy6dXQBCHaxfYHSN2Q+3eNz4qjOLqz9RCfGhm/BbflUWV+kL7frMs+hcNjUG5iPucYB1ZarkfbrMc07MamgQfayO1WfMikaJKAQslFJ/w9r1Y30i+HlfxXLgqbsqxmqBgVKjIaDujBABkw8IPQvTchnqEo17PB5a8oVoTCYyolnFEgP69BlF7vHPZ+XgvUbfuMwigHuPVhJbC66wgioxeUybn/pdMXb2s5+ohWrgLHefBD3fG9aEraxzSFmD7YQPGA987Zf6JfoVbYbd67jJ2sg/NXyED0PKxQFxtHQZJeDrXwv9mKcEQwOofO8Cxj6rbModN3s6n7qI79PDtYZpEr/OhkTSFh33Bv/Da8lm0zrda2tw/rZLD08LE89JeyTo743zj/yN3OR1D33ah/tLLvnXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amVzR2hCN3NOZHpKZ1V6RDlSWWMxcFdITGRoUHBMWC8wV3E2c1ppZExJekJu?=
 =?utf-8?B?Y1FVeHpyaUV6Q2Rpdkx0d2wzcnBqTytBaWlHL1RjekE3cVpHd2pxZERtRHFC?=
 =?utf-8?B?RkVKZGFnNWdUaVJWWXBDYjd6V3F5dmNkdHFBWk9OOVpNdGxkN28rZHdtNllj?=
 =?utf-8?B?MXc4OTZQOGlVVkx2VXI2MkxFWnJXZGNzWmVmOUlhTVJndG5JZ2dPVG5EYzJK?=
 =?utf-8?B?V2RYeDRZcHNvaGVPVitEQjEvSENWUlk3MTUzK2NVTTIvQjFXL0x5TEltejUx?=
 =?utf-8?B?WFh4TStzNFBCV2c2c1VMbGI3Mks4ZGt4eXlsK3h5NWVqSU56ZWxEdVRSdmsw?=
 =?utf-8?B?bEozakZON284aGgyV0JUZHpCRzlHeFU1M0NCVS9mbXBjYkNTRWg5QmJYaWdP?=
 =?utf-8?B?TXBxZjNaaWxST0cwV2RBVkJ6Q3FUb2JJRFhZUDUzNzJubko1WHVoandVV01R?=
 =?utf-8?B?VWIxNGh0UHpaRURkQmplTjdRTGV5Tkl0c0k0bndpVi9JUGxLdWprMnA3MGFh?=
 =?utf-8?B?eDRFS3FRb2dzT0hBazZ0bkFKdnFTKzA1L3lVNjRRK3FmSUdXdHNCQzltL01N?=
 =?utf-8?B?eHhHbk81OVRkUk5kbWlqeDVZay9Eb3ZqNExqY05WRExjOUhCNjVRSUNUTVZV?=
 =?utf-8?B?c2c4bzFibUVYc254aUZWM3M5bmtCRExzcEtWcUxveWw4NHk1ZjFjbkYydWJN?=
 =?utf-8?B?ZU9wbDBMZHFDWm9MOElVYTZSeUtHMVRCUHJoREhJRWZBWndkdU5TaVpwb2hG?=
 =?utf-8?B?Tnp5L2grSHRUSDJRZW9sNjQzTGVCNEM2YzhPTlEvZy9KcVJOd1ZDanhjc3NO?=
 =?utf-8?B?RDAySE1qYzh3UXZJajVkYzltbUgvcHBocDAxSis3amNTTFN5ZVh5UUc1bXR5?=
 =?utf-8?B?UmlVUkp2T0FEaEVKUi9EN2NZckhIRWlkbXA1dEZMQXpvSUZ3eUZIU3JXWmRt?=
 =?utf-8?B?aGhMYjhoYjA0aFBvQmNCamVoY003TEpTNS9MOFZFMnBUei9wRFVFVWI4R0Jy?=
 =?utf-8?B?Ny9jT2hBZGdJNGZnVGVOYzhPaml4M01oQ0orUFBuSkw2UVZmQzh5ZWZhU3Jy?=
 =?utf-8?B?RDZWbjhxSStGVVF4SS9VMnBPcGp3ZU9lbENCcmZCTWgwSExERFJWZkZYWHBX?=
 =?utf-8?B?T2swZDN2cHZyQWJNU2R0OU5SaEtmbGNmaTZXL2xEVUE1S20yVjhqM2s4YjZt?=
 =?utf-8?B?dmxLT2pydWFWbU1aU0lqaDR3d2tXTk80dExYWWpZbDExektwUGR1cmFnWkRD?=
 =?utf-8?B?dXBsN3JOdkozeHVQeXJqRUtEWGtMNkN0dEM0VjlLeDdNR3ZlYXh1SXBMbzd1?=
 =?utf-8?B?K0xhZTcvQTR3SGZTc2xQZXVSWlNxZ1hNV1J3azMxdHJoaDR0UWp0aTZYYUMx?=
 =?utf-8?B?VU1oRGRTaEZzMFpQaVNFTUF0cDFTbVRnbnhFT2d5UnF6L1B0NWRtV0tmYTNI?=
 =?utf-8?B?Vk5vMHRvaWFoRHpXWldvS0YrM1ZTVzlNYnRlVFR3cGtyQUEzQ3J1NEZzOGg5?=
 =?utf-8?B?K1QxQlVaL09tbnJ6MTdJYWNJUEhPY2M3MERyUmhqQkxhVTkrVENpUFdFSThq?=
 =?utf-8?B?UnczeFFacTZiYkcxU0UvcnVucDIrWWIyUnROdlpCWG9wSVRiOTRQL0JzTTd0?=
 =?utf-8?B?dFB1NmlpeDZRMXo5ciszWXZUNjVvMXF4dG1KdCsyM25QWTRPbWswbWM3MkdI?=
 =?utf-8?B?aHpwWlpObE5VOHp0YmRKYlVXOW5kUi9FZS9aajNxb1JYOVA1V1U0MDMrYTRG?=
 =?utf-8?B?RzBWREd0UFduOUEvMzEwSDBiQm9wVzNWRkhUZkp5RWdmbkoxNy9pWEJLTDN0?=
 =?utf-8?B?OU4wV3Q2OFRrU091NUo5ODc5M1dpVUtiLzhXblZyemdiQm8zTytUejVTOFRo?=
 =?utf-8?B?SW1HUlJvNzZYQ2JnZ2dCR1VET1pybnlidW11QmR4bjU0VThvRFJRQlh6NnU2?=
 =?utf-8?B?eUVnL2pWUHd6b01BMUlONmJWTmJLQmI1QVJMenJOY21RQTB0TDRMSlc1RUVW?=
 =?utf-8?B?N2VsSDZ4a1BzaURKcUxOZzVFZ3pDRkNkTVc1YVlVOEEwYWp3d1VaQTBSYjFx?=
 =?utf-8?B?TEVlQ3pPcXZrN3N2TjU0dVJ6TkFwWVNjSi8zbGJaVFVIYjlreHBsRVF2emFO?=
 =?utf-8?B?ZjdiSzl6QlVSdFArVGtiYjlxR2xlQ3hnWmV5Z28vNytjbTNPOVhNcXhZMTZ3?=
 =?utf-8?B?ZzVDc1ErODFCa2VGUElMSVhNR1BkQ3VmRlVlU1NkaFNhNWw2V0l0U1VkeWpi?=
 =?utf-8?B?bEFoMWoweGxXVGdMaVRiWjNKUlpCV05JclAzKzRoWm9sRDFvdE9OV2NXWnVC?=
 =?utf-8?B?U21nM1l5MWpudGhOSTR1M2VWVXJYbk9ld1BXbnpnSU5hY3dnaEV4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33c3e59-4770-44b2-2fbd-08dead410ef9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 20:33:27.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5IKoZugNLFtQW+2/GA4l3o8CoZbY8NV0XqDOYVWobgqxFcUmrpqouDoi9Uy7wrN5YgjgoRirmtPxObgatlElQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827



On 5/8/26 15:32, Viktor Jägersküpper wrote:
> Am 08.05.26 um 22:05 schrieb Viktor Jägersküpper:
>> Am 08.05.26 um 21:56 schrieb Mario Limonciello:
>>> On 5/8/26 14:53, Viktor Jägersküpper wrote:
>>>> Am 08.05.26 um 21:01 schrieb Mario Limonciello:
>>>>> On 5/8/26 13:56, Viktor Jägersküpper wrote:
>>>>>> Am 08.05.26 um 14:57 schrieb Mario Limonciello:
>>>>>>> On 5/8/26 04:31, Thorsten Leemhuis wrote:
>>>>>>>> * there is a whole patch series with fixes for the culprit:
>>>>>>>> https://lore.kernel.org/all/20260508051748.10484-1-kprateek.nayak@amd.com/
>>>>>>>>
>>>>>>>
>>>>>>> I don't think any of these will help; but that would a fine surprise if so.
>>>>>>>
>>>>>>
>>>>>> This patch series fixes the bug when I boot with "amd_dynamic_epp=disable" (I built
>>>>>> the kernel with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y). I didn't bisect to find out
>>>>>> which patch contains the partial fix, but I can do this if it helps.
>>>>>>
>>>>>> If you need further information (acpidump and/or output from amd-pstate tool), just
>>>>>> tell me.
>>>>>
>>>>> When you have dynamic EPP enabled it sets up platform profile.  With that series in place does changing platform profile help?
>>>>
>>>> Strangely *changing* the power profile (to any value) seems to enable the expected
>>>> boosting behaviour, but since I can only do that when the PC has finished booting,
>>>> the cores still seem to be stuck at ~1.7 GHz until then. Unless I am doing something
>>>> stupid, that's not how it's supposed to work, I guess?
> 
> Correction: Only changing the profile to "power-saver" leads to the expected behaviour,
> switching between "balanced" and "performance" even several times in a row doesn't
> help.

Can you clarify what you mean specifically by expected behavior and 
incorrect behavior with this patch series?
> 
>>>
>>> Can you confirm your tree when you found this?
>>> 7.1-rc2 + Prateek's series?
>>
>> Yes, exactly this.
>>
>>>
>>> I would say that is not expected behavior; but it does hint further at the second bug.  Hopefully I can repro it.
>>>
>>>>
>>>>>> Last week I got this output after applying a debugging patch from you:
>>>>>>>> On 4/29/26 20:34, Viktor Jägersküpper wrote:
>>>>>>>>> Am 29.04.26 um 19:14 schrieb Mario Limonciello:
>>>>>>>>>>
>>>>>>>>>> OK thanks.  Here is a debugging patch that should show what's happening in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can confirm root cause on your system.
>>>>>>>>>
>>>>>>>>> These are the dmesg lines concerning amd-pstate:
>>>>>>>>> [    0.845044] amd_pstate: amd_pstate: CPU 0: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.845047] amd_pstate: amd_pstate: CPU 0: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.845059] amd_pstate: amd_pstate: CPU 0: platform_profile_register succeeded
>>>>>>>>> [    0.845060] amd_pstate: amd_pstate: CPU 0: registering power supply notifier
>>>>>>>>> [    0.849046] amd_pstate: amd_pstate: CPU 1: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.849047] amd_pstate: amd_pstate: CPU 1: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.849058] amd_pstate: amd_pstate: CPU 1: platform_profile_register succeeded
>>>>>>>>> [    0.849059] amd_pstate: amd_pstate: CPU 1: registering power supply notifier
>>>>>>>>> [    0.853043] amd_pstate: amd_pstate: CPU 2: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.853044] amd_pstate: amd_pstate: CPU 2: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: platform_profile_register succeeded
>>>>>>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: registering power supply notifier
>>>>>>>>> [    0.857043] amd_pstate: amd_pstate: CPU 3: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.857044] amd_pstate: amd_pstate: CPU 3: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: platform_profile_register succeeded
>>>>>>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: registering power supply notifier
>>>>>>>>> [    0.861045] amd_pstate: amd_pstate: CPU 4: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.861046] amd_pstate: amd_pstate: CPU 4: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.861056] amd_pstate: amd_pstate: CPU 4: platform_profile_register succeeded
>>>>>>>>> [    0.861057] amd_pstate: amd_pstate: CPU 4: registering power supply notifier
>>>>>>>>> [    0.865044] amd_pstate: amd_pstate: CPU 5: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.865046] amd_pstate: amd_pstate: CPU 5: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.865057] amd_pstate: amd_pstate: CPU 5: platform_profile_register succeeded
>>>>>>>>> [    0.865058] amd_pstate: amd_pstate: CPU 5: registering power supply notifier
>>>>>>>>> [    0.870044] amd_pstate: amd_pstate: CPU 6: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.870046] amd_pstate: amd_pstate: CPU 6: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: platform_profile_register succeeded
>>>>>>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: registering power supply notifier
>>>>>>>>> [    0.874044] amd_pstate: amd_pstate: CPU 7: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.874045] amd_pstate: amd_pstate: CPU 7: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.874056] amd_pstate: amd_pstate: CPU 7: platform_profile_register succeeded
>>>>>>>>> [    0.874057] amd_pstate: amd_pstate: CPU 7: registering power supply notifier
>>>>>>>>> [    0.878045] amd_pstate: amd_pstate: CPU 8: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.878046] amd_pstate: amd_pstate: CPU 8: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.878055] amd_pstate: amd_pstate: CPU 8: platform_profile_register succeeded
>>>>>>>>> [    0.878056] amd_pstate: amd_pstate: CPU 8: registering power supply notifier
>>>>>>>>> [    0.882045] amd_pstate: amd_pstate: CPU 9: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.882046] amd_pstate: amd_pstate: CPU 9: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.882055] amd_pstate: amd_pstate: CPU 9: platform_profile_register succeeded
>>>>>>>>> [    0.882056] amd_pstate: amd_pstate: CPU 9: registering power supply notifier
>>>>>>>>> [    0.886045] amd_pstate: amd_pstate: CPU 10: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.886046] amd_pstate: amd_pstate: CPU 10: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.886055] amd_pstate: amd_pstate: CPU 10: platform_profile_register succeeded
>>>>>>>>> [    0.886056] amd_pstate: amd_pstate: CPU 10: registering power supply notifier
>>>>>>>>> [    0.890045] amd_pstate: amd_pstate: CPU 11: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.890046] amd_pstate: amd_pstate: CPU 11: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: platform_profile_register succeeded
>>>>>>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: registering power supply notifier
>>>>>>>>> [    0.894046] amd_pstate: amd_pstate: CPU 12: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.894047] amd_pstate: amd_pstate: CPU 12: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.894056] amd_pstate: amd_pstate: CPU 12: platform_profile_register succeeded
>>>>>>>>> [    0.894057] amd_pstate: amd_pstate: CPU 12: registering power supply notifier
>>>>>>>>> [    0.898046] amd_pstate: amd_pstate: CPU 13: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.898047] amd_pstate: amd_pstate: CPU 13: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.898055] amd_pstate: amd_pstate: CPU 13: platform_profile_register succeeded
>>>>>>>>> [    0.898056] amd_pstate: amd_pstate: CPU 13: registering power supply notifier
>>>>>>>>> [    0.902046] amd_pstate: amd_pstate: CPU 14: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.902048] amd_pstate: amd_pstate: CPU 14: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: platform_profile_register succeeded
>>>>>>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: registering power supply notifier
>>>>>>>>> [    0.906046] amd_pstate: amd_pstate: CPU 15: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.906048] amd_pstate: amd_pstate: CPU 15: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: platform_profile_register succeeded
>>>>>>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: registering power supply notifier
>>>>>>>>> [    0.910046] amd_pstate: amd_pstate: CPU 16: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.910048] amd_pstate: amd_pstate: CPU 16: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.910058] amd_pstate: amd_pstate: CPU 16: platform_profile_register succeeded
>>>>>>>>> [    0.910059] amd_pstate: amd_pstate: CPU 16: registering power supply notifier
>>>>>>>>> [    0.914047] amd_pstate: amd_pstate: CPU 17: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.914048] amd_pstate: amd_pstate: CPU 17: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.914059] amd_pstate: amd_pstate: CPU 17: platform_profile_register succeeded
>>>>>>>>> [    0.914060] amd_pstate: amd_pstate: CPU 17: registering power supply notifier
>>>>>>>>> [    0.918049] amd_pstate: amd_pstate: CPU 18: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.918051] amd_pstate: amd_pstate: CPU 18: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.918081] amd_pstate: amd_pstate: CPU 18: platform_profile_register succeeded
>>>>>>>>> [    0.918082] amd_pstate: amd_pstate: CPU 18: registering power supply notifier
>>>>>>>>> [    0.922049] amd_pstate: amd_pstate: CPU 19: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.922051] amd_pstate: amd_pstate: CPU 19: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.922070] amd_pstate: amd_pstate: CPU 19: platform_profile_register succeeded
>>>>>>>>> [    0.922071] amd_pstate: amd_pstate: CPU 19: registering power supply notifier
>>>>>>>>> [    0.926049] amd_pstate: amd_pstate: CPU 20: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.926052] amd_pstate: amd_pstate: CPU 20: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.926073] amd_pstate: amd_pstate: CPU 20: platform_profile_register succeeded
>>>>>>>>> [    0.926074] amd_pstate: amd_pstate: CPU 20: registering power supply notifier
>>>>>>>>> [    0.930049] amd_pstate: amd_pstate: CPU 21: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.930052] amd_pstate: amd_pstate: CPU 21: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.930071] amd_pstate: amd_pstate: CPU 21: platform_profile_register succeeded
>>>>>>>>> [    0.930072] amd_pstate: amd_pstate: CPU 21: registering power supply notifier
>>>>>>>>> [    0.934050] amd_pstate: amd_pstate: CPU 22: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.934052] amd_pstate: amd_pstate: CPU 22: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.934072] amd_pstate: amd_pstate: CPU 22: platform_profile_register succeeded
>>>>>>>>> [    0.934073] amd_pstate: amd_pstate: CPU 22: registering power supply notifier
>>>>>>>>> [    0.938050] amd_pstate: amd_pstate: CPU 23: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>>>> [    0.938052] amd_pstate: amd_pstate: CPU 23: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>>>> [    0.938073] amd_pstate: amd_pstate: CPU 23: platform_profile_register succeeded
>>>>>>>>> [    0.938074] amd_pstate: amd_pstate: CPU 23: registering power supply notifier
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

