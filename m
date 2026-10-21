Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792577202;
	b=0WlVJfnWQjZNagndUahDvGhOjG4zM2RJlWlnZDbpK3n4MDxzpAFwm6ucS1MLLGCdZG71
	 EHVs3gCPyVFyCXJjkqMOyxwv+q9Xwg6Erqr3Jp+v0trpsfyMBuv4Y1Dq3cKSLjJz6iU8z
	 LJUbOdVC96qkCfHsmfxb/zveIiOpbE4upealo0BnQ2vTyp0BxgAWHH6i88gl2hG13+Krd
	 x3v+3zzIsJIzloxusJNlj5CExWr0z/JCa4kDHaD9FQrBPnzCrNo+mr2e3opqsdihLaZP8
	 vB0wVd3mpnMTJrGPK7HIN5zyK/orC8p1/EoGp4M8JmLfRlt0wLcpLO+7e2ZHCFdEEzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577202;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KCEw07ml2Caa7OHsV8nAfMrvtbW/l2isAHuuI4SHCSk=;
	b=UhfWkjRH65/s2QJECHVxDWwIVljhbOpQJHLnhCrj+74W9bDrCD8PYm0kUTcSOAcucY37
	 2JXuCDt17f1p38NknXF2cApbIMMkx1tqpCkGr1SCmcNFMrugf0yUfNPxccfsC1cl8Ymrc
	 rzSi3T4fnYoOuOaZyLNxxEHXST9xb+bYlRDgSEAAX/h3R0C1gCsM1l5/dseyMDDyX0iyS
	 +x5E59EIvDub2ka0dvI7n/Yhs3fkg7D7ZiAwzM2wkMO1GVHTbQffWPRtgM6GMMo8zeVsk
	 PQmeuU937/5wB9sJ5dUD7qdLUrwDkaBT1vEKjoZh9IAZOzKbY4KRs7ZuHF3FVeHXv3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Vz9x6O08;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.17
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010017.outbound.protection.outlook.com [52.103.33.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AA606A31B;
	Wed, 21 Oct 2026 10:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D9AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Vz9x6O08
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtJ1zxxA9snV7hC/rk1L4HguG5958bDdemmRcIO5ib7pkuJELVvNoN3TuFtxjsUyXvm3hdnHDmT0qJlZCKimRGWMcnxKWhCD0mvCWOy1Zr7rplPSqXeP4L6O5HW81xHjPKdcGLdR/B+MmlEaUscddko78j6PSupg4erszeCK5lzx7BlSAqrJcJf+wn5pSEkEc0wc4o8agUwkueWct0V6jfdTy6254XIEVvc/U5/e/yoU7M17OCSG//6ODQH/9Fcx//XJfJnEVsO/jDyip9zGxPERY0/feb/jBb2yv2P1ayqt9wQobB/U6yxCsKh35Tb19VFqaN/eWeFoKxZlxEXdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCEw07ml2Caa7OHsV8nAfMrvtbW/l2isAHuuI4SHCSk=;
 b=NfUcy9lTvnj7Uy6WOZNedLknGTDYaGWcc1caj1mDNiZhr2hNeaHXUVFsUt7emVq5L+6BAzoYnkmyogybeVCb6CHPMo/DotlTySbwnbj3q+GbFddpCo1JvrIFYD9E5NCrcbLrZY0QZHsSEIA6A6EVXzU/Pv6H01xfIwMeHF/XapKGfpy/eH4ruEDDOankzT+9psxe/2cSww5fhDhMm4o5FoyW9lTTNgOVdsSAYHxgUZKDkncpQ4upBNSuidcxjnvKVt9B7RAM+jv5gXqeV9jyb4zyk3ACCYW75MhiF4Fi0ee+tU2tyuzhKJvmg1jlm0xWmHMquAKGiKQI4R5q58ScbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCEw07ml2Caa7OHsV8nAfMrvtbW/l2isAHuuI4SHCSk=;
 b=Vz9x6O08YEP9s1PaOzRdg3P/s7mIo/TZ3USObIzARf162rV/FvawKtV8IdxcIrnrb8gWDrcAno1FXK6rZmW03lbe7L7tJfGXXCt3H/h3IlMl97E08JxfXXrPB/rP15gKYlx86VP5EzyXiAe0uOvKF0ZdLf+sbb0EovjOMEUDENigNr6oBEp7CdK55Yj6LVJXMXwV7wYauFC0zNSgTzq2ow2a9O2JV2yAUNFxDXdzB9OCMLKdQL2mHdgNPM/ZnUs0NdvC68UfmBhNzjXGe45/n8YCqUxs4N9T9nxUFQiEvc8GDGkeP9lzapJjCUvNzgjJtFkhbRQSfOMe18Bzi815SQ==
Received: from AS8P250MB0300.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:37f::16)
 by AS4P250MB0463.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:4b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:06:39 +0000
