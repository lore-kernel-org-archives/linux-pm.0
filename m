Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC372371D0B;
	Fri,  3 Apr 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236092; cv=fail; b=KEGrd3flt9wcUc9M+iUcuPfj9Ro+/j/j1v3vym6NTFeSMUr/fpIPoc1ZmIrDYXp0vIv6Nw1O8X/OlbnmA5tBFOzW0kxCleOuS+vnx2FdEi1+hN2RAAMoBSAEL1UUgSsOAd0us18F4n/LSl6mZunfbfgvnUt3CSWRflqaTSgoZCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236092; c=relaxed/simple;
	bh=NnOyRzEo7kV2fpaTuA+oUQi7cECNIJ1kjm23NNKBuX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itJLZI/sQHVy6PxUE1IiYUcqqPhUcZAzQg7hyuV8OdxaX4flHKlaYm7JsBa6p2oRNn8m4wmtUO6lZ925DkBbuZ9nVSeaFrQqZjlBBJXaA7Gt/+sBaTw+YeckyQ93/OHr9dI0r+1/7rem7mayiIuYC5xdUFbkJ7gsE/6TyZCDgss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=kGBMAvlS; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kGBMAvlS"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633FKBbF3091986;
	Fri, 3 Apr 2026 10:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3CHE6V3Alhcj3aU/nCQ7wMTdZmrXunKB0mvtxKK/2SE=; b=
	kGBMAvlSK2cW5fJ532yFPjPwRqy1q+spGxfqVNb+PF50Vzj12QYuUHpuGqcledZl
	EHuLzwF7oM7wpdU4CcjOYjGK03kjkSAqSuMWzNm7R9+tauGXI/UZyBmvX9WfQBF/
	YAHm+K36g9gV6bduGAu5hb0bonesFI2uKHXfmBwICMmjGKzlZXHP6SmkPyv5SNHz
	6o4/C1WQbMzOgiXvgJGfo1pRHBawQ58gy0I2vjAw+rQr5QXznzuQKEKUfmW1VK1c
	ZGMpFbkDs/q9lsMg3/UbWw0YmYhXTi5n8Hr5vpL1Br9u4wa0F8tSdfzDCIWy8Khc
	jKcGsqDQ2bBUJVA6l/2Xag==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vhasr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 10:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZu9b/agM/OdTM4Y2DSr188N2W4TAvv5gCts+9Ax3TqpcM3+/zIbiEuRxUaL9fnkHnuWq6jVCyT3FoE5plvoa5ppxbN/7Z8cdnEQ0mRfj22sSELnfL6dGVUWSni4Gh674/dVCUGy7aX+X6OLBYzlo14SJVgNPvq/fCiqUVp664mcQ1XAxMtS5gJlPtHslcbmoHpeyddXvRxieoUzicfXRFopC7TpUAbKKOOHaOSlRKaD4uSZsAd4k9QTLRqKWw4MI45tCYpWRQkLKsTTgHd2IkowVrp+IoRcPulIZyQGFRFwlUkGrdPpthygg0vrNTSmXKDfn4/+8b2ZzViYr3+YCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CHE6V3Alhcj3aU/nCQ7wMTdZmrXunKB0mvtxKK/2SE=;
 b=DLz16v0AWqcDCDBzHQe5LaKAwKEOuz3apsQTQUSNplOyfMyDTJaZodfx1TlkS6RrOd2KaMEsxdzN8Lv3Ek17Z5Den1x+xll7irYPC713VX1sz3jbmKKSFIFMpZYrS7GugIDVs+U8WL1+LHddTxlu35z+1qrQoed0gZr7UC4G7HjyYd8KvHbVLQ/jLHXO428nw3jVoSr7P2cOMRDWomZPIwXnxt+sGixotOFUd8QLgq0QM6WIDNlixlxjK/yiZkQsWou92jkZSg4DsZdIxQJ1Xu//v4UuUtAWTd+sBQWZGrA9fWisZpsFSNbzECbezinqH5/VxgAbFuLeLNStNsz7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH3PPF307806035.namprd11.prod.outlook.com (2603:10b6:518:1::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Fri, 3 Apr
 2026 17:07:47 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 17:07:46 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: rafael@kernel.org
