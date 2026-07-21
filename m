Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB645BD78;
	Tue, 21 Jul 2026 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629461; cv=fail; b=hPBz1BdG7whMjNLk11+0chhY7xas0wimIdwFRPiI5aIEl45J2G6u53nC4MahEaTUn9PWRXYjtRuJ2cBWTFZpQ9ilzmqytqwUryZ7tvycNEfaHllFJluG1k8pCAh1hnKA/ahQzBAgLITDZ3xVYnO5r6VFgPdnaflOaXz2UnOFPFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629461; c=relaxed/simple;
	bh=guapHNhP2U5Fis61mArMye/8fn9IRG8TGtY5Ef1Lcdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=stcYm07WwE7fJMkYWGgywnsBPAmRaISVcacx0JlDhl7c4YOijVFPsmGzzRlsuqbncfVQWRRETd+njffM0vhZS5BcuQC6fYIqgZHtjgT1qgez8NpPB8qJfsMhAa3pcLWF5nXK7IO9ZDWzrtt5y8TVbxgU44KYfcpMH+qITzgubQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kVVAnDRM; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kVVAnDRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mglrHxHUPwU8PZXRIoJrcaTXXOGyCVyVRqoQRw2ZTJ2orJ5R6WMe4/ZsAgKBQkvnEuicbJo/iwRsFOtAFJBL5WKzi4iP6vL0Y5Mvz2vksJnpG4Bjx1y2O8kRUCvOFrSk7kYwkIwzy9DukysSVuqWvwtTifoO4qKPFemll9L4Fa7Vhfo82dS5ptnX8Gm1L9wy+iBsi6SRyKq2GgJroa/DNR1d/8n6do4O1BGpnJL7noofQHO1MSGnE72kJ20LCPGwdxIpcnnwSCPZJjOSnPritdkSKZM7r5ObS/KtXPUhjHOfQ5EOB76fxnWrzNcwX7oksafFViF9VnfjrNoCu9U25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt3+5AJb7ESasRP7an3/tVkWrS+5XBoFqVlnMaXvCig=;
 b=e5cMiZ46xGCuTg7Mfz+5tFVqptCSYF3CJIpCoI2bHMD5HOdwcyY/zrB4y2/J6oF5dUyxVirLvHiavJo55M2qjMoKGUAKt2Ie3a4sa788BFtU0e5rDnSszOxD9jqW09ZShso4Grv1xF+wDsl642YHH0xk1fUkWIGDMXh7UhsN/z/uZIKi7/pARSqFWQReu80fbk7J3PuZzZTSD4mGvzgznB2Vm8zYO1ln2PeTzOe6ExssM+RTAnDwDMJyzlPpe5C/e49WFdvn/ePQD8GK+hxvfLr1NRyvvTrX6Qv/nJspArhQoJp2VGYgguod86Liq91hG+pRWFXCpXHf+JDgj0ZtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt3+5AJb7ESasRP7an3/tVkWrS+5XBoFqVlnMaXvCig=;
 b=kVVAnDRML0aEYfnt2bs9UpPQMM1lNIoS1BY3FzKhUJVu75n1HWfnFj0q9dV2SaQqfDYBzXb1rV+OkR8JgeDd0YnPizDDVD9UwaxKrsZjIvf+GGNL+sNKvnRVo7l6zxLaWD3iKuap7JK+7fjxMXAf1rfRzVscq1XscHxe2dx6/s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:24:10 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 10:24:10 +0000
