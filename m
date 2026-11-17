Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794882352;
	b=CuQSlyLD3U6bUEM5B6JLxnmFpWbOkTWU5L9zPHTJazfT+C41cWJvg2Uoxg4MhzUGWzmn
	 DJDCwnObUn8NGEZwkJiO41Dm3P4SpNdLDatOKAb4vCGxCS4xZsitAqSKxS1+70hbEreyy
	 6942Nj3iz75+5jkpiB9dS1Qv7N7uO9aCGDoCh31bLeTVtMu9oDY8y50zU8kytKIr48leg
	 ZR3dMGmy2pM6FjEKShCzo6I0kOHnp0POBIMaYY7jJHLML1DdHXJWGOnz4EOSrdyKw/2/Z
	 OJL30irnyl5QS0kfH8naRWHZpK0H8Wxgy6i85sJFdR2j5ts3s73L8BFYO0MjKRfw9hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882352;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XfPjiw63RCTj9FUHKElLMXMYXMA0NOh9SBhBRchXFD8=;
	b=4wUS0o38CocHohXvug90u6boFVNLBnB7OnTCNBUQLMqHNIOSy3PhnVY59Loj2kExSMVb
	 WSs8AbGjNzLkzsCYQLM4DGuSlPAlhcXny2EHF/fJ4o/TQxet8xUasnbIXTiEqdicWtJ7p
	 bkBMbUSUPLi8icL4nOvntBuLVQ5BE78Q1OktO5QXNve7fSqM5jVqLeTNlwtU71fXj5kHd
	 G6Xmy16qNf//ROiaOKRW4Yqkbwq3F3VMEap58s20HUCbs1hZHpFlY/cLILj+dWWkKA5MJ
	 bsQ76O5o/XKkNEnm41bB/0Wj7mKguovpvvjKSl0xbgEImFBoIM6aRjAOr5lcJnKEaow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jpyGj60q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.21
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC1606A31C;
	Tue, 17 Nov 2026 02:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jpyGj60q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAEpJl12WWCrE81IT+fAkpqDgJ6jIyz3dXBvywyvYeRV9USXnJErQm/wdi1uQOxQfYWvUS8YFqoUGOZfLMuP5jQHetPef+kkK1Su3iHf7i1DlmMe6arzzRMBcnjoEczAbuVAfQuYaGQGPWlvy4JA08NpQEptE/t2FARvD/gPUA1mnxRYmh0Y2jRXPVkQzp35WJMdKGKipl3LxrSjtyYoJP6lFhVdcmIgT0Ybgz7YRSHmm/Ro93JKXzWMvh3++bkOI8nRgOAO9kAthGl4g2siSAmLqWahxSfhn2LpO0KZun65Js5o5ocqG/rielGrzFRTZDe2BCQU6XhsA5E2Gs1g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfPjiw63RCTj9FUHKElLMXMYXMA0NOh9SBhBRchXFD8=;
 b=iUQWWRV/pFaR+tNrOHtlRGwFJeyEvERABEAdS63zQXrWdd4povormpcVArxUco/Zf0Kkd1JsnnzDnU8DuN4aBJE+eSYf3wYpDW6pn09zFx+xO/WK56QEBG45XFYIPSiXstPg8SL6+R+ON2xOLwwAoUJkd37XYB0qFbca26FktO9CvDztFKRbQl/uASPKUGBwwTnjRGdgCbceupGwSg6kdiztUDQRdJ/nd3vfwkTU9i+o01CSlvSbnKcTg+jgb4OF8ZFJISdIUq2UYmo9nDueb19YfLqedfBhKrx2digZDw6Ps6prmstLsIKF3EdcYKDfchMuhAZtZ/vb3RjKRki0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfPjiw63RCTj9FUHKElLMXMYXMA0NOh9SBhBRchXFD8=;
 b=jpyGj60qn48foErkrVvEO40B0scSFDBINuf62BD8HKprtksVzEVarZuCY92QqtsJnwQX17J31z141ca7ESiJgIhy55jujdPpsU3b3F+evLsDVxrZQBxsPebmlmPSrzs7fmWvKNBXnpf6vIgPM6975fEEsJgmwWrfXqS4hhoViQAxF11AxGW/TQSVSk3yUcbVVMcQ8TnCDenx9p7pH3rBocy0qxoDx8cw+qVqzCXxLoThfOqEJWIhWVd10mIAzn1G1x2P3i8wrBi5RnteX497AdW7Ilw7Mz6RWnUrJQfTCZTtw7c8q1blyVM68Pe/4vWPY0ga3rrAnldRcLgYjjLgaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:25:45 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 02:25:45 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Wei Wang <wvw@google.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>,
	Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Fushuai Wang <fushuai.wang@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Mel Gorman <mgorman@suse.de>,
	Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC 0/3] Expose writable interface for preferred CPUs