Cc: aboorvad@linux.ibm.com, christian.loehle@arm.com, dsmythies@telus.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sunlightlinux@gmail.com
Subject: Re: [PATCH v2 1/2] cpuidle: governors: menu: Refine stopped tick handling
Date: Fri,  3 Apr 2026 20:07:22 +0300
Message-ID: <20260403170722.575573-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3341782.5fSG56mABF@rafael.j.wysocki>
References: <3341782.5fSG56mABF@rafael.j.wysocki>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI4PEPF0000012E.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ad) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH3PPF307806035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a05359a-acc4-4a73-8728-08de91a3870a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ezZCVZvpE9srFpi4s4SqULH/6adN04BYJg7AZ1dcXsFF9uFTazLVmKdMA5phYVc5DO8jUDBK9A90mtFYbv+uzCTo8fGMzTUhq6XKp+9MWAkcYdrr9Dnk+ODHe5P/XGZS+ICwZr6zqanPDZNYW3EnZaXhlfSUwlIGpCTBqVefj809BvBXK993l4YoayaCA4P+6KzjNFO258qXsHJSKXMvG0pFPkBlC2qap0q0Nf2ttEslU82uRmqxxxMEhXHN+Hl0fEKMpoxeb4IuR86xkO/9NzyHvRdoF0QE80JwB9QlY2OAUIcrdk9HmUBfa8c3LK31663Pz2APPhkmb1xxvV1Hw1quxp1eqJInFXmb8p9TlOF/ZcALfbNdWOopxm7IKGKmUY7r3mxlJ2ZOlza5s04eflnfRaFNIt1ILd9/kv1kUDB4WUQnXjfxj4QzhvcAOh8KPHyt0hmqNV00LtA1RNhMYVx5+eLJzatIcg/ts6/1/X6dCxYZN2HqEGIu9cB69eFo3UPBd4TTX8KRbVnIcwXQpmNJ338DBmugDPqk35gRjY/EQ3hepT7UDHXOAri7KbeOnjAEW0m1B4XYoidmHDLDoDI1LxhCgpgB8sdWLEI0862ehc7iwgV/ilXh7QkvxxR5as1NTNutqd1duR2yYSzDeExIjtQ5yTxiZq5lOCdwGXyJws0aCJJi3d3uXDgvMlsqk/HzJEwL+kJOJUu2ojuGFGdjIF7suGtI5pY64TYy3bulALg1ZLesgnhiVt3d2ueS+WVWsqKAek5v11SaTgqnhR63YP/jg+f1oMHgX3iFb18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMT7XunseOrxoxmzY+oNfiF9iF3EtR/Kt6YMgmKiHLR34z4QRa5dDIlRCarE?=
 =?us-ascii?Q?RkD/xvfkJnE3Z+s/TnzzebMLeqzgN2nf+K4e815TgWF1wlLgv9zAUoOrrkgT?=
 =?us-ascii?Q?jXWaa27ew/m3x02Blny8iF5jWvcBXRESa3ZJXrfrTIDheqfY0Zs+CnGrPg0m?=
 =?us-ascii?Q?/qYJ9ZDpc8JlHzcJqulVvBQuRk9WSd1XVSMsAROJmPneeMEYp0m7BkGBAV94?=
 =?us-ascii?Q?Da6mh5ZtnBVlzjYy6bVEEvfkJy3M12Q5BS+aA8Eln6zOTAuOWRLoRJSIVGHU?=
 =?us-ascii?Q?VYP+hQI3JEevx5V2B8qAX+cpYRf2vV1Jj/7urtIIxeI/dDvNpYPFA2LFe9UD?=
 =?us-ascii?Q?YiHjwyqN80p988iuO4P1O9TZ7oFqkMWbaWOmZGuPYdT9ORbLsBV32wKscwo0?=
 =?us-ascii?Q?MrHG8iqzfAgJ7k1lzutzTRQjGtHksidjOrg/BN5xkA/KQuvC+kOINFmtvC9z?=
 =?us-ascii?Q?MP3v+mfK434o9viUJ6hbOPZ8Yh3kv3P6KCWDEUvAssPsTl+/Zm4oiuIsymdq?=
 =?us-ascii?Q?EIVwCW3MT6jF08KLIRZ18ADH5DKH7eBuHkdegwKj7ZBJKdr/l0C59E0dkMJ1?=
 =?us-ascii?Q?i+hDjTrmD2iGluAtMp9ptUXFT68EETYrDQBf/9EM2+TjwQU5UeLDr7rrhbu3?=
 =?us-ascii?Q?Hp+AS/mnfYB9XbebrHeUiCOmF7fqC3iJ4OUTVtxs96aKemzOYZ5cY4YDqC8S?=
 =?us-ascii?Q?QlC0enI8jv9Xozut6u+qpQLoqMSdkIrjVMWx5QhQx+sukVKxYfWXOqe2oObS?=
 =?us-ascii?Q?hBwJ9bdhHMsWTq6py3VmrzrhGkHITdstasZ65+rOJ40u4OgYOkbPd+7L8MD/?=
 =?us-ascii?Q?vx6qcVmdZq0AclK5rFiUlHJbb2lrrf85AxK6mFdDrjQrtdKKMKSfWs7rwr3D?=
 =?us-ascii?Q?zMhXLnFWFw/uSJi+O/6xgmsIAeXdK20DMJuAIPxVRJ7ZIE0jC8dsUaaa3fov?=
 =?us-ascii?Q?eswfErQ611On4Aglh+BCW5a/kZyYd55hyTqY7kk7rpxGZNWctwBiiqFpsowO?=
 =?us-ascii?Q?m2C7SkZJbSz/d09VFDatA8berDgd1svUkX8QRueE1Uk2rcTCnCPGiRmAr/Em?=
 =?us-ascii?Q?+R1B0p93iiXJgBHXcEhTf9Uy9sG5owOD9uqSiN0pBMBeh9KUw5hwYOjhXHOG?=
 =?us-ascii?Q?yD6iCHgIpV2l+5uRHV6VKErB0+kMeF3rNfcfNVuGU9Nf6R9WIlr5qt9d/0+B?=
 =?us-ascii?Q?lpZvfrz0h3A6SOoxlrqnJ0ogOpXpB6ak4HmQBKm2IuA+lSywbVKiG0pbDgid?=
 =?us-ascii?Q?Wi+OanRFkza1QgmEOL3sEnAHQBUuPhEk744Oinhe0deynOrn3q3yDuPqJ9Z2?=
 =?us-ascii?Q?qNPSayVl4DIaM5Udqk2EZIrm7vZn5p2L3qU3D5v+LJvc34GTObiO573NRPbC?=
 =?us-ascii?Q?5igWrOqn7TfW5BhxO0qXwUCrKdJOKDgl2BeR46KR/o9xyGIMBgOfnQ8Jt1uZ?=
 =?us-ascii?Q?Oh9E+mNB9lh4u4gHnJQYQ6loIljcNpgChey52HTR/uWBokknlnscXPxQg0kO?=
 =?us-ascii?Q?3N6Uibb+lahfeOMs7WSnRoe470QTiN5pMeyw3AJEWpY1t5mrBTv83fv8kUys?=
 =?us-ascii?Q?Havllj3sJEpfdGQNa1mwi9jEqP3ZN3PWfOm6AW0X8XQzUZPGzxdIWbShxtPM?=
 =?us-ascii?Q?yraART6s4/iMFOAVj5FvMLnvittyfl6UZ0K9veQEeTqvMCEJOrHE06oXtxUJ?=
 =?us-ascii?Q?iWHDdaW4GgXb5IumpPVJTNbuSQlI5Q1CcyHHuFyn1pqA1v7DR4QIrxMv5uoI?=
 =?us-ascii?Q?LnOD/IuYa7ayjk5xBijHWY6+CDSkKuU=3D?=
