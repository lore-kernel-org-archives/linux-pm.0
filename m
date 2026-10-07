Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBF35F162;
	Wed,  7 Oct 2026 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791341956; cv=fail; b=fppTicRJPigSBm30VVjOY0vCoGlifd4iyNQzA7SGwq4aUw3bEpGojTGKIkY6jZxqU0Ia3Pedo7Vl2lQOjk0LFK6lZaMUYkZiBE2kz1k5BAmcXjdwQT0DDxkodWFfu2UPMZYCsscKIadKMJyTMILR+v18smqkaR7CMYJghT5jmsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791341956; c=relaxed/simple;
	bh=L20SLHp2yQkPQS4TNcC7fCYaHob8+Rkt0B1Eyj51nhE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dna32fVxVAHOEKL2LdbJ2eXl2bUL7XCblAhJC8Q0ZyqGftFBLhyBlK6m/eS/qRStBGkZnEJSI8WUAXzOfnMG2F9A9f3J9W/9ZKY14QRVboV+uvjMfValvkGgkCcwUhM6DL8w1YWJhorgFvKmPiIEY8duLkKbgcrZK5/cWo5NMng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAZ6jBO6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAZ6jBO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791341954; x=1822877954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L20SLHp2yQkPQS4TNcC7fCYaHob8+Rkt0B1Eyj51nhE=;
  b=bAZ6jBO62Uz+Rd64RuGtFq5vxJgp1AT6sLJTpuNI3CZLhzsFQ6R+gS0W
   jTf047NiNhqVj46R3SLVkOCpyHWSeCllLefkwHCLfypnZmVkI5D1dmZXv
   itOP9OccHPV/kH3pbb4JF45+S9pzzSxdJLs0uPwZqBM2JESQSXARJ+vbQ
   gjuJHRTiG7SPy2Auz0FAa+prTuAnEOVVl6XZwTAx0jfaKJtuIbM0ZZs5Y
   ie4jymERwtwkkPRBph8ErqRW9GbjHVp39t77meDRCGmt7mPW0voSJwX0e
   CpWPZOYNPzYgApzZgUVxy0fCkB/cBnKvCJkDfts+kEfixEK94qWEpG3l6
   A==;
