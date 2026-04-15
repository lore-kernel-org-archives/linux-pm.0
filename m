Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5C393DE0;
	Wed, 15 Apr 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266615; cv=fail; b=XtvRzKwtM08P4ztwnQXLibAgM8a91FyUARch6cr2VZ6XkKFpSWzhkYvcayZ5e1j/xnQvphi8AAxcujQGRU+XBlCXOyE88mltRyKppmGBiPFg3izj6Afbi9L9DXfynGAk23h523eblIozFy9HIckutffRwa+3V37FCEAuO3+dJs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266615; c=relaxed/simple;
	bh=qrHHCw7icTaY3JhUr9RQsLwfvlrdumcCjeCqL19U1ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YG3JnRY0Sha7xDVlcph37+hptQED47q4EhfLhCRUFqzk4GkqDcCOfvD952v3tAN4KXMmNkhA0zcNZjK/KIqWk9Qha1tNOiL4abV9yEanTqYwGGHEqPX4P0BJ6RmbmfTO8naNG/WJ/qmW64kHyu1qOiYyU2FhutKOE7F9KPB+3V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1W0VKI6Db8Z/ZFKxLMZxQI6zJEChKX7S4flOk1c3b3NRT6bphcSQQYnkHx6RVaSXbux3t68oZwoiyNNJUb4bKaXE7OlIhQZg/BahAeQ1R6AmJQhJnrfEEQ65yGIyK8ddYDA+jlCyDQKmdVMZAk/FcBhax8lYOU++oiJLHjHW/XY01igI5sBEbXR4IOjlAHvBUjxGTV8kavndfTah1ZoEowewHPlP9p0icoSPgacAPy5nJNXFDhCPhqf/RxbMHgK53BRKkML060cnFcJqHlvmLr8acx/oXdbBT3qWm9/o/qvITSZLEDfY4icJZSCrOGmDlnHVTrQ7tKVHSnX4hS6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrHHCw7icTaY3JhUr9RQsLwfvlrdumcCjeCqL19U1ro=;
 b=K9ruGlyBpGl6jda25QQG5UE58prKXsvUg3IfjuaPRT7ZppfZ56T+CAMjDkbA9ejlv/0Sn8sOgdGTDE/ViCzUr+PPPpYPtrBJoe2MoNzkUZYy/jFc6kD3HydypHOEkbOi4zdaJmLXPqf8Bi2a+RBocjWyf7A+TTtWEWGyNtoN3aa2+yHEJbvrbfQW4tL/FdkVyjmL83UoT4S3v0VQuaNRqfLqTs537ORiHhC8n/Lb6DK6lci4jngKy7B4vK2yO5gaS0S0RAsh+xXQnQbcCwazi+Kn9c9N2FgecNjKjaCnxC8ruYq0cT597L8T53ECFXpWwElZejLkcbxziomTELPdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4241.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:23:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 15:23:29 +0000
