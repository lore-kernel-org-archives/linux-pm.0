Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E743C37A2;
	Thu, 21 May 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364785; cv=fail; b=VxU+FzOtOXaNpXN3GO1iRU62qvJdM8vHZjKa2scvl4yq6n9tO2IRCCi3i6gJHLuNDR8z4beoYvk0neQR6KF37sdJWmgWPXg6uwoW1BMqibXp2GIejigp5ZqH8Bsm7/UqSZlReh6sucytc/YKrOyhhpvdthd3VIYdyDVRWc5S3Fo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364785; c=relaxed/simple;
	bh=ma8W+Zp+XJt3JApwmtsscoz3vdgpQPVU0dqvEq9zgYQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UGE70R4fmIg8VaEqL+6LdJ8Ngs/ppQ1W21X+s/nS1wTF42+W4BSmRbyMIqPAdd7Dl2e+7zTm0VGq4x2DIvSwuD+z/Pu/iFcyT2LPM80HTvEXhuCTbKnBEWiwuMSPmd77dsSiDDy62q1btVIonmOzZdX/O6IyvVRdRw/JqihiV6I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K90jfo3L; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K90jfo3L; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K90jfo3L";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K90jfo3L"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=vieEyD1g/a9pnZEXg4twjzAweRGCxAR/nAb1objUXDlKMWU1sO27Eg4lUsi1k99FKrn5EIh3K2CPRXUNiPZ8bIxqWyrLXq0wqs0n+6u7Na1t9nwVYuVrdn0nMjr3l4/L0Wye5kkF5SFDDPP/ARR3tTzSDUr2ZzXDhaElPSD0iGgxmKoxDpPK9jkyuiFVcH8g8ONy4ut1PB7kyl7TIKQdz+RwY3P/bwLdfwBqfLO9JmnsZxoPI9DsBS/v2QWPeEHNzNT7z14KdNQlJuKQcX6+PuMfwrotU6X+BPAMqcG33N/yFLd2Uyavdd3LgmvHaMy35PoxkqfxviOS6C+B2Q+ZQg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYYxeYE1wE5QB+8BybFNlQK9AQl0sqfZb2fPpXzTL3U=;
 b=l40PBz53xUuQ726DW4FnkPWdaeQBN05oXvI3PciW73liCzC4oRpJyA5xA0g0DkljoglgOuIb8LwC4cgxgDUU07TUzCyC1Oj3bVG+WC8evUnRom0Q7wlXhLrWOCOHMTRHhgUEQ0n1cIQy159MNJFfrrthQJmirs4n0xL8eldm/HQ5sOqKxqAupqMxQhrfRug7Q8DpIVq6HcXDcod0VZ7SZ1n2yA3QJLppCi3Iw5Jys60dks09RXlMdEV3nltIShzQ7Q4LQf1mN0YEXTij2+Po7a68O3PObBQn5m3ZxCumruzMVVSia0rWuZBGd3DXGgEBiIf5DSjyy626AGMq19SdUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=fail (48)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYYxeYE1wE5QB+8BybFNlQK9AQl0sqfZb2fPpXzTL3U=;
 b=K90jfo3L8dZTUweV4LELxbPpKshqaXRZSjg5hdls0tp8dJsrB4UhVJJUyw0nex0FBDn/DFLrQiQxQiLM+pS0E945zqgmIlyR+Yi9jUY4zFVki3qtEKZhL+qVyLQMBadnbbRD1zJaRiP4GSfoRlF7pwy02Ta4BYyXTy3nQn6yN9E=