X-CSE-ConnectionGUID: xIuM1+jSSianHzFGdgBzuQ==
X-CSE-MsgGUID: gumtCTjZSlWr2wTKHa8ymA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="102622874"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="102622874"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 19:59:13 -0700
X-CSE-ConnectionGUID: Zx00Ky/1RAmN8EsLF4WB7w==
X-CSE-MsgGUID: N/QWtTUcQh+1mD8SwSvO7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="276856450"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 19:59:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 19:59:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 19:59:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 19:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbWiam8ye5NIroXq7bczEwEgWLhLYmUU4SXk2Gk6oHJ0JXGxXF7yAgO7xwodyuXjByo0xG8N8MK7MK3l7dE1KTHmK3RBIADhH7FEgcssRKpHgpvDROxyv3EA9A6XXZSv9tNgYoVfcLwCRcGhiZ/Ary+RIB103pn1DqwyxA+9/t70xJ/9eyhJ4Exg2Aets3wAWlOaIDF7yjbNCNur0QtAMi1+EsKNkgOHVBhSy/U7dBZCcluzelIip5xpFjV9q4lb8cJyKDu5QHlsI0BEFHVs6bh/osJ1NMXiYv0oI2AnCIxO1BYBnQN5uyB3VZWQjqevkxEdlkUB4Kj9TKWrhgK9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPOZdRU0Y5QLUjyRJVBUiPVcVNLPi8cKMXp531QH9T4=;
 b=FUqxpYPxffIyd9sidAjiw/zvtntMPoQcVh662kF7GFn8GeN8Kg+f3gS7mIhVdzUaWO0vG6gYPBF/8MJ+dy5lB93FukbUcoJ64tmVNMrt++vPdTFvEM6skgGPoq8IeG1cgihZqvBUT2FsafA8GhCw/kLaGXp3tTVL3Bj8bmLxlbq7CyWQhGCbE0DpdY3TZlCVhGPTSQD0oSKasNjLtXsiA1unZ0g87Mti/zpggPXU9YQR8WfTLXZ+lYd/hBqZcH9jdzGZHk0zJXoHBfqPlAp21Ga7ue9rvySKliA8TcM964Y20PQhPxFJco4cSR6ipohvCyV3mthWvYF96+vmuwZ9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DSSPR11MB9641.namprd11.prod.outlook.com (2603:10b6:8:377::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Wed, 7 Oct 2026 02:59:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 02:59:07 +0000
Date: Wed, 7 Oct 2026 10:45:58 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <lukasz.luba@arm.com>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
	<qyousef@layalina.io>, <christian.loehle@arm.com>, <pierre.gondois@arm.com>,
	<sshegde@linux.ibm.com>, <chen.yu@linux.dev>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
Message-ID: <asWyZtW7zPVo3k-A@chenyu-dev>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261002154415.2270586-8-vincent.guittot@linaro.org>
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DSSPR11MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: df55b3b7-bfbc-4d23-18bb-08df241ef3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3GnxXPqatgN/nX66FAv/5CQJX+wnarcYyi5HprUnkcNGUbOzV7gE8NJT1fOjai9lGGkPUpzNim4WWgCVp9Py/NwHzpFh5fGAhgcI46NUU587PLWBvdOyv1y/x6+AQiDf6V1jn/T858jCuRP9koVBJvprMahMn7ySDSrqGCRMQoRTucZhr2XXSw+9HyifQ1K1RuY4kIQb9crXVab6BEYpfIf9OqNdBYAfz0S6sKJGBJExE6FQjr+73ENQVwJvbMhrE9zD/sYqWJaJz/rI4ru5gRT9gb+TnzlfF6CgMehjYsgdpVINvxNFwBzMrQOpMQe81TP2mJG3PGLCMFANX7Ez7HPS51cVvVnAuwjj00+11Os0rZZngbBu/pIxQ+F6Gg9i7vIyewEKvS/ri2Fgorj4GYNk5kDWf6QaeasrhG3GJwM3bvUkmsKE5dTEo8U/R9ezPB0rEq4PIRHCb6VvL5BpMIjdW0yoijexofeSSr1TO8u8647k4O9XWKVL98o1n4h6CvSzJORLbj5TVgSEo9ph9WwzmxUpW0weJxJ/TdCEKsCyrvfMJUzTo0QhjYZpS4xCBx93qjUJ6e8dvK+X+/gHCVFzfw8eQFBEy/DYiPaoOHSCOjqCn8SqYXhdYQ4RV1Cb5koafNBgrKnVl3QuA6LxAcsUE9c+8+h0GeKypxkSgUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hhDbdPrk8Ets/qbPXgvaNCbvHZ5OnK5qNhq8SGbjEXHVSALrDT4jWz0NSY2z?=
 =?us-ascii?Q?cZxXajqY66xyT55GybmDWGc0T6yGsc8LDiO2Aoc1EvOLGcBejzeqtfLbE7zI?=
 =?us-ascii?Q?grw4Wm4QNom5Zjy8D4ZbDlGT1/p9WGiIlFdGmlOuBixOhSWfW/rT7O41RTHU?=
 =?us-ascii?Q?LT6LdKajtXjZUKYa1SxxWnFHWIW+wuUQe/UjAuT6g/duQ5ki/iPZlKcs4Jiz?=
 =?us-ascii?Q?ZpOqtgKX0NdD7qyKepeyszI7Do6WwvqwAWeagg9tdqq6EKAuh0gNjkOdy3+9?=
 =?us-ascii?Q?+0DD0P3GwzW48QkqVUC8lsxNziNO1OOF2uj0ZL+epeGhSz8btI98eom2g8GR?=
 =?us-ascii?Q?r7LawdokpQOWf+0CFQZIvZYwZ8IhIMNRsPeceuswx2o85JxM+GnuyIUPm11t?=
 =?us-ascii?Q?tFY8oaLaB2svrnNY4yqMUf3VhhGRiHnKH8q3YoSlYNUpSLId+t6nMDxbxZok?=
 =?us-ascii?Q?p7yKNqIsse0jf3illt5SI5EG3USOmp4VEgnqtg0ChVmzWxNi3btfSlCl1mGm?=
 =?us-ascii?Q?fMyCYUTFKyptuq1TapJ8aiEpWNi1DurKsPeZ099GDH965EqieEljxtMOpj/M?=
 =?us-ascii?Q?sF9jqXV/Eru7pwfaSxx61kRGy5BuCTfHiO4jcB6jLCxR+yXgmZbk+tAQu/bE?=
 =?us-ascii?Q?DcfwoEwEZuvfkk4fWM+7L+7x/RSF/Mvo80VyXB1sFoKXB71YNdlvJe3aVvTx?=
 =?us-ascii?Q?9Prym/cJ5xtnE+4so8vGgS9v3klu51jWgmiek6pCe4908VpCAbMo5JuvRbQf?=
 =?us-ascii?Q?NpmSMbNRdm2JSng/+U61lm545pTapdWCtchjrhVGnQTBHh8jK/DMS5FrbfUx?=
 =?us-ascii?Q?EcgYObHLQe5petBMKXVijpRZwsZt3bcpZPV2BHus7O+vgXGQ6lIcJQLvLc0o?=
 =?us-ascii?Q?3CTKacgdB0iOKWRz1/lDts0YrFenjbBvHOpiAGijYJYDW3WVaxHKni9XSdQh?=
 =?us-ascii?Q?p+U1RmzpHb1eVynUlFzCjGavZrg7sWhvi3A7dpxeWWLH38HMHaqGi831wXPb?=
 =?us-ascii?Q?lQ2HgO3uJDEHBd7WXYpxUoky5pogr7u3OcJG5UThMHilGK+31KhFgLZi7LcH?=
 =?us-ascii?Q?lPZi5JEuru4YPYFqem4tJojBsJDqaQxv1r1Tvx1euopxQ6NEGE9eSqIr18NJ?=
 =?us-ascii?Q?1RwVCKRpT3+yK6FuMAGCLgSVkQTDZfCOBzNBUVP3zA5Tf6R9vlFMqdDezHzT?=
 =?us-ascii?Q?KPsjHoq7XStNC/Bt4qLVjA0L83+5oCJ8RVqsi8PNkcxTfeijcPmo7U0IcGA+?=
 =?us-ascii?Q?Yqe5oxVSZnIoCqr7Gx2FGCqS/1wsSGOFGLoKouxvSgybsnukoGtXjp830I3N?=
 =?us-ascii?Q?1PRPWy8xx1qcrDHy1h4EYI98wI1KAo6HeWRJNjkLBQ9XTMf8iAFoz6eKkCXd?=
 =?us-ascii?Q?T7W6vqFktaCLhlgNxLP9fSRzU3c9qxqh09zPE54c0jFC1Vi68hdi1O0woXfF?=
 =?us-ascii?Q?qRrl1InzEdaMAS/SVwSb2v7sk13I2LfK5HZxj9saI7K+jNNtrW5Xh2OKEF2K?=
 =?us-ascii?Q?jdBBAvFMgZQb8mmGZ3u6LoaFNHOSQhLPv1ojinwVlFtHRKD6N2zbXZsp1hQd?=
 =?us-ascii?Q?zMQAmcHeQtkvfMBArrii1YntIHaXHF2Sgpau6rEFCAyTMtL2g8gYikgkZ/nq?=
 =?us-ascii?Q?YDlKYMkJH7ZUjywj32VyG8/OR+WcMWQR745flMk3w3hwdwv45d+lgyTK/leh?=
 =?us-ascii?Q?4Kvt3SlYEMT1yUhJolYp/uyq2MunPeBYgv2TY6X/fPlWEZcj6ahQPboKuqvt?=
 =?us-ascii?Q?04JfrLndMQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: CSL01Ac2JDSzSrJkFwWPxlmftBNWDfErPcGENv5sPTwJzL6JmkP06EJZ/+HE3sPfMJpmXFQhfOG4I++rrBK1edusxijFl+993+M3xkyP0HIE/QGZ2h1qfT+wgJNGsYeTql6860Joq8vg+QwErXW5USoBePsfBgQzYqq2SbcP49vQ3xDClwC5l8GReWiv0RFopy/onHoFw8ovKTpYlo50I5aD3NX4BTYEiDES90KuwnxFAwZP8qPyQIjfkHzaWnh+cpb/ypyLDGgYepbtu+1+pew6tvFtwa7BtSgOchDIw20IifQ+7Zkb2NU5BhpZz4VVDQFFnha4z8wTKkaD7EWlkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: df55b3b7-bfbc-4d23-18bb-08df241ef3bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:59:06.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbs3ZyCyLrIsyYwV9diejyxLCnxp9BQXwsdEUdDi+9sHsQqT4Lym2SkMQmdCE8mK4BENtQu+zYr2UxCNmEY5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9641
X-OriginatorOrg: intel.com

On Fri, Oct 02, 2026 at 05:44:04PM +0200, Vincent Guittot wrote:
> EAS is based on wakeup events to efficiently place tasks on the system, but
> there are cases where a task doesn't have wakeup events anymore or at a far
> too low pace. For such situation, we can take advantage of the task being
> put back in the enqueued list to check if it should be pushed on another
> CPU.
> 
> Add a push task mechanism that enables fair scheduler to push runnable
> tasks. EAS will be one user but other feature like filling idle CPUs or
> short slice tasks can also take advantage of it.
>

A hackbench was launched on a Xeon server with 192 cores, using the default
settings to see if there was any regression. According to the test results,
there is no obvious difference, so I think it is good now. Later, I'll also
test with a mix of different time slice workloads:

=========================================
Hackbench comparison
BASE: baseline
TEST: push
=========================================
MODE     G  FD |         BASE(s) |         TEST(s) |   DIFF% | RESULT
------- -- ----+-----------------+-----------------+---------+----------
process 16  20 |     76.438/0.2% |     76.310/0.1% |   0.17% | IMPROVED
process  1  20 |     52.532/2.3% |     51.217/1.1% |   2.50% | IMPROVED
process  4  20 |     61.754/0.6% |     61.758/1.8% |  -0.01% | REGRESSED
process  8  20 |     76.817/0.5% |     79.049/0.2% |  -2.91% | REGRESSED
threads 16  20 |     66.290/1.5% |     67.120/3.5% |  -1.25% | REGRESSED
threads  1  20 |     62.311/2.3% |     61.518/1.7% |   1.27% | IMPROVED
threads  4  20 |     56.376/0.8% |     57.455/0.8% |  -1.91% | REGRESSED
threads  8  20 |     63.871/3.8% |     68.611/0.3% |  -7.42% | REGRESSED

Besides, as suggested by Qais, cache-aware scheduling could also be a user
of the push mechanism. This is an evaluation patch that uses task push for
cache-aware scheduling by allowing the cache-aware sensitive task to leverage
the push path to be pushed to its preferred LLC.

In my opinion, task pushing is triggered less frequently than task wakeup,
because it has a high bar to be launched(preempted runnable task)
This could reduce the risk of contention between the task pushing and the
cache-aware load balancer, and achieve faster task aggregation on its
preferred LLC.

We have launched a simple migration test based on the following change, and
will update later to see what the result is.

---
 kernel/sched/fair.c  | 88 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  1 +
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7eea0414fd46..d5c6bbf04b47 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1391,7 +1391,8 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 #include "pelt.h"
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu,
+			       int push_cpu);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -9325,7 +9326,8 @@ static inline bool asym_fits_cpu(unsigned long util,
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target,
+			       int push_cpu)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
@@ -9348,6 +9350,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * push_cpu must be checked before the target: when
+	 * a task is pushed from the tick, it is rq->curr, so
+	 * idle_cpu_without() would consider the target as
+	 * idle and keep the task on its current (non-preferred) LLC.
+	 */
+	if (push_cpu != -1 && push_cpu != target && !cpus_share_cache(push_cpu, target)) {
+		target = push_cpu;
+		if (choose_idle_cpu(push_cpu, p) &&
+		    asym_fits_cpu(task_util, util_min, util_max, push_cpu))
+			goto select_smt_priority;
+	}
+
 	if (choose_idle_cpu(target, p) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		goto select_smt_priority;
@@ -10156,6 +10171,15 @@ static bool check_pushable_short_task(struct rq *rq, struct task_struct *p)
 	return false;
 }
 
