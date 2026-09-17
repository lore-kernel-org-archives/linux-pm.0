Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169213B7771;
	Thu, 17 Sep 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669244; cv=fail; b=J49aUelDz7NNjIlNodEnBnOljewIhJ1dSLu1ZMstbPDMUKu1QLZMHTcM8y8cXO2hgs6Dl2DPQy1hJcvq0iu62XzDmY20trEwGEcJMSKwaKiMlV9W1Sabgd3HqqzBqYBYSvmZt24tIyVvx6VSVrSAV7yG7zwlLyYYmTFBKZbSGo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669244; c=relaxed/simple;
	bh=2BlUbLVYqdLzKw1VFDrt8hsGM+kDUpGbXnZYXMPNiKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FH2Khn68lSVdP2wHAKHa8VHbVjk0o5tI+nA/49v/9spXuH1fqFe/aWVeXRVLt/aPW3ywydq4cLl24u6omKVytNW6qXvkxVneIUWF5GLihUdGM6SzhOEoqjcSJpjBa/rLQYy+UamhsKZb1gCN7Z/J+qNOoyOhm1j/DTLZkqot9kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izoRzZMY; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izoRzZMY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRoyI00M2SRZkaPwMBQs80shXHwbitnPLPrfGe3QrqMAXilvscOBN/7jMF6RYNycFdUR807G3BX8Rw1TABA8RFNc/FsYdAeCT+Bck7HVN1X9yGyOab1J9yder8soSGonteICbgDAhnxOvnr/HLkOtik831SpYOU3FglJX1N8O5O4y3fzBvzlJ0amwF6S9PwXF0t46NdQwu3l8Nda/oKu53tNdFNvcf47tbVCWyHuEiWFxsSu0FLNQxnc+XF4cQ1zVn/OHtQtUcNudES2uCAk0yItNg9BCs9e0Uvixxt5kQ4Ys4SAaclZOu34ckyjlL7rpc/cYhGOhL9rN3VLgdv9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpVIDpOdZPuuqdD6DG+RTMkOUULTVaBl9gCt1p1Qr/A=;
 b=PRDwCu3PWn8g8EkAI6gPogdKOQHEEgfglYyo0goS9xKZjP6DIVC5zALB5PuJLNQFqNFPplwMPtp4D3iG237ssIPtTkiYZZtIlPfY1RSAXkhHvqYYYbqmtXvkYb8IxnaOlJTY+/J1mXLsv173snyD7zLbK9f84RpfbO869jNkW9DDKQkkv/ipkNJ1OIhx/FDE1lZxC0w94sMfHFd00ncBRGoMqdxi5ryCaVWX6e5vX9v8hcphDp7+BDMjez+ZvdN5oud7KEBYNMJUwIzbBWXPkLEZVanbvGneV0Bv5vnHBUKKfKaZz0TLyGvqENr6s+cS14hUUUU+MAIl5q48fxO7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpVIDpOdZPuuqdD6DG+RTMkOUULTVaBl9gCt1p1Qr/A=;
 b=izoRzZMYVkrEd8i3caOJtm5NfZGuwbUJoZbfhs5uhRq1JrMripFM2VXAUlaFPP5NgGB3Qt5aJoN019s2GXlaBll0KNqa1Io8ubQ3m4s9gIIdRU8Lb0mpTB6jdLHPh4aiQ7Cd40fwc3K2qqkxg3E1OQBGcOiX2Mqc0o2i4qbO7z3UHMwas6J1iPs/7+G0RnTarhDAi8+fiDYpQ35WRMyNKYkS4WSnHqHAk3qa+WUBJFzLnJizORz7+eiDNGhP66eRLnBdksXHA1CuL2tNsYOzX34jXFecUdqvS6VcyHEokqusxxwaHr/WkGtX61jUsnM654hBcCaQfIAo3ybeAI5tYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:20:27 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:20:27 +0000
