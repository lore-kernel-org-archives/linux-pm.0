Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0038736C;
	Mon,  3 Aug 2026 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729490; cv=fail; b=XOCv0Y29VkUk8bEfQ3ZW1R71SCiuSYCUo1iaRGxwpyYTAq8sYlEXH9mHu3h0+0OcHFYp92PdqfzytJgKXnLmKeQMnce7N33x4zY7ngesBkAdKX4ULh0PElfjMiY/rJgM6uK4Loln8EqHAVk3rkenzVXmldLYcyVIRzVjHsVBTKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729490; c=relaxed/simple;
	bh=VijIk8gxfJOJXACoG4W6YH1Kq52NtGhZ+Qj7rabFYBo=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=GjWucDVIEdwlde10mpz3SHhey2Gw0wU43fWnP8bi6asurSKbg5A+wve6rB+LtGe4ZihPj7wyn1U7a+hKfpqAvUWnrnQhTSdissMoU32LpNUGGxSXL3T5xkYjf69vY3nCHWyqpLBKn5t12Obv7qrKd3ImRWm37RU/DR8cWhPE/N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9DyA5br; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9DyA5br"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9SzTtDbqbh9LvS1DuittmdQL52ru/gxtw3q/fpTRCXX15qf6E6kQGtVFVEcxkX+WY9ZO+M3vLRZM/ebcrGSWdzXpTjpNkHkiNbY9MvZIJe6XxKBMydPrNuEJCemsAMLcdz9P7i7xW9nAjsGGdIjoL8Tgy04a8v8kxN8/frGFD8t685GQ82Vh5zx/47OeqNdHpwklh7DMBIvgENOkAP1KX2Yjrd1swVS8xlbNyx2/i3Yz46EuuvmpBif+oZzUKFyoRiDGFfRsEUhR2rSTjyuR64/n37P5wgloKQMIsvc678u2OzlNwjuqap56fpu6G8zQCk0yydsS74jVIQAu+L7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VijIk8gxfJOJXACoG4W6YH1Kq52NtGhZ+Qj7rabFYBo=;
 b=kLMnLaos7ZofVQ5P3JHhwpPoAjwGwPZypyTjN3m3E5B69klnQLlQOJUfN13ZGSsUaJfRvhe0kOdBhYomU5RBvzx+v/mD6PjCYLwywP3NTq3dt/dPrfjH8q6lsD/DMTkc9gFhJA0EZ5P3km5x0iWDAqZkea6cxJhy7+IZDab6dyrx2p7r86K4/T0cTccqxbSz5pRVD51ElYF25BB7aebSh0Zg4w/A2wae9i0DpEI8aYlh2iMqGm9x4/O1yQ06ayNFnImWlqNT+t9I/s18ZXLqurjRk+z98KG0S1UMzyXxrDwJgHm3DvnXtkW6YNKFeOwiVTirYN/L8nnsxz3TF2XCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VijIk8gxfJOJXACoG4W6YH1Kq52NtGhZ+Qj7rabFYBo=;
 b=j9DyA5br3l8VIRlAo0ttUVHbs18YujyK6KM3vqKk7Gm98/LihyxUBDm4PJObsJ1vdrQS6JXHFkb11ZfDCzNs99lWauhKylZBOBvfQ4HkUfLiUR7m0WRicYC2FjfvO158rvQUcDpr7WYYY5a5+leTkn/0UMFYuErDwKJHnfTVq/8csucvk0RsP45S1q+p0NVVCMULAXcPq509qaKr4kCofmjKViMP7c54nDy7liXjfhrnOO1jCuP9gm5HshRlJrB+pzd9zKeYwJVmiPi34KRqZ6eayrmU4vIknVxifixRDYkoz+jFaCym2HS4b+Epyqz22O0pQhz6v5E87Lg7PZ5+nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 03:58:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Mon, 3 Aug 2026
 03:58:01 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 12:57:57 +0900
Message-Id: <DKF09OYPH41X.A5DBVPSRM4CD@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Boqun Feng" <boqun@kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Maurice" <mhi@mailbox.org>
Subject: Re: [PATCH v5 3/4] rust: clk: add devres-managed clks
Content-Transfer-Encoding: quoted-printable
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
 <DKEO9XYE7EGU.XU9OHA368TC3@garyguo.net>
