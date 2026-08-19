Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDC453A28;
	Wed, 19 Aug 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147230; cv=fail; b=UidtAPhPXpQGRRnQ53Zc6RheOgmfiV/Ag73ZxTJTa6vHGAY9ZatAcV+ym5SW2gDj2jjDK58GB22WhVmmOAI3qW67/jX4ktmYB/NB/9yc4aIPqIx7Wxt4TXmaMT1d57abvpdoUfjN2o9zxIiTneKKmvB15GRdteGj7tA/NLmuwhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147230; c=relaxed/simple;
	bh=rfX9ze7shnaZ0tC3WezwE88EWXFNQEeqvCuhlR3EoLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RRqaZgEVd2YJB06JWYuKZxgs30jpK8Rfzwa8sKDG2cVoFyFCri/JuWbPBrZ/RkoWfZh5PFtjODsjFe/xWMXnqpihaKSFO6qfn6OfRc4Zp4yaumx40k2n1m+FYLBWI2HXy0BCvcEMUn6v+UN6LpqgTfIzeVC/bI4kRD8tnnXcyVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NqofYrWS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rs2yh265; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NqofYrWS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rs2yh265"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JCoBMU2128965;
	Wed, 19 Aug 2026 08:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=4ejc/C3w3IjFU82DKFTEpxwxv6zQuZGB0bkEKWlcp
	eA=; b=NqofYrWSaFE2VDEdt/cq4BMKI6FruHlM6OjJRfAfhCPJ43VX9A4Vq6OH5
	ep+rTABVAk2/1CHwJ1bVgNVqZyYi7NbYfWHW0WJx4QFgpaI8goAPaOQdcclculEd
	WFYV6eX2TW8iTQS3UlCziJRSnQjYV4v6uRDatlW4/PEtDeHJ6x7oymHaHha/EBSw
	xi808AF9nskKArZo7OViRjSdq0H1fd+o/JVrZpXNNESiDx1rWKatu0QZlZeKTS+i
	9gLfxOqEZy35WsXbplO1MOd3SlJdX1SCYn63qd3yXF4twPPWQFDU9y1D28M0Ib77
	H1T4EmKlDLco+p7W9qSu+GidZRQwg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g4yejmr4n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:46:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDTHALKoYI3gULo89w29xljiCF1ZTIMZ7iC4ezFCmnRO6J7ChUhbiEoZ1nCJn/nHpiCOyeuo/biZYPGraSpU1iLefsceVCAcu7dzJxBPwWp18NPvSwkZfUtoLtQZ3++j0x2kY+6tJ4fOcGrb31JVhPt+YNdHCmFuTYauWpNol3DOficnxVZ9EO9TlRFPsCAtioPGCUAB7s6xRXxICrvGb1/OLTd7FMbjufHnwlHLWrpYSU3hhmZp3tamOPqCAQyJHRtFQYczSyvr7dsBVuZWwjjRRwsWc8zOXh5hD+TeTFQnhVaUEErSlEJPNU6vgLBMmGO+E4s7zYLbhx1xt1obTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ejc/C3w3IjFU82DKFTEpxwxv6zQuZGB0bkEKWlcpeA=;
 b=nXxYFXKvu88GDJYBfodYtMAOPiJ7Fa5d4A5bUwMSuX8UQKlP8NSWLWdf0E1WeIgDP+PJ+lqF2FAVrLrbQSZ+y1ZdpaWxuH+uwtP8r9Cr8P2i2gd7yforZFr4j60r614ftSZz5NPdBxIDxH+LzxAS2dIo99l9R6Omqt4iIKlXr6Cqod1yAUhvjUea+kZ3Z8vB1gkRNoRyi8HKLrThx2n8zEZOTfrrJmcappDfNtH3myI7KZKR7MSUN4QvA5kaS+GUAJJpw6jwSWjha7k3O/zRmbCfAeWbcbE1+gS7VrGs6KEoh3qBWiWK+XwBMSm44oh9mTICOPApew2uizNFzW/8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=axis.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ejc/C3w3IjFU82DKFTEpxwxv6zQuZGB0bkEKWlcpeA=;
 b=rs2yh265XSxks8l3LJ1fnPeX7k8qSdKVkD0wFwsRE3RVxZIncyIjvOw2Fga0YkLEf239JvIVcldlIcase5tTOPEP08PCtVKBZZrQc1SRiFMkVv0SlNzVVhWrw8QeFxksuZcCDGhbXdb3xDAVj7tXSoS9Ndbz9bwfEjciT4B1DQE=
