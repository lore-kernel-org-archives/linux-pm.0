Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A1342CBD;
	Thu, 19 Mar 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912703; cv=fail; b=dTI8SWhr2goVxH3UP3XzBZZxFt6mf/+KDnyEufKTmMGsmydCkg2WOsnriGph+jqt9SC4kN2NONdtHt2K9A6MBfx44Xe4KYXP79jtKOYiuiWkQZWVeVWWGrk0FEGd2pf4Wd8g8UeQ+iYOABQKqPmCeFYpODul5ePwlrknAgTVXf4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912703; c=relaxed/simple;
	bh=MVmMgd+9fj7IW0Ne0rHbtgp2HzOmZpaH13n41sBpEhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mAMDuOOf2VGcChnDSklK+Jt4YMPSHxhwxVkJoGkzkccjYMX1wVhmQmt3t9aVJxoKNNQFseVnrr2OdmaxaTnioWTtGP1tV+o8ZGkq6XvbNL4Ba7EsiIbNiADZsX9qJrSp858LGQcRC0mR8hjipeTTAR7B4BL6025QlF3PjBw745A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QoTV6j0G; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QoTV6j0G; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QoTV6j0G";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QoTV6j0G"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lYUzdL/isWT4VvpbyvLQbvY17siKEuYFpGzNnrKfBkStm7+BrPwVY40cQrfTbbmzZXTpaZS4lQCheZ5AVk4TlhHBD3fvkq1OMojC4BKbnWoSmX3slw94cBSHBU4BcuvphZ17gQU3LbX94f9yvt7WbprDg4+XN5Re/h5bESy1Iro9yaqTJ5KAjOWMFUakEZPmG7B2kl+csMuSf6er/h5CD/fupysY+h+PMNInCThDqv2+WpQqCRru9q4HKHmjDgHQL+hJK3D/O4cOMpnICkJpqh6eEKEqOqrDhi/2ROyxsFB/96Z4xPLkZvSR+rECFM5384dNmhlCocFF0CWTQyxuPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVmMgd+9fj7IW0Ne0rHbtgp2HzOmZpaH13n41sBpEhM=;
 b=Jh5S+QqqB++aUbdwoqkki92L+TNkNfCleK8Ul6M6X+W4SAuYy3mHNdmrblZ5bcCxg5O04+AbeyK9ZhOqB1ITK180MAEQjcSCsLhWI2h/G5dEWFfnkvKNTuGx3ILsFwfeCTzQ34/Y5iX2cfKzQLN5HV3OVmDOG2ZjaqJr3th0FwEjtwnLxkLP4V3kvk9fRsQvglNRgjIMC0bjpE9KC50FmXlbWMUYnaE+UxckZZANjqDQvIYXaO7ux91ni2jkmNEgyLqydaoIiDi5LKN1LLRJL/+xyS3USs4AYhBOcmHqQw8dRcMAMKcIp2Br06pIB1qCWaPO0WtG3q5UKamCS6Rb5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVmMgd+9fj7IW0Ne0rHbtgp2HzOmZpaH13n41sBpEhM=;
 b=QoTV6j0GqKq9XCIDm/hBQlEVWyfIiZj28Kc78nWTBDqW0UIRVyrQ+CxOvZxmuiQ3Da/OYEXebTqfpLBrZ58j4ut6f03Jcy/mYmdvgZw43nm71P/XUe9kNt/+9NUN0IOj21B0GrHqfQ+911DkzcHdaRjCF7ErprlWEsdzHNu3CCs=
