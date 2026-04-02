Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABE3D6491;
	Thu,  2 Apr 2026 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128909; cv=fail; b=YcJ13n/OjcQ1YFc2Tk5FAsKkfAL/YNIimLR0bTyKK6G1kjJp8ODP9kzil47y2jS5pfrkgcnJ94+rNyXi0rtwau9ylJigBPWm31/PO30OZz162H79RcLwDm7go6EvYBiqG+UqfoQeDjKJoWYGE/54LvD50kGHPkjki3AyMYYRW54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128909; c=relaxed/simple;
	bh=6UEyQ5gtUyFfDEnrvcEGxJYN1DPg0aoRJbM6txU8zbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oZO2nIt2aXnOncbYmaJECtrQ6R5ah7Z2mo5Pz+6Kbymv2v9EGAlg5s4BXsv5yLgB5BuMLO7h/Y4IrbBAl2H3yz9J9bMWubPTmQNHX/TAZJAB4ZY83xOiBkxSWjWDDslOs441uAC4dMWsUYMkbMj2GKz4ChVSHL6Bi9nwZMOA3FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CDXpm9wH; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CDXpm9wH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx5BKNiAvtE5OMasQuwYjQWcyyvXq+Kl5kCVHRCD56Uv/H4I0OIaLGp9+dDMr9Uz6VTB/z8g98+V8TcuATeibUeNBfAJlpqPJR8lFeGJKqONXICzxzVz4JQtLLaagh2zpo3rcB9fd2KMQpz60p8xcScJRdR+CIXk1r4lgzWEkcg6Pl4ZzR5pmQ02HXcV87HTixrUz1pwYBBgf9KLbuMYOXaBgUDuDEhsJd4Uryuj/N4b+VRTZipHQ4c/8aJGgL71+3PKJceGvI0qTorek7zLuil5QTmIcIaGJ17sbQTlLVYvRp6TJ1g8maOUvrMzeE4K2RF9dOxgTJ4F03otPoMR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJl2qDCcNWW2RI7ax2nfpFAcb9Dp5/R942nPV/EyB7I=;
 b=BTs9ECJs4pV4l3Zxdej9bN2lWV95tdk5M7F6G6cr9+rO1Vaxh7PZRt8+RBUEt0r5NxsF+HKzhnq+GRclIdpo41d3VcY475ma1OiV1CEwUuyFnmLCJ+fxqX9fp0TnIO0dKGdOCfNOK4IZ0UIzdvcX44KiWs1iCURdGuYdPa08G2v2hIafixbW/n78TFpW5eII7aJroBu6QKbqPKXv8E1J99zyLREokw2s4JLxcbQw89h6g6sSB/nKYFgqbk9APT31oJOO5WvtmC8sVVBXXblQNhXvvqcmGT45vSvqGUE0Ire8c4ALZiVQeCiMIkaEDHWAn8NSNeBrTM8Sl0RlQJPQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJl2qDCcNWW2RI7ax2nfpFAcb9Dp5/R942nPV/EyB7I=;
 b=CDXpm9wHRr/noctQAunY+8MC/VEjH+hKnxDFiACrQpnuYh0ePfFedl5d9Up/q+Y2zzXOkXaXhlQe7TVQRIzk/wFbazMoZeHcjTYgQPi6bMPXygBzs7zJsLnyDd2wuzUnjXn3KRjHwmEmFD7e/wvWrewnAOQePrz5NzzQE+sTZHY=
