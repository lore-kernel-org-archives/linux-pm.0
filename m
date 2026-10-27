Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793116006;
	b=u8xR99f199r9ZDZCcGSdmAjitOuazb+agOk7ez5r38X34K4ojrP01mzA/PIYIpkZ6JBl
	 6KNcFqdH2G/lwIXzXSqhB8/t1L3lrkUaYDyhDVjHC1YLwaAzAQJOlp9A/gf0W2nTkcQIO
	 XSBgxrEsJY62alYri1ZuKgCBsWZ4lQJz5QC3ILS00w6jRul5ieh67jz8Qs8sRAzqjulcX
	 1f9PPxQOwWaDvOoIScYlwdpUtXRY7iaQYrdsmkRLnVHm/bsn1xmuqGYTrT7UZzrkt4r6+
	 bKhEhXvdicpa1SgwKtXvtS2IzukxCmF5Wbw09LKAaZJhX7EQA6CwxRcNxGGZ/E9qj6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116006;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/edb+WRuVJ1qDsSxNXX8nt2sKC2h+Xjf1aJ+yau5pe8=;
	b=TnhWImBA1MlYE1gKzi9jyMAR6x6Ul6fnaZPamS4d6K2/BMkM8vYUKWj2nUJKpYm0k0MG
	 kv5SOXt0EoNdepwR2rQHv89fjQLhWDw1OZ1tpkq4DCJL703e9nUs9B86jhjvypYnZDpXv
	 pjfcgoM1B/V47g+zQozRomaOYzQdaeAeDxMhocFDJ74r+cW04gjKfLF+v1eKWrurLsSVy
	 d7m+zbPn8o2ov0piXCFwafjVAZiwSFyTU+dieotVe3If2d8e0FocOwOIsrnvgvn7Qf1GB
	 YYhG93A/FtaYIGIMxx+rISidNRVzWrfS7IL8Bkz5EyoOr3Nz/0vZ2mpu+hIzqFwxNJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=B7oaFrbH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.32
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011032.outbound.protection.outlook.com [52.103.12.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED19606A32F;
	Tue, 27 Oct 2026 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED19606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=B7oaFrbH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT4qFLzDrnaOEf5Fw51gpRPK/0W9dnUf/YwayVJz1p68+nKMo3qDGtArI/0jX148abC71mQAAoQ+nr6RGSC2upXkZ8iop4Bl62YR1ksobakxIXCBUAEWs5nlOUtI1VerdZJOdeKhuDD3AgzgV7/93k5oPqyGRlnd3xFG7dHSKXLjp1lwaTrutfvN+oSXA+EW+9cmriTICUCmTwAtR7VTpg7gacpnPi1h9rdjNRx8YIwz0gFIaGOXj0Jw0IiOrNSECcWKzUzNG/Y1PlxipILRL5fHFemje7ijzi14r12dbSPlzerkcI4pqKw9JuGzeEZogbf0TDVbqIGVwVN0idYAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/edb+WRuVJ1qDsSxNXX8nt2sKC2h+Xjf1aJ+yau5pe8=;
 b=dkmv+woPg3dHY0UTkxGf2OSA07WHzcl+S5lMDfBndEv2BXqs0/i5YMKp/I5Ws44bMaHJcnUB32cAEce8VcdoywLCdUtL+myDO66+CJIjq+w2wasCJl6e6G/6nIJTDRyZodUvFjmbt5zUQUv1T4Gy3LRAS5HvNO6ejxa7I4z5+bJZlHawIqad3Bu0un9qyeZs4xPnCFT3EVg4d+enqCVEAh5oojadsFY4IEpItvF/SkS8SogHZWbYxIe+buABTPhAjPw1RJJZOuHIb2xnwl1kubltuRXKnYKisGefU2jZAnnAuvrWm/LpIqz2ZHEFwZr7TikURqMOrfr2JRFCfQHHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/edb+WRuVJ1qDsSxNXX8nt2sKC2h+Xjf1aJ+yau5pe8=;
 b=B7oaFrbH+o3m8UpUWJnQrxIOZ7AVsYLARwl6CpyN8/XKHSJEsKK+iCi73tI/kG5tr7Id/p0sxUhnWGbiXD1Ft/gU7LSzBRwWWm6qo15tV3c0v61AJhSLfB1TW9GTasOS/GV2Lfj3IH16yxN03r7rbitCCjHqKKirYHdztySuJL+eIAEp8qxEdKX9Tsma7rLkKr4SG3RfFV+oQnmJ2XIbiGZ2WPASvYsJOVrzpwhYfpzXOky1P+yqhZg9KF6loZK3mza5Jl0sSNbSghUWXATGU6OTAxWkLVpdhv6+4FesIg1u/3Vy/F5nzlmMBCQ1P08EjkSZE9QYqTxpby/2ktyFJw==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by FT1PR19MB693254.namprd19.prod.outlook.com
 (2603:10b6:170:28::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:46:43 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:46:42 +0000
Date: Tue, 27 Oct 2026 10:46:39 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, sre@kernel.org, t.schramm@manjaro.org,
	Xu Shengfei <xsf@rock-chips.com>
Subject: Re: [PATCH 2/3] power: supply: cw2217: Add support for Cellwise
 cw2217
Message-ID:
 <PH0PR19MB9973384449E545D7EF4CFC8BAFA5602@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20261027131751.1724448-1-macroalpha82@gmail.com>
 <20261027131751.1724448-3-macroalpha82@gmail.com>
 <265cfeea-1b7d-4d51-8c9e-42757fe59e1e@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <265cfeea-1b7d-4d51-8c9e-42757fe59e1e@rock-chips.com>
X-ClientProxiedBy: PH8PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::18) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <auDHXyD-OdQQqvSk@wintermute.localhost.fail>
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
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|FT1PR19MB693254:EE_
X-MS-Office365-Filtering-Correlation-Id: b2069a3d-ac14-447b-4c0e-08df34417f59
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFA0GyAFqbKW0EprdbA2EYzUVYelI6NWHW/mgXZRMJZN19QcRiqkxwVZCwfD9lrWzHz/RzNkNcSUxkhEASFcw2F3JlenDnROnM23L/+8Sel2vBufvyI+7WdA2/4sUAEWh78Zehmp09IyeziAOg8Scq7eg/7QblkRSOB/0tAy3SC+nUPD0PvVxA3PA0p9yyO2mSx+hIr2jr3Y4J9iFozq5jtCN9dQzERgWi+UjSxIEJIVYjiXNQKwRO0ahK28ZRBcolhR7UNqcUwNH/HkCHVi0XqAonZGmyCQssxoaS55mH2IBciL7D5Zgh0gLqdqJIo4yiRb/COZ7ux7dXZ3u985+hrYzDFuDXoOYD6Gno0mkquIbaL2KkC8ya2sHYuMcyBNB1FW/E1rFnSGYeit6lEYHe/L88DaO5X2teP2NTM6JWdftntlVERy25mKAzRhO/g9cR5HB1sZMINVW/ykfLinXIuwN8LwejOQ+NCJ/TpfxlRJGWSDwkg8oqEUxsp3iNTD4UXogcZurvOQAn3+t4v9/QvxfoeqcZRerIkBbVf3/cshGZ+SlxhFOUTnD19XlgNzFbqQ+zhiM224IEAxDrf4SYNWgplVA5GF1ngPUnYexeqkrLv9xskz66vY8I9uOE61RLzNPwSlqNb7Lc+AqxP+LFoAe0cEPi1PY+HfcGQ9/mlyztdvG+tHaizokfnfi36eYrAGm0jsRcTBwTTkp/ltKNlA3D3xatpMgDZHMCgT3+ZfZQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|5072599009|6090799003|25010399006|19110799012|8060799015|55001999006|15080799012|23021999003|25031999004|12121999013|37011999003|24021099003|4140399003|3412199025|4302099013|440099028|10035399007|1602099012|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0dYNlJzREVQVlRXS2l0Zkk2OXFTVGRaRUpvRTVWUmdudGJxeE0rdzA1cGMy?=
 =?utf-8?B?TzJ3WS9TZnczOC9ad2hVTXFJR2lYbXorVkZiczMxS3Z6NGtJSUFUQldsN2ZR?=
 =?utf-8?B?UTV0UFRuajh0bTFiNmJaRXkyR1dNUWpINnlMMWZnaEdSc2l0ZTg0V1QxYjk4?=
 =?utf-8?B?V2taK3c4RFNPRlUzOW9xbHdMRVZlUGMxcUtwbmY0UXNkVi80L1VxRGp6bEZK?=
 =?utf-8?B?b25XakV2THF4OUV0NytKUERnZnZJbnF4YWtqRnFCSkEvVnY0OEwzUHkySzBi?=
 =?utf-8?B?clN0eHJIQmVhZHcxbHJmaTBJeUoxYjYxT1pSZTNCdTVGSmdJUUFuQTZndmJl?=
 =?utf-8?B?ZkZOdlk3Q0U5bzJLalZtYmVDSEovZmlHdTMwYzN0L09STi8weDZxTFp1Ym1q?=
 =?utf-8?B?aTF3TktySEhvZkQvZm5UckZlT0dkaHhXZzBTQUtCbHpyUCs2TGxURE1ubFRi?=
 =?utf-8?B?L2lGYm5nWUUwZmNRZ1lVTE4vb0loR1cyYmN2Z3JHY1lLamN6Tzl3NGorVkYz?=
 =?utf-8?B?Wi9jSmVQVDEvYmF5VHBveHkrN2hUVHhzV2NrdlVXUUxhUEVpWlptZVIyb2lj?=
 =?utf-8?B?Q0M3ejU5YzZnVW81M2JaeC8zM2w2U1Q1ZVhFVkpRYzFiTWR0a2lVR2lQbWRm?=
 =?utf-8?B?cXRza1Joa1dqNEpYVExVSTZocFBINzNPT2FJK1EzeFJvT256R0NjSWgrVlds?=
 =?utf-8?B?NGNuUHJrazh5bW1TcE95ZU4vZXVaS05mUzQwemtBYzlBN3N5bjlEUEJoNmVM?=
 =?utf-8?B?Znp2Q1o2ZEdZbXAwRUhqVTVscCtHazJ0R3ZMMDVpMGxrWUpOWWcxTU80cnUv?=
 =?utf-8?B?cXpxbjVYYTVna3lnZ2lKRFNWNjh4ckJoLzdxaFNQSFNNbHFsS0huT3VlSUZw?=
 =?utf-8?B?MDdUMGF2WUtON1d4Z00zRHdJUVczYkp2c29tdDRoV0dZRFlzRmxEWkx3SC9H?=
 =?utf-8?B?MUsyRXRTUnk4eDRuY1NCUFl4eWFqRWM0d0FBRzdScDBUR1YvVEF6dWZkcmJm?=
 =?utf-8?B?WGp5N3RCNHB1bkpocGt2eE5qNmc1VktUWFl2RlpxYisxSmhrYUZQSXF2TXlp?=
 =?utf-8?B?RFIvb2xCM1RYMTRlZ0ZuT3owT3Z2NmpSWCs1bjh1UHBWRlpGMllpb3NDMGNJ?=
 =?utf-8?B?SFZ1SnMwaUhHZUVZK0lPWWNuYzlmMGx6dHllbmNWUW01N1JrZkU3dFloMGpH?=
 =?utf-8?B?Wk5OdndsMGszRndDQ25wZ2lzdkxIcjB5cmhYcWluc1N0MTdwN0w3MUg2b3FM?=
 =?utf-8?B?VURxTE95dkZaY0pQcG91VzVyUlZQUjJqKzdNK1JycDFEd1FkenJBUkdoY1dK?=
 =?utf-8?B?WVArY1F4RjM0OTA4QXJkQjBhMTRPUTVaR2tqTVNsWWl6L0hXcktnRTZYTXVK?=
 =?utf-8?B?QzNGNFg4WHViOWN3Uk12VUdIYVZ2ZCtxdSswdmliTFYwd2VOZTgvdmdqMllH?=
 =?utf-8?B?UzJSbXJXRFRDbFptOVJWd09mOVBBOHE4SFp4S3lxTmRCVmMvNkJIQzVodWRT?=
 =?utf-8?B?N1dEK2owYnAyZ25pT2VuWVRUUmFhQ3VEVVUzTGdVc0F0eXZqSFdpK1lvWnc1?=
 =?utf-8?Q?fSxpUnUbqRDJ8UnBhPP59OFlE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJJbXcxQVlQa0NGMVB0WVIxWVc0cVR6RVpCUDd2L2tPbHl1UjRUYjQ1clkw?=
 =?utf-8?B?WnRkYXY0OHpUTWZOejk4S2JzUzVVbjcxQTdtUldISUtqVGQ4SytZVkJzVWg5?=
 =?utf-8?B?M0tYTHhRT2FXK2lUWURLNE1jbHhQWDB3Y1ZKT0tjQWRyY3BBTllKQmt4Kzhh?=
 =?utf-8?B?eDlRRzlqZHNsanJmZkRDcXpUd21ERWVlc095d2VpS2pXMnprWGVxeHRmNHJH?=
 =?utf-8?B?RExndUlycVlMNDFwNDNlM2ZqNW42M0pLa2Rxc3VmaG1lQXRSNno2M1cydmky?=
 =?utf-8?B?ZGlaT2dSVlkzelpRTno2TThuZ0NuNlFFOGgzSEZocUJ6d0doSDFlTWlwNGtM?=
 =?utf-8?B?WnEvbENWT3MvMmpOYkpYVnkwN1RQdGpUK0QxNDhWYWdRN1V1OHdlWXFNbG9J?=
 =?utf-8?B?RmZzdVVpK3BVb2dMZTE3YkQxbEEvL0h5Skx0NTB0YXUyMDRjL3dMaW1UWFdO?=
 =?utf-8?B?MFpEVmZyaCsrOFlwM2pKY29lcTRGVzBqU3UxaXp6ZE5iTnQrNUF2eXVKV2RZ?=
 =?utf-8?B?aXdwV0tZNlBhOXM1cUVDbVVBWHQyUnFnbWszZFNXN3BvMjZXOFlweU9UQ3Ni?=
 =?utf-8?B?SWlydjduNU9ONjZjUUo4L0tKSEpKU3JLMnAyYUo2bEVNRi9LTlJ3MjhxRnlJ?=
 =?utf-8?B?Slp5K2p0UkRMYUYrYnBVdmc3cUtINmwyRlRRd3BsNFovdzE1MU00V1FjSFRN?=
 =?utf-8?B?aFlHck5VOXlzYW1KU1lCd1pWVUE0YWZGbVEwVFh4L1dHenpkM0wwMGQ5YVJL?=
 =?utf-8?B?S0tFRGFGWkJpVzNVSGNlTWpZNXlZUjVLN09vTVpqMW9lbWszdE9VQ1NRLzFr?=
 =?utf-8?B?RWRLRHpGNUticWlKN1VtTUJTQ0pTTmRRcVFwRUJPRDU1bzIzbjFrTlZuZjlR?=
 =?utf-8?B?dXh0aGdRVTdsNFhaRUozSVV2REJyeEFMSkRFUzVmTkxobmQ3MUREaFhNaThs?=
 =?utf-8?B?MDZPSUEwTFNjSUNQcFJRS0NNQlFhS1RqTmtqOGNqZENFODA0QlYrM3hScG9w?=
 =?utf-8?B?VnVjUjEzbDRNMnB1WTQxbGZkWkFnNkRvb3A4Yk5GVFJFWklqdVhVMGlhTlF3?=
 =?utf-8?B?RUNQemlubW9uQTdsc2hzdnl1WGxvaVYyNGhsczlpekJqVTJtdW9BSUsxckdy?=
 =?utf-8?B?QURGTUZMdUNaZ2x5MkJrWGU3eGsxQkZLRDdFUW5VY1IwOUN3TVByOTdxTldW?=
 =?utf-8?B?N3BkSm44VVNUNzR2NkZTUldEOFN4WTAwYncrdlA3Zmd4MzkzN3RQSmdsZUpn?=
 =?utf-8?B?dUJ0aTFFZlN1MGxNajA1OGt5T0JpV0ljNFNvL1hlWjJGcVhGZWNuS3F0UnJu?=
 =?utf-8?B?UFdiUXY4b1A2VHpyaE8yWEV6YURQOFV1R0dnR25BRVpyYzg5QUZRUWZFNk03?=
 =?utf-8?B?RlhhbWdBVnp5NVhNa1p3bzMrRTRvcVFEQXVtY1F5YWZWWWpYcEFUZWRkMENN?=
 =?utf-8?B?K3VpeGI0S1R0b1poMmxpQUNlZTJUL3U2K0JuandVUDdDZWw5aldYenJHMnJT?=
 =?utf-8?B?Q0JIYnFFcnYxMjE1WnF4NU41dG9WdUhMK2VVdVNSVVBPK2lscThxT2pmbE5z?=
 =?utf-8?B?RXEzVWhwWDAwRFh0cVVUaGFrdXVKTyt4TnB1R1V0VGVXQzByQmRPMjA4Y2x0?=
 =?utf-8?B?a3J3YlNnNFp5VXMzVFFFUnkzMDVlYndjbWpoeDR5cFZyS0NqQ0RBZnlOcEJW?=
 =?utf-8?B?UFFUSmdPbTh3dEIyYWozdzRyZUtMU29ybmdsUkwwZHVOWnFmcWZ5ZGljKzV0?=
 =?utf-8?B?WVBySWpSSXh6bkJCM3RyK2FLKzBGdnN0VmorSGpFc0Q4cjRJWTRWUy9QWWoy?=
 =?utf-8?B?aWZzSkZSSURMY2xVcjFZVHVNVkFIR1hPSzk2aXZJeWtFeXhhQjVURWpvSjk2?=
 =?utf-8?Q?cqNERACUezFoI?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2069a3d-ac14-447b-4c0e-08df34417f59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:46:42.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR19MB693254

On Tue, Oct 27, 2026 at 09:34:53PM +0800, Shawn Lin wrote:
> Cc: Shengfei
> 
> 在 2026/10/27 星期二 21:17, Chris Morgan 写道:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the CW2217 i2c battery gauge. The gauge driver was
> > adapted from the Rockchip BSP driver [1].
> > 
> 
> I don't look into it to evaluate how much it differ from Shengfei's
> driver. If not too much, he deserves a credit here. I CCed him to
> look more into your submission version.

It shouldn't differ a lot, and I left his name in the file itself. I'll
include it on the next revision in the Signed-off/Co-developed line if
that works? Sorry for the oversight.

Thank you.

> 
> > [1] https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/power/supply/cw221x_battery.c
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   drivers/power/supply/Kconfig          |  11 +
> >   drivers/power/supply/Makefile         |   1 +
> >   drivers/power/supply/cw2217_battery.c | 818 ++++++++++++++++++++++++++
> >   3 files changed, 830 insertions(+)
> >   create mode 100644 drivers/power/supply/cw2217_battery.c
> > 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index b89ef40df7f8..6a5235ec16c1 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -141,6 +141,17 @@ config BATTERY_CW2015
> >   	  This driver can also be built as a module. If so, the module will be
> >   	  called cw2015_battery.
> > +config BATTERY_CW2217
> > +	tristate "CW2217 Battery driver"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y here to enable support for the cellwise cw2217
> > +	  battery fuel gauge (used in the Anbernic RG Vita Pro & others)
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called cw2217_battery.
> > +
> >   config BATTERY_DS2760
> >   	tristate "DS2760 battery driver (HP iPAQ & others)"
> >   	depends on W1
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > index f3c0d1006c1a..66e6303888c7 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
> >   obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
> >   obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
> >   obj-$(CONFIG_BATTERY_CW2015)	+= cw2015_battery.o
> > +obj-$(CONFIG_BATTERY_CW2217)	+= cw2217_battery.o
> >   obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
> >   obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
> >   obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
> > diff --git a/drivers/power/supply/cw2217_battery.c b/drivers/power/supply/cw2217_battery.c
> > new file mode 100644
> > index 000000000000..8b18db3d54db
> > --- /dev/null
> > +++ b/drivers/power/supply/cw2217_battery.c
> > @@ -0,0 +1,818 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Chrager driver for cw2217
> > + *
> > + * Copyright (c) 2026 Rockchip Electronics Co., Ltd.
> > + *
> > + * Author: Xu Shengfei <xsf@rock-chips.com>
> > + */
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/devm-helpers.h>
> > +#include <linux/i2c.h>
> > +#include <linux/minmax.h>
> > +#include <linux/module.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/regmap.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <asm/byteorder.h>
> > +
> > +#define CW2217_VERSION		0x00
> > +#define CW2217_CHIP_ID		0xA0
> > +
> > +#define CW2217_VCELL_H		0x02
> > +#define CW2217_VCELL_L		0x03
> > +
> > +#define CW2217_SOC_H		0x04
> > +#define CW2217_SOC_L		0x05
> > +
> > +#define CW2217_TEMP		0x06
> > +
> > +#define CW2217_CONFIG		0x08
> > +#define CW2217_CONFIG_ACT_MSK	GENMASK(7, 4)
> > +#define CW2217_CONFIG_SLEEP	(0x03 << 6)
> > +#define CW2217_CONFIG_RESTART	(0x03 << 4)
> > +#define CW2217_CONFIG_ACTIVE	(0x00)
> > +
> > +#define CW2217_INT_CONF		0x0A
> > +#define CW2217_EN_SOC_INT	BIT(6)
> > +#define CW2217_EN_TMX_INT	BIT(5)
> > +#define CW2217_EN_TMN_INT	BIT(4)
> > +
> > +#define CW2217_SOC_ALERT	0x0B
> > +#define CW2217_SOC_UPDATE_FLG	BIT(7)
> > +#define CW2217_SOC_ALERT_MSK	GENMASK(6, 0)
> > +#define CW2217_SOC_ALERT_OFF	0x0
> > +
> > +#define CW2217_TEMP_MAX		0x0C
> > +
> > +#define CW2217_TEMP_MIN		0x0D
> > +
> > +#define CW2217_CURRENT_H	0x0E
> > +#define CW2217_CURRENT_L	0x0F
> > +
> > +#define CW2217_BAT_PROFILE	0x10
> > +#define CW2217_PROFILE_SZ	80
> > +
> > +#define CW2217_T_HOST_H		0xA0
> > +#define CW2217_T_HOST_L		0xA1
> > +
> > +#define CW2217_USER_CONF	0xA2
> > +
> > +#define CW2217_CYCLECNT_H	0xA4
> > +#define CW2217_CYCLECNT_L	0xA5
> > +
> > +#define CW2217_SOH		0xA6
> > +
> > +/* This register not documented in datasheet. */
> > +#define CW2217_IC_STATE		0xA7
> > +#define CW2217_IC_READY_MASK	0x0C
> > +#define CW2217_IC_READY		3
> > +
> > +#define CW2217_STB_CUR_H	0xA8
> > +#define CW2217_STB_CUR_L	0xA9
> > +
> > +#define CW2217_FW_VERSION	0xAB
> > +#define CW2217_ID_MASK		GENMASK(7, 6)
> > +#define CW2215_ID		2
> > +#define CW2217_ID		1
> > +#define CW2218_ID		0
> > +
> > +/* Default values from BSP driver */
> > +#define CW2217_USER_RSENSE		1500
> > +#define CW2217_DEFAULT_POLL_INTERVAL_MS	5000
> > +
> > +struct cw2217_battery {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct power_supply *cw_bat;
> > +	u8 *bat_profile;
> > +	struct workqueue_struct *battery_workqueue;
> > +	struct delayed_work battery_delay_work;
> > +	int user_rsense;
> > +	int chip_id;
> > +	int voltage;
> > +	int soc;
> > +	int temp;
> > +	long cw_current;
> > +	int cycle;
> > +	int soh;
> > +	int fw_version;
> > +	u32 poll_interval_ms;
> > +	bool update_profile;
> > +};
> > +
> > +/*
> > + * The CONFIG register is used for the host MCU to configure the fuel gauge IC.
> > + * The default value is 0xF0, SLEEP and RESTART bits are set. To power up the
> > + * IC, the host MCU needs to write 0x30 to exit shutdown mode, and then write
> > + * 0x00 to restart the gauge to enter active mode. To reset the IC, the host
> > + * MCU needs to write 0xF0, 0x30 and 0x00 in sequence to this register to
> > + * complete the restart procedure. The CW2217 will reload relevant parameters
> > + * and settings and restart SOC calculation. Note that the SOC may be a
> > + * different value after reset operation since it is a brand-new calculation
> > + * based on the latest battery status. The BSP driver slept 20ms after restart
> > + * and 10ms after setting active, though no delays are documented in the
> > + * datasheet.
> > + */
> > +static int cw2217_active(struct cw2217_battery *cw_bat, bool active)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_write(cw_bat->regmap, CW2217_CONFIG,
> > +			   CW2217_CONFIG_RESTART);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fsleep(20000);
> > +
> > +	if (active) {
> > +		ret = regmap_write(cw_bat->regmap, CW2217_CONFIG,
> > +				   CW2217_CONFIG_ACTIVE);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		ret = regmap_write(cw_bat->regmap, CW2217_CONFIG,
> > +				   CW2217_CONFIG_SLEEP | CW2217_CONFIG_RESTART);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	fsleep(10000);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * The 0x00 register is an UNSIGNED 8bit read-only register. Its value is
> > + * fixed to 0xA0 in shutdown mode and active mode.
> > + */
> > +static int cw2217_get_chip_id(struct cw2217_battery *cw_bat)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_VERSION, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->chip_id = reg;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * The VCELL registers (0x02 0x03) are an UNSIGNED 14bit read-only register
> > + * that updates the battery voltage continuously. Battery voltage is measured
> > + * between the VCELL pin and VSS pin, which is the ground reference. A 14bit
> > + * sigma-delta A/D converter is used and the voltage resolution is 312.5uV
> > + * (0.3125mV is * 5/16).
> > + */
> > +static int cw2217_get_voltage(struct cw2217_battery *cw_bat)
> > +{
> > +	__be16 reg;
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(cw_bat->regmap, CW2217_VCELL_H,
> > +			       &reg, sizeof(reg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->voltage = ((be16_to_cpu(reg) * 5) / 16) * 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * The SOC registers (0x04 0x05) are an UNSIGNED 16bit read-only register that
> > + * indicates the SOC of the battery. The SOC shows in % format, which means
> > + * how much percent of the battery's total available capacity is remaining in
> > + * the battery now. The SOC can intrinsically adjust itself to cater to the
> > + * change of battery status; including load, temperature, and aging.
> > + * The high byte(0x04) contains the SOC in 1% unit which can be directly used
> > + * if this resolution is good enough for the application. The low byte (0x05)
> > + * provides more accurate fractional part of the SOC and its LSB is (1/256) %.
> > + * For now, we are only interested in the high byte.
> > + */
> > +static int cw2217_get_capacity(struct cw2217_battery *cw_bat)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_SOC_H, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->soc = clamp(reg, 0, 100);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * The TEMP register is an UNSIGNED 8bit read only register.
> > + * It reports the real-time battery temperature
> > + * measured at TS pin. The scope is from -40 to 87.5 degrees Celsius,
> > + * LSB is 0.5 degree Celsius. TEMP(C) = - 40 + Value(0x06 Reg) / 2
> > + */
> > +static int cw2217_get_temp(struct cw2217_battery *cw_bat)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_TEMP, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->temp = ((int)reg / 2) - 40;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Current is a signed 16bit register (0x0E 0x0F) that reports current A/D
> > + * converter result of the voltage across the current sense resistor,
> > + * 10mohm typical. The register value should be divided by the sense
> > + * resistance to convert to amperes. The value of the sense resistor
> > + * determines the resolution and the full-scale range of the current readings.
> > + * The LSB of 0x0F is (52.4/32768)uV for CW2215 and CW2217. The LSB of 0x0F is
> > + * (125/32768)uV for CW2218.
> > + */
> > +static int cw2217_get_current(struct cw2217_battery *cw_bat)
> > +{
> > +	s32 cw_current;
> > +	__be16 reg;
> > +	u8 fw_ver;
> > +	int ret;
> > +
> > +	if (cw_bat->fw_version == 0) {
> > +		cw_bat->cw_current = 0;
> > +		dev_err(cw_bat->dev, "Error! CW2217 firmware read error!\n");
> > +		return -EIO;
> > +	}
> > +
> > +	ret = regmap_bulk_read(cw_bat->regmap, CW2217_CURRENT_H,
> > +			       &reg, sizeof(reg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_current = (s16)be16_to_cpu(reg);
> > +
> > +	fw_ver = FIELD_GET(CW2217_ID_MASK, cw_bat->fw_version);
> > +	switch (fw_ver) {
> > +	case CW2215_ID:
> > +	case CW2217_ID:
> > +		cw_current = (cw_current * 1600) / (cw_bat->user_rsense / 1000);
> > +		cw_bat->cw_current = cw_current * 1000;
> > +		break;
> > +	case CW2218_ID:
> > +		cw_current = (cw_current * 3815) / (cw_bat->user_rsense / 1000);
> > +		cw_bat->cw_current = cw_current * 1000;
> > +		break;
> > +	default:
> > +		cw_bat->cw_current = 0;
> > +		dev_err(cw_bat->dev, "Error! CW2217 firmware read error!\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * CYCLECNT is an UNSIGNED 16bit register (0xA4 0xA5) that counts cycle life
> > + * of the battery. The LSB of 0xA5 stands for 1/16 cycle. This register will
> > + * be cleared after entering shutdown mode.
> > + */
> > +static int cw2217_get_cycle_count(struct cw2217_battery *cw_bat)
> > +{
> > +	__be16 reg;
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(cw_bat->regmap, CW2217_CYCLECNT_H,
> > +			       &reg, sizeof(reg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->cycle = be16_to_cpu(reg) / 16;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * SOH (State of Health) is an UNSIGNED 8bit register(0xA6) that represents the level of
> > + * battery aging by tracking battery internal impedance increment. When the device enters
> > + * active mode, this register refresh to 0x64 by default. Its range is 0x00 to 0x64,
> > + * indicating 0 to 100%. This register will be clear after enters shutdown mode.
> > + */
> > +static int cw2217_get_soh(struct cw2217_battery *cw_bat)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_SOH, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->soh = clamp(reg, 0, 100);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * FW_VERSION register reports the firmware (FW) running in the chip. It is
> > + * fixed to 0x00 when the chip is in shutdown mode. When in active mode,
> > + * Bit [7:6] = '01' stand for the CW2217, Bit [7:6] = '00' stand for the
> > + * CW2218 and Bit [7:6] = '10' stand for CW2215. Bit[5:0] stand for the FW
> > + * version running in the chip. Note that the FW version is subject to update.
> > + */
> > +static int cw2217_get_fw_version(struct cw2217_battery *cw_bat)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_FW_VERSION, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cw_bat->fw_version = reg;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cw2217_update_data(struct cw2217_battery *cw_bat)
> > +{
> > +	int ret;
> > +
> > +	ret = cw2217_get_voltage(cw_bat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cw2217_get_capacity(cw_bat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cw2217_get_temp(cw_bat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cw2217_get_current(cw_bat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cw2217_get_cycle_count(cw_bat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return cw2217_get_soh(cw_bat);
> > +}
> > +
> > +static int cw2217_parse_properties(struct cw2217_battery *cw_bat)
> > +{
> > +	struct device *dev = cw_bat->dev;
> > +	int length;
> > +	int ret;
> > +
> > +	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms",
> > +				       &cw_bat->poll_interval_ms);
> > +	if (ret) {
> > +		dev_dbg(cw_bat->dev, "Using default poll interval\n");
> > +		cw_bat->poll_interval_ms = CW2217_DEFAULT_POLL_INTERVAL_MS;
> > +	}
> > +
> > +	/*
> > +	 * Datasheet only lists options of between 1M and 50M for resistor
> > +	 * values, so assuming that is all and clamping if out of range.
> > +	 */
> > +	ret = device_property_read_u32(dev,
> > +				       "shunt-resistor-micro-ohms",
> > +				       &cw_bat->user_rsense);
> > +	if (ret) {
> > +		cw_bat->user_rsense = CW2217_USER_RSENSE;
> > +		dev_warn(cw_bat->dev,
> > +			 "Using default resistor value, reported mA may be wrong\n");
> > +	}
> > +
> > +	/* Clamp, but also warn we're clamping due to out of range. */
> > +	if ((cw_bat->user_rsense < 1000000) || (cw_bat->user_rsense > 50000000)) {
> > +		cw_bat->user_rsense = clamp(cw_bat->user_rsense, 1000000, 50000000);
> > +		dev_warn(cw_bat->dev, "Shunt resistor value out of range, setting to %d",
> > +			 cw_bat->user_rsense);
> > +	}
> > +
> > +	length = device_property_count_u8(dev, "cellwise,battery-profile");
> > +	if (length < 0) {
> > +		dev_warn(cw_bat->dev,
> > +			 "No battery-profile found, using current flash contents\n");
> > +	} else if (length != CW2217_PROFILE_SZ) {
> > +		dev_err(cw_bat->dev, "battery-profile must be %d bytes\n",
> > +			CW2217_PROFILE_SZ);
> > +		return -EINVAL;
> > +	} else {
> > +		cw_bat->bat_profile = devm_kzalloc(dev, length, GFP_KERNEL);
> > +		if (!cw_bat->bat_profile)
> > +			return -ENOMEM;
> > +
> > +		ret = device_property_read_u8_array(dev,
> > +						    "cellwise,battery-profile",
> > +						    cw_bat->bat_profile,
> > +						    length);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Load a new battery profile provided from the device tree. */
> > +static int cw2217_update_config(struct cw2217_battery *cw_bat)
> > +{
> > +	u32 reg;
> > +	int ret;
> > +
> > +	/* Set the battery monitor state to shutdown. */
> > +	ret = cw2217_active(cw_bat, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* update new battery info */
> > +	ret = regmap_raw_write(cw_bat->regmap, CW2217_BAT_PROFILE,
> > +			       cw_bat->bat_profile, CW2217_PROFILE_SZ);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Set update flag for new profile and disable SOC alert. */
> > +	ret = regmap_write(cw_bat->regmap, CW2217_SOC_ALERT,
> > +			   CW2217_SOC_UPDATE_FLG | CW2217_SOC_ALERT_OFF);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* mask all interrupts */
> > +	ret = regmap_clear_bits(cw_bat->regmap, CW2217_INT_CONF,
> > +				CW2217_EN_SOC_INT | CW2217_EN_TMX_INT | CW2217_EN_TMN_INT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cw2217_active(cw_bat, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Check the undocumented register for bits 2 and 3 to be 1. Note that
> > +	 * the BSP driver would sleep 100ms after every iteration and retry up
> > +	 * to 50 times, this felt excessive so reducing to 10.
> > +	 */
> > +	ret = regmap_read_poll_timeout(cw_bat->regmap, CW2217_IC_STATE, reg,
> > +				       FIELD_GET(CW2217_IC_READY_MASK, reg) == CW2217_IC_READY,
> > +				       100 * USEC_PER_MSEC, 10 * USEC_PER_SEC);
> > +	if (ret) {
> > +		dev_err(cw_bat->dev,
> > +			"Gauge did not become ready after profile upload\n");
> > +		cw2217_active(cw_bat, false);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Determine whether the battery profile needs to be updated. */
> > +static int cw2217_check_profile(struct cw2217_battery *cw_bat)
> > +{
> > +	u8 bat_info[CW2217_PROFILE_SZ];
> > +	int ret;
> > +	u32 reg;
> > +
> > +	cw_bat->update_profile = false;
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_CONFIG, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Active is 0x00, anything else is inactive */
> > +	if (FIELD_GET(CW2217_CONFIG_ACT_MSK, reg)) {
> > +		cw_bat->update_profile = true;
> > +		return 0;
> > +	}
> > +
> > +	ret = regmap_read(cw_bat->regmap, CW2217_SOC_ALERT, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (FIELD_GET(CW2217_SOC_UPDATE_FLG, reg) == 0) {
> > +		cw_bat->update_profile = true;
> > +		return 0;
> > +	}
> > +
> > +	ret = regmap_raw_read(cw_bat->regmap, CW2217_BAT_PROFILE, bat_info, CW2217_PROFILE_SZ);
> > +	if (ret) {
> > +		dev_err(cw_bat->dev, "Failed to read existing battery profile\n");
> > +		return ret;
> > +	}
> > +
> > +	if (memcmp(bat_info, cw_bat->bat_profile, CW2217_PROFILE_SZ)) {
> > +		dev_warn(cw_bat->dev, "Replacing stored battery profile\n");
> > +		cw_bat->update_profile = true;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cw2217_init(struct cw2217_battery *cw_bat)
> > +{
> > +	int ret;
> > +
> > +	ret = cw2217_get_chip_id(cw_bat);
> > +	if (ret)
> > +		return dev_err_probe(cw_bat->dev, ret, "I2C read write error");
> > +
> > +	/*
> > +	 * All of the known Cellwise 221x chips set the ID bits to 0xa0. If it
> > +	 * doesn't match, we're trying to probe the wrong hardware.
> > +	 */
> > +	if (cw_bat->chip_id != CW2217_CHIP_ID)
> > +		return dev_err_probe(cw_bat->dev, -ENODEV, "Not a cw221x\n");
> > +
> > +	ret = cw2217_check_profile(cw_bat);
> > +	if (ret) {
> > +		dev_err(cw_bat->dev, "i2c read write error");
> > +		return ret;
> > +	}
> > +
> > +	if (cw_bat->update_profile) {
> > +		ret = cw2217_update_config(cw_bat);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void cw2217_bat_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *delay_work;
> > +	struct cw2217_battery *cw_bat;
> > +	int ret;
> > +
> > +	delay_work = container_of(work,
> > +				  struct delayed_work,
> > +				  work);
> > +
> > +	cw_bat = container_of(delay_work,
> > +			      struct cw2217_battery,
> > +			      battery_delay_work);
> > +
> > +	ret = cw2217_update_data(cw_bat);
> > +	if (ret)
> > +		dev_err(cw_bat->dev, "i2c read error when update data");
> > +
> > +	queue_delayed_work(cw_bat->battery_workqueue,
> > +			   &cw_bat->battery_delay_work,
> > +			   msecs_to_jiffies(cw_bat->poll_interval_ms));
> > +}
> > +
> > +static int cw2217_battery_get_property(struct power_supply *psy,
> > +				   enum power_supply_property psp,
> > +				   union power_supply_propval *val)
> > +{
> > +	struct cw2217_battery *cw_bat = power_supply_get_drvdata(psy);
> > +	int ret = 0;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> > +		val->intval = cw_bat->cycle;
> > +		break;
> > +	case POWER_SUPPLY_PROP_CAPACITY:
> > +		val->intval = cw_bat->soc;
> > +		break;
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		/*
> > +		 * Observed when battery was full that it would report
> > +		 * approximately -12mv at between 97-99 SoC. Assume that if the
> > +		 * battery current is above 0 it's charging, it's below
> > +		 * 0 but with an SoC 95% or above it's not charging because
> > +		 * it's full, otherwise it's simply not charging. If it's not
> > +		 * supplied it is discharging.
> > +		 */
> > +		if (power_supply_is_system_supplied()) {
> > +			if (cw_bat->cw_current > 0)
> > +				val->intval = POWER_SUPPLY_STATUS_CHARGING;
> > +			else if (cw_bat->soc >= 95)
> > +				val->intval = POWER_SUPPLY_STATUS_FULL;
> > +			else
> > +				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +		} else
> > +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > +		break;
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +		val->intval = (cw_bat->voltage <= 0) ? 0 : 1;
> > +		break;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		val->intval = cw_bat->voltage;
> > +		break;
> > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +		val->intval = cw_bat->cw_current;
> > +		break;
> > +	case POWER_SUPPLY_PROP_STATE_OF_HEALTH:
> > +		val->intval = cw_bat->soh;
> > +		break;
> > +	case POWER_SUPPLY_PROP_TEMP:
> > +		val->intval = cw_bat->temp;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static enum power_supply_property cw2217_battery_properties[] = {
> > +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> > +	POWER_SUPPLY_PROP_CAPACITY,
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
> > +	POWER_SUPPLY_PROP_TEMP,
> > +};
> > +
> > +static const struct power_supply_desc cw2217_bat_desc = {
> > +	.name		= "cw2217-battery",
> > +	.type		= POWER_SUPPLY_TYPE_BATTERY,
> > +	.properties	= cw2217_battery_properties,
> > +	.num_properties	= ARRAY_SIZE(cw2217_battery_properties),
> > +	.get_property	= cw2217_battery_get_property,
> > +};
> > +
> > +static const struct regmap_range cw2217_ranges_rd_yes[] = {
> > +	regmap_reg_range(CW2217_VERSION, CW2217_VERSION),
> > +	regmap_reg_range(CW2217_VCELL_H, CW2217_TEMP),
> > +	regmap_reg_range(CW2217_CONFIG, CW2217_CONFIG),
> > +	regmap_reg_range(CW2217_INT_CONF, CW2217_CURRENT_L),
> > +	regmap_reg_range(CW2217_BAT_PROFILE,
> > +			 CW2217_BAT_PROFILE + CW2217_PROFILE_SZ - 1),
> > +	regmap_reg_range(CW2217_T_HOST_H, CW2217_USER_CONF),
> > +	regmap_reg_range(CW2217_CYCLECNT_H, CW2217_STB_CUR_L),
> > +	regmap_reg_range(CW2217_FW_VERSION, CW2217_FW_VERSION),
> > +};
> > +
> > +static const struct regmap_access_table cw2217_rd_table = {
> > +	.yes_ranges = cw2217_ranges_rd_yes,
> > +	.n_yes_ranges = ARRAY_SIZE(cw2217_ranges_rd_yes),
> > +};
> > +
> > +static const struct regmap_range cw2217_ranges_wr_yes[] = {
> > +	regmap_reg_range(CW2217_TEMP, CW2217_TEMP),
> > +	regmap_reg_range(CW2217_CONFIG, CW2217_CONFIG),
> > +	regmap_reg_range(CW2217_INT_CONF, CW2217_CURRENT_L),
> > +	regmap_reg_range(CW2217_BAT_PROFILE,
> > +			 CW2217_BAT_PROFILE + CW2217_PROFILE_SZ - 1),
> > +	regmap_reg_range(CW2217_T_HOST_H, CW2217_USER_CONF),
> > +};
> > +
> > +static const struct regmap_access_table cw2217_wr_table = {
> > +	.yes_ranges = cw2217_ranges_wr_yes,
> > +	.n_yes_ranges = ARRAY_SIZE(cw2217_ranges_wr_yes),
> > +};
> > +
> > +static const struct regmap_range cw2217_ranges_vol_yes[] = {
> > +	regmap_reg_range(CW2217_VCELL_H, CW2217_TEMP),
> > +	regmap_reg_range(CW2217_INT_CONF, CW2217_SOC_ALERT),
> > +	regmap_reg_range(CW2217_CURRENT_H, CW2217_CURRENT_L),
> > +	regmap_reg_range(CW2217_CYCLECNT_H, CW2217_STB_CUR_L),
> > +};
> > +
> > +static const struct regmap_access_table cw2217_vol_table = {
> > +	.yes_ranges = cw2217_ranges_vol_yes,
> > +	.n_yes_ranges = ARRAY_SIZE(cw2217_ranges_vol_yes),
> > +};
> > +
> > +static const struct regmap_config cw2217_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.rd_table = &cw2217_rd_table,
> > +	.wr_table = &cw2217_wr_table,
> > +	.volatile_table = &cw2217_vol_table,
> > +	.cache_type = REGCACHE_MAPLE,
> > +	.max_register = CW2217_FW_VERSION,
> > +};
> > +
> > +static int cw2217_probe(struct i2c_client *client)
> > +{
> > +	struct power_supply_config psy_cfg = { 0 };
> > +	struct cw2217_battery *cw_bat;
> > +	int ret;
> > +
> > +	cw_bat = devm_kzalloc(&client->dev, sizeof(*cw_bat), GFP_KERNEL);
> > +	if (!cw_bat)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, cw_bat);
> > +	cw_bat->dev = &client->dev;
> > +
> > +	cw_bat->regmap = devm_regmap_init_i2c(client, &cw2217_regmap_config);
> > +	if (IS_ERR(cw_bat->regmap))
> > +		return dev_err_probe(cw_bat->dev, PTR_ERR(cw_bat->regmap),
> > +				     "Failed to allocate regmap: %ld\n",
> > +				     PTR_ERR(cw_bat->regmap));
> > +
> > +	ret = cw2217_parse_properties(cw_bat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cw2217_init(cw_bat);
> > +	if (ret)
> > +		return dev_err_probe(cw_bat->dev, ret, "cw2217 init fail\n");
> > +
> > +	ret = cw2217_get_fw_version(cw_bat);
> > +	if (ret)
> > +		return dev_err_probe(cw_bat->dev, ret,
> > +				     "Unable to read fw version\n");
> > +
> > +	ret = cw2217_update_data(cw_bat);
> > +	if (ret)
> > +		return dev_err_probe(cw_bat->dev, ret,
> > +				     "Unable to read initial data\n");
> > +
> > +	psy_cfg.drv_data = cw_bat;
> > +	cw_bat->cw_bat = devm_power_supply_register(&client->dev,
> > +						    &cw2217_bat_desc, &psy_cfg);
> > +	if (IS_ERR(cw_bat->cw_bat))
> > +		return dev_err_probe(cw_bat->dev, PTR_ERR(cw_bat->cw_bat),
> > +				     "Failed to register battery: %ld\n",
> > +				     PTR_ERR(cw_bat->cw_bat));
> > +
> > +	cw_bat->battery_workqueue = devm_alloc_ordered_workqueue(&client->dev,
> > +								 "cw2217_gauge", 0);
> > +	if (!cw_bat->battery_workqueue)
> > +		return -ENOMEM;
> > +
> > +	ret = devm_delayed_work_autocancel(&client->dev,
> > +					   &cw_bat->battery_delay_work,
> > +					   cw2217_bat_work);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Failed to register delayed work\n");
> > +
> > +	queue_delayed_work(cw_bat->battery_workqueue,
> > +			   &cw_bat->battery_delay_work,
> > +			   msecs_to_jiffies(50));
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused cw2217_bat_suspend(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct cw2217_battery *cw_bat = i2c_get_clientdata(client);
> > +
> > +	cancel_delayed_work(&cw_bat->battery_delay_work);
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused cw2217_bat_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct cw2217_battery *cw_bat = i2c_get_clientdata(client);
> > +
> > +	queue_delayed_work(cw_bat->battery_workqueue,
> > +			   &cw_bat->battery_delay_work,
> > +			   msecs_to_jiffies(20));
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(cw2217_bat_pm_ops, cw2217_bat_suspend,
> > +			 cw2217_bat_resume);
> > +
> > +static const struct i2c_device_id cw2217_id_table[] = {
> > +	{ .name = "cw2215" },
> > +	{ .name = "cw2217" },
> > +	{ .name = "cw2218" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, cw2217_id_table);
> > +
> > +static const struct of_device_id cw2217_match_table[] = {
> > +	{ .compatible = "cellwise,cw2215", },
> > +	{ .compatible = "cellwise,cw2217", },
> > +	{ .compatible = "cellwise,cw2218", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, cw2217_match_table);
> > +
> > +static struct i2c_driver cw2217_driver = {
> > +	.driver = {
> > +		.name = "cw2217",
> > +		.pm = &cw2217_bat_pm_ops,
> > +		.of_match_table = of_match_ptr(cw2217_match_table),
> > +	},
> > +	.probe = cw2217_probe,
> > +	.id_table = cw2217_id_table,
> > +};
> > +
> > +module_i2c_driver(cw2217_driver);
> > +
> > +MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
> > +MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
> > +MODULE_DESCRIPTION("cw2217 battery driver");
> > +MODULE_LICENSE("GPL");
> 
