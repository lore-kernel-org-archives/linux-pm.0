Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EE39A071;
	Thu,  2 Jul 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009598; cv=fail; b=t8YjvflQxSDwXmicov5WWQN954U4/CXm01mMgRAXRtM9EIa85vR1wpsvPRePWzXkZn06srSOjUityP9drxSLhE/cTWETNnBKzVoWY8sCoCG5j+Re2lLMzbjdaIj/dA03fYj+L90USUO9g0MkoLoWQp51JBM7CFFMC5pxNBHFgyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009598; c=relaxed/simple;
	bh=wB9rq6nbj26B3NWTtEsllrG2AUMqnOWGrFoeFiKfX7c=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=pAHdGYXIjmAvxqxnCqWJg23EEM/bzfTNSXHYiX7dbw8BPZ1gUm3aWQyyZg7Ntf1kOjkPsrK2rGMU+WA8ZrPCXIpPAmH3SsWbUTh6Y38bnE6+7hToNeoBBFE7eFPD1dsSM/9ioZ1yDvFna0N+M69eRkG6yqSng+Cwaeyz/hZ894k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pmqd3NqF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=drSgD2Sy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pmqd3NqF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="drSgD2Sy"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662CiuqR909405;
	Thu, 2 Jul 2026 16:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=NlVazfGbE2pkNVdh
	B2b7o7u8bYw6YjLC4tK/A3s+aJ8=; b=pmqd3NqFq/oJAR0GYV0qdrJlb3GIXTLW
	DcpH+ZVGl7U2DWge8MJMQz9oWx4I1Vj6G4+eexJhM3x1YHktoXJTwknRjvu44YxJ
	kyien3XxuubZ2J7vkHAkC6YxOd2+ABIPwPdxu5b0A0++2ghW0Vz2KIj43pAgxQOV
	+UM74CZG1KrTcoP+i/55Tr1LHKPInPhPHjYjfu+FMJwmrbKJkpHpRyRYAU/I1bMT
	fzwmp7GGrDsk7//ZRj8T8/bYFX8lG/7biGT76GHfOoED5/ktmc6GJwtWf1R1FaZs
	vIYLAsY/tWdMvD8nuR0amPf4Xh19lb3uiVlp4hvZLcSD6vq4ypMIow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f272qrprs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 16:26:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 662GN6X7036030;
	Thu, 2 Jul 2026 16:26:00 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f50yty4k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 16:26:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MG/7KGfjhnakhjyR0+D8ENmo5UPIRpU6M5xEaQ7Jr4OmF/TKtJJizRDlUQ0SW8nPz3KppQYJfzG4UlRqr7U5SzNPbWgs6CpN5TZmiWd6ziAK7QVjYeC4T899637/IZWe+CtPjD+6VmoMntop3+9IQQKPLOBr/pgRCrjNcezh7bzhjD12FZCX5YqfzV52urMZQnbu0n+erkM0mENB4dR9ijhoz53cqoTtMbM4aatEEOdtH/A0Ci4MdtN2MvnesIQWDOKbJdrXXuBhkq1/3LV4A8w+JP6ewWVKcIitPjcsF1nfy05QuDi+wpM4ej2iRrBXkzCdUPA+N6Zd0Z+pyBaWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlVazfGbE2pkNVdhB2b7o7u8bYw6YjLC4tK/A3s+aJ8=;
 b=G4l3wXyA91c73S9HET0IK17lZMnTyVrcvtF4Qiirhs2RpfjK8n64VKuaj8gIJNPim7uONF9wlODO5NqsENuokYkdmAjn/0FmWGNh/7hPVWTxu+43QGOR0C1hgpMhEsGK7XWhRVjg3pKJYDGeal9ebyVna1zByqyIVAt1TNchE1A6rqy3TqcXVe3nUukOsPfa/9SG7iWs3hqX6zO9yUcC0R4m+/Uo5vECtndjLzs/jn+gWfex0x+hHMEblyJdJ6KV01gqf6Nyi6oit21pd/iLvafGIfC0zEkTh4dxeB2OhqAjdxRPQA5S7t58ZBSgEweO9yLldxwMeS8ggwxo3MfT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlVazfGbE2pkNVdhB2b7o7u8bYw6YjLC4tK/A3s+aJ8=;
 b=drSgD2SyfD8/nGFuiqL+kS3MNCGQeJZgmXA0qmopXKNDj3XVQn2HSfqWMUom5/aTea2haTTXW/Gz5ebcCQTlZ6FMK9+KKXdQrDg8CMedaVHBo8CIy8FFh0mNVva+87OiTKTvFPhKkieLNkNaivmGtHsf6ZLMcdo2ZD35RDbYuEo=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SA1PR10MB569391.namprd10.prod.outlook.com (2603:10b6:806:51f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 16:25:57 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 16:25:57 +0000
Message-ID: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
Date: Thu, 2 Jul 2026 12:25:54 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-AG
To: rafael.j.wysocki@intel.com
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, christian.loehle@arm.com,
        frederic@kernel.org, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [REGRESSION] sched/idle: Sysbench threads regression after
 f4c31b07b136
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::25) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|SA1PR10MB569391:EE_
X-MS-Office365-Filtering-Correlation-Id: c127f802-664c-4960-cd73-08ded85698ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z9RHRMw2Z5J2Fo0mpQIJaBEhYdbbmcjeEqhXcVSmYa2tXOdlTzYPH1oPsrFhwuTepJNsbOpPLoHz26bOnomLZlylXb+az61Ni2OPGei3UHzFMuAjuO7ffcXg/Wxikll31u/3PTTY5lXoaK1ar0yHWMg4aPu+nbxmqEbf+2v0z9TtBZ6eXZya8b9zh6WwTMfvSoormCBLLKS3cXd4/jrWhenEmVmBIB4X+VHGAXXPsY1aqvVewnkbMfHbSteNaUjvV3sbmog/Evrk6yvF+xMy71fqIbHwCjKjtt7VDPnUzyutxbMdG9JTY5hKN5qhI0taCJaX4bje6SmkGqf5+6KR5umh5/cWwrx+aAoc9E75KPxx0vNrMms1vBg2Zcv07e7vgDP4D6RuLkTFqz/InsGVQ60b74PBgIPQtJk18PzMekVfA6nEVG3LPAsI+A58MtYkJXBAOYfgGFxz+2GO7v1cc1kfd7yS1/4bnDNUdrFU5MKDhmwPxBBUypv6whPHKZMFVxevHw8u9cb9VKsMoHLBhVWZgEkoet9zT/bTM7QZuD9HhkK3GXgPYj9J/avdRGssyhEJXHSl/QYnHSHIxedNvCf3HIz8ug9cLDywEz6e98uI6fRwTU1CvCecBZJfh1539ByfTcdo6KzhS43+TFHZeF3nG4SSbHaVS0zBZW4t83c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWRQdCttbnREamVRT1VXaUV1cFlocFJTdjB4aEZYN1ZGQWd5N3JmcVVteEJu?=
 =?utf-8?B?bDZUSUpobk5XRWtDQ05JWk1nNVlNS0FnVnRuSVljUmVRdSt6dGxkMXJ2SzA4?=
 =?utf-8?B?b0tGVE9mRUlMcXZNeXVyUTRlRVlJTDV6a3JRays5YmVDNG0rNUdxc2c1ello?=
 =?utf-8?B?RzkweXpRZHNySk80TTR1eG4zdGhvcVBwcDhrYXZ1UnhaUUlvbThVRHBxRllw?=
 =?utf-8?B?Z3I2cUJLRmI4MVdYU3RhbFpKSTZEdU9IRUlMVVNPQXJCRWN5YVh6WGZRZzlw?=
 =?utf-8?B?RCtmRUtHbFMrNWFvNHJmV3lIQXJHT3FMbXh6bEVSc2NhS0tpNnhSQ2cwTkVv?=
 =?utf-8?B?eXh4cHM1NktSWTJuNW0rRktrajF1bWxRWThZZ2NMdXNjdC9VaGFIQ3YxUXBu?=
 =?utf-8?B?SlZ1cXlaeWxTbHFXd1FIdk1xYUFqZWc2clcwbHA2SUlmN0dZZDNRaWFhK2wv?=
 =?utf-8?B?UXJOTVU0UVRoSlFwKzJleW5uNHE2YTg5Y2RxNDh2UmhQdlFFUU42Tm4vekNw?=
 =?utf-8?B?OTdVSTFKaVBCWXZJU1dYQ2NLb3VzYkNuUG1jRXBmajd3WlpWTHhVSEp1eDNy?=
 =?utf-8?B?UVZlUHVJcjVlY2Z5UXhmN096aHo2ZDBjWUtSN3RBY0x0RGRTY3dnZVhYTVY1?=
 =?utf-8?B?QlFmVzBTQ0kzVHUzQ2hjc0RmcUlabzVxUHEwaWE4eG8vK0NZS1RzMzhFeWV1?=
 =?utf-8?B?TE91Vy9rV1l6bjVOYUNVenliL1daK1RtcldNa3BlMk1EQ21xTWtEOHFTemUy?=
 =?utf-8?B?d3Z2c3FuSnByekVBTFBqc0VEZ29mUndYTFRub1VycEdocnhQUkNRUmlBMUdW?=
 =?utf-8?B?OXVMaHJ4aXhMRTFaV1RDMGo5S2REQ1N5NXR1K0FTd3FKZnREY0tNUlNLeGZ1?=
 =?utf-8?B?MW1sNkxqMEEwTnBEWUhxbTNRYXFndVU4ckQyWVJwVEx2ZGdUeEpmRnVNZjdj?=
 =?utf-8?B?TkFsQzNySVdPbHp0VWZIUVBvNERoaXVtaU05T3JyTVlpZ3p3ZGpKRWMwOWVs?=
 =?utf-8?B?Yi9mK2NZRXJwNisxZ0NkYm1CeVVnUkw2cHpVb3lBVW5WTlc3RVZBanlzNW1W?=
 =?utf-8?B?NmdYWFlBSEo5OXladU41bDM1d2J4YVhQdWd0ZFRyTnlibC9jcHpxdEVnMzlE?=
 =?utf-8?B?ZVpBL3FUSmNyRlBUSU95YmgvcVBSM0dpMmh0c25zdEVpNHVKcXZxSlpkREZ1?=
 =?utf-8?B?dThndnJHZUlpbjZCeTBmYmI2dzNLQ0xTbEFVRkkwZkozNVZLdEtjODB0VER3?=
 =?utf-8?B?RlZhMWV4WDU1NlZ4cUhSRXZkSmdJQXY2aGhNTVR3bEVvV0RDR1BwVUdRSUM1?=
 =?utf-8?B?OTJIYWZVci93NlJBMitaWEltNFVWZkJFcnBPeGRrWFcvZWd0WnRTQ25ibURo?=
 =?utf-8?B?U3BaNGY5a1ovSzNnc1hteVRncklqdGhGSWpyOWNGZlU5Nk1rdzY4eE94V1V1?=
 =?utf-8?B?bjlaNDZDdkdkWUZiVlUxN3YyOWdodVB3UVlCOFBCNW1VeWdkeUdhaGVUZ0Fn?=
 =?utf-8?B?SHlpQkdDNmNyN21TZ1hZUTE3c2I0enVTZ2pONDFlVkNpcXhseHFNdmJVRmFX?=
 =?utf-8?B?VHpZVE1WNHdBYWtEUnRiRU9BL1hINHBQOXlPNVM2TWhZY2k0TFNMekRHSllZ?=
 =?utf-8?B?dGplbHhKY3FIYTJCbjRqSlBVTENqUGlLN3ZOZkZrMEo1QnEybWVPanlabVc3?=
 =?utf-8?B?RE9FelM3b2ltcGRlU0sxaEFQTU0vRks0cVUrN2QxQUJnV3gyMjBGZUl2TkhG?=
 =?utf-8?B?NTVIdVk5S0xVMEo3ZWlBR0g4cWxtNWlWOXFWRmVCQ1FpZ2V1TExGaWtmeHBQ?=
 =?utf-8?B?V2hFK0RuQ1dXWHZVU1VFSnRxMjV0UDhSTUNkZEplV3BoN3JoQzNvTXhEUUlZ?=
 =?utf-8?B?ck9rUEMxMW5KdzFSRUsrejI2UlVpRUg1SGtZcWU4dFp1RFZpRW5jcHZDRWhk?=
 =?utf-8?B?SXhadkI3UWxhbkZ2aXZoUnMzVFVGY3FucXh1anZkdGRKbnVLMXB4U2UxYnN4?=
 =?utf-8?B?U3JZTy9zVTZ5WXMxcDJXcHNHTjFrcllGYTdsRGVTRzZLN0pkOFRNRXlTbWVT?=
 =?utf-8?B?RWxuaVZYT2RRREZZb2g1MW1JZ1hyY2EvSVUvd2Y0SXdWRkdObDdROGkvNjF4?=
 =?utf-8?B?U0tSTFhxY2Y3dlVlN0s3YTUxcXNncHRDR3VoVTd0cEo2WmxpeGZEYnJOYmdO?=
 =?utf-8?B?d2o4SUZJYll3d0ZqdjFJNGhrQWVEdStHUEl5OXlhU2JwWlZrYVZPNFVMcW1C?=
 =?utf-8?B?cG1JUXBKdzc4UzRsZDZqZDlqUm9Rb1pTcHl0T1JjWmNUWWUrbmxydEtJQkVK?=
 =?utf-8?B?VUZTNzN6WlkxSW5jUUo4eUp3OUM3MW9UeGRHTHliOFJITEVRRHh3VEwvUGxO?=
 =?utf-8?Q?BVaW0lq/D9xD8evc=3D?=
