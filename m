Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9033F12F1;
	Wed,  8 Jul 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524334; cv=fail; b=UTSloLujclXqNYNnadKJsE2jFWGGD1neWC65t9JSk5HLyq0+P0d3+VhNR/zNh53+Ldc2NsjyZXDZYIey1JTn3CyaCG0kKW7T1DvL3KJ1nPAreqntqMBjcpehDJzpNeFhf3qlmXjFUAJ4JqN+eXjJGR77Yc2DiGY5qBrP/XSXyi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524334; c=relaxed/simple;
	bh=VgxlOOMRpPDB8vTqkGpPqLdHKG2umtzVPwR6MjNrOxM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FaUSfObf/1GTpD58lNrC/IaqDR+ZZdhD/OgJFrhOZhF7j0hGfRgq3B9kv/JkkID+agtN9dK46lTe+LWbPoZqIzKLTe+rSzYQ/kWpGAd9QLzPzH1WSmSf0jfAj61DYgaSMkOrU9JI6UqY7StwKUrvcm4rItuGOa757nYmaQKhCvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d5IxeVoS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IFrtGJSM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d5IxeVoS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IFrtGJSM"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CiMk53174534;
	Wed, 8 Jul 2026 15:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OvF6OjK9oV2adO6I4vC/G2pnWFKoDR1h3yqX1g3bZiQ=; b=
	d5IxeVoS5Z2uzE/Q7f0F5MZPOARTrR5lSCyzNyX4ZKnHGO7dlUnX4PsJGi6Neh9F
	d275e2fslp4FwC1AamjNS3R8E0IjIXpLCnQhRVgcWUHWFFPmfYacz/aIQfbIXbWz
	QAzcmtUj3YXaWKQ1mtqkaqAIS9WqPJmDNYLOx4E2qsITvSHRhxLSIMylGuCtf0DK
	3hQZ/qOgqEhPDs3+Gid7QdSoxp5gNzeMqQQeT3yWK8cqO6bSzT5zzo05F3ckmUad
	ktbaPxfHAQ93w6xjA15u31I7ibSF5qYj0bqQ6Sro5/gBzNwv4r5bmLuqTt1YRo+I
	Ux3o/37pju2hF3Ry1H0NjA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6rs1fw1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 15:25:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 668FI0wW005752;
	Wed, 8 Jul 2026 15:25:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f8wuynjqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jul 2026 15:25:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhKOL0LvOdG3jpB8QI5VDS2SrWMM3b1OnH+SAKX7YKZKEhqly+xkEcZBey+mu9VtRQ9RYislPSpcLTApsNqrEJsljNn3Dfvx9lKna3S7NVcN4kKQTwxjF3wgcQRHyIPoGng8DMdL8wwjzt1cqmK7HovgTAn2l86kia7uVbWsvXnQUtbjqPPEfth0+JVkTQGHYeTENT6wXSR4oHrnbmUPUbwuzr0HjlaWhfMNefBuYKLxVDS+u5qs3qon5+AN47VVA87hMnZ3oNB9uushmhcKxa2BsFWA51h2FDhrckc7wrU2WFnvBZKiQAO7dl+2OQZ0k+DfOtpsuHMXQJo3bx69xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvF6OjK9oV2adO6I4vC/G2pnWFKoDR1h3yqX1g3bZiQ=;
 b=ugvUR+blpDyWel/Xp1dJUSNJj3yfCTeodiTNurXCOrkn7jV6RwA7ZgduWBDs8YNHH9pypMSitMGqaSFPKCBpbQH+1eH3B6R8lKz3O/YQAupyNJ2JQ9gtNUAz+1vHrW0JWpPvcRPpmffX1vesjCD6Ki2upgtmAB5MyMWwGi+SX4ccPXE5N42gUq0z9+DbDNGRNJn1I1g17K/LjyxUThnN0v2A88l6V67xJZV89xb/O8l2TfSo7lyQld5hSa0AbqTuuIyWO8EFpLqGB2VrerzR73GzeHPPiW2NhdRcuTbtROhGm9VgxLpjj0InsRGFhS3O6Ut3osEomrPxDio3HSsmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvF6OjK9oV2adO6I4vC/G2pnWFKoDR1h3yqX1g3bZiQ=;
 b=IFrtGJSMdJlDu9aJOPeZC1k2Vaw1qybEnV+XENiT3A7qLFs1pBT2gb6NpVNbX3GgyO2pGoTW6EVrMJjW0iPHrU54jyh2lISTb8TkU/I6Dbr5ES6IjSiikmfQ31W8l2hc3EsYxadvNjtf72AZChMzPvxRbis4eWTDzaSzTYkhcO8=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:25:06 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 15:25:04 +0000
