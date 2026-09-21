Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5B50B424
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017696; cv=fail; b=pCw0zCXpXQeE4WqyAVZHKpqhQnOuVf6jdr4sPoicA/3D9bbPn6AfEL5PmADFefb1L4oFCuWFX1fiP1ovp6Hj0C9lZ/MYP3DQeQH/bnUS6bZOxL4o9jL77Qu8/PHdVq+AwszIy/uL10FwVPbyynyHbGsakeWV98i9YK6HPKpSE+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017696; c=relaxed/simple;
	bh=TLL1gjPclOIlSt/N8pMX6z7bzPbpC8NHsQ2Cm4wQXkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K4fNEFeufBZCwoh4M4u91nzwA0nAWMDE+KpNfpQYoJTm88EVs384ezqjCgOHGuSwjvwvcGG8HYFtvC8wRNcZOBhmG6cWt2G/RoMAR7poBbrZgwz/mfXkfjXsJ51av+T4OXG+c15sa9XkNoco+YvJBrl6x8aNCIs1NlIBKumgRtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhbKkjIz; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhbKkjIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790017695; x=1821553695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TLL1gjPclOIlSt/N8pMX6z7bzPbpC8NHsQ2Cm4wQXkk=;
  b=EhbKkjIzAzU/2kXZ8+ep1cLO+LXNsZQxB8laamooPKkB41MJ/laTy8cj
   ZgrKtKtonsGTdgOYJg20G+dakxTegKAuAdfn5p8NK96cE/QbbQI90ICgH
   zd95ldViy/zATSafA15RdB0c9mRNgAIwxoVMWBGW68QQTC0V5PNi19E31
   Mm4dI0cQPwzARo8okjcp8Tu2uElhTcBTxpNwca8xD79fZhN3EkYxPTiDb
   gK+54vkaCR+rjftVf3WVeyqm30rAmanoItKs59uM9CyH4+UYbF7x3Yfly
   FIHUPxd3KFs5DJlYaHEChBf+C7/cExnO1vzu/pQ88ZP4gHQtDYoc/yuLd
   g==;