X-Exchange-RoutingPolicyChecked:
	qf5e2Zko9+GAVUCXxSTaaufPiqu1y9TMIQPnYNvBu525kHCWevxw620K4RasgPb08nidz0pMy4w1pHXDKI42ZxlNARONJjj8ntJJpD5UuTZ0EWrs89oq3/5YcQ56+6O3QWLwWfHX0QxUdi3NI2/diDHgW+/zKOX3jz2qoxj+Y/o8mfqdd1rimy91KCNvJ8K+eE9cRznd9SCEFlxvXnyHEVkcwXiPjj9NoIbMsMr3GYC7iXAzEJKqFaHIe1B6GJD1h5sw7yqob2p9Qd/S7+kJWk3mgeh5xOYQbxQI2qq1qpEnuaRzaCB1HckKYhcwHqObo79N7e4zdQmjC27ZzrF6/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJR+5xDtF5fBEsLnTRFGc74na+WQ3xUhQFXj/S9b7mvXYYAGwu9nmZdvpTbUYZxOR98Qc91Xmw2LsVakIJ5EsMhqLBhTNzE6gPD3MGroILfTszW18zoDIktXehXPFr0YusTZ5gCk5xOw1LhQegkm2d6s4JLwIgB9FSmU3rHYh3wMZVZaz0wqeZbv/EJY8ll1I7K83kVaQzbl16asiInYl7Ey3U8DYAyxJdtqHppfn3H+lFvdzzYyZhdLAUkiD5rote0Kvlf2SoPDIlrHsiWej3zUPjQ5M0/D/DqwAQSdR1PRlt8mApmry+zAl1wNo1Bmia6xvzeqzMdkj8puvJNulhML10B1WYxluK3dnQk2ULIcQ7twIJX/lTOgBr1O8hn6+ZJ0tA34DePPJXuv0P7UAdG/4apf0Zlu/smbnOyiXJp8fQa5Wm+rZgafbvq3dyYyjDMAnPTqo2hgBFfIFSp2JLn92ZacEFk9/12MMVNmypXjwbZlR2S1E4WQN7ahyLwMylfBOnJvM0uCJRBku1YpOcJ9R0U1lvkzCyqlhd/TqC3gU47pIA9kLifUPw8L+5oXHlwk3qp/msHhBq1dRKJCi4Cln8ibCdG4jJuh4lrDvEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c127f802-664c-4960-cd73-08ded85698ad
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 16:25:57.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N43u0Q5kPOY1a2ofuTbfc8h01A0LxX1T/gxBpVEH95/K61XZcBqssQSJrF53rw4KITHPMTq47DXuL/tTI1Xi3+vTnjyIUnvG9q9SPcThD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB569391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020172
X-Proofpoint-ORIG-GUID: RF3hczYnWCzw5Oi0DNSR34-a4HdTDTJQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE3MyBTYWx0ZWRfX81uVln8rbpWk
 SsHt57lW7KofPw56XUjoCJRwN9bK4YELq2eJqjIGSizRyUnP2vQejRxgT+66rOGi3meeuqaRh6n
 7DExW56IOFpZB+pdn73wCpKX7c9GbzcVEw2wnNZdqW6UHyyw+umCR2Ut9l182olrpylAedeprNS
 XTKkO53KpOdo9iZmAhm/DFpHpQJY24KrtVWs/bOOBQJuzkxO7qKUp+V0kWenBbP8H7sWiTEmlSC
 xDRaX2FILcMk9/iCCxNRTZ8204g5dDJRO0bICJc0FjROyd7CUOHxHRdLwLGA/gH+YVcuzy6lf5A
 CRFfTj4bRj0W5gSA9faI8mrLgcoOA3jYeJxLRJ1LIviaA+Qd1wKitwwRSTacmtHbQTxJx72YG5+
 FvyxHnvCk79aQCtQYlYU3MNDLcchnnqAbi7CUueiv7NJQQ8vXHX7dYMmJaFZhin5stB3JzF41Lo
 0SIgzj83X3574Mw948Q==
