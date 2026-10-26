Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.35.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793009298;
	b=dn8stK4O7U+Q/wszSaAfn76DZ6+LtIkwgqLUtcDJJ7Ga3DVstyphbrcgCpCRi4S2FaaT
	 Gau0zFnhk/DcZQWejRAnu0xuKVnJv54FvTvrfU9w76Ov2DAwoTWIJjBhUaUsz/QumEAEX
	 rbyLDNLga+pTz7k8QLkkAvqW+y32R/pjle8FWvAmgRmhtRhIAxYQKG6u7n7WARc8hRgCV
	 u/tj42LIIjEcepRKjVrnQmwzFRT6h39gOIf6gp6ZxWq7YijbB8lHPDGCqFY22hd5cQmXH
	 errSSoCRRxeTeWxOaPcxAYG9QOxPjxvHcYbbndFnx/Q8lKFzlJGCavaoM4pJiwfAllg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009298;
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
	bh=Jh3gJDtE8sPEumE5jIP9Jhv1Exct2n9Bhk02xWe4QPY=;
	b=OxPIEbkLAz3eDrq26/FuVX+0hgucrop9NQa6yv/WOmGvRcPQ+NU5OasLuz4lYRuL4+G6
	 qkiAC9Au+w3jwlCshz1suOhJEwbb4oCi3BgbYmO3bhafDglVPZL1tGK0jK9X0YsAT8Qhn
	 CaAdMW+HO4aRZkan9pRIAB85+XbbH9P9gzPVtSDwQC2spHvSlEMK6WZAreHZoHGBUjXW4
	 8jgEYNisi+c0JgDR6P8kl82RPPchmsF2rtS5Zwx2aqm0GGFpegYJ2u2aimLH1xNcydb2g
	 VtWnMlfAKCaKfhaf6wxEO/j7E8XbNtLnDzpdeKenewmgka2TP2I0hGoaCFxYTw/Pq0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=outlook.de;
	spf=pass smtp.mailfrom=outlook.de;
	dkim=pass header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=RCBlX9sv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.35.73
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013073.outbound.protection.outlook.com [52.103.35.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D4606A31B;
	Mon, 26 Oct 2026 10:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 266D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=RCBlX9sv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN6ssiP/qpxt1+jIDBoBGBEH1kvjuj/vzLUqpbYawT1MxL9npes0JP4MkDoKXm+XHxS+arm3tUF06gQW7m1UPrrqM40HaLztDl7RXbITdbSrYAHsKWq4zLQjgNgm2qGO00nXxFa3OFdEIIKbFrokcv/DYQyJJsQPrdy7g2+Pvp8TGI+n5uxvELxQFoZDTBtDhyu16Gmg+9s17RztKVop69Hul5BNuuWslf/nGdnKuAE7KsG5x1Zujq0z0G5Ivt8rHqRxE/0Ykaezdi5LINMPh59Bg7cpziQivmGLTy3bjJvXa+fs322Z+gI+WRdc/69qaTCy6v/9kaeZS/4MJUHRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh3gJDtE8sPEumE5jIP9Jhv1Exct2n9Bhk02xWe4QPY=;
 b=K+Y+vGwW41SkWx7+9kawhKv/bOupNXj6Z6sVC+Vc8M5AR0nzMdGeUiO/Dk27/q7LTj6cPWv3KcCTBWAyxnJ5Z0oRzhwQnItIJSmCbncVZT7QzrzXhQgQV9G6ygG39USnpra1eEjfqDj9rd8WTxQA3rCAV6YHSs6Greqljjc1ZJPEhODc2BbPpK4RpgvXS5SCvy1ujEDGwxARkqCy0Ve6Wvre7vVlGBGrCE4lFwRUdjZvMVR7Y0o+4Grq41CUG3sVlWhdkugYQ89B6uTKt7PN/S8BbHlgwbuSYRIKfGpjv8IufxYmBJaarHwmJBw4BTvJ+s+okdvV9pZasFjoSPh+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh3gJDtE8sPEumE5jIP9Jhv1Exct2n9Bhk02xWe4QPY=;
 b=RCBlX9svj7XWjVZdAkUUDAc/GIWKeCQY9rk43pZ81yZP1jSxtdnnrZg8lcGZnpCMGsDJPCtcWDgAVTRfvY+KmhpSjwt71zrUAIXWiWFUYJ8Gwx+3s0hVELfTs1YGNpjnP7pnpUC9Dnp4D234YkzD6a7RS+CbsGXuXez0/u2MruQ0DKmzCtboCVOdAMZmMwTWzdGHTqo+QFAo4pGGj7GFiCO+j43MWMfV56wEUtalcKDBiJBPMpJpMKx1xta2MtC8EKAg3mtZiXz+OZuNnbVZgVhfaALmpWT4pCpTQ7Nhw9VCwqinR9syRFyIWhVJ18ZO38Nzn35fr8mQBzEo5jgp5g==
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19) by AS8PR08MB9361.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 26 Oct
 2026 10:08:15 +0000
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5]) by MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:08:15 +0000
Message-ID:
 <MMZPR08MB549315DB32DCE8589A27E461B5DF612@MMZPR08MB549315.eurprd08.prod.outlook.com>
