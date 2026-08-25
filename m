Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6033C518;
	Tue, 25 Aug 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674784; cv=fail; b=DX97GEIjz4AY7LmySPO2/UXA4Taj8kwQ7NyxbwfV/kYSX9V6YSS+S1wO0H9CKCIJfdYK1ldcbmKyrwSSUuzyDeJ+I8OHzPc1e3lNaC5NdJmNQMg5oJWJhVodBPWuD2+3tYaxcg+yuaPeetrkrefu1SEA3jShoYGLelnAHlRGA20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674784; c=relaxed/simple;
	bh=wBq1inh9+fqVJe1hFepEvQjg5t1iayp8VHU3A7rSI7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2LCsKcSyGC/QDN8XVNL069BvbrMYaDmsB5JqYSJ6jbjusNYligj2u69CMM0Hl5A0cX7Kh1xFEMbZIr1lfO5dw8OCj7zqhwK+TaWBDRaDodFL6AjVXKjaeaCijvuLcyWcGA+t8COpzAnogW5XOI6MkkqJTRsClqsS5yEmbBLURE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=p0MoKzXd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tfL0E6ne; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="p0MoKzXd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tfL0E6ne"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVckG2046047;
	Tue, 25 Aug 2026 11:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=gIfhtlbBX/nmlGs
	vXKI798mHnz8R3FgVTu3SpBkIdmo=; b=p0MoKzXdYJMB8Aef1D427PfShSEC/Rp
	JPRBk2RrS81mbGyQod4ddb3EIYemtIeRqAnyKOLW3a/QHi5MljbDrIUEXBxe5iIP
	yq92M0PUL6bDk4/5nVPuBoqzYXIR1ZrrHJl+cXZdMRsUi8zP7HQ9rudv/ZiVboQP
	egoyL0y+zirma5abyQBajGyXr9q/TaqFaR/owOBgP50Pm6/zb6B5fPHEtSODUW8Q
	AAf7CvyUxn9sdAfjahKW0Fr5kPa/wMDaeRCjTwQMu/pooDREKBDpPuAh+AtydZOz
	cK0cQjekVm03eXXieHaaTxrg+Bq9mYumxAJSlTSDRmqACN+l4jtZQ3g==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g92xnky85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 11:19:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stcbPswcwycZodipzHdoIlJMUE5EafrRT+2eZ8idHp0Z/4iLCCS/+xvpd8FErhyV+OCITK52h4B38cFqY5q+rwzRwiAun400t4PKq2K+JY0ax3PPFx5sABAa4AaZ05usmnCsYC5fFhOop12eOXuohv+IwvgIiklCEiblGTjXHPiC5/TE4jjIxOamdSs2jjCxnyp4EtZdtcG+8suSt9rFI7U253m0rGPTrezB1yEZ2RwJTSDdK/UHU2GV/dx7w8Ctpt+0HurUtwJBpes0VVE3DclLkFnmqlfTFUAS3492ylem9PmNpiYsladl6oZ8Jo73AnRx9wB4Pw4qoOmklDUCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIfhtlbBX/nmlGsvXKI798mHnz8R3FgVTu3SpBkIdmo=;
 b=DrvKQfk/FY/cOtF/7IZXJZKh6j3L6xEUbwwpCtGZehsYTGo2QDORH5lw15s6L5W0aCb6RSytdiRBTNlwOPhxpHvTrzGZmN1pt7u3y5WwT1jTj32tKNMiirJDLwnsJP/ImeQ+wb4m9iTewsO1kUGuqdyIofJnnsqwjMt/gNyByTwnRsFxK+NUwoBBGUQ4ncO9BG43cYyXDelyyjZlrlHEIEE2mQM9kHLpheT2wDI34L3K3Gv8HvgRnW+xdmB9qJtRH93zLxVTXb3A4l3qPImeAfCOf1dAufUb7MV9+eWOyj4rsfGl5X/dwBf2u6bHFvYJ5fiBoGyrB+hNpOazpmhOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIfhtlbBX/nmlGsvXKI798mHnz8R3FgVTu3SpBkIdmo=;
 b=tfL0E6neRAZGaPc2hvW9lcvY75TcAt6ii6lsXbRVuOA6DVtzRUUWpaigl2/hTa+/8innKDwY6kLS0FZv8xiVGf1N/KHh42u0Dh9FRURbmestts8nApiX5iRcqAmlW98auLllSGVO9X6ybxW0HdhCmjz0Wa9pwA3EYsySdzlBmiw=
