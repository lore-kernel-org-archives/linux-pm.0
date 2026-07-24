Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E544CF4E;
	Fri, 24 Jul 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913684; cv=fail; b=ZjHG9Aw+srE85SjqPvgnxstgpy8FwIsTUPqdP7drY6GriSxzSJ6+YZSdZ44kr05J7HZ9wiEBqtj9iXvxnC6Z4SwlEfVlivaq+Hj8GIYHXuGCrlOSkOFMqh/WGtMiEWGT3KhaPINqlmQOaFSYNPFH7Mcd/bCN81tkLMrYR1DFOgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913684; c=relaxed/simple;
	bh=1fJHOrk/PcTlGY2iNErMUAxjMA5yZcRTvYRESO4yptA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGb5/Iv5sOWfBFaLYGMlrjoHG87SmRK3+woS+ffiKbpkFeEtZpCpIpruaw/HAqLxwG07kHqXO9V1o0tidKAShKhAU2JQlrSRuXU1hRDjx4b7RbBBOfz7zUOPIRoEyLesol8zon9PwHUdHZq0NEXi+ctUe1vqKICg/Xji7hapT80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gZCFCh5E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gtWzObKT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZCFCh5E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gtWzObKT"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OFBs3V3578828;
	Fri, 24 Jul 2026 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=blRSGvE3R8MhAm7l6GmVE/xbiVyyjK1y17iD8SGSlXc=; b=
	gZCFCh5Es0IGvYLxsDfFNpp9abEmpdrGoZuHM090QGdmfHic0UCP8JjoKXS4Qe4m
	MjbH7XJFXl+p62Hj1HUF051Lw9DHDjMTgLGrU2kpX+hvYvOX9nZnunWjDuwBZfdz
	i2jtI52w5wESrcVPCLByj7G5bgiloCSs/g/SOlmmt3PLCjtxJyF643PQJAJfTjRc
	mzBpnPHuf+/sinHf8yBtYItb05q334QbJYqhBNmHUXot29eXvP1hgO34wONYQpku
	k0ttCC/uGdPY74RkAL3RBiv/zeITuHVQxXlUf1LrH0lpiQDlfOcrUyMjxe4q+QIH
	61/Kg736Y0MrWcRKWRY+4A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg21q8x78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 17:20:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66OHId2u031100;
	Fri, 24 Jul 2026 17:20:50 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxtxh47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 17:20:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsKbjxB3wY7Y1hF4fQ66MVNwzmfFzgmOwNM4DDnkNmp8j5NtsKKoeI+kD416oncam8fFI4iOezRi01jFrXlMSk1yWzXxpD0JjfHRyAX4vMK0qTPY3z67mjUtSarK1+oN4pcFXdF2kLSV/VePkdu/0h0Avm10k5xMaGVaQ3+N9OzjXAgJjD7+pXO6fgjXn5SoWNqyr0vR2d/Cgjp50KXVlUmqDfNFI3HJN/8kY+bJNj0F4ZKIvrbQqWjqS7DG653M0/6qUvb8qpB2H4VHoM9d/W0qnldTgA1oMcpBVwuBDB3t0NfEIoMeLVtf3+pDk5yb7aQ/HcHZr7L/SCw2yTOs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blRSGvE3R8MhAm7l6GmVE/xbiVyyjK1y17iD8SGSlXc=;
 b=vhEkFVuQjLkg1Pvo5/fBKLOrmegeeq3oJumym/LeMdQzlNSrdzQLJvGVIc42+sJxL3fRNR8K53HVQ+QuHG8ZOZobeY7ZjVAVyFfc/KIpHzZo8XIrDWMdWF1ruSEy4D9r/R2AJvrrHYkLlAH30qBh/GyewmlJlHxTK7R8bVKA89x7Hh26lewgiM2Pe9ny03yNmeLUPGG9/EbIJt18xVP1rKTPBUfS5CviVq7Ah6yy639zSZHSuhTeLBndKpg2404ZcprTQqBb+5F62Bb1EUMK9KIyeRCv98eA78UrnDQIkjvYvp+I5b/irGLQK9BrlW+YKra9HhEBuR7gxn2BU52+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blRSGvE3R8MhAm7l6GmVE/xbiVyyjK1y17iD8SGSlXc=;
 b=gtWzObKTS7k+IoWijmO5urA3j+cK/q57pTg63vWTHXEz0y170YN7yalNivDK4/7+P37q9QS2DMv+XY0imxagEGjVBsik/qUshrbcm/VP24BunhSMZNp68q3q9oy25Wnu3rxhrPb1AWDx4Jk/CuS7BLI7BJECZCEgLc12Vqzhtks=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 17:20:45 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 17:20:45 +0000
