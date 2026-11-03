Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699161;
	b=bXdND+vIE4F1h6t5pHJEd0msloKunpg8zLbqzBY84YDfIlPPwQasXD6MOmtGhLQGvFel
	 3hOmj2+TPK8AhqJMQ8lH2bY5lUVivKIyjaSP130GY9OYXi0HX49z7ExpfiLV0p0+DoI/p
	 b3kMWxwHFQB36BhHGOI3D2EDy2kxxn8knqyvMaVMhKNEEYkrZcTNcq+9BTWQFn6ILaJmT
	 MoMkNiodZChK6kO9eGFRrbPmGadKtva5sGF7yMRpGlkFZxX1daJTH3C9uL7Vcpneb2/Yq
	 P1P8J1t+aKS0gLHJimqPWPWddv7YMywA05/uaUg09KvcAUIsum9sE9UiiiI9on/kfCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699161;
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
	bh=1pkedbSPImBF3RB8Y8aTp4GtNrReIWN/JTYaP4eTwN4=;
	b=X4eGdXz7er4f4IAoWCZdcqZYrFVSGcbGI/8qUTDOKwbu+wB+mVFPrLq3tqCaT1dRPqF5
	 hXIkXnXaADJjrVa/IOY2vGn4MjMhpjgkUyhJZM7By0UCPC/570Qo8sx5NLRuc7QY9+98w
	 OiMV/Q9Z5XA1ogV6iB2ErxXRRRN7EFumYgMG7V7OsD/KHN+H9G0UjjShDLLvSu9KzMdUH
	 lLnSMu0Q0hec2CGYbnaMW292E9vCr83x56dEnqI5AcDcxTei8O61WZOktgD0hs4IjGfpZ
	 kND3NJwDq8wxsPTYwzev+Z4+1RsuNNw9cn3akvOZjx0kKWpC17gSnxhlIIh4K105IwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=ODqXYTHC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.113
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023113.outbound.protection.outlook.com [52.101.127.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B1606A324;
	Tue,  3 Nov 2026 09:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC0B1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=ODqXYTHC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnuxprRIygwinJTsgW0TMPgejOeTbUS+Ncj3iLPKSOQGiw5EefALBtUEbzsT/mPQAnxRZRpLwZmU12X1ui+Cw1mNnLDCzVQrRDEAjDqQUAaYmzLpuRN2tkcGpo9uszHVEWwwRBDWITRYxcNYaSEHkAL2eElCgONcMVJF1HdKOjhcpUz7xgGseyoJ7YtVGgu+NvlGcOIGIQZ7AHDS86TM11Rb2zabHUl9LhjHlNCH+qXA0vBlfffrxTHJ4RZzMzNmtRakNfi4t/PsE6Fga05vZ6JYZur1Odb8MQy4J0wwguiKHR2EzW9eCiCpCj4GvTXMgHmxvJcWbWBxhClTrjBwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pkedbSPImBF3RB8Y8aTp4GtNrReIWN/JTYaP4eTwN4=;
 b=kJsXUFeKfEpB/IGSOv6TIlnGXUpWgn8hirQHp4F3wRj9vL5u++bzPk0EQXsp9mhH+g1zFw1JpHW54fmL6RQVNOU+MesrW/zDW4KHweGedVQ315gRD0JSfewhXZjxFOptUkPETZ/2caHBVpZCfJrLd/ce4fEPGAloPQIAdqaM6/8ieSFYCqVqcVhrhnrc4bTmcx/V3djj3vByejL5qBUQkPYtbOo7WnPouKVFD+47V989qPdq2kPxDBGojHDFV7pxGo0WIx0A2e/rM5e57pt0n2OADAK3z1QvqkcTrYLV+vvqezBUp8JJxSg8URhDTd3xSNsRFDlw/akkriBiQEONJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pkedbSPImBF3RB8Y8aTp4GtNrReIWN/JTYaP4eTwN4=;
 b=ODqXYTHCTmD0uP8GWYl6QbvQG2e3gelR4XBsPIUclLf46u4IdarADZL7wPbk8fb1Zk1zsx0knAD/iDHCFIMXPKYQKuaIFqAhj58lLPwFDdc5K77RuB78urnK71Ng49Gyf4c2YptaeJE0hek13KC40306StMFTMyslQ7DU6rqTKimQmUUAwUyguYJPWojALyJGdTCofBZNEq0X/ZxXUYOn43VM4f7JTzTIuSn7+wvLdEg/Apky9umdSuI3O1oae2CsDnYzbL0dLOe3YyS1RBCwAdk3j5l7akcSr0a3H6SkzYu0A5jfgOI4I3BTxR2TRUFysDq7pSFbCjM4kQYQekAnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB8580.apcprd03.prod.outlook.com (2603:1096:101:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:45:56 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 09:45:56 +0000
Message-ID: <48b333a3-ef88-4739-a087-3ed9d8ec60a4@amlogic.com>
Date: Tue, 3 Nov 2026 17:45:40 +0800
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
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCBkJJeRPKLFBA9KYjwXMxFjow_NOtvFoKRQdxD=rOPW3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::15) To KL1PR03MB5778.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: c111d39e-1e7e-4659-641d-08df398f4203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|261102123227099003|22082099003|18002099003|56012099006|11063799006|4143699003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261009223027099003|261028144727099003|261009221227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	D+y5+H9rNT5e9wHUS8YvJ2m0mZs1n7Uc83XKajEt7Oa4XueXB6DtODb8wGpPa3P8xe+c7UPyYwnKxNb1Qu9prlBd5qzRUkX85iOKQR+6taFyskJZ36DfoPiNH+WpbL3mCPyk4g48HfSPtJ8BPlS6S+NpZo5yiqM2E6kRdoubD6C5EugB6W0CVRQ44Vi9TMj3FOgngIHwcUtErdMVn4h4AbhFo9j/wCmUXQt/KK7Y13fTwEMwd20Cq3Yl2Y1L7lR0uhrm8JWHfciZFphegQZK72PTJ3oGD02obLQRevXn1P/gWmLDFZ6UB9GP7XifNuRfSG7mutRgRH+PzK5TKrndjkQg5V5hgEUCJNdxWWR0N8nUY+7iVVdNOKsvg8r3uW3w6HDK+7+sWZQg18YmmMo9hvD8sz+fQ06T7GNVQ0hbKWz917ihNh8yVYcplQesX5haQyAd1UlNdW1VQPE5xiPE37GHpDvtZCwqSN6xv2Zjic4WiKDQ658Rz6xb8ZJXJ739ibxs8+01Tn3ts2u5OLchmSFGZbUPepnGWLmslNGLwnNjF7Ni0oK7BdYbCXxWbkc+l3nC3v09Td7RkJKxDZy8gwClfpW+XKMRs6hr4Pb5aDW2GRZKAHhDCazM5tBmPz2G4NkHGvVHSuyuGvN9OYv12aUaUDQodVjAPYCVYZJWaXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261009223027099003)(261028144727099003)(261009221227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHc3dDRWNjJNWWF1UWNqcm53bEU5bVJRNXhPdEFaRmdaWkMwY0w2aWZzb0hO?=
 =?utf-8?B?STl6UWl0c0R3NHFCcXFyWGZtT2c1Y2Y1T216UkMxYTNjVzFCUXMwM0w0MXBY?=
 =?utf-8?B?WGlPS0FlaTRxc3U1SHlnMTNNNERac1ZvUmNHVlU3RS96SUZQNXg2SVpqcGo1?=
 =?utf-8?B?cXc3ZDF3N2l4aVkrZkVCNHJnOUc0MnRhdFlQV1FyRTRHMVdCQkYzaU01SGo0?=
 =?utf-8?B?QzdnYWhBT2Y2RlNCMzA0dE1ZSm15Vi9ldENMYzlPcmJKT3pUOGNvcy9reVdh?=
 =?utf-8?B?ZjFnb0pMWGcyS3lUWDhUQXprU3VvM3hBQ2REa1I4SlVpUmhNZEVOSDN4Mk5N?=
 =?utf-8?B?TXdmUGlSOUxROGV5MVY4LzdQMnc2dklwMENGRmg3VzNjaHNGdDFQbi9lTklD?=
 =?utf-8?B?RUljQjBEMjJzN1N2N3BJT1ZHY21TSWJTRUgzMmxPcXA1TGdtUVMzSWtWb0g5?=
 =?utf-8?B?dDNNelhxaUdEbjRXNFFBUnZKSERLVzJTandwbGt1M3k4dUtMQWhZUldSNXBI?=
 =?utf-8?B?UDY0dWVIYnB1SGNCcGVSYWlaZlN1SnN3RVpHbkh2MHFjbUdkUnhvM3ViMkQx?=
 =?utf-8?B?ZFZZdHZBYXhFdm5GZnJNODRaRFlKV0RLRFFudHpFZFJQak1QSml3MzExMkto?=
 =?utf-8?B?U0c0Q3QvNmg4OS9ZTEw0aC81SjdOd2JrWCs5azd6dUJXZ3lBMThZVXQxNDZa?=
 =?utf-8?B?NFJRdHZ5dmgvL1RhM2IyaHkrTHBmQ0QvV2pxUkRjTnE2ckhRWE4zYmU0ZTl1?=
 =?utf-8?B?cVNaMUtRYU9QUThWaldNVDBWbnFQd2hQY2hCcHNRUkZSa0NzdEhpdDgydVgx?=
 =?utf-8?B?NWtFQk1WbDV2ZGM5SkhSdHFlNmF0RzM1UjlJMHRmRXhNNjZZOEp6ckxpOGJM?=
 =?utf-8?B?SHJ5Zmora2xjVEZmYjlIczZIdG1ONTJwM1VsYlJEL2l3dnpRekZTWUd3TUM1?=
 =?utf-8?B?Y1dMcmYrQmM2aXBFVDBjdkNVSlpEcCtkRFdwSGhBWGNZZkovZXB4YUMyT29i?=
 =?utf-8?B?VzZHd1BVeUtaWXVXcmVkb3BBQUJXS2Y4aWZPbHZMcmxjeldTMGMvT0ovS2pr?=
 =?utf-8?B?cVIvMVArcWZlV0VzZmdYMXE2dmR2Q1loaWNwNkdtMUNHVC90ZHlnamxBUHh4?=
 =?utf-8?B?OU92TDdUMWFCS2Z6MlI2blhnL2UxekxMc1Y4ZmhySHpRbytNVENNVHVCdElY?=
 =?utf-8?B?Y2pMT2xPZjFGSTlLTGdUMHg3NkZFcXhsYXFvTm9LdXVwMVFUNnM4dEE5N0Er?=
 =?utf-8?B?RGdwQTQxQUMzMkVJc2tzY3VBdnZYelptRXFaekY5djhvR3lxL3BaQnpkMU5G?=
 =?utf-8?B?UlJUNUdvNVlOd3BkSWNJVTlJN1BtY2ZnMVplL1pxeEZIZm9palNtY24rM2Zs?=
 =?utf-8?B?clkyU2tOQW14RFhuVUFkVmlkeDNTOW1sNmV4bTdhSWVTZDNSejdIdWtQWWwz?=
 =?utf-8?B?YWl3V1dlMzlHUFdOd1pjYVZFRWxyVmMrTmRrTzU5SHMxanBobHF4d090YlJv?=
 =?utf-8?B?TFQ0QjBLZU1FTlZDZFROcHIzVWhxUnpyY0Vxd0NHMEFuY2pJWm0zZjAxcC9r?=
 =?utf-8?B?RjhwM1JyTE51Vjc1cW1ZeGdRSVpDTHNwcGd5c0hTV1BCME9Yck05dncwSTZp?=
 =?utf-8?B?ckIyWEVjQVR4QU41SjhMSU9LUVhmZm8xaG9WcE9OdmtaSVdDbnExMEU4MkxQ?=
 =?utf-8?B?K1RpTEVZVzB2SjI0SmxJdTBjMmNqcHVvOFRRbVBlcWxsWXd0SmNLQTZsQ1dK?=
 =?utf-8?B?eitrTUc5KzNSTW1CdTNUYUU4L2N2K3VGWTBIMXJHcXlVSnBXR0g3bS9WYjdI?=
 =?utf-8?B?WHpBRmJjcHFDWXFvbGp6Y2laajlkSGNOdjJINGlFTGZEajFNQldSbGV0UVFh?=
 =?utf-8?B?Q2VYaENESTlraUdZTGk5SlNBMUQ0eG43VldYZjY2ZEkxL3IwWlBzOVpTdzlR?=
 =?utf-8?B?SkRhb2p5R1h0RStMVmtDWWhvU2tVOTJ5M2FhYUlVa0hSa1VmL2w1VXJ2dFVP?=
 =?utf-8?B?VjJPTkk1aDA5Q0RTb2JuUXd6VHJVbDQ0Z0FQUTE4MWFsYXpqbGtoVUN6aE5Y?=
 =?utf-8?B?enpRN0Z5WkZjSVN5OVRCcUEzOFdjKzVMYmFXVldtL2w2eVg2aGpNSXNiQUVI?=
 =?utf-8?B?clNhSzlGV3JiVzFrenZ1UHBlcC9uaGJuU0VUd0tUZlpFRHpDbkY4bmJZbFI1?=
 =?utf-8?B?aXFLT3VtYW5lN3FIdFFzakpZWURjVGhoWTJJcm0zbVFKSmdWMHlQWUhKaUtJ?=
 =?utf-8?B?Q1RmTCtocTVKK2haOHIyZlBYSGdtdUdHSzZuS0MzbFUyTVY0ekR0UDltUFBR?=
 =?utf-8?B?VTBEQU92Y2VFV0ZFaGs2WTFKMU5UYnRtSkovVy95Mjc0K2FtTk9Zdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c111d39e-1e7e-4659-641d-08df398f4203
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:45:56.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q30Qc4FjoBmWmHb7Vc2o4SP8OEor8l1xgL76iQf7tUlmvZpSkuO/SjBiShDLDu3H8nFoOExItQJv02N0IJbJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8580

Hi Martin,
     Thank you for joining this discussion. :)