X-Authority-Analysis: v=2.4 cv=LOxWhpW9 c=1 sm=1 tr=0 ts=6a469119 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=u9mg0psqAum5SC70FcIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: RF3hczYnWCzw5Oi0DNSR34-a4HdTDTJQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE3MyBTYWx0ZWRfX+X+PjLFOGb/n
 ASpxVPnUb06I4bfkJpdzKRF7p+3WCWHW7MHDd8IEwF39Pmly57eTDcchfnc2UOiu4XUPH1obp5B
 dAa0Rym6gi9EnYqmzJ7eFofcTJwE4Qp31nJhEwD4pGl/TdGGJIH8

Hi Rafael,

We are seeing a reproducible MySQL Sysbench threads regression.  A 
bisect indicated the following commit as the first bad commit:
f4c31b07b136 ("sched: idle: Consolidate the handling of two special cases")

The regression was found in Oracle kernel performance testing on OCI VM 
shapes:

VM Details:
* VM.Standard2.1:
       x86 OCI VM shape, 1 OCPU / 2 hardware threads, about 14.5 GB RAM

  * VM.Standard.A1.Flex.2:
       Arm/Ampere A1 flexible VM shape, 2 vCPU threads, about 10.9 GB RAM


The ResultsDB runs show the regression in the Sysbench threads metric:

   - VM.Standard2.1:       333 -> 236  (-29.1%)
   - VM.Standard.A1.Flex.2: 1286 -> 1152 (-10.4%)