Message-ID: <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
Date: Fri, 24 Jul 2026 13:20:41 -0400
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
X-ClientProxiedBy: PH8P220CA0038.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::21) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|DM6PR10MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fb4d5d-b71c-421d-c6b0-08dee9a7e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YWx0ZyRp4Xx9FyRI26ZZYrV3MwQE+jeakfri4aEbScmlGXWrte6wLwCcoI/0dy+Z3KL7bbUvvYY6vE0VlwVOZ9pvfrTtOzbGNmvxtvFBfjFYeByGJ+0cLs3poeb0rOWwp6T8Kqcle6YYBxF74G/mJ2tcGZ7xXPkvkbpouKGmqX98G5koSvYf+qk60IrAnwk5GTbw7Tghb0jPVoT0o4RI5+ZkS3l6vYOHyWv5B4pMD+vJTYwcEaLZTQqsDPORsU6HwErnQ+LIZzkQIV08y4ZoJI9KOzBhQm2KbUFu0E9P7PH4ZTQDDZ7IxQVqqEFdk7HqsPupJa/nXAF2g/JvOagH5NBhV5YTk4oLNens9dlR6LcRCWoY8I10vHhNxKtqzh3KFdAZgIUXUTFVLxMIrI2q7NYz6fvnz78u80EwM5y9x48Nu29ZvZbQh0xBSW0W/18WYBGSna5VYcvs+p3AtgKEk0FdWJlWLKyp7nfo+Qfreu5RpWz6OdoHlxLmqPfg309w0CqyX4IJ7ziSj7UjcngvXhLmdl5tkgCH8LpCtP8ZNxCgwdeLRhVQ7kH0UWhzfCmxttxartP3eg8E1+gs5OCOnGNIAw8AZrXL22sghVbLBhqoNo0EJCm0vVies61UEGk2QUsbHKiqCOjwo2btYXAtfnjYKpWq6baspr7pCR1wgo4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU1Xak1JeDN2Y2N3VVZFNGlLWUJZZktsamVYTktpMEhlY1pMb1B5bWlTcjFk?=
 =?utf-8?B?TWRqL3pMZ2pWaGxDdlpwSklZQ0UxVHd6L014d3F2MjdOTFNUL2VsdnF6QUVl?=
 =?utf-8?B?THpaOS9DZHJhNThrdkRxUHNmK2ZOb0VwRlUrT3lPZTRtT2NseGhjMEc3WmZt?=
 =?utf-8?B?bGdCOUdXQjVMTWU1c2FqQ0ZESDNUQTB2U3liOW45Y3NRcFZTN3B2Q0dFS2V3?=
 =?utf-8?B?MDhkeldDTDVyZ1AzUXdVaGVLVENtWDVoR00xcStxSDNMd09TMDhYM0RxTFBI?=
 =?utf-8?B?MGVYWkxlbW9PVXYyRzUwSm1RUGt6QmhxWGl0ckY4TWVVdHEyS2VPSWRKWlpO?=
 =?utf-8?B?YUpoblkyeVpNRE5SWlkrVzg1VHh4c3Y0MlRZcDhJUmM1ajR1MFJ0WkEyUjhj?=
 =?utf-8?B?aDhRMCt0Y3hEc3ZLTUM0aE9ZVlpKUG1sdUJmbFFJdE9yZEdzUDNnUER4RFdj?=
 =?utf-8?B?K3ZGMml1dXJCc2tUUTNyRDBuQVcrWHlNVUZkYlhNZU5UUHN2UVYxUVFuSUtv?=
 =?utf-8?B?ZzFTRllxQXkzempjT3pIQlkzUUxiSkZON2E0Y0FmQkhiR0NkOTVPV1Y2czJn?=
 =?utf-8?B?YjExMlhoc083QTI3N1VNelNLM3E2T0tURE5IZWIyL09BUXZPQmxYaFRKaDBo?=
 =?utf-8?B?elNVSlNJRlRFalp5NVlQYjBlTlA2QTArQ0FBaXNrRHZHSkdEM3M0ZHZEV1py?=
 =?utf-8?B?Rm1tc0xYZ0xaU01CMEdYbHNOOXp0SDFldWlwSVBKQjY4Q1lWVENkUzQwQjRu?=
 =?utf-8?B?VldjWTE3RkVnN1N5NlRKNHJINVVOMjJEQzlrUVZkL1RZNVBNbEQ3N2lRcjJV?=
 =?utf-8?B?VXBNMzZNL0RWMHhIRm53Q2tad1AxSTdublBiTHhVcE1TbjJXY1BjOUV1cXFN?=
 =?utf-8?B?YkpsTDBPK0J2VkR0V1Bwajg4cis4aEEzWlhkU05xbkRVa0JOMDE2aW42QWtx?=
 =?utf-8?B?WVBEUzJOYmU3U01ZMVdPQ0ZSR2V6UkdlTnpzemVzWkdvdjRrRno3Y1k0aTNP?=
 =?utf-8?B?SkpxS3BsMnlaVXpaTElyVm1Id1JuOHl6V0diVFFrRmtDbEtKTUNJaUFHbmtk?=
 =?utf-8?B?dmpZR0Z5MWtpQXd0cng5QkhrZDY4VlJwM1Raa21XNExTenJnNlk0b014SW1k?=
 =?utf-8?B?WFgzdVQyTFZJbVFGcHhNRUY2TU1jSWo0L2RlYVdzQSsvbGtQYk1lc091WUJY?=
 =?utf-8?B?M0o5cmpHU05XNnQ0bzZSd0xWT21ZZlBFSjZ2Sjl4NnlZY1ZoMlprMXBGK2Na?=
 =?utf-8?B?bDFaQ0tyMjMzSlViTTBBbTIxNTJpeHB4WkR2NzhvOEloN01zakdHSno1U2M1?=
 =?utf-8?B?MU9pVmpBaTZHdkg5QjZ5UTdYa2c3OTdWbU8rNzFoa2I0ZnZYelNOUHdDYUo5?=
 =?utf-8?B?ajRkRG9ET01Pa3hKZE90OC9iZm1uRmRyNW9sYnl1R3RZa2IxWGhKOWk1cFB1?=
 =?utf-8?B?cy9YTWVhZ0pPMWJjNzdLbnRESXRUd29VSnAwT1lXTGhDRFhWWDI3di9hbWNB?=
 =?utf-8?B?YVNESURPOVlZT05wVHltd1dSZkNjZHlYNWZJT1JmMkE2K0VQeXBKL01DbGZ1?=
 =?utf-8?B?V3pXYU85NnQ0TUw4QUNOU0FVVnhhSlhwYTlFWGZQblptb1VlRkxST2JDSUwv?=
 =?utf-8?B?d21ZWHRjUjI3NWozK09CNkhNS3RwQVNOWkhHZncyY1VoMGF5YlBmYXQ4N05I?=
 =?utf-8?B?N3FiN3pqbGpUMWJzQ0JYajhCeHVOSFl6V2psSi9XdWEwWFh1Vndka0psNEJI?=
 =?utf-8?B?Q09BQnhwWkpESnVzK09FZHBSVjZtSEFja01kNTM0YldIdWZheXE1ZWNKd3V5?=
 =?utf-8?B?Ukw5djhhRHpCaGRaQkxlUjRWcnhheE5ON0RDYVY1NFJSc01ZOWV3aE1kZUcw?=
 =?utf-8?B?YVBFaWtUL1JPUUdMUkdDSXpZaEZTdmFxYXk3Ry9xOWx3amxKWkNwdjMyOEpt?=
 =?utf-8?B?dVl5VGtVZVpSZlFDOGRROFJNeW81Vyt3ZEF1UTUydDNIcDQ2YW5DdmRreVdG?=
 =?utf-8?B?TjQ3QXRab1llcStpNzdPUnI5UlVCRy9hbmRGdmtwTGNiM3lWUEZuVXlES0Qw?=
 =?utf-8?B?YW5zaDM0dHZjby9EUjVwYTgrTk9lZWhlTk9GdHo1VnhLUGx4U095U3JmMnRy?=
 =?utf-8?B?YzJ5R3Z0ZHBTK1o5WllrS2J3VWFuY2docVF5S1A4NFV4MlBjVFBvOGQ4dkQ2?=
 =?utf-8?B?b2Z4d3lhTGJ3a3B2NEkxRUwxWFp4L3JMa0h6aVR4alZWYVo2OHVHVWRvRUFC?=
 =?utf-8?B?dkFJMk43OFIrT3RkUDUzWkJrNGgyRkZsSWFqemc4cXhLVkF2RFRZQmRIczRP?=
 =?utf-8?B?T0NTUE52dXBwejNZVDJkQWlOeUFOOVh5ZW1lOThzYitOcnVhK3JlWUxzMVR0?=
 =?utf-8?Q?LuD9XpAHoCHE5SW8=3D?=