Message-ID: <523a095d-8c30-4e25-9a1b-88cdf438041f@oracle.com>
Date: Wed, 8 Jul 2026 11:25:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after
 f4c31b07b136
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, frederic@kernel.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
 <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
 <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0404.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::19) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a37d1f-b055-4965-ff71-08dedd0515b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oDuAjPgKajDffgjRLCPNI7Mceb1AihnG5eAnXWCoNsLiTBfTzuhj6EYy3S1HitpEWH/iDXHno1MGTyFowOTW+jEPhXLmPAfvMhI7YTwvYLxtPNIwGl/G/dx17HQXniF6PMD96fSR0INNMD4we9V1S9KRDxLqNyiLm5a6dgBOzkKraHlhK47P7UUFRNhWnBhhuCiylQgngdxmx9e++8SWKcQj66DU4vHfAuu0pC54KmOT+cMVqiuZ5GddYC1W0FEWJdww3Mkx4E3e9Cc9uzqMWBKB4ad8uDX6QVxwvlswX+VhcYzgKGVgSRCZjJQYdILOcfOfEC9i/K/oaj1Mo54rH2B4zjyM7yIac1k6dBEF6uaY0ciLCkOZljkzIieNzDLxmXeL0O8eqMZq3iqAs7ev18vWDF+z64A/r/9rnCLXj3Po1DfUvoaydIYjDmrvUilyTHWc5bczYYozZjiK3hlImWkyyGlXByyWJRkUaz+a5VYUvkVBnytiEtI924k4xV9vxt0uUeqdAE/UvBI3T/zDL0jh4Z53zl/+Qts15VcHTUFJypNgZRhLTgsBMpQvE8QuDX5de18+i7MdB+FQQbM1ddghooHbXsmAyZut6Td0ihDuCbTmUdYD8pUYX6opZLEiwDUJKjhdPMmwfAkUvbzgwZazo66kA0+l8mESSO9GvYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVdTL3dPMUM3QTRHTmVqdGJQNVE4NlIwT2JOSFFKOTZuOHVoamlIOC8yc3pz?=
 =?utf-8?B?bGJiNlg4NnFjMUhTUGdnTk5GV0tvbXZYNzlHVFI5WTFIU0hXWVJGYVpycitn?=
 =?utf-8?B?YWNqbkxKSUNGM3ZVZTdWK25qYVQ1Tm9GdTY2bXBhWkhOcDVkRXhrZkl4d1p0?=
 =?utf-8?B?cVdiQnJJbFlIZ2dZNnRkc3JGbUNpQ1BGbm5QdmQ0NjhnYUpUODV6T253NzRI?=
 =?utf-8?B?VXNVc3c5MHluekt3K0xJK3VIWGRFTXh4cTduR3NBMmNobVVJQmtud082SVVa?=
 =?utf-8?B?d1EvREh0TFdQMlZTbk9ya05PUEJYK3BTUDR5eTFZbXhVTjluTC9nVTQzUU1W?=
 =?utf-8?B?WmJKbm5YOWpDSU9mWUVCcUxyR3pJWktvMVVCeFJEQU80ZHNQeVBOT0lveGRY?=
 =?utf-8?B?STk5dXhybGk2ZkVZZ0ltckhjMnIzSHFSSjRkQUR4SGJIRmFtM25sUzdjc2wy?=
 =?utf-8?B?d3ZxeVl6dnJnWmNqYWlEdTltMUJzTWE3QVFuNForUmt3cjFmdmNwSmJyd20z?=
 =?utf-8?B?Q2ROWHJkSDNWL3FwbENnTWZ1WS8zbnh6eUI1Z2dMN2Q2bzRUQ29xYzBJbzBl?=
 =?utf-8?B?M0VjVmJHbkdWWmdzcjgyV1BINlZReGxlMWdWZ0g2WmVWamZJK0VkdHRjaVhr?=
 =?utf-8?B?VHFPWVMrSVRzRDIxYUhQZGQ0MElJMDdhUUxIYWhlSGY4RXl3a1U0UnRmK3hX?=
 =?utf-8?B?UHA3dFo2dG5VZE5TbVZvUHFtRlJ1Yi9VMzVLYUJlM1RWcS9lT3ByZnNHQ0Fh?=
 =?utf-8?B?aGxneEs2RHBra3lRNXRSOEppQVZnTWg0L1ZvL0tpdkxSSkJCVzhMQWFDd3Fr?=
 =?utf-8?B?aDJvREFCUStFRmYzdEZ6RktQbGh1bjF1RHBxUkhVNU1RU3hvMVVXdGg5a0gz?=
 =?utf-8?B?R3BLREEvT1ZTZ2dZNjJiSERVQjlKaGl0ZmpxcGNaejBET2x2VG41dlB1RTZC?=
 =?utf-8?B?Y3Vrc3h0NUpJZVBSQU41bEU4SnFsOVk1dkVacjY1aHZDOWhDc2tPdHBNOHEy?=
 =?utf-8?B?WVpralJodUJsNUtudXJaL1IwakZBdG9UKzBRSTFhelRoc2pOZHE5NzRyNDBq?=
 =?utf-8?B?YmNIQ1B4Z2ZiYmM4Z1ROdnlPRjhXSElrSy9ERjZDYjhkcHUwL2RZZkIzUXpN?=
 =?utf-8?B?aGEvVkJTdDV3bmZFcDl4ZHNEaG9SaW1nbDhXY3FNZWVOeS8xdHU3ZGNIeHdj?=
 =?utf-8?B?SGZqdGdBdWYvSzU2RCszdHluQ2VWc29LcG5UWDdzK1JCMVd1d0NleUpJbGx0?=
 =?utf-8?B?SEV4MzhVa2J6eU8yWVFwakgzUnZ2Z2NjWDZ2WEZxVFR0S2ZZVkdWWFNrVi9q?=
 =?utf-8?B?Y2E4YkZGWldlWkFwMWpYVWNoTUMvYTNXZkROV1VnTFhiZ3k3S3BUL20zS3Rp?=
 =?utf-8?B?cFJxd01wRGRCdmdWQmlxbzJkVS9SSVhCMEhYNHRGaFB6YVVQeEUrWDVJSzlr?=
 =?utf-8?B?UlNRNXBCVUMydkY0alpQQy8wYkhOcXpXeWIxQ0thYm1sZlMrOXQzUzF5c0VT?=
 =?utf-8?B?c2kvQ3RtNHFRMnJFM09DTGNTK2VCZ09KTmpiWmgyM01qb3lRSnhPS1Iwc1pZ?=
 =?utf-8?B?aTBINkhPVmhwT2l4M3NMTmVKQjA0NkJxNk9DM004TzJabFhHakc1ckZYS0Zj?=
 =?utf-8?B?OW10ZjNtWk9TbTAyOE9oeW1xYUw5dmhMWDgySVc2REliVE9ldlhvMnZNQzhq?=
 =?utf-8?B?MmVzVUh4dFI2UFo4aWZwM2gvNktkeElDTU1KRXdLMTZqZE5keS93Y3hxNkhB?=
 =?utf-8?B?RFQ2ankrZHZOdllaTG5wSVJXNWFUZ1dZcENMSFpXZG4yRDZzSnQ4emVmYU85?=
 =?utf-8?B?cVpsRGpVY3NqVWpyTzBxSUQwSTNMajRzUGpzMUF5WUJSdSt6VzBLdjRyeFF1?=
 =?utf-8?B?b25qU2J0UTMwL3gwYWloMkx0NWdKaFpWdGovTDdVWHRxQmlCWC9OeXczaHhN?=
 =?utf-8?B?Z1N0Smh5RFhVK2t6eUttSWF0RU1YSVpqcVB4Uk96R3hxMkFNdnZGZE02Z1Qw?=
 =?utf-8?B?VFM2YTNCK2lWWVpRaUlFZmZrM0JwRngwcjdROEtHeVJMQVowVERrTkd1aEN1?=
 =?utf-8?B?S0hBTDRjMWN4dDFuK0tPZFJiM2FTMlY0aVFsZnFrOFM2VkxnZCtzVTFHS3pI?=
 =?utf-8?B?SHdtcThYRHhrWVczV2JrKzNmV3l0N3k1L1RlYVZ1OGZzQ1JlTFJsWFUwZ0ww?=
 =?utf-8?B?M3kxUGVhTE1NYUdlaGNXNHZMMUhzeUp3SUE1MGhKUGthUzVhWTAraXJmcXpC?=
 =?utf-8?B?SlJISVN6RXRsWDBxZndocU5YMzkxcDlhdlBWV04yczlnc243emRqcHRIRVFE?=
 =?utf-8?B?RnVSMEZGckxSMlREUjR1ZXNSd2I3SXpHcFJVK0h0RzZLMnA4YjBCQ09RcS9m?=
 =?utf-8?Q?mWhBUfVjmPpM8qZE=3D?=