Date: Mon, 16 Nov 2026 21:25:38 -0500
Message-ID: <20261117022542.863028-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:408:f5::13) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a42cde-d2fc-4b5d-29be-08df4452153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|18002099003|261009223027099003|5023799004|11063799006|56012099006|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	x9hzp6NLphJnDClonUc1VQGG+AXNrbK3wkj9NwpuWxuMb1v4ZELcJmg8CBis52cpUmD429MF2zvlT0RVmNBNe7Tp/3IDE748fxSvPBliQo9UCNWHEWMg3cX21ERWntA9bGVfjQR4ox2uvd+/i1Vy7Jr1FwdiL221IPbPiQXQl0VqIncUQyq/aPQQYAL538D3jzO4knSKXfI4a7boa/Xim/zgRN0lIlj3wcYxwE/CAgV5/ECQja/e6ugpaw1rOXRmp0f1HF7Fhptv9Q8sY/zGiSZ/CVmLP10awMewVu2oiidaq274VIinzzovsXAKLsgjYHP3DAmmlIoKGuzNVBtx2uH/9piUJM9pfZEXrgDMpWkwVVhhJtZoARB3m+hNKkBu/69x/WfucasiksjNM6QQmTMQZwWJXhbaUC8E0chTN7JiyyjWDBc+rpHZtWQRFuAWqT3MorjCQI4aMULOfpKeD9wuykL/hZfR/SZJ3TB0e8Zo6LO0GZgFTKwhoeToPlAxIunyH9nhPsOSNh3YOpahrcGNT415XkDMLng/ExioTTDM51GK2wh4o4dIEKcqad5dcPUR3ZrYyz2MVQTsLqcpB/Tac/fvAdeO8+EACDArsnzx5a/Y6akHaoaP9nnbrgl+7fg/JOuPeB8HKdOpcodspCZTGqdCjcTmdYK+W92qqVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(18002099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JweG0YaZV7H7bCNMhG0ilW9ZvPrg1zjpYv9QD7QaEGPgviNaAleQ3rZ1ToHA?=
 =?us-ascii?Q?cYuRY6Yfi243cYG/ChU0SD7cas8GG4mM6zaapXwnlsIQdGepqpNmNfpUoUKw?=
 =?us-ascii?Q?izk63m8SqEbJ6GhdmuS3bbhi52iogsCkyBsPAWK+Se3j2QRI6BOwnnB+24eY?=
 =?us-ascii?Q?2PbXwtMG0Xxsf9ExVG0PoQ2J2zuD/ub4irbBoLxEer3j04h5w/KYOqvMGw+G?=
 =?us-ascii?Q?T+r49h1Gl+671EA/oJoZoqgaLeI6+LQeBAZNWpAAdwD0RzqCAXcnSbnf80GW?=
 =?us-ascii?Q?Ld4vLOsLpGsvbUi6+Z13q4Ez9PI0Gs+k3noU/zatsFeMSGMoICA0DnXjYKJ4?=
 =?us-ascii?Q?B8oZB1UgwQQVVWr+XuhUf6WMtV6qCkvCGPWHzrBGQVuFSWO0tBhv89Q5gK7Q?=
 =?us-ascii?Q?Mzgldlj4p7mY6kkbwItRsFF9hk6qHy4qatjwAFD3tCmV51NR0TBjNB4FZY47?=
 =?us-ascii?Q?+EIupDMByFcymQJRvS6LZdSXdPWEQcWgl7kJhB8CNem1QHWka6zMtILex9XN?=
 =?us-ascii?Q?mCFLQz7te93r3R4p6wKVGR3sgtyizA9ueasZ3K/xJmXzVtWgPqe0zIuKOdGJ?=
 =?us-ascii?Q?pZ4jIL6RK58wbETPy/+BUpperc/Zlq8FZlBYmjIXOIRfbbzg/ceocBYudAID?=
 =?us-ascii?Q?GEhNUvMGKGMnqwDEw40oifHDwf2dc63Iyxx4FY+hP60doTTe+TbBvKCW7suL?=
 =?us-ascii?Q?dQKM/+qfbW91jh714tYtrxiVPul8s6aq3YVqnBE9Uy/6kywrMhy5RhKsbmu4?=
 =?us-ascii?Q?me8OL+cqf2fLYtwRZDJSFFEQQjlyOrOiH1ZuFmc8biwxS9nBizPScOeGQGT7?=
 =?us-ascii?Q?5/PrETJX71B63D4f+h15ReVusO3vFdXXtEqj2nA9+l4wTcieT5hSCxdCVckT?=
 =?us-ascii?Q?o5qYmroI/p/JGS5u/tz4ePPJmCPPG7M/aqdJ8FC7sYi1rRRFcUx4GooTTmzx?=
 =?us-ascii?Q?+t+/9shHeHqiSkzQhnjN4gC5kr4ZYz5q/HG9GSYFaTUR7oCYaG7WAVUhnIra?=
 =?us-ascii?Q?+PXe0sSxmP/qYEHQk3z+nRNu+P2yJDjnPIVuxFjxWJggYMw6ha4BZmbqEBlK?=
 =?us-ascii?Q?c5VV7eHZrYKl21xr0RTR5KUuYP8eSDBVKMnEQ/JMvuyg/i/tXuJhk5yHp6CZ?=
 =?us-ascii?Q?AWUw0B7baf1yuHTTw5k2cqG1o60Si6rleZa5EnDtrHJuLQfKPI9RS1KYgCT3?=
 =?us-ascii?Q?9HJwzaB4BM9FKY5XCjNq7SAuWHwal2MUcQ/fV9D0bPpiZ82hJgDlI9RmSskb?=
 =?us-ascii?Q?rPUakT/xhu60E3mzq16pCpyP99e/VqniK9TER9fNEkwNFvLXtwLdptkq5nWT?=
 =?us-ascii?Q?p+EEUwDxqfHn/+fcY0IhYiChlcIkg2i6C2zK+HFI3BV3luZVSlv59tZmZzQ+?=
 =?us-ascii?Q?SeG7uYmemy3D0UHUHTbhCFbhpldXIqN9Uln8lEdXEUNbJz+1vl8jw+KClqSn?=
 =?us-ascii?Q?utaBPYssdI1rFo5hy6bk/r5fvZ/A8C6qid7v72/ENsuB8Ka59AgoQHCus3wL?=
 =?us-ascii?Q?UffrtXe3MYTQixbQCFf9gnMsIAjCw0RebE9W3aB+5MCbm4gECEc0i49vlZ7i?=
 =?us-ascii?Q?TcFOEEEUtfcfWLaDjxpErSkWxcKTkgg/WrFPBxMLAO7j/h2ExmDfyJFUwfOH?=
 =?us-ascii?Q?69SLcz9diHC/RjIFU8OLlIPS2tdqNMLIyO3KKbKkSyUrceDilaTO5dkT9wQ2?=
 =?us-ascii?Q?6sWmgYuBrB2Y0F+KBpyMMBig+yzTpQ7h3oKPATOA9OYPdlzL3wohjbJUnPaA?=
 =?us-ascii?Q?bpEsjGElCdqTj43R7xNs2/Hi7iUUKoRv/UhkEUmzJGPwf4ZVDq/A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a42cde-d2fc-4b5d-29be-08df4452153c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 02:25:44.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk86kUGHrF46EKsy8RXmloz+8X+9LvewJgePtwnPXzBuGsOjhSZcBPO4m/fsAB19891m/74E4MF3FfcXX2/+mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

On top of tip sched/core + [1].

The preferred CPU mask currently lets the steal governor reduce vCPU
demand when physical CPUs are contended.

This series adds a writable sysfs interface, allowing userspace governors
such as thermald to encourage CPU idling in response to external pressure.

Patches #1 and #2 are partial resends of [2]. Patch #3 adds a thermald
example.

The complete series is available at [3].

[1] https://lore.kernel.org/all/20261113184257.621707-1-ynorov@nvidia.com/
[2] https://lore.kernel.org/all/20261101192203.6979-1-ynorov@nvidia.com/
[3] https://github.com/norov/linux/tree/sysfs-preferred-cpumask

Request feedback on preferred CPUs as a thermal-control mechanism and its
relationship to existing cooling methods.

Yury Norov (3):
  cpu: add sysfs control for preferred CPUS
  sched: decouple preferred CPU policies from steal-time accounting
  docs: sched: describe thermal control with preferred CPUs

 .../ABI/testing/sysfs-devices-system-cpu      | 14 ++-
 .../sysfs-devices-system-cpu-preferred        | 42 +++++++++
 Documentation/scheduler/index.rst             |  1 +
 .../scheduler/preferred-cpu-thermal.rst       | 94 +++++++++++++++++++
 Documentation/scheduler/sched-paravirt.rst    | 20 +++-
 drivers/base/cpu.c                            | 76 +++++++++++++++
 kernel/Kconfig.preempt                        | 18 +++-
 7 files changed, 251 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
 create mode 100644 Documentation/scheduler/preferred-cpu-thermal.rst

-- 
2.53.0

