Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795797819;
	b=qfbR5FUCufWh4UwTh4jJ1VtV1a7z2KyqLabyYNLOAAsvlIorsqAgQCodMsr8JRf5zPHB
	 OM5pYT7c2ZjCGElncMcGEuCn//rQol0ewZkNnfLB2Xd73WSIymeR/1TrPeuSgxTpnRjSR
	 VRfENgeFxTaJyn/Dw6Ke610zUKdd0CKlVJy58I85WbJt2DrE27x3w/O9wHSoLBqpoH0Ln
	 p3aHw2LJAibkXfpXgBU9PRHdTrn/sMbpqbCSoQ0o/50mxb/7/zbUf1nHgGdpKDN5VgazF
	 1X1ymvtyJcus8APF3LWKVFfN/+ma7i1WR6fyMHga487vgaJ547hohhLUt//3wcP7vbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797819;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gPnqV+uJp9/t/toK+Czmxem3bP3H56zxi9UOY0SoFNU=;
	b=vbTuV8QwG2AOTtv/1E5b66DIau8jJnPIqi3BMGBibnMPtFt9YexNs7W0oganJ3mlDf9m
	 sdjSvXDUWdbuQiV2Sl9pMx7OsULrluW3+1s8tXV4lNNBQyTrxHXgg2wMRiANJDWgfhZK5
	 iHj+PoRsMp7dzURK+Xf0+NPA/xHJQ4bHXUGZflkLIx4MmsP/vyu82+sHm0JHzQuVLjJY0
	 A4P8lw3AqhAcKbc0Z5t8V717rPKQFjYAC3OdSXIzO27Q2eRj+8sRwyXpvzTaiWOAhs7aY
	 Qss9mT+QVzBY7tzRa3C38SPfjRMjpFdzN6spgoGKJcjJRouJohFwW0dUrERyrRWRxRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mpz71Tag;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=dmi1B5CZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB58606A31C;
	Fri, 27 Nov 2026 16:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mpz71Tag;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=dmi1B5CZ
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARFoGM02137338;
	Fri, 27 Nov 2026 10:43:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=gPnqV+uJp9/t/toK+Czmxem3bP3H56zxi9UOY0SoF
	NU=; b=mpz71TagD11TxBygt7AQg7cf5Hw3Lm+g11fPLxMaDK6aFmZKGFKVyyL0r
	tAIIS2WJIC6G7POX+NwxqwnjxPSTWO6I60Ep8KsqeTvQNd6h1IGvjKDYRXQEJIM7
	4E8rednpYx2b259w4QmijEWtu2VajfYNZ77a1aOILx1Q/h5wXWGDcDnb8LRSWzDp
	6XFQn78+SZAFt5JoWGo+x/04U7pVT4jHl2qtu1QTcNRstbP+vUhwBdlAKCvKOgWC
	HQR9vS2n01jnjZz7e0Kwm5QyrrUC/NBpT6w9zBEvO2gEKABkaFVHeF9MvCiCcwrA
	awQ+yYt3fB5QwVi2x3Z9k8I5jbyCw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j72ujubb9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 10:43:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFOU5487h9NaJNkE1Sr2whEdj3ji2MuYoQohV7fmUFOO1VYC4Ih7ibn9+cPXJR9rtooEtxQpB2LK7HqmSpvIhTymXRI4y9yP3bjuQPaRb99IqxLgpHfnSZ/vxbyPqHzPA9QHpKAwNskH1jh2OctGMRZz3XdHHKm2IwulnhU4vVM5DwtmUrzv/ebEQofwb4Ondygi/tPYclh3O8BvHY0edfbeZSVdYNU36W/phTLM6i7SLFh0zeX2X5VdWmNtuoeAOR4Enepva0uIY0HpQY52l1fOqorHvg59NtaO8claGfeKTbpoLmlCf4FvYtBpdEJvVRc6dTScfKtFyvYlp02ZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPnqV+uJp9/t/toK+Czmxem3bP3H56zxi9UOY0SoFNU=;
 b=Yon0e3wzYPvIS7mzlKWF6exb0kTdsOz3qk8vFWj8fCXwUwYSTnj6ITaVEJ5TjOKwJPVkdEP/JiBJ61Q3wXZMPNeO75TVzTusnXOi8efrRPS1k6fm3AmVJeayb9nvwAPynIgcJuYP8KrsnpxGyGU2cqmmPPWpKw2QPPbgYsaleO4LdYVpnmuK44v/v8Wf8zaxTNtUXOOQel8UU+jwqz7c6JCO+WnxFczUHxcRH5ClyuC949AFfe3+6kMPkWTWABy7mloomS80u/BxYixHDMnnvYAB7GcvK/qYltrPMJKZ722W2k3UuHPxiVk+xc/bE2Sn3CVuAys78sOaQwkDpc9cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPnqV+uJp9/t/toK+Czmxem3bP3H56zxi9UOY0SoFNU=;
 b=dmi1B5CZfTqTbiaPBVzJJ9q0xvBkg+eBqHSPOEnzoZFvOM3QYaldJimA5GE7FcX/e/8d9k9mREhg1OWdBEXNA40AINLlWtWMFUAKxbs6vwFwHc1UQIh+mhEPjUlP2JsGvPdqmTiOi93VJv043/pH3hDnJlj+24oYmaUW250SPV4=