X-Exchange-RoutingPolicyChecked:
	ZJxR2xL+yQrnTIPioaoA9AT2dnil29Q/0gkpFIgKUOPycfv3D7X6pkTcHobGliSA/XRaP56t6EvTl4jbEinOH3S6QaWCMTl3DjyYuxYdjOxNOZpYpC0sLmaAAm3uG0pRnxOT7ZWPkh/vJmqLgEGRkIOkbJo9o/LQJDdLKRu3FTA8aTDMkYoRFPcMN+5RBSp8bm/2fDI58+ebJBkKmcG/U76EnuVgmYGgCpL4qlglFI31w0abho/uRmuKh0LTAbMzMeZQOvoCQgMZqU+3y1DxL1QrHerJIj0CTOVM2p1V1lI0Ypq5dFmsipbOI2vGTimE8vraZkCuYIE6fZGtuVbteg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LUwCIatqL4JHpRqj8PPnlJMsJ7hf+1dpP8oTy+5zBtpcSpbPKMShVLBFbN58u5o/kU/17nOhbGtV8wHMBb02jBEzAsQZSbDk8CM4S6qKlM/EdhRt+cFySBIeoyGkajdYcbhO9wUwM6KAAriF24bhAfF5IcfmFrMqS7KQ44dezGPxbDRuq5efvgV1z0XMiVnwXnMQesvuViv94LuvzCFFrBaDA/lOPfzy22tCqy7upE2SRKUVP8gdXVkcAIYXExDmwhc0GgjhXxrq2Dq3zOdE2TnVVwpIqPZMDRE8fFMPFyclA5aj+Slambh/6Z6bZpumExAFxJW1uXOdq8Px4UOWY7ERpTaWvidsWqQWD6t4Y70fwD1aspQVvt2xUAZ7OjWigmQaYlNY+CSu3LoqP4R4RpdlJNqjmPls361KTkGJPWmAlPQVILFIWOpyxnLcDrPbZNemwq8iFgbhZgR/JiPBpROrjuBX9z+SGNFzbRFBb2mEe7PkyeJGt8GFHA5tf7mKJe2B+dYUlvjhMQrueSsxnAl4ux4y4HSnTCDY/Vz0EhGHhwVoVY/pdVteuc3uuYkEef9KdOruK/0lOpbyjqeDY2VaD55wK64A3bT0XdjQwB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fb4d5d-b71c-421d-c6b0-08dee9a7e548
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 17:20:45.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYsLUv2fVA3XpU8zZxWyYKgT6LvNHhDR6bI5MfD8/jEkON1yUQVglJ8QJSXwqSiLKjceCwjgQjUXaxyAWvppKcU1BqBYUSzi94rY6YDhoh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607240156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1NiBTYWx0ZWRfX7RGtYJk7WPRy
 UEV+d21E0v3zy2wsp7xR5hk+k6Z8NWdGJdY2aChHceIx+BUHOx1HtJvS77m8SY5/w/EoDOsCLIE
 36aMp90J5j5bhfGiLZE8GbwU9to0Ld43ASHO1CJgR0dkM7ZwL9GRdgvKJzLAsi6jTGVTzM5PDFk
 SJIsjWyaHmsvwbig8ukcI/c5QvdOm6G/AqAw9eLzIFGUmUWoaJDhyF/5BQw6SpH/L4KkfQUNed4
 bpPYyLwb2YgBis1f93KlrjaGyjBFN8VM3zQXRigpAC6EjXfDrkbSUAmplHsrZQkUdOMTeneAvqm
 2/a24xkPYPSggI1QQ/ahs9nUDefq1jBvstMkSwhZGV7Yjs2vxuQ0XLEj1D/ttR64u+lEwMBZ7Yy
 J4S+XmE3idordlQs8ou/y0i3DUAbIsKScgKhI2z1n1n45IMowFNzfwAlTe02btq5ZpoFYDlRzyC
 7b0C5RVTI96rXq6z5KNJpL0IotWe2FsradxJ5Omk=
