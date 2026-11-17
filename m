Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794882353;
	b=UDXQ2AGFL2sfGz4EZpHgenEhjZn/tA+XKdBgSpAOH9oHpdaBF8NxuIuJ8H0xkJl9l6X/
	 sQQ9PX8XA+pUnd5WT+S38q/0o3rC0RSYOO21Acekb17KzAJQbBGrXDeHK3mpxOI75qgvz
	 knpGeV3+AXfHwtgJyC5rhakvyGnhMnVkSoRa8iljyb9HcZYe0ehIeWlbNAGwS+R/6uzcC
	 NNtCtGSma6QeGW4ZbnCZ1CiIXsTbTN95w60F8DahqoidAVW6FOrU+qPqfzv+xCzAnC+dJ
	 o1fZMvyNoMQjDCE2Vdh48HcUUuffvEb8W8MqEu8/cytgO6M/h4eHrjvgk9McNows5Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882353;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=39o3bbkboIKVaXBuxcCW0IFe3Iwp+EHRIIwZWhG3y4A=;
	b=zUYkIuVzS+nXVDDHj00XNlibOK6VpREjbhkIduyXdk9UmTlt1dFsx4e7zMIVoHPQAYtO
	 VnH2DpPZoGQtqC6qYvmD2FpL/ksJXoJeQNjPuCLCriqS0KxekM4d3gn85nMI/NEg8Lkag
	 h1KVXzsHa6LhUav6gZOkFPjTzVooLzRJQXtY6T5/KB1zxiZwSg6xCMpmWrLm6jq9kd2wt
	 a3sx1u6eVL2qlKOGBM/7XHm840dEzHlAmjLetyzQsITkFFHvP3ObalItrDHRCq1Z9GO8p
	 PPng1cIcdZcSYLrJ174GCVH4DT3YyUa9J1SHj4ubmLMXDY1RTlA5UEWY8xkOv9bgh3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fevw5Jaw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.21
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458D606A32F;
	Tue, 17 Nov 2026 02:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8458D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fevw5Jaw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUdCe9TtI8XI+weeBB0HU9CdIRBC+GLAyyb/4n+YnRE3Z1fNjce80ftEyyM3BnTna7EHFLTHO0mHSOShPA2a1SAysf/g5ablgFUvCVtBcdHf0YM9VekUHLosMcYzPfo9pad749EUBaTz8iEJSlQ8gBSWzXSZf6+pqdc9NpmFC7PD41VuZmPApEk8+adBfNz5lYiFAOq8NyKcUj91GAxNrnWlJRzkDpylXpYNNQP3Sy40eSTrNv7/bE41bOVWPSGL++PM53IxRtjlIIsXx+AFRw/sxGPm6Equ6PZSJyZuV3ErqJOTF6jnfgQ0KY5jg9ReF1hVjaA8CgQxHqDJiKOAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39o3bbkboIKVaXBuxcCW0IFe3Iwp+EHRIIwZWhG3y4A=;
 b=ynYbOJzpoyEMSftDOQblOCXjdrphP9WrXLBN0riGX8Ya5WnCNsFecSDuMRZVvN3QuyGCANEOaQL4HnbSTOg3KjJKKW6x/gqu8XY9cYO6z6C2GY9gUID/S94p2r922L4GUAAR3XcN+GHgC9SWfw4TF0Xlr3nHapL46dpX1LLOhdl3mp/3ejbyv+Fx+yrRS61d5724xihpyi27wofpon//wWOLVRnaq6wYUONhtQTU3/3gwgBjCONFtHcez4NA7rNpllf3x75MCnOiec1TUDKwkgd/xUsh2qzYB9676wTOxQraI2mKQWNWCrzamln9aRa6AGRn3SRqK37+vuR5mvdrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39o3bbkboIKVaXBuxcCW0IFe3Iwp+EHRIIwZWhG3y4A=;
 b=Fevw5Jawo55ADGSOPbV/16HhElOFnJK6TALBY39rcDM2aogiPBzlSECOUHYMz+TrVKln+SgxUtb8GkWqcqdQfTO5W30Q+4JpyVb0YMo28+wRWxeWPIsb7BsHkGoswmA4huhxMqPbljyC9BYS4BbZL6XRM+vyT+/t+4jJ/Y4id6BOM5vdzMhvT83yNYNeTHqOLvOqgBg7WkVnj+fZ916z2E9caoQD7EqR9XWeZlxaN3yZZAkT/9X6ZmEG/CrW9wAd6JFQSzaagm8lp7kANDDJ+1IiSLXfNuGFRSwBjIRzQLpKhGqEFJ5fZvo1DFiqQOacIBqO97ZeKiWbOWwJDA7XYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:25:47 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 02:25:46 +0000
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
Subject: [PATCH RFC 1/3] cpu: add sysfs control for preferred CPUS
Date: Mon, 16 Nov 2026 21:25:39 -0500
Message-ID: <20261117022542.863028-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117022542.863028-1-ynorov@nvidia.com>
References: <20261117022542.863028-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:408:e3::23) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 76bbdf10-4aa1-44a2-8ed9-08df4452166d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|18002099003|6133799003|261009223027099003|22082099003|3023799007|11063799006|56012099006|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	w8QMSwieJ/a5cBd0+3BxsTBylsUwMI4bpWiQ/cfCj5AoID1aV3DMsC2cZ9UtawZoCWHXGmjjo4bPc31pLFdwMiB1vBW72/BNPrxTVQOQHZNGlb0eQ6YRqHyvDkPj8fMU3b/1ky/1crb3AQglQmhJYAZkdj0tWMs0TIejGN/grnDpwri+wYYb3tg0U2XbXymDTxt7zgQPyq2K0JYvqcBcipY/mHjTUFXknoSoTT6MmsuAIuOEtJ9rd1PKXjBLFqFOGU1YsjwbamW7VOdqEy6g5onSFVIBczRoVcsTBDNlCGqBj45tsEhBTLi/VY6hy8g0swL/Q9cAn7FPTs0a6XjkrtBeLUSiSNp/02VAin05ZMkegHQNVAX4zL4r0PmFNMqK04wmAAiUSCqkVla5aPUxAjZNW4oCkVl8xM9tUlQMSmRcVL8CqPQZr6epkVafO3S9dYUaAevHbhu2CjAA8BLoyLAXktuXGreaYUDWiyiWMecB9GnQUychyfJ8I0/9GdJq+3GDIMyD8JE9n5pwb/lT8rwLdgSh3KutDccIkT74x5Py9PmZGd1Skebsy4Rq8KiYIYh4/E9U8criNY8O4QTfYATjzYqXQ4r9717i+0266RZaXIMy5o4o8AUtaNghIKPQW4dtezPR22TurexZ9moyfHVNrU2bqDODQyRby7WQyEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(18002099003)(6133799003)(261009223027099003)(22082099003)(3023799007)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXyjQ/ncHGqScDjHEjLVJ7eqzq7LA4GjcmIkz4aJZvHysdPMrvsLJSygwpFA?=
 =?us-ascii?Q?U6DjOUJj7LLIM3F24b3RuPRaKZpVZQ1Zj1xKojDeM0aeOL3GIKn0T8MjGvg3?=
 =?us-ascii?Q?hHfYyxfotKKhtISgK0LGH9u/e4amtOg6MfLAohaE4Dg9XsmmbEWygz5OCfM7?=
 =?us-ascii?Q?5HPeAzGmVc64zVZkzXc3Ib2iYHbH+OLMUhWL8enteYtV+R2w9lmOQGdxFlRc?=
 =?us-ascii?Q?AoBd/g/m9/lTG+4LsW6dlSDHAMswZLj1lyZcnjDqzDceSMu/n0V8MNnNjKey?=
 =?us-ascii?Q?InmYCABmiW0OYA5c4euIyJFDLQcUpv0LHGkCByrYcgTBb5C59BRDgiOvK1dx?=
 =?us-ascii?Q?XGHqDJr3yIEu/V+fDh4tWwhNy7qE7y+9EYqasFBook9sCyIajzE6R9eBBKyL?=
 =?us-ascii?Q?ONv/pWyA/q/rXCE78kJit3G6pPlvbBI+rRPLMjeCGZDZnfMUHmtKdNpfgarM?=
 =?us-ascii?Q?xvwHHrIpMyqNzuxsoJym6j9qdoJY5UleReVdxWWEdOh8VFMESIRqoeNMa182?=
 =?us-ascii?Q?lbL7FF/84O63dZvjyAcvjb2Ze9HWog1AnBsK9F5O41wPJ4cZeXwsRkiNm60P?=
 =?us-ascii?Q?o3uZ4g8WDdFYiyBwVqjp5nzcWQBfAReW/NGPgsmQ80Vrs0HjZuniOprauNm0?=
 =?us-ascii?Q?Pu+xS6QK5AysentyDUxWmDvGobES82Szd1ZU6DIgVtcpgJqLbnFd2VX2ikKC?=
 =?us-ascii?Q?HG/SOXdPzrsjHkzqSroYFerin4HDuR3EUo1rNADsU+7j2BEeX5tmXi7D1Frz?=
 =?us-ascii?Q?21nvoSwDWMmaYdDADUjljyM4gzexgm6BDi41lp11neS4Xj7AJxPYLV2Pky6t?=
 =?us-ascii?Q?ZGm/JRikqO2hHEmOBUZNR3jBwjS+teEMX9zpZbu3FiYJ1aCTDejWH2LuziUt?=
 =?us-ascii?Q?r5MwVwKCTTDZ0UzR0OZ+Xpu+cSmHdnSc2c8yZ+e94pLODiqjKmlhgbm1SfbD?=
 =?us-ascii?Q?Wf2HA20sw4xXRCNYgDY5MK0RvjoNu0dwLsuUd7ME7kFJ+BEwemLpAQc2/172?=
 =?us-ascii?Q?B+vE4EbtAfGmKCL34R62txg11Nw3Zm3jottIEUYCaOGjDfWEzd8Ct7o1jliI?=
 =?us-ascii?Q?WWmYUISr7Cmyp2rt4GigV0lBarMvs69Og6XDrX//IEg/R6LQv2nx8smisoCL?=
 =?us-ascii?Q?B3WuzCfZcymchPeOIYBpidYtt6bV62fe+5eLJTpbttSQa2cSJ8dsEzJ+ASt9?=
 =?us-ascii?Q?dW0K83oibTqRE1Qlbp1j3fXwX4uFzT/sLnnB8+drIEwMAIJgV7Ya/sNubIj4?=
 =?us-ascii?Q?MQUdy8aV6fgW7u4wUmlEDhqMX9GI6il+hb6V4ybRCLO1ICoglYh5gJt/Ge6g?=
 =?us-ascii?Q?sHPvoS3DiVryR2tgpn25ygv8HFc7CGQrApxCDoUdzMJE5YYk26EeIFwWBm9w?=
 =?us-ascii?Q?YytYVe9FA64OIwwSPF09T384MutWK/J8Ty6VQxw6Ot+oYtayxC4pVe+HWeRg?=
 =?us-ascii?Q?hBNCTzgo0LN0pmayagVZv8Ic6byZ123pcPJkpU9ayRTj6THR9G33MojGR2f8?=
 =?us-ascii?Q?QawjiqUt7TwtPKhHXTRJC217nEWjZI5+JDNgRuVpM8AQI/AcgdOBABvh5sDj?=
 =?us-ascii?Q?wnvEB7/Lx7Lep2ipmZUAWoHO4FAwgD0tTldjXffZ9u/6CihjOVx/fy2tAwV0?=
 =?us-ascii?Q?MkOlCFX3HNs9eUq01lb1jrU5qvNNcA/V0NBp75G/lt82M1kVQdHo77eR+Cpb?=
 =?us-ascii?Q?vQDfPelLK0dJgR336WMFw6iQdF/qKTnDQaYoZaNweBFMI2PjqYReL0vqFikJ?=
 =?us-ascii?Q?hFyPsdAkrZDMa3dsfz8aY+/J6R/ag5sOkPoSykESvWpjsdMhsb2J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bbdf10-4aa1-44a2-8ed9-08df4452166d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 02:25:46.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q93YKn6TpYUF6KIgYrXP8VO+f/CilLc0bBXHgzKYxE6k2RlZTSH/QdmwgBlAbSeWLw9slpkVVhRH/xKmf3v6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