Received: from CH0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:610:cc::23)
 by IA1PR10MB6759.namprd10.prod.outlook.com (2603:10b6:208:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 16:43:19 +0000
Received: from DS4PEPF000001BE.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::5a) by CH0PR03CA0078.outlook.office365.com
 (2603:10b6:610:cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 16:43:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS4PEPF000001BE.mail.protection.outlook.com (10.167.23.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 27 Nov 2026 16:43:18 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 10:43:01 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 10:43:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 27 Nov 2026 10:43:01 -0600
Received: from [10.249.32.241] ([10.249.32.241])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ARGh0474088669;
	Fri, 27 Nov 2026 10:43:00 -0600
Message-ID: <314807f4-dedf-496a-b4e0-d034ac97ade3@ti.com>
Date: Fri, 27 Nov 2026 10:43:00 -0600
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add TI BQ27Z558 fuel gauge support
To: Prachoday Sutar <prachodaysutar7@gmail.com>, <sre@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pali@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20261126201959.28743-1-prachodaysutar7@gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261126201959.28743-1-prachodaysutar7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BE:EE_|IA1PR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1487ecdb-6c53-4a86-b57b-08df4ca58aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|261028144727099003|261102123227099003|261026121527099003|261021123027099003|261021135927099003|261026140227099003|261021121427099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TcDciYuE2+TUNgu/AubGExlGNTEYoADci5tpHGRwqPeVSNbKvViUzWKMGRN6KllTF8wSCLRxJHKVRCWvzKWRwPLWtk7/ull4coRuAveB1+aE0ngRGtArLb4KY3KGlxOOFMoaFiepk6EWUgB0EFXV6Ur3PtyAZ+EpnuEf3nxoBfmwCm7HF+2n1G4JtLqSMEqv9zMM+IzPO48u4Z2fXDGsBqyMW+srxeJEqyAg/CHx4SZnzfmLwg6DnEfhk9GznMoLy3Dqtw8UlEd4UqXt2d06n/qKjK+rw1bz2OdMVhKGBvbHhTImHoEYdKwV7ZK6LOme6Le/Jf8nN4wQmmQmjLwZPNxgNdntldDbBake+8YuSh2x7kxpor0Bwe6uiGVTPIolcDngn1+O4cvaZwy1pzwYXHUaIfm9T9sF/GUdnevzOeXeMWSEKzWDQCF6cg1mf9nRqUDCGXMulcLdlyFebrYqN+dGAk92X+D+0rZYMisNxlADwvj3zt4uaZL/yD/GJJtVdt/DOpqtyUBwbh3rRZwWwZET0U0teI2vv25bTDzc8Z6uJreCsEIS3OcdF8nwK9Uo4z7AzXyI6bqV3G5MHLho08rY3GWGGgLQYp4JRasUjnaZTml+UlSNexNnaKIsr2SzWVgs5O4ibaXZqBXaWKl9fw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021135927099003)(261026140227099003)(261021121427099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3GnEvYJYVcFdhm3cf2CvMwkWIv/g78LyBieJ71V+9D1nTD7AIvzhgneyyS8gTsXvSQIglS1abqFLVFpNZRGCav+DoNSBbZmoNmEYVWPHS4x/qCWkAyMNz6oMk+Jmi1AEA78k/8gQ+9XMe3BsWvhzycWrDg5iPqJ65WJ/h3cci//UROFADbabDxQjRq98uTtMPe6puwaYUe82emQYPEQNZleffCET7bWSuzhYhIQXQi9Sug5ynTnG15oYIR0qOSQjgU1CAKXHqpJudDWqrSSGRl38H5jv44K5fo6dNDUXTKUG7DM2KWJ7fefbV4SQW/olBMNlpbxkmUObBeHVNYM5yyEzt074Li2XyBEjEP6eD9RfgiwPd3of6wyDEM5k3j+rznmmXh6lJf3hFG1s9qKhvOWvqfO0Lf/1jKeC8I3hC2qTYFB2f7GgCz9tOMowz9zf
X-Exchange-RoutingPolicyChecked:
	JWn60CK1DUkhPeBUAZYugPv1I5AfMOZDwiWNP3gbsTExDwJpfH3xSpGkh6w9fPWCu1NlAmSNj713DXKXcmBpvMgBVNCA12KUsAx81xjShLfNYf2rrui/aKWj51Kp/liZ0juaw9i5wq+ZUeqmuXzLZ1A7vzcGF/AHV2FCaHQ46TD9g0pUb/2yEiy8i3YHPLR9BRdF1qrMNfsW1Awlsbs/1k6d0uZ2vY8oRWKFsuCblc/1YRAjC5Qqe6qptXDdfaO28xv2SDxYtAzwfrtlNqz7YPFMeReChYd7nPGRl/6YhUZgmRKuZGeDJJhWiTVbEH1QfzS79IlxgGGGdHmpS+4+lw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:43:18.8327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1487ecdb-6c53-4a86-b57b-08df4ca58aa5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001BE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6759
X-Proofpoint-GUID: 1QAfPlogT98_VX7WH3k3s0sy5ASWtAdt
X-Authority-Analysis: v=2.4 cv=N/y8hG9B c=1 sm=1 tr=0 ts=6b09b32a cx=c_pps
 a=lnATZ3Q5w/Ci7ZOK4Uls6Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=9jIlWcliD0jLBcx-AEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NiBTYWx0ZWRfXwsvk8Q/jMJ2d
 S2x6yMUTY73bVtdvYAQII2Z9sggE1EcIA5zBQih3fedM7cQ8jKsrsO3CE/dNGuBwNen9L+j5Zus
 f8dFjQ2X6lv2D6P/cIwcPMYgRBIMWJGv5ySB++8w+p7IdJ6c5x8LrgUxGYpGapFA1dkmg+CPjid
 MrSlV7yazJEeqNoDLZii69znXgfDvIsHC9DU9q+QBruUPXq0SUjEADdr3lSmMTS/ssKstITZyfl
 esrZCZDI20TWhJh4sGjqc/Oxlu3b+5/Xh+OkEyeg+f4ARt4jmzmFR4ZVzamzbCNBs6ZiYpmIjyf
 /8iMWzkXn0EitK8FhhaOkuOsBVCkjqgufDj4lYAaDByXKG4Jw6xwJ0lsB4p+VhnNm+gSHtjCy0U
 kHqlUqEped2YzgmybSTmtg+isCVcwQosVQvfNJ23fYpN+xfRQNY5o42noiheMkZh7sAFyVNFR+N
 nFKZMXOQ1qkt6ox0qaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NiBTYWx0ZWRfX9RJBnqw+b/P6
 sn1JHRFKNbI+Jz3Ck79/fybSssvBjKQG8Nd3qYiCR8TWZapHLRKmF+5K0jCaLna91ham/6hBxbd
 AiltnGgmE3es4pYZEAbWvzTp4c07K30=
X-Proofpoint-ORIG-GUID: 1QAfPlogT98_VX7WH3k3s0sy5ASWtAdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270066

On 11/26/26 2:19 PM, Prachoday Sutar wrote:
> The TI BQ27Z558 is a single-cell fuel gauge documented in the same
> Technical Reference Manual as the BQ27Z561-R2 (SLUUC54) and is register
> compatible with the BQ27Z561.
> 
> Patch 1 adds the compatible to the binding with "ti,bq27z561" as the
> fallback. Patch 2 adds a matching I2C device ID so the driver probes
> correctly when the client is named after the first compatible.
> 
> Tested on a Kneron KL630-based board with a BQ27Z558, using a vendor
> Linux 4.9 kernel with the equivalent bq27xxx changes and the fallback
> compatible in DT. Voltage, current, capacity, status and temperature
> read correctly through /sys/class/power_supply.
> 
> Changes in v2:
> - Add patch 2. Binding via the fallback compatible alone left
>    i2c_client_get_device_id() returning NULL in probe, causing a NULL
>    pointer dereference (reported by the Sashiko AI review).

I thought you said you tested this with the fallback? And Sashiko
says fallback will cause a NULL dereference, one of these must not
be true then..

I can see what Sashiko might be talking about here. I think a
couple things need fixed.

First, the `bq27xxx_battery_i2c_of_match_table` and the
`bq27xxx_i2c_id_table` are out of sync, so we match with OF
compatible, but use the I2C ID table to get the mach data.
The OF match data is currently empty, that needs updated.

Second, `i2c_client_get_device_id()` is only used as we need to
fetch the name, but we only use the name in `request_threaded_irq()`,
and we could use `client->name` instead. Then for getting the match
data use `i2c_get_match_data()`.

Third, I'd just skip the fallback stuff. If you have to modify the
driver anyway, just add a normal compatible and use it in your DT.

Andrew

> - Patch 1: drop the claim from the commit message that no driver
>    changes are needed.
> 
> Link to v1: https://lore.kernel.org/r/20261126191906.25708-1-prachodaysutar7@gmail.com
> 
> Prachoday Sutar (2):
>    dt-bindings: power: supply: bq27xxx: Add BQ27Z558
>    power: supply: bq27xxx: Add BQ27Z558 I2C device ID
> 
>   .../bindings/power/supply/bq27xxx.yaml        | 72 ++++++++++---------
>   drivers/power/supply/bq27xxx_battery_i2c.c    |  1 +
>   2 files changed, 39 insertions(+), 34 deletions(-)
> 

