Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EFF9C0;
	Tue, 25 Aug 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641138; cv=fail; b=ObHSdbmMBYYkqQn5r42hqi9fer4kTGr+XpGyFoWP3TY7UuY3ROwl1nR6I4R292oLopZSc2rHhMX3Yb10X838ryrATjTAkdy3kfjagqAsB5h61cRkMsJDRhXi6USYEfENTYnckg/lXrdUNGySRiwXMr1NkDPseUvKWkiABNQNBMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641138; c=relaxed/simple;
	bh=rDHegkFWDfMIuXe6ZzFIR+I/VcEuFMYXMzUoHkMTa9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHmWpipXRjomFZyDS9RECfsFf2lJjcX5qdWDkAOqXF60fYdr/NXE/FCza0QhGt75I9citf1exXYcz9QSvoRnjDHRF12utbTIpC4CpECtNUhC8KpvzHDdhgyK+4c/SiXA8rAHPc5j7TACEfYmCBEsfUUSqT0a1exThQfC0bVJalU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SIHCN24P; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SIHCN24P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv3aFyu4+0W91RiCXz/q/ZIspKNWNfm7U+oJkoChvCxJiUjSnvFTLG86XcJlByG9vCzsg3wZPmmfvZpOE/9mNj9ffegGUhYd2YJgIQQcLdevFnNTCd4OnjxDRJNvQnVfnw5d36BUjBmdFcPQfPZHHCMnxEv97nwuvDhGI1FfNQRxlfhyrzWs5IET2I7eCYBJgIka1n5qRM21lGLKJ5ptGwmpZULErRd3tczbMgpCOI8V7KSGVrepkqEe6Ie37EbL0yNfW5y4P7QdrahtYMyUS1KSpZaVXJXkwgfn91awiiPY06sMlc8SCE+OGW5h9xs1bOjgM5va0lDKhGmaWU/rNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=levMmdcfHRNRUHYJuvVcC0ByXlqHx92xxTafjGAZLaQ=;
 b=xCYHQ6mfv8mK62R3GDP1fDL1Ja+V/3O6kaxzvkTvqaL2E5tYKEYDa/QtjyPdQ/ImXOL+1CVeYPz4nP3pGPHxnyzH4FZg0vXeP4bHCbQwr0Z50nN5BOy4to/W8hswiBuaISmmfswNlwG05ZkNtyOA5yz+9mwPqohvBdXuJFtUoJLk+N5fLClUD9MaojD3/VHvePDM21A+dC0GsJ0WQeH6xe9UKCt84Ee97s/+AOoZD67q3o6xEFyPgAHAGgyCNRLWBw4iY1QWZQe5uRrVTSLqLO3NWUXN0UFyQBGDhC3PVbk63klb04j7qFcpAoufLZZcPnirb+TaK/DVZ4cI23vGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=levMmdcfHRNRUHYJuvVcC0ByXlqHx92xxTafjGAZLaQ=;
 b=SIHCN24PSgTbHoR5RAXZriI3XZpO4K24JY3olfh7hyoFC9gYnW7SIgzO/kwSg2r95ojDZtviw/+Neb3/hWge1040LYKCmscQgj7IVC/JcNPN74sDNBmJ/2b8iJ6IiYgFZtSHIzIy5Vob+46z7aVK5oBwXmR7MQ3LS6tc9qoxTZCWHv3f3K1K0gEpLlm63pXZwiDWSqXHuHvidX8wvDBx8KeFhbN2Ysd/tmMZKrbR6VUdpSqyyg4amI+2DQ2aPh7oeJAK2B3OHVHCS4W55o1GqzoOi1VkZ9ARAf0+jWMaxv2FIq9Um4L8g1HjLLK8X3Kn0EDWI2QlztL5T89UU4qHYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 06:58:50 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:58:50 +0000