Preferred cpumask is a powerful instrument to hint the fair scheduler
on tasks placement under certain conditions like vCPU overcommitment.
It may be even more powerful if the final decision on which vCPUs are
preferred is delegated to userspace.

Considering two VMs running training and inference AI workloads, the
inference is more latency critical. In case of contention, the
inference VM should keep more preferred vCPUs for better UX.

The in-kernel steal governor is the reasonable default approach that
works good for cooperative VMs running similar workloads. In case of
non-symmetrical VMs, optimal vCPUs throttling may require sharing more
information between VMs, or at least knowing their role. This may be
naturally addressed on userspace level.

Preferred cpumask has no write interface other than via a loadable
module. Modules are disabled under certain configurations or can't be
loaded due to system policies; or impractical if the preferred CPU
state is supposed to be controlled by an existing user level software.

Add the write access via sysfs interface, similar to CPU hotplug. The
write is not available if the preferred cpumask is claimed by a kernel
module. Kernel ownership does not prevent reads.

Sysfs interface shares the kernel modules limitations: making non-active
CPUs preferred and making all active CPUs non-preferred is not allowed.

Write access to the preferred cpumask may also be useful for the system
debugging, benchmarking or CPU isolation without changing tasks affinity.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  3 +-
 .../sysfs-devices-system-cpu-preferred        | 42 ++++++++++
 Documentation/scheduler/sched-paravirt.rst    | 20 ++++-
 drivers/base/cpu.c                            | 76 +++++++++++++++++++
 kernel/Kconfig.preempt                        | 16 +++-
 5 files changed, 151 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-system-cpu-preferred

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 545687ebadcc..3bf89c7c4b91 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -829,4 +829,5 @@ Description:
 		CPUs outside of this list may lead to performance
 		degradations due to underlying physical CPU contention.
 
