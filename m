Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795436652;
	b=vDa5OBnVyjsWl8JGK9cnmpMIC9O3eLrMZNbfq2czgHAjlGzcOoSAQVfpbBT1B9KrGkkM
	 aG3cXAE61jBozJ3wDXtyyHRVP5hkElTANGLmJnn0EDnuulIgL2gR7Huo2YpUZ3ORxvQSj
	 m5OInQDB8h/u/oMSgFK1WdOg9eBnUF1Zb8hHhKgraqy4+NQUScnj6b3LMx/QD5aT12D4r
	 +HyMxDCxUAdy/2TbhEwnj4VdT8AAKqqZWqPUxP/iOCgIIgO/qI9WNPne6/4KC7YFed1Bw
	 k1jEfzGnPCr4eIZfClQFhnmHs/VZOLSiZ2TIUtuniH50pVGavTWqrm8T2TCV1mB4JvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436652;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Qe+WnX/uVdFD9IZfK7yAjEwOAl/mxKoAfroHvk6dJHw=;
	b=o9EDtxPdKt0sOXV9Vv31oQOxi62iR0ecgR4GIyOTc9/0S/2ST9lIlYbq28k4ykTu+ryQ
	 UEhX+LkhhijXLEYbZVvf9wrdqaqNHLTHhaT2KHrqDCD6iiGakMp50pZNlB481fz+yLEzW
	 CRBaRA1qc7udnXPhtaMKyCh7OLYF2iNFMlkeaX1nzjD2Wj7hiDunt1DkL2JtAZjF9zGVW
	 YfU0gyfbkHxMXUH5fAggXz4ABW1eER3XgBPqS9/E1RRcqhQZSAZRhnRaqfChcGAOVcJ9S
	 8mwedpzHq6E1ec3CPOWbojs6XCGg6j1DQDsnkAzetDkdcPvTYnRNDHGWiYFMVLTAJEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=tpbqtlcM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.81
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022081.outbound.protection.outlook.com [52.101.126.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C4606A31A;
	Mon, 23 Nov 2026 12:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=tpbqtlcM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP5BEEozl2QHO19kVo7vL61E4GLmSMODaPO7t7WGtjAHg4S/I6Iva1veUDAXbnlu7ccOZpsjIte3JG3sfd21oLjw79mjIR+5ShOgqbrmxpIjHC0azh9R2GmGg+RHkpgsH1eLYU26nrYR0DTGa+Iq2xIHtkI803oCQYn8z9Tldud2kVdW9fubJFShF+oImRCb0381ON2DaypYBYuV0jovZ5HFgRCTnm1/gJMsIhbAVt2YB6wzdFCbghptDXdophv6X7fk5a/07gsIhROaPffea+xUFQjehsFlAF35LqhO4IG2jLPqCcIgjKl9XbpuZsD5eo8hKhogczujFiymSFwPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe+WnX/uVdFD9IZfK7yAjEwOAl/mxKoAfroHvk6dJHw=;
 b=sf9ZdHMZOsEow5u3/LBmW5b3bjP39iefsyNIjs7spOpdyOxjMH4nBaWA4RN50UyAqA59Olp3tGeDRSSL2cwZFsbQCYAoBCVOrg/27G4MJ/VysffNK1+l6Mg+rWKrZVV7N0g0dgWK3w/DX0X+bZrGNAcugvs8f8F2EKf7cYdyGZBlWI3EEqkwSH2KB5xvHL1Xq0VeCqcJVHHiMoG40DVDO9fQ00KoCgr3ZsSpnu8uoJYPbrfsGmQGxVVluk+A0qmL7HN0irrXgG3xFrPPJ32YdyuQXzuPdppSbh5FxStD2iHhu6yTNTXRjK8gJZb9nzbqy1xexrtrQKVFEIza17BMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe+WnX/uVdFD9IZfK7yAjEwOAl/mxKoAfroHvk6dJHw=;
 b=tpbqtlcMu4DZA1yXwF6Oae7k19T1sv39Gr44j++wpJ3fU5H2Bka0g6uX25P4WPpcBlB/WSqyZbgU5XR9SQtxSAwKLQs1gm1376tWyi1tY/iX6MUl9hzyBRsNematUtIIl1UVKkwMzE0uJPG+ToCtQAmC3IIM0xcn4hiM4feVKRoVK2mNA1ogG+7WHvdpVZYpA/TOdhwIhLGuxP/hw36XVv8XGGG3m0UqTbQoXFAwPEWNb/5mXsHnCIENX2ncwduMvtqf7BaxgwYmGGfhA1naSZIwuQU8X7q0xtzqMoRFcB9A4WH+BOeJVcLndP+DpCUdAwXekPsCk2MaKCEQ3JtCIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB8523.apcprd03.prod.outlook.com (2603:1096:101:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 12:24:06 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 12:24:06 +0000
Message-ID: <b606819a-661e-4488-b5fb-9e786de463c6@amlogic.com>
Date: Mon, 23 Nov 2026 20:23:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, christian.koever-draxl@student.uibk.ac.at,
 neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com,
 khilman@baylibre.com, rafael@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Drax?=
 =?UTF-8?Q?l?= <ckoever@outlook.de>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
 <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
 <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
 <9556e959-daf3-4c85-8794-9613e7e7a9ae@gmail.com>
 <A45EC676-5B14-4932-A4CF-87ED3B71108D@gmail.com>
 <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
 <CAFBinCBkJJeRPKLFBA9KYjwXMxFjow_NOtvFoKRQdxD=rOPW3w@mail.gmail.com>
 <48b333a3-ef88-4739-a087-3ed9d8ec60a4@amlogic.com>
 <CAFBinCCgmRmk--W53wqdJhF-SzJbai--s7wyzDNt3LpfN00spw@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCCgmRmk--W53wqdJhF-SzJbai--s7wyzDNt3LpfN00spw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6912feb1-0a8e-4888-3654-08df495caaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|11063799006|4143699003|56012099006|261021130227099003|261021121427099003|261021123027099003|261021135927099003|261026130827099003|261022105027099003|261026121527099003|261022075727099003|261022113327099003|261009223027099003|261022115727099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fWE1/j+HZdMm3VvEDtV/aPlYmeAMv520RjCfzg4Cr/Ygt+lU+pZx3K07tOz8OYFXLgWnSvHMzeL0wRlSE3xqM9K3wRKcPS3vfabUE0d0LlAp+LctdXowp1AOtGe8Cr7khQbFCo3ohmKPZeSXUlbeK5jxzqWxbUyUS62QF0Mu9ZbKauUzKAnm0/n0Fcg0S6e4Quqnpd385847ADDsq++igFd+COXNvL3xyHRQo7SObzNjYqsj4cpMChG2RlkxghmFTxO4iDwFhvhLf9VyJQ0dnAQ+RckRaYah4tLdrpCXl3hxaSUCjYSIdkpsDEk5B/gCNMRB7FRYhPk/+F9pMeLwLxfroBjFmDv0CqAXv9tgA//SbAuIiCpxbfS319zSjRr7vWmhLj1IAf7USCNYNgVWMVynyckitV4k/T7SMEe7S4C5G/3nDlRldZl/UUg9Pt6LpJV2gcc56zyXMvCvS5a8uVb1b/QUObck2sjxGTmQg+ifxmoSsj4VAkWgJKpobzrw4bdD4uSn5gHuJMuoPuAwsV1BdluO5xKRZpPhBdqMS6n0UpWGbDM4O/XP3Fk53e+/esncXYsZ3POzu94WONPaMKuj1FFNFn/mLWHWaCRLnO42zqER1yGMaXpxeDyTdXav1S1xBU0gvLGu6a84Qnf8qUa7g+Oq1kg3P4xSeAL3ghc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021130227099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026130827099003)(261022105027099003)(261026121527099003)(261022075727099003)(261022113327099003)(261009223027099003)(261022115727099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVpjdFArczVGMVE3aFJKcm1XSFcweFJjdDF1bzNGTEs3MFRON2Y1dktXZE0z?=
 =?utf-8?B?M0l0aml0bUxWS1ZmK1p3OXdEc0hZREw2NUltUWovMm4yNExpNmpTdEJWdWJn?=
 =?utf-8?B?bkRUWXhkRCtwTERIM29zNlpJTER2bE9hRGora3UzdmprVEtsTmp5Y0VSVGJC?=
 =?utf-8?B?QWY0U1FYWUd4Y3k3RGRxUm5PUmdRNHBxbXR2cmFIK1lFQmhuSis2RHhVaVM2?=
 =?utf-8?B?dU4xeEFUbUNoaGlHK1daYXdtcWsvTnNNQTFDUHpGZFoxZXVOUWZ2cXpLRUFu?=
 =?utf-8?B?Ujg2U0E1K2xnRFRpUk1IVW42WXlqNDY1Z1BCTWxXWGR1ZlAxa25wSkluMzZn?=
 =?utf-8?B?SWd5ZE92WEFnbUlWNEZZc0NzZ1U2Y0ROYy9DTWRsR0VvOW9oY1BVKzl4OTd0?=
 =?utf-8?B?L2JFNVJIZ1pGY3FZSnRWNVo0c0xVZm9XTFlEVk9qVkN2aUJUaWtVOG1OM1dD?=
 =?utf-8?B?WUNjVTI4eDFXazhTZ08ya0pjWkhKYjNKRmUvbU1lYjVXNEhsSEpQQmluQ0NH?=
 =?utf-8?B?UmZPR0hKK1R2SG4xSlJZOHE0MEJ6c1Yrc20xeStwamt1ZzdPL3RjNXhaRDN3?=
 =?utf-8?B?cmNPWEpZejVRZ0FIM3ZkY3B1MTdtK2hLWVJxQkNFQjd1dllqeWlWVEplT3FB?=
 =?utf-8?B?T3EyS2tvWW5YVDYzSCs4Kzhkek1rSmRabStSUkZ0bWYxNjFuZVVMOU0zZnlD?=
 =?utf-8?B?R0x5N2pBVjFtcnRjaCtUMEZEUWF1OXh3eU5qbHh1UENiTXZDZVgzRm1yOFUr?=
 =?utf-8?B?TkR0V29NR3lTemVqNXpSblEzYlg1b1N1NUFUV1piME5LVlpQRVlZVXlSRExi?=
 =?utf-8?B?dFZhNkdWWjY5VjR0bEpaaWRQVUN3dnpNZ1B0N3F2c21iWVNJQlVaVDRWNGt3?=
 =?utf-8?B?Mk1FY29OSS9yenY5ZG14dElFRlhCN0RHeTJLeFlQU2JaSHlPMkNUL3gwZThD?=
 =?utf-8?B?OUlDSUJiNWUyUDN2SHdVbUFLcGs1WHNDWVl6TTB0d2JJcXlqd2RFOHhvL21U?=
 =?utf-8?B?aTlTMEZQU3RCSWZabEVIMW5wVGttZGlyTGJHeDVzZXlWRW5CdUllV2NudUpK?=
 =?utf-8?B?Y0YxSkNMVUpxYnh6cTE4QlA2VDgxTjNEWDRWbmMrajFsclh6dmNvQlVQR251?=
 =?utf-8?B?SEtYeXptTHlHdURORk8vY1pKQnBqT2EyUUVGcFJjSmNMdzNoTTVpQjZucnA1?=
 =?utf-8?B?bUIrZDROZnM2d09SVk9ZNjNkTzVOZ1NiSm5yUVVEL2ZQZ0JZTmxvN1JBeGRK?=
 =?utf-8?B?cUluSjVRbmF4TW5CNVR0MG1qWjBRQlNBNWRrSlUxbFFRT1Joa2V2L0FvcDVr?=
 =?utf-8?B?d2k4OHRXTk5NdVJVSVVySTluSlBEZ0lRWHFzQmdEWE03K3V3N3FyQU14R3JG?=
 =?utf-8?B?VnJmdzk4a3VJVDRnemN3ZllUMzd1T29LbGNCSi8zY2lpV25rK3QzZFkxanli?=
 =?utf-8?B?V1dRVXRiMElCdDh0a1VMSEMxMHpQQTNhRTJ0NE5CWGNjUDh4SGZ2WGREVVpP?=
 =?utf-8?B?NFFlQXk4S0lkTXRIZFJidW5TRC9BeFEvN2NRWk9YQlFPMTNUUWJsOVZhTStR?=
 =?utf-8?B?R3RDVFNuY0dBTU9CNjVqZU5Xc1lXbFI0MDJ1RVBxakhDSmlpRHBWRXZEZ0ZE?=
 =?utf-8?B?UWVrWXBucGhvckszc1hmM1hjWkxyTGRVOUorbG1TSmVwaDhQVDQ0YTR2ZW1l?=
 =?utf-8?B?ZXhGZGFZOUZCRDRhMGQrVFZtV09zQ3BYTk81Nmo4cXhzb2FwRWNmTzIrRmRv?=
 =?utf-8?B?SW4xTUtkOHlqWDAyYTZOMWdxOUJsY3gvd29LUjZuVXVxaDlvclJ1WFJPRk56?=
 =?utf-8?B?SlVMVDhDZ1ppSVlvOWExSG5Td2RKRkl4bStucjY2YkUxKzF4YkNQeFdKdFJi?=
 =?utf-8?B?aCs0UVhPWXBYd1VySGNUeElscnpycGFpTXl0UElsbmlDYWFIZWdydjRiZE9a?=
 =?utf-8?B?eGoxMXVoNExmY0JLNWZLbEVqOEs0RkpRdWZwazFxSU5wMEozSUJOTGRldWFF?=
 =?utf-8?B?Y011dGVnVDJhMEQvSTZBZ1lvU3U3WEhCcW93VDJ5b01GSm5BUkZiQTIyVlVa?=
 =?utf-8?B?WDdJVGtFOGgzMUkwTFhpS2ZuVGRKTFJLWWFjdGthZ01KSlFueFZXK0xSRTNS?=
 =?utf-8?B?QzNSWVJwNzNzTmxueXJsb3BaRjFEb1NBNHJkdHJLQ0Y5TjBqb25FNjV4R3BZ?=
 =?utf-8?B?Lzhzc2sva1M2eCtlVTcwcHVidFNqQTlMbUlWOFZzaHljYXMreXpmOEw4MlQ4?=
 =?utf-8?B?SjNCUE1mbHM0UHY2WXhHR0Zrd0FIMm9qSVA3clA3MWYweXBLcVNTd2tFU2Yw?=
 =?utf-8?B?WFhOd3ZrNzdzdnN0WGlZZFhGRTVSVXR6eHFXRmpmdnFVK0tGbk55dz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6912feb1-0a8e-4888-3654-08df495caaf8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:24:06.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDbv8Cv16mtDiNpMSeZRIxdVs6QD/gjS+h8dU6p08HpZQ2PdqFg4Imy1Dz6ug1ZBgDASRxu68rJFYJmycPOySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8523

Hi Viresh, Cc Martin,
     I've run into some issues while adapting the Amlogic A9 to 
cpufreq-dt to support the coordinated adjustment of multiple clocks, and 
I'd like to ask for your opinion.

On 11/9/2026 5:45 AM, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Nov 3, 2026 at 10:46 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>>
>> Hi Martin,
>>       Thank you for joining this discussion. :)
>>
>> I have re-examined the capabilities provided by pm_opp and cpufreq-dt,
>> and it seems that we may also be able to adapt A9 fairly well based on
>> the amlogic-cpufreq.c here. So we have no objections to the driver
>> implementation in amlogic-cpufreq.c here.
>>
>> I was most worried about before was that cpufreq-dt might not fully
>> handle the complicated clock and supply adjustment logic between
>> multiple clusters, which would have required adding a separate
>> cpufreq_driver. But it now looks like this can be solved by adding the
>> corresponding config_clks() and config_regulators() callbacks in
>> dev_pm_opp_set_config().

Our original intention was to try to structure our Amlogic cpufreq 
driver around cpufreq-dt.

> That's great news, indeed!
> 
> [...]
>> All in all, it looks like we can currently support all Amlogic SoCs in a
>> single amlogic-cpufreq.c? Then, for the specific characteristics of
>> different SoCs, we can differentiate them through the "compatible"
>> property and add the corresponding drvdata for each.
>>
>> I'll also try to support S7/A9 with representative differences based on
>> this patch.

I have already completed the support on A9, but cpufreq-dt currently 
only supports the single-clock case, for example:
dt_cpufreq_early_init()
   ->dev_pm_opp_init_cpufreq_table()
     ->dev_pm_opp_find_freq_ceil()
       ->_find_key_ceil()
         ->assert_single_clk()

set_target()
   ->dev_pm_opp_set_rate()
     ->_find_freq_ceil()
       ->assert_single_clk()

Both of the interfaces above are limited to "single_clk", so SoCs that 
need to adjust the DSU clock in coordination with the CPU clock (such as 
SM1, S7, A9, etc. mentioned above) cannot directly work on top of 
cpufreq-dt.

I changed assert_single_clk() to assert_clk_index() in the two functions 
above and it works, but I'm afraid such a brute-force change may break 
the semantics of the original APIs.

To support the Amlogic cpufreq driver coordinating the adjustment of 
multiple clocks as specified, We can currently think of three approaches:

1) Extend the cpufreq-dt/OPP function interfaces, for example:
   - Add dev_pm_opp_init_cpufreq_table_indexed() and 
