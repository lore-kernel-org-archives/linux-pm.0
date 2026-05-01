Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EC9463;
	Fri,  1 May 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777613252; cv=fail; b=uZBYhoTlMfBIQYCpyZiJNmiDp+sURNSKItJfuwv+MtK6tDl3hgDs+PAgmKaQgqSWhwbHiij2E3w6dqzG4j0ek7MmGcpzqW8S0a/npbxUGQdPr59Gjljf9w/Hq4fQE5ri4UTfVNUtKu3u7vT/ZqUNfrtlc/d8DrU0dZ86cVFNqO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777613252; c=relaxed/simple;
	bh=gCt1N/+Bvdij4MsaXEvJEFZ/yaD8toi0KPPBCOPaa5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hr1kYdzfo1xiSzyiLj/db2mAedyaIoD+mHpVOI1hj2Cp451rzUTLUZWQrTZ9jhmx6aFd3pSHB3+2wlHigl9CO9ZTiu2sGNXfxaVNlTKLD37Tyu0GZ6KC0hBVAFwwiIrWGZ7C3Bzo9sGFfpc3BwZQZIvinNoRDNkOoZO/O5Dm5S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+yXraLp; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+yXraLp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkSNPWLgRymNHdYmw8KIQBdVUOpR6+uv5aHijxhy++avERscLPez6OXkXQalZGdvhTTpDlcgTU4w59cGgiNkMoS7uokPON1Gldlsh+uVLCHFx6pDlJxahxFxiClwHeV2oB8dyQ6TZm48DyBSQK5HwqmpKDxTTFpbWML/sJlxE93Zeq8PY7xqP7yxrBKFh+zwAOs9uon3nfBJWh/ansLZVhuqAR1fFXJaOkSICEFcuJRWZrWW/zxhc7EcYTk66M+3g8oZfq4RXMvwgdKGcOHFA4q2D738LL2L41Z0xmGHPwDwk0vJvvI4Qv6Jo/8oGyITit0/tIYxULGq34YuqB+TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt3S7NoU5lWguRvq+nBD2ENz36sNqkk0TZa52T6r0c8=;
 b=E9vG6eYXWRqeqF1Nw7rxdJkarLUvRFEy9W+Gn+/IkVZKDeMDoIpH2fw01ypSRDcnXGZfZRWtLy2xuDdM3fESI7zP4iFhXNnM9sc7neiaWC23hGq4TizIUCCUrv6AkYoksvvhF6PMWOcrMD+lze1zp1RVoEvK2rVHpM7pc2ogIqwFMn976UMATCvh4g+sfmoMJ65coeBMSGHvq0KpoHNAFixJqaJo7qegQ66vQE/D+Q+OIETNNMZqDGW43idAzzDzBQ/m1cmtlpd9bEcG1ERKQvVp9B64MYZ1dw7sQStuBy7mFXrK7EsFhKkPEcn1PQ0vvtHeIuR/+CxkelVs1cmE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=163.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt3S7NoU5lWguRvq+nBD2ENz36sNqkk0TZa52T6r0c8=;
 b=U+yXraLp345Wh0nvf/567xMFREssfU3xEhXLeXjbjlADj7mOBX7KyMWJA6SSOS4pwp+se+RM5PYG9LrlLkhYT9eMmFlLmxq7rlvEoEcSVTgxFfsfODDOSJ2aSM3IfFN+mJpvgIAhWQYTu75GiTu8EfD4MKnuhue9b37IOBQmf9k=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 05:27:26 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e8) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Fri,
 1 May 2026 05:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 05:27:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 00:27:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 00:27:25 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 00:27:21 -0500
Message-ID: <9d8d3f4c-2084-432b-900b-8411c56478e6@amd.com>
Date: Fri, 1 May 2026 10:57:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate: Use FIELD_MODIFY()
To: Hans Zhang <18255117159@163.com>, <ray.huang@amd.com>,
	<mario.limonciello@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<sven@kernel.org>, <j@jannau.net>
CC: <perry.yuan@amd.com>, <neal@gompa.dev>, <linux-pm@vger.kernel.org>,
	<asahi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260430163213.44695-1-18255117159@163.com>
 <20260430163213.44695-2-18255117159@163.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260430163213.44695-2-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecad14e-9abc-4b64-b640-08dea74254cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZyToTkshyduIQY7V+VIHBpMFBCVfiSIEXdp6pmLuFehg9PjlpynIoIJhekFMqiV/NnxuqIKEfSbaIfPEA22U2WSSCr67d/2eQsy3dI630PhrCK1Jw9guMoAss3CX7WuSFG9Ib/ijf3ZahysCJNa7DV+rW5TRSHm9V8N3b41sFHkDfAokUVZoqHRXjFD6a/ZV/rmEEn0YZ3ZsijwzAe1N1hgGSCFCRCJN3X1fbYyfELZkgeOH0dXObRgonDHY7FZBz84L7AO7Dfxk8Vv2laWfUU3aL13BSsB0aqvdpTKsK8Ve7AwXCEoczI6KMPg/ze16+ahwhC6YFzWO4WaniMLyKY42eC04S+2yuc8UW0sFnQ/X7yUlS8MWDXGcOiZ3plYOCtoqNDfUQyHHIq+85OaYcRMSAM8/z0usG963edTq0jgIA0eui/ImWqC9uM21TIR2Me9Ftt2LP96PwNzamRYp7yw/x6AcWXlyCt7cjeqzEOQgQc7a0xfmnHJ1DhjbbPkjPmkzKmqbUVuy3cZqeXR2V0Y97cK1npV84/ABU4F6paKfhlRx4vJecvmdJaI7Voec6bt9ePzhqfH2BaZnTSigXobXIWGsU1DvHHkS0Sn1qdRWrx0hHVdET0eeqS3oT4WepoY5fdQdFW9Xg6T+8VduFdSFTJBcvgQF9VXvV3rO8/Z/oaiLBHU/nJHwMFWCHZy0etV5m/yWi16azvO9TlCypLqXF/UDOyBwXtYSjiKr3JU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FGYuNnDw5LvfvVy2Lntl7ysvajki7Zo2gcmbiQUcqlKNZKkA7VmYZKv1Jnf3zJxy0RTbx1ApBkrU6I5imzJ9LUc78K/0qZmEAm7GWHBXyQDNaeSfWidbG0aInfto89R0Z9iibuF7NAUA2o0BckVQGGqRiHH/zIxb2zhv9weKqzc7KXKs1WD7SVYj/O9E3oDaIiRVEntb1GsEYTws+wq8YLbMdX425sNiRAe2CTnYcCJX6aSs0xGBP4Y2rttHX1Pts0Wve3JhQFIiR+itMo5Qfm980+HmtBJdZnPxTNOZQ09L6n68Z9oLEL99U9ak5gZzcHPE5cP3NYGFis99QqPNQMGG8V1lB5cxx0tnL6+GUmGjjDhLxR7M6uTsXUWVEPl2H88CZNfrY9A7VONmj0JHLa+4Irc0D/0/pkOHBvcqDzP8WPVreiURpbIonZ4rtSSu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 05:27:26.4426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecad14e-9abc-4b64-b640-08dea74254cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056

Hello Hans,

On 4/30/2026 10:02 PM, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Thank you for cleaning this up! Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek
