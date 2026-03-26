Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D60341062;
	Thu, 26 Mar 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515339; cv=fail; b=k0ERe9CTo0+/5Wd2PVoV6pEG7SY6ZgmQKetY1yILD2LuRgLxnazaJIuisCLgEHnBsIcr8u9bVjJ4kdhrtNhyP7xdNUkBP4qtjpHRd+t0BRNTO5vo/HF9E1kPJethQ5FE8X5hUXaWhyZQWkXUL1TIvD9tVGXniJZsO/xgB+uml3o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515339; c=relaxed/simple;
	bh=3rEq6vfA8Y5j5y0nYGL+3ipxc75AhkpOzXjmMAykOng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VsO6LihoJK5sSxajmoRtP77MjouuHkuoso1nPB3wnloNEkPM54zeVw/B/yhDO6sXlJc+VbqwpN3E8jlR4MxrLjUKMIib0LwqHEzO4yFJy8P2Pp862gyfgRrT7YgLuquBPlkUP//hM2EhhfhzV2kKAaNwIm0IQSKv+mYiZtPsaWs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CqhH9bu3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CqhH9bu3; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CqhH9bu3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CqhH9bu3"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u62a0ciPylYgnhcNvXPSVPNjH1D8Pf1iRCke2tuYahreO4Yb/BspICKJl7Ug9b/JCpTWTczfwZeRs7oe9L8tIcwQdjTV78f3E3msAmGchCzXDkYznxFLHYT/zWrPG7osjkLQUEhCdqVrXg/ZGglH5n5GasEffP8U6Daer/aVfbUs586laVUzZQpRj0iVoV4/xx0FQKUE4ZwUXHSXXgi/VXIvuiv94pdfRYinvMXuMS6zhSDIM2529QiBLuY28i7AS13qLuynOv2/PJ/jeyUbfWiO1EXT3UAs+sOVoO2mMbf6FltjkEWnx7vXEABpLteunFfoIrFYZxckrL4l0VmJZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbSG3gWxyxmbnmyELnj6qXDmZfUD2zkz50GzzdBtGv4=;
 b=IcGCmbsyQOnCvLKYIQtdL4BRfoonRZ1xb0Wdtw3UoJEDyvJdjarIabRWJh0sVA1T+8O2vvx+6GyyvJe0f7Aap/4eFZ1wnP1A+w1TjnDZFoIAyVTTH2iB7Ij18o/hHcu3tCBi+M65+IXGrNF/byLbQ2Sd+7IhvXiEBEMv84s2Jp5hOgLzvfoqQ9FSh9AcdzJCH+ismvfnuP6x1YE1UEMxW5KlB3PT1cIPcaYxGNyRELyYxyFeFazFmy3FClHiSmTqbbM6UnRjdZ2eEumRoxdYkaE+p4BBNuUaFRPyld9aR/Yp9N7VvrlM2S+S+aJiCmuVokSxHC8F7dWqk5VQ9ApdKA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbSG3gWxyxmbnmyELnj6qXDmZfUD2zkz50GzzdBtGv4=;
 b=CqhH9bu3uqrhNoEwUw2b2ezom1+h6TuhGthm0Vd3Z7hU36p+bkXDTFXh7dd50VpJW/M46une0hkLUDw62bP+ssyeE88NfeBr1bm6DxRRJPtDHclvNfcLhUS++wILJ5ED69urBIKVC9LutQLeRYkNFEEfLbInKuSjLgWnRsn5l+M=