dev_pm_opp_set_rate_indexed()
   - Adapt cpufreq-dt to these newly added functions, sample changes:

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7d5079fd16882..8940d36f2371d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -53,7 +53,7 @@ static int set_target(struct cpufreq_policy *policy, 
unsigned int index)
         struct private_data *priv = policy->driver_data;
         unsigned long freq = policy->freq_table[index].frequency;

-       return dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
+       return dev_pm_opp_set_rate_indexed(priv->cpu_dev, freq * 1000, 0);
  }

  /*
@@ -245,7 +245,7 @@ static int dt_cpufreq_early_init(struct device *dev, 
int cpu)
                                 __func__, ret);
         }

-       ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &priv->freq_table);
+       ret = dev_pm_opp_init_cpufreq_table_indexed(cpu_dev, 
&priv->freq_table, 0);
         if (ret) {
                 dev_err(cpu_dev, "failed to init cpufreq table: %d\n", 
ret);
                 goto out;

2) Keep cpufreq-dt and adjust the DSU clock synchronously when adjusting 
the CPU clock in config_clks(), only a single CPU clock is kept in 
"struct dev_pm_opp_config config.clk_names".

3) Create a separate Amlogic cpufreq driver independent of cpufreq-dt 
(similar to mediatek-cpufreq.c)

Which approach would you prefer? Do you have any better suggestions?

> Great, let's look at some code rather than discussing theory on how to
> write code :-)
> 
> There's one last detail that we have to manage in case we also want to
> include the Meson8* code into the same file:
> config MESON_SM depends on ARM64_4K_PAGES
> 32-bit kernel builds can't satisfy this (meaning: we end up with
> linker errors). I think a simple way to get around this is to add stub
> functions to include/linux/firmware/meson/meson_sm.h.
> I'll take care of that once I can submit Meson8 support patches for
> your upcoming amlogic-cpufreq.c!
> 
> 
> Best regards,
> Martin

-- 
Best regards,
Chuan