In-Reply-To: <DKEO9XYE7EGU.XU9OHA368TC3@garyguo.net>
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e472be-ef53-4c16-db1c-08def113696c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|7416014|376014|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BT6+Qy+CeZJsOusdjTEqWraBaDuKMcPq1RbFY1vAkF5+ljLDRA8Pk8/i4/LMzHveFn9MrVYkBlbJ9TC3z8lF3dUsv60fVxxmQAndcSYlgguqLXXeJbmRPJJQ28rrCd/7lw9wbhjkbb9NGXM9dqNt9Fv5tHdXxVgWIM/6emhkxWBwsUE40eHynC9Pl+I5j1WMBbvAiqIRGYwETJLRWc1hrl0slFFUvVi8t2HhwMo88oX/MSO1iBlRljhhd7AJRKUFT2WqTTAu7IJk5eZujznR4sN3pXQWcVzuO1SPYld/nCVinnS301+7Oe1de2OZny4eGK0gyOco2DzIUpOEKiRndk4vAbssp+N5ItiLDXNtkxztmI/YZ2HDnD9DPOcr8I5m0Oo2mOZEFDsfA8l7OF3stkoN6c258/jvhL5Gx0Z1h7AFACoue8hIHKYJ6FCZn0bOxM4psFKCBNGXCDeE7ic72NLymnom9jmrHEt8zy49sSTeBZY4BiAsCYNYA2xqaUN8C9dLoHaKP3UK6HZAnxgrAhZUJrKEPazREgHyTMrIad24hPQgb94DPDWWOQDpt6JeGHPhEYcwrsCT3Q8jVms7i8K7ooOcEQcOqwz+hLzqOqV8vBY+WOfAxAovtU7UCVR217YlM6kPmeI1Tu9UynweZXqPFvb9oHMJSNWFXdGCDZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnN4NWw5aGV4ZTlmYTNmZ3NvNWhsOWpiVkRHZzJ5VDRFUG9aQVZuT1IrbnU0?=
 =?utf-8?B?bjdpN1cxU2lBWExnbkhUdWFIRDRaOXRJWndaeGNXdXArMU4yVWFud1ZMeUJ1?=
 =?utf-8?B?NllGcGw1RWhVRTlqakpZSW52STlMYlArWUJOam5KZnB4ZDRTa1grdnVKcTRV?=
 =?utf-8?B?d05KYS8rTlhhOU0vQisxV2JkZjdRTXlld0ZLdndQSXRxeHRtVmIxeXZTRkFV?=
 =?utf-8?B?MDB5SjFRRkZHam5Bc2U4RTQ0WGxwdDl4Z3UwUS82dEtuVGFiZnlNZEFGc0NU?=
 =?utf-8?B?cGQ4TzVjMEkvdDB1TnZXMk1iVndyQ1FaQlp5WGI2SFI3Zjdrb1ZweGpka1oz?=
 =?utf-8?B?d21WUVNiTkZBU2xZTEhZdVhxdForM3Npeis2YmlGb01wSTRBeG85OVRiclIr?=
 =?utf-8?B?NnBHYjU5T2hKY0dZS2VPbGhHZEZoQk9VUjQvb2pVUHBFbER3RzlpaHNyZlV5?=
 =?utf-8?B?b2o1QmNSRVVBWDFCNnIrbnZYMXgwS2RvZzBpT0tZNERlR0E3bXVqdDVmTHJ4?=
 =?utf-8?B?Z05IWXhFbXd6R0M0dWJDaTd3TU53VG9NRWlMbmNnd3dXQ2toZEJ1NmZnRjZu?=
 =?utf-8?B?cEpmbGRpNDFQeXM1YkNOT2lwOTNEV0ZaWkNHaFk3NmlEN0JaSnhQYkNDUk5t?=
 =?utf-8?B?aVZ3OFNHejhIQUtjVjJ4cjB1NzFreHhJSktQNGl5V3paUXlWNEtzNGhubXU0?=
 =?utf-8?B?VFBzM0hWMVpUZFNwTFJpYXZpQytmcWxHNFZwa21BaTBxOE8rSjQ0eVlITC9E?=
 =?utf-8?B?bVBZZGUyTlZyUk11cFBPajhUbnhSdGlOQVkwQnBucU5Db0RYaUVDRmJ2d2V0?=
 =?utf-8?B?RzR2anNRVWR3c05jd29UeXdpUzZub1ZRUHBwM1JNcTd5Z29USUpBOHFPanVs?=
 =?utf-8?B?YitQWkR6c0FDSFdwZlpKdXBRckpwR2tPb0x4MDZ6bkdiQUlHVWxrRjAxaTZE?=
 =?utf-8?B?T1k0YlN5T0xaMy81NUk3QWNGc2pmaHlvSEthZVN1RUtES3hlV1c1UGU3dnJ0?=
 =?utf-8?B?dlB6aGlSNkcrakhVUzZYSmxncUdHRTMvaVNid1F1bXkyNVFNK3pncE1XdTBY?=
 =?utf-8?B?b1gzVDBpV1B6RlNOZXNFM2c2YUVuV3laM0pWV1h4WjdlMHNxYlV1cWlrWXJr?=
 =?utf-8?B?bWdRNXNhVFhBZHJuZkdGVkZadnQ3MFBNZ1RJMDhCWlNaVEk5R3JHVWMrd0Yx?=
 =?utf-8?B?bWtCN1l0TUJSTHFFakE0bko5SlZyMzJTK1VqL0dlQ2FJYm80d1VvWllMQTdC?=
 =?utf-8?B?ZlRQYWpPWUtLNkh6SDJaY3dzcHJhaVppWkVWM2I1ZHFMT3Z2OUtSMURQMkJl?=
 =?utf-8?B?QXpTbU9FM2VwVGpGT3RXSnhPUTNNZlQxL1UvMUkyUFA4d0MrdFphamR2aTJE?=
 =?utf-8?B?QzNEdjhGL2VINGhOQ1h5azc1TWw4ZGgvOEpnc1h6bWlZRmg2VGFzOGlZeGNU?=
 =?utf-8?B?SEQrSFd5M3krREd3SXk5OE9qa1gvUjhKNjJEaFh2WkxRdUJFVGxvcHRYRnZU?=
 =?utf-8?B?U3IwT0s2dThzM0JtNFM1Ykh1Tm9TYkdHWS9RRVU1S2sxdWo0ZlJQMHU3WFdj?=
 =?utf-8?B?dldrM2ZCSmY3MjkzcS9pL0M5b3FXcU5SN0VVYmRhcjFGZ05teUxHQnRCb0lr?=
 =?utf-8?B?cGkwVlZuTHdWZ21Nb29xL1I1YWJvekxGZmpibHFobm9yaG05VmtLWGVvRHRw?=
 =?utf-8?B?YzlSWlZ4UmQrYUxzanVCWW0zQ1dwaGFnVmhiS0MxQklsZG5VYnowcThWV1Jr?=
 =?utf-8?B?eWN4WllLN3pCMlAyWTVnak4yL0tuTHRueVJPZjRIeVhXRGtIYzFlcXZyaThz?=
 =?utf-8?B?QUhSQkZoSTJWcHdUblBVclNjRWNLMWoyNSs1VStHZ3dQRVMrOWl6bVhUaUZn?=
 =?utf-8?B?clJWYUdybTZhS1NDRU5WMVlrMk1Lc210NzdHMXJBYndMNTFIZ3F0dzN2cVFG?=
 =?utf-8?B?a1l5RzNORldKUnVmL0lMQi9GaWVPcmwyVEhvUDBvUXR4dGM5VzNRUDlqdGY0?=
 =?utf-8?B?VFZIejJleGswdFp0T2VNQ3JZUm5qUE85U0xpWlhBV3RSbkl6Njk1RExKelB4?=
 =?utf-8?B?cHRJWFQ0d1hUUWhZdXhBOFFIYmtCUkFXMDdnalAxYTNzY2RQeVdjak5iNUhX?=
 =?utf-8?B?dUlTVDM3OXhFTkhZZjFBeXZMcUpaUGlsZURBN2h6UjBPTUFMRTdkZy91WWxV?=
 =?utf-8?B?Z200T2xON1c4ZmlMTEdORGpoSWszK0oyWXNSUGVwR0JGRmZwbWVySm1sTWlu?=
 =?utf-8?B?VjloWTNINnNmN2tLRERzRjFid09rTGdLRVY5RitzdjdmMm9qVmtMRVZMNDlB?=
 =?utf-8?B?cmU1b05sbGl1ZURxd1J3dzlZdnVIY1E0c3FvcUovbkJVTFZUUCtCemNHdDll?=
 =?utf-8?Q?P1Cz1JTs87oHGZhEeNIw3ty2r+YL2/HNpmoy9rUirVYnB?=