Received: from DB8PR06CA0039.eurprd06.prod.outlook.com (2603:10a6:10:120::13)
 by DB9PR08MB6426.eurprd08.prod.outlook.com (2603:10a6:10:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 08:55:34 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::ea) by DB8PR06CA0039.outlook.office365.com
 (2603:10a6:10:120::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 08:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 08:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1tlrhp+RIg9+0VDD9bBVKeCXzjXXrp/HX4DZtFaDLMTqVMR3FkARyIbcdslQoqJoBJXnuy+Eg1S285JXw8wh3jcmSSQgsEFP8O+6LkWc/EBNN+xEwrd2ZN2RviJ58+ujn9gQXQBeokyNIOu4YnsLWJFhfIkN6ZDePqAf6UuX0nNmtqwoF7oK33/xs9i9fPxvDGF5dA1vQvP1qUx5yTnp3jHcbr0ET8P4bZPUgsHEC7qtYu1Hxb9/xS9TQjlonbDuteyWKEURXXr0H+YFhYvtoTkBsiitBL6EVKyoaRk4+GLcY+qqj8MxgT1IfpFxgNWbCU6yQei5Jp67Sx3RLVSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbSG3gWxyxmbnmyELnj6qXDmZfUD2zkz50GzzdBtGv4=;
 b=EUHJ+G/e0zbzJ5eXatSR8V6jxFaAzdM6xV+TtCRMoxiOBJeW6XTCZljvoa1uFPD4+fUme9xX/hLdPnNY1+bOu8fZKSFcNJY1sqf48WHccaSsABrQZZtrDQYNlCbR6VHZnzzNamyz961r7jWEfQ60FNRXQdHvD8mtFj5oaw1Mpl86mtDwPOxQGr5ALSzXhGEAfzXoLjNBX/5K0XgBrzsVuY5GD5Pc9D9qnLnM+OSMQMJ4/heGZEkwmjJExaZCt3pdKVLbqx4Y8FhCx/tt9YuwwT7w89pnVmgtkcvrBGmSXWqOiXmQGgEOYgfl7J1Sii+PZxO8j2WiKehtOjYxl7YArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbSG3gWxyxmbnmyELnj6qXDmZfUD2zkz50GzzdBtGv4=;
 b=CqhH9bu3uqrhNoEwUw2b2ezom1+h6TuhGthm0Vd3Z7hU36p+bkXDTFXh7dd50VpJW/M46une0hkLUDw62bP+ssyeE88NfeBr1bm6DxRRJPtDHclvNfcLhUS++wILJ5ED69urBIKVC9LutQLeRYkNFEEfLbInKuSjLgWnRsn5l+M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PA4PR08MB6256.eurprd08.prod.outlook.com (2603:10a6:102:e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 08:54:29 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 08:54:29 +0000
Message-ID: <f9c94614-313d-4d2f-8374-cebb329a6c6f@arm.com>
Date: Thu, 26 Mar 2026 09:54:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
 <hajhezqrujiky7eo4eidogvjomixmhtdxpzfjibrd2xbhxawbd@ptljcesqpyqx>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <hajhezqrujiky7eo4eidogvjomixmhtdxpzfjibrd2xbhxawbd@ptljcesqpyqx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PA4PR08MB6256:EE_|DB1PEPF000509F1:EE_|DB9PR08MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: f3657a31-02d5-48be-fe3e-08de8b1570dd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 igHmT7cFrmT9ZmNog3HY+dRTG2AFgVdPwi4mEbAEMglKg1cKD0++lVKCoMuHi3IXq8VciQW6eYEToM0FnwVtmkMOdE9WGkN8RaoC2uB9X8Kaw0tj2Rp/sSheuUuc0U7zTUju1WFggoE98630haWB3HONMw75NhdbEILa5vRbGnYnYV2wFOX1mWwCDnpmuSdoJndfaYF2Uv1J30Y5Uk2MF6tJ1aW6xEPMVhIw6uHPY+wKsASBa2BjIGzOjuMraSxBcWnoBl8d8FgTymiLRy8POWe6UiUOfxXaB8mzJJgXayf4qAww9LFAXoehlI0lzLRUYkoVZ5ZpC1UAAl59soGcIQSzNyF09sp6js5v/vgHwgvtWPvV0WnsevnMl3QfKcb3SC9xD7CIdYrh6jKgKa2xtbh4yGdyMU0LV7UezQFq1Sz8nCi2KqqbT42XWKyxokr2VtgVNAkrNml8bFQVkkJmF1Z3w0h4OodQ4kGsqvzvS8/yGIf6XOMhDREDBz/DMgi2oJQ3VYmQ0+ZS3LvTzr8As3QAYBhMQJMMzeKFAinhPBwMI5a8w/BDgzjtb2wEEFfewSFanislvZEV4Ptx1OwWp++wpz506rW76JcMrwFwnce8zZ1XdRee+5seZ951FU5LU8a5Wd3eYiLKq5md7HE4Hodo7H4+uQciCrIc56ZOYnZ+SfxiQuwURdH3U5WwENCf5oHHmshgKJeVwaQoxXwyKy9JcGHIPWMxOBcg8Jmurv0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ej7fndqbmXB1/Uxyr443MvmoxtfZONhzWwlHqtudwYTDyfWkkJJFfZ5H6rSP1z8TwwHMpu8vkckUsxruwhdDW/+xG5dL9gd/+sn1CprqJ9DcZbYeznP/ob22KyKo9vd59jptSjar0eYFdxCPHs5/athd3StKrYccRn3EYN/dd5FXC/k352J6fWRd9miK/MgHnHBo3diS5wo5rrF4MShyUtDHmCHOwXBoOhehf6fNs8yUry8WYsJFbrnsy6dSVI7iYE2n5kb2x6AmCd3QJa5jxlsLCsqjXZFeI4eTrSRiom6GHGl2HAbAu44EzH6c7qKzauNtgDTQWH9dFQj3o6WKeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6256
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	22834acf-6c57-4459-297b-08de8b154a06
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|1800799024|14060799003|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zLLUcnlmWUz8yqv4yOe4OPis8MHph/uy7YlgIYsDlkdCQYIxY1Y2Z9APeygtmw3xMsTDvH91Mq7JGVGBy6nRjGnJDl/jK9n7VbcG+a/quLgcSc8xWHE91rly4X5dXJ5n/dCh26NootrU875lU+xu7n4BJxw24Y5Oh4UmaFn1mNDVMn99Hulg6y9KxoJjXPeHgr79BRGE68LqOuTYBQQSrJ+hhxyGsaLbd0X0XxqKZb3Awp/ytd2g9ntm2ov08SaqWVLNulKQuTaIzgiTHDqPcPt0JrmhrMMIZ/inF7aNx7qtem3/AKelGuDqjpppHybWhyTaEKBfOTqQwS2W2z1BHpvF9x88l+CO025TxL77AqySll7gL7U90gaOH9iW/Iwja/tFbBU5Lmd0BrMe9Ix6MhLf7h0FonqM7sSVYWWC2Ga19YQkvf7sW3MyzIVlOhLrm32XKvsI0ghzdovv/5wM/BFjLtNnDg2GL7Hk+nR7bMGXsDheDQNqCVvJmZKF/nH01pfMWXVFAkvanhcRBofBKssv3UI54bMO7hAXozkT21QUG0UYiBjzEHmSVSNMnVazzKbkLrdvgsHUqs5FXl08lBV+xt/kYSWOK8nU29vUrXm2lapfh8hlQZOHYE1lxgHGvtBWgOnes7MHkLxHu2ac9hcNQcZ05s+KJOBIFkNjmlCffVzfvNFCUjAt/n7H61Buw73lS8vg4ublW4TQUvTO90uDMDuWQRiodjQ96JGbGjtjub6/taIG0qo2pTeAX5bPYFkikrsqg3lMYn4ISjJlNw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(1800799024)(14060799003)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QeL7fniX6BZCKMKXWMDMOeSQ4YeDs29pL7oJrwNlvV3tihJBaU4jd0LldVaZ25wZQeHmY5HZVEmbk83czJpC4f+Ef3SK/VSujUcCedknOZSQ/EdBiOWXw5NbNWPqf8jKOqp1w3Q1ziZs6I0iuHzInajpMKfhhg2ryFcWp+dWFJZLA0mkRquSvLOS2CC1DHt4rGqUupWEowZKRobD6fr0xEF5kqaSRHvIshiyCv9xZt1D0t5U3EWYbDxpbwxJ2c4KhdwhtpT/7O0tm5mKQX5mxMWpkK2XOrUlsSlfmsRhLi7VxdYFDVGIEWyUdT5MOobLMpFjTXpH0FQYkV9Fx6IjH364zE/iRskGhHWNTqRXa7LM69YY0XFSvF4J50HWYzRNUCEcwuazajr+JmqkMGC3X/HRDH3Gk3L+et/rTXOBZpR71VQKv6pwW1rbm52lXk+1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:55:33.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3657a31-02d5-48be-fe3e-08de8b1570dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6426


On 3/26/26 09:48, Viresh Kumar wrote:
> On 25-03-26, 17:52, Pierre Gondois wrote:
>> @@ -1377,6 +1386,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   	}
>>   
>>   	freq_qos_remove_request(policy->min_freq_req);
> Since this doesn't check min_freq_req (and depend on the routine to return
> early), shouldn't we do the same for below one ?

Yes it is possible,
there were different views but without the check is ok aswell.

>
>> +	if (policy->boost_freq_req)
>> +		freq_qos_remove_request(policy->boost_freq_req);
>>   	kfree(policy->min_freq_req);
>>   
>>   	cpufreq_policy_put_kobj(policy);