Date: Mon, 26 Oct 2026 11:08:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com,
 khilman@baylibre.com, martin.blumenstingl@googlemail.com, rafael@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
 <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
 <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
Content-Language: en-US
From: =?UTF-8?Q?Christain_Stefan_K=C3=B6ver-Draxl?= <ckoever@outlook.de>
In-Reply-To: <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19)
X-Microsoft-Original-Message-ID:
 <792d5a57-ba6f-4100-8145-7f863435a7c4@outlook.de>
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
X-MS-TrafficTypeDiagnostic: MMZPR08MB549315:EE_|AS8PR08MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: da040348-fd84-4b6d-7fff-08df33490cfb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|39105399006|22141099003|25010399006|4140399003|19110799012|23021999003|8060799015|5072599009|15080799012|19101099003|6090799003|41105399003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkt4NHhiRmlXeE10ZklNZGMrWGtNTEJPaGxDRUF6engrZ1YvaEprZFRDNkoy?=
 =?utf-8?B?QW9UVWw4SnRKcjJJdjF3MUhOMGlDTFVlM2JZRGl5K3l3M2plY0pqU05qS2hq?=
 =?utf-8?B?bGVoYUxaSzh1SzEyNkNhWHRzdWdwU0Zma2JLVzVuQUlybzNuajdmOEcrVHpJ?=
 =?utf-8?B?bGdjSUxEREIwcUlzTXRWbkRuaUFZaUx4bnZ4NU81b0VUWkpYcFpRWG5oMyty?=
 =?utf-8?B?RDVJMjZiVXYwUGw1aHRiNithWTV3WXZPNFhWcFJNMVR4Qi90bmlYRjBMTEsy?=
 =?utf-8?B?aDFkK0t3b24wQ1NhUHRvbDUzQ05OcDNwZGhjb1ZnQWc5bXZtdnpEUkJEZVVW?=
 =?utf-8?B?cEZRRmQ2MUlXTzZ2bUJGck5TeXE4TU96THpHbVpjSjZKSVNQLzRiT3QrbjhO?=
 =?utf-8?B?RlFXNnQyZ0lHTjlDeDZ0SnZEVU1FQWtQdFA0Mmo1Z1MvNERneVpoeldNTnAx?=
 =?utf-8?B?QXVyU0V1cWhZZ3UybTQrRUtkdFhpTDQ3Vlljb09pMFkwZ1JINlZQUU50TGZR?=
 =?utf-8?B?M3BKU0ZObGk1dTRiS1lKRnE2MWh0V3NFdUdudmtjdVZZOXQyWDYxMzAwdHpk?=
 =?utf-8?B?ZVNKM1dLWFFQSzZGK2ZvQWhDNTJKYnJlZC9mcmxxSG5NWmJXMDdwaXo5bFZR?=
 =?utf-8?B?N2Q0Vzk5MUg1cjAwd01TKytLbG9KRVVvRU8xdWh3ZGxGOWY5OVB1N09UcTQ2?=
 =?utf-8?B?SURwcFBEVEp3LzZjTWN6Z1pOT1Q0ZEtnejFmVzlsc2Z6NjF1MXJlcWtuY1cr?=
 =?utf-8?B?OW1UN0R0OUlIZWQya0NrekdnaU5VZnJEdmdSSmRHd090MWc1RXhEbmxUc0tG?=
 =?utf-8?B?WXdla0hUYkZIR2pobGtBdDhMN2ZiK0FNbWZqbEZTUTJRNXhwdyt2OGpFU3Nv?=
 =?utf-8?B?dGVDTVFPL3kwaGRqU2NsRmx6WFNFMXA2RGRYV3lpeUNHZGdHcmJtaHNHdlgz?=
 =?utf-8?B?aEQ3OCt3alllemJmNjNhdFFEU3ZqRVU5aTM5eDRNZ0M0Z2k2bkY3Yyt5MGw4?=
 =?utf-8?B?eFQwQjhzWjBJUHR3TzBqWm9TaU51VXVwTXhrVUk0VXFyQzVqamJFd1c3b0Vr?=
 =?utf-8?B?N2NoeGFqTmtjc25iSjFBM2ZZQTJKSG1zNDNXT1FNamlBVXhJUmhXWjFKNm1U?=
 =?utf-8?B?RXVlMm1yTnhJVEN4a2ZtTkxYaU9yNTVhems1ME0zcFhrbnZXU1BoTWNiNnE0?=
 =?utf-8?B?QkpRc1BuQk9nNnRJSFU4cWI1RFBDRTgwbmw1LzN2VEcwWmJuU1VGOTYzRnlC?=
 =?utf-8?B?Uzk1UXBjd0hjNVBrcDQ5S29xVHl4WThGT3RMUkZ3cnpSbnZGZDcrazZkREZC?=
 =?utf-8?B?RUl5UFFIRXFJc3ErYnFCaEpkalVCQVJRRVAvdkxoS0N5RTVLRmp3SzdFbXA3?=
 =?utf-8?B?am5UU0IzTENVR1RIaG1ia1JOdDJ3aXgxM0lpd3RtRFhPeStsanozcjhwOVV6?=
 =?utf-8?Q?cKdvhWTw?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFBU3cxQVJvUlAzcnFxTEpEdUJycWpwNHNib3Fjem5rNmpKMSsxVmh5K3I5?=
 =?utf-8?B?SmFmK0paTFM0Nm9sQmcrU2pHeXZCaDBPdnl1MmFEckx4NVAxbXRwVkpKM2pQ?=
 =?utf-8?B?ejJpUUxnSVI3V0wzTWFsR01YZ2xNd1RiaFh0V1c5d0VCa25STW1tZnhWSy9h?=
 =?utf-8?B?VktOSWxFU3YvMEpmR3dJT09YS2hkeGRFYmU2TjRlbjB1N043eDFzNmZoT1BR?=
 =?utf-8?B?amt5N3hrbE1zTVBYQkU0cmhJbEpqeXhmOFdMekQxdUZ2cmpRZk5DaVFzWUhl?=
 =?utf-8?B?czhmYzRJR3NzS1YwSGZMUElKOVZSdk9neiswVVN5TmFEQWFDNzZHdE91Qmdn?=
 =?utf-8?B?eEVVVXpZMmxnb3d1cGtnQzFMK0p5Nit5K1VzUDFtL2g3Q2hkSCtzYkZxeVNt?=
 =?utf-8?B?eFBZbFpkOUMxWWxOOWlraEVwZUFvOGlJaGIwbXZRWFhURUhPUnR0enYyUGo5?=
 =?utf-8?B?bEdtY3dReDNocjhYMGxiMmZNUkNDUVYrL291R0kxVWl3dFNEZWdESU94VU1E?=
 =?utf-8?B?LzlsTXdtKzJCQU5NMUZpY042VDFqTTVhQkQ5Q0xhWEJIK1ZTaVpndis0NkVr?=
 =?utf-8?B?UzVWTFVhZkJsRmM0eEtLOVdleVVscnV1L2NTYW1mN0h3ekVqWEN5QzRWZ1l1?=
 =?utf-8?B?US92N21uUnlqc3lCNmc0UnAyYTV1MlpMUk9Yb1daYiszc2xyRW1iZDNrdFdt?=
 =?utf-8?B?bTBBWSt3L0lwZDRKalF5RVhWbTNLcS9EbXF5cFAwZ2ZwZ1JTRER0Sk1PSGN0?=
 =?utf-8?B?dWxUendZWUFOZ0pvWm9QS1hyVHBMYi9EWDR4R3dwbHhuMVZqS2N4aVZIZ3E2?=
 =?utf-8?B?WnFjeFB2WHlSSkxYcS9YMUM2VTg5L0RQK0JnSjQ1WXBuZDNxVTU2TzBpUjFp?=
 =?utf-8?B?SVRySVNxb2dPNi9tUU5iRzgxWFJDbCtNNEFDeW5tbkE5RXdjbFdpNjRLLzIv?=
 =?utf-8?B?UDQwR0t2L1RLWktUZmRKNDVGYlRjVFI3NDZtUHB2NTdvRnJWMXAzRmgyRWdT?=
 =?utf-8?B?aTdmQzRsbXNNNHI2d25qcGV5Wm0vL2k1VllRaUJSNkQyVzJ4RVlhUFVzODBL?=
 =?utf-8?B?dUMzYnRxR0NXbUVZd3RBUUpCVThUTCtYc1dSSkF1LzFpSDVjd2x6Q1k4bUc1?=
 =?utf-8?B?cnpXcDJwZVRrSjNnNG9Ga0RjZ09pZXlGWmc2aFl5eTQvTHp4Um9HdjF2RUtX?=
 =?utf-8?B?aDREN00vV0I4ak1velkzWHUrNnFWWVdWQ1ZDZzFGRkIwdmN4Q0dEUGw5Uzhx?=
 =?utf-8?B?WGZtcnJReG55MGtXR0s0RjNoUllJUHpEdVhyZFlnVWNrU2RWeE15V3J5TW5R?=
 =?utf-8?B?QmJIVTJMME15SDNrUkxyRmZhS1BvVmZlMjgwSlpnZC9iQy9Ca0NBZ0JYZHVt?=
 =?utf-8?B?K2ZCZStseDFidHBmWEhuZDFsbVdMNzFKUit0dkV0cXZPSy95U1diYmIwZkpF?=
 =?utf-8?B?NkNJOHdzU3didDRZOTd3SXM5YnpzMzNxTVQ4UFArcStoZ2piUVkyWGl5SlBw?=
 =?utf-8?B?NjZzQi9CZWNJSTdzMHFOaXNTMytEbk9XdEJQRU0xbXJIOWlpNVlnMnQrU1dv?=
 =?utf-8?B?cHQ5QTRFL1hzQ0ZjQ290a3VNa3NPbXFlSENqb2E4alNadE9Hd25TaTFwV0dp?=
 =?utf-8?B?UHBKOHlUVVFkckJmYkZQZytxVjhSVThHdk9PMTdpM0xWdzBtN1o2bkZOYnBm?=
 =?utf-8?B?OTR1cSsxQnpPSTNEcUJ2VXNlcVRla05wVk5oa0dhdEdFa09QaEhVVFczMW1G?=
 =?utf-8?B?amhyMHMrb2NzMHBkdnBMRUdWaXZwdzVxRHZhZmxIQ2krYkF0YWJmTGNyNVNh?=
 =?utf-8?B?YmtWZXZHWmQwUGp6TmdpajRvL3RQWUVSYmRGUStjNDdhMHUwSTZwS0h2bkJN?=
 =?utf-8?Q?xIcN3KgFzrLsz?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fbb9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: da040348-fd84-4b6d-7fff-08df33490cfb
