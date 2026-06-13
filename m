Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020119.outbound.protection.outlook.com [52.101.195.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D0380FFA;
	Sat, 13 Jun 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382830; cv=fail; b=bECiHIK5NwDgxMgOzhBMFcm/dOoIOTpfyto33NGgs7hXNIVueDRDc77raYBmjx+Vw4WSohpNLmba22twOS+w5joRUhjMMDivcRzqL9LtDOgvs0qyCLoEB4obToxd1thQp9SYelM+K2nv8NEeWmLfSQwnFy96glxEg5bcoEyLUi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382830; c=relaxed/simple;
	bh=C5qiiKnXUDoBhFdSHEmLJ584u8IwR2d04fnZeWcuiRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NKjZ8djI2zAnMn3ZF0Oe/OVPQ/189MmlJL1IBMY/z681iDGXpTaB0mT9ICSZJw+NrsEnNvAEaRI5BEk3RcFMCfBzKKm5KNFUFbP36BNWGpSsYjxY51uuoFNVbqSc6332A+NZ03Y/qv0MbmDtLTi80ec1IsrHR8nLdBpES9urKqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXFVAw/8NagJI8XgUbIX4jZnaA3dypStgnUjWnNfFVT2wjKKiOfAWaLySosoZpgGLRHzDKfsooz+1yjlP/M7Gao1Hgo4oM6soviRPes0m9J61OrgX5uGofDSgI1aDTVlqRydjxoRR88SU4sAv5+3pk4lxAeSM9q6mYW52Bc2H6bDGYpRfzVIcWR2D6n/oMtIRTbebiJkFadiE+2z7rxebRuYKV7bAAo1TKBNTiybqsBgOELob7i+HAZxzHWBhLZ7NbuNHHulsLqLpFEZ+Kxn4zAe/I5cyYA7PgVyPTB3RBU1xWB0abwgib5hDExYglTGRVVaySEr+Hqg7csBAPGlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=C5qiiKnXUDoBhFdSHEmLJ584u8IwR2d04fnZeWcuiRw=;
 b=rTgw8OJx6dxyHFxXjRgg8F8l98hwIBq4ef8jinwz/XLnfTARA0bJbBBLv0AorHWWSqU/0O+yYjbWkr6jrnptPl0F2zmFdkKOCQLYG5XihOfARZnxlpHn4opUeqXl57S2nwc1One3m4T6/yCAtRCqLv7abErIWhDIVoFuqx4f44lCNHgKls0ODhhY++TjjNlQdTERAGNKwnF0AulFa6ey0bKCUSS3lwZR97pKiACcEGr19+mI+4oUwl7J5XgYEl9CEX9B/jFtRfXAqWjviUc//UEV8spAJu1U0McEmzdzlew6qXauRQhy+vHnjMdPE57kCC4mjXRQjF+LWI10dcTMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6831.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 20:33:44 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.015; Sat, 13 Jun 2026
 20:33:43 +0000
Date: Sat, 13 Jun 2026 16:33:42 -0400
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
Message-ID: <rl6tnqrym3nqhp3as6owwccabjik2mnlunu2nnlafullsozwet@buftmawjay2p>
References: <20260426160127.292486-1-atomlin@atomlin.com>
 <76opmfrrzgjgd2m7pnzjdd5h4a3bc3ofz4xwsxuavulnqslsm7@fuirka5jro5j>
 <CAJZ5v0g4ksMwxqso8nagPO6s59fFzWt0YSv=SJ1ePF1bfgUCjw@mail.gmail.com>
 <3uztb63u72mniljqb2cd4q7cbma2hvns27gn2j2xfm4q4ouuu6@zqyc2wjt55rp>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvd2m3iafalqar3u"
Content-Disposition: inline
In-Reply-To: <3uztb63u72mniljqb2cd4q7cbma2hvns27gn2j2xfm4q4ouuu6@zqyc2wjt55rp>
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 184392e3-3943-44f3-2c5c-08dec98b0faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6i+3tqEh6fDiT/AiJtZhskr+oPEm0oV85eHrOiiWvG/sBaULxvN6Ge6B9H7pYa/IzU5y74PWRQUvTGza83FspOXuLgxWvzZKwCt1RMzilrOxgOkNaAGm2+Tb6SobGza4pekqqNmw9qqMG0YO8ZJT1PvgeSJ/fzKyYgTGZ5X4PSrI3yZxt/w+ZrNBLhzZXbjwBUe+97Gv9HlIeMgDGz20qsQ1gL+G+h0A/hMWj7Jkf0idhTDxz3Uf7yZzZab2juiq3XykxnDgGPbyPk8zxfLc7mKZ6hpqXY0TjREnBQPP+kG08g2JyYYtTwaImnQaSqKvVvdSinvabENTKtXCbCy3RIzfyZkd/EziYU1lT8LuCd5K+C4/I2YDPmXsNuqJfkBcF6qbtNxS+73c2tWzutS7uSaGzrmh7LgZlR/tS2uGqQYg4v47ZSLFPexmoJK1UkmnW6PVu7Wb5+waiNaFaBVDVPFyEo+CqAFcJNtumcuEt21d3iRicDqr72AoYuqmC2km+fcbp8ZgFiVjPibmnn8PkqvnO54nLwwWz0Kl1pl4f/Hx5bEUYq+/M8y/vMIKxPQ6+VswjU11L+elBlPaZfZjUwiog1i1ZhyBRC9+qtPH/Ny3uVkgpUKbEoFjWg5f/JWjykPRL1cYvS/OEaarqzp1pOX+eesnyKGPDfFHSM/4LFflobETpUZ7BfOB1lp3pwJ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDN4WW5KR2pWU3ArUEZJdTNWcklsZmc2dTRVTURUSkRHQ3NpdmM2aE01S2wz?=
 =?utf-8?B?cEYyUTdrbGRrVkErQU9PQ09sejRKRndlclQ2Vi9zRHdJc1RIRWtMclAzYmFF?=
 =?utf-8?B?cUpCQWZzZWtTaGwxY1F2eGNlcEtmQ0dIZDJZK0dLZHFReVRFQ096Zk8zMlRa?=
 =?utf-8?B?R3NwTUhhcDJCWHU2QzR3WnRCWlRUTk93KzNncDIxcWhZR2VsL2xvS2taNlpT?=
 =?utf-8?B?KzJZNTVxMHBHS2VGNy9GbDhxRDNKdmswQ3draUF6Q2ZPTmlsb0k0VFk3MWpx?=
 =?utf-8?B?Ujd4ZS9yMEY5SDhVQTY0SlhFQ0pmSTZ5WUNJRW8wbGNxK2grK1dkdnR4RWpR?=
 =?utf-8?B?NTZTVGpwc3dLTHp1VHloMmFFajJQUWwybkRxS2FFam52RStybURuRlBWV2lp?=
 =?utf-8?B?OFF2M3BWbFd4Z3YvV05iNDRjM244Zjgwc05SOW4wbzZQVmppY2MvTWZaWTJN?=
 =?utf-8?B?bThHdGIwYVd2aVBhY2Z5TC9CekxVSEp2RjNsRkhYeS9QcUwxeUF1cGRkWlpk?=
 =?utf-8?B?L29hWVRXWnhEUndBRm1vQnRmZnVIbDN3Yk1hZFZidVQ5TXhsbHBaVkRtUHB3?=
 =?utf-8?B?MlN5L1JQQ3d6RzB5RWtMd1FWbVFweHNGT0JmVHRwTXlnc2U4YjNRa2FrV3dX?=
 =?utf-8?B?dStGeVRFT2JaZFNqQ21zUUJUWWFTWFNNcGxwd041a0lRLy90VEhlakpYRmlh?=
 =?utf-8?B?Q0dORXJ3ZENLSkUzTnRQbUxxMkpDc1JncmhyNnFoWUF1YUNPVVR6eFNFNnpQ?=
 =?utf-8?B?aWllNkpDWXo2dTVteHJPOGhPbzJQNUVPMjdCaDQwcm42a0xibitSNmtFVWJh?=
 =?utf-8?B?VDBtSllZZ09MdG1ZTGJuVVFHUHU2TWg5dHo2bmhQWXo3eGtqQnFRNWwrQThl?=
 =?utf-8?B?SGpvaFluSWIvM0VKcTJsTWhuSSt3QVNDYkowWkZvWlkzUGdsWHRuTEFiRE1D?=
 =?utf-8?B?N2tYalYyMnNtU0FxSUpMbSttNEROVVZIbHFaV1JCbVIrQlhUeml6d2RHWStW?=
 =?utf-8?B?YzY3QkZRWDRLVG9rL2NEVFJIOEJFSDkrUzVUSk9Wbm5lKzBaNDF6ODlDRjM1?=
 =?utf-8?B?NFRFdFh1QjduQ081WEREWnNzL25EZ1JqZno1bCszOWtBU1YySjk2VE1NVmc1?=
 =?utf-8?B?clZ6eUxZeCthazVNYkJpcDFEbjhsUzQvOUNXU2ZjcCt6R20vNHczdUNDYnpW?=
 =?utf-8?B?dDluNjI1KzF3YWRhUVoxUW1yN1FQaUpaQkxzMmpONkJkRDRQT1B0clgrVmEz?=
 =?utf-8?B?MEtkcitBQVhtaEkvR2RIN2wwbGhaL2ozbXdFa0ZIV2xyZk9QdzdmcHV5WlRM?=
 =?utf-8?B?aTJIWmdDVTNxUzFsQk9OWGJVVWtlMTlrc0tIbnpuU2phODh3aGpUOVhEUkUr?=
 =?utf-8?B?WmFNSjMzMHRBRXlQaGVxRDNBL0tyY096ZVp1NkhBMk5sMEtNOUtnODN0OWU0?=
 =?utf-8?B?akFMMTJpRVRWNVk0Q2hGZnI3aE1xbnFjcmxuOUV3NjZYWkp6OGFWZDlvS0RS?=
 =?utf-8?B?anpPUU5zNDJQbjRLUzM3RzRORzhPNGw0VDNBZmtVSGcxVUV3aUlhRzR1TENH?=
 =?utf-8?B?SkxZV3NmbVBKSE40Y0I3MmRuNkp4a1NDZXlSd1RaNmpmWnE4WnRqU3JoK0RG?=
 =?utf-8?B?bmpNbUw0Um1mbTB3R2t1ckJRNXErNGFqZG1SdkJOamY0eTc1M1pvSGtqTTBi?=
 =?utf-8?B?VDVMRERHWFdxY1QwL3RVdkFic0RzMjJjWGJnUGhLeUVkK1pXVDB6SUdPNVdn?=
 =?utf-8?B?ODdaM2RJNnR0d2JTdmlpV2R3L3Nhb0ZvZ2VlNkMwRklWMW5mYjRQTVhjdG44?=
 =?utf-8?B?MDFPaFdEa0tLZTNndmJhUzZEaEJjY1ltaFl5UDZJZktmWEJOeGhLV0tUV2FE?=
 =?utf-8?B?RDdWWXR6N1Z0cXVRcG90cm9TeWlNck1WeXROdk9OdkF5cXppRFpJc0JRL0My?=
 =?utf-8?B?N0h3TkQvTGtBamhYVVhRTFRabHNVN0xLSUlIODZ4Q3ZMdFFGMS9ZVUdMZ3Zl?=
 =?utf-8?B?ajR1dFFqdXFIRjZKY0VPNXZ2SXBxWWRWV2lTUndUeHMycVN0MlozdmFpdThJ?=
 =?utf-8?B?cENQWEw0TnQxblQvT0EyVXN3eXNSVHRUZlpaN3paM0xRRmFhQVNZWFMyaXNw?=
 =?utf-8?B?NngxVXhrdTNRcDU2WUNHbkxRd1F6Z2RUQmdBbDdYNEo4WFJvQXI5aHpYNGxl?=
 =?utf-8?B?VWZzVXA4T2dDV3AxQzVmN3BuMG0zWmplU3lvUGFkVUx2N1FsWUI0VGNGVmgx?=
 =?utf-8?B?dTNyS0Z3UW51bXBxSjVMSGdWd0w4UzRLb2w5Y2c1eVZFaUdvT3BkL2RjcFNR?=
 =?utf-8?Q?S5kUlOeyBkT+7CFZD7?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184392e3-3943-44f3-2c5c-08dec98b0faf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 20:33:43.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfFp9Pu3hCkZZKQJCcCAe4y5lGD6uuEEVDHrCI/rI+4zI+Mp49KAIJXxGY+RAUscenFwQ8z5xuyIJcWRMQWaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6831

--cvd2m3iafalqar3u
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
MIME-Version: 1.0

On Tue, Jun 02, 2026 at 09:03:28PM -0400, Aaron Tomlin wrote:
> Hi Rafael,
>=20
> Thank you for your review and the constructive feedback.
>=20
> I certainly appreciate your reasoning concerning the naming convention and
> its current CPU-specific scope.
>=20
> However, before I prepare the next iteration, I thought it prudent to
> briefly outline my original architectural reasoning for housing it within
> the generic PM QoS code, simply to ascertain whether you remain of the vi=
ew
> that cpuidle is the most appropriate home.
>=20
> My primary motivation for retaining it within the generic PM QoS framework
> was to maintain strict symmetry with the existing sysfs interface.
>=20
> The parameter is designed to align precisely with
> /sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us. That sysfs
> attribute is exposed and managed by the generic device PM QoS code, quite
> independently of cpuidle. Furthermore, the boot constraint itself is
> applied via dev_pm_qos_expose_latency_limit(&cpu->dev, ...), which is
> fundamentally a core QoS API.
>=20
> Should we move the boot parameter parsing into cpuidle, the consequence is
> that the cpuidle subsystem becomes responsible for parsing a boot string,
> only to immediately pass that data back into the generic PM QoS framework
> during CPU registration. Keeping the implementation within qos.c ensures
> that the parsing logic and the underlying data structures remain cohesive=
ly
> in the same subsystem. Crucially, it also preserves the flexibility to
> extend this syntax to non-CPU devices in the future without necessitating
> further refactoring.
>=20
> I look forward to hearing your preference.

Hi Rafael,

I am writing to politely enquire whether you have had an opportunity to
consider my reasoning concerning the generic PM QoS framework.

There is absolutely no urgency on my part; however, I am standing by to
rebase and prepare v6 as soon as we reach a consensus on the most
appropriate home for the parsing logic. Please do let me know how you would
prefer to proceed.


Kind regards,
--=20
Aaron Tomlin

--cvd2m3iafalqar3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmotvqEACgkQ4t6WWBnM
d9YPXg//Yoe1yESCBv1bFgomehDdkvfJ9PWs12AIIZtqEsdgmoqXWZcx/2yYJdRE
lxDY05ID09Hno1NvSKOO7wVLZwH5/m0j1exSV29xfVF2PvBr3K7Mn+M5LiFLEN0k
hwgiwJsh9D5HfspRiex8l/LLBXxXjS1zF573df2ZkFpxR2q5WjOnug+McSazIehK
nf+QWYot11QpgLCSMetbjRDkzg9SDhTQxTn+uk8GY73m4kzbXlLfyxpO9Nq8atxe
wroOrRbRyGMoiUoNDtOc3XYw8DqAyc7UokEbM/pxBLoLrN1f29DLR38wlZ3tt+cQ
BFLS5+FBWZBDZT212vvgV5mSDi2/HCOl72PyEdBUQMj5fU+BVAwXr7aIoh1ShtSJ
kM/mhHzm03ldRRA6JF2QBfZ/F2NTMWrvQvf+81vhumJj2ScEHfI0ovNKLwfJUJdg
i3he/EDSjG207PTRH84Coy0lNLPKt+dg8NPNBGy0fjagcfhtpuhFXoTr78j6nnR/
c1h4Qy0fTgOZ+M0c/xhzjazTKd8E+lz5yirKZHFrvhV20YwA0kvO1+JYPUCuG/Wh
66ULne+8Hlz62nthVKESXxAJRqf4glHwDxBRY0wKktjL0+0b78GXr9tkHBRUFuxq
PLPSKv6r8viIcs3P5G0y0hkbABqlRgM6hLLEEGTiclWXCxebzIk=
=A82E
-----END PGP SIGNATURE-----

--cvd2m3iafalqar3u--