Received: from DS7PR05CA0106.namprd05.prod.outlook.com (2603:10b6:8:56::24) by
 SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 11:21:33 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::a2) by DS7PR05CA0106.outlook.office365.com
 (2603:10b6:8:56::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 11:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:21:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:21:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 04:21:32 -0700
Received: from [10.136.42.52] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 06:21:29 -0500
Message-ID: <31d6da20-c0d8-4ccf-90e0-7484e6f07264@amd.com>
Date: Thu, 2 Apr 2026 16:51:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: amd-pstate: Step down as maintainer, add
 Prateek as reviewer
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gautham.shenoy@gmail.com>
References: <20260402102611.16519-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260402102611.16519-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e63734d-3996-4943-35fa-08de90a9fec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AQ1OlZaPB2yiFlzJLVKQeYtQ1y+kGyo12hQDzb1ADsyOpbixFOSYWa3VMab5xEa2NmEqFPB+E2ArdhTKtyWYmPkHFW6bpgzN3wAaYtqu6RkhHtexuWNArozU0D++G8voZtuNrDG0M/9UPe6IZhtRuF98p6mRPybwyUBMxOQ2QVVzoJ6m/7AxYgC+DR2dLzU1rsPQcUJqdXpHm3icc+yHHVajDoqeQPaxTIaSIVUe2v+97B/YOtnrD4863zbkwUU3eSiu3z7bdcrFlDlfhl/NQYkQ/P6PBhHAG9A42ioUJKQWuWWF4drBDhO9FLxnw/Wvv91SxPDleUWWLpEe+iyT9RlAgQIJk7xMdSpRmDC9CfdfTG3b8Fj7Lde/0VHHyQW1IYX0AZG0G8mMcliMLSAiEzcp8xhnkNZdwJiwPmjeloAo3s1u6Ycl+xwcW9HFViXMg3tke3Phim8aRDx7sBksYSrngjh2di58QM/lpqc9c/1C1jk25zGOUoLj/6mOjAuuYRuob2KXcz7UvMjc0eJ4nWp3ihHDuXbWyBXodgufEHiNgbjF0MsI/m6TNma3AW8JQgn+Dc3oZd7Co+dLDcIUCj1F+RN2GHqiEQOKVueLK/2t2TZw5p1hy+WKUEkUeZx07DPmquCFo7+35SHliCItj2GI8uX4WAWB2fm6HjvCN8X8Dq7Se0AjjgIUJnXxki/7mbOgm5gWo96ljZH37iWa+JB4M3wLGO7T4HVvpicZU2fQi4ffIZjXhwk1SdfD4D5aSy5KBSE0GNc7V2S5tlJ/jQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HFEwDIDGm4F+UatkwR2oLIxQN2GDMScnv55KMlbz0FfGLEFwuPNFThMoG91tRGqTPd+VEMuOVjfhv/CXcjGprpCSkPTglXVKaM3DoOkROrsBM5jWMnLYlJ6oYj1BeH2lYkyE674MqPOyqUQ0POcIcTa3JqZtqAaaQbtfvwRHns9X3wxbjBh7ygCm5RFtd62kwS+n5IHtAMWvnvChgDVupyON9Q1T14svVAHCn8LZw3jfRZgIe+BGhBdS0dQ/DwwV+BOmVeylsLDPA7nxlsK5MB+XMjaBxBMx67cbA+xYqQmHeZut+qcleK5+4kJLdxK2geOJiPiqRDX6smnYL3ImpzHWGZClT4J7cZmbTPCd5XpSulxatawN2gK5Xpbitq+6AvnXdgI3sdcO//EN6yC2+RfrygLukBheDqcFkO1jE62aSU3dtDPFJoz7PA4iCgU1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:21:33.0470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e63734d-3996-4943-35fa-08de90a9fec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

Hello Gautham,

On 4/2/2026 3:56 PM, Gautham R. Shenoy wrote:
> Mario Limonciello has led amd-pstate maintenance in recent years and
> has done excellent work. The amd-pstate driver is in good hands with
> him. I am stepping down as co-maintainer as I move on to other things.

Thank you for helping build the strong foundations that amd-pstate rests
on. What was once a house of cards is now a fortress thanks to all your
hard work!

_I'm not crying. Just sweating from my eyes_

> 
> Add K Prateek Nayak as a reviewer. He has been actively contributing
> to the driver including preferred-core and ITMT improvements, and has
> been helping review amd-pstate patches for a while now.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Acked-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