Received: from AS8P250MB0300.EURP250.PROD.OUTLOOK.COM
 ([fe80::12a5:93b:a03:4312]) by AS8P250MB0300.EURP250.PROD.OUTLOOK.COM
 ([fe80::12a5:93b:a03:4312%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:06:39 +0000
Message-ID:
 <AS8P250MB030066869E5255AB94A4205188662@AS8P250MB0300.EURP250.PROD.OUTLOOK.COM>
Date: Wed, 21 Oct 2026 12:06:36 +0200
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: don't clamp gfx and gmxc before
 sync_state
To: Oleg Keri <okerixx@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <20261021080517.2161-1-okerixx@gmail.com>
Content-Language: en-US
From: Denis Zornada <denis_zornada@hotmail.com>
In-Reply-To: <20261021080517.2161-1-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To AS8P250MB0300.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:37f::16)
X-Microsoft-Original-Message-ID:
 <034c8f21-e124-4511-a451-4cbb6b4ae56f@hotmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0300:EE_|AS4P250MB0463:EE_
X-MS-Office365-Filtering-Correlation-Id: 225696c6-70fa-4c92-e8e2-08df2f5aff60
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|23021999003|6090799003|19110799012|37011999003|25031999004|24021099003|8060799015|51005399006|25010399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEtwOHFyaXh3cHZZMmI1M1FQM3Vkd3hoaFNEcW9zSjgxQ0M4eDNJQmhNMmtH?=
 =?utf-8?B?VkFqeURuQ2JJcDZ1RkVLY3JScjRiRmlpOWVrZ2tEanNnTjNQYXFBcnVqN0RV?=
 =?utf-8?B?dGwweGgzWGRMTDVMRG1uQzJqZ2JId0RNUTJ4ajFxa3QwUzIzQjNXRFA5clFx?=
 =?utf-8?B?Yi9xRmZNMUVNcmNUU3lJb1J1MVI3R1dyR3lSN0NXZE96T0ZWaDAzcGxqRm5w?=
 =?utf-8?B?SVhkY3ZmWmVwcWM2emtwUEpkeXVLTkRSekZDUFJHdWRTb1psRFVTM3Z2eWhB?=
 =?utf-8?B?ZThhMUMvM0N4aUZBb2ZsbnNHN1VUeW1rUEd1QVlQZUtYdXdmekV6djB6UTE5?=
 =?utf-8?B?Um8vbzY1a29aK3BySmt3T3BTSGVaZ3FqOThadGZtK0xrNktQZ3UySkpPWXJn?=
 =?utf-8?B?RVh5a1Racml2TzAzTjNxcEJkckwvYXlXSVNESEpIc1JCMktpTFcvY052ekdt?=
 =?utf-8?B?VFZOL1Npa0RIQVc3UDdTWnRHdGo0QXNzdENrckFwV2tpNVhKeGxnRGZVblNJ?=
 =?utf-8?B?eC81cnhTdkU4dmVUbEpDTE8rMlRWQXhYUmNHQU9ZUi9VWVJ3RTBjWk5lK29K?=
 =?utf-8?B?OEZEc3lRT082RXExL2YwY1VlRk9FSnVaSGJ0QkhTYlRWY0h0VjU1NXJHUWp5?=
 =?utf-8?B?YisyZkU4YmZuVllWU1RhSUcwbzNrV2g0ZmprOFhkQ0N1a0RESjhlZlhnVnpH?=
 =?utf-8?B?eVMrYkl6akRSRXZaVkJ0dlR5S2R3Zmw4bE1sNkt5Q1dhV2hUeDBFSnhKMVRO?=
 =?utf-8?B?eEY5NlcybWRudlhzekxSNHkyMkVFYmRTekhKeWthaDRPelZoM1lCaVgvWVJo?=
 =?utf-8?B?enVKWHJIQ3QvT2RiQ2NTMzhIYnBPK3JUeCtyd1lKaUlqN0VwTlJGMTBBbVFk?=
 =?utf-8?B?ZEFteHR2eDVHb0JHUVlrblpkWEZLWWdkQjlTdzRlU3VMU0t6ckFwRnIwZHo3?=
 =?utf-8?B?L3RuQUwvaUh2bjZxbUFReVp4cDVWOHBxM2NkNmJaRjVybmFHWEVZQmxiS1RK?=
 =?utf-8?B?cWg5NFRJK09lcGpGdTFqOVVGeXZTOU5HWXFyUjlkY0JuMmJ6NmltTE44ck9X?=
 =?utf-8?B?WG1NeG1EcklTVUdrL2JlTFFkeTVmUytCYm05RklHdmc5bEtzVkdXS1RUd3NS?=
 =?utf-8?B?dXd4L0pTVlg4Z0lSOSsrYXd4TGZydDlPd3JaU2RJbUFiOG5ka2N3S3E5WG1D?=
 =?utf-8?B?ZlU2YXN5UVgzd2lKOTkyTGhvUTR3dTczTFlMS0pTalBaZkxmRFAvaUw4UGd0?=
 =?utf-8?B?ZFQ4bnlrcFhTK0NLZ0FTQ2E4NThjYUxBTGVHSUlrRGR6QjNtSTZPM1dQUUk0?=
 =?utf-8?B?Z1Q0UURlSnVFUE43NlZxZWxFbDhUNW5QN2E3NGt6TEgwbTJQUWJ2TmVURzRH?=
 =?utf-8?Q?zvxekmJ5Ozz2gCYvuN2GMABw2QL1A2HY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXNpYmVGVGFpQnBzbUtZdEJWUTErRStLKzlHdVVaQ3hleUNIeHVXLzJqc3pq?=
 =?utf-8?B?THZQenN2MjhpcTM0blJhMVhYUFk0bVU2OG5vTU9SdlJnZm1yWTE3TnpqcnpM?=
 =?utf-8?B?QkZtOElDUzBhTGlmbjRlTTE3aXk0Qzk0SDNvdm5oZzJVcmkyVndkdUVHK1BL?=
 =?utf-8?B?RUc0SzlpdWdHaWYwa2R3aG0vZG9CVGh4THNxc2lBYnAyVzVqRkVJSFpIc1F5?=
 =?utf-8?B?dEVYQmJ0SmVaN3NIKy9BenFycXdCYjBJNzZMeUJudmtYcEZYa2xuUGVqVmNH?=
 =?utf-8?B?U09KZzFQdmRVWHJyVlFFY3BJK1Z1K2Jjc3hqZ3VOUFBrZlhmeTd3dldkMGRz?=
 =?utf-8?B?bzRVbEx5ZitGSFZsT2N0OU9KOW1sazFDWW44R3Y4NXdqYWNieXJBb0V3T0w5?=
 =?utf-8?B?VGpVclpZOU5GbzB6R0dzOEhpTXVHMll6NDZhRko0ZUF3UW9hMmJRUGp4ellp?=
 =?utf-8?B?TkdORkYzelZTVUpERXdmRVZFOXdiWG9ZUi8rL3lCaEFkeEsxaDgreDE2OHJQ?=
 =?utf-8?B?dUU4Z00wT3dYTGtYSWQ2TDdDVURRRU1YZGxVblRJM1FOVy9aeUtVTkZuYXlY?=
 =?utf-8?B?TnRrM2E5cjlKaUtISHY0REtzelFlV1ZBUUM3eDI4K2xQdzBSNk96WkRsWVd6?=
 =?utf-8?B?eVpmdVpQcTBkN29IQ1NiZ2sreS9nYS81Z0hUejBTSGpxRjhlOWFJSGZCdEV0?=
 =?utf-8?B?Mm1IQ1FIeGllVDFHTGdka2Q5OG4wczR5eXZYd2ZNL1lGMkhjbURsU1NZZy9o?=
 =?utf-8?B?V3lFU3MvcktkOVpnY3k5TEZIci9yRjltb0hEUFJiSnpPSWY2K2p5NkRaR3Zq?=
 =?utf-8?B?bFViaVMzUmRUTHV5SGFiaDVHUlFXS2FWalA2WVQzUnprMUhITFQzS0pnSUE2?=
 =?utf-8?B?bVU4TUx4SnRIajIrMXVoNWFqNXlsTFJxSkxnNzc0TEZTWVIwcWJrNUNicVRs?=
 =?utf-8?B?cDI2SmxDM0FEUUZaa3FsTDkxVThiYXRVTG9QeFlHOFowZmc3UFFBVVVBeEFy?=
 =?utf-8?B?eVJRRy9vUUlsaVVaeGU3U28wU1dUdjFnV1VTbDE0alhHNXZvS0Y0ejZYRzNB?=
 =?utf-8?B?SVRzVlo3ZTJZUWsrK3FUZXZ1S09WMXJPWUltamRxZ01qaUVuRWVrSXFFREI1?=
 =?utf-8?B?aldoNkQ4TDd6cGVQNXBzRG5YQUdzVHY2Zi9jdTF6RldhVHA2NXpER0VUWS95?=
 =?utf-8?B?YmJtWWZPT1Y4dE5aMllpS0h0Umdpa2k0QUZCOUJwaFJWa09vUDVNY2NVbkRJ?=
 =?utf-8?B?T1NGSjNaanh1blRpY1ZQaVM1bEJVa2F5N2p1N2lmMjhwcWtHa3pTTTFVeEN0?=
 =?utf-8?B?c0VVWFR3bXhZWWl5Z1daL3d2TTBzMndVM3h6cGpJRCs4eFhqT2tGcWp5Sy9R?=
 =?utf-8?B?NFFtVHQwZFJTZVNIODRjbFl5QmpxZ1p3NVpzNEJRVG1WSWR5dEhtYWsvRXhl?=
 =?utf-8?B?Z05JSi95WmRPbUh2ZmpvZVNoY3pVdUkzT0lOd3VtNjZsNVNjTFpXL3NRWmV2?=
 =?utf-8?B?cXd3QlcyUTUraitYVFdXdUl3b20zYWxmSTFjNGgwb3FxaUR3MjVMOWRTbXUy?=
 =?utf-8?B?RUNtdmNsVTZyRTZCNnJERVN3ZW9HdWFoSGN0OXpJem00SXYxdjlycGF1QjZR?=
 =?utf-8?B?N2NqV0RJbU1oUHQ0b3pYTk1HblAwclhaTDIya3hSZ21MSHdxbnM4REErTDVy?=
 =?utf-8?B?aWRvYjBuczhORXQ1aDd3aHc4VmcrWDhxNjN4Rm95WmwwZUpmTVJNZUdNWEh5?=
 =?utf-8?B?emJQa3IzUm1hUVp1WEpwQXBnbzRkMzdoTVkydHExWjVwOERSaHlJa1NBaGZG?=
 =?utf-8?B?bFA1cUxYQXlhZEtkYWZFY3RZVDI4dFZyTVhMK3BZTVBaaUtBei9YNnRnNkFs?=
 =?utf-8?B?a0ZIdXhrSFNhdHJQMXllS3RMTmRPTThDdXNOZUh3RnNzOUE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-6108c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 225696c6-70fa-4c92-e8e2-08df2f5aff60
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0300.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:06:39.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P250MB0463

(Resent as plain text, the first copy had an HTML part and bounced off
the lists.)

On Wed, Oct 21, 2026 at 10:05:17AM +0200, Oleg Keri wrote:
> Leave gfx and gmxc out of the clamp: they have no bootloader-configured
> consumer to protect, and the GMU votes them through its own RSC.

Tested on an ASUS Zenbook A16 (UX3607OA, Adreno X2-90, GMU fw v5.2.38)
with next-20261020 and the upstream DTS. Distro-style config: msm is a
module and the firmware is loaded from the initramfs, so this is not
limited to built-in setups.

Without this patch the first GPU init fails as on the other machines,
and every retry fails until fw_devlink forces sync_state:

  [    3.584003] [drm] Loaded GMU firmware v5.2.38
  [    4.641088] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt [msm]] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
  [    4.760713] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -110
  ... (26 more "Couldn't power up the GPU: -110" up to 18.7 s)
  [   19.937852] gpucc-glymur 3d90000.clock-controller: Timed out. Forcing sync_state()

A GPU open after that (~290 s) succeeds, so this machine behaves like
the Yoga, not like Abel's CRD.

With this patch on the same tree the first init succeeds: no
GX_BW_PERF_VOTE timeout after "Loaded GMU firmware" at 3.7 s, the GPU
comes up at probe, long before sync_state (19.4 s), and a small Vulkan
test (vkCmdFillBuffer plus readback) passes on the X2-90. Two boots with
a complete log show this; on a third the log was cut short by an
unrelated reset. On this tree the A16 eDP link fails to train without
additional local display patches, and once a compositor drives the panel
the machine resets, so I ran the GPU test without a compositor.

Tested-by: Denis Zornada <denis_zornada@hotmail.com> # Zenbook A16
