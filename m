Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F72571A9;
	Tue, 13 Oct 2026 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869431; cv=fail; b=kDi8zplDv8Xoj6e5nFvvnKTLhw+dVLpHqWNZcv0dpcq8ru5WZQd3P7yGE+zq+MKkP6T+K8ycZ57QdJH9ITnfEFRYwVC+7agTVWHhiQ7nTXxsgrCdHVYChrJx4wL93goUIXyLnSDAUs9TJpjha63w7Jom2VEiCq55D52uIlLCLiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869431; c=relaxed/simple;
	bh=f+atP8i27ZenZvprGDoxnq/MUt5usmq8LedIkyzC+II=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKWd+WF14l8yZ1pb+nzbSUtn6HuYwE0sZ9t5AHBes4gTzITzYdN3KHc31Wlqu4j3/tszLKncpryNOhJ+W03GNn5szhSFzg9uhtLTTtDSMXFAcNDmvIYTBYmllkWw5G/T2IRRMewYcHrKiD5zSsV8THPWpAwP6zuip77DyfwZ2a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCBviNDo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCBviNDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791869426; x=1823405426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f+atP8i27ZenZvprGDoxnq/MUt5usmq8LedIkyzC+II=;
  b=MCBviNDoXKzNFVRF1Jbu3IZPWl+lbjByW3bwrWEbReS9bRb6gg+KeRPD
   XocNonm2/7BXXHvClcLWylO41yzpuXF+QxoSWxYsTAMebibh/+aOM3iPM
   5mqu9cFSLgmDtvQGYiauI4Yos52dF7LH0JkIV7cnEbFGDfkzDahMGItXB
   BNSpGii/o0vNgMIpMx3H4VGLhXe71Sss5GiJZUfs1eECCspWWxdC4oDA4
   gmACQlik8VLujBfmSFKvKsV9/XhA1QEZBWvlhDthGDX5BKMz6xcxGcmdB
   Fq0TM+SurB7XyzZYcnP5oFok/Dw4uRqVPTjBsO+ocKlNRPdlHhXVAQLt6
   A==;
X-CSE-ConnectionGUID: jXd5RhSSTA6Wd/E3ewPk+A==
X-CSE-MsgGUID: As67HPIQQsaOFAWYwjGLHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="464768"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="464768"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 22:30:25 -0700
X-CSE-ConnectionGUID: GJkqrxQZTsuLf+oW6auaUA==
X-CSE-MsgGUID: Nik/3soERk2Bk7TGRNRDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1113312"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 22:30:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 22:30:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 22:30:23 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 22:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5GYVw/+ekyabX6lqlIfzwcF3kl6exUCtVOax3KfR+A8HdEoamSiQTnKGYHhbv7+HBgMRqWROZndBqwmj1q2lxeL2CIp20mHyYHaL5QWJFcmTQt8xD3LdGVnfsIIKRKa+ZLBHd9lZQYn05KnxJZz2dI/5lq9C1MdCgb1GqCYQhBa5FhE6UdawBiUKHEaFSos/eQzekcBbMgouI/akqAbqIzfCFpUn+LIN812joDWiuJ9O2CVNIdYZ1j7Fp7wnNIfyi/JdIaPlHIN/IepRUy07l4XHnQ2Qe6J2JOc+HuKm51U+z7RVpFL4/ATolTCI8Jjn3lCWa0/8qh18pN0N/u6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afe+uRItTSPBYqHyF+HuYOhTWvTMkMLFe2U0wQOWKaQ=;
 b=D0sahzmSR45L8qkbF+512/8wz/yIWYpe0XjAJgJ0PRJSWAcOX7JQHK7idiGrM8N0w7rXtEtmttS1SXklVYZAI/po86PiyOGVwB0OR3LRfZCdCS40TJDKsXz/S7tlCz4WS/9VmZX1mifafFtYdhxxmsyPy9gNUJ5GL+JwcwZ6GXwv6g2PxJiq5C8seuxvlVcg+k6vT5ZoX5CvgRfnj2FxLq2PBiPvARuBqZLNn6TVkrFYRkAXhZdRZyLV8dwjpxHqvtrNlmPlxzHs3j/S/RfhVshWfcz4adhJWQnGhPikNFk7hF5A6fU9UzYZqIa5BXXkWzWL4GJ7H5k2HzuZaoFZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 05:30:21 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:30:20 +0000
