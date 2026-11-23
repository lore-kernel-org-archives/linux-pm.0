Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430805;
	b=B0DdPe2bo9acLtadG42YJCrOwiKyjn+snqhT9IpAw7ZhOXtCGaa/vyCeknFMsii2+dT7
	 dyLOnLV6BwtaoRHRnrqUAr52YUk2OO1LOwb5/kB/Pvx88abtPDQkZR3+565o2FYKbQj8v
	 VvixR9hGkEQC6x3mDnb6DdCaxEh3KPqhG6ZUHuqqb1nPhHtqIbexgDRKLJ/tqnDHY0iJo
	 r301ePdf6Oc3Ne64E4mX/Cz1l4MHFiyCCtpKSBLl4fZ2zxAKXQRD+9HsOhG9oCWMCeelI
	 I2TARCeFj/PEgUUS47pgT2jOlaKyT7aH/+JCEvDVKfZ6PElbps1wpw5c9B6rp8sUhuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430805;
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
	bh=AOObROQUJb56vGpxps8TrQAgu6J9Wp/MDFghOPRMBs4=;
	b=UkxOvcpaDgfEQhAPev1qvj4v0bA5iS6scNnG3D1R33BOaYvL07dgjf7nAbINbYyY7y1i
	 GnFm068BKic/DXsrD5J9zV5Ng1XFfAj070QYZH42e8XL/oL3ixEUesJjuU0lCHYqWaEQI
	 sCVmUxEU/FUG6KMA6yxjJxC/at08iWGYSAY7W6dZ5DWnDW73ri3SUKfp4xWuYBFGXAuKt
	 2cximS6qpfJ0VOQBlAK56wVNa66Wbk0Inv88CP9ODGxO6yzIjK8NbqCkEP/WndAeDHyDH
	 AVt1pnzTb3qUr9QZ29zMdWrJjrrCt7uifzRt3gueaF1a/NMG8nAjwrBfUobXfi9o/Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fu2A4vqV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.12
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAABD606A31E;
	Mon, 23 Nov 2026 10:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAABD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fu2A4vqV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGHzZbVwyUsADuMDijEBfu0vbI6jHB11IiJzQn8LxdIB4F47iS2bAAovX0f2Gqm3Ode6XLc1WM9x3z++fyQVq880xoL9PxaJmb1JCzxljGYTIFW2ruwS1z7aH+0ppEd8ee85lWYmp1Khu1oVzyI0dbV/iVBR8ustseJ2C8E9OBxAlt054MTiL6RJjRLz+9evDqauOATYtTffxnq9gVdxcwOgOFG9JWguNxoy8Q5y8cFsVkseh9LYmxta0CLU0XBAwNPq0Qtw+ld48cT7wume5BWMS9VJcznNtcIRgIV03oUjTL8s4T3S8Hc06txd7o+Z1BMuSF78CU+WJBBYbHzemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOObROQUJb56vGpxps8TrQAgu6J9Wp/MDFghOPRMBs4=;
 b=dXj4cFnCW+g1sziE6tjgAXBxDylQaCQ4bi8cRZtEwr4iE50FiuDtdf2X7VDSGLzy9ncbdnV3BcU1ddB1Kiv7GZ5xvoxDCJrepyvgO3RHuVjx4HxdaGm1gVnKsVKwUSDJldcPw2qOILsycD/KQGI4jBUJYY4IqIsY/CC3bEebyPJlBuPiZ+74NLLX4GIvftGgoALSOT9wsiIPGM/2mJGoCIyIjAIWivgTMR4z/Bapq8Wk5ythOFfWUKbysJtew/U2sueGPIf1mmghlUa+IUTtApEH7HGkkNi/wCei/pvr7Xwarf85+tF/R4nLKSAKcUZDeSTJSv07DtCzj94Gei3t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOObROQUJb56vGpxps8TrQAgu6J9Wp/MDFghOPRMBs4=;
 b=fu2A4vqVzkrYsgCE0g+jqGGYJTEwq7hlRLc/JR/HvXcRPMR2EzpzotBHraIi5VWPlNIkm5BlsAu/5P9hhb0gSud4GSeLFmaYqL1BjScVjNE6TjknKt48W4H9SWGZzfkH7r+nyGaabfWryXr+3SYjYGKEqJAaKdU+YNcgk08W1P4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 10:46:39 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:46:39 +0000
