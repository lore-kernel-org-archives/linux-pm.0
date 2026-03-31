Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C53BA24B;
	Tue, 31 Mar 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940692; cv=fail; b=fubVYFHFir8Scx6gHbluCR0SiePi/iGKyJtDRWklJFcSSRQ6uCZlnJFFxRv/4t0hrmf85gp2xCPxX+3QWfsPR9RAFNzHjcG/P+uiqpW+9c3/jWBp3chWZ/5p74p6gaA9PtO11XQ6DhwaKZch694ZKbyEFcndyY0lmzvXBBCAvNA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940692; c=relaxed/simple;
	bh=V/bQQxSv/r6VYY4JRlMj+9/KB7BIML+uKPYOBPknqIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=riI5O/a6zN/jkQrkW/l8Gb30Lu+6TMCOICFzeXZK44SxTgxjDeXto+fZzLrSRy7/D0dZy4cvmiytghOGa3NVR261TLF5ZM5BjwsJG88Uiv5XjcAcNVPw4tTtb6MPob7P7HYxtV8pQDUmteG5qS50UqIpk/yjAHMlkpEQNOh5LO8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bJr8nuZA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bJr8nuZA; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bJr8nuZA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bJr8nuZA"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BIgsYngRO/H0Y/6MZnPT9WCrtugjw5xe8olLjh6v8WJ/vfDgEDQiOSKsBaw2/wEYtsxFVqdB8vU1Wa+nlyrZ2bhNdFAGMFlwkgnwhdDuJigrkn765gbx/LOvYasDbIuyEx/SF+B1gRYvwUnAsqZt3ILaQYY8MFTHmg8PU1Gs1FypbbRkxrGYyrQlZILd1vcEWP6bo2oziWt0Ge+Q6UIZhHHic3dbIC44Ejn+OBPv86JzBW8SE/uXnLbShdG69PeIiN1CbT/8VW8Otmord8vHdsvoSiyAJ4wIkkFGJfECwquNpJ/ir5/Y64jLTDhBsbeR+wK80SlOY3ZqWGj8BywDtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/bQQxSv/r6VYY4JRlMj+9/KB7BIML+uKPYOBPknqIA=;
 b=jLPq2z+yUxc7wayIsFJdJSAm0uF3G2LL7nv5OgFQjPYLHIy4mghJh04A0rZh6d0gKtZ6IdUuwjyd8crOO4jPDAubiBnpi6zfll9Mzeu1T8GfCiJWbE6VJ5+7cv2zHbkUAnBEzZLbRA6gb8Xd1buciZ3XSftt5NlQSC+y2v3hixsUFU/R5EmbREkWB+9sy7eWykaJe1E2JL9kg0Vn7BZG98Fk5c+7a1Ur3/mVC1AEZBs9rJHGIw2PzCdyUSrEq0U/qYMzS0MBPckjGEKLRgPqXODj7cgunqXeUawlFINepfjqcYrMlfrELq6AJTPZAqv7rhWEPmKmgxdIoDESrya/fA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/bQQxSv/r6VYY4JRlMj+9/KB7BIML+uKPYOBPknqIA=;
 b=bJr8nuZA0dqiKwLrJBMN695XEdvJf0uAdPo2uONlfxGVCQ9AOYYCDPvN6RzF8fvn3vzCSygGn8XeMgRwKLpzxTPqNhNg0aroF5yNpePZdPYubtnHW6NrELmPijBDQ4mK380yA2u7Dve91XCadlXXQV83+hwb4J7MZowY+4Vg+C4=