I have re-examined the capabilities provided by pm_opp and cpufreq-dt, 
and it seems that we may also be able to adapt A9 fairly well based on 
the amlogic-cpufreq.c here. So we have no objections to the driver 
implementation in amlogic-cpufreq.c here.

I was most worried about before was that cpufreq-dt might not fully 
handle the complicated clock and supply adjustment logic between 
multiple clusters, which would have required adding a separate 
cpufreq_driver. But it now looks like this can be solved by adding the 
corresponding config_clks() and config_regulators() callbacks in 
dev_pm_opp_set_config().

On 11/2/2026 6:51 AM, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Chuan,
> 
> On Thu, Oct 29, 2026 at 6:30 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
> [...]
>> Regarding the concern I mentioned above about supporting a unified
>> cpufreq driver across S4, C3, T7, ..., A9, let me explain it in more detail:
>>      - These SoCs fall into several hardware architecture categories, and
>> I'm wondering whether we could take all of them into consideration and
>> implement them in a single amlogic-cpufreq.c, for example:
> I think the main question here is: how much code is shared between
> various SoC generations.

In my view, the main difference lies in the code that handles the shared 
and coupled resources; the rest should not differ much.

> 
>>        * S4/C3: 1 * cluster
>>        * T7: 2 * clusters
>>        * S7/S7D/S6: 1 * cluster + DSU
>>        * A9: 2 * clusters + DSU (the 2 clusters share one DSU)
>>      - For different hardware architectures, the resources that the
>> cpufreq driver has to manage also differ and are coupled with each
>> other, for example:
>>        * S7/S7D/S6: the CPUs and the DSU share a single power rail, and
>> the DSU frequency scales proportionally with the CPU frequency
>> (typically dsu_clk = cpu_clk * 80%)
>>        * A9: the resources that A9 needs to manage are relatively more
>> complicated ...
>>      - Optimizing the cpufreq transition latency:
>>        * Clock latency: for most S4/C3/T7 customers, the released bl31.bin
>> only supports configuring the CPU clock through SMCs with discrete clock
>> rates. Frequent set_rate()/set_parent() calls in the kernel would result
>> in a relatively large clock latency, and would cause the sugov thread to
>> consume too much CPU time, hurting scheduling performance.
> We also support a few more SoC generations upstream:
> - Meson8/8b/8m2 (32-bit ARM Cortex-A5/A9) where we need to reparent
> the CPU clock to XTAL for stable operating during clock changes (which
> should go into a cpufreq driver that implements target_intermediate).
> There's no secure monitor or firmware involved for CPU clocks.