-		See Documentation/scheduler/sched-paravirt.rst for more details.
+		See Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
+		and  Documentation/scheduler/sched-paravirt.rst for more details.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu-preferred b/Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
new file mode 100644
index 000000000000..a0e9680e1c34
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
@@ -0,0 +1,42 @@
+What:		/sys/devices/system/cpu/cpu[0-9]*/preferred
+Date:		October 2026
+Contact:	Yury Norov <yury.norov@gmail.com>
+Description:
+		Control whether a CPU is preferred for fair tasks placement.
+		Reads 1 if this CPU is preferred, 0 otherwise. Fair tasks
+		whose allowed CPUs contain no preferred CPU can still run on
+		active non-preferred CPUs. Other scheduling classes are
+		unaffected.
+
+		As for the online attribute, boolean spellings such as 1/0, y/n
+		or on/off are accepted to set the preferred status of the CPU.
+
+		Writes change a system-wide fair tasks placement preference
+		without changing task affinities, cpuset settings or CPU
+		online state. Cpuset constraints continue to bound task
+		placement. Use cpusets to constrain a workload's eligible CPUs
+		or create exclusive CPU partitions.
+
+		This attribute does not reserve CPUs or configure tick
+		suppression, RCU offloading or interrupt affinity.
+
+		Selecting an inactive CPU, deselecting the last preferred CPU,
+		or writing an invalid boolean fails with EINVAL without changing
+		the mask. Writing the current value is a no-op. Writes across
+		all CPUs are serialized. To replace a selection, select new CPUs
+		before deselecting the old ones.
+
+		Reads and writes may fail with EAGAIN if CPU hotplug is in
+		progress. Retry the operation in that case.
+
+		The list of preferred CPUs can be found in:
+
+			/sys/devices/system/cpu/preferred.
+
+		CPU hotplug sets the status of new active CPU as preferred, and
+		deactivated CPUs become non-preferred. Offlining the last
+		preferred CPU resets the status such that all remaining active
+		CPUs become preferred; and emits a notice in the kernel log.
+
+		Writes fail with EBUSY if the preferred cpumask is claimed by a
+		kernel module. Reads remain available while the mask is claimed.
diff --git a/Documentation/scheduler/sched-paravirt.rst b/Documentation/scheduler/sched-paravirt.rst
index d8f446c3ab6e..4cea2bf7c4f4 100644
--- a/Documentation/scheduler/sched-paravirt.rst
+++ b/Documentation/scheduler/sched-paravirt.rst
@@ -42,13 +42,25 @@ This is achieved by:
 ``/sys/devices/system/cpu/preferred`` prints the current ``cpu_preferred_mask``
 in cpulist format.
 