X-MS-Exchange-AntiSpam-MessageData-1: hOi/RihmKqSIVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e472be-ef53-4c16-db1c-08def113696c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:58:01.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEwsBapNZhw9wAjRSohxLjQzxtyZAAAqmKlJUF1Xc0Pip7gd5Fi2K4ojpeW21hdtEIAY1b0n33dchUvzt82Pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022

On Mon Aug 3, 2026 at 3:34 AM JST, Gary Guo wrote:
> On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
>> The clk API allows fine-grained control, but some drivers might be
>> more interested in a "set and forget" API.
>>
>> Expand the current API to support this. The clock will automatically be
>> disabled, unprepared and freed when the device is unbound from the bus
>> without further intervention by the driver.
>
> Drivers could just put the enabled clock into their driver data.
>
> Given the general shift from devres to lifetime-scoped device resources, =
do we
> still have a need for this?

This mimics what `Regulator` does; back then it was merged with quite
some consensus [1].

IIRC the justification for having this was that it's a nice
fire-and-forget interface for those cases where you don't even want the
driver to have a way to touch the resource after acquiring it, and it
also ensures that the resource is dropped at unbind time even if the driver
data survives it for some reason (for instance, DRM open fds?).

[1] https://lore.kernel.org/all/20250910-regulator-remove-dynamic-v3-2-07af=
4dfa97cc@collabora.com/
