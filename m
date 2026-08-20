Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301838655C;
	Thu, 20 Aug 2026 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203707; cv=fail; b=DM7QImRn5EWS5FTY+ImgeLmAWu2RPlkt0xO8rGkri7gpbw7654yYGgKG8afTsKlcEVWSs/tLgcazFhdYs7Qfw2SATYWzLd9gRIzg3F2aVd/XQUoRF/COyCURK9BR00mtwCY3cAw9BgC98XCVia2RVxaZc55YCO60kus7HHOP7iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203707; c=relaxed/simple;
	bh=cRsfkHCy6zrhMDmM4XZLtIMqqNvf250OEt+lviQDTEs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a74hvo+Z9sQBihgAV93mRc4l0cjspfr+gaWvwEMTb/DUOzRLLIoovbTRkfMhucwrVZm6HNKFFvulZvYKNSuZNPtGbzGi9QmfZeTxnKS5IRXRnMU7FF3jDz7HvJMF0dowvjLEEN3DLSR2oFaNIXKWgkcl+VmBip582ks5zNZNXMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpWGsgpW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpWGsgpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787203706; x=1818739706;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cRsfkHCy6zrhMDmM4XZLtIMqqNvf250OEt+lviQDTEs=;
  b=XpWGsgpWOtU/x1Qc4ZDirohAAgVDsjxDIUlkpcStzuz96lRKtw4N82+c
   6lAt/+k6L/HZ65pQByHmzvZ3jvxO49gfT7Ljt/JNy7ppY3/OYFMHeK4hX
   3Ttign9IdGR7cAAr1P4W5kEiy3dmJufL+bL+kMikVGsotPxzUTjB2pgZe
   wHwpSRipTlvKCig25i2D3f9PBc577e1gj891vgC24IZbO0t1fw3z3X7K6
   DxMiwUwa7n08M11fCVZI90Lx1/gpAWW0w/MQGy9esWEWOMRHOm5/T4MES
   jHRRBFz9NYwhiIi6q5ml5nSxjaEGZCBybAFmYJ92PL0eqvZ9PaCG9rpfF
   w==;
