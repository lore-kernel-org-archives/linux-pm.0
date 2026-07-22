Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E737EFEE;
	Wed, 22 Jul 2026 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733700; cv=fail; b=dN2PGMMz/Ytki1ySFAE/6XUZN7Dmd9ERfmUVMYTtCRNc2aMoWTTAnuYDeP1QOyhl7aO4Zkh1+TR9Lw03JfM7VFNJca469pJaP//IOL3Ojgxi/q9Ja9tshB4JzonRrUhG3bIlNSTQhqzodP83weH6Uk36foVn/yZQ2BH9ost4dEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733700; c=relaxed/simple;
	bh=xutwVITmTecjJXeZK8+d43L6rKYh+Gb2dIIEVDbU9nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZmguG7fADCWUO0TFGeAHKmmRN4256xJqynZzCJBuzL3xTVmiaPrCwH56bv2n9QjWIeRcvUxP+ea/Z5lugR85I4Au31V7rV5MFQodhU741zPdJc4uWKnFUzIf55xe7dwAupdqiHD5XzZcW4KGYfD8Z2ud/3SI2bzeK50VfjS+QMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ke5KATL9; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ke5KATL9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVX56WqmhSaKPUKjFUrBKEjAKr7+HUry5v4TTkUP++UIMGvJgdW5kTh7TMhxpkY4AlP2lvjumUB0hpvQqYnhuRdWFS1xpR580HW3jvf7psxaxTSBwNOERTlPIkHszqxNudt5p3ToezSq4oqk3w7iLPknr0CF1BFJSyHaUBDPavtqoZdz67IgfklrsWiXH1XFoWMHfj9EqzZR16duRF5WMs+GuOGPxKgGCsNSItoMN/sw0RtsjlC56ZfKcdiCinKEb5mB687aFNSy9Ua2QxxQV7VqeHPUvNUOpneBAMkBKLWBRf4Sy4xU4dL+/j/qbNopzlsNUQsiP307pAQjGPIkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvVm/8L7Nod8MFQIK3iUzm2PLSu+Bq/Q08s0wILBxgM=;
 b=qXat/A8cZ38J3rl5Mur8ruz/nNEtzHulpy132PY4FMWakNayjNGh/DnJHx2A3piEDaiGIVKruAnCMOJB4CbNke50RSkSNfLSn9entZawolCbEos+qVJy/gKMnZ7Mb0LNfukSn8Lhuv12HKMiiCEP9h1wpu80cjK1geULmfBL0HuYMvD0qiOdaGFbF6xBRwInooxHcWeg7ES2Bnt9nEhEerg2ww+WS0Ptb39QaO64S4xHyiYdxp/j/to5OldzRh/g9LIggDWbDLMn3ZLyBYOlRADxzUBNMBx0/QqXTEKXG11PCIi/fqctms7juOMQLyDf273S7mLx1fYKVQBtHDM+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvVm/8L7Nod8MFQIK3iUzm2PLSu+Bq/Q08s0wILBxgM=;
 b=ke5KATL94s9Qqo+dtWeAwtTjzsDgPirf1lNXOhiE62W0z1pJjgSEaqYNeasmOtHMZCbc1BgJ2KzQshiZZsHqsGUDdoXG2G2Hq58jfX8RXvCx9en2JOG1QJ+lp3z3RAG76ilm1LvyMB1aldjZuW/OYphYaOs58Qfs8mpLW2hI3Zc=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:21:29 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::26) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 15:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 15:21:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 10:21:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 10:21:27 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 10:21:25 -0500
Message-ID: <d4839dda-75c3-4a82-bad0-8ae29e67c16c@amd.com>
Date: Wed, 22 Jul 2026 20:51:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power: amd_pstate_trace: fix help path dependencies
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Yousef Alhouseen
	<alhouseenyousef@gmail.com>, <mario.limonciello@amd.com>