X-Exchange-RoutingPolicyChecked:
	XQF5Ja1XQF+99dRhwFJuYlUP7Nj5mWa+2UXWkotAGosLt4tf5PGgCQ4GoJ9CpQ5mNzIfRlFL6QVI9jHaYaH3sAJI30uG18wFYf151t/E03wxRBzq2JzoAWvlRXx+j8hvteAXQOJcR0kcztJTst/88Ul5qf9g/DPr6emENMic5HwYoxDiAmtcDOuTqTMM4zE43qbeYgj1XXPaNIadRx5tBdhffvZRTGExZ1RMcWJ8PSHY1R77fufl87+2VDps6zA3u+NaZO9NhH/Uy2yslmK5SFwgLXC3qrRjQ6cr+efWTJS0vInZe5XU1fS3dWc0HGjxo/cnXqzazylWDBz7qSc9FQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PM+m8xl77t1sKVl+zn0Gp2SBS07bJOBy2bFYnI+nmpRN9ZCfhAkry0FEVquU6ZIi9y4qO+MmgKR5pyOxTHfAMHpufYY9HoduisofNwJbh9rosnHhd2JSF8PsLAQcOttOvQhVoa2OejRArv4AFMZVgTSi+grxAwV/dAwsMtpJDhywB1DC0mVIxNOm0PuhxEP7k5qybnWyKxOeDKk/5J7E1wfs4jKUT5/H9FPQW70B6jyNcirNp+5Ub993BHOFh3zWG8aAdiK4d363/tsPD7+Jj0gjOGnaJyT/gNK3+OEGIlOK2Y8YkWNkTbyNal28/F5/kIaWvJWwHTsYeOEGXvUb9nYFVxNJJqu1iGv8zXTquhS2QQNcqqPQKkdPtaIaxghtwvYXITZ2KxdhtbuofjzJS/4aDpO5Pgf8/BGiyzrdhaM4Ux5dotIvoXx0Mus0hpWbDYc74r2fULBo+FWHn6JXQEMQ5WnzwdLCQr8abJh3IhspK/Vj5HCdts0U3X+7arIrTeDmAjmFyioxWwHM7LTypOF6AD11Wb9L87LcaS0fOk6mYhzIu4E1MkHSquKTD7fKkfuMFWPh9ZODJTeiw0sD/TgMskah6DfT0QWOSyAc9hs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a37d1f-b055-4965-ff71-08dedd0515b5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:25:04.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeljdF3o38QeF3JhQI4/zrrmFmoGniisUeIUXVIQc2j79ZQlzxvjlU0X9fTwgrAlJCkq4wKn0exw3wSeVpuIG3d7eTfBRQ+RhGKJhgWZyEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607080151