+Userspace governors may control preferred cpumask through the sysfs
+interface similar to CPU hotplug::
+
+    echo 0 > /sys/devices/system/cpu/cpu1/preferred
+    echo 1 > /sys/devices/system/cpu/cpu1/preferred
+
+If ``cpu_preferred_mask`` is claimed by a kernel module, an attempt to
+write would return EBUSY. Disabling the last preferred CPU or enabling
+non-active CPU in the preferred mask is not allowed, and EINVAL would
+be returned.
+
 Notes:
 
 1. This feature is available under ``CONFIG_PREFERRED_CPU``. Driver which
    makes decisions should enable it. For example, steal_governor driver
    (``CONFIG_STEAL_GOVERNOR``). On enabling the driver, CPU preferred state
-   can change based on steal time. Without the driver, preferred CPUs is
-   same as active CPUs. Only one governor may be enabled at a time.
+   can change based on steal time. Preferred CPUs mirror active cpumask unless
+   modified by governor or via sysfs. Only one governor may be enabled at a
+   time.
 
 2. This feature works for the FAIR class only.
 
@@ -56,8 +68,8 @@ Notes:
    to run based on its affinity. But no load balancing happens if it is affined
    only on non-preferred CPUs.
 
-4. Decision to change the preferred CPU state is driven by the kernel.
-   Hence it shouldn't break user affinities. One of the main reasons why
+4. Decision to change the preferred CPU state is driven by the governor
+   and does not break user affinities. One of the main reasons why
    CPU hotplug or Isolated cpuset partitions was not a solution.
 
 5. This feature works best only when all the Guest VMs enable the feature as
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 747915ff974f..88e803cdcc36 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/cpu.h>
@@ -145,6 +146,75 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_PREFERRED_CPU
+static ssize_t preferred_cpu_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	/* CPU removal drains active sysfs callbacks with cpus_write_lock held. */
+	if (!cpus_read_trylock())
+		return -EAGAIN;
+
+	mutex_lock(&cpu_preferred_mutex);
+	ret = sysfs_emit(buf, "%u\n", cpu_preferred(dev->id));
+	mutex_unlock(&cpu_preferred_mutex);
+
+	cpus_read_unlock();
+	return ret;
+}
+
+static ssize_t preferred_cpu_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned int cpu = dev->id;
+	bool preferred;
+	int ret;
+
+	ret = kstrtobool(buf, &preferred);
+	if (ret)
+		return ret;
+
+	/* CPU removal drains active sysfs callbacks with cpus_write_lock held. */
+	if (!cpus_read_trylock())
+		return -EAGAIN;
+
+	mutex_lock(&cpu_preferred_mutex);
+
+	ret = -EBUSY;
+	if (!preferred_cpumask_owned_by(NULL))
+		goto out;
+
+	ret = -EINVAL;
+	if (preferred && !cpu_active(cpu))
+		goto out;
+
+	if (!preferred && cpu_preferred(cpu) &&
+	    cpumask_weight(cpu_preferred_mask) == 1)
+		goto out;
+
+	set_cpu_preferred(cpu, preferred);
+	ret = count;
+out:
+	mutex_unlock(&cpu_preferred_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+static struct device_attribute dev_attr_cpu_preferred =
+	__DEVICE_ATTR(preferred, 0644, preferred_cpu_show, preferred_cpu_store);
+
+static struct attribute *preferred_cpu_attrs[] = {
+	&dev_attr_cpu_preferred.attr,
+	NULL
+};
+
+static const struct attribute_group preferred_cpu_attr_group = {
+	.attrs = preferred_cpu_attrs,
+};
+#endif /* CONFIG_PREFERRED_CPU */
+
 #ifdef CONFIG_CRASH_DUMP
 #include <linux/kexec.h>
 
@@ -190,6 +260,9 @@ static const struct attribute_group crash_note_cpu_attr_group = {
 #endif
 
 static const struct attribute_group *common_cpu_attr_groups[] = {
+#ifdef CONFIG_PREFERRED_CPU
+	&preferred_cpu_attr_group,
+#endif
 #ifdef CONFIG_CRASH_DUMP
 	&crash_note_cpu_attr_group,
 #endif
@@ -197,6 +270,9 @@ static const struct attribute_group *common_cpu_attr_groups[] = {
 };
 
 static const struct attribute_group *hotplugable_cpu_attr_groups[] = {
+#ifdef CONFIG_PREFERRED_CPU
+	&preferred_cpu_attr_group,
+#endif
 #ifdef CONFIG_CRASH_DUMP
 	&crash_note_cpu_attr_group,
 #endif
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ffd2cb2a4d69..0cbc697202dd 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -196,5 +196,19 @@ config SCHED_CLASS_EXT
 	    https://github.com/sched-ext/scx
 
 config PREFERRED_CPU
-	bool
+	bool "Preferred CPU scheduling"
 	depends on SMP && HAVE_CPUTIME_STEAL
+	help
+	  Hint the fair scheduler to favor a subset of active CPUs.
+	  Non-preferred CPUs remain online and can still run tasks
+	  if their affinity requires it.
+
+	  Preferred CPUs can be selected through the per-CPU preferred
+	  sysfs attribute or managed by a kernel module, like steal
+	  governor, to reduce CPU contention in virtual machines.
+
+	  See Documentation/scheduler/sched-paravirt.rst and
+	  Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
+	  for details.
+
+	  If unsure, say N.
-- 
2.53.0