X-CSE-ConnectionGUID: hDk1X0jKS/KCcu2JuNkLxg==
X-CSE-MsgGUID: FPI06gDcTpyrlMJ41rnb0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75260908"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="75260908"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:28:25 -0700
X-CSE-ConnectionGUID: kweyVip/SlqyTHVVNR9lng==
X-CSE-MsgGUID: fTPAcIgXSmaGnZEhR13UxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="262543894"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:28:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:28:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 22:28:24 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QonUKlzrOE4dBgBDXNS2j2KZGCaJoW5WFWJuDNkd6Cdku35tAkgBflqEoAhzgg+aRJZybkp8j72PpqHxyVnEG62sm2iwhncpi8MUBUm2+xQYw/lC75Ked5PsUEEpRylpspnVS3R2I7YLp5m7pH8C94n+y8QqISPMf8MVQj83xhkJIAO1D8fxh7KI9ORr5dGp8141wk9xdX+mSCkHy0Yi+sDw115YxswwS7RyhQnOs5/lY1wfKbBKDau0hMx6u5bPefQLemZifpbmjrgV/MPC/g4Pmk3Tkdsl81iG8/Oda1ZED9oViiLUkTaYphQEcIn1V6oc4tYcNlnFkzRguMNvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpgVf87YnPRNtdbVe8D+p9qPrLJjhhNAZtHYIYAZvYw=;
 b=HTPsH3n+dBPHhdkRF1CIC6koQWHZ9MpXjqP6VuFY591s5d8T5k/88+EJEXJzlmk0Qwl8jff/Ohooo3klLCB+QL7IPJMMmG7WLwrv+UMFBFAUrT1eFwicUSPpftrsm8u2Xc4Ja8vpjnW6v2dVrauIuN3hFw/wq1VAS+0M5LsVvwNUuRfI3n0B+VQ0EfamuYMPsbYFWOnTfVPa4dk7hWTMdnjpcGspOC789azjlRYiBAs2SXVjjYaAlOWOFenW9B0khm5JvTthK/Ke/JV0sKuUGy05JZPDbDwaGhck8ao2lS4qeTWQ6nxDD6sgVqZHoey1YTXyQIDcAt1I2frGGtG/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by SA1PR11MB307637.namprd11.prod.outlook.com (2603:10b6:806:520::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:28:20 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:28:19 +0000
Date: Thu, 20 Aug 2026 13:28:10 +0800
From: Philip Li <philip.li@intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: kernel test robot <lkp@intel.com>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fc02d96a639b5b4ca32bd249e971e5d0aafeb874
Message-ID: <aoaQavCUUwzDVNmY@rli9-mobl>
References: <202608121937.J7M1vGVB-lkp@intel.com>
 <CAJZ5v0gaAfZFuwze2rU4gACoOE2jjF6dfAOELC2vqBCwV2bhJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gaAfZFuwze2rU4gACoOE2jjF6dfAOELC2vqBCwV2bhJA@mail.gmail.com>
X-ClientProxiedBy: KU3P306CA0005.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::14) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|SA1PR11MB307637:EE_
X-MS-Office365-Filtering-Correlation-Id: 51779f9d-d881-4f24-c3f4-08defe7bd806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SbNt7a0RsqYCI2itQpAN29KTHLPdL00Uq2iZHcCLT4+nwJoLgqs2+rgL6JnGr027HXY8Bii8j9vqen1AIX/wrmTVnbsVncjx05ZU9HQo9EMy1eaboMbjyns1RiFFppyfXzcF6YOpx+jAXCcqg7wfetN5ZbqawyIdTipsNziVLIm2avRu2Au8DEaI7Cuk6eRVS0c2KMAUdUrKWToTNIvXDF5+rFuywN6QSMJKYBEce3E8I7NolO8rVvgfwDUvv9u25ormo2eXa5sfuTxN+zBF2arThGH6a0yEFeIVR0HgsLMXvNmNX8yFdKbIAcqzyQQx1/3wYL6zJnsmQQdZ8GS/weri6IMcMwqd4Y5bChLI7LZg6QVvpiB4mClAnMrEc9gUmM2jbTB8K9QGptvahbh52890ijqiD57cqxKmFMsfhScwcjdlMHfF3eqiQg/3B1Fw4nXfIwJ+e36nSxcV51D0e0tuyeJjWopj0RXy2HDapXihKUgLiUT9TiYM0L4W87uwHzPymPZrFFxMQlYkdim+A3MOXCzFBveSQWtKyq8jtWtCngaiM/xu+vq9icV0Zvao94RDjxOIASNgIIf0AoyFfORj5kENbHR0mvYHaDrwA7pyv6kBo5s6eOALcZyj3wIy+2JjM4AoXuwjR33/bXgPxd0UUz7YlTEKNVvmlhX0fwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01RckR1bTk5RWM5M1JXNmxKMXpwSUVjbjR2QkpyUUE0RHhyQ2dkWk9vcGdJ?=
 =?utf-8?B?OXNBM1JKYU5pRi81ODZPYUU4S2hXeWxoRjFsV2dtTEhlMFh5SXpINDNJeUFi?=
 =?utf-8?B?YzhJUElwQURBTEdYS0JuWEN5cUpjRlBpU1RvMWRWTW5pT3dIdUYwQmwyNmlt?=
 =?utf-8?B?TXhmZzQveU9iUDAraXdWOThKVjkzMUg3QUNJRXI5UmgzOVQvQlZXUXpzbDFZ?=
 =?utf-8?B?bllUMUIydFc2d1JPOHhjVEEyWWlleEpkQkhzM25oTnpaQXZ5SlQ1eE84Z2tm?=
 =?utf-8?B?SmJMbWJiUWVZOHBQMEdhN0hmZ2hUV2lXdm1zTytTRUFVamo5VkZHVjRZbGdB?=
 =?utf-8?B?TlVvS1YwTGlrMHZVeXpoc09ZQStxV09KTEY1ZHJMbldZWlRUbnN4aUJwcEhU?=
 =?utf-8?B?SC90YTJqcUxwM05UTCtVVE5sa3QrT1B4UjFmZktSUlNJUFlXakFFNDhYaHIx?=
 =?utf-8?B?dzRMOXAxRTdlSjRVdkkrZ1hURGZIKzd2Sk9JeUo0YUd6UXdxTzdGaUpPczZE?=
 =?utf-8?B?Qk5kNXZzWW9OMGlhRnE3aGVYM0lBeXBzcGZON2lkUko5ZzROeGhVV0phRmwz?=
 =?utf-8?B?MTFHencyM1ZmeHdKaXhMUzlBYVJWbEo1c2ppektTNEprU3JVSmFwMlhRWHVu?=
 =?utf-8?B?eTBKbHpVeHFJWFM0L3B5MWp3OGlmRGNYSEtwTE5zaXRKWTFaLzUvdWt3YWhR?=
 =?utf-8?B?TWY1YmRFZThRQXc4aXBNVytLMndxSFp1VVAyZnowWEVyaDZrTDBya2J1OGhG?=
 =?utf-8?B?dnVJWUN0UHlaajJPMUpNN1VuMEpKaXpyMzJhSktEdERFTUFNVFl4ZURBL1Bm?=
 =?utf-8?B?VkFNZFlEVmlCVGkxUTVzVHBhZlpkbjI5SW5rUkJsTnhLbHV4WnNyWDRYczNE?=
 =?utf-8?B?Ykh0eEYwMWZZdFBNeXlzREpXUHExV2hKQSt6RW9oOEVuS2kvN2Jwdlh0WDI3?=
 =?utf-8?B?RXM0bzRYTXBQQzdFM21zN29SbmxDMnRFcFR0T2lkMFlhMWtoWXdVU2g1R1M2?=
 =?utf-8?B?Sy81QUloaldlU2o1ODBwMkdHNUQzdmlEMEpjdi93b1lRcmJzaXRZVlBNL2ov?=
 =?utf-8?B?aFFMTm5Ick1jR1hIV3pMUzVzdG1YOGVhYXRvSmdoWk5TbWJyekh3aHZHOFQv?=
 =?utf-8?B?M3p2TE9JSHJrclJBU3NSZGpnYzFFYStPZjdQSEpXaUY4SytFODhMNC9rK2V6?=
 =?utf-8?B?ZzdkK3R2QS9tcTNtdXk3c3ZmMGFKK2FKaEoxMGtTdUx3dmQwaU93bXpKbUtI?=
 =?utf-8?B?RFRtajc1RTlhNC85c01yMjBudlJIZW95dFdBaW04dVpOdkdoQlIwakl2bmpt?=
 =?utf-8?B?NXRrK2JnYzdCTWlVckdXVE5VL042aHlTSDArVjlFNXNMcXc1RWRET3FWdUpr?=
 =?utf-8?B?YnhhVjhSampRS1EzQjNRb29PVUJMQ2c3QmQxMGMvRmJFdnZZd01QdE0rak04?=
 =?utf-8?B?T0FOMGlwQkZvOE0yek8xSjlsSU1la1JIcStEOTIvYWg5ZithUHVrOGE3NEFX?=
 =?utf-8?B?T2RJeEJaRkhZa29RMmFSRFBKc0plQ3hoU2k1SUZQTVM4dkljcHRMUHQrVEtM?=
 =?utf-8?B?MkN1V2pCNlJSbFZUeUIwMnZZODlwbXM2OWVjWklsK2VkTElYaGRRNVU3d0VW?=
 =?utf-8?B?eHZDdmFhWjdndVBuOXhybkc0UlBUSi9wb2gwaDNMM0hMMGRMUUNkbEN4UkdR?=
 =?utf-8?B?T2Fic0lrQ2dhcmtpWTVYcEhhRmtpWWxVNjFZZTZoUHVKQUZPVXhQeUd3eVFo?=
 =?utf-8?B?NjFMSnN4c096ZHlwb3JPM2FCOTVjaVZPS2VIcmZKTWJpSXQzYklubmhiR2ZN?=
 =?utf-8?B?MklHeGkyRXp6U2lNVnJVN2t5cEtvbXViUmNhMEVlNkRmQmlRQTh2UTEyOVZa?=
 =?utf-8?B?UVlPamxUWnlCaXAyaXIrUDV5RkdmWHBheldzZ2VINXVsRW5WVkV0QTlkRkNi?=
 =?utf-8?B?K0ZONUlDQW8reGRjRmFnbkgrZUpaV2szbDlqY3ZUTVNZNVpBMTN0NHBMVm1Y?=
 =?utf-8?B?alkrSVFld2N5UlhqSWQyTXIzSEd0Tmh6MnRTWStZeHJwUnZCVXI1UTQ1a1ow?=
 =?utf-8?B?M0tPd1JXeDFITTU5cmp1NzZIYktXNTFuYUN2QmVOK3JrMWVlaEM2WmlYVHBD?=
 =?utf-8?B?MEQvVWxsU1psZVR2cU9Ba1V4eVZseHhhQ21SalBlc0NnWGpqU0dhbkRNMVFG?=
 =?utf-8?B?OS85NEhjZlVEcU9ySnNQaVpWUXp2bGV0Yjl2N3JIYWhkQmt0OEVsTzhHQmpD?=
 =?utf-8?B?NzlRdC80NjhZV2ZENVA5RXJTS3BrcXZwdmgxTTZRekhtbVhEb3RrRzJRQjRF?=
 =?utf-8?B?NDVYV1lycGY1NkV2RG1CWFppaXdiYW1WemgySS9yUWpweEpjZ2RYQT09?=