BTW, could we put the CPU clock handling logic in the clock driver like 
G12A does (though, of course, handling it in the cpufreq driver might 
minimize the coupling between the clock and cpufreq drivers)? That way 
we could fully reuse the existing cpufreq-dt?

> - GXBB/GXL/GXM use SCPI firmware CPU clock control so to my knowledge
> we're good with what we have (meaning: no custom cpufreq driver
> needed)
> - G12A single cluster, no DSU: needs a cpufreq driver that implements
> target_intermediate (currently it's managed on clock driver side in
> kernel space, no firmware involved)
> - G12B multi cluster, no DSU: needs a cpufreq driver that implements
> target_intermediate (currently it's managed on clock driver side in
> kernel space, no firmware involved)

The cpufreq-related resources on the SoCs mentioned above are relatively 
clean: each cluster has only one independent clock and supply of its 
own, and these SoCs also do not support voltage selection based on chip 
binning.

> - SM1 single cluster and DSU: needs a cpufreq driver that implements
> target_intermediate (currently it's managed on clock driver side in
> kernel space, no firmware involved)

Compared with the SoCs above, the difference for SM1 is that it needs to 
additionally manage a DSU clock. In this case, the clock-related 
handling can be added in dev_pm_opp_set_config() in amlogic-cpufreq.c 
(by implementing clk_names and config_clks in struct dev_pm_opp_config).

