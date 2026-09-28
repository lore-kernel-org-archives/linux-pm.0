Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B4325483;
	Mon, 28 Sep 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598100; cv=fail; b=SZAsQp/y6+pHIYxliYbsM8bTJaL6e7R7fg1FGA9NVMyGJJR3Rg+vq2atUh5Fz/6ptflP/jkAxRbs4KBHa4TMc81cMwOLSY7u+fYeKJ4IWUyhnY8s1e6gvHPaa5Ax/oauExZzMO6GP7KQwx/a8FBvNwzKowZlI+29dYwWLgjlT2w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598100; c=relaxed/simple;
	bh=nL8kDBDhGpWQPQvETvVCcR+RmB1cu+ukhnFGA1pK4C4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uy9ddIiZv2nMsSSPLtjO0iolO1nIIiN8z/xTCLrBOuBt0NcC4xhwg9NeL0XMy3g21M2R6hsVPobdK9/SDTTMHTYxJpqPPhNrQymlyccIYi+2qTErIYQtVXrkfzDJyFZYpSXO01kc9UmWOIKrBRhj8Jop3SjAN8JxUFGwzYHJnpo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LbsqGpPe; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LbsqGpPe; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LbsqGpPe";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LbsqGpPe"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gI+J1RiNMKrqp8MR81QdC9s+9N9RUj/caH1eQ0aFLP9S1yUr/V7ox/1wc7cmbUUNyZzHmTazLxfY3ooqrBr919y27KnNldn2hfDF++5pcwKkYie0zxGko27u4lLSJqF8Et9mzbk3cfSVagvQQry2HLNG/PwdHmmpezueGPJeZm7sm+esWn2MUC4oSMieSJbObhR4zWzfzT69Xg09CKI4uZtB8QWHiSA1MzWSVIMWgRWAhlS0shCpX6DORjskl2Ujn4sGiOS9oeJEgdAsecCpfboJd5Gy2MhZjFO/jvYW4I8BBi20qWrOW5alJzq+1hL5IP7otwGColDWrFAiC8QDaA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOV6h2iTpf4eKmJQNamxZYgk4AWA3jDKGVpHbBBSU2M=;
 b=pKmXjY0Q1zmojGozGhK5y00QcOMggTPyt9POLhiQPSrMPZJh3NCwBxRNiPe4ir205BEPfYI2cl9+RrDFr73iwTLWV/Pq/sDlUN09So6h0pammO20VOr/43TNp9pKx2MsfPVGZWygDoS1XNzbWAXiwSVZStJAMhWkbFd/2Qa3UL1vpGJNkdprGYtFgkGgA16IbNjOE4bbsxr1QlgKl44/Sx/FmGLmoDYR9CV8/XJUa4YGIFzgE3NATr3lk0iK9YPFedxaehfy/WkfoMbffEp0cQ2agyLP1y6ehgKlscHa4Bu1gCRRtWsSrburrdz6hrkjk0o/jiy5HtECDtm0LhD85g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOV6h2iTpf4eKmJQNamxZYgk4AWA3jDKGVpHbBBSU2M=;
 b=LbsqGpPevd3lAsurt/v0McgrmKm8VoiSYnwl9PS1zzMHQ4BBXEmXdGFOhrw7YnKXB8szzep6SGdXHDY/hn9KDewFGQGBn557w1jewsODeg1wtobDoIY2JcKmjh/EBbUIB5vLAqKdPJ3xe+WZq/xD1vg+dEPNhno+THHXbvjKorM=