Received: from DS2PEPF00004557.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::511) by CY5PR10MB5913.namprd10.prod.outlook.com
 (2603:10b6:930:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:46:50 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:6) by DS2PEPF00004557.outlook.office365.com
 (2603:10b6:f:fc00::511) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Wed, 19
 Aug 2026 13:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 13:46:49 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 08:46:30 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 08:46:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 08:46:30 -0500
Received: from [10.249.36.219] ([10.249.36.219])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67JDkTe33473535;
	Wed, 19 Aug 2026 08:46:29 -0500
Message-ID: <2a392567-002e-4c05-ae8a-441c72fcc4df@ti.com>
Date: Wed, 19 Aug 2026 08:46:29 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] power: supply: bq27xxx: add support for bq27z746
To: Henrik Grimler <henrik.grimler@axis.com>,
        Sebastian Reichel
	<sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Chris Lapa
	<chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>,
        <kernel@axis.com>
References: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
 <20260818-bq27z746-v2-3-0371e206665f@axis.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260818-bq27z746-v2-3-0371e206665f@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bfda15-1678-413e-60db-08defdf8515e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|13003099007|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YiGVgGEqErsufMJUU+vKAoxmt7ZQ6HjyFA4vnm1w6HE+DnAUgCAtXjG2+W91d7QAY9MUWH6EeoIHgZWoCCajR/l29MpLv7+0yOmXtfQXDV5cW7oMVZD2KCjtjG+pCNyptGLgScDlWuxmshHf48UsnsBWvOgeK+UN75O32O73BvC243RiKkhkgeP2K+yum3O+c2noTjYdJSnFEPZOg7TMpxpVkV25kihbFtjmOhiNyb2NyvXr2uyZXV+C9kUWRfOVnGvDhf5MS8EpAn9VGIFVALJLDFFtzgQtkXHeNQk/mnY+OBsaexdkvqHaa4qnqQ6uGxXLkxJnM+tEfS+/pIkeM37XexzOkTA6+xqLgZCYlT7kNfTWvfEpFJHCWQ6PZH5DSxPz1jWlS+/FX0UGHxicLxR/iZrYwb4FszA8jKkZfss4JaGkah0PtbtuFHtlbvnHT36JIK9KUg8RqEysUa85aWYGlUqbk/5Hag2ZzoARkwIIGYxZxkt02YIroEhL/6bZ8M5VkGHQ6NAB+yOjoWh7qsljKOFBw3KpZLoUwZin4dac8GpT9PN6tbtN9UCRMZeRXxRtU0v+JMusNWaJLBpjKizIGQAN1OqPkDirsPKCjVWjj+t6YnZydxrlKYfQ7EwPIYqJjY/uyzbWS6i+AbFjcMoimw88D14Ya6VyR/de0Jwn4hO6qqicKAN8QyfddPB+D5LTlGUbvuGbmuoGDYciGA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(13003099007)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Son0l3lAXB0fPwgnsU2EakAKDmD3wv/McBGKY0a6ce5uHpvIa/aTJDxZRXMFwWwa/JfDGEjPBbIeak1Wlwh2UllLj3Yd0eO1venPFZ+z7xVLAKsyhSIpG1f/dvYl3aUGhXSp/sVlpaE8EpdNdvHQ4QD9Cvl6jeEeLPHtCeuI7OjSfgE+JcJJAkqAhkT3V01qv48F+7d1vKNATwRosZy4vomWkJy1j2pcQAkS0Z7Ch3W/NNR5YZ1xH6Y6+Q3aXrbsY/80upptINYp0o895/F8yoTewDzQWvMDrLGVcWRK0BIvcbf1nSIOMzncM+r17BHndSqWLpjfa3H4ezRgt9mg0YYefuKJfOzvtQFehBXMjQuLPaHA4M7LK0MeQ4aSGeYLpgmKHamacOpPJgOGZgIWV5STRY/GuCyyyM/ml2LjFnxe0Rr3fiDTOqc3pMg0YDGc
