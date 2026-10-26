Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793009429;
	b=vTHKHlf+oZ4N7rmvPW3rHsUIqI2NUjwBBuzzR0IzvXt5nlaPgWS0ZynFKBH0tk9pFRNA
	 Qh4Lj9uF6/JbrVhuIIBJx0sVXh9VHQZwEgQYcbU5Duo0Wy06T8eqb5mRiplrnJ48cLagq
	 v3AejMLtp9sXfXum4dMXFhUWuOLStanTTdeEANkwNLxfYa2DsajwhKnJXSh6iNNHtpUsl
	 VviSk6DAy34/wSvPk72f4qRcJ74HLdVaHAqvLqRa1HKQiyLWoiqwq+UobcY9m2sg+h+/Y
	 Uu3qw3fim1V7HZBxlBtUX39ZRFnne7MOj9yZwM2IaqNNlKlva554uf27Z9GSMLav8Ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009429;
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
	bh=Wo/Ba94vurq4f/2y0LlL+T4zH6vWnNxm3XHj0C8mvQ0=;
	b=Nn6rr+wM6rK6GV4J7ASwmj2xGElNm6/UfDqOtQkN0X6Ec3GZqGOx3u+REYJh6sSjTTtI
	 0aoKjkEmHYGO+Ry84iuE2W8bH7n+fDybEShkZdSbU3qZfeyKcv4rJSAvj0XVPRl4ReJuD
	 fh4lbZ5NaArDeIHUky8SL/vi+JNvtTG4SKBHeZSrAEMC9K0QNIq9jYBrCX8jc/cyCW7IA
	 bSis60VutkQVvxSky9Deb4AXgCzfJLIn4U8R1a421Wtc9rkFFLr1bqZOKwedCZK/Yv5SW
	 apnlHkLkQLO6ktKLEoWw6vzohfPisyOAmAwYR9HgVTrCCT1OMvX9bXVmBCep0T7439Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=outlook.de;
	spf=pass smtp.mailfrom=outlook.de;
	dkim=pass header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b="YIa/uyfg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.7
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010007.outbound.protection.outlook.com [52.103.33.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF98606A31D;
	Mon, 26 Oct 2026 10:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF98606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=YIa/uyfg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0DICkUa8dvc7cnfiGESLdrYHs/wuGOYhv2OuuZ7dwWJ6BJqiaHNdyBUxER7x6DjGM9XW+25/rYZo5RXu6hDtE0F+z/NumrECy1FFK10fBA5hpJhzw0SbFydglHKm7o60wT+zX+/DR3nMmfARF/1WuYGZQJ0Yv8fRwl4UkGbmr/1Uyiqnz91NRKdmx6926csOD0sJowcRT4uCYKBEkIzroxy8dapECvMjDnbaUmN5Hud6siROXZf2mrcSUubHxlhgDEWxfT74wfCzGALfrY9P1cZ8McIJPY7XwUM7B29UXSe2N+m2v5JDCWCtiTZ4d+BkQRZT2iWpC34/UcqBKa3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo/Ba94vurq4f/2y0LlL+T4zH6vWnNxm3XHj0C8mvQ0=;
 b=l879WKx8fCBcsTBgMVu7VIc0rIkj/wS5z7fRvuK66jq+GYDtJK1Oj5tquktIcbsyaFqX0xahcxhBgl/TMZMkvwtL/BMr6mjzLVAejEl/VMQLHilnx5n1llY4KFX/lR3+cdba4ve7pOHDEKmcawAjj7k+8NBRyBW2NpH/qA5i8bLSVrI0aJ+08J2LLcsE9Oq68ie91Wc+EQFhWhgnlOFVFpO76m9+ujUmvYuodTbC4Ms2XbotrfetN043+Rx8MlfDtj6/RBBowvUFg3li3tAqFvFuzqddO7POppconfmJrpyW3TC8ye7OvgE4eu5Z5QfxTfGV19DzEIxBYEjQL0314w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo/Ba94vurq4f/2y0LlL+T4zH6vWnNxm3XHj0C8mvQ0=;
 b=YIa/uyfgZkZo6cALdSY0vbdEA72Mr/xPkUiGGRtr/0gCU3IP3+YyTRh43rUBeQQYeXdiTVa5+7thgKbSYj3ATzHsZjPUXTF8CBO8Nlbt8JglvIj9312T4pzJzQsbXvyyx77Sbcj+PA5Ed3++r0Ru4yE1cNnHq6Fk3/yRH0RkEeeT6cXA6/RLvJh30U2F1j4cU8rNhbBgE29HM9UcfnZeNl8FcL+LyFhCZracdAbdeSFtntkS3Klf2AByWV8WgMRcT3lE28u5K8cQOO7xrA/7SX0+meM9Pj82Qyz2plIs1yBhirM2to8W7we/6Mm5ua31kYgEJPlcLPUOVQfDVUrzkQ==
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19) by AS8PR08MB9361.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 26 Oct
 2026 10:10:26 +0000
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5]) by MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:10:26 +0000
Message-ID:
 <MMZPR08MB54931587B388DDCDBCE0742500DF612@MMZPR08MB549315.eurprd08.prod.outlook.com>