Message-ID: <d1aadebd-9bcf-4198-917d-61f12702e364@amd.com>
Date: Tue, 21 Jul 2026 12:23:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
To: Guenter Roeck <linux@roeck-us.net>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
 vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
 Alex Shi <alexs@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Brian Masney <bmasney@redhat.com>,
 David Lechner <dlechner@baylibre.com>, Dongliang Mu <dzm91@hust.edu.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shuah Khan <skhan@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>,
 Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yanteng Si <si.yanteng@linux.dev>,
 arm-scmi@vger.kernel.org,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 linux-arm-kernel@lists.infradead.org,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
 <ak_Eu_eQKalPMwo-@pluto>
 <CAPx+jO9KMcxnmt-wT5jaApj9p7s11B6eSG6K08Jt9J=-vXxjhA@mail.gmail.com>
 <612e3496-2917-4d4c-8794-69c3b5b27c5c@roeck-us.net>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <612e3496-2917-4d4c-8794-69c3b5b27c5c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e3cac1-a103-4a54-82de-08dee7123452
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	I/4XNPbAym8HegBYb+vDMA62dSDw7YgGQCz6ukgx/2M1vPk85gCQ8AkMu988zgzF75cvlewaErmcZxTAFnJicepjMfzA10XKFfsQzZ2invvtRFlgedgZZWia81Gmplyz/UZFp2Ded3BP0f5XYSa4S8xaF11O6IhUd0v+rLaoSbV/oAt9wDICZa8qoYaZWlBZfhDEnCF1pl0cDQQ+TilvblYCQgTHA81f0hppop7qnrI+eGcyj+0NBMwiTLaALygwK58JVbJn30h+vItyGLie4/10FEbDF4lNoLChjDXwINz6Sl6BVnseRc0PvmWfa8S2VhO7rkjcHUF8P7aTwJTiMOmdVPqsMq6oNDwMf40CR4KFa9ACj9BDMgb5278qnkfAVi7jqllL5XQiHvrymDNZKWjXeBKvNHJPHhx+p77i0/mzb76EyveCsUiU097XyPUuv9MNXNBBEUn9znaEoRYWltUOmDIyCK3VBQL4wd4GN0iNr/JeqEceyMMy6rLxiuVLNW9O4wn16W3LEtHjOy02Y6AyPCfRIkJXjVCMAdzY9+zE3tL4Qr99UUjGvTSgeQYnTeXb7Zb0B+zTOz4lxzzEZDdU9XvL+05bbt2mIiZnQby+4OoI0EW5z/pDj63jzPKP4QwS0+iht+OT1/nsgr2njZ0JfWliWWc+BsH/z4XZc7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akl1WCtxZDltUUZ0dmpCKzN6ckZiZGZwanJWRitRb3FOUC9jdXFZK0s1bTBj?=
 =?utf-8?B?WTFTcEF1RENjTFFKWVdqWURYaTBES2NIa2oydWNZN255aTRpblArT0Z0Sncz?=
 =?utf-8?B?NVBramZzNDhnK3FOSjF1aWNQUEd0Wi9QUmFZQnc0ejB1djBveEVnbUtjY0dI?=
 =?utf-8?B?WTNwK0tPWHgrWDNaTlVzNnhVa0g3VmlFcTFrUHZrVFU0b2M0R1VpWVo1ZmtB?=
 =?utf-8?B?b2NTV3h1VG9zZVkycURtdndJYmN5NWQ4bDZNTG9UbG1WckwvdlR4TENnR0VD?=
 =?utf-8?B?TG1hV1FDVHBvVzJNTnU0TW13U1BPWnNvM2p4VkVLTFZpV1lmU2dEbHNsd2sw?=
 =?utf-8?B?eURsbEluSGVOWVZqMUFEU1VFTFZTZmhGNUEyblB6VlJTWFRBNHkvb1FQRTNN?=
 =?utf-8?B?M2xzYjlMTXEzZFZrSnBwUVhRV2s0cVgwa1A0YWdUb2FwU3NiQzhMVWpYSS83?=
 =?utf-8?B?bUthV1RmWGRKaXpRaFpiVHFCRFFBcXE1L1VyNUJyblQrRURFWWFqdG44K2M2?=
 =?utf-8?B?bEIycU9xUGYyc3M5U0Z0MnhYSDdYZDFRSktHVHJVK0lGMUh0aDRVL1NSRE1p?=
 =?utf-8?B?TkYxTmoyTjZoY0gxdUF0VVNlaGFzM2lMUzdMLzJab2E2bDVtaHNWVzNqSnps?=
 =?utf-8?B?WUxqaEVOcHJCQXVPcStpZFVtNXllc0c5VnNGdzdKbTFDMnpyQUtHMkFKWEsv?=
 =?utf-8?B?akxGZWhuSklJOWRUN1lrS05lbWdvcnpLUVVpSExWOE83bmZTTW5wd2xEd3Nz?=
 =?utf-8?B?TXM0aGxCNVhCU0kxVUhmYURReUNKWFRoTW05eWVza3N6MU9XVmRycDlOdUVR?=
 =?utf-8?B?OW4wcFM1cEFOb2IzWlNpTjI5M2xSUzZ6dDhGVjU2MFB0bzRQeHJtNlpLMFZX?=
 =?utf-8?B?WmZYZXBsSi9PcURtWHNDZEc4akZKM2RLSGg1N2I3czhDTWRDVTZRVklOcUlk?=
 =?utf-8?B?ZTIvT0Z3TkFzcm41SklLTSt4a1Vka2FNWCswa1VWTWhUN2V1RGtPZ1RuWTRV?=
 =?utf-8?B?K01YQW4xdjN3L3ZmV0JkcjAzMXZSMlBxYXpNaDFlQWhkNnlHYVk5Vnkrb0pS?=
 =?utf-8?B?VW8rS21pQU9JMWd1SGszakd6R2tZS1JQUjdBcHkydXJTL0d2QjROSEJJYkp6?=
 =?utf-8?B?SHNMWCtaM1Yxb1BmK0tZZHBJSlQxaUZ0cktUS1RVNitTS0p3dWdCSFErT1NX?=
 =?utf-8?B?WCtRWlFZSEF2TXNnblI3eTdjai9rNEc5UXc2Y1RHcjljZEdBU1JINXlkWlpL?=
 =?utf-8?B?SUdxYzBSSk93dDI0VlF3STRMck1ySGhRelUxREw5d2ZmSERxQWNrckNNR2NK?=
 =?utf-8?B?YU4zVjRzMmc3c1RtNkZLWEM3eTdaWmd3Vyt6bUl3Z2FMTzNPVHo3VEZNRG5R?=
 =?utf-8?B?YUd2cUVDNVUwVkRTb1hZSmdOcGx3cyt2akRCU2VDSnRHUTF5QVFzak42MmVL?=
 =?utf-8?B?RTBpdjllVXdaWmpFUk5DRG11MWZieit4NTUwTW1QZS9TbU90SWNQRXMyNjR2?=
 =?utf-8?B?c3NJczUxdmMzN0dVcG5FbnVkM2I5ZGs3R2duUDZDbExhL1J0R2sycXhXcEdl?=
 =?utf-8?B?QTZhZUhBcjhpME9pR2tXdElRdHVndnQ1bWhzVCtMa2FhdWNBdHkzL3hTcVZ2?=
 =?utf-8?B?UUNHMWtjbU1rZGJnTnMzUG52NnNWWEkxcXl3Z0daT0FHR3RDWnAzUUVySjRP?=
 =?utf-8?B?SVFPalV1VEJwUEhQQW5tRVFMMmV2Q2wwYnMvbXV0SFowVUt1cUxuY3kvczZM?=
 =?utf-8?B?Y0NrdnV5M293UkhzUE1MYmplWGhvWWM2bmdTVDJMV2VYMUE1b1NXRGxNSlZl?=
 =?utf-8?B?cENGeFBacDdMZXVmR0ErTEgzUVFBZDFxTWxPYjlPV1FmSkhiNDd1Y0ZaODl0?=
 =?utf-8?B?M3VXRjhMYTMzZE44ZkNzcDF6TFg4UDlnSGttTWttdFk5dnVmSVhqT2R4ZHFO?=
 =?utf-8?B?a3JXa0p2UWdEdEZoWnlWWVhDa21wUmZNUjNHdUVjNCtsWVNsOE54N3BWd1kr?=
 =?utf-8?B?RDdwWE9maXdBdHRnZzFzVVFEK2R2YTExemV3RkdUOGZ5akxiaE1IMlR3WS9T?=
 =?utf-8?B?encydWVlRkhUa3FycDBMVXdzMnhxakRWaVErYTZ3U1hCOEtwNm82YVZ6ZEc3?=
 =?utf-8?B?MHdkUFJVUzMzRHpUT3FpczJKZlc4Q2tmeWtyM3ZnazdMTzVUOWJmV3dUajl6?=
 =?utf-8?B?K1N5bi93S0FFYy8yNjJQVTlJMjEwWWxXVHliNVREdkZndkpzclR3MnVaRXNP?=
 =?utf-8?B?Q3N2UmpTNnNFekRsd0ljNzFnaWl2bmtZZmYxNW04V3lBTXZJaXVCc2tVTEhK?=
 =?utf-8?B?M0o5ejE4RVJ0S0RHSklML2RKV2hiODgyTW1yOUdSNGFBQVdQSDVhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e3cac1-a103-4a54-82de-08dee7123452
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:24:10.7756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2Fr+h24GQQ2RuUTaP3ZejCBvTa6KdrA/Z2ChT/6R4VJNBrzF1OIc8Rq3npfsY+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201