Received: from AM6P194CA0017.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::30)
 by GVXPR08MB10639.eurprd08.prod.outlook.com (2603:10a6:150:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:31:33 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:209:90:cafe::73) by AM6P194CA0017.outlook.office365.com
 (2603:10a6:209:90::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 09:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Thu, 19 Mar 2026 09:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faRIiBMN8W8CjAj/0BXKz/GMBO6B2YXTnzEr4bvO593Ayxu6a/nb1PWUYV5XVyCjnAKbGqGnxq0uz/dCJegMeKedLvR0H6zEB1nn4cCA4fgwv4ha+hDufMPKuIKLV3qKEGMEhPM4IvKZ4Y/33QkGzaKIOb0t8kvU3LX4OEzKaN9xn5qXxogXUd0MX4xKki2dlk0JHrBpSRwS1dymxuVzxekAjdPzXuK4OLlZhIPTlqEl9wM8K4M/ESt4aPjQ3QJxEsupvZXG1tFIypeRdpy+0rcfbNWfa55yOWdSsXIHpEBnGpGLDM+9pqBZS7p784ypFhOC5QWCD9jio5EJnzi3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVmMgd+9fj7IW0Ne0rHbtgp2HzOmZpaH13n41sBpEhM=;
 b=R1sMugu4qMM5s3QTjXAmaEZ6vlAvghFItl3dpY+yh1ZDA9IcjgxN5m5qmNC/Ihrz6MpG4W/ZL+cdKVsl+YJnLbRFtcPlAFjVwBnffSq86HuiIkB5pBKfoSIAm9riyCTr3zplP67kH2M93QNPP9Aa2AezueDaSl1L14AAPOxiyRRIywmdNFRYirvg5FgTMkkGZZ2WCbrrXFFQDcqRQQoJr5O2jJsmqiWEZCVI/4/9oFBLYZgwMwxELGmNGmG9bV5W7iBErx4IQlnSH7fDGlHRkGL55GlgUY3rA2DTB3bDCho2j8mOTZjPIXHj7WUlqNTdACwHxDQ8bAcq9T5eCSR+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVmMgd+9fj7IW0Ne0rHbtgp2HzOmZpaH13n41sBpEhM=;
 b=QoTV6j0GqKq9XCIDm/hBQlEVWyfIiZj28Kc78nWTBDqW0UIRVyrQ+CxOvZxmuiQ3Da/OYEXebTqfpLBrZ58j4ut6f03Jcy/mYmdvgZw43nm71P/XUe9kNt/+9NUN0IOj21B0GrHqfQ+911DkzcHdaRjCF7ErprlWEsdzHNu3CCs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM9PR08MB6657.eurprd08.prod.outlook.com (2603:10a6:20b:308::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:30:31 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:30:29 +0000
Message-ID: <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
Date: Thu, 19 Mar 2026 10:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
 <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0311.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM9PR08MB6657:EE_|AM3PEPF0000A793:EE_|GVXPR08MB10639:EE_
X-MS-Office365-Filtering-Correlation-Id: e86ce18d-0e22-4d29-3da7-08de859a4f52
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 N5jeNJviia5+3sqeBmE8UjglceSCAwY6RnOkZvl/sSBliVXWg5XWyn5DbqAs56pCrXPH0pDtPLYI6NqU9bCCcWB7Lm2eDMIGp0092W3DGIyTG9gmWnbdNJ4C8xHAmQrwmlSNNn3i74dlyBJ6jzh1aTlEyu/H+HWTYGViU+bCOnZtRAjL89TC2lqGvPTp1rHPlr5Z1af++pSHtHmOmvKz+H7FiEZz2DrwWGhKkIHohcgfxXLWaAaGcYkmZSrN3X8EeHo38x6yOkUT4aMXfBfxhWbBCoFf4vp3sBE0s/0hvAsdGZzQFgrJAX4N330O+sBrT/3nNGHhCe0oEjgzTH/3MxeIU71pf3EaRwSEhWmnwAr4Ks9OnKIZyzcKpHKq8PVnG2XIg7AQa41nwZHuvrGfpd2seBsOLV6tr8awAsDIez67mu4sw7fqvjpDWw/xsxhrn8grj3UfAOvCJsKe4Hjoe1RFP4I2ew9NLw14d791/joLfzVwkp6UDB1kPJ+lXbK9zWTQpbSEcQi43+Y6AY4YAEft6pHuMT3SCH4HwdWGHjxZvHphe+Mwsot7irKaf7toc2Ydt8J4hroOpIkyEMwH2JRPrNLfstKAvHYqnl/hiwPh6/n0n9yM4nxOoy3kW2VJ/uK/9qj0UyM1WuQOB6satkCVr1dClCDjERTkAFExj0fI/vnhKaYrcbNVMscBGnZB+4TATAu6oku/Y9OAJlJyIHJFA13ENw0dgbKEdpXyEsI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 kt8GuBfz3edc+qD6y+j1J8Qe3ZQGUc6gWdICdApijRiA6B9jnqfL1tUt5clL4EqIWlKF2BvYmeMFukjGrEEbKE12AsHeKRBb6ZIk9t+AF0bFgpjw8x3CcQnA+zxmsMVtn1GejIn8EP0qX2i3VgsvgiHMUl7v5q8KFLZ+c3DgTgXcCMLEHy/A6PNK0TahZwYUrj0nv5hgK5uxbXkyAcif4GoFJ6YJov2rJxvMBms2pfKvTjYDO0q0ATw9BUGWvLa563LPCha3A/+9g+Z513+sYRgft0B+Nb8AgKacdsWOsQWOnHIJnPdyu2N016zWirpmSfq/tEO6oXq4//cJWuIJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6657
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b017b82-3c1c-40a3-8637-08de859a28a5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|1800799024|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tmEzP0DMr2E/iS4LcSMCycSQiiThvbzLub2vgflg46szNPNrplnZIhfeGJWRB4ya7fdw3QYNu3d7aV8ikFCDNqbRhpN/4LFWMb7madcRFVhrG7vEhQUuvYCvLgSVMDZHjwf7joahcrPJ29U7is3flUdvGUkl7alR6880y/e2N5x+IM6KGsSi0jtb0uzJEbvsZTaJRwAPh93BpobZ7Dz4Q8H8pQJWUl9Y+EmwkZ00urRFfIb9bQe8r9nFiU/UVvmoSc1WO5QdHufz8eLUKdBsvp6I6g3xZRTh9cCf+2EDTCrC9lZFZ17JT4auSrFANpXwyC+wswtekweRPEuKQXCQDKqRg2xB3aqmwdxZGZTte3gOFYLroTWKAYuihr0watOTgiASSQIkUN6MPawx+MdjvAmHeHqxd3qx+a7F30YqMZm9cpI/NOuQFCsgQ3/qAKIinUbbchgOcy2Z7c8NSTpOpKK/DtE29o+p0QPV6PnJQ3sZwOqi6uhAh6UYlALtHsgDMd8Etw1N/fm3nw5Z7djnaTs/+ajD6zHGCDBelCOSX1rMZY3EwJAt5y/TgKU2Mb4Xw5OxlmhNnD0VsBHXssLHYPS9PR4RFRURXOdVJG60K328SV5d3JDV7VrdV35we2bhLb8vGXrk1+Z2bOQoeyqcDNvStZwPDcg/eKzY0lpZJUKUeH1O7/6u5nFuDRhcfcz8LDrHinbOEfNAlV4A4mENMjKUpDrIZywWEp7jzfBD5IPwirlWLyN5NbAecp1T7zWRZpcsW6F7taVcY9SjYLflrA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GHwBIgjEjbzB986DpK+z1L5jinsk5m/zrEUsvpoUCxnwBmCebhTyiRHQbMC14bTsqAY3+c1k71wdIf+9wQJMdOs0WFqO7zgbreU9ShTQk2PhcumFpqVvuZfzk02/SRB35TFN3jD3Suj0UvQDYyFhZLw8aP3PxyCL75TyBBKSz/oB/LgUsU3FChH7L5uTjLiOc7iFnkZm2XDxLVe4EvWYcoNZ9VJ6fkV70LJrmNY75RXRLpVa605fpLptjhXz/j0V9mQu3/A7SnBP3QIFZ1VJRUu0w6bYn6FS+ihY6WIh5RuwpsqCxiskuCbsRso135NCaK+Pce8EL1dWCQJjzzhwzXORoyB6NX4fKIVPCIab30VTO9KpS0eSHpkJIXrhPipcoblVb1/rMnbS+SORhjhMvcPYR34uO3qbNBrr7jIcuPf3wqvURBE/7ozNFBcIN1TD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:31:33.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86ce18d-0e22-4d29-3da7-08de859a4f52
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10639


On 3/18/26 12:13, Viresh Kumar wrote:
> On 17-03-26, 11:17, Pierre Gondois wrote:
>> policy->max_freq_req represents the maximum allowed frequency as
>> requested by the policyX/scaling_max_freq sysfs file. This request
>> applies to all CPUs of the policy. It is not possible to request
>> a per-CPU maximum frequency.
>>
>> Thus, the interaction between the policy boost and scaling_max_freq
>> settings should be handled by adding a boost specific QoS constraint.
>> This will be handled in the following patches.
> I don't think the above is required anymore. This patch is removing stale code
> now which isn't useful anymore. It has nothing to do with a boost specific QOS
> constraint.
Yes ok
> And it would be better to know for sure why this isn't required anymore and
> which patch exactly fixed this issue.
>
On a kernel based on 1608f0230510~, and replicating the
process described in the commit message of

commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
a CPU")

I could not see any issue regarding the values of:

- policy1/cpuinfo_max_freq
- policy1/scaling_max_freq

The following sequence however had an issue:

1. echo 0 > /sys/devices/system/cpu/cpu1/online
2. echo 1 > /sys/devices/system/cpu/cpufreq/boost
3. echo 1 > /sys/devices/system/cpu/cpu1/online

as after 1.:

cpufreq_boost_trigger_state()
\-for_each_active_policy()

doesn't enable boost for inactive policies. This leads to
CPU1 having the non-boosted frequency as its max freq.

The above sequence is fixed by:

commit a153c6049ab8 ("cpufreq: Introduce a more
generic way to set default per-policy boost flag")

---

@Lifeng, should I check something else than the value of:

- policy1/cpuinfo_max_freq
- policy1/scaling_max_freq

in order to reproduce the issue fixed by:

commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
a CPU")

?