Date: Mon, 26 Oct 2026 11:10:12 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Christain_Stefan_K=C3=B6ver-Draxl?= <ckoever@outlook.de>
In-Reply-To: <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19)
X-Microsoft-Original-Message-ID:
 <71c1ba2b-e35a-4b1f-a80c-dddcb951a2c3@outlook.de>
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
X-MS-Office365-Filtering-Correlation-Id: 4c00ff7c-10e6-4e13-8b39-08df33495b26
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25010399006|19110799012|23021999003|8060799015|5072599009|15080799012|19101099003|6090799003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitiVGFHTTlZNld1Wnp5bEwxUEk5TVNLc3lrazdrTTFnQjRrUkJzZldYazdl?=
 =?utf-8?B?VHBFeE5ISjNod0FCcHJQd2pQakRxVVJ5QjFscEZMcjMvWEp0eE45dEgyVzZw?=
 =?utf-8?B?Yjhwa0lkSmFkck9tZ2xFQ1A2ZXdOaDhTb2VlZWNxOE11clhhZXIvVWhEL2cx?=
 =?utf-8?B?ZGNlc1NhVFJ0MlNBYm8rOWV1NWF3VzB1VzZKM1hkR0pqdk1OM3l4cThjTGhh?=
 =?utf-8?B?RDY0RTF1NytJRHYrQTUvVXNhUnNOcWluTUtRTFRPdUF4VkZDOVZacG1kMTVK?=
 =?utf-8?B?VWFsSEZKbEZlRkhTOVkyY2EyRUFDMDVObjc3cmF6NGlzMXFSQ0h1cVBxZkU3?=
 =?utf-8?B?YmFBL3NCU3R3SXEzNXk4cjhZVmpRcy9UeG1DeUZDRSs3ZkdzS2U3ZFNZRTJ1?=
 =?utf-8?B?c3dRMkJ6SVA2b1IzeXcwYUhyaFhNanAwcFhMVzFPci9zMUVhTHluU1A1cUw5?=
 =?utf-8?B?UHBraTd1NkVla0h2Z1N6eFBqSVBBNEh2SnpmVDlaMVpJc0t5aDlCa0NMdDFh?=
 =?utf-8?B?QzNsV3NKSktna3NtaVFTVzJFR2N2OTFRVW5EUXMzY2FnNWtsczBrS1BVblhW?=
 =?utf-8?B?M2dKVGtHeDc4RG1DSk50WW53NmQyRFJCMEt4REdVV1lobnlBVjhmQjlpTG9K?=
 =?utf-8?B?WFJxRDVFTk9OT05GOVRuVHZ6SXNENEZjM3I0dk50ZEk5TlVQYUxEUVBlZ0pj?=
 =?utf-8?B?cS9VNWRjenZmUTVQbTZXaGpNTEVOQkNuclVsdnhqL3dvVGRrUnJ6Uk1ncDln?=
 =?utf-8?B?R0pmOEYwNVNsTUU0MjZhZEF1MG56Wnp6RVo2V1VabE1LZ25NaGsrKy8yb1lv?=
 =?utf-8?B?T3hNemROVHZQbmpTU0dEWVMyOGs4MEpqQk1iZG5ZYlltMDdTUUZna0dUUStB?=
 =?utf-8?B?bnNuZThFMnllRkk1cXBPRHNuZVBXR0QzczhwSGp0M0VTSDRyOG9FbEkxNUw1?=
 =?utf-8?B?eFN6OUk5a1hDQlVJVHBhQmpUb05yVDZBRG1Za3BYZG41dGkwT2tiNGRqdDFt?=
 =?utf-8?B?WU42OEcvQlpJa0RINWgyOG9KMjEwOVpxSXM2Z1ZGSnh5WGFCKzk0RHJzajhs?=
 =?utf-8?B?ZlNCbTZkc1JqUmNtVU40M2E0RkYvVHp2eVUxa2dXVUE3YmR2ZnlGTWdzUnl5?=
 =?utf-8?B?TzY2Z0xieHdLcmRMYkNEcjBOYndKVG5vVTFtWGliTU9NQmFsdXF2TTF5WEdv?=
 =?utf-8?B?YVpzSytNb25takduRUs4SnNVWDhQbzV3bEdKSkw0Qmtjd0pXaWN4TDZ5RW9R?=
 =?utf-8?B?UGlEVUhRempPUXNHQmxRdGd5elprK1IxcXpjcXg3VDVvYTFmNzBXaE5EWmR0?=
 =?utf-8?Q?wWyREvtUixg02+PODs7ApyRZ/eDmH83ASG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBqNlMwNkZ0dlRFc2JoUEJnR3ZMa3phdTB4azRva1dLMTRPMDJJSUczcUZT?=
 =?utf-8?B?cGRGUFk1OEZjbWtPT2hKZDVKUjBhRENxSWdwa3dLNEhCS3diYWtPYjkySE9E?=
 =?utf-8?B?ckQvNG4zdHlSbitjQUtUTjg4VC9UQ0JWMWpRL0t3L3VIWnVaeXFSaXR3RE9n?=
 =?utf-8?B?enRhN0J6dVk3QjR0bWtLdGs4SFZXVjZsdm9JdjFmMW9qc2x6VkdDNk53Ykhy?=
 =?utf-8?B?VUJPSTlGb1Evc3cyZ0ZJcnAxMXJXWHk2WU5MbVlEUG8wV1U5VkhXMEpPTFJV?=
 =?utf-8?B?Ny9tVytMM3NDL1NVaDJON29qMWhWbGtrRmhSZDVJVXRXV05EdUE3aWgxTFBv?=
 =?utf-8?B?dExkN3FxT0hEOE5rM3JwZnhJajNyUEtOTzFDem0weVFyejFaN0xqMCtYaXoz?=
 =?utf-8?B?Q2xuNHpxbHFJclBVeXloVXVxOVcvSkd5TDRtejlvN0NZcVl2V1JtK3Y5MWI2?=
 =?utf-8?B?S0x3alNrbmxDT3RrL1BaOWpjekFDOTdvU0pXODJVSktPYVlrMEY0V2tyNkJ3?=
 =?utf-8?B?ZlJqT042aDA4QzdlVnRNcnJzc0QvN2ZUWXNiVm8zOVVzc2ZKL0pzaTRLMTNk?=
 =?utf-8?B?SzBmRVBaVFFRNEl3STNiWlZNVjAreEcxTkF2T20wNWhoQW9rREZ5ckhPa3JF?=
 =?utf-8?B?Rk1mT1JXYUNRNTV2Z3JNOXVtQzJ5dXdKc081VlRpanUzTEd3NXRHcW53US95?=
 =?utf-8?B?ZlZkb0liSG5YN0Y3OUlEQXFCMGtTSkNGMzZuUk0yWXNGcG1idm12N3pqNHd5?=
 =?utf-8?B?NmI5enNXZnI0dEdnWHBpQkMrRERxNVlRdzBOTHRSeDRnWkh5aVpyMVo1LytI?=
 =?utf-8?B?VUtXcVgzZmhXKzhwLzVjNnFKS3RpSWI4Y0lWMkQ2YzljT21lVy9HM3FLNjJB?=
 =?utf-8?B?SG9DZlh4emVPNmQ2QWwxeVlKZmZibE9vWWV2QzBjbEw5ejhIbkl2TC83dmsr?=
 =?utf-8?B?cTcrSXVjWm1DcTB3L1dWTVZJQTZVczIwSHNJQ0kyOGNCVEtySkIrVHAxZ010?=
 =?utf-8?B?aThVWVZIUVIyU0E0L2E1eERnNmlpRVE2RS9PY1NnZnB0NVFNUXdvUzNFOHhi?=
 =?utf-8?B?SGRjTks1cTVlQml4UVcvRS8xNzROczBhNDcyV3dsQ2xscWlyNlRRZ2xJOEZh?=
 =?utf-8?B?dlQvK0ZDZ0pqN3gxb21nTkxOVU5xRnNJTEI2WFFWd0RTTDZZblNHVTVJMkpl?=
 =?utf-8?B?MGRLSlRobmRCenlUc1VJd0IvOExGTjRSaG43eEdkRkxna3hRUHo0V0kzcnll?=
 =?utf-8?B?Vm9sTXJFZDNvWWh0bTM5TDUwYjhtOGhCbEFUNi9KalpzNzg3RUZ3UUFaT01L?=
 =?utf-8?B?WEMxQmRXd08xeDBlbXJVcG44WFp5ZE9iUitaaVBUWHBFeXd3OGRYYUlIUXRs?=
 =?utf-8?B?Y3paS2I3YXZiNzdXeWdZWklmNW9DV25lZUVxMTc5Tm5YdmRDYWx5VktFY1Z4?=
 =?utf-8?B?ajBIOTd2NmpicUJzRjh4ajdzcVB6Sk4rMWNmYTBESkRUVGhDZTMzaUZIWWVa?=
 =?utf-8?B?Znh3L3hDRUxzYzlwd3FNQTg4WlA2ZU01ck54V20xZ2ZjdlBkV0cyRm16bGgz?=
 =?utf-8?B?NDBSR3FiVGk3ZUFvdW9OMlkrYzVVVWVSTm5jZmhidjd5SlVPMlo3MnMxdzBT?=
 =?utf-8?B?ZUF0MUo5YnNmeVV5a2hYRHFpbE1NM2x3SUFZT1hPRWI0d0RhdElrYmdWSDZk?=
 =?utf-8?B?QUdTTWVFbFNzdTZHNmdua1ZkRys5VHkreW4zbm1HWGFqN1dLMGRLN2ZHamZy?=
 =?utf-8?B?bVNheGVWUGJBWCs0QVgzTlN0YytOekl6RWZhcHFyUzNvb2ZUODZ1bmJiL3Fx?=
 =?utf-8?B?R0k0R0ZCb3QyQW84S1haK3p2RDN5UExNNzFjbGxhVzYwTG5PRzFINEl3RmJT?=
 =?utf-8?Q?LCHGv785fZHTG?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fbb9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c00ff7c-10e6-4e13-8b39-08df33495b26