X-Proofpoint-GUID: mZtAdhB_ZzF_AE5efIrUGLDoUbA13ske
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1NiBTYWx0ZWRfXyA72oM3vGKdG
 e/D0FYsC/v4m1+JgaqfeZRfyJdTa4KyG/Jgc8SEB5r4n2Q97jMeRpXzkeDojXfdw+2krT+/ytBL
 1WsltkHOrOFqMToVtj8AckmuvgabdZZDV1kxXI1Tk9DOZt0sltO4
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a639ef3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=sokhk9NVvZNfI4dK3W0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12115
X-Proofpoint-ORIG-GUID: mZtAdhB_ZzF_AE5efIrUGLDoUbA13ske

Hi Rafael, Christian,

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
The guest-visible data does not show the single-idle-state cpuidle case.
Both affected guests report:

/sys/devices/system/cpu/cpuidle/current_driver = none
/sys/devices/system/cpu/cpuidle/current_governor = menu

There are also no /sys/devices/system/cpu/cpu*/cpuidle entries on either 
guest.  So from the guest data, this looks like the no-cpuidle-driver 
special case rather than the one-idle-state case.

The full revert of f4c31b07b136 recovered the regression. I also tested 
Rafael's suggested one-line change, applied as:

     -        idle_call_stop_or_retain_tick(stop_tick);
    +        idle_call_stop_or_retain_tick(false);