+#ifdef CONFIG_SCHED_CACHE
+static int check_pushable_cache_task(int this_cpu, struct task_struct *p);
+#else
+static inline int check_pushable_cache_task(int this_cpu, struct task_struct *p)
+{
+	return -1;
+}
+#endif
+
 static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	if (!__check_pushable_fair_task(rq, p))
@@ -10167,6 +10191,9 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
 	if (check_pushable_short_task(rq, p))
 		return true;
 
+	if (check_pushable_cache_task(rq->cpu, p) != -1)
+		return true;
+
 	return false;
 }
 
@@ -10231,7 +10258,7 @@ static bool fair_push_task(struct rq *rq)
 	if (!raw_spin_trylock(&next_task->pi_lock))
 		return true;
 
-	new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
+	new_cpu = select_task_rq_fair(next_task, prev_cpu, WF_RQ_PUSH);
 
 	/* Task doesn't need to migrate */
 	if (new_cpu == prev_cpu)
@@ -10335,7 +10362,7 @@ static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, stru
 	if (!raw_spin_trylock(&p->pi_lock))
 		return false;
 
-	new_cpu = select_task_rq_fair(p, cpu, 0);
+	new_cpu = select_task_rq_fair(p, cpu, WF_RQ_PUSH);
 
 	raw_spin_unlock(&p->pi_lock);
 