X-MS-Exchange-CrossTenant-AuthSource: MMZPR08MB549315.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:10:26.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9361

Hi Viresh,
Hi Jerome,

On 10/26/26 09:57, Jerome Brunet wrote:
> On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
>>> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>
>>> Every S4 speed bin runs the same CPU frequencies but needs its own
>>> voltage curve, and the bin can only be read through the secure monitor.
>>>
>>> Read the bin from the firmware, select the matching
>>> "opp-microvolt-speed<bin>" property for all CPUs, then register
>>> cpufreq-dt. Bins outside the known range fall back to bin 0, which
>>> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
>>> on the SoC compatible and needs no node of its own, and S4 is added to
>>> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
>>> the bin has been applied.
>>>
>>> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>> ---
>>>   MAINTAINERS                          |   1 +
>>>   drivers/cpufreq/Kconfig.arm          |  14 ++
>>>   drivers/cpufreq/Makefile             |   1 +
>>>   drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>>>   drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>   5 files changed, 202 insertions(+)
>>>   create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
>> Is it safe to apply just this one ? I can take this via the PM tree then.
> I would advise to wait a little for Amlogic to chime in.
>
> Patch 2 is something I already rejected back when S4 support was
> initially introduced. I suppose AI just unearthed it and did not bother
> to mention it.
>
> Amlogic was supposed to migrate to SCMI at that point, and possibly
> handle CPU frequency scaling through the secure fw entirely.
>
> They did on later SoCs, I don't know where their FW stands on the S4.

In my board's firmware there is no SCMI. CPU DVFS only works through the 
clock SMCs.

Best regards,
Christian

>
>> -- 
>> viresh
