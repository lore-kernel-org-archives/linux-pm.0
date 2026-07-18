Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020137.outbound.protection.outlook.com [52.101.196.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C15846F;
	Sat, 18 Jul 2026 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388933; cv=fail; b=Smdh5V6KISp2lBkti9f9i01S02653C5uM678xhwwYRuxA30YkSNXWEz4/V7eBivu6SZliZykPBSQDZlT8ogN6CSRcPX3q6lFunpsnW7WJRQxFalIxNywCWeyKntmhvBE1IQoXwOO8gdADWZ+Yrcuq1Ea+vfig13Gk0yDczQ6pfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388933; c=relaxed/simple;
	bh=KzNFAs0923vB+YKB369S+J4MYFQCER2YjZXf/rR+mHY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QYQrCJPwcdFsZu/ctoSn6OoTJ22wTvu6vwhpGTzID8SRl6jYUMV25k7CaVpQnBU/SmOSxwxyr6z0jXFREb5nKYDsE9W4usdIa8idRaP8o7OL8MA3HkAsY9fJnj60MTtxPttBmZQGvf5eIIqeuvTACTGWw8KSLHhqGER3oDUJjUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MYdnd2d3; arc=fail smtp.client-ip=52.101.196.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MYdnd2d3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T966GwHQynUqhITLPyrD5mGOcUK5A9N8Jw4HAwEQQmjqedNqCrD8q87uFIqYU5buPqUDbPjUulkwZH8Qhq8tR7zqSMlg84A5BswkJ8U0O4NH+MiQxa8cghj5mk8vnYtWs6KNRkqs2eaS+aW8fAnEWA00uN1IKKUu+v3pl7i7FEfxYaeg3TrqIekY5GTDA2/LwdWAu6yhP1upkFBllAD3hG4R8FiuPaRlPxvXuO/490FESV5puqxN22hDszK0Ggs27fSbziHgPtvscdsuP1DchHZ4O1cUW+D9sm2BkQDG52dqFcWVjKvGSDUF8ujV75UMy6fDVMxW8/lbLoUxaMBMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBBdNIM3xPGWAaL64I6fuxhs4yw3cL5BMZwmrCFZNWk=;
 b=GlAu6DHQDr58DT1BXtXqRzj1hZHae56kuCS0pZFdRh3LPajLnc9eUXniseqxfLl4SoQABkuzrFMIx17zKVQmXJmyOWYhKorn0qxQ0GA9FaIbxWWfNjhab7weWT5yxN/F0AObuyohF5ukrbpZC1nk82WENzUkZjY+6TOkj4mNnX7hibeKjuQnYkyw+3+2FwwlXRZkGeKEnqBse71RqWZ1EtZCTSme/7dKxw1HaIL3R04TXQTegPNV4A9QJG8SvzF92EFCFGKQDJn7QWLarG6SJyh/ecYLXR1dE9PRbZnfCALbfRh0bGubatS7HvaHaFpbmy+AxjNKd9ebWZG84imVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBBdNIM3xPGWAaL64I6fuxhs4yw3cL5BMZwmrCFZNWk=;
 b=MYdnd2d30VLJy9p7E1n2n4be4CGmFraeN3vvW5DEfqx8tnLcsIjbET4keiDzxlJbbkufrgpn8arU4P1sIJG5w8tUrf+3BWBL6Ga7gEu7/SRVxiOeBo1+S1vek0nJ3mvciyinan9aTMJcq0ZQP3m0oMod6CLKqWao1zv0kCKqEkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6721.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sat, 18 Jul
 2026 15:35:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 15:35:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 16:35:28 +0100
Message-Id: <DK1T30ZOCE1U.Z8SR05WTWLL0@garyguo.net>
Cc: <ardalan@uci.edu>, <zhiyunq@cs.ucr.edu>, <dzueck@uci.edu>,
 <ytan089@ucr.edu>
Subject: Re: [PATCH v2] rust: cpufreq: Fix temporary write in
 Registration::bios_limit_callback
From: "Gary Guo" <gary@garyguo.net>
To: "Priya Bala Govindasamy" <pgovind2@uci.edu>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <ojeda@kernel.org>, <aliceryhl@google.com>,
 <boqun@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <2fd4425697efb6d52459cd886115edd281bd5f44.1784155370.git.pgovind2@uci.edu>
In-Reply-To: <2fd4425697efb6d52459cd886115edd281bd5f44.1784155370.git.pgovind2@uci.edu>
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dec591b-64ef-4d7b-e925-08dee4e231fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10070799003|6133799003|56012099006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ydg23gZeOk8yjaiIDrQVuFjs0+VbfROgxMZm6yJg8iA71ETki72slpfrK2G5TYyp/B5JwuvjzQdeMEjB0AIfwBn34EUbyT91iNeYj1Q4ZjtEjOw9zTwqZc5OCKYpFoc2DgCcsWnLUvbRanfBDnA8LwfbCcC9MhWvJ/XHSHqiZ50+tjkYPmQ6XGPo/UW7gbbEtWMeECky4yEXF5SpfSbUG9FyAzP6vp6zGywyVWfSmX8skXKmRL640A+PSJc9bUKb1L79v5yOWbcv7XdO1WfR/jAwncqFhKWSl1vf8iNWputYMu+Ssx6FmalYU+fk2/MPvUbcFIm1lyraZB4eL/7UltJXsx41hMGiVsX+/euYF30YAkIqJ7a+fIW24CRkC8IMrk0CrHZ/+ZUN1/P6nSlqRu4wXtzeXxGrpzIxRNYTr/xqPMz8PjoZx5liuQVb/IvLo2nFVa6DfJOJBgACn9A0YdQULo9AHHkFPw9qU52fswqyp63HhKeCyYKGWBnTeVGTyz/6tkKOknmbGwLCg/gyxOSzOLOe6rLAzyH0iwm7BL5vMY+xRSpmT7/KphFG0kyRR8ma8naA+x5AvKaihUU7sap6g+hegJo4vAvzilTk8+CxlulQ3bgnnAhV+3wJO10esU3G9XcGgX7MIKKiCb7vsjznJvzpPUV7cJqNdIg/plc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10070799003)(6133799003)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGpCbDRjWnJickFsNEhHbzd2N2hERVhnS0VFbnlVVlZwbnVmemtWM0pOWExr?=
 =?utf-8?B?Z0tjY2tzZ1hZdC9JSGN6NHpsdkdOK3RQSk55OUhBNUZaQ2tmUlpoZG5qaHIw?=
 =?utf-8?B?cjFhOWkxQzNMUnJNcEZ5Z2hwK01SRFFaekROdlFJdFdOL2M4NjY3am1zRVdu?=
 =?utf-8?B?QVJwTkIxTmwyUzJrQ1U5YmJlUVVWSDdTWHgwOWt0UFlXaldMVWl0L1d0alNJ?=
 =?utf-8?B?S256U0ZXWUxIL1ZVVHVaWGpJb25BdVVudWpIZnB5VWk5Q2tTWlFaZ0d0OWc3?=
 =?utf-8?B?RzJoZko3V2JHSkc5MGJEZ1ZXKzY4N1lMczNuWlFhUnp6dmVBMmtici9tL0ND?=
 =?utf-8?B?WERwcVJkTzV2TC9DYldtWnI3QlNrVDV4RFBucTNnR042WVptNXVZcjh4bXRP?=
 =?utf-8?B?VUJoR1dqMnR6Z0FwbTdIQysyTmRHcUtmSUVXdXg4WkhWWFd2UnpSMklpQ1V3?=
 =?utf-8?B?ckptOUszOGhta3d0THhWaFQrTmF4ZmRhMG91dFdlc0htZ1lWODdhT3p5aTNj?=
 =?utf-8?B?QW12VnIwcHJwbDZIZGtHbHdNNWs3eXNrcGk0d3d6Zk5DSDFSRk81UUNYZ0dF?=
 =?utf-8?B?Q1Vybmt1QlZWTGxCYnhRQjlnZlZWb2ZlSUtTWitCWDVIcnFPSXdwbjlxaUN6?=
 =?utf-8?B?aWNKM1R0REY1Q09pZi80cnJoQWxoWXpRKzc2RGtsdStEVGlxSGdxcjhRL3Iw?=
 =?utf-8?B?dEVJbS96NTlMcGNmUC9ibi9nc1B3eVZuWVZUWGN4ZTdvckpmb0RQaFBZT3dq?=
 =?utf-8?B?bzZKcjk2MkdRSE1zK2Q3ai9zcWZ6VWZlNmNHN2xnNXBDYmxBT0lEbUxheDMr?=
 =?utf-8?B?V2YydFluV1FmdHBvNFZRbHFnV05DU3hLMFJzcTI4TnBQWHBldCsraG9Wa3pH?=
 =?utf-8?B?STdYQXkweHh1K29weDJqR2Z4NFpoUnkzUFM3UDQwSWtvSExEdkZ4TFd1TU5I?=
 =?utf-8?B?NEZSQm45RGoxeW5Vamgvc0U2bW1VS0VOSEVSMzJSN1lFR2tidHBDcEJ2d1JN?=
 =?utf-8?B?a0tHSjN4SGt6SmJoMDl0OW5PbGo0MTZvYmpMTkpTMzY3NWc3RHU0NFlQSUVQ?=
 =?utf-8?B?UjhqQ3RzaWhkYWU1ZnRVbTZDQy9hYTNvT29ITjllcDBqcW4wS0tkZVFiNWQz?=
 =?utf-8?B?aG0xZTFrUzBuRnBzbkVwYnNpNXFzVVhROHRBY2hGY05OeDJoMk1PUWFRMmd0?=
 =?utf-8?B?elEya1ZPc1dYNXJ5UHJFZDlNWTk0NytzOXkwa3ZSKzY1eHRzMkdDSXd3OWZy?=
 =?utf-8?B?b2JmdnRCVXdvM1g2MFZ6N1JiL1J5ellaR1FFQ1Rwbmd5b2lMKzAyaG5QU0xP?=
 =?utf-8?B?UVRpYkdHNDVOUkpMSzljTDk1UFNhY2t2NnJxdDF2KzA5Mmlvc1ZxN3NCcWZJ?=
 =?utf-8?B?VzlwdFlDUHJORUFiSUZCTnUraWhCdUt1ekhyWFNWTjFhTG5kdVNtRUZnY2xE?=
 =?utf-8?B?anJxL05kREdHTEl2NjVkekRhTkdsQlpYUWhBekJaSG14OHpySzA5ZVkvNFJL?=
 =?utf-8?B?S25oK3p1Ly9NM0dBZTIwZTNTSzlHZXJ4Z1R1OWNmT0ozNU9KOTVmU1hZVXhh?=
 =?utf-8?B?cEhZdDlBbXNxSG5ZbDFrLzhzY0pLcFhxVktGNjhxN0RwaTVMWXZaQTdiL2dm?=
 =?utf-8?B?aFBvMDRINkc4VzB4VFIzVi81b29ZR2JPM3oxQVl5a1dWRmFiSzFleUtpZXBV?=
 =?utf-8?B?S05POW1VWURDeDhLUXpxTHMwRW9xRFZXV1RuKzVQRWFhYlh0OGw2SzVsS1Na?=
 =?utf-8?B?VmFNdk9td0h2WEl0SHFNUUdFdzNSNzBLWnNGbDUxVUVNblFqLy9VbjhRRXJv?=
 =?utf-8?B?c2tGUzF6RWFjY3pNenlzYmdzM1hQQzBISGVGOTM5ME9zZHNVQUxmbzl3TmxV?=
 =?utf-8?B?OFd2Z2RoZTlKQWY1QkpLbnhtQWNkWndQTEI2bng3OHJMWllXYjJ1RzIrcWx3?=
 =?utf-8?B?YjhDaFNON1BlVTdSRGJnMktnbFFnYTRDWUR4bmFhanpBakxTYmpRMjdUVDAr?=
 =?utf-8?B?OHgwNmVUTzdZbEhRRjR4ejJBQlNQOG41Z2htZ3FQMWhEWlB0VXc3R2pTbXFF?=
 =?utf-8?B?RWVIdlJiQTlKOGYxbVpYaFU2a1g2NUtZSHZmY05rU0pWQ1NBZ085WjJEZUVn?=
 =?utf-8?B?WXVyOVJKQXdVTkRGOUlVMXRGdzd5OE43TFpJbkFzVHlBTEYwdWRkRk5sN2M1?=
 =?utf-8?B?VjVuV21MYTEreVQ5OVZpL2svbkpwZllYYmNIb1B0OUJnSDAzcjhUc3VEYlhs?=
 =?utf-8?B?WnZEdnNLRTFCekVUUU1kN05zWExZYXZ4Z2dmanBFaThOYmREWXgzUGVVLzRL?=
 =?utf-8?B?Z3crZHdLTFh3NHBjQldXUjh4VUxlQ1R6RUVXUzFycWZsU2l6RGI2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dec591b-64ef-4d7b-e925-08dee4e231fd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 15:35:28.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3iWJgT0UQq7URFMIYxHuRkeT4q2L2+iIgBRe8XtvqdXMMPKfBt82QaRytt8nCWdzAsIRWtKdjECmpZomD9QGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6721