> 
> [...]
>> The amlogic-cpufreq.c as implemented here can indeed cover the case of a
>> single cluster with no shared resources, such as S4/C3/T7. However, for
>> the upcoming SoCs where multiple clusters share resources, it may not be
>> sufficient to cover: for example, on S7/S7D/S6 the CPUs and the DSU
>> share one regulator; on A9 the two clusters share the dsu_clk, and the
>> sharing relationships among cpu_reg, cpu_sram_reg, dsu_reg and
>> dsu_sram_reg are even more complicated. For such cases, extending the
>> current amlogic-cpufreq.c would be rather difficult, so we would like to
>> make an overall evaluation.
> I think you're making a good point why it's fine to have multiple
> cpufreq drivers for Amlogic SoCs.
> My suggestion instead is to name the driver in this series
> amlogic-s4-cpufreq (or similar). From what I understand C3 support
> (maybe also T7?) can be easily added to the same driver.
> For the 32-bit SoCs I'm planning to implement amlogic-meson8-cpufreq.
> I don't know how relevant DSU is on SM1,

On SM1 (as well as other SoCs that contain a DSU), adjusting the CPU 
clock requires dynamically adjusting the DSU frequency as well. To 
balance performance and power consumption, in typical scenarios the CPU 
& DSU frequency mapping satisfies:
   - cpu_clk <= 1 GHz (the clock sources of both cpu_clk and dsu_clk 
come from fixed_pll, and sys_pll can be turned off to save power): 
dsu_clk = cpu_clk
   - 1 GHz < cpu_clk <= 1.2 GHz (the clock source of cpu_clk comes from 
sys_pll): dsu_clk = 1 GHz
   - cpu_clk > 1.2 GHz (the clock sources of cpu_clk and dsu_clk come 
from their own sys_pll respectively): dsu_clk = cpu_clk * 80%