Received: from DU2PR04CA0229.eurprd04.prod.outlook.com (2603:10a6:10:2b1::24)
 by DU0PR08MB9372.eurprd08.prod.outlook.com (2603:10a6:10:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 12:21:28 +0000
Received: from MAD0EPF000008BF.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::7d) by DU2PR04CA0229.outlook.office365.com
 (2603:10a6:10:2b1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 12:21:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BF.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 12:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd6Qb4EA2cr6P7Iewb1BOKuCEQl+578/7lCGMc19e6Y9zXUUr+hydn2Ele+BlfUPhf3GQ2T7ySt5a3BiQR0aZsGD0PoqZP85s9PasbI09iv5u4+qpRGTaGBYhbml64/4SmWt5Kmr2Y+oIaM0vSfx74NYG4o3vYYtLY/6AawSONZcDXkc6xoak+wn8FMzTViZCd4HYBfX3LZxbeZoQS30ih3oy8UTOJfIZxnpy+MwSSwcQRA2i7s3jCt61JpQVg9VWmEl94qjUO+bF5nvCOVH6L+BLv2IQY16OdnIL8UHrgsnk6v5boRYipAatp/BSFBmFxIH+HkY3kyYMV9DQ2YeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOV6h2iTpf4eKmJQNamxZYgk4AWA3jDKGVpHbBBSU2M=;
 b=HaoT7xn9q2+PMMlBRn8PYEow+OJtZCSVuVqOBJQ9ccAElcl1HtKuTsoklDheN0hcKKmgG5mGayGlfkDj/JFWVBJ7/X3iyLNhZ7dWeFIyw1cACjkwKv9vIlI+pbyLE36TLldLeoR5wY1LAxbkXvA1lFwOKymC0qtXh3Q4DyyBt4ymXCIoG5NTKBEKleqQucGBLFZXiTtULfxrkGpaZnAoj6FZTv2vlxAzt5wjSj7eJBfNOkvxcsfDyXtNCL3P2BidGXEFF41fJ5OXzWLv9hRdZhQNVvmQABbbNq72QCk0tPIPOQaK9MWtnrGUT5qa6LmJwpIK+1lccDQvSr8+O1GGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOV6h2iTpf4eKmJQNamxZYgk4AWA3jDKGVpHbBBSU2M=;
 b=LbsqGpPevd3lAsurt/v0McgrmKm8VoiSYnwl9PS1zzMHQ4BBXEmXdGFOhrw7YnKXB8szzep6SGdXHDY/hn9KDewFGQGBn557w1jewsODeg1wtobDoIY2JcKmjh/EBbUIB5vLAqKdPJ3xe+WZq/xD1vg+dEPNhno+THHXbvjKorM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBBPR08MB6201.eurprd08.prod.outlook.com (2603:10a6:10:20a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 12:20:54 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 12:20:53 +0000
Message-ID: <3a3e5dc5-9d1b-4bdf-a0a9-99eaea783f92@arm.com>
Date: Mon, 28 Sep 2026 14:20:52 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v7 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf
 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260807214837.863209-1-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260807214837.863209-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DBBPR08MB6201:EE_|MAD0EPF000008BF:EE_|DU0PR08MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e73d35-a703-4ace-2dae-08df1d5b051d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 zAQQg2vAjScADnAyNHu+Vo6iwWHbY5wvQDdSGUFc4R8QgZKuRxZ00gWkIlnoSFPLyzVDfPk4xsJRpcOZCGGkhEt84NLp9+in8dpEsgoUEQPw6sra6PCKdzV0Ejx1T4OV27smjm8uOBbuTuIayGsmMaG47KKKy6jPjd23Wh+NcJt4sbZAnQItY5ZORD6XxnrTSfB4OaoZ6PlUjc8uZ8e9ledU1lS3BBaw743FYB5rSZwZ/FCDzwdPrw5zyzL2mZB4g4f/GAxE9Wi4eWp5VW2x0/sKJPAote1LpxVW5zDBsG6dzZmsw/rx5QBM2pGgFTtF+7bZieFPDq3/9YlfIb6RZl4Q/0VRsiVqYK11cu+AHHKxGhHpcOugwo0yTfaj+EIUfQ3j8GynHLsCzFyP1YD3xSCnwbjezdp8W16GrEpiLYGRGyUlKkZMlcdoNlSktDWonFnCqgXIh/EDjHgWkajbyNcXo3P82zJ5AYZSw4f9qnlSUA4/SLCNI5Y2aN20ZqoXdkz8oRWOfyhWP1fS9cxmM7XSL7+UNNUoln2/g4AopA18ooRb1crGxIriP5KKpiKjtudqoW4bF8qvLHmtkZ0WayNz5WpQRIgyjIekfrB6o84wID7fni6lXldjaVczUkKSpmeOfuY7pD9YvLtFXYow2tgMkskOMB5v+Ani/zEYtAL5o0dd8XMsI0VDzIx0fa23KMuPUSN/kurUt/cROBIsPQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 xEYmLCEXVhu5ZiH3Io8wLi0qUFF6cICPgXP3kUgUqVJoDzyaxfjs5947ZagMiCrqyUsBxBNwd1mcJfHH7caFtode7E5HLx74ptPTl5FboKygf4Qo6hk1toD7Anh1qbq37DxN7hbAkQMb+c9BgA60eg2BSVYwfOaZKG6Z0JHfPrPk2HIElry/OOrmGSePrJb/QBOuRIAvosRSNz083PDI7F3wVFy/j1VfVOsG1c4iA294pP/WazH3e7b5fEIDAiYJkws/phUE/TE8hrwSLWMGNQRSti7EsLNq5qyA5IqKl4v8F+lGryT4NcBwnywZgFkW+5Bo8eUKptKR71YxIabrmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6201
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	807a73bd-1686-416d-45ff-08df1d5af0ef
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|1800799024|36860700016|35042699022|376014|7416014|23010399003|10067099003|6133799003|11063799006|22082099003|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	jkTeYmN180PQAx9h6aCLjZUDbJbNa7RrrMXAFnitZaFeduE5/PqLH0jXTkZKm+5UdY7HTc1/OxMgYeTcc9cON4pbe+AkuBqXJNKBn3I6t3X+i2r5u6cBuFBC4h5ejuONSxH/mxDMmPwRW7ghAZNf7YUv/Sk/8Zu3fLKtG6ASD4Qb5ELKous2AvkszWByvG6pTP+9Xbdm4tgMxpHG7QjZK3VpUMzjS5WrTH+umI45RFyM1I0yAMZwsA6pPDRgirnOZQ2zn1rIHb7C+Vayz4zhdtWdjswIx5hxLeYH9glDUWYQSBujyC2J8whQxFOs9JSbcTOaliVWFavKN056KVp6NYvzeHWQA3bdJeNezATQ96mWGuXBaX1aCRsNtIjZoOVPUPf+TqdTPjOTSRcohlx0yGq7ugkZTeSYZSrktTDwaerIeXq6SWklcT7Duy3cF4A/zSG9Fz7xwJOTDey6lETQx99it2m5T9vDtC0KBbAwxGSh8DVOYq+NuXOJYVGU8i7M8vtNm6wkJqAmNpVlr72OmtHt3NDxSRXoNLfltJyElbvIS4eD9pN3MPvIHNeQtez/twCiJc2BsFnXWyIJMk6XsJ28IKgm3xElANI1g/K8rhFFjMnPFw5KZWv2IBoZ+SwE+4dXzKu65crXR9qrkCXzoOoMAv1H42bUOISqXzZkhe/SYAMjnVQs2AXLf06lX9GopTVIkBswiqaITFMZFDoX7454pt2FaacSrydVtXzI85ld/2eD56tQCEbuixT7t0QK
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(1800799024)(36860700016)(35042699022)(376014)(7416014)(23010399003)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yt4yHm9GuNZNYYdOk1vet+VnKFZwatw+A2sIFPsJ9+gU6B5SgrpjCXM+OXVSM1kSB5VSOcg5qr0S2GTl7V2UtcvNqxhtHz+/bQ7gskKS4Nz0p5hjRJkSYiE6Cj9scpndhMosxfWmXeg8y4LOsKjeW9wtCeIptEkjXRTBWP6BTidAEzFqjWTDoFNLkKavON0DO/jNdowsavbIja17G3wj5Xm9vZamqdLUXdddK6A6en2dWcLxWlU+SD4ZpS5VZf/lxRTfCjSJ1ONtBsh91ih2vMwKCrQEmtl/MmAvLVzrCDGSz7qLcSn8GI6agxxoDU3AoMtWnjOwszhOQKIfhIiCgshpeJ0Pqy7tNpFYvd03g/lsTxOXm0ICkpQFCxtZZfQ0F98uWJQFyLoFsOkSIbzYW5hbh1z+HgwQEBPZs2A7P9rFvrM8eop0XANAU9NsF3Lf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:21:27.3322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e73d35-a703-4ace-2dae-08df1d5b051d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9372

Hello Sumit,

I have some small comments on the 2 patchsets, but not much
I think. I had some issue to apply this patchset on top of:

[PATCH v5 0/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug 
and unload

Also, I think it would be nice to rebase it on top of Christan's serie:
https://lore.kernel.org/all/20260916162805.1039247-1-christian.loehle@arm.com/

Regards,

Pierre


On 8/7/26 23:48, Sumit Gupta wrote:
> This series adds support for the OSPM Nominal Performance register
> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
>
> Unlike the read-only Nominal Performance register, OSPM Nominal
> Performance is writable and lets OSPM request a nominal level below
> the platform-reported nominal. The platform treats performance above
> this level as boost and below as throttle for its power and thermal
> decisions.
>
>   - Patch 1: adds cppc_set_ospm_nominal_perf() and
>     cppc_ospm_nominal_perf_supported().
>
>   - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz, and
>     tracks the register in the OSPM-set save/restore table. The register
>     cannot be read back, so the attribute is write-only.
>
>   - Patch 3: reflects the OSPM nominal in the cpufreq policy, so that
>     boost and the frequency limits stay consistent with the register.
>
> This series applies on top of the following series, which provides the
> save/restore table that patch 2 hooks into:
>    cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>    https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/
>
> v6[6] -> v7:
>   - Split patch 1 into an ACPI patch and a cpufreq patch.
>   - Patch 1:
>     - drop cppc_get_ospm_nominal_perf(), as the register is write-only.
>     - add cppc_ospm_nominal_perf_supported(), sharing the setter's
>       writable check via the new cpc_reg_writable() helper.
>   - Patch 2:
>     - make ospm_nominal_freq write-only, and track the requested value
>       in software instead of reading the register back.
>     - place the register before auto_sel in the save/restore table.
>   - Patch 3:
>     - rename *_reflect_nominal() to *_update_nominal_limits().
>     - do not fail the sysfs write when cppc_cpufreq_update_nominal_limits()
>       fails to update the QoS limit.
>     - skip the limit update while boost is enabled.
>     - make cppc_cpufreq_effective_nominal() take the value from the
>       software-tracked state, so it returns it directly and cannot fail.
>     - init() checks cppc_ospm_nominal_perf_supported() directly, instead
>       of using cppc_cpufreq_effective_nominal().
>
> Sumit Gupta (3):
>    ACPI: CPPC: Add ospm_nominal_perf support
>    cpufreq: CPPC: Add ospm_nominal_freq attribute
>    cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
>
>   .../ABI/testing/sysfs-devices-system-cpu      |  24 ++++
>   drivers/acpi/cppc_acpi.c                      |  48 ++++++-
>   drivers/cpufreq/cppc_cpufreq.c                | 135 +++++++++++++++++-
>   include/acpi/cppc_acpi.h                      |  10 ++
>   4 files changed, 208 insertions(+), 9 deletions(-)
>
> v6:https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidia.com/
> v5:https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
> v4:https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
> v3:https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
> v2:https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
> v1:https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
>