On Sat Jul 18, 2026 at 12:35 AM BST, Priya Bala Govindasamy wrote:
> In `Registration::bios_limit_callback`, the expression
> `&mut (unsafe { *limit })` creates a reference to a temporary copy
> of the value pointed to by `limit` on the stack.
> Therefore, writes made by `T::bios_limit` go to this temporary
> instead of the memory location pointed to by `limit`.
>
> Additionally, `limit` may be uninitialized, such as when
> `Registration::bios_limit_callback` is invoked by `show_bios_limit`
> in drivers/cpufreq/cpufreq.c. Therefore dereferencing `limit` is
> unsound.
>
> Fix this by changing the signature of `T::bios_limit` to return the limit
> value.
> `Registration::bios_limit_callback` can then update `limit` directly.
>
> Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend a=
bstractions for driver registration")
> Reported-by: Dylan Zueck<dzueck@uci.edu>
> Reported-by: Yuan Tan<ytan089@ucr.edu>
> Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
> Assisted-by: ChatGPT:gpt-5.4

You should move this line above your S-o-b. This tag should be covered by y=
our
S-o-b, not by whoever applies this patch.

>
> changes in v2:
>  - Change the signature of `T::bios_limit` and have
>    `Registration::bios_limit_callback` write to `limit` directly instead =
of initializing `limit` to zero first and passing a mutable reference of `l=
imit` to `T::bios_limit`
>  - v1 Link: https://lore.kernel.org/rust-for-linux/cover.1783456063.git.p=
govind2@uci.edu/T/#t
> ---
>  rust/kernel/cpufreq.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 58ac04c650a1..5dc09063f4e9 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -817,7 +817,9 @@ fn update_limits(_policy: &mut Policy) {
>      }
> =20
>      /// Driver's `bios_limit` callback.
> -    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result {
> +    ///
> +    /// Returns the limit

The exisitng documentation is pointless. This really should just get proper
documentation, e.g.

    /// Returns HW/BIOS max frequency limitations for the CPU.

> +    fn bios_limit(_policy: &mut Policy) -> Result<u32> {
>          build_error!(VTABLE_DEFAULT_ERROR)
>      }
> =20
> @@ -1352,9 +1354,10 @@ impl<T: Driver> Registration<T> {
> =20
>          from_result(|| {
>              let mut policy =3D PolicyCpu::from_cpu(cpu_id)?;
> -
> +            let val =3D T::bios_limit(&mut policy)?;
>              // SAFETY: `limit` is guaranteed by the C code to be valid.
> -            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()=
| 0)
> +            unsafe { core::ptr::write(limit, val); }

This is primitive so there's no dropping of old value, so this can just be

    unsafe { *limit =3D val; }

Best,
Gary

> +            Ok(0)
>          })
>      }
> =20


