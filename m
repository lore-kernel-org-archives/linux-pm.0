Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023140.outbound.protection.outlook.com [40.107.44.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBE405C33;
	Mon, 18 May 2026 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072063; cv=fail; b=oXeu7dgAkI0dvtnqUwl5nDefUg6zFQU354KQH7eJoezEjl7U3gfeo23ZUJsPQNSonjPjfIntBN1qME+I9UBrRVuhgxNrNB28RV/cjufFJfVC+NUpQsi0AXwaLbuN3FUvgx9AAox4T/Ibv0ezj5R/6x3460nSZL1arhLEW4mDAoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072063; c=relaxed/simple;
	bh=jFM6O006MLbjE5Kx6quz0tismilBrM1wtkCqvdkrfMU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lH9hQXs/p6T4eHe31WmBmuXrdsBkdDkL+6qeiEa9eHyhCOljCmFwOZysEDcgND+Gc+2kq0Cd8asU8h/StCNChKTwDQI3+yuZIaLxcT3bcTRIfbPVBmsxmqXsrpr/nFglbAtv/kRGt9NseZtUUhoEsxpzQmb1gqvtbqzO5pH4+64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Ib21+rZv; arc=fail smtp.client-ip=40.107.44.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Ib21+rZv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvsmV44W0m4SglofhCK2tZdX7vLLoj7wV7n3ZvcjbCK8lRYVmj190giglRxIJTrQZSyeM2cS8Qzg/bntSzypIQ9zPIMbgzBW6r1or6Gxq5sXI5lx71Et+GrxkC2BQZFN50Hsns4f2rqrN9HYu0XyMBEd/RU5Mp2tCgF3altNCRp0hveqvjPQhsXznA7uiPuI1qiudlrZaGmgbhByP+XACFYhcLc/DWPBfepPwhQQLNqLDmqw0kFK8bpKF9Vy/iPiFB+WbnaQlrZRvKSknL2XI0ZpuXQYZuH3ju0C9M5H1MQ4IRz2TQnhTZYE9f7jACRjM/soZlNvi/kA2cb/jPI1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/ekyWoE/hE3n1ZhB3B9jvQ2Jc2RHfSbyHZCl+ymMHk=;
 b=d6MdMcb7lTHpgpp1dAENC9eFiPnt+1Y6I5tWKCmuLyKWKib3iy0FCAaDhCVN2E/wCj9qfXHBr+ksYKhjwNSB/lb49ifreGno7GI87zetZj7j4dTLyPDglTF7f/uOHLw6EZwiuRMEC+OqjY0+m3OFde8BR2qJDnAWUludpoW3ZDkjzTcgHo3x/r+xNGHe0912lNgSXDGUJhbCwaAAE+FztMekxk3MVIxeSR57Z+8/s7QOcFcC/u62xfOgmYoTd0/I0zzXYHERTLwGVySHEvuwD71wJf8ViDyDWbUoooHYd+UpoG8Lzff18wN/mI5KCjjHK/YYQEXT0X/+Y3RQr7y+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/ekyWoE/hE3n1ZhB3B9jvQ2Jc2RHfSbyHZCl+ymMHk=;
 b=Ib21+rZvJrJR6h5FlaoLuxQuvLWxtwwormj1MV31xDydzK6QUTBUzYhQ0qDt5kLqORhk/bHZdBtvCF8EiNEq0qnps67LlwKybRFk0H+ZHUQyeNyaa2+/nirgTZzSfIlIAwjZ6Li0LoW0XddkLmzzjJJPESU1VgViAzGIOfgsAcE=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by TY0PR04MB5681.apcprd04.prod.outlook.com
 (2603:1096:400:1be::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 02:40:57 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 02:40:57 +0000
From: =?iso-2022-jp?B?aG9uZ3lhbi54aWEoGyRCMkY5MEknGyhCKQ==?=
	<hongyan.xia@transsion.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>
CC: =?iso-2022-jp?B?aHVwdSgbJEI4VWB5GyhCKQ==?= <hupu@transsion.com>,
	=?iso-2022-jp?B?amlhemkubGkoGyRCTXs5QztSGyhCKQ==?= <jiazi.li@transsion.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8A==
Date: Mon, 18 May 2026 02:40:57 +0000
Message-ID: <20260518024039.932-1-hongyan.xia@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|TY0PR04MB5681:EE_
x-ms-office365-filtering-correlation-id: 1e23465c-62c0-46c0-2db3-08deb486e3d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 1I4tqSl3vN4qBVtBPmSRC36fii6rFiWhaZstcA6tYQIMg0AdiCtznheSA+CVdNhcMIZ805etQn2z/yQmwJFqdssAC5qPh7ugIAPTrFrveG2DI1ss8Vkj/FWsPNiFJWxoNiGX/feJgTQ94BidwmIBo8u22hJBnSKkT8czBUeBPnsTrNuCx4qSIJuqvxgRzCbcuKDZZU9FhStQ1PA4PvJGaizfKVT4JiakzJhssuVu30X4e8J+y/QMFLGph/uFzrUitR6lS1GzzBH+V3deF0u4rUlfOuWfNzRsl0VMC0I7xl64ARxDyRh5QsGwac4rN9ts4U8cItzekbIwz3ctmG7OkpIVJLDyLxy7dx0d3PWHHYWuILPkS75Qc/dNmGXU5Bt1B8jw9ILZNox0k1T2A1S58D/tA2wqxx12P710yXDbx81soLb/sLiEV5D3cHGPHMbGWkDuVq05WBlX2v+r3SBSZ/hzlOk33OMCpfJVi/PVI0Xw+up+evLGrhV6sDn4ZA9IsaejqjPHKowsbXAvhFmH1liV+PwRDHBNWdt8fdD7CdVCtsJJCr1JhUUTwCcbFhncPSwSa9FUROVOc/iF0ISe/sy4X84HmQlO6diibXuOX+nV3uFpglZelx4ycAEcWvp80G4DhsQKs/A/UhI0zbmFb5de6+pVuEE1xxxtI6+bFl79WTlRISRBq6XiMq77Dna1MMR27tk95QMb3jw7aVCIjZo1UOYoTob3j7UAtjKsbN8tRG14lqt2bO3o6bfV6spdlLZoCxhiZIG/1hwzbgqkWA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799003)(18002099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?b1RWZWJLdWlIcGtsS0hHVmtaRVBwWTdoaURvelFHS1FiekZFWGJGd2x0?=
 =?iso-2022-jp?B?dkIyUU1VRTVjeG90OWpnQStTK2VmV3Ztc3l2clUzaTBNV25GMkl1bDVY?=
 =?iso-2022-jp?B?Q3BzL3dTL21obytuaWlEczVxNVBDVjU3eXBZOVNNeUlwWGdGZUxmWmkz?=
 =?iso-2022-jp?B?RmZBZkJTbUcwRDZDR2Rza2JtaXJ2UGJDMnRTMGVCUVBpK3oyeDNwU0lD?=
 =?iso-2022-jp?B?TzRYZTdacDUxbzVlb1VlaXNWNUdrN1JUdzNKTnUzTDkzdk5UZUhoSFhZ?=
 =?iso-2022-jp?B?YnpsUVIrT05uM2p6bFgwREhFTm91b3FrMTdFZXhENlhKaEVqUWFkYWVn?=
 =?iso-2022-jp?B?VlhyZUVFRnZoUU9mSUwvdW0vRVhWVWhXUDlqQ3hvT1Y5U2trcnQwM291?=
 =?iso-2022-jp?B?Wk5OSUpxOG5Rblc5ZVRvdml4Zy9uSHlXUmZWNCtieFdtM2JSMTRET25l?=
 =?iso-2022-jp?B?QUhRbEl3ZGJURi9EVTRZWVFyclZYVlh5WEJMUjVORWNhSDFObmlXZkpG?=
 =?iso-2022-jp?B?eGNWREdUZmlCQlhzRzhIUGYwS1hPeDNtNnNrNU1KSlI0UXNTVmM5eGxn?=
 =?iso-2022-jp?B?QzdqOVU4VXhwMFFPK0hXaGtHMjZQU2xveDRPVVdCVnJ1d1ZpQ2ozdlhq?=
 =?iso-2022-jp?B?Y202ZXF2ZHhDUnJ2VFdEbjA5cUN1cDIvVVJGV3laQVFUd2tuZ250TWhs?=
 =?iso-2022-jp?B?OVhiZTM0N3o1YlZOTTZMUTFjY0lIUEFMaXlOL3NCZWhFdXdmYTNQbk5O?=
 =?iso-2022-jp?B?dXY4TjlPdjRjQ01lZFNkTVA2M2E2VitlNlc0U3dvaVBwdXUwUWxjTURU?=
 =?iso-2022-jp?B?TE1mWWJzNVYrdHlwcFhFcnlZaG41eUg5cGRnRXRYQW9JdTBXZEQ0Zk5E?=
 =?iso-2022-jp?B?Ty9XSjcwYlZvdzFROXRmYThrYWcwVjlzSkx4ZTJLNDMwRDVYTmF3d3B2?=
 =?iso-2022-jp?B?RCtzNTljd0ExcElwMm9TcGo4ZHFWM0RIM1p6RWRyK3FXb0EvR0pFVGhC?=
 =?iso-2022-jp?B?QkhFZGxpVFgxeXBNZktudGZkS3dXM1Mzb2UrL2Zady8xMHZzeE03c1Rk?=
 =?iso-2022-jp?B?NjZSRGVVY3pwQXpMTzRtR0o2T2d6czVxU01UMEhYWElhbUl4SVBkQjVO?=
 =?iso-2022-jp?B?N2ZmKzZ3NDhjUmZ1cHBENTJiTWlBS1k4ZXZzcDN0NTk5TzN5UzlvZU01?=
 =?iso-2022-jp?B?dW5paEtkK1Z0NjczRmYraXlSWi80OXkxUlF0Qk1aUjFNaUhJTllUcHNq?=
 =?iso-2022-jp?B?U1dPMEN3dWphcFQxTEdlaWcwZTNxLzV3T3VVaWNhUWNqT2NZREJVZ3Bt?=
 =?iso-2022-jp?B?ZE04K1hEVTZ6eWxnYTZWVjBnelBSQ0VwU09UVUxXaHBrVEpyUGFNV25z?=
 =?iso-2022-jp?B?SXZUV3pWYlpDdFB1bHdDR29tQkROd1JVa3dPNjhmZXFSa1NSYlNtRlAx?=
 =?iso-2022-jp?B?SWdqMUtweUtMalE4dllLZnliTHNlRGFhWXljWExNZXRWME9pOGk3dmxu?=
 =?iso-2022-jp?B?ODV4VWtRMzkyUHl2bmhMbEtmdUNnSkRDS3dVNmU0VTdvaHczOVBjUVFF?=
 =?iso-2022-jp?B?ejZyb1czMktPSGozTndsZFBWZjc4NldGR3E5aGhJZ0FxUkJESWpwV05G?=
 =?iso-2022-jp?B?UmJPTHJZY0kvbjZ2RDdsUTVFSUo1RjQ2MzFjbmh5NlZEWUs0MTFQZFZT?=
 =?iso-2022-jp?B?Vjk5NldENWhtSms4MnFHQVd6UEZWaGxVUVYza1ZMeFVGVFN5NDV0SlJF?=
 =?iso-2022-jp?B?YnJ0WHR3R0c3RVozREtsRUZzZ1d4RENobWtrYmdGNFE0V2YrdUlIbG5y?=
 =?iso-2022-jp?B?MkV2U3pQald0b3MwRXk3RGJ1cXlTcnBFVlZ0UFFQNFNCMCtqMG1Wb1dN?=
 =?iso-2022-jp?B?R0EvcWdVeGFOSnJZbnl6TGZFeGRGaDJROEVtYWk2cTcydi9icFY2VHFk?=
 =?iso-2022-jp?B?WDBPQkFFMnVIUEhXbmVQWE9TWUVIOVFYYVJmcitubytBZHFFKzhXdzZL?=
 =?iso-2022-jp?B?ME1NZmxwR1ZMQUJYZ2FlTElIblZUd01Pb3JnWkRXVjJwSEF3QkRjUmNJ?=
 =?iso-2022-jp?B?TW1IZGtKZmVRNE1ZR1JXQWJla2l3dGFTd0VSVk9rdytqay9QSy9KaGtx?=
 =?iso-2022-jp?B?T2xxaW5CV24vZVRlc1BSejN1aXlFNXBYWnJYdFgyek4vU2ZjNmJlRUpN?=
 =?iso-2022-jp?B?WXh1dzBkVFVkbGtmVnR0dFFHbHBHWURsZkFLWmM3Y3puaGQrS2dibTk4?=
 =?iso-2022-jp?B?UEgybDdZSzRmeVlRRWtkZTBVY3BIamczdFpKVC85SXdVbmMvQm9WL21X?=
 =?iso-2022-jp?B?ODVOQU14RndKVTVidStmZjZBd3dTbXBpWHJsN1RVa2pNdmE5enN1cnNo?=
 =?iso-2022-jp?B?aHl3VW1lL1YwWTBQSUw5VDExeXp1b3F6WURma21EaTJvZlVoNnlEamlj?=
 =?iso-2022-jp?B?S1pJdlQxUlp6a0RaeG4vQ3ltdmZpK0tMV2U1V24zOWZwQVZpbitiTk8v?=
 =?iso-2022-jp?B?bUhwMFVZVSs1UnlEZDA4angzd05lL213NGlLdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e23465c-62c0-46c0-2db3-08deb486e3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 02:40:57.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qLyZsEbGHx8+9l+57vOTVM8jjGt4GZsd66+aR1rA8YJfVYW4DkeGORZO6d4sZABHJQ0b+GfjYuNOf0rCSQl2Sn9PN+gapLumHPO1CcyD5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5681

From: Hongyan Xia <hongyan.xia@transsion.com>=0A=
=0A=
We have seen a massive power consumption regression (20% SoC power=0A=
increase in many apps) after updating our kernel. After bisection we=0A=
pinpointed the regression to the cpu_util(boost) feature. After=0A=
reverting the boost feature the massive energy regression is gone.=0A=
Detailed trace analysis down below. The regression is found across quite=0A=
many apps but Youtube is one of the worst offenders, shown in the=0A=
1080p60fps video benchmark:=0A=
=0A=
 Setup      FPS   SoC Power (mW)  diff=0A=
w/  boost  59.94      913.6=0A=
w/o boost  59.93      720.4     -21.15%=0A=
=0A=
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>=0A=
=0A=
---=0A=
Analysis:=0A=
=0A=
We found several problems that result in the power spike:=0A=
=0A=
1. Arithmetic should not happen between util_avg and runnable_avg:=0A=
=0A=
After util =3D max(util, runnable) which potentially picks runnable value=
=0A=
in cpu_util(), we then add or subtract task util values from it. This=0A=
produces a value that is half-runnable-half-util which is ill-defined.=0A=
This alone should be a warning sign. This breaks EAS calculations in=0A=
many cases, leading to sub-optimal task placements.=0A=
=0A=
2. Using the absolute value of runnable_avg to drive frequency is=0A=
   too high to be reasonable:=0A=
=0A=
We use runnable in a _relative_ way to util to know whether there is=0A=
contention in several places. However, the _absolute_ value should not=0A=
be used like util. Runnable_avg tends to be significantly higher,=0A=
making it much easier to saturate frequency.=0A=
=0A=
For example, if three tasks each with a util of 100 contend on the same=0A=
rq, the rq util is 300 but runnable_avg shoots up to 900. 900 drives the=0A=
CPU at the max frequency, and it's highly questionable whether this=0A=
boost is the right decision.=0A=
=0A=
3. Runnable_avg may not even reflect true contention:=0A=
=0A=
When tasks are dependent, the bottleneck is often the data flow between=0A=
tasks, not the contention seen by runnable_avg. Boosting frequency with=0A=
runnable in such scenarios wastes power without performance benefits.=0A=
=0A=
We found 1 has minor power regression but 2 and 3 regresses power=0A=
significantly. We have seen multiple applications with the=0A=
producer-consumer model with many worker threads suffer. When there is=0A=
IPC between producer and consumer, boosting frequency blindly does not=0A=
help performance at all if consumer is limited by how much data is flown=0A=
through. Youtube suffer from 1, 2 and 3 at the same time, leading to a=0A=
total SoC power regression of 20% shown in the results above.=0A=
---=0A=
 kernel/sched/cpufreq_schedutil.c |  2 +-=0A=
 kernel/sched/fair.c              | 32 +++++++-------------------------=0A=
 kernel/sched/sched.h             |  1 -=0A=
 3 files changed, 8 insertions(+), 27 deletions(-)=0A=
=0A=
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedu=
til.c=0A=
index ae9fd211cec1..ba867192513b 100644=0A=
--- a/kernel/sched/cpufreq_schedutil.c=0A=
+++ b/kernel/sched/cpufreq_schedutil.c=0A=
@@ -228,7 +228,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, un=
signed long boost)=0A=
 	unsigned long min, max, util =3D scx_cpuperf_target(sg_cpu->cpu);=0A=
 =0A=
 	if (!scx_switched_all())=0A=
-		util +=3D cpu_util_cfs_boost(sg_cpu->cpu);=0A=
+		util +=3D cpu_util_cfs(sg_cpu->cpu);=0A=
 	util =3D effective_cpu_util(sg_cpu->cpu, util, &min, &max);=0A=
 	util =3D max(util, boost);=0A=
 	sg_cpu->bw_min =3D min;=0A=
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c=0A=
index 728965851842..86c6814121b8 100644=0A=
--- a/kernel/sched/fair.c=0A=
+++ b/kernel/sched/fair.c=0A=
@@ -8192,7 +8192,6 @@ static int select_idle_sibling(struct task_struct *p,=
 int prev, int target)=0A=
  * @cpu: the CPU to get the utilization for=0A=
  * @p: task for which the CPU utilization should be predicted or NULL=0A=
  * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p =3D=3D NUL=
L=0A=
- * @boost: 1 to enable boosting, otherwise 0=0A=
  *=0A=
  * The unit of the return value must be the same as the one of CPU capacit=
y=0A=
  * so that CPU utilization can be compared with CPU capacity.=0A=
@@ -8210,12 +8209,6 @@ static int select_idle_sibling(struct task_struct *p=
, int prev, int target)=0A=
  * be when a long-sleeping task wakes up. The contribution to CPU utilizat=
ion=0A=
  * of such a task would be significantly decayed at this point of time.=0A=
  *=0A=
- * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization=
).=0A=
- * CPU contention for CFS tasks can be detected by CPU runnable > CPU=0A=
- * utilization. Boosting is implemented in cpu_util() so that internal=0A=
- * users (e.g. EAS) can use it next to external users (e.g. schedutil),=0A=
- * latter via cpu_util_cfs_boost().=0A=
- *=0A=
  * CPU utilization can be higher than the current CPU capacity=0A=
  * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because=