Message-ID: <3a23d54c-5ce6-4225-82d3-453e7133fdf1@nvidia.com>
Date: Tue, 25 Aug 2026 12:28:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] ACPI: CPPC: Fix register access and lifetime
 bugs
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, K Prateek Nayak <kprateek.nayak@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 jarredwhite@linux.microsoft.com, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,
 Shubhang Kaushik OS <shubhang@os.amperecomputing.com>,
 vanshikonda@os.amperecomputing.com
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::12) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 1208f084-6670-486f-bc21-08df027650fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|3023799007|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Iq0mYuB9S04ReB4UVaNosOwmiEw1hBncI0jMZC74GsWzochoVKb/pBZGR/mjldMH+BZ3MF+vVZrPlWJfhm0+9pLd1V1CwBBCICji4CNWB5rUK3FuJm8ceJ/NkOo0eEPv8/QmRbxCHXMoGJfUjV6lwApNyDsoLMJuDvyJLeWJ+k6q6vLYk/bPyW7kqGonNf2d7ha5vtcwznuqxqOFcNJwy/KrDLzL7BIgNjHJt7nzGnGTDvRaRZ+JeJ0I032COS1OAYhzewxirPFgl67zguDMplPIiRO8kqH/2EpqjKK/tZUSG/2GYCvjoQluKAQEq/Yj1kH/Gzt05e4IkKtLAf5a7nVAcoKSkEqld6V+A+bO/x+Rr38KsRYeQ74JjYOUWMfy6PGHVET+8cEgaev1szzs2RTHNqN8OgWXJ0VQ5o00WaqB38qtOK6PtZgqKeokw7W9sSLf5L28UKXOFHg45ASbwGBjUAN/qxYa4SHu6DheXzCdrPTxL5EuNnfzRNBxVnqCL1uLXrAx1Zukr+050axViufqWNqIPVwGSkoslItbPUa8fxKrGUB90Bc+cicEujDnVP8lPgQr4OqF661uVtKMGLVRJQUZnUFWeA7PNWeQC1eXzwCVhFfYTJFcGvihtM+AwPG+PJQyNQLccHxhYuuJLVEy26w5LSFZd8gm3p49DO0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1jQnhPQVN4cTByMEZ6ZkZqdXhja29EK0lrU0FjMTNFTmMyTzdGZnIyUGFL?=
 =?utf-8?B?ZHI0Tzk5eitIYWw5Slh5Wlo2eE1aZVNYV0lHME9zOVE5c0hQelpONXNEeC9X?=
 =?utf-8?B?cUJIRGxaMEZ3NkJhVVhBNTdLMDRMQ3FFSjBidTIreVRsSDErNXdqY1FMK0Vw?=
 =?utf-8?B?SmFBTU5RQ0YwcURCNXZGZzhNQXpHYXNHclpWbzJ3NGdrQTBMbXRuUDhLeitQ?=
 =?utf-8?B?ZktMOXZjdTFLUk11UWZwZGdTa1NDY3cvVWZuYk5TUnhNRm1VT0NDSkxJN0ZN?=
 =?utf-8?B?cXdZdXowTEEwTHNmWnVYWGRrQ3pRb28zNkVhUm1VZThrQlliS0FxRUVJdml0?=
 =?utf-8?B?WDdzSmQ1UjZrcy93QlVoYUZyNVR5TXBjdDRaZ0hCSEVwRE1YdEdISWlIV0N3?=
 =?utf-8?B?V0ZCVzBUeHdNMFhTa0FWL0NrMzVNbTBlZnpxTDRPS24xTVJrN1RWelR5eG5H?=
 =?utf-8?B?ajJCT3NXNXQvYmI3M1d0QTB6VFdvdDFvOWI4MFh4N2FsQUJVS1B6UThZeHRH?=
 =?utf-8?B?WE13VysrRG9hdTE2b0ZVbDVZL3J1QjY0aHJDN0YyZEtJS2tGMXBLVjh0NnZE?=
 =?utf-8?B?MEJ5dmw1cjA1TWNzaTg2UGZ6NVI4YlAvSXZpczI5NnpTZ0xRQXIvRTI2R1hJ?=
 =?utf-8?B?UEVrbWZ0VHV6OG9OR0xlL0wrOE9CTUhnZ2liRExSRy90dnRBOVo0Ty90YXFx?=
 =?utf-8?B?eVU0dCs4OEExdEREazBQUmdSS0hzSE85ZGIxTmI5cE92WFM5Z29SOUVVTCtv?=
 =?utf-8?B?U1JTOC9KSFBrUGVoUnI1N0ExTVRidnZKRHNQcHJoN0ZQWEJrcllFdW9ZbHNE?=
 =?utf-8?B?a3JqRTY3aG43bHc2ZWJaVGE5SWgrK2xVdDB1aytyaW43ZXFWQ0lvMnk3NElQ?=
 =?utf-8?B?SEIvanR5VFhubW5yWStiVE1FU0h6YmJxZloxUERmN0RlbzZWNW9KblhEdjdo?=
 =?utf-8?B?Tk1DMlJNWkJ0SnRTSHlNQ1oyNXZMaHlYNndYVkRWY0hUeThNeElPbTRjVk9J?=
 =?utf-8?B?SWZPUjRTWVA3MHVPVGlxbHB0NVM3UEJhSmFpYTc5UFM1a3VnbDZxMTdIWFVQ?=
 =?utf-8?B?N0NWZGtIem4yN2twWmJqLzVsV2JKNitiVFFYYUpIZmJhOUJLUStjREhQbDZO?=
 =?utf-8?B?OTdmVEhoSG4xTW01MXRFZDFjb1REZ3ROejl0MXM0eVM3QlR5eU85anpSMmx3?=
 =?utf-8?B?MEZoa0QrT3R1YmJRbUdqYWNQeXZEdkVFbkh3U2NTeWlTRU5MYkNUejFGdUhK?=
 =?utf-8?B?WnZXZzVoc2hrVWRLNE94UENaWCtGb0FKODhGUVFVQTBlUmZ5WWJTSGV0bTFm?=
 =?utf-8?B?WlYwQzVpdzVUdnJCT0tSRE14YnpCeEN2SzBnUmFwNEdaV0gyc2NsSkdCZERa?=
 =?utf-8?B?NytxaW54OXFRQ0JNcXhFZlhNQzcyUHNaMWQxWDhJMTRUNGt3bjRDYzAyb0dr?=
 =?utf-8?B?VzdPMERrZFNNcUhnU1JHemJzbHZ5V0duZnRibGNoZGI5d1lVNG9IQU5QSTF1?=
 =?utf-8?B?V01QMTgyMzlWWEttU1hQUGRMRmFKMHdzQ1o5SUp5enJrbVNwVjVqR3Bad25r?=
 =?utf-8?B?VDdqNVNCMWg4eXhKWXAzdDBkcjk0RzVUbjlEVzAxRm5nclpPMDlUSVZDODJL?=
 =?utf-8?B?T1YvNUx4dEQwUjM4L3NsLzIrNzlRT204WXA0TGV5SUlzek81Qm9FMjFXa0xo?=
 =?utf-8?B?SEt5NHA1NEJHU1hCKzFrODZNRndYVURTRUJGVWFWcUdYSnh5UVJZWk5TY3FM?=
 =?utf-8?B?Z0R2S0JCcyt2ckdmdXgzV1B3WXJoajZjdXVlVmhyeHNFTFR3WEl4Y1RTcUo4?=
 =?utf-8?B?UWdRbGplZzg1ZGdNV21VVFQvc3VsVGZvejAxdnlrTUVFTXVzZXZud3pYTkJJ?=
 =?utf-8?B?TU51R2xrOFl2dTM4OXBEdEtYQjVrQVFra2szSjMyZStodzVLc0Zrb0t0K0sz?=
 =?utf-8?B?T0JiMDN0OFhEMDNsaHpnbjIvQW04dmRNSG5sVFMxNXoxWWQwRW1jdmpjenBC?=
 =?utf-8?B?SlVXa3RmampLRENob1VZSnNCRHZQRFVGMWdsSFNiOGY4YkJWS1ZGWTF5c1Zl?=
 =?utf-8?B?ZVVwWjJWZkZZOS9oTWhLMk1ibmJMMmZmYkxyczVzYUhMNmZRU3d5b20vNTlq?=
 =?utf-8?B?WXJJcUl6QjUvRUY5SVNSQSt1aU8yZHBYM3o0eExkYmhjd0tyenE5TW5VakdL?=
 =?utf-8?B?RVVzRUl1Njg4MUhFenhQdkYwb2phYnlYUUNuQ1QvMXJjQ1FpcWl4eWpDSitC?=
 =?utf-8?B?cm54TTR3bzJVaTJ3a3dFaTFTcFRyVE40dXhXNnJjYjIxamNtVCt5cE80R3Yz?=
 =?utf-8?B?d0FKVXlWb2RoOUcyMGJ0U1RVODQ2OTZHQ2RFSGNndjVxb1JweUhLZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1208f084-6670-486f-bc21-08df027650fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:58:50.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbU/uT4nQ7br+4EpIlQ/E6D6M8jZ40/patzetDJ7dIjeo9LwykQwPFWPxUpTON/EfL2PyE9JMBO5uv+d7lHV8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