Message-ID: <6ad8b75a-85a2-410b-9584-b8989cd6dfc1@amd.com>
Date: Mon, 23 Nov 2026 16:16:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/amd: hfi: Stand down when amd-pstate CAS
 is active
To: Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 kprateek.nayak@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-3-Vishal.Badole@amd.com>
 <404553c5-60b3-464a-8d76-7850120f3d58@amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <404553c5-60b3-464a-8d76-7850120f3d58@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0217.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::13) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4f854c-5146-44bf-6ec2-08df494f0d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|921020|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ii6C+TDywP1SNQbDX0e8MrFAWftISJIY+AbTBtClIaOODytHm92kiI7oev3Tx2fwcHK/n/CzKNXBFks8ynsxL8S7tyoR9pCc7fid+JdF+T+ShSUtM4IxPmyz48UtBlWpRIPFAoXu/zvkUbgALCBzDcd84rdtqEtgKdH93WN4hsk5gkH0nac0gxNc4/cG/UGB8PteNrtbvb2QBRX5Ujq/iBOxRicEl4IepTjdGH+veoW0uDcvl8lyWLpX/H0ZNQOXoxd90wK3ZK+QMRIIN0yXYesYj1dXGKIZZzP+/7bWEj/KHfRJTIaszcA0XePxMmS/L9G/P6zwLuROmWVf9Vo/+PL8GvrkGMyHEkuuISDpNCCbzpCqiduKdmFxc7GXqoQJcolDj7uQLQ6O6i/35FwsY97nPY616RKzxHQP9MnfJCY8tP9Foi4sJGNj1st60MS1ZoUXow5WNhlvYtO2S1e8uc2QS8Z9efw9h0xMwCDRzif6e531ukMi6sjy8kLYHXwJJiG3587YhYAf3Fx1p2nA6nOX8diYCusk1rN3lYAU+5qzEIEjPiY7gfAdky5GkcJ9L2Wcrs8FtZmPX+Y7tIgKvPLxy8iFFilsjBTu2ecVC2oKx0KlHbi63R/2tBhzvFfi9oWQJkd8ZJZvcpRkfjGOBOuA23shNmBOX9VrqW0UMBYOnNsBdeoT/YP0IWZHM3U1MuyAFTspZlGx8AM9puD9yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(921020)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkhpOXdFY1lsbzVSSFpLZ1lDWHVpYThGblVQQktLVnVvUmdZL3UwT2M3cHpY?=
 =?utf-8?B?TlVOb1VLVE01Qk84OWw1dmswU3Qvd0NYQ3JHbXdXK2hYdEwrYlU3Z0RzZmJz?=
 =?utf-8?B?eTQwVm1xM2RZTElhWHVtb3hOSGZONm12ZlVlMnc1dUpKNG5Vbkhnb0ZFdG1j?=
 =?utf-8?B?SnlmNGpibmF3VnA5OE9oS29kRU1KWEd1d1N6M3NHWlBteWlKSXdtdWxqZDJi?=
 =?utf-8?B?aHI1cVhIWmxHTVh6bGpTcTlWMTgyVEM5cWttYlVqeUt1aEZ6d0xkdXZLOUNw?=
 =?utf-8?B?K2VyTzk1cUlCV0cwd3JkZ21PbmlNQWhQbVhDL1UxTjVDUmJMNWsyK0tGS2FZ?=
 =?utf-8?B?cmcyajBmMTdJQjZUbjdKSWx5ZkY1OC9vM0dxeHRaOWFNWEhZby9HWHQwbzR4?=
 =?utf-8?B?TlF5WWZPeStLbWE0VDB4ZnI4eFJUTElwOTd5ODdubVR2bml6WGpOVGxwUnM2?=
 =?utf-8?B?SC8zT0FNZW9QODl1ekkvR3FmYTNIbzJzcGJ5WUlObU1uTklVaUUyZmFSVWxu?=
 =?utf-8?B?VTF6NzY1R1ByTGcyam1hdkpQaHBWZXp6V0toWWpBcGdiM0p0bFRmOXlxYlNV?=
 =?utf-8?B?TVF4cjQ1TExMN0RNem9mQ3V2ajJKZzVweUxTZnBEMDliamoxVWFZQU9HN3lS?=
 =?utf-8?B?UFAxNEdLd0NxNk1EYmVlV0NsMmZMQTFVcEFrcmRoeEhDTzJNbkhSUW42YzVJ?=
 =?utf-8?B?dmxqbzAwZGxUY3J3VzJuUnpEMURnU0tVeHd1V1VwcGRZTHVnUTE5K0p4T0NF?=
 =?utf-8?B?YmlZZGYzWC9iVzh1WVAyb3JValRaSjdYVmI0bll1SUN3OFdtdzBYU2VzeTdN?=
 =?utf-8?B?QWtCdTJOTy9qQmtYdm5IMDZmWUpiYk5pc2NKWCtBYjVXM0NLVXRXaGtjbTZV?=
 =?utf-8?B?d093YnA5bnRlZDBoSDNaUi9sWkNmQ2RnWjZKUHcrdzhabk5tVGo3MHc4YXlC?=
 =?utf-8?B?MXNvai83aDZxZm9PbksxNnpQcGxvd2N5VnpxclJhTHFEMmprRDJRWjVBMTJE?=
 =?utf-8?B?YVAzd1pVUjYvTmxIK0pKRFVxTlZmdkVLd0xURU1WYkpQWWEwaTdGYkhncnEv?=
 =?utf-8?B?ZXE5Y3BzeU1nQ1JoaVVwaDdQTUl3aHhyQVNkYXpNWVpMQmg4RE9YUFJJTzA5?=
 =?utf-8?B?SUxsTHkvNlZIc3lRajlydFBROS83R3BWYURYMmUrM2VCU3BCdWlJTWkzRlRE?=
 =?utf-8?B?SHdPQkJjYS9mYmN6dnE1YnB1cGJkdW56U3g4VFR6ZkQ4WkhsZWR3T0labkph?=
 =?utf-8?B?NkRPK3ZqM0xVTFpycmJ3dWpiK2IyWmNiclVQd2xpTTRrK2ZyNitvY09CSUpu?=
 =?utf-8?B?bXV5NHlTa05SeHFuOEdjMVowTlhUUExMYW1PRGVHc3h3YysxbVZqMG1JU3dp?=
 =?utf-8?B?Qm5TK0tqNm1WRjhoT2FneVRLSGRTUDF4eC8yK0IxTTlYV2twemxXNS9BY2RL?=
 =?utf-8?B?aEpjWmljbjZMNVZPdlVZMUJGUVJxbThXZzlMc3g5bGw1bzIwL3AzODNpQnlw?=
 =?utf-8?B?dlhheVc1THYyU2JpZnM1WnlVVlJRZkZ2M1l0cjQ2L2JsVVhEV1Q2VEFCaXlM?=
 =?utf-8?B?VUZKN2trVnp3Vk5rOGxuZnNMYVk5OEtJeDYyblg5NEZkOUZReUp6d0JtSTNH?=
 =?utf-8?B?OWl4WnpueVh2YTZ5Wmc5aGMzdXN5UFBVYnRWVzdFcXZLYmlCUWMwaS9Qb2Rm?=
 =?utf-8?B?Yzd3NUlVb0dwczBXZHY5TW8xTHU2SnAwR1lTdlFsSU5uVFJZS25XdFBsdFV4?=
 =?utf-8?B?ellURDZCUWF4ZkxHZHcyQ0p6SkZzY2NSUXRBQmVLTC9KYW1hUGxYYjBINmFv?=
 =?utf-8?B?cUQ0bnF3Y2lSWG45aExVSDFNQXJ6ZkRXVzYyMmJVNkVhbUd1azh0OHZKNGNK?=
 =?utf-8?B?a0JWSTJ5ZWNQamlKS0NYSk15M1RhcEtHV1VCdnozV1dQand1aTdzdkZTeHFK?=
 =?utf-8?B?QXE0bFdpYkE1K3F1eDlEQmxDSjd1aHh1WERyK0N4bHV6bGpjVlE1N0g0RWEz?=
 =?utf-8?B?T2ZjQmg2TmtJN2tDR3Q1dWdlMDRaa3NJTm10RXpOQ3lBbG5ybTVON0NrYkhl?=
 =?utf-8?B?RzF4Y1dpV3FRVlZYNElwa1JDNWRLcmtDUGRLT2xJNGlaK2wxYitZLzhWZm1t?=
 =?utf-8?B?a2loS2VZZkkyMWhsQWxWOEJXSUNLWENlYkp5RTdxeFN3bFhxb09SVjdHcStY?=
 =?utf-8?B?emJWQjVJM292WGdWbEJscFZhakFmSFpqTGtMeU83U1l1cGNmL0Q4M2ltYTh6?=
 =?utf-8?B?WThFeWpKWTlpSlFJenVyeWh1L1Z2ZjhpZVY3UzFnc2ZZTTlUamhUbXUybzBH?=
 =?utf-8?Q?XO1rWOKnoM/VNFBYx5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4f854c-5146-44bf-6ec2-08df494f0d97
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:46:38.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT6ypwIkliupNVzY0QYt7xzBwisruPM8wICwwwzi/TTug+jLP8A3H15w/DUw3MIjWP1j/KG63rnPX6e/DQGUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491



