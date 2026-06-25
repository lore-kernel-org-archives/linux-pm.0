Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288E3E0097;
	Thu, 25 Jun 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390068; cv=fail; b=SaB3n83UTQ5g+eBBDFny+cep6wpghLT32QssJn6hjWnZOknnVQxCyd0Ez6qh4+uFvd2NfhVChG37LE0/CL0mmFXjW9q/sKTov+06tK8Z3AQB7sbsN5pUFVnUi4lf7D+waAnc/3gZJGq7Xz4AIb5+REJfnhiF9irQpQ6pD3eLZ3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390068; c=relaxed/simple;
	bh=6eDmvG4qv04dBrD7APZJuywt8QYxkgjZw8G8T9S/cd8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kpO/idjBBlxD3zl1B1R+82319osvd1JknFcC0ZL43c9iP8rdtp3nUdN6Lk45MOPzgAXZy5MT7Sk/z7A8LiKrIbEi+BIhHFIet/d8t2zLYpREDz3snzPugGkiEduURcWBYyoq/P94x40ODxrFKFNV36BYiYq4/Oa3mLg3FqeKp+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MQoTEQxp; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MQoTEQxp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnRND+LeWP+m1rpw5ZcFOiUxJ8bhLwamckxjOXWXSBdMHLWNLt952gjMNI0h6zAv6UKzFVdZrjxNtCbYYlLiQ46hPU7rZKHhyDc3+RE6OyCKOGkdjboWfZeG2kdnb2dr/kJjBZ52oLaS7ShEWHg5OLg0XLdkaCe2GILnQ7gZqWwm+OL+Ny5hva8b7LIU8C9GlbEg0bg7ePSp15adhHORGVUD/epHRIMX3iWc/ZWpVdLMoj0S8Ytb9Iyeblo+h1eO4/o1WJBtU3/sjMMKsZ1nMCfHLpnslspomqfYCS/8N3QQ2EqVkpgIpeJA2ffhcXEu5NwaHPC9L1oEJtJWt0QNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEGnRl5px6gpDCkAUbm55fENrAfDvauFxSSF4y7HoQc=;
 b=gqjbuCI5oAY78n3A9z8L77pPJ3zoz7cbkCUaX2X8NyeuoccOtvwlDl/KJIbFj2QAywK/fp7S3D+GErU8VZbAfnadNuVkONREVSZFtgTW60XD/4sYM8QqK7yqyRbFuh93nXRoNgvoxPq/Prnz0hEo7+yRn7Oyt9UMQ2Z4G299dimtf848ms4MhGG7hpQzE86VDdzBwDopRMpQpFzmdP960tem8H/7prXPfkZes62hvnCT3Qw0ss2dpeKHCwloNJjO6y7jseJxBWw55KxVdLHtcgla1DslgPpZesVAVNEac4Y9T/y07kNjcIZRbB0/EQ+GkiM1h/1fMA+tBmx3ww8NWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEGnRl5px6gpDCkAUbm55fENrAfDvauFxSSF4y7HoQc=;
 b=MQoTEQxpFwh/Mb2bNvjJS9NTOlUXFHtscdGUytsWzBpLSIsYfLTl47FQmqfk3caSMVYbhuqU4JZpD5W2FRFgJ2EU3z3zbZOB2dYrRTtjBSOSbCC7+pv0FfrvOT6NnrYsM7QcVvzLM448Y/nnNhVbZGTqYqx7Uk9AdNB6Gkuc1MA=