X-Proofpoint-ORIG-GUID: f5X3Hdvyp5qVMoxuAMqPLNH00cuoyTwc
X-Proofpoint-GUID: f5X3Hdvyp5qVMoxuAMqPLNH00cuoyTwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfXxtEi+LESu7e2
 BZzmPuNFhiTY+ROB86nEsRpHSXto+R4lbKfbSAsYPSotN0+2yD0jXd1yyq7iSACIo8iTxjdEtvZ
 teXJ2uLbj0NgHuyFLogiPqhkUSlKBrD6bU1dXSCKFEIzy+DZi1oEy7bL5txsiCzBkQvJEUe0+f2
 DqEnA90szGiblqpycCFvZEi7ImjsE1EhQU6fHKXbmjBJTyoVwUayJnEbFFAGwguEmu83YrjhmB+
 HphAeo4egplCvYGyTNxldBXCa2iTyHaf/4sBFJMQ4PH7C+6ESGqzEoMya4V7iwD2ThZe+/SD9XX
 PMTnLH7bMj/fj4ImUgVj970mek9JGXaabaoO4ta2xf7rqQDWOebIcc/C2Md884yrVabIklhEF+1
 e89agnCMLXJjIrSRIDvf9ZXaugYBvkNPaaBIQFCqFrSjT8uzSE0FbVYQR0SduOGDmulbBiNByQk
 Fd1eY/KXHGVRhe189Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfXxUb8HAe3zxBC
 IndYXC49+QHSo9PJHxN9uZgRpA9opdBfmuIBK0cl6f2PiujOWc5IE6hLumGF+lVD2MKQlKYb6nZ
 L6lAI4Rr8f6jURLJMXmpF1iM9z7lrvqWoKAAD1xqsOPLaYlt/wqB