X-Exchange-RoutingPolicyChecked: kF70aGN1k0tKZab77FCVYYomiuXXsc/IXi9k65+8qbDmvOkEK14BVjI2GuNsCoocjjHsMZyAl8h19bdetaSvf8+A78/umyECljlEX0ffT9b7eyOHHXl34wEy0/Fs3v5IAkODMzuWXbNx0OPefsYeLs7EtdWFLsFwjSIDFhQKUGBeqNGBM2atpwyQDIbx8EYCVNVVz7nnmsTJZkF30gIGaW50gB4VzPKPWVVP3H6XBm80MQWMaev7lmqkdyoJVS3R+0oZQj+jauV+hpULy9ZG1IDXmvn1IqlIvkZr+UvJwNX+CDxD7ns1vAPwojmx6gqlYp6cmr3ZjhxL4LKFtMYbRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51779f9d-d881-4f24-c3f4-08defe7bd806
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:28:19.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/z72o35nmAqxlODnyB1hiqTvjmH2mTQHE8W49dF/MjtP+3teLzpIkcezxZifkiLmwEHRa+mBu5B+d3PVX2g9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB307637
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 10:44:24PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Aug 12, 2026 at 1:24 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > branch HEAD: fc02d96a639b5b4ca32bd249e971e5d0aafeb874  Merge branch 'test/acpi-driver' into testing
> >
> > elapsed time: 1515m
> >
> > configs tested: 98
> > configs skipped: 2
> >
> > The following configs have been built successfully.
> > More configs may be tested in the coming days.
> >
> > tested configs:
> > alpha                            allnoconfig    gcc-16.1.0
> > alpha                           allyesconfig    gcc-16.1.0
> > alpha                              defconfig    gcc-16.1.0
> > arc                             allmodconfig    gcc-16.1.0
> > arc                             allyesconfig    gcc-16.1.0
> > arc                  randconfig-001-20260812    gcc-12.5.0
> > arc                  randconfig-002-20260812    gcc-10.5.0
> > arm                  randconfig-001-20260812    clang-19
> > arm                  randconfig-002-20260812    gcc-12.5.0
> > arm                  randconfig-003-20260812    gcc-14.3.0
> > arm                  randconfig-004-20260812    clang-24
> > arm64                randconfig-001-20260812    clang-24
> > arm64                randconfig-002-20260812    clang-20
> > arm64                randconfig-003-20260812    clang-17
> > arm64                randconfig-004-20260812    clang-24
> > csky                            allmodconfig    gcc-16.1.0
> > csky                 randconfig-001-20260812    gcc-10.5.0
> > csky                 randconfig-002-20260812    gcc-16.1.0
> > hexagon              randconfig-001-20260812    clang-24
> > hexagon              randconfig-002-20260812    clang-17
> > i386                            allmodconfig    gcc-14
> > i386       buildonly-randconfig-001-20260812    clang-22
> > i386       buildonly-randconfig-002-20260812    gcc-14
> > i386       buildonly-randconfig-003-20260812    clang-22
> > i386       buildonly-randconfig-004-20260812    clang-22
> > i386       buildonly-randconfig-005-20260812    gcc-14
> > i386       buildonly-randconfig-006-20260812    clang-22
> > i386                          randconfig-001    clang-22
> > i386                 randconfig-001-20260812    gcc-14
> > i386                 randconfig-002-20260812    gcc-14
> > i386                 randconfig-003-20260812    clang-22
> > i386                 randconfig-004-20260812    gcc-14
> > i386                 randconfig-005-20260812    gcc-14
> > i386                 randconfig-006-20260812    clang-22
> > i386                 randconfig-007-20260812    gcc-14
> > i386                 randconfig-011-20260812    gcc-14
> > i386                 randconfig-012-20260812    gcc-12
> > i386                 randconfig-013-20260812    clang-22
> > i386                 randconfig-014-20260812    clang-22
> > i386                 randconfig-015-20260812    clang-22
> > i386                 randconfig-016-20260812    clang-22
> > i386                 randconfig-017-20260812    clang-22
> > loongarch                          defconfig    clang-24
> > loongarch            randconfig-001-20260812    clang-24
> > loongarch            randconfig-002-20260812    clang-24
> > nios2                           allmodconfig    gcc-11.5.0
> > nios2                            allnoconfig    gcc-11.5.0
> > nios2                randconfig-001-20260812    gcc-11.5.0
> > nios2                randconfig-002-20260812    gcc-10.5.0
> > openrisc        de0_nano_multicore_defconfig    gcc-16.1.0
> > parisc                          allmodconfig    gcc-16.1.0
> > parisc                          allyesconfig    gcc-16.1.0
> > parisc                             defconfig    gcc-16.1.0
> > parisc                        randconfig-001    gcc-8.5.0
> > parisc               randconfig-001-20260812    gcc-8.5.0
> > parisc               randconfig-002-20260812    gcc-8.5.0
> > powerpc              randconfig-001-20260812    gcc-14.3.0
> > powerpc              randconfig-002-20260812    clang-24
> > powerpc64            randconfig-001-20260812    clang-17
> > powerpc64            randconfig-002-20260812    clang-24
> > riscv                randconfig-001-20260812    clang-20
> > riscv                randconfig-002-20260812    gcc-8.5.0
> > s390                 randconfig-001-20260812    gcc-9.5.0
> > s390                 randconfig-002-20260812    clang-24
> > sh                                 defconfig    gcc-16.1.0
> > sh                   randconfig-001-20260812    gcc-14.3.0
> > sh                   randconfig-002-20260812    gcc-12.5.0
> > sparc                randconfig-001-20260812    gcc-15.2.0
> > sparc                randconfig-002-20260812    gcc-13.4.0
> > sparc64              randconfig-001-20260812    gcc-15.2.0
> > sparc64              randconfig-002-20260812    gcc-13.4.0
> > um                   randconfig-001-20260812    clang-17
> > um                   randconfig-002-20260812    clang-20
> > x86_64     buildonly-randconfig-001-20260812    gcc-14
> > x86_64     buildonly-randconfig-002-20260812    gcc-14
> > x86_64     buildonly-randconfig-003-20260812    clang-22
> > x86_64     buildonly-randconfig-004-20260812    gcc-14
> > x86_64     buildonly-randconfig-005-20260812    gcc-14
> > x86_64     buildonly-randconfig-006-20260812    gcc-14
> > x86_64               randconfig-001-20260812    clang-22
> > x86_64               randconfig-002-20260812    gcc-14
> > x86_64               randconfig-003-20260812    gcc-14
> > x86_64               randconfig-004-20260812    clang-22
> > x86_64               randconfig-005-20260812    clang-22
> > x86_64               randconfig-006-20260812    clang-22
> > x86_64               randconfig-011-20260812    clang-22
> > x86_64               randconfig-012-20260812    clang-22
> > x86_64               randconfig-013-20260812    clang-22
> > x86_64               randconfig-014-20260812    gcc-14
> > x86_64               randconfig-015-20260812    clang-22
> > x86_64               randconfig-016-20260812    clang-22
> > x86_64               randconfig-071-20260811    clang-22
> > x86_64               randconfig-072-20260811    gcc-14
> > x86_64               randconfig-073-20260811    gcc-14
> > x86_64               randconfig-074-20260811    gcc-14
> > x86_64               randconfig-075-20260811    clang-22
> > x86_64               randconfig-076-20260811    gcc-14
> 
> I'm wondering why we don't do "x86_64 allmodconfig" and so we don't
> catch failures like this one in linux-next:
> 
> https://lore.kernel.org/lkml/annVRNepH48qe6b8@sirena.org.uk/
> 
> Honestly, doing "i386 allmodconfig" without doing "x86_64
> allmodconfig" is somewhat couter-intuitive IMV.

Sorry for the late reply, the lkp account met issue and failed to
receive mail stably, which was just resolved.

For the missed coverage, i will fix the bot which was regressed to
avoid missing important coverage even it can't be tested within 1-2
days.

Sorry about this missed failure and false success info.

> 
> > xtensa               randconfig-001-20260812    gcc-15.2.0
> 