A test kernel was built with f4c31b07b136 reverted and the performance 
regression was recovered.

 From the code, it is possible the regression is due to the new 
previous-wakeup heuristic in the special idle cases.  Before the commit:

   - no cpuidle driver:
       tick_nohz_idle_stop_tick()
       default_idle_call()

   - one idle state:
       tick_nohz_idle_retain_tick()
       cpuidle state 0

After the commit, both paths use:

   idle_call_stop_or_retain_tick(got_tick)

Here, got_tick is true if the CPU was woken from the previous idle-loop 
iteration by the scheduler tick, and false otherwise. On this 
workload/platform combination, using that previous wakeup source to 
decide whether to stop or retain the tick appears to change NOHZ 
behavior enough to regress this wakeup-heavy threaded workload.


Do you have any thoughts on whether this is an expected tradeoff of the 
new heuristic, or whether the special cases need a narrower condition?  
For our stable kernels, the immediate candidate fix is to revert the 
backport, but before doing that I wanted to ask whether upstream would 
prefer a targeted adjustment.

I can collect additional data if useful, for example cpuidle 
driver/state information, timer interrupt counts, idle residency, perf 
stat, or scheduler trace data from the affected OCI shapes.

#regzbot introduced: f4c31b07b136839e0fb3026f8a5b6543e3b14d2f


Thanks,

Joe