X-Exchange-RoutingPolicyChecked:
	ZIc79vQ5ot3ijdSwT4C73L1chlPD0EAm0S28fUdgoNVDW7C31zsa+hoL895gaTOSbQ6dHXJGJyaxpBSf1zalEsOTOMbckAdYAIbFQ3UoYIO/sviHktPq81wp6UKewh2nyudFDnT0SiBvwEFtkiOS4MMhVt6b2lDE4SLXiOiMIohi5SEvsMSKDFfBm4rWZSc3WvaUwWOch+c6YP0RIH/7lXmY02vKJQDzpGRryUCeoJvYiZCBoQweAXEu4G9Xsn1w6xPfelK+bfCea+UrPkCZzpP8QMz0qJQByCjuNlmNKH0nTYuE91lKRDDsVdo+9VWljDFRfLjlUagBfoJe9+XXEQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a05359a-acc4-4a73-8728-08de91a3870a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 17:07:46.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqPzBYlu84FNyoqLyq5DIapfUAaoPUt2QdvpMOVW7h2mye4OfC/yebGo4o9gZk5G4InHgujLq4T5n3ngzcq/JcD1TVBpHZoh3b+12wD2JdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF307806035
X-Proofpoint-GUID: zKt848XPEiuuhnPmf3gtL3sGHE9PfkU9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1MyBTYWx0ZWRfX8QP95Hi0naI8
 HyQx9nI91vea7mBqdO+MJUSjgDSuL27cyy0ern1eFFL0DXed4PXBoJW4QOOuCelao9POyZn5ea7
 6TTu1/uMT5qtg+ftRKJgyfkIkCCfDfVC9HQlejsfMH8wMDtK+2Er2pEB+XJrq1zGm/LIsMo1Bsu
 NJZaZKcv5GTk4jAc9hwC5uucajOI8IJ7o5IbJF7Cxk6qfdetEmRr7uNBKwgCPuZLQcSj0oJpHSK
 Kyx7NPQP7YnDnVnEL1xMk6ai31rMTQREpmN/3LQB+8n6WtpqGbO9gY3+6FuWxUcAci3CPCG6Bib
 daviM3h6wXtDO8AcYob83XONsXrgrKRRxxelD4ksDumuyCo23Egq0Q8LtjpLWfzjt1jp6wpOVbp
 0ceZ2z1CUkX3oMjb5lCE8A2VWOsw2rKmRjvdypsMjqXis1Aij5su1vEOUZ2JDpzTaQtAsNvbdpL
 /kTPSKwKe+KTpGFiiSQ==
