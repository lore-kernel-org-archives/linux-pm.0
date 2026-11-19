Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795084904;
	b=2tNojET8R0sLRNeO6Al6Sp1HYPBsoeUbtEZnlzd1EB61lsmNRc80l+TGuVsarJ3U9LN+
	 wA90VpGFcQ9Xe9nTixN/WIc0CM+uDimioophbwVsx4NdwY9TWIU8NxGJYguxZo90E35de
	 asKmK8RmChEE3fj/+QqAa7s1o3BLo3eF/lxXL5Jg7y1NczP9aRj36O673Qq4JRT4wHuxz
	 cfutgcjsFDH3ij91J/xV34H7TsCm7BCw6FjsIbyp84Z2jP6jVCkuYazXcQ3tTrB+LMkKB
	 YPGqSKH/U1lu3wwZkzaRKXbO6Mdfd+7GT9BQHdg/KaKzSXroAfnlF8JgBaJZUIjjuVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084904;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HItaKBFwGgtIDgzQIP2fl2a4mw4UlG2X/zODMzlIVIQ=;
	b=y4R8IiINXynDTLOncULjoe9q2rZPMU5YQSWWZsyc5VA34rQc4xlkWlgLOMzNmq6mV/8W
	 fkI/9uF9oyTDDx1cgDZaWGPR6vEu/euEJqT2Aw5atV6WnRmzn5kJ6w4bXHxjfYR90Z4oV
	 YIJe7XYVfaq+SjCYuGVbPiFOQwYK/cuNFffhaMndSbgApLggQ4eo3VX7ttcR3BERmEJwm
	 s0pOFbYD6bYuA0JAuXsCJKlir0UG9qDnJlthgvfKZszb7cT5eMqiELKTNA6gQBswhSZQW
	 8GCAO0Gh1mm42DBzkif2mqKH6Oh8LW4h5oK5E4RCt32td/BrnUt8Fc29YKXY9zPADWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eqAI96OQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5D606A325;
	Thu, 19 Nov 2026 10:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA5D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eqAI96OQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz3VynTWCSQIRtTE+kSH3LxrQtucbR+SjdSc+QNeyFB3aDzXSUeALbDFm3lD1P/ZDftTG/z4AsmhPACeS8XGXOhWf1uzolcRRjURyTXftFwsruHB3scqtq7zAW76/TTyoipn8AOL77giv9kTfU87FW6N4Ti6OcdQPsUZxQcuilnGr+99bjrO9nrnPeM3fXfoiG0DfzRBxP8wxZnSPme9/uo8XjaojQqvMt+9SVgWj3dUSI/8yyuCB/nKBjpAOTsB/VxyjqN5G1+SE7WmAHY3iMEnKgyV3ufXy2yH7AevuMQjC9R9zz/rQWjWM9EpoQHHsJVSpNQ+8bnazxcB5do1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HItaKBFwGgtIDgzQIP2fl2a4mw4UlG2X/zODMzlIVIQ=;
 b=aVDJvMTqvBywweK+ABSIsNjgN15u2+DAvGwthm5uapwUVWYBblp9GQUMF/koWwB2aH173AFiFaAe39EohnY64jiTjtbIbk/4JpNy/T+XZ/vVqu18RFI64c1/JiwS6ewHWbmb9WLFB2qSe+cnd9uhbXsyRNZ7NrVYUZ6StJ4NpCrytNlC70uFiFfeF0ZJOlkBkopWi12kl4ykhpw5Cyeq8wjkcYwhBsOusvygIuee/lwddg1pRRVg0mCVoIANZNQ3BDQKgIub9aWblCUouszowg9jJwHacKOYGTiLU3QzmWa/VK+xgELz3C2lX35qqOMMX4d9IPUn3kVqXk50BD/3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HItaKBFwGgtIDgzQIP2fl2a4mw4UlG2X/zODMzlIVIQ=;
 b=eqAI96OQ5tvEKABrMq5oL9kjxap3QaIZ4cQyoEfgBOYUgs+KxFO2QABea2SdeCyrlW6OPjK90w7vcnQgfvmkzaOE0kI9J76Zf3rex6K88VrI22afj6uqP8sAqJb6Q56eUjQYiXbNSr5cKUEfxD0i6EGhr9q03GdlYgl9h71S/wENMAuyJC/VTkxezJYGHJJxsnX7DIMVdVn3AN89a/8VCPGNrbwghPJFja4+nN2z9/3H0onk4pGCHBmIzb7gZAtwn8WEoC/DFX5Y0mJCFFidOVid/ZYXylr+v0HFe331udhCealKOrFTiHPXdYhusuNBrtcnjgk4FQPtJ3Jppn/7nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 10:41:39 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 10:41:39 +0000