On 11/15/2026 7:46 PM, Mario Limonciello wrote:
> 
> 
> On 11/14/26 09:03, Vishal Badole wrote:
>> From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>>
>> When amd-pstate CAS is active, it takes ownership of per-CPU capacity
>> values that the scheduler uses to distinguish performance and efficiency
>> cores. amd-hfi manages the same scheduler state through its ranking
>> mechanism. Running both simultaneously would cause them to overwrite
>> each other's settings, leading to unpredictable task placement on hybrid
>> platforms.
>>
>> Avoid loading amd-hfi if CAS is enabled.
>>
>> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> 
> When a patch is authored by another person and you send it on their 
> behalf you need to add your own S-o-b as well.
> 
> Think of it like a chain of custody.
> 
Ack! Thanks for Pointing this.
>> ---
>>   drivers/platform/x86/amd/hfi/hfi.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/ 
>> x86/amd/hfi/hfi.c
>> index 86a7f4332c35..b6878614e2bc 100644
>> --- a/drivers/platform/x86/amd/hfi/hfi.c
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -29,6 +29,8 @@
>>   #include <asm/cpu_device_id.h>
>> +#include <linux/amd-pstate.h>
>> +
>>   #include <acpi/pcc.h>
>>   #include <acpi/cppc_acpi.h>
>> @@ -536,6 +538,12 @@ static int __init amd_hfi_init(void)
>>           !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
>>           return -ENODEV;
>> +    /* amd-pstate CAS owns heterogeneous core scheduling when 
>> enabled. */
>> +    if (amd_pstate_cas_active()) {
>> +        pr_debug("amd-pstate CAS is active, not loading amd-hfi\n");
>> +        return -ENODEV;
>> +    }
>> +
>>       ret = platform_driver_register(&amd_hfi_driver);
>>       if (ret)
>>           pr_err("failed to register HFI driver\n");
> 