Date: Tue, 13 Oct 2026 13:17:13 +0800
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
Message-ID: <as2-2b417B8ZaFdO@chenyu-dev>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
 <asWyZtW7zPVo3k-A@chenyu-dev>
 <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
 <aspc8doovTKdBqPC@chenyu-dev>
 <CAKfTPtAy-n5_Dj-9x2qxcu=i7eo9DmZ2aaxig_nbyNDbP2m_Mw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAy-n5_Dj-9x2qxcu=i7eo9DmZ2aaxig_nbyNDbP2m_Mw@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0afd60-13ab-4585-49b4-08df28eb12c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|11063799006|261009223027099003|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4FGuig/cXqY9QdGQnO0IG33NayJqZHLrbKjR9AEbFKgJPpKlTyBS2AAxVLLnYpjSpPlGzTAdPxvAwOWicb7EvH6ThFcwZd5yzm7t7wxCfyd6cS2NIlMQ+XMG7Rv0WnQrkJ+09YqPgLdCH2M/jOKv5ReeZyvl5LzO7GpwIzrDDz3d7C0w7hXtjUtfvWjE9qiB/xSmvQWIQJUptjPGx4MdmCX5hylwt37sG1Uw8PxyyZwLI6IWGk/paRZfcPyPPiojD2E4/qRZaSCYXBSAHnOihajIx1FjVThwkpJYHHLvaecz2MYaa80J7NQtgrFXT0WAil+0jHsdTc3liBYcsNN1xt+UhoVYoVuHShcN3a05JAvqaCCRgPVuaT3ofKC3Uuvy4f5WxYm0q7Sqpb9rZysiZuhr+mR9ihFtV3TuFmkx+99huPHHTrGffAM8RaaAGPUPNIqoZDnCzwEjGAcZHzQKsGvqO8bPH57krS7sSDUUfzOIOTFVj8w+luPt2OisqoFSB3cR9u7a0GCzL8qd8m/tY/cJJrxOxCjvbjcm71Y6pGqA+BD4IhqW9Hp7untFQ3S999CWdNKWmEGP7PNA4PlcDvkQ6g7Ff1oY0qrpD9aNS/SwaEReJTCOeUgH/+dRMyEJTAgylDNHgc1XfX+OOGqooF3DkzWLUaJQK/z5GTlNn7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(11063799006)(261009223027099003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FUhJAwAZDB2N0s2tCZ9rtKK75VeOWWp/zd1+S5Qz+k95JAnTBV4I5caWwK22?=
 =?us-ascii?Q?rOMbZmCwi9lohjZ6e0IyE/MFFq+NzBr5JLvRToRu7JUvKvXLf7+rdQnXdrPl?=
 =?us-ascii?Q?gFFx+CSoqq3k6zhkyFtocI7bHt5/EerGJzF8foZQfXJ4kbaR3Der7iCZLjSD?=
 =?us-ascii?Q?0lMUVvuhUuAGdgf4wQi02yBPvBoWt+QrskIBK3xFTToTsSfpKPxhiS0rUCAM?=
 =?us-ascii?Q?NZHGrzHEO052cj3I1oknOw8Cq5rSfAyecARkMTdbujyFLoXQ4VFxArDMjJNa?=
 =?us-ascii?Q?D0TE+fpaqS+Qps2cMMUUzlEcBv8Z7I93OHOh8zq9bkNe+6GUSoIDZ6ua6nzu?=
 =?us-ascii?Q?uvv82qaBBVQGaY9BLWl4EyKNh8o1+vyw347Md1DWBB5TygJOYyxeQuxPUuKR?=
 =?us-ascii?Q?OAXFKfwmn2ReMQgkxDlhcYWbmq0LALC1REycc6zTWj8WcwHz1WpvxTqby4SV?=
 =?us-ascii?Q?+RuT24QIaMiPNi02NtIq32S72PKeduPMkgtzbw9mui2S+orRLbbKyJlDIQJo?=
 =?us-ascii?Q?lg2OgFY7Hncfdcg4S4bz1vbM6OdZfZZkqEReV7NPYtBxVH3v2UEyG4GB+MpR?=
 =?us-ascii?Q?kiqAtHYIBQUjxVhGMegwtKuijP12RFAUgrmLycKxjvL1V0rflvgYtEqZqJrD?=
 =?us-ascii?Q?ram6ZnknEcblljHlNO7C1pNzFjf81LJzwEFCfE7AIL+ikcLBWSNIZ1muacrH?=
 =?us-ascii?Q?J8xWb56wyW2sTGkXLJEPjLIfhY33PWXpJw11HzDbhhFWjM511EndVeFI/RBU?=
 =?us-ascii?Q?n9xwRnaOBVn4FEhgXm03olz+3QR2gE8bKFcrCGzdN183UhKMaULjx+btlb4t?=
 =?us-ascii?Q?bFfTPFVV7j3GwmiPQ1rZSyNzBciGhwTInGbFe7BXfDpg0nyU1Q6gVXG79unt?=
 =?us-ascii?Q?7fmXUJ4tZRlQusAZk52utE/+QVdPG6krTfttQO/rLinDgJ8Gf+QgPJ3wbNaw?=
 =?us-ascii?Q?Zkmt98LnxwmDfNelTe2CJtzQesdY32xlgep2dzrNLzKelqLZqJ/hfJMnBH+r?=
 =?us-ascii?Q?Wmpd7kqqBYnEZh6bhiJK9kko40KvKkO4SJze/6fpWBQk0Gjof95aNa/525EA?=
 =?us-ascii?Q?TY/1uRQwYIyt9w7lGNuKMSX9fShVfCjcQnEDb/HQ+GkEd2sxPCx5k3eti1CL?=
 =?us-ascii?Q?1yzqqNtFUKR0EtsbkIof7cI9ulxUiHA+hbBWyok92XE3OiikKKgV68heH6YW?=
 =?us-ascii?Q?Wvc2G2ffluVIFwR2Oy3eqYYkzNvZCyw7qf8V11y3UZ/K95Akp7v/Kl7CqvtC?=
 =?us-ascii?Q?wG2+Gujsg5NSjnjzs7K1guyVGdafcC9Ha18fFyU54F3UDoglynUEMiZCb+dl?=
 =?us-ascii?Q?fXDZwEnVzw2FEAtj7qpAAEC8EXXbpVvtEODV0+7zsBOr9BKMO1MhD7zoKYfU?=
 =?us-ascii?Q?3WikXcMeZIeUFANpUmWeRcvraAeNrPUKkwLTJpq66RGcYHXSAccOILBk0zHY?=
 =?us-ascii?Q?GKcqGmNVbYF3ZdrkUBGOz5NGW0CLqhT8p3ubw9jp8dFssA0HlgF2AyHp/XTO?=
 =?us-ascii?Q?j2hiq0Z9VTxsJHwk2JUZe20exwPqG6kDK3kpWYRurO5wxZSP+CBYXomhSA5t?=
 =?us-ascii?Q?YFHFwRlnySq3ECjFfrekdlj/sUuE1330/kNhDh0rldWpXLJC9/5VZ6b+GDm1?=
 =?us-ascii?Q?ojWxvuLyZJ5ikXM1WOGjLk4Hqw+9m9lKtfFcQE82WJWIw7wz8NWgTtrWObp1?=
 =?us-ascii?Q?UirwpzP7WoO1dbUsiI1QgBTLIczz7xlOdoK1Q9E6F4FWMG44LpaDMlVQ0yan?=
 =?us-ascii?Q?Zfjx39jegA=3D=3D?=
X-Exchange-RoutingPolicyChecked: d0+kbvrsndQJJOKkDNh7hOdbQTo1WTuuq47R5nBWdhwqojf7pAGCDeA55G85Q96Tc2DJQ3jhg1aWr7ieiTJWKqQgqpI009xMLzfLBmzpmdXp4lq5WOQYrluCVzc4hQjenL7sGRDCoEohcwzT0DF76l1VKhQIv/pRHBTl0yI3uMfHpMaGPRGzwbtaliO8i0fQz3dlor1Z9hHtNe0NTa9M4sGCf7uh3Vw+I9IqPFUk1/yTT3uSITMs31FDhVfI1iwuHZ3fbKuTDa1lUqACuRhRc3GOOsWDeo6jLstEwoYrNSSfDCOuCZHsvT2h0s+9cYmAP2s6U2uCxkQjxvS506fM4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0afd60-13ab-4585-49b4-08df28eb12c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 05:30:20.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EjLDr9jIvYej15N7WLZCXFqhcSSrDShQf97ir3x35pyZRAM0FFqYXbNLvQvq6c8hbLpOQXgzevTQirdAZGl6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com

On Mon, Oct 12, 2026 at 11:18:04AM +0200, Vincent Guittot wrote:
> On Sat, 10 Oct 2026 at 17:55, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On Fri, Oct 09, 2026 at 04:31:40PM +0200, Vincent Guittot wrote:
> > > On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > [ ... ]
> >
> > > > @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> > > >         if (select_flags & WF_TTWU)
> > > >                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > > >
> > > > +       /*
> > > > +        * Only a push triggered by cache aware scheduling will push the
> > > > +        * task towards its preferred LLC. Pushes for other reasons, like short
> > > > +        * slice task, uses the default push strategy.
> > > > +        */
> > > > +       push_cpu = -1;
> > > > +       if (select_flags & WF_RQ_PUSH)
> > > > +               push_cpu = check_pushable_cache_task(prev_cpu, p);
> > >
> > > Is there any reason that you do'nt want to migrate the task at wakeup too ?
> > >
> >
> > The wakeup path seems to be too fast to aggregate the tasks, so that multiple
> > CPUs try to migrate the task to the same LLC without synchronization - a task
> > bouncing issue was observed when cache-aware migration was enabled in the wakeup
> > path. We can double-check in the latest kernel to see if that is still the case,
> > and to see if we can mitigate that.
> 
> Yeah, the goal is to use the same select function for all events;
> wakeup and push events should be seen as the same event
> 
> Also you should separate the check for adding the task in the pushable
> list in fair_check_pushable_task from the decision to select pref_cpu
> in select_task_rq_fair. The check added in fair_check_pushable_task is
> mainly used to decide if it worth going deeper in the decision with
> select_task_rq_fair
>

Do you mean the check in fair_check_pushable_task() should be lightweight
and let select_task_rq_fair() make the decision as to which CPU the task
should be migrated to, because the former does not hold pi_lock and thus
should be best-effort? OK, let me adjust the code.

thanks,
Chenyu

> Vincent
> 
> >
> > thanks,
> > Chenyu