That test kernel still showed regressed performance on VM.Standard2.1.


>>
>> Overall, it would be good to know the idle state lists for both the VM
>> and the host.
For the VMs, there are no guest cpuidle state lists exposed because the 
cpuidle driver is "none".

I do not currently have the host-side idle-state lists from the OCI 
hosts.  I can try to get that data if it would still be useful.
>>
> +1, but also which HZ are you using?
VM.Standard2.1, x86_64:

CONFIG_HZ_1000=y
CONFIG_HZ=1000

VM.Standard.A1.Flex.2, aarch64:

CONFIG_HZ_250=y
CONFIG_HZ=250

> Both systems reported have 2 logical CPUs then?

Yes:

VM.Standard2.1:

CPU(s): 2
Thread(s) per core: 2
Core(s) per socket: 1
Socket(s): 1

VM.Standard.A1.Flex.2:

CPU(s): 2
Thread(s) per core: 1
Core(s) per socket: 2
Socket(s): 1

> Were higher core counts also
> tested and how does it affect them?
Yes. Higher-core-count runs were checked. The regression appears limited 
to the smaller core-count shapes.

The current data shows regressions on:

- VM.Standard2.1
- VM.Standard.A1.Flex.2
- VM.Standard.E4.Flex.1

The larger tested shapes did not show the same regression pattern. The 
test runs use one sysbench thread per online CPU/core count as encoded 
in the metric name.