X-Exchange-RoutingPolicyChecked:
	fVUqHae1tlhqg5rMfFtg6qEgv/mh5g2X0dJqPcIm9pv4ZGhbyPpd0tRgVas/OB4KriuIHFIYDkQBRetBYjHGdTMlLAE2ag57PS+wdsD3FTCoxWci/Z2pAU1g+k3N3cXv6QorlNGSNVZhd/Y3hP6BDQf0z8uv+5MLS+SeOc9blGE3dF3oo6RTxnADA9wkLS64FjAGk/ORzN0DZOpEVPAp0AG9pxXIdK0RHaAMnQ2lizZK2H8s58pFw+KhliuFjdr5ZAZyrUIT19AIiY/W0YrDpbf0vXfTZazkEHW2yYFomFPR8lxZAwfC52/ejC+JipTuilPc4TM+Qq+cYI9iYsjuZA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:46:49.1071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bfda15-1678-413e-60db-08defdf8515e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNyBTYWx0ZWRfX4j8YJAG0lPUr
 LtltRFWyY4tlvs5JwdNiC5LnWo+rqKkntfYkFKPWGKeoFfX21chvecKzxNTgNzsjzvt7sdn516H
 YNKbXQRxvviYTGgTpYqhlnsRF+1z8s8=
X-Proofpoint-GUID: OHTdrnRyLIdsg8bGzHNhyTEChpNsrRFv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNyBTYWx0ZWRfX1ZXrDZbrx5vP
 AF0zxDtiUUNQyH6ubrUxwxfcj3qD/fgtesGMNDZG35RB5QYzQKRQkFA8pnWdrMg78J9R64kiQKd
 My8tIRC9KZ6VgUlwFIyxVafjLCxwOBEYUBHdU1bQaiG6H6FEIj50yr6n7CgGyS6J8Pu3vvdu09U
 GgzdXIkPXH9UiBzDnP7sY+WSsOqy2ocIOF3ZltbP1w7zCc/aFBS02yCZA2LHLQHYSd/bAXafBIS
 MCMbAE1E0QKLIJY/EtA9J9hMYQ35nvdPbGrjkfDwl113j/FALXUiw4KgpzonnT0yfbZVi+bkFzL
 GJWjHpSjtuyBZtP9a28/X3mhiM/XOM4gn7ymEB18hoghaIxl8/TP6m3EymRoXDFGeWlhJwemHZZ
 1mc7kgRSVCv59mVXxvpZOO0F9J4zFkJ66JlyAxWst26Gyws1NuKSQ6lZ9m5cby9e9nL2BhDn5h1
 nmZ55J82RVxUz627YUw==
X-Authority-Analysis: v=2.4 cv=f854wuyM c=1 sm=1 tr=0 ts=6a85b3d1 cx=c_pps
 a=LQDsqUhXq6x2TIKBD9Oruw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=3-RhneuVAAAA:8
 a=X-YF9uxeuWHKWUsyoMEA:9 a=QEXdDO2ut3YA:10 a=VLVLkjT_5ZicWzSuYqSo:22