Hi Christian,

Sorry for late reply.


On 20/08/26 15:37, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/9/26 07:25, Christian Loehle wrote:
>> First of all, sorry this got so out of hand, initially this was just
>> trying to fix some relatively simple issues found by sashiko in an
>> earlier (unrelated) series.
>> But with me touching more and more code and going through rounds of AI
>> review that kept finding more and more pre-existing issues I've arrived
>> at this.
>>
>> This series fixes correctness and robustness issues found while reviewing
>> the CPPC control path. They affect malformed _CPC handling, error
>> propagation, PCC ownership and cleanup, CPC object lifetime, register field
>> access, cross-processor aliases, and Performance Limited clearing.
>>
>> Series structure
>> ================
>>
>> Patches 1-8 are deliberately small, independently useful fixes. They
>> validate the _CPC encoding consumed by cppc-acpi, propagate control-write
>> errors, serialize PCC payload updates, correct 64-bit field masks, and fix
>> descriptor and PCC lifetime handling.
>>
>> Patches 9-15 are the register-layout hardening portion. Geometry validation
>> is more substantial because safe RMW and alias handling depend on the
>> physical access unit, not merely on a logical _CPC entry or _PSD domain.
>> These patches normalize and validate each supported address space before
>> building probe-only physical interval registries. Keeping this work in the
>> same posting gives the complete safety boundary and a single base for
>> review, while each transport and bug retains its own Fixes provenance.
>> Feel free to treat the two parts as independent series, I didn't split it
>> because they're all technically fixes and to get Sashiko review for the
>> whole lot.
>>
>> No interval lookup is added to the scheduler hot path. Full-width
>> SystemMemory writes remain lockless. RMW locking remains necessary only for
>> a partial field, where we must preserve the other bits in its access
>> unit. The existing per-descriptor raw lock continues to cover disjoint
>> partial fields within one _CPC package; probe rejects cross-descriptor
>> layouts that it cannot protect.
>>
>> Parsing and control semantics
>> =============================
>>
>> The parser now validates the package header before indexing it, bounds the
>> BYTE and DWORD Integer forms before conversion, and validates the Generic
>> Register descriptor consumed by cppc-acpi. NumEntries may not exceed the AML
>> package count, but additional trailing package elements are ignored because
>> doing so is safe and preserves compatibility with padded firmware. The parser
>> likewise tolerates trailing ResourceTemplate data instead of imposing a new
>> EndTag compatibility requirement.
>>
>> Writable controls must be Buffer-encoded registers. Minimum and Maximum
>> Performance are checked as the pair required by ACPI 6.6 Sections
>> 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
>> Integer-zero convention for absent optional fields, so Lowest Performance
>> may retain the valid abstract value zero.
>>
>> Performance Limited is one deliberate compatibility exception. ACPI lists
>> it as required, but permits a platform with no limiting indication to
>> always return zero, and deployed firmware represents that case with a NULL
>> descriptor. CPPC control does not depend on this status register, so we
>> continue to accept that encoding. A present _CPC package which otherwise
>> fails parsing or initialization now emits an error instead of silently
>> preventing cpufreq registration.
>>
>> Compound performance and EPP updates propagate errors and perform every
>> fallible non-PCC write before modifying the PCC payload. Updates across
>> address spaces cannot be atomic, but a known non-PCC failure can no longer
>> commit only the PCC portion or leave an unsent value for a later command.
>>
>> SystemMemory locking and support boundary
>> =========================================
>>
>> A partial SystemMemory field requires RMW to preserve the rest of its
>> access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") used
>> a per-_CPC lock and noted that a global lock would be needed if physical
>> registers were shared between packages.
>>
>> ACPI does not make _PSD a physical-register ownership boundary. Rather than
>> put a global raw lock or lookup into the scheduler path, this series makes
>> the cheaper per-descriptor model's assumptions enforceable at probe.
>>
>> Supported SystemMemory layouts are:
>>
>>    - naturally aligned 8-, 16-, 32-, and 64-bit access units;
>>    - lockless full-width controls;
>>    - read-only aliases;
>>    - exact full-width writable aliases, including 64-bit aliases on 64-bit
>>      kernels;
>>    - disjoint partial writers within one descriptor, serialized by its
>>      rmw_lock; and
>>    - a partial writer sharing an access unit with a disjoint read-only
>>      field.
>>
>> Probe rejects overlapping logical fields involving a writer, another field
>> inside a full-width writable access unit, cross-descriptor partial writers,
>> unaligned accesses, and exact writable 64-bit aliases on 32-bit kernels.
>> These layouts were not safely supported by the old per-descriptor lock or
>> generic writeq(); rejecting them turns possible corruption into a visible
>> probe failure rather than removing working support.
>>
>> PCC access and locking
>> ======================
>>
>> The PCC protocol requires OSPM to acquire the subspace before changing its
>> command or payload. Single-register and EPP updates now hold pcc_lock
>> across ownership acquisition, payload staging, and command submission.
>>
>> ACPI 6.6's implementation example places a mandatory 32-bit Delivered
>> Performance Counter at unaligned PCC offset 0x116. Performance controls may
>> also use byte-multiple widths such as 24 bits. PCC therefore uses
>> byte-oriented I/O with explicit little-endian encoding for zero-offset,
>> byte-multiple fields from 8 through 64 bits. A short per-subspace payload
>> lock protects concurrent aliased copies made under the shared side of
>> pcc_lock; it does not replace the protocol ownership lock.
>>
>> Bit-level PCC fields require RMW and remain unsupported. An unsupported
>> optional field is marked absent, but a present inaccessible CPPC Enable
>> fails probe because OSPM must write it before using CPPC. Thus the
>> ACPI-legal one-bit CPPC Enable used by the specification example is a
>> documented kernel limitation. The old accessor could not program it
>> correctly either, so an explicit error is safer than silently proceeding
>> without enabling CPPC.
>>
>> Every retained PCC field is bounds checked against the shared-memory
>> region. A subspace-keyed interval registry permits read-only overlap and
>> exact same-control aliases while rejecting every other writable overlap
>> across processors.
>>
>> SystemIO support boundary
>> =========================
>>
>> SystemIO supports Bit Offset zero, full 8-, 16-, or 32-bit accesses ending
>> at or below port 0xffff, including legacy Access Size zero when Bit Width
>> supplies the size. Partial fields never worked because the driver neither
>> shifted them nor preserved adjacent bits, so they now fail visibly instead
>> of being misprogrammed.
>>
>> On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
>> disabled according to the affected control's semantics. Runtime accessors
>> also return -EOPNOTSUPP rather than treating an I/O port as a
>> physical-memory address. A global port interval registry rejects
>> cross-processor writable overlap.
>>
>> Write-only and Performance Limited controls
>> ===========================================
>>
>> Between _CPC revisions 3 and 4, Desired Performance changed from
>> Read/Write to Write, and revision 4 added write-only OSPM Nominal
>> Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positions
>> are undefined. Explicit reads of both controls are rejected, as are
>> SystemMemory layouts which would implicitly read them for RMW. Full-width
>> writes remain supported.
>>
>> Performance Limited is sticky, write-zero-to-clear, and requires
>> interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separate
>> read and write could clear a new event reported between transactions. The
>> clear path now writes zero only to requested status bits and one to the
>> other defined bits. Partial SystemMemory forms cannot be used because a
>> spinlock cannot interlock an enclosing RMW with platform updates. QWord
>> forms cannot be used on 32-bit kernels, where the MMIO accessor may be
>> split into two 32-bit operations; naturally aligned, full-width QWords
>> remain supported on 64-bit kernels. Since CPPC control does not depend on
>> Performance Limited status, an unusable description disables that status
>> register instead of rejecting the processor's otherwise usable _CPC.
>>
>> Lifetime and cleanup
>> ====================
>>
>> CPC descriptors are released through their kobject callback, keeping their
>> storage and mappings alive for outstanding sysfs references. Every PCC
>> allocation, reference, and acquired channel is unwound on probe failure,
>> and the per-CPU PCC index is initialized before every early return. PCC
>> allocation uses a separate temporary result, so its success cannot turn a
>> later parse failure into a successful probe return.
>>
>> Changes since v2
>> ================
>>
>>    - Relaxed the exact NumEntries/package-count match to tolerate safe trailing
>>      package elements while still rejecting any count that could cause an
>>      out-of-bounds walk.
>>    - Made patch 10 independently preserve immutable-autonomous setups whose
>>      inaccessible Desired Performance register requires RMW, rather than
>>      relying on patch 11 to restore that exception.
>>
>> Sashiko v2 review not addressed
>> ===============================
>>
>>    - Kept Guaranteed Performance Buffer-only. The suggestion was to accept a
>>      nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer for this
>>      entry.
>>
>> Deferred follow-up work
>> =======================
>>
>> Sashiko also identified a broader pre-existing lifetime question which this
>> series does not attempt to solve. In-kernel accessors read the per-CPU
>> cpc_desc_ptr without acquiring a reference, while processor teardown can
>> unpublish and eventually release the descriptor and its PCC data. The kobject
>> change here fixes the concrete sysfs lifetime bug, but a NULL pcc_data check
>> would not protect a caller which already holds a stale pointer. Closing this
>> properly requires defining the kernel accessor lifetime contract and then
>> using CPU-hotplug serialization / safe referencing across all callers,
>> therefore will be handled by a follow-up.
>>
>> ACPI-legal bit-level PCC and SystemIO fields also remain unsupported. In
>> particular, the ACPI example's one-bit PCC CPPC Enable register cannot be
>> implemented by the old whole-value accessors. Supporting these descriptions
>> requires transport-specific field extraction and an RMW operation which obeys
>> PCC ownership or safely preserves adjacent SystemIO bits, just accepting the
>> descriptors would silently program the wrong value. Therefore continue to
>> disable optional inaccessible fields where safe and reject a present
>> inaccessible CPPC Enable control.
>> Full support, if even needed, belongs in a separate follow-up.
>>
>> The review additionally suggested validating the complete AML
>> ResourceTemplate, including its EndTag. We currently validate the Register
>> descriptor we consume and tolerate trailing firmware data. I don't really
>> see the point of ever doing this, but definitely not in this series,
>> where I'm trying to guarantee that no reasonably working platform is
>> regressing.
>>
>> Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
>> reviewing:
>>
>>    https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
>>
>> Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up review:
>>
>>    https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>>
>> Patches 1 and 10 address findings from the v2 review:
>>
>>    https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com
>>
>> The series is based on Rafael's bleeding-edge
>> 77acf59d7cf1 ("Merge branch 'acpi-cppc' into bleeding-edge")
>> the base-commit specified below is linux-next for Sashiko review.
>> It applies cleanly on either.
>>
>> Christian Loehle (15):
>>    ACPI: CPPC: Validate the _CPC package header
>>    ACPI: CPPC: Validate _CPC entry and control semantics
>>    ACPI: CPPC: Propagate performance-control write errors
>>    ACPI: CPPC: Use 64-bit masks for register fields
>>    ACPI: CPPC: Serialize PCC single-register payload updates
>>    ACPI: CPPC: Serialize PCC EPP payload updates
>>    ACPI: CPPC: Release CPC descriptors through kobject
>>    ACPI: CPPC: Release PCC data after probe failures
>>    ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
>>    ACPI: CPPC: Reject reads and RMW of write-only controls
>>    ACPI: CPPC: Validate and access PCC register layouts
>>    ACPI: CPPC: Validate SystemIO register layouts
>>    ACPI: CPPC: Validate PCC overlaps across processors
>>    ACPI: CPPC: Validate SystemIO overlaps across processors
>>    ACPI: CPPC: Clear Performance Limited without a stale read
>>
>>   drivers/acpi/cppc_acpi.c | 1298 ++++++++++++++++++++++++++++++++------
>>   include/acpi/cppc_acpi.h |    7 +-
>>   2 files changed, 1116 insertions(+), 189 deletions(-)
>>
>> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> Gentle ping on this in particular to the CCs not involved in the merge window.
> Even just a Tested-by: that the new CPC validation didn't break your platform would
> be appreciated!

Tested the series on linux-next-20260824.

With firmware reporting _CPC revision 3, every CPU logs:
   ACPI CPPC: CPU0: Performance Limited register cannot use an 
interlocked SystemMemory access
   ACPI CPPC: CPU0: ignoring inaccessible Performance Limited register

cppc_cpufreq still probes and frequency scaling works, though
perf_limited interface reads 0 rather than reporting the
register as unsupported.

With revision 4, every CPU logs:
   ACPI CPPC: CPU0: _CPC v4 Desired Performance register requires 
unsupported read-modify-write
   ACPI CPPC: CPU0: Performance Limited register cannot use an 
interlocked SystemMemory access
   ACPI CPPC: CPU0: _CPC v4 OSPM Nominal Performance register requires 
unsupported read-modify-write
   ACPI CPPC: CPU0: cannot access _CPC register 5
   ACPI CPPC: CPU0: failed to initialize _CPC: -22

Here _CPC initialization fails on every CPU, so cppc_cpufreq does not
register.

Thanks,
Sumit