Received: from DU2PR04CA0231.eurprd04.prod.outlook.com (2603:10a6:10:2b1::26)
 by AS2PR08MB9101.eurprd08.prod.outlook.com (2603:10a6:20b:5fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 07:04:46 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::eb) by DU2PR04CA0231.outlook.office365.com
 (2603:10a6:10:2b1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 07:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via
 Frontend Transport; Tue, 31 Mar 2026 07:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVPqOHB62Y2W8opO/IMFRm3xAWfqD3dHMMpe/7JHZC+bXVdSBVuEKA180G0Ebzcv2eoKAcl+6Cl9KhK9DG7yL/xbMFK7890Xk809PcQujZiMQobiJcEOu2kt4wap4lm/EL2tNxUcUqgnSlfQIZ5iMz3mlMZkSa2QpZ5lZccAeOPwZHTK58xfPhcswpDWm5SO0DpT/KPyRSijuJ2I6akzFNQeuKglraLh9y6gzPwM/MsupC7gtZvJ0DvBS7XtZQV+mJ54KqPtAHJlPLhy2xOb7fjw2AAKPy3kKVRBwkp5OdBDt/KTyjZokRIKO9UuCr3cKVnZwDTC3NQU29duW3QVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/bQQxSv/r6VYY4JRlMj+9/KB7BIML+uKPYOBPknqIA=;
 b=qUHhvQ/9+nQWqeEQKk0kYpph+dhouxxO6OmZyjIYCWzMCPr3ANJRjB1ImbQlWGoi7ZJnxg+G85SnVVef84pz0gu7DG72qmM8aRAupz2562JqXdVDkX9W64CW21khTmOz8I2pRo3dMueCeDQzVz1fmUg3409csGbJlRz90dx8wE+UgGw8G2CynzFoAmUt6fJL71mNQ0JmolFdxf1Kti1YuB1+QVZGtpkhxuqtrZbuFr1x9Z8FSOB++sjIJCNmPV6cXqfvopWHuEDsBy/2X0sR++neScHTfL75Xr2agbMQVIuuvKVOXKAGK9gcEfu0wF76P4fGv08lMiYMQbqDC8/hFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/bQQxSv/r6VYY4JRlMj+9/KB7BIML+uKPYOBPknqIA=;
 b=bJr8nuZA0dqiKwLrJBMN695XEdvJf0uAdPo2uONlfxGVCQ9AOYYCDPvN6RzF8fvn3vzCSygGn8XeMgRwKLpzxTPqNhNg0aroF5yNpePZdPYubtnHW6NrELmPijBDQ4mK380yA2u7Dve91XCadlXXQV83+hwb4J7MZowY+4Vg+C4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GV1PR08MB8057.eurprd08.prod.outlook.com (2603:10a6:150:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 07:03:38 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 07:03:37 +0000
Message-ID: <05799650-81cc-4761-9eed-dab4b9945186@arm.com>
Date: Tue, 31 Mar 2026 09:03:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Allocate QoS freq_req objects with policy
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
References: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
 <fbe74184-98dd-42f8-a851-8a8b5d001f1e@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <fbe74184-98dd-42f8-a851-8a8b5d001f1e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::11) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GV1PR08MB8057:EE_|DU2PEPF0001E9C6:EE_|AS2PR08MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7ddb5e-5818-4d4d-a3e4-08de8ef3ca0b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 8xTJy7UVsHBsRQ072smqrXAgvlccteFr+P1HhA8f5oiNr/zxnuPAxiIxg4+AlUsOPLozlf56sg27hxAdS6LNhIgbkjuZDYfAb9Le9PF1HgE+diIDE8Xa6Wx0isKFmfP9r5JbkoXYUWW7r8aUILW3O4LmXxKe+Wu3F07Z7BRwNkLm0qdN+pV/oTuGUNLIthxuS0Q87NiFIsWV1TT86gOJBv/HyVYIT8o8VXEA3hV8r2kszeVws7K/IB2eOoBV1yZo6dqMm7IV8lastAsaTCmSwmhODhbN76J9u9vdSX4xWygHxQ2ryDq5X8A0/danlwvQkhKPzN/YUR7g9e3k6OkXYgdigApho6Qm+GEE0XQHrH77G58UVdO90aocgWPXce4Te2SJShItpOP7ACSZvKBKH3DXRRwwBrw0iNvh7wNplauV0XRwKqtV4ZxhSpnLUlOqdcwJiVl36JnaofLy8mbsQVzKZqjVb/eJod6wJmwwr15+gZGvgPHg2SJCbqiG03wedwW15NknrC/SJjomNSWbx/B0pErPM5g3EasrlBUjNDlAwkMJjTTLJ+WGGABUiImJI4KKrqOKhqCOiqmFiqrSCEySPZ9eMcTzpXKEn7jsnOIX6MrCjijm+HJWyDq3olTOjlgrf3x4LMO3BDKYw8VKRdzGyAEn/yVEwTsX+jG9xhNj82Sqj+omAiAp6rz0s1iUZIgLzMTsw+ix9oSsUv8Ymvv5yniYqHYOMFm8x6KgQtg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 LZgcYAvJo0+s6U/NbuXONJILmLz9mrTeuCojuZ5pjsoqxmNUdM+40mYWmOxVP/VsbS/thzKa2JU1hozT8rzqHEO8HqbW3bq+vT0VKu6DvjrpjPl2t2isOMhlxAfhZuN1hRQgkRCBEp2RMBD0EV4cH8kX3yL9dZPv54FLB9SYUt6O6gDx0dvPDKmGWc9nmVlUWn8+ttEtYPfubv7HPa1a6T7Fc1Mob8BYN9eixF4/3qbOYpKJ6wm4aWjsQUT5CC/qfHMokbY3C4CNuBNm/TRDAw4Ov4bRObcBxJtyz+n70HHN5LXiXd/UUXOaruMGTHQQDbL+24XaH0CAYlhvBVtSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8057
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1f77c07-3fab-44a2-47eb-08de8ef3a187
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|14060799003|35042699022|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cvqEwNZsVOCFw20ZxvLjzBNfUM1N5+w8vDwFiyVsPai5n6P0375GXaNdAuRme0EGsm1Kw5lWA7cZTxRFNp6m3W9hRDcMw9gAOgStTm/V/uYfoVxBKYPrnB5rcyl0qpepPtvll1AT/fwhQT24W4XgdzeqSatpwKlkEccwMNGn0vsc30tC6NNTKywnYCx1KiOMqnGZU2wuUEt5NR7uu4JHAqIEQO47ASWsnO2jJ/kGLXlsQJx7Hgw9S5gydDNYPdhdtQKfC+16yQS2kUiHVr9Nj8b12/BferG2N8HbVAGwXwY0W5MVPUkoplO9FsNQ+MC63Je+NwV3HCHF2sU57mxDBQsBH6ZLIFB22JN1cR7HBD9P5INDklcXyV5NuQd9YURiVT0CIy7CpF8QLLFHEhDAlNaor2Xj661cFj0OK6hYyqEkmtBU1hv5FYjtrgqrtC8eOB/ChXGab4N/mXU50lB4m1XPr7ZmVqlN9pTG1Bqx50Ikhxn/5RsntI3Fsdzo6a+jMRth8A4EpG8iBXSk30kYJxBIILA8h7f+0uurXp+hzERwTZz/NDLyxKGTn8tvu6qkg6o6KN0Z8S8gSYjg1jjOpWVnAeoVjNaWHPjoFzFhfVpq0tTBAXt7uIgU7IX0STDJIaH2M+JJEPxWBRvvccHZ2UJ0meNhZPbeATIqVgi7lA0G0RxyM0XXPQTNbAlF+xVhiWib8a93uIC/fII1fpMf8iufDhIncJuujPi1uWBQCWub1OJ/VaU5GdgooG0jnAVC/4A0E4FPlU0/mvK/SkqQVQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(14060799003)(35042699022)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KiyMvqIyjK8p5mFMA6AvJczebmlmF3i4mCyWjBZ045VIOuogLmUADT7PQBbMnasbgjDA4WgQgUFCtHBdRNQCcL01CWuRAQGQ5SDh7GSxWzHZc54vMD+0SFOsvAIucQgHj5+xbIGTAo1k2qvHyHpiHUtuDll2hD3kvFzxq3rZv1+v3J3DHWoixBW2+746HABU4B3NJghjjWMkM3MfPNg8KHoTvjrZgBjKpGlPN97WDpcHyptgAoGJIONWGOHsq2Jn+I3b0MBNeX5WZzqR33asOC6qQLndzY7bcW8SH+bQ+90ZAGjYb2d7i57dTqd9wnJuyJRNsv/19h88K+6iBnjfwfVFuGnfj2tkygSdiDzWLtU3tkgNu7OojQr5u8XYKTLrsj95hoUltScQZxfl6SjjkeCYIkuiDsv9tZIL7Ee1y8unxarVeYlBUBnnvwZXx5QH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 07:04:45.0132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7ddb5e-5818-4d4d-a3e4-08de8ef3ca0b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9101


On 3/31/26 08:44, zhenglifeng (A) wrote:
> On 3/31/2026 1:03 PM, Viresh Kumar wrote:
>> A recent change exposed a bug in the error path: if
>> freq_qos_add_request(boost_freq_req) fails, min_freq_req may remain a
>> valid pointer even though it was never successfully added. During policy
>> teardown, this leads to an unconditional call to
>> freq_qos_remove_request(), triggering a WARN.
>>
>> The current design allocates all three freq_req objects together, making
>> the lifetime rules unclear and error handling fragile.
>>
>> Simplify this by allocating the QoS freq_req objects at policy
>> allocation time. The policy itself is dynamically allocated, and two of
>> the three requests are always needed anyway. This ensures consistent
>> lifetime management and eliminates the inconsistent state in failure
>> paths.
>>
>> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>> Fixes: 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request")
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> This looks much neater. Thanks!
>
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Thanks for fixing the patch, removing the allocation makes

things much cleaner.

Tested-by: Pierre Gondois <pierre.gondois@arm.com>

