Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.104
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793251812;
	b=5JO28tQTe9I6Qe9nFSI/YJvmaWrHzFg6AlE59n3qnkdyBk1TbIC4pwMWEe8yRCQP+AfJ
	 Xx+DgfAcYd9Y7/5+QvwJ+wQjt+s17Dg7YfqNTpK75H259NMEfvvN96/Ck8a599s8n/mZ7
	 PySQXluzOd/KgnbAtWO7Gm2z0pE/ewaJMqKKlDfyW/jVzibJ2DIFAK4t1N2YpyMHBiUt8
	 SJQc8W6rOiOYg3Ca1Z9beHyjiySNP3QW8/gN0cGRLzwrk3X7veQsvwOlVmQMG83MkNpC3
	 wiyzscrjF0yPqLQqt0bDNmNWXQi85iy3whJsPR85T1wdBOvdsXlJ/+cSqkcK2m0cA7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251812;
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
	bh=FsdGW7pA2KyCHESizRuAszeksHHdKky578dQJtE5Iyo=;
	b=xJ5iJe6Pn4R/TUU3AbksErUMAXnGnC95Ka5N007OdYW9AiF+Xwu82MYWMYQmWuam3zf+
	 TTCQF+0Y3fXlxGQhUR3k1YLbTzKhwlOTny2+2aKM5516mtsUV3czgUp/Mz0yOT2Wke7Wu
	 Za9kQsA2IVsIF8gWitrpjDqp3txksGP3mSGHVOEjDW6PhAhPLSbV8kiv7FhEoqdGngpif
	 ASnQQYcsMPQWci3gKiYNzvWq1Aq9Brw61JuhqWTOe4ZhiDOWixagOZFTJIHjCIyPaECAw
	 1mWSa5otckNOXgeiDdxKMQCKE+vRksyj8QpePdTSwrDDBGw0Rx1L+eNvVjGSa9MlUeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=wkLB+ABl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.104
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023104.outbound.protection.outlook.com [52.101.127.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE3606A31E;
	Thu, 29 Oct 2026 05:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01AE3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=wkLB+ABl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwE0qA8T/09798UZXc2Gtm/ZXfL7TUV8YvkaLSdpoq3KcXfBBjSTbvXHIuarAMWPBxdUO8vD+IH6hM+L6Xr88dJ4PyXVJMnv8HcV2u9VpFJbNDZBApfZCPRZ9vUzPP8cmAyybfKQ1AEiP66BGUTOLpeYkTpGg55wNEekDx/J7WbOFUYaPjLTBbUT5wJ0nCDFo9aKAuoJ6FmxBVVOUU1MF9Hd4Cr+6UqTk5eirhPU50OVB8ncsefeS5I0/iQOe9AQzK/1aj4vJIzl0M5eqvzY2v4JHlzBnKiYzSbP2f6/kTmKXxAZFQEO7Z2ZQNZi6Nh6eKJdHYFxUfoGeSHH4AUKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsdGW7pA2KyCHESizRuAszeksHHdKky578dQJtE5Iyo=;
 b=edPpLvzCkbHvzHZrkYvSbu2MeqwKxf6WojwzbNlSk2U2PTUhuLtMRzIYLiksjNLL03mdOKRJ6mW/fEfhXBdoJ8PCZpom7HR0BStCB1bNmi5rqIvMP+1+aKsiJTpgFIaDmjC2jXmHhhNGtlBkKJ6z1SDqzbX6GVjohHAmYwUJaLkEMrJS1lq7PU5etswIUBTOKrS2J2GbonvceYks+tcRhCyenWdJ2hWe0K1aIDLmcrafAgiqND/JfB85As2CS/P8i0/E9y/VNEYxBsFPvTKdbF1D4+oHfQavvktYTTQuZAUYnWO0hGzJLBG/c3jbe3gIC+7J2NuoO+QZEBA8UdPDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsdGW7pA2KyCHESizRuAszeksHHdKky578dQJtE5Iyo=;
 b=wkLB+ABlXkoH+g5VP+0DslhJLqxPhS+uo2g4HED3k5e/QSMxY/Hfh+v+z4ylhhX/wzY81KkyqnHMDP53zJzO04Mov9QHQcO/YiMcC84a9P4qQwy9K77+m1ajYSNziJBoXPDKQ8OtWagsk9JSTIigSHqyXs9v13Di4c72/ml0Lt5P/tW27N0vGMnUviMmKVxn9vEjVfjuDIoeRtvSz+GDrtkplFrMenfatFx7D1i9ihyet1gnknqSGtSZI4W6YFPdL0mnOq3Rn1MlDy3oiPh2c59kiKzIo+aY9H/QvOWv4Bxh6U5+T6JKUujtcCI0cPZGHpGcBvrl0d9FkLkF+cj3uQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB7094.apcprd03.prod.outlook.com (2603:1096:101:db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 05:30:07 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 05:30:06 +0000
Message-ID: <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
Date: Thu, 29 Oct 2026 13:29:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
To: Christian Hewitt <christianshewitt@gmail.com>, chuan.liu@amlogic.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 christian.koever-draxl@student.uibk.ac.at, neil.armstrong@linaro.org,
 sboyd@kernel.org, bmasney+clk@redhat.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, rafael@kernel.org, robh@kernel.org,
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
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <A45EC676-5B14-4932-A4CF-87ED3B71108D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0053.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::10) To KL1PR03MB5778.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: b33c17e1-8666-4cff-6193-08df357db0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|261028144727099003|11063799006|4143699003|56012099006|261026140227099003|261009223027099003|10067099003|261022075727099003|261026121527099003|261022105027099003|261009221227099003|261021121427099003|261021123027099003|261021135927099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	T+gMuUmj0rHVeOHao8C9FjfzAw7AX3QiQpqF/TlemiWs9dLE7hioxBXXmYM44wDpUS8xTtFta658EXp4nlv+Wwfo5Xfc0ZC1Ig6WMu/EYhyy8R3x3PFl3BWTn9gBP34vh6+D0y+B5yPNWb1fnuKtECTV67NICulztQAnaUfpUw7KRD0S0I2EH8KzaKgO2nceJ+WbEOYykv/iFbOgwu87CGBBimcB9l/XfVxSAAp2/0IuqVx1kWDcwWwku/8OZVQjjGTVOMLxxKBuR8ncc8ixH9FCBG/aOh8nDRup6GUYp9+CTCgl4qcHXdqPxdis6ntH1ZGdQS3VGkmHBczAbnu0deQXjc5u+63KeJbHp5JS5xbIcJzE7BNMVNW9sYGX3zOq50EWa6NN6QuGS8WpRiDrXlSNCSoP0uNjhVxed6My/oJ1a8nBBeBd0BYfR4PqzxaRusg78PoEJ+/QsT1BAeZIcXCEZH7D7Gv8oS+JrM07AgbLYH1q5usuRzD6+sI1l3kg/Ep0v38hgr3TxZdzoSHezLkqzNA8fyKQHstOzCz2JggyWn1XpxsT1WLJ+XTDKe7p7+scYkC2dvwsxoiIQGnXU/WIWbeN9Y7U2CTL3tj98xY91StX8UYhrV038tYo563P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(261028144727099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261009223027099003)(10067099003)(261022075727099003)(261026121527099003)(261022105027099003)(261009221227099003)(261021121427099003)(261021123027099003)(261021135927099003)(22082099003)(18002099003)(13003099007)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG9LTzE1Q1hSdXd1c3U1eUliNDNKN2xiV1VVeGlPM2xKVjlrQjF6MFFHUTFQ?=
 =?utf-8?B?OXJZOU02eUg5RFVMTWhKWUp5VllsaElydjBXL3dHL21TSjFJWVc4a3d6akhn?=
 =?utf-8?B?bUNuTkdWVC9JZkRGMFFGaDlIYUpHdGM1MmtMNWxja2VKQmRZMXJHMU85dWt4?=
 =?utf-8?B?c2xmZ0ZpWEVRdnAyeEJqaldFSjltcXFER2dyK0tuMk0yTmRqV1ZyUDc0UllG?=
 =?utf-8?B?NlNWNG9lN0lJUUZWSVgzdDFpVmRLdVJiN3NXUmZHb1NWeE0vWVdxVGJXU2J4?=
 =?utf-8?B?cUhRU2tNNDhFZ1NsSEhUM2VOMVZtR2Q2Q29RcmpmN0ZKaUp5eUpReW5OQmFK?=
 =?utf-8?B?VDN2ZVVkWUYrWDBWU25HVHpCSkt3dEhRRlI2NnlEQUd6YUVlYW9WT0R2dHBK?=
 =?utf-8?B?S0lZUTJlWXRsK0l4L3NmK09ZMFlrSU1OYjZabXpvRnNkSEtWVHZwUHlYb2pP?=
 =?utf-8?B?U0xZRHhhbk9CZHdVbndVSVkrK3VQMHQvbG5LQS8vcHAxTzdacUpaM0tHVXdr?=
 =?utf-8?B?VkRGLzg2T1pMMkZlS29yTjU3WmFWZEhlRVFMTFROTHppem4ycDlWc0ZnamR0?=
 =?utf-8?B?YnN5SE9iM05MaXdZZ3RZK0xyc1VtYzV6Q3BPbXFkZ0RFRCtRSExWRmFaUEFV?=
 =?utf-8?B?cnlIZ3VEOCs4cXJBdnZHTkxlaVBYQWkzVXgxK201S05xUm8xYW1PQ3ZZUkFh?=
 =?utf-8?B?cXhrVVpDOW40bVNGbThlR25BdnlVUW0yaGtTZzBQQjVlWnl3d0QzVnl5bS9S?=
 =?utf-8?B?VzFrOWxyRUtkRE5lNHVldDFqcmtlaEJPNDFWSUJiWnRmZktIK0FlZWhxVU5N?=
 =?utf-8?B?OE5MUitvVHhldSt1YzVGUXRkZDBZRys5aTVZUHRlNkZzVVRVRVFCY1RWbzJ1?=
 =?utf-8?B?akpybUJwTUZHYURoTVd2emJISGJTTFBNTG8yeHZxT2kvbU9DM2JBQjJ4L2FS?=
 =?utf-8?B?WE1jUk9yUDlTNUVZdmwwQThGVkRVUnNRMXNXR244QjdYMEtEMmwyVHRIbjA0?=
 =?utf-8?B?MFJJWUlSUnRWS1ZMc1gvbWtCRVNqYUx1a2lZVDBNU0g3K2RXZlAzTHdlVDN0?=
 =?utf-8?B?VFlDRU1BdnBLUWdNK0tJc0JMcHdDei9rb3phYk00SDk4Qk8rcHRQSHdvN254?=
 =?utf-8?B?KytpdHZxU2F5WkxuMDhtZ2hQOWNaR2t3c3ZUUUFmc210TkRIUENpY05wQkJH?=
 =?utf-8?B?QnBjQlhjMEVDZ1g3bmRNb2x0bU5ZeDYwK2JGYUEzM1F0djhiaDEvaTRCbURL?=
 =?utf-8?B?UENhQjdaUE9YYkpDMXpBbWxTUnpwb0Q2NUp0NEQ1Znk3ODB4cXVUcndlb2JR?=
 =?utf-8?B?eUdpaDZFRmtqVitMVVgyV2lJR3NCNXo2LzU3WDdVNlUxOU1PZzRwN3dERHp0?=
 =?utf-8?B?Z09ERm9qaDF1OGVyNU95eXM3SWVFYlZaa0JqYytoVThGWDdScVhkS3ZLQ0o1?=
 =?utf-8?B?ZmZmYVdmYlV0anBnSU9DNVJ1ZUs2a3lQcjgwNTVETm9BMmlGWTJKd1lYUERh?=
 =?utf-8?B?T2w3eW1JWDhGVkZVeEpCREFvY2JlYmdkNDNVTXVNUXFoclpCaHZ3UUhxMnFC?=
 =?utf-8?B?Z2s3WVRLRVEvZDk2eE9XZkppSENqUGRleGVPd1ZxNGw4T29qTmkrUU8ybGFP?=
 =?utf-8?B?RElnNjVMeXdkYVZ5cjZnK05uS2VlaG1kNGtxVEZpZ0lndGtFazh4V1NIMWoy?=
 =?utf-8?B?VHpzNklFbWkydDVjVEh1SVdBc2hDSmFxRWh4VTZDZDB4RXlPWGE1UEdCZVBT?=
 =?utf-8?B?Ukl2TDFzalhVRFgyWkt4eXRQNWpnOGw2cWQ2VjN0TUh4aHVvTFhkTGFmUjVn?=
 =?utf-8?B?TFdUSDllbFc3a0hQdS9PeFFtNy83N0dKc1owcFZPRjErQzRhcVo0R2tRdzJl?=
 =?utf-8?B?bkM1SDJXdEJTbTZmVWtWVlRUdFFVVUV1UzBkQ3RmNVBHY0ZTK08zSGkyZWN5?=
 =?utf-8?B?bnpWTXlYTnl3TzZFTU1hVjJMOExOUldTWG8yY3M5ZnJsWE02aGh1UG5sa2Rm?=
 =?utf-8?B?WEZMSTB0YW1lUGVEQzl1NkF6ay81MEVzS0NiWVA4OXFpK3RuRFRGZjN5aVBx?=
 =?utf-8?B?OEljU2FHcnJ1OEVoT1pkL2tEVTNhSGlBT0RuTHJsUmJaN0VML2tqNFVZUEsr?=
 =?utf-8?B?dEhpS1NWeisrbzBiSENRWjViQ1VOYXE2NHZxL3BoeUQ1TDI4UjVab0xmSE91?=
 =?utf-8?B?WFpuczdxMU9YQ1Q2WFI4eG0renlsZWVzeWp4ZjhmOXQyUVpGZTQrbDhoSllJ?=
 =?utf-8?B?anN1VmFHZXNwVy9pU3FMMWlNdFQ1ZHdtWG52ZWVndktvTGQ1aHFGMmJpNElQ?=
 =?utf-8?B?bjFYeUFUVjhZK3lWNWNrRHdzTXJDT3ZXM1hsczFJUXZKdHU3YkdOQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33c17e1-8666-4cff-6193-08df357db0fb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 05:30:06.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLubtPcZ/hPpJlhp4NUbFk5UZ8mNt0PWgnbaKe46oPjbOSYI85x4g7fY26RyljkfbUll+0d0UAQ8DapoNVSmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7094

Hi Christian,

On 10/27/2026 6:22 PM, Christian Hewitt wrote:
> [ EXTERNAL EMAIL ]
> 
>> On 27 Oct 2026, at 1:26 pm, Chuan Liu <chuan.liu686@gmail.com> wrote:

Sorry, this is my personal email. I didn't notice it when I sent it 
earlier, please don't mind.

>>
>> Hi Viresh, Christian,
>>     Could you please hold off for now on the patches adding cpufreq driver support on S4? There are still two issues that need to be resolved first:
>>   - The clock driver currently does not support setting the CPU clock.
>>   - The CPU regulator needs some time to stabilize after the voltage is changed. Without a proper delay, the CPU clock frequency may be raised before the regulator voltage has actually reached the target value, which can hang the system. The S4 CPU regulator handling currently lacks the logic to wait for the regulator voltage to settle, so this part needs to be completed first.
>>
>> We are currently working on submitting our own cpufreq driver. We are considering how to address the issues above, taking into account the hardware characteristics of previous SoCs and evaluating factors such as the transition latency. S4 will be covered by that work (as well as SoCs from S4 onward, such as C3, T7, ..., A9). So please give us some time.
> 
> Please don’t top-post, keep inline threading!
> 
> FWIW, the recent bindings/clock/driver work I’ve done for S4 is here:
> 
> https://github.com/chewitt/linux/commits/amlogic-7.3.y

Sorry, that's my fault, my mailbox seems to have some issues. I only
received the follow-up replies commenting on this patchset, so I missed
the other patches in the series (e.g. 2/4 here).

I've now re-reviewed patch 2/4. From a functional point of view it looks
complete. As for whether implementing it in s4-pll.c is the right place,
Jerome may be able to help evaluate that. Thanks for your contribution!

> 
> My speed-bin driver is based on earlier work from Martin Blumenstingl:
> 
> https://github.com/chewitt/linux/commit/77e12d4d584d6a8bbd93304bbd4e9bbbb6ee159a

I had also noticed Martin's earlier patch, it is a useful reference for
us as well. Thanks!

> 
> Setting a ramp-delay was the key to opp transition stability:
> 
> https://github.com/chewitt/linux/commit/ca7a99e86e23677c7b5af887e6f3b3c8ce3470d2

This approach can also satisfy the CPU regulator requirement of waiting
200us per 30mV step for the voltage to stabilize. However, we are not 
entirely sure whether this approach might pose any risks (such as 
causing voltage overshoot). We will test this method later and evaluate 
its impact on the output voltage.


Regarding the concern I mentioned above about supporting a unified
cpufreq driver across S4, C3, T7, ..., A9, let me explain it in more detail:
    - These SoCs fall into several hardware architecture categories, and
I'm wondering whether we could take all of them into consideration and
implement them in a single amlogic-cpufreq.c, for example:
      * S4/C3: 1 * cluster
      * T7: 2 * clusters
      * S7/S7D/S6: 1 * cluster + DSU
      * A9: 2 * clusters + DSU (the 2 clusters share one DSU)
    - For different hardware architectures, the resources that the
cpufreq driver has to manage also differ and are coupled with each
other, for example:
      * S7/S7D/S6: the CPUs and the DSU share a single power rail, and
the DSU frequency scales proportionally with the CPU frequency
(typically dsu_clk = cpu_clk * 80%)
      * A9: the resources that A9 needs to manage are relatively more
complicated ...
    - Optimizing the cpufreq transition latency:
      * Clock latency: for most S4/C3/T7 customers, the released bl31.bin
only supports configuring the CPU clock through SMCs with discrete clock
rates. Frequent set_rate()/set_parent() calls in the kernel would result
in a relatively large clock latency, and would cause the sugov thread to
consume too much CPU time, hurting scheduling performance.
      * Voltage latency: voltage scaling consumes a significant part of
the transition latency; most of the time spent in target_index() goes
into this, which leads to slow load-response.

The amlogic-cpufreq.c as implemented here can indeed cover the case of a
single cluster with no shared resources, such as S4/C3/T7. However, for
the upcoming SoCs where multiple clusters share resources, it may not be
sufficient to cover: for example, on S7/S7D/S6 the CPUs and the DSU
share one regulator; on A9 the two clusters share the dsu_clk, and the
sharing relationships among cpu_reg, cpu_sram_reg, dsu_reg and
dsu_sram_reg are even more complicated. For such cases, extending the
current amlogic-cpufreq.c would be rather difficult, so we would like to
make an overall evaluation.

We have done a lot of optimization on these issues from both the
hardware and software sides, and we would like the cpufreq driver we
submit upstream to cover these optimizations as much as possible. For
example, the bl31.bin for S4/C3/T7 has already been released, and
updating bl31.bin may cause extra trouble for customers, so we would
also like to balance this and see how to minimize the impact.

I went through the commit history of your repositories, and some of the
approaches there are well worth learning from. As for the Amlogic
cpufreq driver, we would very much appreciate your comments and
suggestions.

So please give us some time, although, admittedly, we should have
considered these issues earlier.

> 
> CH.
> also a Christian, to confuse people :)
> 
>> On 10/26/2026 4:59 PM, Viresh Kumar wrote:
>>> On 26-10-26, 09:57, Jerome Brunet wrote:
>>>> On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>>> On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
>>>>>> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>>>>
>>>>>> Every S4 speed bin runs the same CPU frequencies but needs its own
>>>>>> voltage curve, and the bin can only be read through the secure monitor.
>>>>>>
>>>>>> Read the bin from the firmware, select the matching
>>>>>> "opp-microvolt-speed<bin>" property for all CPUs, then register
>>>>>> cpufreq-dt. Bins outside the known range fall back to bin 0, which
>>>>>> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
>>>>>> on the SoC compatible and needs no node of its own, and S4 is added to
>>>>>> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
>>>>>> the bin has been applied.
>>>>>>
>>>>>> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>>>>>> ---
>>>>>>   MAINTAINERS                          |   1 +
>>>>>>   drivers/cpufreq/Kconfig.arm          |  14 ++
>>>>>>   drivers/cpufreq/Makefile             |   1 +
>>>>>>   drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>>>>>>   drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>>>>   5 files changed, 202 insertions(+)
>>>>>>   create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
>>>>>
>>>>> Is it safe to apply just this one ? I can take this via the PM tree then.
>>>>
>>>> I would advise to wait a little for Amlogic to chime in.
>>> Sure, I wasn't going to wait for the maintainers to respond anyway.
>>
>> --
>> Best regards,
>> Chuan
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Best regards,
Chuan