Date: Wed, 15 Apr 2026 11:23:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org, dakr@kernel.org, pavel@kernel.org, lenb@kernel.org
Cc: zhongqiu.han@oss.qualcomm.com, akpm@linux-foundation.org, bp@alien8.de, 
	pmladek@suse.com, rdunlap@infradead.org, feng.tang@linux.alibaba.com, 
	pawan.kumar.gupta@linux.intel.com, kees@kernel.org, elver@google.com, arnd@arndb.de, 
	fvdl@google.com, lirongqing@baidu.com, bhelgaas@google.com, neelx@suse.com, 
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <j4aaft56kpkhiucjshtc4bkyhbzs4n62rqqihjaebwaknm45oj@dsrmbg56cym5>
References: <20260308190421.46657-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="amoh37pdovgujyce"
Content-Disposition: inline
In-Reply-To: <20260308190421.46657-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:408:111::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: e87eaf7c-9c63-4c26-00f5-08de9b02f21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yzfONVOCRkvR5/Z3LI/qHH1VGKJ3v15oiK5VnLr/68T13ajlV5r9rKtnUg0xn2aS/DtlsdqdpoddUy3ym4Wj7ojIBIrLo6mCeWUIqXQ2NR7hKJWof31dTZjCLAy9mVEBF920ih7FXnP2oG/mUVIop2C2D2Fi1iGy+aAa/qlm/4BRhfby+OoJI1xHeiNeNaajoHXePmZqJi6ZXFS/MhVJ0bOjb8DnWMG8K6zlF78Pcu8hR87wfbBzX6aOMtvmZbwoYhjCUCdaYQOFf2m979xSzVsCPdTvNkv7gjs8sQUH3Qz9OVLog+sD80/YjSiksnQ/Pivep4Jqf+Ru+TwL++dNadVQ9mCx9OYoXWCHvHJbPBKCshmjCK6JCYlNrZBlgj5aFqsym9qum7PJPYVdMsV6MiAUdYbQANR59Uff92c3UJ1tG/7k+tGlT6azIpohjtXM5MiCM87MlkuI0rZW+eddM1+AUIxfEUx6ITGJMYqNYqHPLT3C1T7079GQujR1lHkQA1kNZiMZ1GwFzcjy8kNQbHD7YwLcvNjWYv9n6VjhJuLxuPX+1JoxcUY4l36EWlEcEO4PdTpB9fYuejC9aqy6VFyaZSgBAiRAVZCNwLPqxiCnDnxH9YRuomeBgsn76KCuN7MO5Znl4SvHkgK3vn7ep5CNGYHS6uBl8/dCsL0pvkF6iOyEabcy0z6BjSvPYEcWkPpYKMxsVvFtH9VydlkVGFfhO69WJUKG+sWISDLKOi8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R01oSFNCUjBPOGE0R1ZINWpSNEtHV0l0ZnpuODdvVlBtVUN6ckRWUkpUMUhX?=
 =?utf-8?B?OEc0dytpNE5mREJ0ZFMvM3VBeVJKdFQ2QXp1b0RnRnA2aFNQbGdJUi9vSmZt?=
 =?utf-8?B?aFFSNCtQZGlsU0g4VE1QTElZNFFzWGNIRFdaRTFoZEl4T1labUprL3ZyOXR4?=
 =?utf-8?B?SG1mU3FSNGpoVEQxQmJ5NTRXZVRUN3R5MzFkWHRUL0ttYXlBQkNDaGxkVGdX?=
 =?utf-8?B?SGxGWi8zcEMyS0k2NkZuSURXeG5qL1hDOGxaRTIvQ0Q3VFFjZXF3NXd3ZUM0?=
 =?utf-8?B?bExBR3oyNXcwUE1sOCtrNUV2VWVnQ2lhS1ZhTllKN01lOUNXTzZVWEFPcGZp?=
 =?utf-8?B?UjVqaVkrNjJuZXl3anlFUXRCOUJhQVdCeFRZY05oanZqRnZIcmpFZlRrc1FH?=
 =?utf-8?B?a0pVajVic2ZIYUJBOTNad1FPM2ZaUGFYTk9FQ2tLN1E4Y3JmekVzZjJhaDc2?=
 =?utf-8?B?MHRiU0ZLby90T25wRmlnU1d6RzZKVVBKRGdBblZ4WXFhZUtWSSsrK2g2Qm13?=
 =?utf-8?B?UDkwUFpBdGV0RWlzRFJxNzNDTVI0WnM3NDFiNitSTitTZzB0dmM2OTRyOGFl?=
 =?utf-8?B?d25YMnkzUU1ETWladDU3RmZXa1ZLVWxxTkZoM0gzTzN0eFBnREd0SFdiWjNZ?=
 =?utf-8?B?OGNiUTVzYnhGQWFEYzRSZXVYQ3dXTXR5SnNBdG9XWGlKNGVFRVB0Z0I0UEVY?=
 =?utf-8?B?ajdVWnJqdTZ1N1UxUXUxdTE3eWpxcm1qbnU2Z0diRUNraVhUZUlaSWdZYkZU?=
 =?utf-8?B?cmhpc1I5TlFVWmNTU2l6SWxSeUJVaUFNcEkvd2swZms2UnMxL2gyd1RNMERr?=
 =?utf-8?B?VnE3azZDWFEzWGM4RnB6QkZveG1BSEl1UWVHWjk0MUd1SitTcjRxTDZLNnd3?=
 =?utf-8?B?MmFtNDh0MHFuQmI2ZDFHVFVYbDZteHlJUDVMYWhmdXIxclZzVW5qRGc0Y0N3?=
 =?utf-8?B?UlZWOVZLTjg2czlXbjA2UkNxSFhjQndVeGFnbGU5d1htZ2xHbUFsQ3F2VHgw?=
 =?utf-8?B?dFFVQ3RjbUNyLzF2RjVIWk4zWDVGbUpDYkRWeXo0WDFDNWlzeGt5Y0w1ZlVy?=
 =?utf-8?B?RHdwUitSK3F1SlcyN1B4ZXRUYllNSFlyMW9ST0o3U0Q3bW1kWjRRcWVtazFW?=
 =?utf-8?B?WnMzcXpnS1dScHhHZHB3VDZkbVczVUZSRDJJNFZWWGtOYUR1TUVpN3J0RURm?=
 =?utf-8?B?RkZGWHZaZ2lCME84VGNCUHE3RW1VTi9oUUd2cnNtQ2VjZ0xlWFVxd1lFYnJN?=
 =?utf-8?B?NlZNR3o0NkF2Q0FJNElJWWxhVS8yM0QwTG5uWlB3VzVHU2VSZnhzaVhTT1gv?=
 =?utf-8?B?MkY3aHNIeEdndkpaOUpqVndWU3FxbUhpdFdnRTFta1NPSjN6ZlpyYVhGaHpY?=
 =?utf-8?B?clhnUXBLbG5HTFhVVm1DN3IyNzV4TkE2M0N2cmRZdXNiTWV1SHcxa3AzR29S?=
 =?utf-8?B?b09raWd0RVFjUnBzV2ZHM3E2cmR5SmIvV0RQd0k5bXdVRDNqOVBRZzFDb0c2?=
 =?utf-8?B?UlE2OUdMZVRyYUVLeEYrS21kQWNvSGM5UDQ4TTRLSHRGTjVhRkJTVEJDWlNr?=
 =?utf-8?B?dHRtVnRIeVZIU2ZnZGhsRmJnQjBEUnNlT3Q4RzRQZzlvd2tmWjJpQnB6dkJZ?=
 =?utf-8?B?aVNKQWxCdFNhYklBUUpDSy8wY0N2WnQ0Wi9oT2xnRmlrd1p0QWJuMkxtM2kz?=
 =?utf-8?B?ZGswY2w0aHB3NWJucVZUUnNpd1d2c3RKRXIzL3F2T3prR2tzSWVhY3ZJN245?=
 =?utf-8?B?YnNQc3djQ1l5M0ViNEdCb2F4cE5EWWFjUmlLS2xsRTNPWU5wS1RVOHc0ZGxa?=
 =?utf-8?B?WHJaMWFkM2pJbU8xdnhQc2xjc3h6YUhrd3lYTGdnNFdONVVMeXltSFo3YTlG?=
 =?utf-8?B?em5XRU9uWEtPd3ZrN3ZOOURZbmZLM205S2RkZjNvU1VicWN6dEdycDdibEg3?=
 =?utf-8?B?NU15SG9oVnlyVjdhQUhSM0NlVWwzakt5YU5CS2k5OHZjWnZJN2oxeU1TM3Bt?=
 =?utf-8?B?VDF2bnlQdDFTRDlZQ004MndpTTRxRCtRaEZnWVRPRVM5MmtnUUcwSlkzcjQr?=
 =?utf-8?B?NFdCUWZFWWpQUlNiUytMMG1waTRqdCs3UDI4V0V5Q05PZ0tZOFY3eHFWc2Jz?=
 =?utf-8?B?bU5wendybnZwdEUraUF1Tlp3TzBwcFIzNjZHQVZUK3cyR1lKanBFWDE3K3dZ?=
 =?utf-8?B?MkZxM3NYV2hMVjE5dWZreGloRVlLUkdaa1VSb1J5YjNDYlNRNVRWQkJLdkRU?=
 =?utf-8?B?NzJhcGEyQlVTb0M0UDZUYUdUOFdvdFNMTFd4UmVmR253aHVsdWM3TUJuOEo2?=
 =?utf-8?B?Yk5MRXcvVmlxeU0vMjFMTUhxRElPalI2UmhtakhNT2ZPQU8za05tQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87eaf7c-9c63-4c26-00f5-08de9b02f21f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:23:29.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOOg6ydaBxkK25ll085MHwNC9E8nyUU+PZgejiO3CDrWfHU1a4XCQL96CFR/GQoeK6WMDMyMt7eN3XrgWYkwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4241