@@ -10382,7 +10409,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 {
 	int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 	int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
-	int new_cpu, cpu = smp_processor_id();
+	int new_cpu, cpu = smp_processor_id(), push_cpu;
 	struct sched_domain *tmp, *sd = NULL;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = select_flags & 0xF;
@@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 	if (select_flags & WF_TTWU)
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
 
+	/*
+	 * Only a push triggered by cache aware scheduling will push the
+	 * task towards its preferred LLC. Pushes for other reasons, like short
+	 * slice task, uses the default push strategy.
+	 */
+	push_cpu = -1;
+	if (select_flags & WF_RQ_PUSH)
+		push_cpu = check_pushable_cache_task(prev_cpu, p);
+
 	new_cpu = prev_cpu;
 
 	for_each_domain(cpu, tmp) {
@@ -10441,7 +10477,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 			break;
 	}
 
-	/* Slow path */
+	/* Slow path,  push task will not go inside due to flags = 0 */
 	if (unlikely(sd)) {
 		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 		return select_idle_smt_cpu(p, new_cpu);
@@ -10449,7 +10485,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 
 	/* Fast path */
 	if (want_sibling)
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, push_cpu);
 
 	return new_cpu;
 }
@@ -11572,6 +11608,44 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 	return true;
 }
 
+/*
+ * Return the preferred CPU that task p running on this_cpu should be
+ * pushed to for better LLC locality, or -1 if no such push is wanted.
+ */
+static int check_pushable_cache_task(int this_cpu, struct task_struct *p)
+{
+	struct sched_cache_group *grp;
+	int pref_cpu;
+
+	if (!sched_cache_enabled())
+		return -1;
+
+	/* preemption already disabled */
+	grp = rcu_dereference_all(p->sched_cache_grp);
+	if (!grp)
+		return -1;
+
+	pref_cpu = READ_ONCE(grp->cpu);
+	/* If the task's pref_cpu is on the wrong(non-preferred) LLC, move it there */
+	if (pref_cpu == -1 || cpus_share_cache(pref_cpu, this_cpu))
+		return -1;
+
+	if (!cpumask_test_cpu(pref_cpu, p->cpus_ptr) ||
+	    !cpumask_test_cpu(pref_cpu, cpu_active_mask))
+		return -1;
+
+#ifdef CONFIG_NUMA_BALANCING
+	if (static_branch_likely(&sched_numa_balancing) &&
+	    p->numa_preferred_nid != NUMA_NO_NODE &&
+	    p->numa_preferred_nid != cpu_to_node(pref_cpu))
+		return -1;
+#endif
+	if (can_migrate_llc(this_cpu, pref_cpu, task_util(p), true) == mig_forbid)
+		return -1;
+
+	return pref_cpu;
+}
+
 #else
 static inline bool get_llc_stats(int cpu, unsigned long *util,
 				 unsigned long *cap)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 95a18c0d21c6..85527034572d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2559,6 +2559,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
 #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
 #define WF_TTWU_RQ		0x100 /* Wakeup completed through ttwu_runnable() */
+#define WF_RQ_PUSH		0x200 /* Push the task  */
 
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
 static_assert(WF_FORK == SD_BALANCE_FORK);
-- 
2.43.0