X-Proofpoint-ORIG-GUID: zKt848XPEiuuhnPmf3gtL3sGHE9PfkU9
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69cff3e5 cx=c_pps
 a=z4Cvy7J80qD6KqIazgzwmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=pGLkceISAAAA:8
 a=NTM3MBKb6arpASKX1lgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030153

On Mon, 23 Feb 2026 16:38:55 +0100, Rafael J. Wysocki wrote:
> Update the menu governor in accordance with the above and use twice
> the tick period length as the "safe timer range" for allowing the
> original predicted_ns value to be used even if the tick has been
> stopped.

Tested this on 6.12.79-rt17 with isolated CPUs (nohz_full=1-16,
isolcpus=nohz,domain,managed_irq,1-16) on Intel Xeon Gold 6338N.

cyclictest --priority 95 --nsecs --duration 600 --affinity 1-15
           --threads 15 --mainaffinity 0

Before (6.12.79-rt17 without patch):
  Avg: ~1780ns, Max T:3-T:8: 9300-9700ns

After (6.12.79-rt17 + this patch):
  Avg: ~1790ns, Max T:3-T:14: 5200-6100ns

The patch reduces worst-case latency on threads T:3-T:14 from
~9500ns to ~5800ns on isolated CPUs with nohz_full. T:0-T:2 still
show occasional higher spikes (9400-10700ns) but the overall tail
latency improvement is clear.

Tested-by: Ionut Nechita <sunlightlinux@gmail.com>