=0A=
  * of rounding errors as well as task migrations or wakeups of new tasks.=
=0A=
@@ -8229,16 +8222,10 @@ static int select_idle_sibling(struct task_struct *=
p, int prev, int target)=0A=
  * Return: (Boosted) (estimated) utilization for the specified CPU.=0A=
  */=0A=
 static unsigned long=0A=
-cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)=0A=
+cpu_util(int cpu, struct task_struct *p, int dst_cpu)=0A=
 {=0A=
 	struct cfs_rq *cfs_rq =3D &cpu_rq(cpu)->cfs;=0A=
 	unsigned long util =3D READ_ONCE(cfs_rq->avg.util_avg);=0A=
-	unsigned long runnable;=0A=
-=0A=
-	if (boost) {=0A=
-		runnable =3D READ_ONCE(cfs_rq->avg.runnable_avg);=0A=
-		util =3D max(util, runnable);=0A=
-	}=0A=
 =0A=
 	/*=0A=
 	 * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its=0A=
@@ -8295,12 +8282,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu=
, int boost)=0A=
 =0A=
 unsigned long cpu_util_cfs(int cpu)=0A=
 {=0A=
-	return cpu_util(cpu, NULL, -1, 0);=0A=
-}=0A=
-=0A=
-unsigned long cpu_util_cfs_boost(int cpu)=0A=
-{=0A=
-	return cpu_util(cpu, NULL, -1, 1);=0A=
+	return cpu_util(cpu, NULL, -1);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -8322,7 +8304,7 @@ static unsigned long cpu_util_without(int cpu, struct=
 task_struct *p)=0A=
 	if (cpu !=3D task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))=0A=
 		p =3D NULL;=0A=
 =0A=
-	return cpu_util(cpu, p, -1, 0);=0A=
+	return cpu_util(cpu, p, -1);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -8489,7 +8471,7 @@ static inline void eenv_pd_busy_time(struct energy_en=
v *eenv,=0A=
 	int cpu;=0A=
 =0A=
 	for_each_cpu(cpu, pd_cpus) {=0A=
-		unsigned long util =3D cpu_util(cpu, p, -1, 0);=0A=
+		unsigned long util =3D cpu_util(cpu, p, -1);=0A=
 =0A=
 		busy_time +=3D effective_cpu_util(cpu, util, NULL, NULL);=0A=
 	}=0A=
@@ -8513,7 +8495,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpum=
ask *pd_cpus,=0A=
 =0A=
 	for_each_cpu(cpu, pd_cpus) {=0A=
 		struct task_struct *tsk =3D (cpu =3D=3D dst_cpu) ? p : NULL;=0A=
-		unsigned long util =3D cpu_util(cpu, p, dst_cpu, 1);=0A=
+		unsigned long util =3D cpu_util(cpu, p, dst_cpu);=0A=
 		unsigned long eff_util, min, max;=0A=
 =0A=
 		/*=0A=
@@ -8675,7 +8657,7 @@ static int find_energy_efficient_cpu(struct task_stru=
ct *p, int prev_cpu)=0A=
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))=0A=
 				continue;=0A=
 =0A=
-			util =3D cpu_util(cpu, p, cpu, 0);=0A=
+			util =3D cpu_util(cpu, p, cpu);=0A=
 			cpu_cap =3D capacity_of(cpu);=0A=
 =0A=
 			/*=0A=
@@ -11848,7 +11830,7 @@ static struct rq *sched_balance_find_src_rq(struct =
lb_env *env,=0A=
 			break;=0A=
 =0A=
 		case migrate_util:=0A=
-			util =3D cpu_util_cfs_boost(i);=0A=
+			util =3D cpu_util_cfs(i);=0A=
 =0A=
 			/*=0A=
 			 * Don't try to pull utilization from a CPU with one=0A=
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h=0A=
index 9f63b15d309d..1c934dd126b2 100644=0A=
--- a/kernel/sched/sched.h=0A=
+++ b/kernel/sched/sched.h=0A=
@@ -3551,7 +3551,6 @@ static inline unsigned long cpu_util_dl(struct rq *rq=
)=0A=
 =0A=
 =0A=
 extern unsigned long cpu_util_cfs(int cpu);=0A=
-extern unsigned long cpu_util_cfs_boost(int cpu);=0A=
 =0A=
 static inline unsigned long cpu_util_rt(struct rq *rq)=0A=
 {=0A=
-- =0A=
2.47.3=0A=
=0A=