On 7/20/26 16:43, Guenter Roeck wrote:
> On 7/14/26 06:16, Ulf Hansson wrote:
>> On Thu, Jul 9, 2026 at 5:56 PM Cristian Marussi
>> <cristian.marussi@arm.com> wrote:
>>>
>>> On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
>>>> On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
>>>> SCMI server from different architectures than ARM that's why remove
>>>> ARM/ARM64 Kconfig dependency with also remove ARM from description and
>>>> rename folder to reflect it.
>>>
>>> While I understand dropping the dependency on ARM (I always wanted to do
>>> that and test if it worked at all on some otehr archs with QEMU), I am
>>> not sure about the whole renaming party ? why is needed just for
>>> cosmetic reasons ? it is at the end an arm originated protocol so I dont
>>> see it as a being wrong to be named as such even though used by other
>>> archs...I have not really strong opinion on this...
>>
>> This is certainly not my call to make, but I have to admit that I
>> fully agree with the above.
>>
>> Usually we don't rename files that indicate a legacy platform name,
>> just because a new company/platform wants to make use of it.
>>
> 
> I agree.

Just to add a data point: renaming an ARM-named-but-not-ARM-specific file when
another architecture adopts it does have precedent. See the EFI stub/init, which
were renamed precisely to drop the misleading "arm" name once RISC-V reused
them:

2e0eb483c058 ("efi/libstub: Move arm-stub to a common file")
f30f242fb131 ("efi: Rename arm-init to efi-init common for all arch")

The justification there was the same as here — the code isn't actually
ARM-specific, so the ARM name is misleading once a second arch uses it.

That said, I agree it shouldn't be done purely for cosmetics; it makes sense
when it's paired with the real change (dropping the ARM dependency).

Thanks,
Michal