CC: <ray.huang@amd.com>, <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260624123135.7193-1-alhouseenyousef@gmail.com>
 <CAJZ5v0hE8RyBwi6imwgzADMaRzL8FrD95KeH+Eo54rfXboyggg@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAJZ5v0hE8RyBwi6imwgzADMaRzL8FrD95KeH+Eo54rfXboyggg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: c18c4eea-0f6c-4f54-381e-08dee804e6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5FMU7rKjMWszMUPRxyOaQUQ4kO1UChmQ01HM8LVMIOCVmIRmp4umh2PaUbEjir8RxeDWxEA8HKgy/dE6hoKeqJf2riCAw0rN4QpDOLY/ctg+AimJHgoqJ9b3Hi1juKYx/Pp0FbMjEhZ+qk34TRFF0mhNM8Fwxv8OLxYd7NuADy5mWCVQV4CCY+8VL2nv27/0mK/2Ir3MQ7iiilmvjLOF9h39kCWbPkFprC3NkvrfVXaAIEq5c8uYeR/eTtq55J7dvbQTRGzH5ZzgDEQanQ+dfMI9/367fmQtPqo+TpbTABXyva5yylby7U5w9vv069F8lfHI506rwx9zhHCogctx5h86A7to+EQk3IzNZh4T0V/jR8gVVyrtw4qHuAORJUJWF9DwvYufxpoLrzz1/w8SESC9ogQuNjUQ62CXxbrwj+2nND5v1H+RWolZNFvb2ZSuKjvoQLoyrwBz1eSMSXCWDCJoz5uKMNgfcU8kca+dedr/sOe1yaXya2HZDrQiiSdc0+ohWaJZC1k0ZK2VaDJTG+z1DJb1WJ4hyLFvyQzTpMN+9AiZzdAsR/LQxLbnM01n4lP81P7EwULEW3D0/gKKFhRXyalOIHE/teNPjqb7ieyCLg+cS8iVkuCN/zEhFf+qtD+CYMJ//ePB9RNj15cYXMKptz/aBPXj2eSpxeiS9fAcLUV9mVYHzzt5l20RpC1eQW/oBqQ89vVXrOXBWfa0MQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YBnX9jU0rSX+Mv7RI6AxFgE7MPKdaYQ2XpSw4M2LYiPc+gYanu9xOkFCi9Mgf69N22gNyf11ep7w1o19mXaK9624DkBATnBs7c5rk5f2G0pB2wuMo14RBdqdCtnidKnPgrbb+KiM4jliyCLZMRVY3UYqZlitSGKSsPKXKiIyRDLApqVHWJzbd6jfYmHL+dw2AqfO4SVp2k58iZhAEH/sLQMhitac0zdscYrfIMXhl+L67cCqrE1uGWXKoQ3pzlrFzt0ynw/3DXhHNpPStpnBagN+iGm0+xYbBXhLI5qzQcszISQGg1EGnGkQ5XhIP8DmpX4Tb1FJUmn7elJ9UKQbs+18M+LcOJ6Teisoa5UmVsyumEwq6rApQRRKnJEmqyr7bFTUH69qlvu6Ajp1A2nY5ZTr/TFcAZ1LoJqVZfkrSqUXrnBmDGfV+OKgGKNTaWMA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:21:28.3277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c4eea-0f6c-4f54-381e-08dee804e6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

Hello Rafael,

On 7/22/2026 6:18 PM, Rafael J. Wysocki (Intel) wrote:
> On Wed, Jun 24, 2026 at 2:31 PM Yousef Alhouseen
> <alhouseenyousef@gmail.com> wrote:
>>
>> amd_pstate_trace imports Gnuplot and numpy before parsing command-line
>> options. As a result, even "-h" fails if those optional runtime modules are
>> not installed.
>>
>> It also handles "-h" by printing a blank line and exiting. Use the existing
>> help printer for "-h", and move the numpy import to the path that needs it.
>> The direct Gnuplot import is unused, so remove it.
>>
>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> 
> AMD folks, if this change is fine with you, I can take it into
> pm-tools, but an ACK (or equivalent) is needed.

Sorry for the delay in reviewing! I have some comments below for Yousef.

> 
> Thanks!
> 
>> ---
>>  tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> index 875b08655..b1b201b2e 100755
>> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> @@ -27,8 +27,6 @@ import re
>>  import signal
>>  import sys
>>  import getopt
>> -import Gnuplot

We don't use Gnuplot so removing that is fine ...

>> -from numpy import *

... but we want to keep all the imports together at top to easily audit
dependencies. Afacit, most python scripts in tools/power/x86/ follow
that convention.

There exists a big fat comment on top of the file reading:

  Prerequisites:
      Python version 2.7.x or higher
      gnuplot 5.0 or higher
      gnuplot-py 1.8 or higher

which is a good indication of whatis actually required to run the
script. If users prefer, we can add a requirements.txt that pip can
consume to install the necessary dependencies and make it clear.

>>  from decimal import *
>>  sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pstate_tracer"))
>>  import intel_pstate_tracer as ipt
>> @@ -260,9 +258,6 @@ graph_data_present = False;
>>  valid1 = False
>>  valid2 = False
>>
>> -cpu_mask = zeros((MAX_CPUS,), dtype=int)
>> -
>> -
>>  try:
>>      opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
>>  except getopt.GetoptError:
>> @@ -270,7 +265,7 @@ except getopt.GetoptError:
>>      sys.exit(2)
>>  for opt, arg in opts:
>>      if opt == '-h':
>> -        print()
>> +        ipt.print_help('amd_pstate')
>>          sys.exit()
>>      elif opt in ("-t", "--trace_file"):
>>          valid1 = True
>> @@ -291,6 +286,10 @@ if not (valid1 and valid2):
>>      ipt.print_help('amd_pstate')
>>      sys.exit()
>>
>> +from numpy import zeros

Having it here needs users to skim through the file to know what
external packages the script needs and we don't want that.

>> +
>> +cpu_mask = zeros((MAX_CPUS,), dtype=int)
>> +
>>  if cpu_list:
>>      for p in re.split("[,]", cpu_list):
>>          if int(p) < MAX_CPUS :
>> --
>> 2.54.0
>>
>>

-- 
Thanks and Regards,
Prateek