Message-ID: <357545af-dff5-4836-92a3-4576af0a64c8@nvidia.com>
Date: Thu, 19 Nov 2026 16:11:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] cpufreq: tegra194: Add support for Tegra264
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com
References: <20261117154954.625126-1-sumitg@nvidia.com>
 <20261117154954.625126-9-sumitg@nvidia.com>
 <6452ab41-2d7c-4995-9f6f-1e8207767cdb@oss.qualcomm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <6452ab41-2d7c-4995-9f6f-1e8207767cdb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::20) To SA1PR12MB5637.namprd12.prod.outlook.com
 (2603:10b6:806:228::13)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cb62fe-3a21-4f4a-6b74-08df4629b112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|921020|10067099003|4143699003|56012099006|261028144727099003|11063799006|261022105027099003|261021121427099003|261026121527099003|261102123227099003|261026140227099003|261021123027099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7W+X/oXPis4Cg2fcZk2SvEa///B11ft07KcR3g7Rae8Yr1qR209y0eLvw0H3DtZw7NuHBKJ3aRkoVd1Lxyd5xoBPVDI0Hv/CdR1NkTJOJfO1EssRJZkDNVjJb6a3idVgt3homhMzB3eXfz1AQMoGUiOZB0vYZHX8WF1LhY2PB1OXkVUPbCJygaJnlKRZB/+vWO4G6WgppSUR+IyAYlj00Zzyz9g4OiEh/It3Mi8HOOEuovCz9QI3POpGj8OONof5N2WIB0g6k7qBRWAraO7TIIXDd18GmnfFuO1nK1fpze2IK6565so9qj9zreEk29N4+rHSjpv1lYwk9c88CrUdCWB2Sra34gYyxvpOKuLBUpfJ157PjbfyxieQ8w1PLlUz8hJocz3UdOLq3qkdAx84I7cCZxX+BC2b1yqHHwdvg+Xdq0SETLJQzH+sNie/HtYeC31nVQGX9t781yDWC9/xdS3G5viAgpDi8CREfmX2+qOEf7QJKlbShfE88cbmhSFCqj21MflQaitXzcX15nBEvH5Sxerz9krdY7f25V6HUm/NqtBkB1uvL173GF0cdwcBZv2fA31wB37Hlf36Py1sLr6xKBYt4eoC5QUdzF0cHW9OpnAEsQU/Ua5At7w+KIYxvvGcEqmhV/SWMX4xkBsjh41BzkhCZnzQuremiIj2EeNNl+5R5bhWUkH/3iAmZexZe1JkV0/IjNqbDnZwtioBhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(921020)(10067099003)(4143699003)(56012099006)(261028144727099003)(11063799006)(261022105027099003)(261021121427099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OENzTzRicElVMUxFQ1F1aEt6aHNmOWVYUkU2aEFuWDJHQ0V5d2YrdXE3Vkkw?=
 =?utf-8?B?YW5GT0NZcFowNWJKeHRQSUtrQmttOThKQllzOUxGMVNZdkljNVB6YzRYZUll?=
 =?utf-8?B?amJuQVZTc1VlQzliMWFpUVhVbHFrbFlaMGtvZElqaFpQRGRoN0xKVy9jZXRk?=
 =?utf-8?B?dGQwL3RVTnUxM0lyMUhJZ2dUNHFyL0w4Ukk0UTh0bnhPYk12UUVsQUJlNDdZ?=
 =?utf-8?B?cmp3eXBxUDhBdGNUTUJobUVjTjlFeGJCQ25pa0k3OGRPb2V0ODNidlRWck5h?=
 =?utf-8?B?M1RzQWlWc2dlT2tSSWEzZXVmbEpJK0xaRzE4b3NWcnowY2xOamVLcVJsMjZH?=
 =?utf-8?B?RzFweXBQQW9rNEcrblJPaS9VMnVhT2hpbkpteDdLTEJXUGxOQ1VyUjNFemZP?=
 =?utf-8?B?WkNyeGNnYWlTWFhDTmE4eWYwaWExSkRyVWlXM3lpbHVhUG1YazVrYnlONmZp?=
 =?utf-8?B?YzgrZHlvMnl3b1B2R3ByYXlsREpjK0N6bERvWTlFRm83ekE5RkFlUXZKU0FI?=
 =?utf-8?B?OXpUeHUxdDV4R3ZEK3FGS1NtVHdLY2x5NFkya1FFYjJaaFk1WHhPZnU0MEJ4?=
 =?utf-8?B?VHNVc2M4TTR2VjdBVnFzMzVmaVMrcGJ0VWJVbGtCME9ISWJxalR4U2RpdWlB?=
 =?utf-8?B?ZVVpbVJSNGFQSEdjc0FaajErdmtnaDFnQTA5Uzl1TUhnUTVoaU1VVHpCTElO?=
 =?utf-8?B?Mlg3UHkyR1NmUnk3S1BEYll5U0dPZ09CamJ3RjNIeXZ1VVc0Y3daZTFkV0kr?=
 =?utf-8?B?NEZTT1hGV0phOGlQUDNPaCszQkNhMWVtam5PbjFCTWVWa2V4VXNoWFV4dDVM?=
 =?utf-8?B?S1F0MDZRZnl4UXdjdSs2UU1jRG96eXlESUQwU05Tc2JqdnJuZkc2azVOZUNX?=
 =?utf-8?B?S3M1bDU1bm5iZnVNUFZCeXMwa3F1cG12RktLZ2FNMGhpaFpFczAvM3FFY2dt?=
 =?utf-8?B?U0lsYkxzaE5JZ2FxM2wzaWt6cS9aOXRRbFZlWVNscnNsdEhwdVBHQWE1V0px?=
 =?utf-8?B?VStjekU2dFlHZDJWcXkwRXlaTHEyaUhSNlo4ZXNiQjEwQUVoa1hVVTUzcXVt?=
 =?utf-8?B?QVkxRU1oZkQzZ2h5N1RtNnkrL2NMYTBWNkphWXNDV3p4Rnk3ZUhaMlpPdVJj?=
 =?utf-8?B?emRma2k5aE9ScEF0clh2bmsxZncxelZOQ1NrRUxpRkNqSk1pWmQ0cmdTQ3Vt?=
 =?utf-8?B?dWVXbGFubXF2Q3pPTEF3UDNPUmdKSWNWSUM0QndhamRaSUlseVZDSXh5SXlI?=
 =?utf-8?B?OFZ4ZXY2aXZJNXZ2U1hVNUQ4UGJhcktIQVlaOWZVZXdvOWVVR3U5WFdoamYz?=
 =?utf-8?B?N0UxelBvTndNRUNWUWd1UlByV09GZ2ZOVVB1c29LeWpPV3o3eWU2K3FlNWFx?=
 =?utf-8?B?d24yTklNN1Vyd3BLMVhNOUpxV281OXRtV21PcW16TUowZzM4QWgvQ1JXUVJ5?=
 =?utf-8?B?bkg3T2xHOElnWEpxTExXeHpVZ3EwMlptTlhWOE9DbTNDYnZ3bktkQUxldjhQ?=
 =?utf-8?B?SEZpMkEyZzJPQm1QalhoSkdCUXkxRmQyNE84UDJHbGJ6YitVUHpKMzdXcFdw?=
 =?utf-8?B?ZFBRVzV1L01KQTg5Yjg1RFQxaFdpSXlyOHVOeGNFdlN3dU4yU1l5ekdVODhW?=
 =?utf-8?B?VENVYmxkTjV4THNaeDFNSnh4bnJFSFhGVUpvTzEvVDZ1cjJ3Q2YxOFhMOVhy?=
 =?utf-8?B?VE5GZjU2NGRJUVZJNzQ0Tks2R3BjZG5tYSt2UFdJYllLY0dQKy96RWpDOUtD?=
 =?utf-8?B?QnFxSVd0R2VLU0hVMDZ1Ym5rR2hKc1l4WFJicjQzRU1KN1hRcU1qRFl0WTQ5?=
 =?utf-8?B?VWFwOWJ2eE5nWUkyZ0tySjhiWVhuakIzaitJelZ1Ny9WR0I5d2VsT2QwUzJ6?=
 =?utf-8?B?SWJPSVVoRnVvVkorTVkwTjVVclcrazRGaU5yTTc2UTh1VG1Qblh6M3pqYXgy?=
 =?utf-8?B?d3hLcXR6MTBqUFM3RUh1VG1jSWlYS3dCamxlVmVRSzhNRndla0Nod2hMWkNY?=
 =?utf-8?B?UFVENFJaeFl4VFdLcWx1TU1vdGJxS2I3NGVHaTcvNWE5RnJzczdyZXcxLzJn?=
 =?utf-8?B?WVVtVS94MjUzWnV1cTNyS0R2WHRtT281aGhvQkhIR09hZnNTQ1Bic1M0QTNi?=
 =?utf-8?B?NDA4QXo3RitvbVBmNkdoWlB6Z3JVakRnRms5RjE2cnZRdGNkNjRCeE51d1F5?=
 =?utf-8?B?bE1jb0c1M242eDlUcFRaU2xSdFBOeStkQ1VpYVVOZ0ZtWlA2RFV5VzNpZUtw?=
 =?utf-8?B?Nm5VS2dpZEVYSElmejFHc2lra0hzdTltRlRhd2tMNFVSWWN5ZGQ1NDZZbk1u?=
 =?utf-8?B?dE8wVnlDU0VjcmU2czhYd1RtZ2psU0tkbVJaQk5lQkJUZ3pzeE9WUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cb62fe-3a21-4f4a-6b74-08df4629b112
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:41:39.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sznBVohX5+/+t/oGmEFPodWBBPnDX0+LhZIbxc5peYwLpSbZTYTE2gRsWV69IKvYFtYevkT8jt86AV0YtN0wnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875