Message-ID: <74592f6d-92b6-4cb3-86cf-ddc3a4ce6b09@nvidia.com>
Date: Thu, 17 Sep 2026 23:50:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/20] ACPI: CPPC: Keep Performance Limited clearable
 on NVIDIA T41
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260916162805.1039247-1-christian.loehle@arm.com>
 <20260916162805.1039247-16-christian.loehle@arm.com>
 <9ad67536-7b6e-4633-8cc7-52b0d68196fc@arm.com>
 <CAJZ5v0g-ipGKWyEUKrBGTo+B6RYqWxba4KhK9RaCJmh2MRLtLA@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0g-ipGKWyEUKrBGTo+B6RYqWxba4KhK9RaCJmh2MRLtLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4a) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: bdac6b2f-ac99-47a5-2d5d-08df14e85923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|4143699003|10067099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Tkyrqod0Ec8OEEeqzJK0sMYRFJiIBiW9St/v/R0dhCelrmG63C6ZRIPjttT5pM0Cfoqk1b35Z5YgIhDOOLriGy6wYJmrEqt5SSyRIqzDfVh/z3+/SecGxEl18qpYok0BZTin2QYVo74+j4mZQOalfWadalnRsKlR/OStcdTcTk+75bZ9/CJwyJIyFJZneZ1HZ24jvhXiarRHJSg9y+ul7a49QxmWn+YM1t+1pSDSPUYNrTMZU88F9THmn+9EzpZlJK9Avbateox6zZWxqQAviMkHUfZqs7G1lwHhiU1wQnNQvsMgdy3+1AMwP7zkZw+yXXPMyqCPBQdVCFqKkZBt+t3XZNR6NzxIaAs6Z91O4scXLxpGd9ulE3G58G3P7q2bVt8SHO993gh+wiyO3nJALuHgzW3E16hEPHIOTy2Ny0eYNWWC+igOZZtqZ6Q3nlIk0CtzPHcKasvAMgCugpnFli2q8zC00iJgi7AIir4kiNxk7I7c9l3Bw+VzNPUEXZEdhkrIIWj81MfOZYNiP/2H+ZnCkzW6Z0wWpwKslYt6gdD7ebZOJSyCSaldaSPbPKysPyXxE2UCKwDsk0tNmoVmfwSstRxofYshs4jDMFcDpunsecZdiFt/4v6ZKkOYFH3/ymitgaSrWeRp41G2ddK0ZXmWKKqBFAaP1WDbCkLg7Pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(4143699003)(10067099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUFIbnBhR2xtcjB1cTRRU2VZRGFnRi85Q3JrSFB3a3JPakx1bmNLNlcxVHZL?=
 =?utf-8?B?YUpveVlBaDhiY3plWHNEcDhHUjVyTkJ6NHFQYVRYS0s1QTM2MjB0bXNBU0JH?=
 =?utf-8?B?NWZGSUNMNmtrTmFodEk5UjczTmMwTG5xOFZMNksvTWF6anNzenJidGtUczRv?=
 =?utf-8?B?SkdiSkZIZlVHMnhUVUR1NHZwNHhrTnNsNXY5eWQ5N1BTMVdVRmxQWDRIOHVq?=
 =?utf-8?B?RkJXS2Z6TzNTM2dvVWV1RWJEWmt5TzZPV3hHZEgwcTI3bnhTamNvQ0JsNm9V?=
 =?utf-8?B?Mm5TMzdXWE1qczZGQWZHZVBKTVpLTVJxOCtSU1BVVTJQR3cwSktYMXluSTFV?=
 =?utf-8?B?N3dMVFJQT1pxZjQwdXRkWTN0SFBnSlYwbE9NWlBkbUVtcTI3QzNiaEkwWGZY?=
 =?utf-8?B?ZVhzL2FETDV5TDdvR2RlZjVuVk4yZGUyb3ZoQ3hZcWcxTm1nSGhXNjJIdG5K?=
 =?utf-8?B?N25lK3BINGdZcytHMHR2RXJLRVFoZVBiTjhtUTFnZjdNMnFRSE5PMVJVY2Vz?=
 =?utf-8?B?SDBvdGJ6Q3hYZ0tWQkhSamIxNGhObWg4bUN5ZXI3QTJ2S0cyMWNFUEgreGZJ?=
 =?utf-8?B?YzFPeWR1NTRXZ25Jc3RWNGdlVURoQkxKVnhyT0xqRjZaVkxXWGVaalk5TUtR?=
 =?utf-8?B?eGY5YWJwS3hkcGphblZ3ZWgrd1Z5STVXSjd0d1MxOElUWldWZi9EOU5tQWhC?=
 =?utf-8?B?aDNac0FqejVaS2pEa0FkSTZrUnZaRDlhY3k3UUNFK3dzME5TWTU3V1V1TjFH?=
 =?utf-8?B?dm9nNjZRSFJIbVY3a0VOZ1BPalBFejRHbWpQMk9uUUk0U0k1RXlaK2lKOEJZ?=
 =?utf-8?B?K3p2bmI2MTZtaW9PUTlHU0RwRUpxK2tHdzE0ZUJ4ditFUHNVM0pJUkg1bmIx?=
 =?utf-8?B?UDF6RVRKbklQNFdWMzM3UWFNMW83Zk05Q0xhd3hxWDQ5ZjhRcEVTM2k2S29B?=
 =?utf-8?B?WTJpNWh4Y2daVkYzbXB6Yjc2VUhUQ2hONGxmcHc1bGlsQjB5eVVVODZSNHpD?=
 =?utf-8?B?TjRwRWhZenByWWt1RXY4dlhoU0FOZjVLMm5iUDhZMEwxZGRVaVhyQ0NTTXR4?=
 =?utf-8?B?SXJzOFdiR1Iwb1FyaTZDSkp3azZqVFg3MUI0QUF2OVM4ekNZWFgwQ1hDaWtO?=
 =?utf-8?B?THlqU1F1QnBKdy9LNFdCUDRMVmJyZXJCWXBobStUb2ZydGlEbC8zMjcwejR4?=
 =?utf-8?B?Q2tuQ05rbzBGcjRGQnd1RzdQR2JTVk90MXJnV1lGNUlSYUNQY08rTEE5ai90?=
 =?utf-8?B?aGYxQndEb0k2ZE9nK1NIYTk3SzZFUk1MRlhZK2hlOEJmczBnQy92U3ZqV0cv?=
 =?utf-8?B?L0pvOUpiNStmNkVmS3N6dXlkcnVUQjNQMGNIRVNBZWNrK1BOK3E3VjZxV1hQ?=
 =?utf-8?B?ZGxmeVJ2L09aR2szUlJ5R1VpQ0ZvUS9SeUp6dnUybFE2bDEzbHlRaWtEUDVM?=
 =?utf-8?B?KzFHUHpkbzZoc3pNODc2TjQrdjBTTXh4Zld1UTd3Z3J3cmJYN25uUE4vNE1U?=
 =?utf-8?B?UVp4NzZjSWViOFhCUjhVQk5qb1RVbTA3YVFXNmNKRGpLaTVWMUh0Zk1DQnNH?=
 =?utf-8?B?TkxTMlM3OU5BMmNqT3BZMzVHV29NemJFc1ZaemFPQ1BWUHU0S2Q5VWw2bjY1?=
 =?utf-8?B?UXIvdzYwRE9TYVVkdjhWZU9jKzJZWm9xNENlN2NsWFQ2cmg2NHJpMWk4YVlh?=
 =?utf-8?B?NllEMklpc2dTOUF0eklkekhON1ZRc3BvZFpWVzJ4OE9Rc0swYlpEMjR6VHBj?=
 =?utf-8?B?Qmh4U0htZm8wNzk4Z0xYNFM4eDlsVldESmZyOEZubklVcjVBRUh6bVBUVlZH?=
 =?utf-8?B?blZoN0orUFRwanRDY0xqcmhvV3kyU1BpTXZXc0NFb3dLWGZJRGt4cnVsaXdV?=
 =?utf-8?B?ckU0RjRuSDdnMThVR1doVFIzYThIdlRrdk8vSTJiWllDNFFveEQ3dXVrWDVr?=
 =?utf-8?B?R2daZHpzV0x0aTNYUDZ1WWx1aWNPbzRDZ3RyVCtPZ2NUTnlFU3c1cFdWZEkz?=
 =?utf-8?B?ejZHVW5xdFQ5UkdCK2ZsemRaNHdVL2lTc2puYi9TYzdsMG56azIrOUpwZE9D?=
 =?utf-8?B?a3lVeVEzb3B6MHlqM1JnTkxDcUNHYVlLVWUweGhGTEs5dWVhZGJVRHVQR3Bq?=
 =?utf-8?B?b1lwcmhRenJiWHV6ZnJCREYyaTV4ak9ZZEpXVFpwS0JqSUh5eVFQVEZxZzc2?=
 =?utf-8?B?RDBWS1c0MU1rc25wT2pQRFBOaUpBeUd2QlhydE1NeUNyd3RDaXF2N2VaTHlH?=
 =?utf-8?B?QUt5OTVrZGVSQmZ0TVlzOWx5blRzcVZXQnRDRTBXMllYbFBYYU1tNVFUaVU2?=
 =?utf-8?Q?r9A051geILJZMvf9aK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdac6b2f-ac99-47a5-2d5d-08df14e85923
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:20:27.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUf0UN4KFMaZ721wpyNRPoeme2fSXmXEu6WxD08EviVKk/CV6tbP0bUIb81EvnI2GPFZ5nj7qCRVAS2rGv8xhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873



On 17/09/26 18:53, Rafael J. Wysocki (Intel) wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Sep 17, 2026 at 2:59 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 9/16/26 17:28, Christian Loehle wrote:
>>> From: Sumit Gupta <sumitg@nvidia.com>
>>>
>>> NVIDIA T41 firmware describes Performance Limited as a two-bit field at
>>> offset zero in a DWord SystemMemory access unit. Generic CPPC code must
>>> keep such a field read-only because preserving the remainder when clearing
>>> it requires a read-modify-write which cannot be interlocked with platform
>>> updates.
>>>
>>> The remaining bits of this access unit are unimplemented on T41: they read
>>> as zero, writes have no side effects, and no other register uses them. The
>>> Performance Limited register therefore owns the complete access unit, but
>>> shipped firmware does not describe that property accurately.
>>>
>>> Add a CPPC platform-quirk table keyed by the DSDT header and carry quirk
>>> behavior through explicit flags. Cache a successful table lookup, copy each
>>> GAS into the driver's private descriptor, and apply fixups before layout
>>> validation, mapping and overlap registration.
>>>
>>> Distinguish a genuine non-match from a table-header lookup failure in
>>> acpi_match_platform_list(). Propagate lookup errors from CPPC probe without
>>> caching them, so a transient mapping failure cannot disable the workaround
>>> for every later processor. Existing matcher callers still treat all
>>> negative results as no match.
>>>
>>> For the known T41 layout only, widen a two-bit Performance Limited field at
>>> offset zero to its 32-bit access width. Clearing both status bits can then
>>> be issued as one DWord write of zero without a stale read. Corrected
>>> firmware which reports the full width is unchanged. The workaround
>>> therefore lapses automatically when corrected firmware ships.
>>>
>>> Link: https://lore.kernel.org/lkml/d5f1ea9b-53b7-4db2-983a-b5be8e71a371@arm.com/
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> [ Rework quirk matching and fixup placement; propagate lookup failures
>>>    without caching them. ]
>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c | 72 ++++++++++++++++++++++++++++++++++++++++
>>>   drivers/acpi/utils.c     | 13 ++++++--
>>>   2 files changed, 82 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 6d130381245e..0e218f2be0fe 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -330,6 +330,68 @@ static unsigned int cpc_reg_access_width(const struct cpc_reg *reg)
>>>        return reg->bit_width;
>>>   }
>>>
>>> +enum cpc_platform_quirk {
>>> +     CPC_QUIRK_PERF_LIMITED_OWNS_UNIT = BIT(0),
>>> +};
>>> +
>>> +static const struct acpi_platform_list cpc_platform_quirk_list[] = {
>>> +     {
>>> +             .oem_id = "NVIDIA",
>>> +             .oem_table_id = "T41",
>>
>> Sashiko:
>> "Will this quirk successfully match a standard ACPI table header?
>> The ACPI specification requires the OEM Table ID to be exactly 8 bytes long,
>> typically padded with trailing spaces by compliant firmware (e.g.,
>> "T41     ").
>> Looking at acpi_match_platform_list(), it compares the IDs using:
>> strncmp(plat->oem_table_id, hdr.oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
>> Because "T41" is a null-terminated 3-character string, strncmp() will
>> compare the 4th character ('\0' from the quirk definition vs ' ' from the
>> ACPI table header) and immediately report a mismatch, causing the quirk to
>> silently fail on compliant firmware.
>> Should this be padded with spaces (e.g., "T41     ") to ensure it matches
>> the firmware's table correctly?"
>>
>> non-padded "T41" matches exactly what Sumit proposed and was discussed in v6:
>> https://lore.kernel.org/lkml/55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.com/
>> So once Sumit adds Tested-by: this should be fine.
> 
> Sure, thanks!
> 
> Sumit, any concerns?

Hi Rafael,

No concerns.
"T41" without space padding is correct because this firmware NUL pads
the eight-byte field:

  # od -An -tc -j 16 -N 8 /sys/firmware/acpi/tables/DSDT
    T   4   1  \0  \0  \0  \0  \0

The quirk matched, producing the following message during boot:

  ] ACPI CPPC: firmware quirk: Performance Limited owns its access unit, 
using Bit Width 32

Thanks,
Sumit