Received: from CWLP123CA0188.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::17)
 by VI0PR02MB10804.eurprd02.prod.outlook.com (2603:10a6:800:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 12:21:00 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:400:19c:cafe::51) by CWLP123CA0188.outlook.office365.com
 (2603:10a6:400:19c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 12:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:20:59 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail11w.axis.com (10.20.40.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 25 Jun
 2026 14:20:59 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<kernel@axis.com>, <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
In-Reply-To: <18ae59ae-024f-4dfb-ad66-2db90e6f7ed4@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 25 Jun 2026 14:10:24 +0200")
References: <cover.1781789320.git.waqarh@axis.com>
	<96b7d1a0aa0c00929f0fef2847db116b54079a30.1781789320.git.waqarh@axis.com>
	<20260622-whimsical-inescapable-pronghorn-5f94bb@quoll>
	<pndwlvm6ese.a.out@axis.com>
	<18ae59ae-024f-4dfb-ad66-2db90e6f7ed4@kernel.org>
User-Agent: a.out
Date: Thu, 25 Jun 2026 14:20:59 +0200
Message-ID: <pndqzlu6cb8.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail11w.axis.com
 (10.20.40.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|VI0PR02MB10804:EE_
X-MS-Office365-Filtering-Correlation-Id: 6def7c53-e429-47d8-88c8-08ded2b4377c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|3023799007|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2bQkhGCgr3Xr7f9a5cWoCB783JsN3yJ2OJYOOGWZqRIt67KQAAXSXCxGR0O3N5tGgiJaOE5yVLiLmJddgu+wP8b34rY4pmVSAy2Q+otEyj/TA42BMK1RAstftT4kDDwC3OkzHMuqScekPGqHIsxsQddWZ2qirfJ+oL7XL1GyXcQIk2dkougnYTWE5pGFdEzuE0+HsDNrkX7uHUNFZgW6kx9p2x3igDYkgRhs7smbW1B/DvzVdiaaHo3nh1OEBCTBiMiNXMeqG8se4OwpD9Bbsje+VTyBLmGcLF726A5ZFj4SgLjpfuFZgahI6QUKshizYFU3UqECrcqJU3MBYBEAGr5//BV4xfmPrZjolAxOXy9OeTl0G+vVDAle/dyFvehRsfmNvbh7ZjiOJM0GFs25YonVTIlN1qhST49oIgSr/o1gQf7aoYu/ROpvJ6C1EJP2saukrSjvFL4Hqr4iJmKgY9duMOkFwWrHWeZ/jMnlq5LONQ9akuJ3bw9GQUCXvUToyut1rgyeDfn0Kc4KY28RvViJFZaLwyq0taFa5mk2rBhFp2hemHgORpTZi06qnXBAWTCmtVWTtlxGJJJ7sRKCE420BDG3W3w3OvIPYn7mKkf7HNRaGnq6kCyJYdhhporwYkTGVghNOB4rgO8aMfnkj8NaVco+qBUgftlkxdv3KMaj66cxbQiRnIi6iLTBXXzixzeiMsXnzQBZXH9BDWk38Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(3023799007)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ayPK/uYYyj5BWgcPEwv7QqxIW9oQRElwKSpZgJlHdGcSFe7ROsoTF6oJdyhVxiFPOklOLVp7EScM1BAX2IaXEpQMBEMA7sFx2yzvNTQECEgayyvCtIMMLy8A9mRGKKQmiQ0eIKhYENV9fdgfzlhVHVOOokev7/JEPKtY/Mbvyt8L+slvfHMHFM0jJusHfaiRj+yxgy68/BIZHyNQ6syygWGMXFA3ecOsVCW2yxOkX/bKRkce+To7z1ILlRbu1F798IiyDbFeBWZoIAlZgacT9o/iWtMET2l/XrY8X9xZs71YePBy9WiBpV8EnWxObvF7V1eqOSnTL6w+/Sj46936Sm62Ud7Dl1dS237rUgN+g7EjKxKQpZCb0ulJ6+1PFhfTaglI9OsLRLjW5Kcw0HuacTs8P6mNghRQTp0vp3YyXWGYKVxpQQTtk8ijt9FOpcZd
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:20:59.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6def7c53-e429-47d8-88c8-08ded2b4377c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10804

On Thu, Jun 25, 2026 at 14:10 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 25/06/2026 13:27, Waqar Hameed wrote:
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - interrupts
>>>> +  - monitored-battery
>>>> +
>>>> +additionalProperties: false
>>>
>>> And here use 'unevaluatedProperties: false' instead.
>> 
>> Hm, reading the documentation [1], `unevaluatedProperties` should be
>> used, because of the "include" of `power-supply.yaml`. I'll change to
>> that.
>> 
>> However, there are tons of other places where `additionalProperties` is
>> used instead _with_ a reference to `power-supply.yaml` (which is what I
>> followed). Are all of them actually "wrong" then?
>
> No, they are not wrong, but usually preferred is to allow all properties
> from referenced power-supply schema.

Ah ok, I can see why it's more preferable to be more "permissive" with
`unevaluatedProperties`. Thanks!