On 18/11/26 09:17, Zhongqiu Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/17/2026 11:49 PM, Sumit Gupta wrote:
>> Add cpufreq support for Tegra264. It requests and reads the CPU
>> frequency differently from earlier SoCs.
>>
>> To request a frequency, the driver writes NDIV to a core_freq_req
>> register in the CCPLEX register space. Two clusters share a clock and
>> its register, so they always run at the same frequency. The driver
>> exposes each pair as one performance domain and one cpufreq policy.
>> Each CPU's "performance-domains" property gives the domain index, which
>> selects the register. If the CCPLEX node declares
>> "#performance-domain-cells", probe fails if any CPU lacks the property.
>>
>> To read the frequency, the driver samples the per-CPU 64-bit AMU
>> counters through system registers. The AMU constant counter is the
>> reference. It ticks at the system counter rate, so the driver takes the
>> reference rate from CNTFRQ instead of the fixed 408 MHz clock. Probe
>> fails if CONFIG_ARM64_AMU_EXTN is disabled or a CPU lacks AMU.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/Kconfig.arm        |   4 +-
>>   drivers/cpufreq/tegra194-cpufreq.c | 161 ++++++++++++++++++++++++++++-
>>   2 files changed, 158 insertions(+), 7 deletions(-)
>> +}
>> +
>> +/*
>> + * The AMU counters are per-CPU system registers, so this must run on 
>> the CPU
>> + * it samples. tegra194_calculate_speed() queues it there with 
>> queue_work_on().
>> + */
>> +static void tegra264_sample_counters(struct tegra194_cpufreq_data *data,
>> +                                  struct tegra_cpu_ctr *c)
>> +{
>> +     c->coreclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
>> +     c->refclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
> 
> 
> The core cycle counter and the constant counter are read separately
> here, with interrupts enabled. An interrupt, or a preemption after it,
> between the two reads skews the pair, and the resulting error in the
> computed frequency becomes more significant as the gap increases. How
> about reading both with local_irq_save(), like arm64 does in
> amu_read_core_const_ctrs()?
> 
> 
> 
> 
> 
> -- 
> Thx and BRs,
> Zhongqiu Han

Good point. Will add it in v3.

Thanks,
Sumit