X-CSE-ConnectionGUID: fsy+MnDIQNeAur4G3swDvg==
X-CSE-MsgGUID: 8Gj10hzxTTuJJdl7TN7PAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93063282"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93063282"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:08:15 -0700
X-CSE-ConnectionGUID: U/wp+HvqR32iL8lhfiLt+A==
X-CSE-MsgGUID: V0gNYikESBuiFnszvuen7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="4114617"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:08:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 12:08:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 12:08:14 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 12:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7zHmhYMKROxMA7A+wc6f5yfivx4/MfR2ES6AzMkUCLjoCAIuLdGFW513ULt0yBSw9HBRvY/PpaKg4NP+w0rzOokWBuZt6u4zZVTioz+AzDOmC4YoOAMUywTlV08YXH0CigRgzFBPB9wj0zG/+4asIUh6tPWX9HAcuaNcL6Ok3xe2jRH1ttdBki2zk3c3r7+bfKYsnZMq8nL8lw7P4FWK/2tYazMWfWCpZJiODOKMewvBLVhAYX6RVg6BXRVMdd+vlPBnqwkJf6Q+jUo0SUPm6Ma+wLHaZAMhL5CuICeRDux/NGRngfxFyr/SFkw8tQEATp9vMLhgg/UzMn8QHmXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLL1gjPclOIlSt/N8pMX6z7bzPbpC8NHsQ2Cm4wQXkk=;
 b=Hr+xtm8K/89CJf1I8FI4wCIcCfPddY6VNcq1l88wO+S7VFiIu+kdA+G+JNlJVTn/VcjlYmlrWKq7xz17SZ0PKKtsuUsxXlHo5veHGS8XtG7kSa5JOfSrZq3r0VVjRWnIK2qMR3B7AraXXLdSymh+Bbl+QI1TtSAoXw1G+jWd/xKydPhOKqRxIiwe8AisHIAqe1NIBQfBpmk7lWMcWz+NIbyssIjC6quqzegKqfs19Oe1b/UwlWprw2Xmzc9JFHallRKjtjgw5kykBrGFt7miUuAwnyqDCzHtI/y10hsYs85R+psm8nPKkuqrm2kKAmdTm8CeGV4XhBFWoke4cbLIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8)
 by PH7PR11MB6698.namprd11.prod.outlook.com (2603:10b6:510:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:08:11 +0000
Received: from IA1PR11MB6267.namprd11.prod.outlook.com
 ([fe80::748e:f6e9:c380:ed94]) by IA1PR11MB6267.namprd11.prod.outlook.com
 ([fe80::748e:f6e9:c380:ed94%4]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 19:08:11 +0000
From: "Brandt, Todd E" <todd.e.brandt@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM: dpm_show_time changes to suspend/resume dmesg
 prints
Thread-Topic: [PATCH v2] PM: dpm_show_time changes to suspend/resume dmesg
 prints
Thread-Index: AQHdOZg2dnv7bqhJ0Eifnrzf242grra+bJKAgBsZUYA=
Date: Mon, 21 Sep 2026 19:08:11 +0000
Message-ID: <0986b7fb287eb688b9e34a4648970c43b561e99b.camel@intel.com>
References: <20260831222926.34698-1-todd.e.brandt@linux.intel.com>
	 <CAJZ5v0gPuf4wpqMgMUVEAvETcyKVNvSXK6=Fe0DYfHbp-J1zLQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gPuf4wpqMgMUVEAvETcyKVNvSXK6=Fe0DYfHbp-J1zLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6267:EE_|PH7PR11MB6698:EE_
x-ms-office365-filtering-correlation-id: 146ea3a5-39bf-4841-75f1-08df1813ae53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 4wntdZMwLxMbXfq16oEPS490wuLsySpL/v8mBjUR7atGRZzahZwP7yUtxhf/Bw6q7QnuE5QnmcFVEln0E5bjE59lEWHneRa4aS0KNJEWqVMWOlqIIaylHAfEEBZHndE362srekeqHgi2aQMCtMMrD/tN4FC5LXStjVhsxaac5GRODMMz/DD3ApQ9isn/ZSd6+uLkiQC+c+H9crbLR/7yCzGZSMBWwOPsJzb/5AZgjPzcu1ILJRzwy4S8tN78SqoanWEYF+bSVzvFh4B5fe7MuxESMp611jm8cpC4LwHKLxIPR5eJVqc8dBojf2qT84Qsa3mDE7JyoVnXxoKXKtxJAkfleRyt31HqveiQub2YNW2FLolxh1/WR2UpEpjENLpkAKt1GMz3FKLg3kb/rw0Gopb9AX9v54D7cJaBOdrxR9tl4jf448XT3CMmqpXxb5m9OvgN+FhMGUmecyRZNbpCEyB496ufCArYMzvk0swHCVX5XwYaOlsfhqdp1Y6qll29FW5YifkE4t2Tg1+HkTBf9/D9PzORUX97lKe/UX8R8tWwjyTuakuOXjimKKXCyb/Lx6kfT4cjldh+UnIDcZwLXBX5ySEc0hlNwQMhq8N4cyAS4oVF2p7T9agPWIn6poUgOX5sJFsrBuhBWu9Rt1THJE8ZEw1lz4tlEqb36EBSOIlTk9/HG2K73S0R4BNQ8bv+d9LPOWuVLn0ECCFNpzd372udhVjVtZq9Nrj3VJYM4w0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6267.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlub251RkhMQmplTkhVU1ptYTY1VmJnL096U3BsWnA2YnJaeVBIRWZRZ0oz?=
 =?utf-8?B?NThRUVdrWVlsUU9QZlJiSW42K1ZjR1RsMmtIWWhEZTgvNmYrTUlPUnJDeXdw?=
 =?utf-8?B?ellueE9tRkZJQ0JCV3cxWWF0Wm55NXhVWmtnMkd1ZUNoTXBoS240TVJOYVRm?=
 =?utf-8?B?T0RlQmN2VlM1ejhRenAxN1pLRGRvTmJrZ2M4L1B2VkgwaDYxYkhNVTdkQlBv?=
 =?utf-8?B?SGZBYTVLaFNoak5MYlkyZWRKOVRGYzNDaU5lcS9VNWFUQW1rZkFQbUtzV2Ny?=
 =?utf-8?B?UVMyK3B0aFNVZGF2TWJwOGh3SWExc1FicTZVSXQ5Rk04cVlYeW5hU1Q1UGpT?=
 =?utf-8?B?aFhDMWtjSXRhVXBTSnJ4OXlYSGhPNTcyMFFsWWNCWFFHM09VcUhNdFdyVG5G?=
 =?utf-8?B?RTRMbTFVN3crMjU1UWUvTWR1cHhZUzF6eURGR3NXbUdiTUpON0V5TjU5b2pY?=
 =?utf-8?B?OGk5NEx0VkpmbVN4Vis5UWtNTFJORUJNb21zQ1UzK0wza2VkNUdxUXppQ3Fp?=
 =?utf-8?B?b2pTbisvWUVUWjZhVTF4Mld3KytqaDhtZnBabm5mc3B6RUx5aURlNDZsVWwr?=
 =?utf-8?B?STl4Ym9WbHAxbWtyZzVQZmtXb093SUJ6WEFxRUtLL25wNVhNQ1Rsa3RnUWtY?=
 =?utf-8?B?V3JWQ3BIMkpRM2pIWm81L3Y3ZFBqS2lDcS9xQVk2WnloYzBQNWJkU2toazNN?=
 =?utf-8?B?Sk5iZGpSdHh5ditGcWJsU3FXemFzejZTQVlNcks2aDQzUzNhdStzSGVBZU1u?=
 =?utf-8?B?VFUzZDA0ZTUyb0pXZDhqWXdyOERKRExKa0J2UXNsWTFKUWhIOGZZdTV3NDBT?=
 =?utf-8?B?ZmQ0MFd1aWY0MW5yeHBUYUc2Nmp4MDVMcnNmWEN2c3dxTExVeHlzQXRMVWdk?=
 =?utf-8?B?U2lkNkZSUjljbFErWmhNSlYxQ2JSZnludTN4Q2VHNkpUcGpHdzNIVEkvbnhF?=
 =?utf-8?B?S0c1ZHYxVGFNS0UralppSjNrdFJrSlpndnpEaGNOY2U3QTI4QUFsOTBsYjVw?=
 =?utf-8?B?QUZiUGJreEtqTWhrQ2RqcW85VXVKZ1RUU1FoQnE2Y3BtdnVzME0yb0o0Zngz?=
 =?utf-8?B?K1luK0VEc2hacVl1bXluVEFJTWFsbG4reXVsaG1hQTNBMlVqVWc3VlBJZDEy?=
 =?utf-8?B?Q3Y5UXpRQllqNWU0MzdYMHVtNzNGYXBZS0p1aVpIRk9tV2thNlFkZGs0ejVm?=
 =?utf-8?B?a3Y2bTBDWHdIYmtkWFRWbzRvME1ldWFXWTJFczdZYWUzTUlUaVM2VUI4RU1l?=
 =?utf-8?B?c05iTGJNcnJjc1lIeWJrUHBaSEQ5dUJVR0o1cHV6cS9sMm9MN0xMVkZiUjNH?=
 =?utf-8?B?RnZ1b2NtVElBMU0vM2hoNHVHNFdVRDNicGh2dnZtOUErd2dxOUk5b011c1k2?=
 =?utf-8?B?UUg1dE5Rb2RRYk8vSldpelFRODRZbnBVVWRxOWt4RjhOSGd3bk9vbU9pazVa?=
 =?utf-8?B?SVJIejZqaEJ6czBPME5DRU9QREhVOFZidlh3VFI3TVM0aUpPMGx4MHFNM2dU?=
 =?utf-8?B?NEhreDVYbFlSL2xJcTZkWk1CMXdMSFFLKzZXSDJWMmR1Ump6RHFET3pseTZH?=
 =?utf-8?B?TFQvdEljVzFhbjIrV0p4OXV4WkpiaW1DYnVzSzNMcHNKSkdIVys3ZVVuSUh4?=
 =?utf-8?B?Q0pINDVIbFdMUnJLNGYrY2UzNU9kN3hQbCtyeTRJQ1RTZzdxbk0zanBVU21H?=
 =?utf-8?B?SnBVRmVoRndFcGFJY2k3dDRYWE9CQ1RqR211YzdjK1NjUUtCUThpZE1IUWlQ?=
 =?utf-8?B?TEJ2cFoyTUM1QktRR2ZVOUsxUVNzMTJOQmhXVGFmTGE2M25jUUl2VnU2bmhQ?=
 =?utf-8?B?V2pha2VpSHRyUDhwb21ROTVJeVFLYlJQKzdZMjlZWVQ5eFlSYWFNODYyN04w?=
 =?utf-8?B?VWR2MUZSMFlhRDBIZ3BycHhTc3d6UFlhNkp2U1ZkZkxTQ0paM0FxaFJ6NDJQ?=
 =?utf-8?B?bzYwVmNLZTlNTU1pQ05icXF3WUk1Rm8vckJHSEdiWEc3SU8rYjJCY3JLRWRr?=
 =?utf-8?B?NkZ5azVwSmJJR0xNTHJpZTZQa09aU3dHUjZZbTFOUWE0TGk3KzBRd1Z6N1Iz?=
 =?utf-8?B?bERVU3pTbDdVNUh0eTVaMmREbmNjbG10czRzVU5kV0NQc2ZJTUszR1BIVWpY?=
 =?utf-8?B?S2UwQ3NDa0ZWVkY5MkY0UTlEc1RsMkVXOEwyWHVwUHBGT3hKaUNhNkZnR1dt?=
 =?utf-8?B?dkVZMU83bWZKRElsNzh4NStDYjFHVkVhU3RQem9qMWtQU1JrYXhYcmtOOUJP?=
 =?utf-8?B?RmhhdzNaWUMveDlDcyttUmJYNlFHK044eHc0cVUyK2M2Q1lzaGx1cUk4bjBQ?=
 =?utf-8?B?Nk5hekVIYnhlcVVOaytDWFd3RVc0VkxRcXJ0ZGY4eVNmY2RhYnRuZElIRzkw?=
 =?utf-8?Q?kIQ3vuHvgX+9syo0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB74F34A5F192C478A9A446BB08E5901@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jnLHV+4DMTJf7lQl1ii7neCfR/1sjsIiG7koALuAkOumQjd1dMTxKeUMPUB0UM0qvqt8Oygl08bxEjsJlsoDFeCQH3n3LqBlk8C7xcXcG/4fRqny5YxvXLyvQ+wcAEKQqKMvhH7bSITw+XLGQwOgwRAzALNZIZowdemRZYMe7IAC++9q6P4tVZnYTw3f21MWgsUe2GU3LrLLK7hnGVzaPbUlCBajQnAAi8IgHdUQYNwhwjSWYijJUVHln1bILXP24bcS5s4yjP4D3Q0q1YTrLnJnmgdDBviD1c4NV7QEf459RMzHxul6G7T/7LFItiG1MfyaK4zBac+7BLMQbuxkwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6267.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146ea3a5-39bf-4841-75f1-08df1813ae53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 19:08:11.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBo/lRyBHmI1OiyzbX7FCpXv54joceFTP5WkUcBQl4astUR5cDSsPtl+Gj1g1rnAmmqFyK9w0U5fmydfisUYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6698
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTA0IGF0IDE1OjE4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSAoSW50
ZWwpIHdyb3RlOg0KPiBPbiBUdWUsIFNlcCAxLCAyMDI2IGF0IDEyOjI54oCvQU0gVG9kZCBCcmFu
ZHQNCj4gPHRvZGQuZS5icmFuZHRAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBP
cmdhbml6ZSB0aGUgb3B0aW9uYWwgZHBtX3Nob3dfdGltZSBwcmludHMgdG8gZm9jdXMgb24gdGhl
IDgNCj4gPiBwb3NzaWJsZQ0KPiA+IHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrcyBkZXZpY2VzIGNh
biB1c2UgYW5kIHRoZWlyIGFzc29jaWF0ZWQNCj4gPiBwaGFzZXMNCj4gPiB3aGVuIHRoZXkncmUg
Y2FsbGVkIGluIHN1c3BlbmQ6DQo+ID4gDQo+ID4gUmVtb3ZlICJzdGFydCBzdXNwZW5kIiBhcyBp
dCBpcyBjdXJyZW50bHkgYSBjb21iaW5hdGlvbiBvZg0KPiA+ICJzdXNwZW5kIiBhbmQNCj4gPiAi
c3VzcGVuZCBwcmVwYXJlIi4gUmVwbGFjZSBpdCB3aXRoICJwcmVwYXJlIHN1c3BlbmQiIGFzIGEg
c2VwYXJhdGUNCj4gPiBwcmludC4NCj4gPiBBZGQgImNvbXBsZXRlIHJlc3VtZSIgb3ZlciB0aGUg
ZHBtX2NvbXBsZXRlIGNhbGwuIEZvciBleGFtcGxlOg0KPiA+IA0KPiA+IFvCoMKgIDY2LjY4MDQ3
OV0gUE06IHN1c3BlbmQgZW50cnkgKHMyaWRsZSkNCj4gPiBbwqDCoCA2Ni44MjY2NDZdIFBNOiBw
cmVwYXJlIHN1c3BlbmQgb2YgZGV2aWNlcyBjb21wbGV0ZSBhZnRlcg0KPiA+IDExNC4wODEgbXNl
Y3MNCj4gPiBbwqDCoCA2Ny4xMTkzMDZdIFBNOiBzdXNwZW5kIG9mIGRldmljZXMgY29tcGxldGUg
YWZ0ZXIgMjkyLjYzOSBtc2Vjcw0KPiA+IFvCoMKgIDY3LjEyMTMwOV0gUE06IGxhdGUgc3VzcGVu
ZCBvZiBkZXZpY2VzIGNvbXBsZXRlIGFmdGVyIDEuOTgzDQo+ID4gbXNlY3MNCj4gPiBbwqDCoCA2
Ny4xOTAxODRdIFBNOiBub2lycSBzdXNwZW5kIG9mIGRldmljZXMgY29tcGxldGUgYWZ0ZXIgNjgu
MzA5DQo+ID4gbXNlY3MNCj4gPiBbwqDCoCA4MS4yMjc3MDZdIFBNOiBub2lycSByZXN1bWUgb2Yg
ZGV2aWNlcyBjb21wbGV0ZSBhZnRlciA0OS4xOTYNCj4gPiBtc2Vjcw0KPiA+IFvCoMKgIDgxLjIz
MDg0N10gUE06IGVhcmx5IHJlc3VtZSBvZiBkZXZpY2VzIGNvbXBsZXRlIGFmdGVyIDIuOTIyDQo+
ID4gbXNlY3MNCj4gPiBbwqDCoCA4Mi40NDQ3MzVdIFBNOiByZXN1bWUgb2YgZGV2aWNlcyBjb21w
bGV0ZSBhZnRlciAxMjEzLjg2OSBtc2Vjcw0KPiA+IFvCoMKgIDgyLjQ0Nzk0M10gUE06IGNvbXBs
ZXRlIHJlc3VtZSBvZiBkZXZpY2VzIGNvbXBsZXRlIGFmdGVyIDIuODUwDQo+ID4gbXNlY3MNCj4g
PiBbwqDCoCA4Mi40NTcxMzFdIFBNOiBzdXNwZW5kIGV4aXQNCj4gPiANCj4gPiB2MiBjaGFuZ2U6
IHJlcGxhY2UgZXJyb3IgdmFyaWFibGUgd2l0aCBOVUxMIGluIGRwbV9jb21wbGV0ZQ0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRvZGQgQnJhbmR0IDx0b2RkLmUuYnJhbmR0QGxpbnV4LmludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMgfCA0ICsrKy0N
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYyBiL2RyaXZlcnMv
YmFzZS9wb3dlci9tYWluLmMNCj4gPiBpbmRleCBlMTMwZGE0MjgxNDEuLjc0OTZmNzZiZjlmOCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jDQo+ID4gKysrIGIvZHJp
dmVycy9iYXNlL3Bvd2VyL21haW4uYw0KPiA+IEBAIC0xMzI5LDYgKzEzMjksNyBAQCBzdGF0aWMg
dm9pZCBkZXZpY2VfY29tcGxldGUoc3RydWN0IGRldmljZQ0KPiA+ICpkZXYsIHBtX21lc3NhZ2Vf
dCBzdGF0ZSkNCj4gPiDCoHZvaWQgZHBtX2NvbXBsZXRlKHBtX21lc3NhZ2VfdCBzdGF0ZSkNCj4g
PiDCoHsNCj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7DQo+ID4gK8Kg
wqDCoMKgwqDCoCBrdGltZV90IHN0YXJ0dGltZSA9IGt0aW1lX2dldCgpOw0KPiA+IA0KPiA+IMKg
wqDCoMKgwqDCoMKgIHRyYWNlX3N1c3BlbmRfcmVzdW1lKFRQUygiZHBtX2NvbXBsZXRlIiksIHN0
YXRlLmV2ZW50LA0KPiA+IHRydWUpOw0KPiA+IA0KPiA+IEBAIC0xMzU4LDYgKzEzNTksNyBAQCB2
b2lkIGRwbV9jb21wbGV0ZShwbV9tZXNzYWdlX3Qgc3RhdGUpDQo+ID4gwqDCoMKgwqDCoMKgwqAg
dGhlcm1hbF9wbV9jb21wbGV0ZSgpOw0KPiA+IMKgwqDCoMKgwqDCoMKgIC8qIEFsbG93IGRldmlj
ZSBwcm9iaW5nIGFuZCB0cmlnZ2VyIHJlLXByb2Jpbmcgb2YgZGVmZXJyZWQNCj4gPiBkZXZpY2Vz
ICovDQo+ID4gwqDCoMKgwqDCoMKgwqAgZGV2aWNlX3VuYmxvY2tfcHJvYmluZygpOw0KPiA+ICvC
oMKgwqDCoMKgwqAgZHBtX3Nob3dfdGltZShzdGFydHRpbWUsIHN0YXRlLCBOVUxMLCAiY29tcGxl
dGUiKTsNCj4gDQo+IEludGVnZXIgMCBzaG91bGQgYmUgcGFzc2VkIHRvIHRoZSBhYm92ZSwgbm90
IE5VTEwuDQo+IA0KVW5kZXJzdG9vZC4gSSdsbCBwdXNoIGEgdjMgb25jZSBJJ3ZlIGRvbmUgbW9y
ZSB0ZXN0aW5nLiBJIHdhbnQgdG8gYmUNCnN1cmUgdGhhdCB0aGUgcHJlcGFyZSBhbmQgY29tcGxl
dGUgcGhhc2VzIGFjY3VyYXRlbHkgc2hvdyB0aGUgd2hvbGUgb2YNCmRwbV9wcmVwYXJlIGFuZCBk
cG1fY29tcGxldGUgc28gSSBtYXkgbWFrZSBhIGZldyBtb3JlIGNoYW5nZXMuDQoNCj4gPiDCoMKg
wqDCoMKgwqDCoCB0cmFjZV9zdXNwZW5kX3Jlc3VtZShUUFMoImRwbV9jb21wbGV0ZSIpLCBzdGF0
ZS5ldmVudCwNCj4gPiBmYWxzZSk7DQo+ID4gwqB9DQo+ID4gDQo+ID4gQEAgLTIzNTIsNiArMjM1
NCw3IEBAIGludCBkcG1fc3VzcGVuZF9zdGFydChwbV9tZXNzYWdlX3Qgc3RhdGUpDQo+ID4gwqDC
oMKgwqDCoMKgwqAgaW50IGVycm9yOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGVycm9yID0g
ZHBtX3ByZXBhcmUoc3RhdGUpOw0KPiA+ICvCoMKgwqDCoMKgwqAgZHBtX3Nob3dfdGltZShzdGFy
dHRpbWUsIHN0YXRlLCBlcnJvciwgInByZXBhcmUiKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAo
ZXJyb3IpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRwbV9zYXZlX2ZhaWxl
ZF9zdGVwKFNVU1BFTkRfUFJFUEFSRSk7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZWxzZSB7DQo+ID4g
QEAgLTIzNTksNyArMjM2Miw2IEBAIGludCBkcG1fc3VzcGVuZF9zdGFydChwbV9tZXNzYWdlX3Qg
c3RhdGUpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yID0gZHBtX3N1
c3BlbmQoc3RhdGUpOw0KPiA+IMKgwqDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiAtwqDCoMKgwqDC
oMKgIGRwbV9zaG93X3RpbWUoc3RhcnR0aW1lLCBzdGF0ZSwgZXJyb3IsICJzdGFydCIpOw0KPiA+
IMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnJvcjsNCj4gPiDCoH0NCj4gPiDCoEVYUE9SVF9TWU1C
T0xfR1BMKGRwbV9zdXNwZW5kX3N0YXJ0KTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+IA0KPiA+
IA0KDQo=