X-MS-Exchange-CrossTenant-AuthSource: MMZPR08MB549315.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:08:15.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9361

Hi Viresh,
Hi Jerome,

On 10/26/26 09:59, Viresh Kumar wrote:
> On 26-10-26, 09:57, Jerome Brunet wrote:
>> On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>>> On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
>>>> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>>
>>>> Every S4 speed bin runs the same CPU frequencies but needs its own
>>>> voltage curve, and the bin can only be read through the secure monitor.
>>>>
>>>> Read the bin from the firmware, select the matching
>>>> "opp-microvolt-speed<bin>" property for all CPUs, then register
>>>> cpufreq-dt. Bins outside the known range fall back to bin 0, which
>>>> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
>>>> on the SoC compatible and needs no node of its own, and S4 is added to
>>>> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
>>>> the bin has been applied.
>>>>
>>>> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>> ---
>>>>   MAINTAINERS                          |   1 +
>>>>   drivers/cpufreq/Kconfig.arm          |  14 ++
>>>>   drivers/cpufreq/Makefile             |   1 +
>>>>   drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>>>>   drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>>   5 files changed, 202 insertions(+)
>>>>   create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
>>> Is it safe to apply just this one ? I can take this via the PM tree then.
>> I would advise to wait a little for Amlogic to chime in.

Viresh, thanks, but please don't apply it alone. It would need the 
speed-bin call from patch 3 (meson_sm), and without the CPU clock from 
patch 2 it has nothing to scale.

Best regards,
Christian

> Sure, I wasn't going to wait for the maintainers to respond anyway.
>