Received: from AM0PR02CA0115.eurprd02.prod.outlook.com (2603:10a6:20b:28c::12)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:59:36 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::6e) by AM0PR02CA0115.outlook.office365.com
 (2603:10a6:20b:28c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Thu, 21 May 2026 11:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=femEa2BU9bKxQVAHPsvGxp6mQlQjuG1WltR9MpAjJJ1yze+NwEE3K7nKbrmQvHPUfOYwpFQz2e1M26HSoGh7Q19PqvaXLBfBv8oIKZxR40/Z0jsTz06pVb/Tw921hQRte/jNS3uA9E5AtoQXIHP3x5lOcFD0JGJuTb/xZG/ag+vxpDjYNYhisw3+R+VLqrFVSfPJC9kX0RKjlyzKsVgRWhLC/kLxwis8PYrAM7jlkSZjvUu/f+wYKpadvEh2lHVo2z2Uic8kHVJagdyklDG70d2VQHuSdauogzFOrUrSF29qrVgShxllhKEOsDXUnjWQz35PKrHDmMc+hDdSIHf87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYYxeYE1wE5QB+8BybFNlQK9AQl0sqfZb2fPpXzTL3U=;
 b=B1pF6jqRmK8kdL0S2otPkLUiAGi72SHHlcpY79svl2efyPtcPGsueVNbKBuxXSL0R+/cNgyTn7hq4be2ZAnRWU7f+BBupqXAmBDIKzqMamRuoqzhMpQNSw8A4UpehLb/0fdBPCQGvnBUztMRLj2OK6at136Oaos3i91xN2sjBYN2qn428mVPe2WOhQUB9A+PXw11rF4WfmAP1bf5ChUxJ2uGrXft4xIFrzDLq4hj7p+rrIS7P6rtlX9qleWQIQYj2IN38wlXNwCWNNS0rigKuLJ5GF6YKo1kw8I6B9C/O9+H2mzf2MX9JPF9XmZRSu5zktJWN8AlnefKCJCz7gWtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYYxeYE1wE5QB+8BybFNlQK9AQl0sqfZb2fPpXzTL3U=;
 b=K90jfo3L8dZTUweV4LELxbPpKshqaXRZSjg5hdls0tp8dJsrB4UhVJJUyw0nex0FBDn/DFLrQiQxQiLM+pS0E945zqgmIlyR+Yi9jUY4zFVki3qtEKZhL+qVyLQMBadnbbRD1zJaRiP4GSfoRlF7pwy02Ta4BYyXTy3nQn6yN9E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GVXPR08MB10500.eurprd08.prod.outlook.com (2603:10a6:150:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 11:58:30 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:58:30 +0000
Message-ID: <9a8065c7-249d-4a48-96a3-460048f1f94b@arm.com>
Date: Thu, 21 May 2026 13:58:28 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
To: Jie Zhan <zhanjie9@hisilicon.com>, linux-kernel@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
 <112c6947-d496-46a9-8561-bbc23793e615@hisilicon.com>
Content-Language: en-US
In-Reply-To: <112c6947-d496-46a9-8561-bbc23793e615@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GVXPR08MB10500:EE_|AM4PEPF00027A61:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 630edcc9-a8b2-4789-ff5e-08deb7306dcd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 llYQx2+HNAVqS6tygKjtDoMVMbXrjGJ5d1MIgkenjnZ9C9+s2LsGFGjCffowQe1guzqbj3RONDXDc0hIz9E9+RFoUexXazqKvX/GNdNtIf9HfpU52vSY3EGUXkIkzeBCT7p3s0mLR7JMPz5MI1MjaTJl2oVXfsY1S5TJ+EwrQq8A5Hzf4rHAF7ORgJ6hdzdq/TMr8Ym8jM02iJMFlGOB79B/u3HPPXcN03aY5ct/B9XKxMsqfDvQSzyyMUSEnmgIPR2qg7F+svSEal5R9pj4VHpKQQTffdpSXWq9hTKbqPoILI6kOM2GrWPek3KN47nonE912aae5dBNNcEeytrfnQ4/0KkIEZEjpavJqpLDeKCfzYSXQanrRhQ/fvFKSsr6AIEAr2FITMmgVbPp7fDN1oP93PfufjR9pfpoSM51oZ0hVYUNjxU+hdpHVDjaKZczDJ3N+ObHinEr4VsFPGH0sxnFaoZ6NuT3JfdDQNuDWrlQDNteEJ6S4lyzGdonvHwsn2Ov1avPrUyOmnL3pTFqPZdFwxxShMXz2v2Ldmqp3bdLXSUelil0u91trCiNjTEPlJDE6oQlt7s28a0HW3FdUsjGqdXk2F1358YUQf+07CvEk82rK8BouqZDgQtfe+jdEXa0GWj9Y9T9MXQWs1RpnQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 HGJDmm2ntuTptQep459nktCZ7WWMRiittdj42s1jvxa6XInw8CRqfXdDZrC0j4CX+015CxBMRa6azrKlniHZQFU7BqoVSrOPUMjRAOEl7IR291WZF9pn9dp69FZ1SVu+ReUF61GgVA+F7QMwqfeYb+ZSdIhOtNRvr0ejZHsHvnto/HaKV26cbsFB+3suaQFrVf2+e8c5QoomA2SR9ynzm6gY27dhykAB8OwrtU04TnHwfggAM+CcPJyDFDFMf/UcnoxuLR4pvmVbek3vZCnpadxEgKIbJGmFLA98gXm4yMyEVReUpkRLCfJR2tD/USNUDn4ieSR1TJozd+RGASqFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10500
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e0dc5526-623e-4886-a9cd-08deb7304693
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|35042699022|14060799003|1800799024|13003099007|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	YUZhJIA7KSJ1iU9dQucx0cmT1ZmA8Drh8Q+iYzLnh30w7vJLw2+JZm4gixYVIhcEDelALeDnGKcVNSdnYOV6S73/IPQKINQWJjfp4IRQuXLSduOPY7w3WDtxZ5wkyVhK2fOs312q1I1BKV+YuTT7IRJ3ZxOoQI+MScMd4tOjxQ5u4QP55kxd2TDKTD+0jmUXIzCR9wei2ELrzZYIN0Vmw6g1EqAY7RYeyc61cT7UeBPA1rI8GJu4KwdE3Y6AfNIDn5R38J+WsAxCf9VJtCXQGIgAcB3Cdrh/REcFk5Wej5+dKHfXAL1MS3cTwyqD/IBxcelkafRSkrtzmkmJT+U0/vDbne4mVaO0fxqdoqymc392vrGbuDvV3amcTVXL76M57hPUTNdeS41VJONOwuAawt8ap0GvEHXM6u81F2W0irnNZ3mAOQmKO2z6i3hLQYgcJseajjNTao1D4/Wjmew0Qoe+Wv46tMe8AaoudHDIfh7HHTKttXK43bJCA7UtYD4S9OqMpdG/PNNolpdBmDa3N/9cRUcjpcuLnHN/6B9QG9xXCvGUTS85QymI8QPL0BhYnrmOiMOS/nsTzsxxYy33bElU5Edr0Io05aH2v26MDtiGZpEwANpHitZ34EqwcgUdC5FGq2zhPM41uwUUHk1AT69yy4YmTSVrt751P9+WIDeauDRkII7EHUjsikpGAFND
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(35042699022)(14060799003)(1800799024)(13003099007)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hhvTBpe3XOuVv/bUTXlPRB27JANchwRGVNBPnkbC0awVukJrRkXIfoHufGA5wXN5Q5LsWUXHxpZDCS1yZlaZYOMPUvtH/ddloS8kBV5V3X8DZfE1d1RXGyf8jbWplF+opgKwX4EDRlhIH48DwUt5PyYrbdLIEzpgBYAFh4eO3dA6hldCvi71n4M+7ZUvPflfxiS7potb78c9tW+HTiWKSLHLZhRhAJuNnefDdMW6mQ/nPDH+iU02E3bwbL/R8/189WTg+Mox9Gyz6qjJNxgISUAC7TBZCaQx7UQdPrM3mZBQLkpXBzI8cR/uOUKKVixfvwB6wmtCxdvR8wq9X2CMXd5vEyzh+9//+dLSmlv3yJoRAW5+ZfEX+ElPaYrDoDr9iGq3TH6h5ENdMNJxjNIuA32oEDKniOPkBoMbfAp6sE7tUSskE0+a4xdv4JK0aOpI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:59:36.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630edcc9-a8b2-4789-ff5e-08deb7306dcd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524

Hello Jie,

On 5/20/26 10:38, Jie Zhan wrote:
> On 5/11/2026 9:55 PM, Pierre Gondois wrote:
>> Consider policy->min/max being set in the driver .init()
>> callback as a QoS request. Impacted driver are:
>> - gx-suspmod.c (min)
>> - cppc-cpufreq.c (min)
>> - longrun.c (min/max)
>>
>> Update the documentation accordingly.
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   Documentation/cpu-freq/cpu-drivers.rst | 10 ++++++++--
>>   drivers/cpufreq/cpufreq.c              | 12 ++++++++++--
>>   2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
>> index c5635ac3de547..ab4f3c0f3a89b 100644
>> --- a/Documentation/cpu-freq/cpu-drivers.rst
>> +++ b/Documentation/cpu-freq/cpu-drivers.rst
>> @@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
>>   |policy->cur			    | The current operating frequency of   |
>>   |				    | this CPU (if appropriate)		   |
>>   +-----------------------------------+--------------------------------------+
>> -|policy->min,			    |					   |
>> -|policy->max,			    |					   |
>> +|policy->min			    | If set by the driver in ->init(),    |
>> +|				    | used as initial minimum frequency	   |
>> +|				    | QoS request.			   |
>> ++-----------------------------------+--------------------------------------+
>> +|policy->max			    | If set by the driver in ->init(),    |
>> +|				    | used as initial maximum frequency	   |
>> +|				    | QoS request.			   |
>> ++-----------------------------------+--------------------------------------+
> Hi Pierre,
>
> Trivial bit: add the general meaning alongside its driver usage at the init
> stage, and mention it defaults to cpuinfo_min/max_freq if not set?
>
> I mean something like:
> The minimum/maximum scaling frequency.  If set by the driver in ->init(),
> used as initial minimum/maximum frequency QoS request; otherwise, follow
> policy->cpuinfo.min/max_freq.

Just one NIT, policy->min/max should follow the min/max allowed freq.

the cpufreq driver can set. E.g. a thermal constraint can impact it (cf. 
dtpm_cpu.c).

Would this fit ?

The minimum/maximum scaling frequency.  If set by the driver in ->init(),
used as initial minimum/maximum frequency QoS request; otherwise, follow
the min/max allowed freq. the cpufreq driver can set.


> Thanks,
> Jie
>>   |policy->policy and, if necessary,  |					   |
>>   |policy->governor		    | must contain the "default policy" for|
>>   |				    | this CPU. A few moments later,       |
> [ ... ]
