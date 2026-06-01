Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020120.outbound.protection.outlook.com [52.101.195.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CC284B29;
	Mon,  1 Jun 2026 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340123; cv=fail; b=dZBd5AFXtBvPV65qBhaERA7dbYuajhtDimy8LOPsLt+SIvWH5HbK7EI3GJTp1MoiIYrWSLNQJ8NFw1NkFdm7jb9IrZpjQGAk2Ff+NI02wXVwCqj2u00UjtW3ES52Y6bV5JIEKlw/jYYWKAQ+aNdXdKmUXxWzFHYmxMWMVlpOeQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340123; c=relaxed/simple;
	bh=cVvZQ5fcQFbwEpcWF8dqP3yTkwFQYB+MvTCeo1C+wRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nu3XTKky3cBx7lMjdTpKQqJzVuHzvjiv7+MWav3XxOXdm+m7UA4WMvbsCd+7US4aUAXYjlryzrSPRl0eKUqWQi1RG0gOkR0gVTJy77vSFDf1ArRnK4EUSqH2pvd+5n80L8z9PRCrFcpV53yV8ab81MKaI2X/CdrasRjE99sGzqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0VSGnGXEnv2x26y3DwkHu520eBZ9ZwiAoFBF43lnVDFN11zmKSWNdtarutAU95flOz4y+OlCOS2lAGyO0izKgNJOWEdtWlLUeL2lzkLIzz5S5/WPuW7V+Ns4AyV5JF6JqicUZIi5PBb1nAxFyZquaCWSOAXOZdLkgXKNk6n3DeQj1d0iz+puJiYXmOZiiDkGbPiGSiXbD5OS+snKdJ0l4tUdG3xDwtDoHtxYaqARmxutmVYNGeUbylNTHK7nuhPMz2+Ako7SUypeqFeKtSaVLC+YbEXcI642CEO2NrStZH3nIeWGqV6wwWFBvdb1AjPKNe+7B6Ls3NMvTN+uPGOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GG0RQXV3lk62ujmuokZ6P/j9gGLcS8am1LVkb1lsF1U=;
 b=X9KfIYzLWiFjOap5rp4g8Q8cPJBf0mclUIDiLC6KmRNTUrUMcL+jvKTwZiI6f9zOjhplL3kWJ9XIqVYPeL25nOjE0Gfr6qjYOkbQFKnDq9J2Ej/dv2LciI0XbxV+sci9PAFELH3ypDXB4pcG4mVJCOFjCMfXUaf4MpK6qdD4Qi1NOVgxC6NbWaNKs8SVzvhFZ8HQHDElB3qoE7yDU7B5+TVzyWn+/VKSJUXt4VzMcP1QPrQ0qgEE7yE7Fqs5plJM7flsyw8DMm8QtqoY4Vou8WUeq6SYHkeocoKVzCBrZofz1/VCI3qe/wZAf90ndZvjc6nVOtAU/WBP48Hakx2q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB5884.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:193::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 18:55:18 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 18:55:17 +0000
Date: Mon, 1 Jun 2026 14:55:12 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	pavel@kernel.org, lenb@kernel.org
Cc: zhongqiu.han@oss.qualcomm.com, akpm@linux-foundation.org, bp@alien8.de, 
	pmladek@suse.com, rdunlap@infradead.org, feng.tang@linux.alibaba.com, 
	pawan.kumar.gupta@linux.intel.com, kees@kernel.org, elver@google.com, arnd@arndb.de, 
	fvdl@google.com, lirongqing@baidu.com, bhelgaas@google.com, neelx@suse.com, 
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <76opmfrrzgjgd2m7pnzjdd5h4a3bc3ofz4xwsxuavulnqslsm7@fuirka5jro5j>
References: <20260426160127.292486-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7d25756piuznb7z"
Content-Disposition: inline
In-Reply-To: <20260426160127.292486-1-atomlin@atomlin.com>
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a34602-70c3-44a2-f1f9-08dec00f5257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	PYOwzyfZhbmBCO7A+8TdZrwBA+B/Ao6UZYI+dpZHlGKgrM9UQ4Jw2Dz2ktMBREM96yAVOy4NzSW/0lrR2m7qIamy5vJW3q4Ii8x0Xj54FuRJQEBytGbwidchjx+rdTXP7eeHL121us/OhmJK7I5LFCQRjxU1/G42ZNdLKs/rVvG2B6COz9aBInip/FNCQJBY/ZyWh+8akNHh4tRo5L/LoDzuWQpAD46FW87BMERqN66IpUK47+yh67PDXK2Zfq83hTSeIkbG2l/Jn4Ba302AlHHiYMBD4ZQMKAyO4yl6Ie2/AucO43t7vhrgsyovewaGc8WmGJN9zH6lfxa7O666LztlSE7HqHgliKh9GRdsNUHJWOSyBrAFwizl+8Sj8ij+ujozCovIkR9TalvbKqKA1GyXGa4+JdY/1oQDSpvLa0Rmju8Fx4OysEdp6kW8xIwrL/RNVvvQeWzzVnDxcT8epLbPDC/GKuLEyygBViEiyYdVf+IrGig3g1QFnHclIp8XRB2qqmq/mi6UmzypBzOXHkBgrTFqF9lbEbP3DYbujL54qZYnNeUCnUjH1W5n69ZUre8eSLCYmXrqkqWEWwZd1HhFVfwxAI/HiTGrac6oNl8Pq2KcysM3ZYxQISHOm+dH51LPZzhf4C82Z4ixedFS+HQjyy7YlwEWjt8okCtPrmFxOmb/sTgQEKIlsgasGls2sa6XN5Pr+R9jEjWhatXjlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFRY1c1clJqZUFEbXZlb0dRMlQxbjFjdkN3WFFaeGN1a0l0UW5hWGw4ZDB3?=
 =?utf-8?B?UitodWYxSTJiVk1PeE1XOUJEK2VaY01IZWtRZC9MUFdROU80WFR1b1IxaFc3?=
 =?utf-8?B?bG9GVVh0bUJIK1krT0FpM2V1M1lvVXFYdmNNNGJjamR0YVlRcHgwRFFabEtL?=
 =?utf-8?B?UVNYUW9uM2xFSVBKc2FzeFB2UHJXbDlRMUdHaWIrZzVvUWVleHoxalZLSmpn?=
 =?utf-8?B?SVh1aUx1TUJuVzdyQVpRNXIxRlRSaXdmQ1R6SnFyLzN4S1BKRE9zcEkrZDc2?=
 =?utf-8?B?VlU0LzRlaEVFbkI5M1l6RjlpQUpUZzV3K2htNWhFYlZjcWxDK0FyYzNjSmVY?=
 =?utf-8?B?SjBYVldtdGlLUHdvVVhxMDdyUitoVmtOelpPUEtnUld3Wi9OOGRxZXVQU0JH?=
 =?utf-8?B?dWFvaURXR2xBTFFYZjdZQmFMQlE4M3NnVzA1RkIzdGJOOW95NFh5YlN2UWZW?=
 =?utf-8?B?RVhiV2RwMklNYlU2L2ZHRzJ5a2FkRnJLNGs3bWxKcWIydXRNWlpwUkNOdXFF?=
 =?utf-8?B?cGNRWEQ4dXBlbjVwcHNNVC9BTStoa3pDbEoybkZNWHV3cnBQVC93N0UrVHA5?=
 =?utf-8?B?d0Q3VE9DZHY0WDVEb0EwRGp1ckFEQ08xSTEyUnBydWkyZG0yNUk4eVB2Rzl0?=
 =?utf-8?B?L1JVUExQd0NhOXZrMVVSWUVZanRnak1uc2VqSnI2U3VIbzR0VzFMaTVwWGdp?=
 =?utf-8?B?RVE2UUpZRzJrVmEyZjdDWGVqWFRaOFFSQXl3Z3daRXR5ODZzTkxQak45OGNH?=
 =?utf-8?B?Q0FQZElNVDFUYjRlWHROYW5vWGtXNmMycU91QnZPT3BzWEtsTUc5UzFjYkZ3?=
 =?utf-8?B?NXJiTUdTWWlkQkJnQTlneUpaeERrSjF1bE55UkV1VnRaQThzZVVVdS9oMGJx?=
 =?utf-8?B?dU82MmFyTXgzeUcwWHM5WXZ0eGNPYWY3R3JvdkpzcGRyd3c4ZERQanRDK2dk?=
 =?utf-8?B?SlAxQ24wOWU2MnJ5c2tNQzdpdERDM2VXeTRYVlBiYU1BMjMyblRlbXIyeXVa?=
 =?utf-8?B?aDJZaElvd2tXa3VuejFlSW1PQUpmRTRvNGxtMDc0R2poVEpGZDgxUTRrSTlX?=
 =?utf-8?B?Z2p4Y0U3aExJY09DRnJxczRjVFhtbnpxazZzem1nTm53Q0QyendIQjNlZSth?=
 =?utf-8?B?TEVKeGt0OVRyVFM0eGVpSUg1RUhNRGhiZE9qMmFtRW5rd01NL2VjNkI1QmVL?=
 =?utf-8?B?cG1PVVk0U2E1c21wcE9qQTlFUk5KQmZ6UGJ1eUowWTRrRVpuYm9qWEhHNEk2?=
 =?utf-8?B?R0xwbHJPY3AxejRzbm4yazdYM1M2dlMvYXNVWjBod1ozSUtEV0daN296MnJO?=
 =?utf-8?B?aWpxOWV0NGVwYXdJSXJYRUYxTXk5REV3dVhtd0FMS1FodUxwaE1IZFd5T0d1?=
 =?utf-8?B?QzRnSUZkT2JiTzNKQTdLeElYWlQ1UStWbEtCZXBudk91azN1eEF2c3BmZjRC?=
 =?utf-8?B?OXZjUG44MHdFR2VlTkNCdVBvNUl6czFXQVQ1VFVzQmNDbU1pVXJWU2p0RVZY?=
 =?utf-8?B?YS9YRmhWWlp6N29CUCthODdaYU14SFROUFgvZDQ0RDNwMUQyM0tmRzZLakx2?=
 =?utf-8?B?U2tIek1VTWVHYlpUbGs4cFhEcitBQWpCQ3Q4VTZ2citscVBScmM4dzIranZO?=
 =?utf-8?B?d3VzUFllNmdVRGYwUUNSYzZjT08xcmphTHVRekpoRGUyWDJXOFpHS2dEOXN4?=
 =?utf-8?B?NWRCTmMyU1REY1ZveEs1dE5qdk55dEVCa1Y3MHRMMW9pcGdLZ29vRjhxT0JM?=
 =?utf-8?B?S1dWMWR6QzBoN2luZ3VhM25aMzRhT0cxWFdEZDBaWHhzeW44Rjc5QStneFpO?=
 =?utf-8?B?MVM1aFJRZVBKNjFqZHB4Yjk3bDQ2Z2VaVDYweU80ZG1NL0hveU4vNUNVa2dK?=
 =?utf-8?B?dHBrSzhBVWxKYTZlQ3VXNW16TjNTaTdHZzNHbk9jUFRsaEFlUFdSdjVDdlVH?=
 =?utf-8?B?cW5sRHFteE5xQ2JmS3ZLVXZJRE93d096YlBNWlNvUTFCMWN3MmtIUkVPK1Np?=
 =?utf-8?B?T1hRSWhsQi9INWF1bmRERit1UkY1d0ZMaUhOaS9pNUpieTd2RGxYazl0WXVR?=
 =?utf-8?B?aGV3RkF1ZFVGSmdmZUF5Zll4WHY2TDNpcGlEa29aN2h2SDRMM05JRWtiVnNt?=
 =?utf-8?B?Z2cyY3Nrd0Jxazh2Tll1UFFxM0FjRGJPZE80S05TaFV2MTdNcDdGR3V2WDZB?=
 =?utf-8?B?OFJyZ296T3ZmMzZZSkRmMlhvOFZZb0xPMGdBeVdoTks1NWwvK01PNkRid0Jh?=
 =?utf-8?B?YUU0RkhUMDFubkdYWndjMUtiNkN6WFAxV0pacTUrMFZZYzhvV05WWGFOME1x?=
 =?utf-8?B?U0VDVHhCL2tLZlhjQ3JSZGdDdkYvVUdobTFHeUtKeExZcEdtbGdnQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a34602-70c3-44a2-f1f9-08dec00f5257
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:55:17.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw/B3nSTRPjDFtRKON5jZfs4vB/nJ3cGXzx3IyrvTp9Ypo+m1I4ErqaKIojuqNMgSLSULyYPnxslLKbwcAuRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5884

--f7d25756piuznb7z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
MIME-Version: 1.0

On Sun, Apr 26, 2026 at 12:01:27PM -0400, Aaron Tomlin wrote:
> This patch introduces the pm_qos_resume_latency_us kernel boot
> parameter, which allows users to specify distinct resume latency
> constraints for specific CPU ranges.
>=20
> 	Syntax: pm_qos_resume_latency_us=3Drange:value;range:value...
>=20
> This boot parameter mirrors the sysfs interface behaviour: the special
> string "n/a" imposes a 0us latency constraint (polling), while the
> integer 0 removes the constraint entirely.

Hi Greg, Rafael, Danilo, Pavel, Len,

It has been over a month since I submitted this, so I just wanted to gently
ping this thread.

As a quick reminder, this parameter is highly beneficial for deployments
that prefer to establish strict latency constraints early in the boot
process, eliminating the need to rely on custom user-space tooling later
on.

Patch link: https://lore.kernel.org/lkml/20260426160127.292486-1-atomlin@at=
omlin.com/

Please let me know if you have any conceptual concerns with this approach,
if any further adjustments are required, or if you simply need me to rebase
and resend this against the latest power management tree.

Thank you for your time.


Kind regards
--=20
Aaron Tomlin

--f7d25756piuznb7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmod1YsACgkQ4t6WWBnM
d9Yzmg/+JKAFzWlD/vuLIPeNrl/RCsypVGCz+hQKA1u/IP7uSdSmB1aJ0/mJpsGP
ubbS1dgwknn0H67kWE7bGNQr4GRANUYtswaH9ykl9IFk0AVkuN4IggtIYoxOQdFZ
Hz0ypJJHYm87yywN86Ml89AsSZSy7Hlh8oDPmm5hDbYQXkv++NtkOmx9CTv2s5CM
1rJw472y9/VASHnWCq9WsdbrbB+piOwVdjs0sb+ZWmBxgqI4yeC7MHyvBAC/o/lA
i/x8PuRL7pn+rm+5CwyOXfHhRO6F1ht9qZffoQePXYu7lYNxXAjkPhhiF9Ga7vnv
MpkdSLo7lDpW3cW+vv/O+w9qTi+Ri0eWb6Om+TDBNGKwOzt+SU/5xYEd8+zUUGdO
UQ/YjPzTTKSvTcJWNrwi/wyeLudZWjRbS7O8JTbdGWtAWthVpJUlH4Jbbk5Lqt7o
/9taFwpXcTbKuI9zurm76yq2fFnPE11UMlL9vBYVPjRk+GhmsG9kdaudN2VuLGQ2
O5kx3cW0pjKpLFdlRokIqyYZJJZiwyhf1mUQI0NjSrROG4SKVWNl0j3Ki6/W+DiJ
jhsHxxYoEhXABCHITQXBCIQ0y5xmXIo5Z4NE23qhM3ApCm2UDh9yjgAZzf8P6na6
1gy6XNnYFGnKwB0Xv6pmLm3T0fhHtwZQFYEnrC0K2BVLyZE3w2Y=
=i7E2
-----END PGP SIGNATURE-----

--f7d25756piuznb7z--