> depending on how tricky it is
> support may either go into amlogic-meson8-cpufreq or (a new)
> amlogic-meson-g12a-cpufreq.
> And for the newer SoCs like S7/S7D/S6/A9/... I trust your instinct on
> whether they should be in one driver or multiple.

To summarize, the characteristics of the above SoCs can roughly be 
grouped as follows:
   a) SoCs up to G12B: 1 * clock + 1 * supply
   b) SM1: DSU clock handling added on top of a)
   c) S4/C3/T7: voltage selection based on chip binning added on top of a)
   d) S7/S7D/S6: have both the characteristics of b) and c)
   e) A9: has these additional features on top of d):
     - Handling the DSU clock shared by the 2 clusters
     - cluster0 and the DSU share one supply
     - The cpu_reg-sram_reg and dsu_reg-dsu_sram_reg voltage scaling 
must guarantee Step-by-Step Voltage Tracking (one can refer to 
mtk_cpufreq_voltage_tracking() in mediatek-cpufreq.c)

All in all, it looks like we can currently support all Amlogic SoCs in a 
single amlogic-cpufreq.c? Then, for the specific characteristics of 
different SoCs, we can differentiate them through the "compatible" 
property and add the corresponding drvdata for each.

I'll also try to support S7/A9 with representative differences based on 
this patch.

> 
>> We have done a lot of optimization on these issues from both the
>> hardware and software sides, and we would like the cpufreq driver we
>> submit upstream to cover these optimizations as much as possible. For
>> example, the bl31.bin for S4/C3/T7 has already been released, and
>> updating bl31.bin may cause extra trouble for customers, so we would
>> also like to balance this and see how to minimize the impact.
> I agree. I my opinion it would be best to allow the OS (in this case:
> Linux) to manage clocks so (closed source) firmware binary blob
> updates cannot cause any trouble.

Since clocks such as cpu_clk are the most fundamental guarantee for the 
system to run, in order to prevent userspace from arbitrarily modifying 
registers and causing the system to hang, we restrict these registers so 
that they can only be read/written in a secure environment (e.g. TEE).

Regarding the closed-source firmware binary issue, we are also actively 
exploring more flexible ways to avoid this kind of trouble.

> 
> 
> Best regards,
> Martin

-- 
Best regards,
Chuan

