Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA637BE9E;
	Mon,  8 Jun 2026 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898059; cv=fail; b=IbRd5gjY3DPpYFGhoQLI/38rz0fHOhBmV+XRgiNkZkbQkokHEJcIkf2liTMp7m2bEMygjpuBKZ6C19u6GjNQ5vCwyxJof/TRSLjv62W5joezIxI+c0VUu2KlD7GNee2C+L33M3KEhYXWdS7o+KQOG2RdmdcRGXfzl9QgoEwEN9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898059; c=relaxed/simple;
	bh=wl65qjFKZwOAXiSwZT98dTWzc18P00Jc6q09aJDJoS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dSgr+yMyovzhT3xDVSLqPbzFAQgiKZZ7GCEK0i7smPde1fcv5tl1Ert2UK8MkPhU6s1KRDxPykINi7GizEzzzynpYoZKEKUDr7CQVucPgaL3TVRigB6K+9gZTJK6IUCbKPC1d7hZFUTzW53lTnm1vbfs/WWGPZ57qR/uP2vjZys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VL/e79+m; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VL/e79+m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2m2iA255vmIeDwIx9rsXzgy252y9DsMDwQPfgdErvZLoHP4mN6CjSiqPt0ZxWPAHLk/b5yvccypUKlC0oLU4zWhtVvMxBiYKHg1BnWKRi/BYWM7t5wn7k3E2ayWMSORIAXE+8f1K3ivreykGnqz7cyhf66vRJHBY+ZWKOQ5rM2ycMYKt6ARjfjm4ggYecN6f309ihde8CbU2QTuUm+qI3caRkthDHllilwVjLXWjiWrdJhO+s4TpR2icVcrobEWYlefL1NHUZ+UZkKDUWWRx13AqZreCYEMetTcCbzcZabqcUK5QhoSNsCzlItpOvgyZWe2KVJZN14F9remwgyoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wasv2EG/LDD5aMmuRExYHJ434T+IEV0jolXDt28rtMM=;
 b=IFtD3fkvRmJvLdY+AbqZrnmpt1/PFEprs2FQtqCQph1hTBpr1FSdsDoZ7wsuvmLXUOlKddPLDAXPIdVptjh5bQVopw/Jcajv5XsKO4lXO/uBHqE+zQSAZYtoYaVnqnSvKauX7gFTwC7N0IZ3DS0IAOnoF4cHuoEzcW4x23NTqp9GxxQuJkCwXzFGI+5gybItMzFj9l8NGRZ9tUTmvUixh8JFQZ4NVeRT1zVe0GQP26X2auFZ3Ja/iQAt4yFvoCkgC+9Pz/78GyFU1ZBqZrAD9jZnlXkNOr4CZXhOxJyCVNzmTgVkxEC9DBFibX4SCA/XUQDoxTAT2jez+vDTbmIvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wasv2EG/LDD5aMmuRExYHJ434T+IEV0jolXDt28rtMM=;
 b=VL/e79+md7S0+MTPCXEvW10+7d6mimmHSmLugvURSmIrZfM7PRtyHlqHY4YDrCS2Qq+o8V8cCu/uOyRFDTXgvEJxGFgYAxikl0g4/nbFQkJcGfAxjL/cdbiUQ7GMzLyv3I+uvle5ye1d0A+fznjl8pzZFi1ESkN91QZYb8mPTaA=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 05:54:13 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::6e) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Mon, 8
 Jun 2026 05:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Mon, 8 Jun 2026 05:54:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 00:54:12 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 00:54:09 -0500
Message-ID: <b9e13709-1914-42ec-81f3-f90d45e6e1c2@amd.com>
Date: Mon, 8 Jun 2026 11:24:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] x86/msr: Switch rdmsrl_on_cpu() users to
 rdmsrq_on_cpu()
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>
References: <20260608051741.3207435-1-jgross@suse.com>
 <20260608051741.3207435-2-jgross@suse.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260608051741.3207435-2-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: d2897de7-f28d-457a-1a2b-08dec5225e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	hrPgTrZ79NH/0jtrAaJlJnTjYDJtDfZ4y3GCKTOUKWaWX7F2yTGxnH0MHn5mtkw/gYDErReTXG9ekSSr09CWRN21swVr4rcplA01A9Jt843W+GPbhQlHp4tz/kiQ/kCJN2ha+ZBdIpciBDxkry947e/nw92rtmJo3y68H8b6dLkRd3Xwr+IPqgaVXkImM/memUg+Nu4Sm+7/2M+41gG8MAlaZFdG9B/lUgh0qQsddKJ0do8ORzlssXvUtC180U9tiOcUWXwAeW8sSyT6prGY1N2NfZvcfu0t0ZeRgA79/QXARZTE3+6Z4AaUXFldC7OSNSXQPFeUiuH6qdo/a7RCtHhnunJVjnp6XBHOEpqYXIuIr4UC20fhIqRknSYenEZkt8/LirbtYnOe8MvtmpHpTbqUs7qyTEMiRxqk2tDKXHIMxYDq8Ivtep4l7Ncm4nKkqm9HDBw1Iq3kIOtbdsoddKdiPZzl8onQnl2AKl/HilQc5MfO6nmcxYf/SkGRbJ/O+rtE+nX32ZbRk+HJlg9qPAS3mSsVNJMDjHJwoyDGxlsy74t6/ITJSl/Sl7qnrid0fY8io+ikg/qSMZL5zNW3jqatRNapixGE8vcDZWrnHZd1AdcjeerCV0QdU1DjCCmuwY4cW+BMzx53Eta97eUpecE5O7pW77O8tnrrGcmq2TLmFkSdSz6/RMLrOzdv6EIxVY4KxNsg4RRNQz+OsZ8nWUO5akmrc1vlU5nNbjFdrYM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cf88bSGmls5aoGPOh4Y/ycBiBMJNDRM4Exxte0B5vmDEANcrZ5//R4nG+9ViR6RzBjTf/2ELSs5UYvUBhuUTXJ0GCzmGkCZyIa7IZXog9kYuHEmPZU7cJdzwDVXq3OxOACp1ua3Is94eTe41TayYqO9YjUEb35BnY7SEClFNco/DWsSK9brdTOFNGDnWmAh5x0NnY4xUvyMBNmm/Po4dHpVY0afIRiNHRKIUfFwWKVsfNIzFIjmvt5pGA2RXkFEwqaBIyUJPxNJB3oahOfIAu4xThxeVeHeQOG2+jK8A/JFqY37lVdi0ktsbADh9pkmvkcEyqYZhikiUutS5bqiEiOYC18Z9se98BOHJAY5ryWJyfXmGkT0FtQqPIbnx7eutLatESMAxpnyqITipu8yQX8Ayj3yJj8a2Grjz/6CTC+NGfpnzSZfKb86cbVnh4VJe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 05:54:13.0761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2897de7-f28d-457a-1a2b-08dec5225e15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

Hello Juergen,

On 6/8/2026 10:47 AM, Juergen Gross wrote:
> rdmsrl_on_cpu() is a deprecated synonym for rdmsrq_on_cpu().
> Switch its only user to rdmsrq_on_cpu().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