X-Authority-Analysis: v=2.4 cv=Vu0Txe2n c=1 sm=1 tr=0 ts=6a4e6bd9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=Z8856WwFtE-RjjnfOaQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22



On 7/6/26 10:29 AM, Christian Loehle wrote:
> On 7/2/26 19:47, Rafael J. Wysocki (Intel) wrote:
>> Hi,
>>
>> On Thu, Jul 2, 2026 at 6:30 PM Joseph Salisbury
>> <joseph.salisbury@oracle.com> wrote:
>>> Hi Rafael,
>>>
>>> We are seeing a reproducible MySQL Sysbench threads regression.  A
>>> bisect indicated the following commit as the first bad commit:
>>> f4c31b07b136 ("sched: idle: Consolidate the handling of two special cases")
>>>
>>> The regression was found in Oracle kernel performance testing on OCI VM
>>> shapes:
>>>
>>> VM Details:
>>> * VM.Standard2.1:
>>>         x86 OCI VM shape, 1 OCPU / 2 hardware threads, about 14.5 GB RAM
>>>
>>>    * VM.Standard.A1.Flex.2:
>>>         Arm/Ampere A1 flexible VM shape, 2 vCPU threads, about 10.9 GB RAM
>>>
>>>
>>> The ResultsDB runs show the regression in the Sysbench threads metric:
>>>
>>>     - VM.Standard2.1:       333 -> 236  (-29.1%)
>>>     - VM.Standard.A1.Flex.2: 1286 -> 1152 (-10.4%)
>>>
>>> A test kernel was built with f4c31b07b136 reverted and the performance
>>> regression was recovered.
>>>
>>>   From the code, it is possible the regression is due to the new
>>> previous-wakeup heuristic in the special idle cases.  Before the commit:
>>>
>>>     - no cpuidle driver:
>>>         tick_nohz_idle_stop_tick()
>>>         default_idle_call()
>>>
>>>     - one idle state:
>>>         tick_nohz_idle_retain_tick()
>>>         cpuidle state 0
>> I think that this is your case and the tick stops for you sometimes
>> now while it had never stopped before.
>>
>> Can you confirm?
>>
>> Overall, it would be good to know the idle state lists for both the VM
>> and the host.
>>
> +1, but also which HZ are you using?
> Both systems reported have 2 logical CPUs then? Were higher core counts also
> tested and how does it affect them?
Hi Rafael, Christian,

Thanks for the feedback!

We will collect the requested runtime data from the affected systems 
before testing the proposed one-line change.

For Christian’s HZ question, I can answer from the UEK kernel configs. 
The relevant configs for the affected kernel are:

- x86_64 / VM.Standard2.1:
     - CONFIG_HZ=1000
     - CONFIG_HZ_1000=y
     - CONFIG_NO_HZ_FULL=y
     - CONFIG_NO_HZ=y
     - CONFIG_CPU_IDLE=y
     - CONFIG_INTEL_IDLE=y
     - CONFIG_ACPI_PROCESSOR_IDLE=y

- arm64 / VM.Standard.A1.Flex.2:
     - CONFIG_HZ=250
     - CONFIG_HZ_250=y
     - CONFIG_NO_HZ_FULL=y
     - CONFIG_NO_HZ=y
     - CONFIG_CPU_IDLE=y
     - CONFIG_ACPI_PROCESSOR_IDLE=y
     - CONFIG_ARM_PSCI_CPUIDLE is not set

The ResultsDB metadata for the two reported systems shows both had 2 
logical CPUs:

  - VM.Standard2.1: 1 OCPU / 2 hardware threads
  - VM.Standard.A1.Flex.2: 2 vCPU threads

I do not yet have higher-core-count results for this same comparison.  I 
will check whether those runs exist, and if not, whether we can schedule 
them.

Thanks,

Joe