X-Proofpoint-ORIG-GUID: OHTdrnRyLIdsg8bGzHNhyTEChpNsrRFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190107

On 8/18/26 4:48 AM, Henrik Grimler wrote:
> bq27z746 is similar to bq27z561, but has additional battery protection
> logic. The standard register map is a subset of the one found in
> bq27z561. There are some more differences among the ManufacturerAccess
> registers, but the ManufacturerAccess registers are currently not
> handled by the driver in any way. Therefore use the same regs and
> props for bq27z746 and bq27z561.
> 
> Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   drivers/power/supply/bq27xxx_battery.c     | 6 ++++++
>   drivers/power/supply/bq27xxx_battery_i2c.c | 2 ++
>   include/linux/power/bq27xxx_battery.h      | 1 +
>   3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 01c9ec1116fa..5aed8b24119b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -37,6 +37,7 @@
>    * https://www.ti.com/product/bq27441-g1
>    * https://www.ti.com/product/bq27621-g1
>    * https://www.ti.com/product/bq27z561
> + * https://www.ti.com/product/bq27z746
>    * https://www.ti.com/product/bq28z610
>    * https://www.ti.com/product/bq34z100-g1
>    * https://www.ti.com/product/bq78z100
> @@ -501,6 +502,7 @@ static u8
>   		[BQ27XXX_REG_AP] = 0x22,
>   		BQ27XXX_DM_REG_ROWS,
>   	},
> +#define bq27z746_regs bq27z561_regs
>   	bq28z610_regs[BQ27XXX_REG_MAX] = {
>   		[BQ27XXX_REG_CTRL] = 0x00,
>   		[BQ27XXX_REG_TEMP] = 0x06,
> @@ -836,6 +838,8 @@ static enum power_supply_property bq27z561_props[] = {
>   	POWER_SUPPLY_PROP_MANUFACTURER,
>   };
>   
> +#define bq27z746_props bq27z561_props
> +
>   static enum power_supply_property bq28z610_props[] = {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_PRESENT,
> @@ -994,6 +998,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
>   #endif
>   
>   #define bq27z561_dm_regs NULL
> +#define bq27z746_dm_regs NULL
>   #define bq28z610_dm_regs NULL
>   #define bq34z100_dm_regs NULL
>   #define bq78z100_dm_regs NULL
> @@ -1052,6 +1057,7 @@ static struct {
>   	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>   	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>   	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
> +	[BQ27Z746]  = BQ27XXX_DATA(bq27z746,  0         , BQ27Z561_O_BITS),
>   	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>   	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
>   							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index c4e7a9521d08..2a6b4534cb28 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -253,6 +253,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>   	{ .name = "bq27441", .driver_data = BQ27441 },
>   	{ .name = "bq27621", .driver_data = BQ27621 },
>   	{ .name = "bq27z561", .driver_data = BQ27Z561 },
> +	{ .name = "bq27z746", .driver_data = BQ27Z746 },
>   	{ .name = "bq28z610", .driver_data = BQ28Z610 },
>   	{ .name = "bq34z100", .driver_data = BQ34Z100 },
>   	{ .name = "bq78z100", .driver_data = BQ78Z100 },
> @@ -290,6 +291,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
>   	{ .compatible = "ti,bq27441" },
>   	{ .compatible = "ti,bq27621" },
>   	{ .compatible = "ti,bq27z561" },
> +	{ .compatible = "ti,bq27z746" },
>   	{ .compatible = "ti,bq28z610" },
>   	{ .compatible = "ti,bq34z100" },
>   	{ .compatible = "ti,bq78z100" },
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index d56e1276aafe..0b833c4bb583 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -33,6 +33,7 @@ enum bq27xxx_chip {
>   	BQ27441,
>   	BQ27621,
>   	BQ27Z561,
> +	BQ27Z746,
>   	BQ28Z610,
>   	BQ34Z100,
>   	BQ78Z100,
> 