Received: from SA0PR12CA0029.namprd12.prod.outlook.com (2603:10b6:806:6f::34)
 by PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 16:19:34 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::8) by SA0PR12CA0029.outlook.office365.com
 (2603:10b6:806:6f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 16:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:19:33 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:19:10 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:19:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 11:19:10 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PGJA3v2377675;
	Tue, 25 Aug 2026 11:19:10 -0500
Date: Tue, 25 Aug 2026 11:19:10 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] PM / QoS: add lockless read for flags
Message-ID: <20260825161910.3y6avivkn6layuyi@uda0506412>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
 <20260819-topic-lpm-pmdomain-device-constraints-v4-2-7ceb095f5474@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-2-7ceb095f5474@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH8PR10MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ab4fcc-4cfe-452c-70c8-08df02c4a660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E2LBlT2NctZljhpN9FRDnpjkcAmvXKHeO7nUzgD5LjNQfgDdvrlKTlujHpB4P7iKW3PZT9WlPgSQBykS05y+5CGlEezw0jO5B0QPCgkGMiCreBB+ptNhpu3Y2rGjpo0CMJuSskE85mPSLRGS35hWw/wsFoLTNofOckZSUyWNFIduJ3f8urxNbDh7TCJ66X5aG2aRwtm0c0Tyfwuo7Y5JUEQilyFSiW2EcMBUcX6MivHP8ybuii2bcBkuVkrIX0/Lhu8Avmi54kZ+JBlt61I0NHXOvHz53j+UgcJVFRxhS3V7ISSnLj66LCW3+ZW46RJqzPevyxDyGAvqDs7IaVm9GNAeTaYZibTC8FWljouuxSfFrwk4cvMFKpET/We0cWL21ItocXDfhu31dix8QEaGkPulGW/O7/t/U6532bsnL7g6iSEbTH8j1mlYPCsq2JNcaMRjU3lMwW7zGu6C92kx2OvBh3a8fq5mr2qpdzfvUksXr34ZPINskM96WSTRtPk7HzW4g5ypy7lkYV/o6XkFk2SBTVmiXgD91VDhVH0SDTvPa93lX1zLZKug4yscdAQy+xXxQWbclEZegabRZhtSIpco1/S0T2SV+yWAVm0cig4euM+X50QFGrSIBMm2uWISvrBYARc7yJc7VvkPXmobUPM8iJB3O+CiVnlcuXTokE8H7o2MrF40nwT184mSm6r/bQR6fPx5JMOeF256ZDwkUQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z/1cJzcSDhYFwlHS0aWQOXvW6m7V42Newms9Kfj4SdxxK69KyF3F/C63xTjg2QqF6/Tn9clVLtvqTgBvtZAaZmyTYKyGHQWCsuDISd/TrGO96E4j2LTeDue5FZJUR7D10U/TCtYv+fEwnTKi4D+dVNUUa3KA4vYw1oHG/3vNaqMNhVhBA8qANqgC8d7K1UvGHpgT30WgDTqCMhqG4aYfvVw5l8WqxpnV7YHhLKrRBTIJewGl5iY9OYVkUrONpf5DxcrH4kjFKvk+CvFXPiR56gZ+usYSTrRp/AaXnnlUMCZuzUS/jLHJ8g5visq/Xp0tBInRKhdbBTDVcdx0MQJfqc6GL1vU93MpaDEhNKKuZ991SNI1qvvGNOBovWUCDQvtx5W99RXgao//I2xrrlDcR6XgY8CDj2zEaLtNj+Csu6eor71gbgKqU/YkkYKWhUo0
X-Exchange-RoutingPolicyChecked:
	GrEMOyky3hWiegU9tGbOiC2VIsqPGLtDCis4K5qbxem2vVc8U8YX2ITb1YhzM899ff0go70m0ykGxSfD0IgV0FAtMRR1Dwt/4mNjWkQx9MBYIBu/hqWrdEDS/AtdpUzhQMCPhVH0PO5GH/1mD07E0hN5HPrds05wJmvCADzJJHysoL9wROx7PGCIqabOPplXzssPiAXbnYt2xIzmGJz3JtR/Y2lHEZFCxyQivuiGSLkzK91bCz0hCLCFOLSC9Wm+SnVvV9fCv7TMCnMOFTSsT4LJfF8UbNxNydcZ0Ed345s+lxc8C+1n9k5u9FReq2+4RHECCDfQ1Yem9oiRnraSrw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:19:33.7249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ab4fcc-4cfe-452c-70c8-08df02c4a660
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6597
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzOSBTYWx0ZWRfX3jjwGHn+zb+K
 kDHFdetJcHD2Kpkk04+2uaUqJ/1Tf1vTEjI0nVfs/0ZPuVC1bDgGexIh4whM+IajKZtKRUYlrG6
 51zYh65vubuL2X1trqAdGRR0HEMJQoc=
X-Proofpoint-GUID: Vp_6mOYWOs_vDpAHslckN5u10L2zbuQQ
X-Proofpoint-ORIG-GUID: Vp_6mOYWOs_vDpAHslckN5u10L2zbuQQ
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a8dc098 cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=j9eNnXkOG-J7oe9ME8YA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzOSBTYWx0ZWRfX64rSIqzf6+If
 nVFoUVN9KUUE1/jNg66SBqYY6RKujPNzsmw01TrP/2YdelD4j/i+d3hj3BxJovU0q2UJQJNQKER
 UAV7OAOVRrKm4lXpULbB9X7Ru3MqLeXQzUW525n/8z693cSXoPHLxuhJ0lZCs2WHwnNgVZOXleo
 Zo8vemBmvfiGJHolDLbhdBO7PSusWnqZoAV6FiYPKEHTefJwHXXZEFDwm7leP+BYMSeHYMIKx7/
 IVADOsfKTpT6KJUaygsaaauAmeXkr20BfqE+hMTfVn/ofKfZ2fNyZxL47UPz2bXc1PReVGInjZZ
 726RSZCLz6Fg/CT8LoH3b6Kscy1plWbTl0gmYpOQBDNA8CX+f7fF5BvCpPvaC3aoZkMyjkseQrP
 R8F8mJhLnKjBVD9JxTdFNXC3flZShKPvIR48NcnJTOg1HNifrLLLbiEWjsBye+pOY8lxu3OJ09l
 FcpEb8nQw1ES5P5hrvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250139

On 10:08-20260819, Kevin Hilman (TI) wrote:
> Add a lockless read for QoS flags similar to the lockless read for
> resume latency (dev_pm_qos_raw_resume_latency) which may be called
> from atomic context (e.g. genpd governors running under a raw spinlock
> or in the syscore suspend path), where taking that sleeping lock would
> be invalid on PREEMPT_RT.
> 
> dev_pm_qos_raw_flags() now reads dev->power.qos->flags.effective_flags
> with READ_ONCE() so also add corresponding WRITE_ONCE() to the two
> effective_flags writes, the same way pm_qos_set_value() already does
> for target_value/pm_qos_read_value().
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>