--amoh37pdovgujyce
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
MIME-Version: 1.0

On Sun, Mar 08, 2026 at 03:04:21PM -0400, Aaron Tomlin wrote:
> Users currently lack a mechanism to define granular, per-CPU PM QoS
> resume latency constraints during the early boot phase.
>=20
> While the idle=3Dpoll boot parameter exists, it enforces a global
> override, forcing all CPUs in the system to "poll". This global approach
> is not suitable for asymmetric workloads where strict latency guarantees
> are required only on specific critical CPUs, while housekeeping or
> non-critical CPUs should be allowed to enter deeper idle states to save
> energy.
>=20

Hi Rafael, Danilo, Pavel, Len, Zhongqiu,

A gentle ping on this v4 series. I was hoping to see if there is any
further feedback on this approach to introducing the
"pm_qos_resume_latency_us=3D" boot parameter.

Please let me know if any further adjustments are required, or if you need
me to rebase this against the latest power management tree.


Kind regards,
--=20
Aaron Tomlin

--amoh37pdovgujyce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmnfrWgACgkQ4t6WWBnM
d9ahZw//VMww2+o/pNyP+G5b89h90Ebmf+zW0pziYJadxNOW5QGQDeExvqoatfHs
Ys9np5f5BReAdUs0B+n++0gmmSlDt5fYlT2S3g1dkTi+Si6dlsOhc++83QWrOrPz
DERxe99/rBpr7ktg9oOXA8Vt4pqpn4G3YdTJxpXgZrOkUriY/q+k50vEww30BH3I
wYnbg9Q5ncFst7qW2o5pjczrIJT5eaHGVZiHBRZFAMP7zyV/5nu9eyWl3vepLagg
0VspBZFYlelzqQlzBC/vNPN1WTM4U80WmrEA+Lf3ijXTjMYLGIqP1UbIQR4dTo3V
fLQTr8SM0Q34BpfLpXm/kpL/U+UvOs33vsUj1MhDR5jZwmPcArfUrQQEdfXz73OP
m8LcX/oA+mAq1N+/XQyGP1mjbTKaUkxjeIFvhhsoXx1lDYAwq7ypo++i6HL4j4RZ
kfJVCUm2AEAtbpdbUGwkp+LRPLQcr91dxbWWMidWVAGKluM72zwW40ZKJZSivPQZ
N5pPE0Hei3p2QvoWHkCBalawHk8CyYaf6lVOKurNBJTYeOwA7tlEZ+k0SwJ1xKhL
wk/H7OAmjWvqtFmQZp4ry6fTS+9NPfsD/W4tW0HeDKmP1jAyCUBbilP90XxJ0mCo
LpxBGvVS7UE4fMoFL1k0Uy6ko3ODe674ouBpHwoPnMASFP16Z8w=
=k1BM
-----END PGP SIGNATURE-----

--amoh37pdovgujyce--
