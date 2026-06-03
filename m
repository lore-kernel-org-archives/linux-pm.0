Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022128.outbound.protection.outlook.com [52.101.96.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E81EFF8D;
	Wed,  3 Jun 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448617; cv=fail; b=mzJbiK+/lmMg9htyQnXbqgcsy6bhV2tmoQc2EYpY1AU7MPjtAJKYcpH1gSqZKrs7G5K/o0uAh2ZekDRQwXvVcWed2onosIsdQzcQdyPyOYpu9F8WPXAI1UV76e48lSYKi8JyJeH78Kh6d32lEQPzathOlbyJnGz60sAm98uD6uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448617; c=relaxed/simple;
	bh=SadcGI1V2FjTaQ7iIiAFUBdJyOb0cDjdpLaKWvDlyUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CifGLNdveTtkLd0ZGUUE0ufUdY8MbwLH6XJeRi24otf28+H2rn8UzplPCOHaGFCCUMFYPzfsrfiyMa+vH9AtFtEZC+hJ6tOdTUYbX2Y56n2g9OSZMepjiKoZcJ/+phDzlMQS4BZi684HEEGF8x4XcWLBlZOWVk0YT4t9cF5W2iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RULl/G3MNdzX7DjFHF5jYVE6m6AxEENHTP4O44AruvI8diGp31XDGbmOA2QhQTUrsayTjJ/hhNyXjxRd0wwH5ezvpKv3F3mNXFNLMWGB2qFXHbH2pUitghiuPbECYku4JGwdeCdyLgTvqv4h27KXm1OL7HnSvWNOtf2cSBXtCY4bMIAcOnIm/MO6tCrn5MKsU55+xd/voyxc5vGnGG1+3SUmxi+YgeODGISZimXAgYeEqAfJBsK93/SqYyFRkbCY4aR3lbLjz8zyEu0Fx7t7Kn+wMbsTW7lqAGenQymHnFaDxUf/lnwLJErVnLy+qSBL7AJoTLQMAXi0PbeRcSU7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SadcGI1V2FjTaQ7iIiAFUBdJyOb0cDjdpLaKWvDlyUs=;
 b=L9A2RsVHNJ1Hzf0lgvzEywQNSq3ZHMyhLsNOeOY8iIRibzO2X7Vq8zDaBCo3Dvu4GMocmgX1UlUUlh5xchCpbSV+SwDFaURYjqER8nqzV4wcol8APbS/tUDx51L9JVGd7FzNnKoPg+6CGs64KmiQMWgAL9hCWG42568AXq6H8e5PWvDfdOM+sK03osJyUavaoO89YbKSokJCfc+QxqV4ysCTA3aLYduQ0ZbhCD/sVrp1xILGG/aegT6XD76XnRUSC0/cLcSKV28nGA0ylKMlHActKsyeRCq9siKM6uvev6lP4I1xX530GdG7CfgoiVzdtZvdjOkjSd3yiqI1OEa0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6346.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 01:03:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 01:03:32 +0000
Date: Tue, 2 Jun 2026 21:03:28 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, pavel@kernel.org, 
	lenb@kernel.org, zhongqiu.han@oss.qualcomm.com, akpm@linux-foundation.org, 
	bp@alien8.de, pmladek@suse.com, rdunlap@infradead.org, 
	feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, kees@kernel.org, 
	elver@google.com, arnd@arndb.de, fvdl@google.com, lirongqing@baidu.com, 
	bhelgaas@google.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, nick.lange@gmail.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <3uztb63u72mniljqb2cd4q7cbma2hvns27gn2j2xfm4q4ouuu6@zqyc2wjt55rp>
References: <20260426160127.292486-1-atomlin@atomlin.com>
 <76opmfrrzgjgd2m7pnzjdd5h4a3bc3ofz4xwsxuavulnqslsm7@fuirka5jro5j>
 <CAJZ5v0g4ksMwxqso8nagPO6s59fFzWt0YSv=SJ1ePF1bfgUCjw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3dzh5vcfjlakqfxz"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4ksMwxqso8nagPO6s59fFzWt0YSv=SJ1ePF1bfgUCjw@mail.gmail.com>
X-ClientProxiedBy: BN0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:408:e7::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: df746142-e273-40f8-29db-08dec10bee12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|6133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	H7+UAqeTqJ8YY+O1tf2Lb4zyM9XSrI/hsIzLAVvIe5UEaHzVxjw4UHwHFkcEqjnmPHooNT4vU5lwdg0q2pF20wi+xWpEbGIY5Z+y0dLR4oNI7fIKvOLqLnsFrUySh12gmYmdE5pQza1+5mOexCFUYofMA0RMN5gfV6Fx3Pz67NCKBf6KS5Q4c0nJolbyxeoCnPzsfjbYzx6dN4Cr2PVNrxz4Pl08mnBKOwttexM/jpptS2zNl4O9gBWcKrLG0NkdJjObtF5ErdxdCtnVClJPIQGWggVAsHH0cWXiU4OvAcCfb0R847qAwYEOSfELIiZei4A8vzrAAzlUN2Qe+pgS9Z9HnY6Zsru1i3Qp6obCYofu+XFSvwRVbEOm1LrJjmqm6Lkhogmu2LNHz81VZpCAZMMDSSbcWS5P5UEzGLqr/9AFShM+IQT8nQxFYlKMHF8cCWS2QmKcOQuE1Odum6+MhPWqFKH37n46qTZP/xpmRI9xlrPej8oKAJGrS8gurkrMqgT498Cijk4rAlFR0ezaTP4K6GAlOxp1EnEw+lVtwMBJ2105sNfGEr443iLzs7IL733RjkZqlF8EobgKJLO1Wf+jI+xOL/S6CQbRHc82lJnmX21WUdKT+zgIjfKidgoRRqE1XjgJqccivHTo7kKWOhLuu7QMCyIryyzdjecVsZPriEOycBYaXZDD7gez2/un
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SytuSnIvRm15T0VrRXc1N24zRDVHbDEzWUNvUHhxb2cvMGdsR2tWMmFmbS9m?=
 =?utf-8?B?K1cxMlVvdzVTL05INHZVcjVsQWtIL0ZIRGIvVmlndVBEUWg4ME5kYUdRNjBw?=
 =?utf-8?B?MTNyWlNMZW02eEhnWWlwRW5BQlJBS3hVVC9tek9hVU9ld3NuRHA3eE10VUhM?=
 =?utf-8?B?b0dzaEFqY3NzOWhZdms3RlkyL1JmNUo3eGlDWDBiZjlWNEFTc29iQmlERkhn?=
 =?utf-8?B?REF2NDJ0VnlyaDI2UTEwOWphMFhXT3RMTU80ZXlVZHU1eW53OFlvQ1laYm1B?=
 =?utf-8?B?RUhiVFhKNEowdzIxdXlvcWF1K2tqYzEwRHJXcFlIU3k1aE41M2VWYWxrd0Fl?=
 =?utf-8?B?R01sR21rQm0wV1VGUUdsbDd6aUxVaWdSNzU2V1loVEJ5LzNnMHluTVR2RmV0?=
 =?utf-8?B?UXZldkwvV0g4WjFUZU1DRDJYT1g3dUJ1RVhQSHhwNnZiZW5MZURZaFc1Rnlr?=
 =?utf-8?B?Q0t5amczUW5qWDBHeHlUTGE5M0c0QWhkNGR6VjJPU2lQUDRMeCtSRllvMGZU?=
 =?utf-8?B?YVovUDBMMVFIQUMxaVpla3VKRlllUlFTNXNTdUt0V0RwUjdDdkRYOFl3YklU?=
 =?utf-8?B?allNR01KcmI1aE85NTNXQ1JueXNuY3BNdmh5TmxUcmZSYWpTVVQ2dzJidTVV?=
 =?utf-8?B?WVJOdVl3a25UWGllZXVkdkRmTkc0Wmxodnh3clpObjhrYmtMVTZvK0tPOVlQ?=
 =?utf-8?B?ZHBSbWRoZVU0b3c5SWRqMGZRdlBZVHBzb2RwQ01IbER1bVJoRmpCS0NDVHA4?=
 =?utf-8?B?cjlFQTV4bTRod0JiQ0Y0NnhJcHRsblhwS1ZKMjhxZ2RiUFlUY3Zya01Zdk5v?=
 =?utf-8?B?VEROUVlPbG5NdTRUUy9MVldEVjdpK1Y1a29ESXVCSVVrWlhmc1ZLeGRkdmlV?=
 =?utf-8?B?Y2t6WklSY2JuUTMyMlo4d0NZWTdva2ZJa282aDFSYWxCVHpSeVlFREpXV1BT?=
 =?utf-8?B?dTBNeThqUjY4T2NIU2drenhjb0NLY2ZNclN6cTNDeUVIenVLTmlFUmdYQmRs?=
 =?utf-8?B?Rnl3Znc4MlFyZSs2akRiN3p2cFpuNktvY2RTWTVlRHhXekRyNEhCdGowZUpL?=
 =?utf-8?B?MHVROVVSV2FGbytpMzc0T3lVQzY0WEsrZDBnSFJQdk8xR0pmc2F5SmZTV1FI?=
 =?utf-8?B?Y3Z6RHdOUFlZQVN3ZS9RaU1VdmVYYzRIKzN1NE5qei9zOXpFWmt2cnFLVTFm?=
 =?utf-8?B?T01vbCtNeGZVU2Q5Z04raGxmNGo3cnhFYUNmT2lsay9xK2NTU3ZwWG5sM2Jp?=
 =?utf-8?B?aGxhVHYrZmdFNE5LREtCK2Y0ZGZDSW9TcENqa1VRa1ZUT3c3d0JQMkRYRkQ2?=
 =?utf-8?B?N01ZdU9XSUNtV3lvdUJqOHR3QitaRnhWNkZabkJZK2hKb2lmbmNIbEVRU011?=
 =?utf-8?B?bTIxNEs2V1d5NEZYMWZDOGVHVUx6UzBZTTMwcDNzUVlIZldaeGxFN3Zva0Ew?=
 =?utf-8?B?VVNPTFZidXdJSC9wUjFSL3N4WkFCZmdoS0ROcUVQV2FaSFRhVVQvREVTNzNh?=
 =?utf-8?B?U1pYcjNOYmkvQjJPdkw3YUZ4WG51S1JQanBOVjYxWHNNNWcwWVhZV01UYVgz?=
 =?utf-8?B?anpsQ05ZTnU3QTBVV285K3N6bGRqVGpTZU16Qk5ZcWxmZFBRczdWem1HMjBZ?=
 =?utf-8?B?Uy93OFBlNTZyaXZaZXFnZDhBeXp0eng2SVRST0JPR2prMmlKbGo3SGxGZDZp?=
 =?utf-8?B?ei9DM3dwSDc4c29zTFVUb1pvWm90Yml1ZE95R3BEU2NHdVl2anorSmpDOVBa?=
 =?utf-8?B?K0xXTnFrN1IrNmlFYVlXTmFuRjZGdTVlUUpmOCtLZzBYMDNrQ1luRlF6OWIw?=
 =?utf-8?B?SitlOTJFQ0FxQitaVkU2aUpJTHJMVzdqbTNpc0lXTFk2UGdqdnFNVmtOR1Ra?=
 =?utf-8?B?ekxFS2hycmxuR08vcDRFeW1HOGp2UXV2NWx3WG5zQTJIV1ZPQTViUXFtOHBF?=
 =?utf-8?B?cWswR3o5WS9hcVZFckJieDhLanRlZkh0bHoxcHNqZGZyVGg3MmlRTnZhMnVQ?=
 =?utf-8?B?RFhQU09aWVV5NEt2eEJqOHpUOUZWQUwvRDMxeW1HUi9GamN6aGc2eGV5VzVu?=
 =?utf-8?B?KzY1TENKMTNVUXZHUzY4Q3dCQkw3WHhUV0Y3UzZybUZDUXlYMHpmN3hmSkRv?=
 =?utf-8?B?d1VpOGkzeVhuTzQ3MGJsdTNSd0x6Wk1pMjlldkRON0lmeE9qOUYveUk2czM4?=
 =?utf-8?B?bitMSjlhMmdRRitDUXFUS0ZFM2VpTVV5dTZiaVphOHlhM2E2YnNPZGFqQ1NY?=
 =?utf-8?B?VnB3aVhwdFBkY1hCYzIzbzhrYzVqZ3YrMU44WFp2MGRwdG91SThQaUVwUjFl?=
 =?utf-8?B?WHROc3Z6VmVMUCtXQkRLSXp5NW1meHBkMW1OMVd0TGRJanVpKzB6UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df746142-e273-40f8-29db-08dec10bee12
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 01:03:31.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Arz2+b7K/O9mdOL7ZDK2ZDaHh5IwVISBOtfx01NoPpr6L1ApGAc5hIMA+Nj6Mc9qm/lFi6n08mO0qSnI4qRQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6346

--3dzh5vcfjlakqfxz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
MIME-Version: 1.0

On Mon, Jun 01, 2026 at 09:08:33PM +0200, Rafael J. Wysocki wrote:
> IMV it would be better to call the new command line arg something like
> "cpu_idle_exit_latency_us" to make it clear what it is about.
>=20
> Also, generally speaking, it should be part of cpuidle rather than the
> generic QoS code that also applies to devices other than CPUs.
>=20
> > or if you simply need me to rebase and resend this against the latest
> > power management tree.
>=20
> And that too.

Hi Rafael,

Thank you for your review and the constructive feedback.

I certainly appreciate your reasoning concerning the naming convention and
its current CPU-specific scope.

However, before I prepare the next iteration, I thought it prudent to
briefly outline my original architectural reasoning for housing it within
the generic PM QoS code, simply to ascertain whether you remain of the view
that cpuidle is the most appropriate home.

My primary motivation for retaining it within the generic PM QoS framework
was to maintain strict symmetry with the existing sysfs interface.

The parameter is designed to align precisely with
/sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us. That sysfs
attribute is exposed and managed by the generic device PM QoS code, quite
independently of cpuidle. Furthermore, the boot constraint itself is
applied via dev_pm_qos_expose_latency_limit(&cpu->dev, ...), which is
fundamentally a core QoS API.

Should we move the boot parameter parsing into cpuidle, the consequence is
that the cpuidle subsystem becomes responsible for parsing a boot string,
only to immediately pass that data back into the generic PM QoS framework
during CPU registration. Keeping the implementation within qos.c ensures
that the parsing logic and the underlying data structures remain cohesively
in the same subsystem. Crucially, it also preserves the flexibility to
extend this syntax to non-CPU devices in the future without necessitating
further refactoring.

I look forward to hearing your preference.


Kind regards,
--=20
Aaron Tomlin

--3dzh5vcfjlakqfxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoffVoACgkQ4t6WWBnM
d9ZBPw/7Bej+Tj/C8zgWSrbQdj2kS8XfH7xVIqoh3+tEc9mqVxBi0QZlS2US2Qda
I6Br5+c0uD+20nIi3Nf6DrFUVjImvKT+cXd5yFS/6NaTmuEP3/cWNjYi7HQFNYD3
ZOvxFS7utrZeK+MsglmlO9e9jqNW0t0FUJug9gcZZCi5s/DcBTZD19Mtc0WyS7pE
/wg9Zi9/RFSZhAeRPdYPhfN2ATvOkmMyzvdDJQKVkoP2L78TYxmCPjsV4XPZJ37t
DeQzBgap7n5qKZCpNWm+g+273BHFxW+Plq1ds0faOlS4iGOSXaKQfJhmbOM+tWLI
UOXnyvwzKwNebPpakwsnJbVBvUu/oJI2i+L2LQc6ue38OryfyV/q0ljrE5wqYJEo
zlE4nnziB1Hinh8ZYT+Tgw5//k8lZbci/m2DZ1vAqKqbn0Eyx/z0pHDx7hKTWyzp
jyDflUVi/fAl6iDNmvzDH0sJ2yShQrr7PLe4Y8hDUjl+Bf149HP3kryJYUUwOk2p
On0e0Lt80IBWDxrWddC6ameuBogUW/yrIBEUBPI7Q7N32INmbl/8dlVDUr9leGWn
gaSIEpdRorcLT4iGw1Orteh4t0lVcBcAzo5TUkRc/pPfdafCxLLywQl8iRp52d5Y
ARCklDm9wT+h/MgfJapcOxIWvfT9yhHU+r5XHyDKU+NFKwI2rAw=
=BzEc
-----END PGP SIGNATURE-----

--3dzh5vcfjlakqfxz--
