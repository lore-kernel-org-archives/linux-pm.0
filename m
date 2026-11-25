Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795590375;
	b=OD7XO0jToHTV48dLocuTJ5EAWoH1JXx6GTXEtdjXlpMP+BL/4kpj+WoExO6QtrJ6/slC
	 TGNkbYa/bxr1rR6Rgkkct0rF3BAPFjb5elIFmsnnALgPMjQnk+RVjJGqB9OVMyQ8Jdau+
	 avZ/kL/VkGU7rrtpOCvxizsACR4sQGwKQHZ3aqhLHpyza8PuWrdS/0rl7+kstuNIvBPQU
	 rN+UcjmFxlZec9FOZQjR+T/N1H6biUioN+Xb2oJOndj0feJbbfNXnfN5Uf4HVtpXMvnfj
	 V2e5YWz6fVC/FSuZDCbsX3T0Q7JPDIH6ahm1/Wh6zk/KTiGnC7yt8U+LC8vCZ/V7szA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=g3COIQnjMJ4GcKxAOqie7gvN3r2Y85WLM/TFpmBap3Y=;
	b=xCA4CLCFnjrO7eIEo8hEtd2HxHXWaM3P+JPH3PDcFibyNZuCixkOsURDzbvknayosuu8
	 GSSZPsNvxP7RLmRW6e3C5CZzFBjVgR4rtMfUlF5YWy7S7rXPKQiEReILkT+r+w2IIg8MR
	 fkWO1UHfVFlaeCoRch/UG2/b3zDL6l365Q9E24CXIjsH16vg/BEz7sfkGo/Ydktnvi0Lp
	 9J2h1M+NCmbAGTcILzUs5jaPj00DvEysjKevLcM+zyVmgtmmo+j338w2jHys6YlnOqyfm
	 2xxfV8HMd4efdbm+/ibUwh3+8OI0V4FhiWuxUM/IX6uoaYr7MWPnl0MByFyjDcyaHfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QmqfKmQW;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NX1AlQ8r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885B606A68F;
	Wed, 25 Nov 2026 07:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5885B606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QmqfKmQW;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NX1AlQ8r
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AP6BBEw069451;
	Wed, 25 Nov 2026 01:05:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=g3COIQnjMJ4GcKxAOqie7gvN3r2Y85WLM/TFpmBap
	3Y=; b=QmqfKmQW0O2/Am5KJcOwr7qGj0qVub5NkqTbJwf6w5SNcWcuy1zBzspxi
	UNd1SjZiZqemVEyYgjjb6U1nHz9oMhTiBxqLlGySzYCLvxLpvuujObqQ8XIlTWHJ
	i0fH64s+9UMsdTOOa+71VD9lP+qdgYE8IrdwwnByfxwpenwjedbsDE5SIYhaY1oS
	wc4c0m24lUwifDjQ6pY/Rn5cJT9mUCv921PePXIrv97b9uh6HOUNQzPBIRDQ4paQ
	gW/J4e7DEF/A+LTkyT8glfk5J+zsoJ9a+zcCeEGo8aJirdMFARqUfFLF87jAE63R
	xFoSYUUBU5lhq+pKmnLfusA860TKQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by m0380145.ppops.net (PPS) with ESMTPS id 4j5j1rtm2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 01:05:33 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgQCXa3eFeI8IugXtQEitRABrptrSDuZqMrbvKzhzG+FeW8J7mbnQ0AloGViJ7ZbF8XzSk/KHVNPR9hutGy2ZAiqSWzDxG0IGPULh7LuzfZ6hLuBWrwufxeupVge4d1v5xXAkNRr0wm6D4fCe7MExaM6LA0f1c82yRwPzOxKXH/+3Ddd85vNU57i9i85ILkpvJhw7nkGhTlbl0ejs+sd9FPP2MgtFQrnkd8HOQ9g1M0FyYA4OcftdsUBJp+QGbaQQ9ZheeFF20vuhYxZiN6/g0hKJJkrbxHI6mX21pWOnZGkPU9EMgbsW8Lj6rfKp7GTu+F0Hz76/sDVkALroiK/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3COIQnjMJ4GcKxAOqie7gvN3r2Y85WLM/TFpmBap3Y=;
 b=It/oSOY1wRPodSHWJHZD1Sxz5khrB0UCATbpp+ifaVU5FJaOm9iMdig+TafDl2adLTANvVU3fOfwRki+k/0hgaVjJPQRZ3LS7N/EeM7oSXXFe1EI/1thc1X9LD/nmK6b4t+R+nHVPtlZuemnbeMgarnW1IxJmMtJdNTieAHLakWsixkoR835lGecKS1PcIKougSs0wLyRcDSmibf/xi6QaB9mYMBpLaqp5HRl0LJDcs7FZv8dxzTLrR+mYZguCzRkvKJ7euwWPqubkS8KdTX2GMtoYxjgUZHiZejHctKwwvIIi4WHm0Gia2OsG9gEarGOQDn4ItcAz+Go2HrQsjE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3COIQnjMJ4GcKxAOqie7gvN3r2Y85WLM/TFpmBap3Y=;
 b=NX1AlQ8rxOz+j6OXOsQ6n7vNIboa/+knnMgsIxzr7kNyaJKBH6WqIky6kMkhFFGxFOZVFijN+kup8bYKXNnC/SzSPZlheUZOlK8Fa50iM5PmVuKGo66SAb7iN4V5pKhx1kfgHsSuNpencMaG3sBep4ZLwJq+XH9IhDtIxx8hVl0=
Received: from SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d2::19)
 by MN2PR10MB4174.namprd10.prod.outlook.com (2603:10b6:208:1dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:05:31 +0000
Received: from SJ0PR10MB5565.namprd10.prod.outlook.com
 ([fe80::31c6:5383:712d:a1c5]) by SJ0PR10MB5565.namprd10.prod.outlook.com
 ([fe80::31c6:5383:712d:a1c5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:05:30 +0000
From: "Kochidanadu, Scaria" <s-kochidanadu@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson
	<ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams
	<clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC: Maulik Shah <maulik.shah@oss.qualcomm.com>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: Re: [EXTERNAL] [PATCH v2] cpuidle: psci: Allow domain idle states in
 s2idle for all CPU idle states
Thread-Topic: [EXTERNAL] [PATCH v2] cpuidle: psci: Allow domain idle states in
 s2idle for all CPU idle states
Thread-Index: AQHddu+cdndHDBO5xka/vMZf3gVP3rc+aNQA
Date: Wed, 25 Nov 2026 07:05:30 +0000
Message-ID: <3d3924f2-9fd0-4ca9-acc4-aa82bfb2f6e5@ti.com>
References:
 <20261117-topic-lpm-psci-domain-callbacks-v2-1-744884105846@baylibre.com>
In-Reply-To:
 <20261117-topic-lpm-psci-domain-callbacks-v2-1-744884105846@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5565:EE_|MN2PR10MB4174:EE_
x-ms-office365-filtering-correlation-id: c6505628-e832-424d-4ca7-08df4ac27db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|38070700021|10067099003|5023799004|56012099006|261021130227099003|261021123027099003|261021121427099003|261021133027099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261021135927099003|261102123227099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261028144727099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|22082099003|18002099003|6133799003|3023799007|4133799003;
x-microsoft-antispam-message-info:
 pixJsr4p4LofHPBCjIIMi+xNmcVRSEmTLC+UyYMvXlgxQ2qzxORq+jDtoRForGw+rZ9dpkUfQ60PfC2Ov6cmLYVZ6ERvOAIHo5nkK/oSY8jZP9Dmlcvqn1CmsN4+Uz92reOFXbPnpXPS33nipiSXidFYzxXbqd1vn9+fh3UjCPG/Uz0ALzoLAbf4KcFFF+8qPbisVh6i9vJ6rDTfR70Z4DatEAO4VCltMDA20TPMPwsRUSbTFEHVZMvirOBDBj+J8Kp8W8OHWF+VIuCjkV1zmQ3pj5YPxJAm7O9ZUkv9W/yPwdeGhSeNFhLurSSU5lnhsA5SJXOwXXOdwWWkW1u3wYlhpbqqcaDLIw+MMRdOuYdnGLFb3sKc06OYFUggq9hXwpBHvldPayNgqBNVHne+CPLPbx9YfdoudeDULn7sz4eCUeoPne5MDxvx8++zk639rxWP58uUQc2MW4es4FwrmiLE3ayjWsvQsoircZMc89HF8DGsu1rNXuetonlZnlZVa6NeCCBo8ixqhcQXpVTnHM0kWnEhX1DWROHYwWwCV96j9L03E9g32ShzS9ktB4IETc8Wns9ulkRh11OWPNnaooEbilTWEGbo9mVQjNu4F9UZeoNduYrZVyvLGIwM20jaLZyWphgfGMA6Ptwrm+4792kjGZo5TUytUslXvWfmTRPmwkiAwubQECJWcd9UMeWi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5565.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(38070700021)(10067099003)(5023799004)(56012099006)(261021130227099003)(261021123027099003)(261021121427099003)(261021133027099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261021135927099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(22082099003)(18002099003)(6133799003)(3023799007)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0lvSUQrVEptRkVGR1lnQXZuSzU1WkxJZWpYNlREK1JZcXNOYkxpOWxtZmR5?=
 =?utf-8?B?OCtFVXBKMGd6UmpwUHArckR2ZU9ZaGNrdis3T2ZZMmUvTFFZMXRJNk9uUE91?=
 =?utf-8?B?SlNZdU8rVWpMNWlXU3AvN1JxQms5Z1JYemZnQnk5NnBRUkt4clRhWTZCWDI1?=
 =?utf-8?B?ekN5czVJUEh1bVRFcXZYKzdKckxEZktEeGpkRXYvR0JJTTVMU0EzWmI0MFh2?=
 =?utf-8?B?Z1dwSkpwUDUwNFdPbllKVjd5Qm4xRm8zMDY1SVlrKzN3WXNBK3hSTytkcmxr?=
 =?utf-8?B?MVBrZ0kwa29sRHloaEpMZ09lTGJBbGN6SWJrelorZStRT3p3RUljOFcwMENz?=
 =?utf-8?B?QmN5UmRZcUlXWi9FeWtRZUlrdmtvdEttTm9ueUhDY2FLcUFmTGl2RVhFaER5?=
 =?utf-8?B?d3R6Qml1eDFxNEVyNDRaUFVobXlLdHpNc3diaW83Z0FSZE9IZ0RiZFY3NGVo?=
 =?utf-8?B?aDk2ZHdmMDg5SnZtL2lKUDJ6NExZYXUyaHNsYXQzOUlsN0VKZWRSZ1FoNGtS?=
 =?utf-8?B?cWtyQ0N4Wndzd2dUOXh4c2JjUGNZdFlLSzMvVjZlVERNRWxTc0xqTjZ1Y0NZ?=
 =?utf-8?B?NHRzWXJZbThqeGl5YmZLMEE0SVJ2YUU0RFVtSXN2QlIweEdmODE0QzY2bHVl?=
 =?utf-8?B?OVlXTWtSVzQxYWJ1MmcyV2ZUbUsxRytpT3VNbG5jNnRHcWY1M0MxK2pkRWVQ?=
 =?utf-8?B?cDNtSU1UUlBtYkFaTFpieCtEMnIzam5BQkpnUndjM2JXRWthc20veFVITzMx?=
 =?utf-8?B?cmZYNVBZa01zSGRYYlEzOUFCeGZWVFBZU1p1cDlsY1pVa2V5WUhVS2w1N1dy?=
 =?utf-8?B?dGVVRVM5bzFHR0FKMVBoRXgzUHVFOHJydWtiY2t6Mkx6WGxyNUVvZTZ3czVq?=
 =?utf-8?B?VEluZy9USm9raTlYdldocjdwaUlIYmh3dW9KNlpsUGJ2T25pVm5VRGQrNTFo?=
 =?utf-8?B?bDJhOEhpUFMzYUdjd0xKRTJBWVFOWVhpcktlSm9LZTFCR0hUVndHZE10NVpM?=
 =?utf-8?B?eTM5WThFMVA0di8yamo3RmtzQ09MOEtJUW83RnB2NlQ3S2VLcXM3Nk5mQWR4?=
 =?utf-8?B?UWFvK3Exa2tqMGFiOU0weko1SDdnenBDN2hlODhXaU1PTWJPb1dUcWJPbENB?=
 =?utf-8?B?VTRjcTNuNHloMENXSjlTRHhLUWorMmFadzdXaW1GTDkxZFRjVW5Xc2lic0xD?=
 =?utf-8?B?ZkJpNWlTWEVLek9PeUZGM1Blc0lWMjJqME5EYlFqZ2dWQXFHcUpMdFFHdi9x?=
 =?utf-8?B?Tmt2S1piQ1ZWTUdlQXIrOU5MUUsyM3REZjVDbWFidU1XZXBhWDNWaldjZC9D?=
 =?utf-8?B?RSs2d3ZqZmNOV0JsbkZkSFNBWkNaamduWFlmQS8xc3JlUUEwcjJ2ZVhxSHMz?=
 =?utf-8?B?Ukl5LytSa0hjYWFtSDhKS0xqZ1h4MU9LZi9ya0FOenlNeUwySWRtcUZQbytv?=
 =?utf-8?B?L2tsYUE1MVVqdmwyMDdabGp3WXhkalR1TGJqTE00Y0Y1M3BvMGdCRTJmSW1E?=
 =?utf-8?B?bXJ5K1VhL1Z3RFlxanpjMzFEMU9SK252M051czQvTURpSldRSVRTTW83SUlv?=
 =?utf-8?B?aU4yNDJ4RFNUVUxjUEJtNkxaM0t3a0RGNVcya1lFOG9PL0lLci92VEJmYXZT?=
 =?utf-8?B?MDVJaFJQYmFEVHpaLzMwUWZ4TzBCVllyTG5VajlOQ1ZOYzBrZWhaZ05GbVdY?=
 =?utf-8?B?L29uUWhOQzhRc294L09JSzlmSjNEZHlMQ1BsNDNIQ1hjYXJnU2NCUHhUVGVY?=
 =?utf-8?B?enlSMEkxS3oxWnpROEh3R1d4OGZJTFNQU1ZvT2wrYXZMT1NSNk5qamdXdy9x?=
 =?utf-8?B?bGwvUldRdlc5WFAydUU3TVV5eFMvNEdUNUtjUVljbkVNL2V4UkR4Z2tKZXkr?=
 =?utf-8?B?ZzBnS20wQTg3aCtMVUFRcEZNbThsc1VqbUg0RkZMdmo1OFppTVVxVGRBaytn?=
 =?utf-8?B?N0tuWkJlMTV4M1hFckFicUEySlBRK1p6NURraUtRUEdqSVU2dG4rM0lEMDl3?=
 =?utf-8?B?K0FkM1h2V0JFOUNrUy9jVTJoZm9TeGxEMDlnUi9ra1h0MjJDUHdtanNyRlpK?=
 =?utf-8?B?SXhFb0J4RDN0SENneURWRENUV3FkYnl5Z1FqV1NvVys3MUlzTDNZQy91V2Fk?=
 =?utf-8?B?cWdZejQxYStCMmdLTEVJdysvMGlJUnJ5N0pXWXRPQjlaaE1HRG95bkR1WXNV?=
 =?utf-8?B?YnNpTTR2VXQycThmakpJcjFUTHBFM0tIdTlaUVNSRnFBclZzV21HVmU3cDdU?=
 =?utf-8?B?cUh4dVAzbW9yVEIvNWx4aDI4QXlhdHBqZndXK1VIUWtBQkdrTEZTcE5ycS9t?=
 =?utf-8?Q?2a66W+hy+FEVLkJRX8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A9BBD74201CCE43BF6FB64F0C681093@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SVNeWLGBoZvC06veDmYGIxUaNaWbqdCkZ4JK3PoIudjSG6osJqCzNn5LGHj6myBSlOsgA0GognGHK/5BDXwHF43yDDkrHmJTX/IrxWSQVrVozZDju4tgHl1G6s5TwTjQGymBnEvI0WFkfaGRZyiw+DXn/uZZhamUHp44alkepeNv8cimetbHUUPrFx7IZMeIixf1NX4dI5I5TozyLIiyXmvOz5q0Kuo2VXGSQ1WVBDihFq9pFa36ZHSI2e/H3fv9/1GTnQzag5D4JBWJy92YvIiTdLgJwakXPG+ILXeeoyj8c6Sp66URtUVjpAwOmZg/uAcdmny2GIJws/6ta7aKuA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5565.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6505628-e832-424d-4ca7-08df4ac27db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 07:05:30.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcKQdzCCHMiO7J5yWR1cEVbLPiETJiKe+uSZ9jUdlAD8aw1Ux0f8chCVnqvbf7XJRHHgTkSZX7rRV8iVV2ZJkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4174
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfX1IFllnXYo5/R
 8bXR2zhziv5/+LyekDpBEDuHO2iBEIIYU4Jgt8cGNKlCyUBiAmwp6zm3SsXxeLTTFwGcJ2l9ETw
 wXK7VKoCEUDWcu07QTRnA6bGbCHp8mzzheTqx64iCkqhCZsYNyevz1ZD9BIz/m6vhTsra7VTsDB
 f+4+fM2uD/t/B0rmoX9b0928n2fV9dOp2TVx2555A8JH4uK/l/iSub8qtXBpfSb0qmLiddy3Ix/
 uykUTINJr+SK0M1sN1E/M1dMNzWW2oHSdIA7UwX04Uhldg1mSoS4isZKd07bLjEiBYaoAL5uDub
 ZPkCBtGF+pIGwAiYASRu95ekn8NI74CjVaHvmMF4lXuSizbhMYZYHa/nzu4ZZ+5OdwfmuC/D3wy
 bEuCOK6isEeJ5dsTTbfOVuh1zr4h3fAuWMT69+AcQce9iSAHk+r7/01UA8H2dDaxiPsyvcoYK/f
 6rtVafpEkVjp3m8jfXA==
X-Proofpoint-GUID: lLXwMntBTR3om2Y4MDEnM6GlTQSKDCM0
X-Proofpoint-ORIG-GUID: lLXwMntBTR3om2Y4MDEnM6GlTQSKDCM0
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6b0688bd cx=c_pps
 a=cRSuPULe8LMj8fTR+fkUeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=HgE2TJAPUa6lmHlp7pwA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfXx4iftDUlPrmx
 9bZieMj/2j31eXdoQF6eCPoRYcgqFvl6NK6RQRSNxumgceEYywSQ+RMLFfqVvDjGoP3gPiNmf7f
 /848oVjf4VY6XAI+A3bwewpiw+P9fW8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250028

T24gMTgvMTEvMjYgMDU6MjgsIEtldmluIEhpbG1hbiAoVEkpIHdyb3RlOg0KPiBDdXJyZW50bHks
IG9ubHkgdGhlIGRlZXBlc3QgQ1BVIGlkbGUgc3RhdGUgaGFzIGl0cyAtPmVudGVyX3MyaWRsZSgp
IA0KPiBjYWxsYmFjayBzZXQgdG8gdGhlIGRvbWFpbi1hd2FyZSANCj4gcHNjaV9lbnRlcl9zMmlk
bGVfZG9tYWluX2lkbGVfc3RhdGUoKS4gVGhlIG90aGVyIENQVSBpZGxlIHN0YXRlcyB1c2UgDQo+
IHBzY2lfZW50ZXJfaWRsZV9zdGF0ZSgpLCB3aGljaCBieXBhc3NlcyB0aGUgUE0gZG9tYWluIGVu
dGlyZWx5LiBEdXJpbmcNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0DQo+IFRoaXMgbWVzc2Fn
ZSB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgVGV4YXMgSW5zdHJ1bWVudHMuDQo+IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBz
b3VyY2UgDQo+IG9mIHRoaXMgZW1haWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
UmVwb3J0wqBTdXNwaWNpb3VzDQo+IDxodHRwczovL3VzLXBoaXNoYWxhcm0tZXd0LnByb29mcG9p
bnQuY29tL0VXVC92MS9HM3ZLIXRaZHFYUmZQdGswN0N1WE10enVJOXRsNUV2dmlValQ2bVY0WUlX
Y3AwdEFMNXJLc3A1RmQ0c2N0ZHpLTXBnUVJwOEc5WWJMM3dBbmQtMHJlWDUycGNFaF96Uk9WX0Na
blFTRWxpaUg3NW1tblN2OVRxQXN4cEpxYTdieGZDMDBYSTI4JD4gDQo+DQo+IFpqUWNtUVJZRnBm
cHRCYW5uZXJFbmQNCj4gQ3VycmVudGx5LCBvbmx5IHRoZSBkZWVwZXN0IENQVSBpZGxlIHN0YXRl
IGhhcyBpdHMgLT5lbnRlcl9zMmlkbGUoKQ0KPiBjYWxsYmFjayBzZXQgdG8gdGhlIGRvbWFpbi1h
d2FyZSBwc2NpX2VudGVyX3MyaWRsZV9kb21haW5faWRsZV9zdGF0ZSgpLg0KPiBUaGUgb3RoZXIg
Q1BVIGlkbGUgc3RhdGVzIHVzZSBwc2NpX2VudGVyX2lkbGVfc3RhdGUoKSwgd2hpY2ggYnlwYXNz
ZXMNCj4gdGhlIFBNIGRvbWFpbiBlbnRpcmVseS4NCj4NCj4gRHVyaW5nIHMyaWRsZSwgdGhlIENQ
VSBpZGxlIHN0YXRlIGlzIHNlbGVjdGVkIGJ5IGZpbmRfZGVlcGVzdF9zdGF0ZSgpLA0KPiBjb25z
dHJhaW5lZCBieSB0aGUgQ1BVIHdha2V1cCBsYXRlbmN5IFFvUyBsaW1pdC4gSWYgdGhhdCBsaW1p
dCBleGNsdWRlcw0KPiB0aGUgZGVlcGVzdCBDUFUgaWRsZSBzdGF0ZSwgYSBzaGFsbG93ZXIgc3Rh
dGUgaXMgc2VsZWN0ZWQsIGFuZCB0aGUgQ1BVDQo+IFBNIGRvbWFpbiBoaWVyYXJjaHkgaXMgbmV2
ZXIgcG93ZXJlZCBvZmYuIEFzIGEgcmVzdWx0LCBubyBkb21haW4gaWRsZQ0KPiBzdGF0ZSBjYW4g
YmUgZW50ZXJlZCwgZXZlbiBpZiBzb21lIG9mIHRoZW0gYXJlIHdpdGhpbiB0aGUgUW9TIGxpbWl0
Lg0KPg0KPiBGaXggdGhpcyBieSBhc3NpZ25pbmcgdGhlIGRvbWFpbi1hd2FyZSAtPmVudGVyX3My
aWRsZSgpIGNhbGxiYWNrIHRvIGFsbA0KPiBDUFUgaWRsZSBzdGF0ZXMsIGV4Y2VwdCBXRkkuIFRo
aXMgaXMgc2FmZSBmb3IgczJpZGxlIGJlY2F1c2U6DQo+DQo+ICAgLSBUaGUgZ2VucGQgZ292ZXJu
b3Igc2VsZWN0cyB0aGUgZG9tYWluIGlkbGUgc3RhdGUgaW4NCj4gICAgIGNwdV9zeXN0ZW1fcG93
ZXJfZG93bl9vaygpLCB1c2luZyB0aGUgc2FtZSBDUFUgd2FrZXVwIGxhdGVuY3kgUW9TDQo+ICAg
ICBsaW1pdCB0aGF0IGNvbnN0cmFpbnMgdGhlIENQVSBpZGxlIHN0YXRlIHNlbGVjdGlvbiwgb3Ig
YSBzdHJpY3Rlcg0KPiAgICAgb25lIGlmIGEgZGV2aWNlIGluIHRoZSBkb21haW4gaGFzIGEgc3lz
dGVtLXdpZGUgcmVzdW1lIGxhdGVuY3kNCj4gICAgIGNvbnN0cmFpbnQuDQo+DQo+ICAgLSBUaGVy
ZSBpcyBubyBpZGxlIGR1cmF0aW9uIHByZWRpY3Rpb24gaW52b2x2ZWQgaW4gczJpZGxlLiBCb3Ro
IHRoZQ0KPiAgICAgQ1BVIGlkbGUgc3RhdGUgYW5kIHRoZSBkb21haW4gaWRsZSBzdGF0ZSBhcmUg
c2ltcGx5IHRoZSBkZWVwZXN0IG9uZXMNCj4gICAgIGFsbG93ZWQgYnkgdGhlIFFvUyBsaW1pdCwg
c28gdGhlIGdlbnBkIGdvdmVybm9yIGNhbid0IG92ZXJyaWRlIGENCj4gICAgIGRlY2lzaW9uIG1h
ZGUgYnkgdGhlIGNwdWlkbGUgZ292ZXJub3IuDQo+DQo+IFRoZSBkb21haW4gaWRsZSBzdGF0ZSdz
IGFybSxwc2NpLXN1c3BlbmQtcGFyYW0gaXMgYSBjb21wb3NpdGUgc3RhdGUgdGhhdA0KPiBvdmVy
cmlkZXMgdGhlIENQVSBpZGxlIHN0YXRlLCBzbyB0aGUgZXhpdCBsYXRlbmN5IG9mIHRoZSBkb21h
aW4gaWRsZQ0KPiBzdGF0ZSBtdXN0IGFjY291bnQgZm9yIHRoZSBjb21wbGV0ZSBjb21wb3NpdGUg
c3RhdGUuDQo+DQo+IFRoZSByZWd1bGFyIGlkbGUgcGF0aCBpcyBsZWZ0IHVuY2hhbmdlZCwgc28g
b25seSB0aGUgZGVlcGVzdCBDUFUgaWRsZQ0KPiBzdGF0ZSBjYW4gdHJpZ2dlciB0aGUgc2VsZWN0
aW9uIG9mIGEgZG9tYWluIGlkbGUgc3RhdGUsIGFzIHRoZSBkb21haW4NCj4gaWRsZSBzdGF0ZXMg
YXJlIGFzc3VtZWQgdG8gYmUgZGVlcGVyIHRoYW4gdGhlIGRlZXBlc3QgQ1BVIGlkbGUgc3RhdGUu
DQoNCklzIGl0IG5lY2Vzc2FyaWx5IHRydWUgdGhhdCBkb21haW4gaWRsZSBzdGF0ZXMgYXJlIGFs
d2F5cyBkZWVwZXIgdGhhbiANCnRoZSBkZWVwZXN0IENQVSBpZGxlIHN0YXRlPw0KDQpDb3VsZCB3
ZSBoYXZlIGEgc2NlbmFyaW8gd2hlcmUgYSBjbHVzdGVyIGlkbGUgc3RhdGUgaXMgc2hhbGxvd2Vy
IHRoYW4gYSANCkNQVSBpZGxlIHN0YXRlLg0KDQpFLmcuIEEgQ1BVIHBvd2VyLWRvd24gaGF2aW5n
IGhpZ2hlciBsYXRlbmN5IHRoYW4gYSBjbHVzdGVyIGlkbGUgc3RhdGUgDQpvbmx5IHBlcmZvcm1p
bmcgY2xvY2stZ2F0aW5nLg0KV291bGQgc3VjaCBhIHN0YXRlcyBpbiB0aGUgRFQgdmlvbGF0ZSBh
bnkgUE0tZG9tYWluIHJlcXVpcmVtZW50cz8NCg0KPiBFeHRlbmRpbmcgdGhpcyB0byB0aGUgc2hh
bGxvd2VyIENQVSBpZGxlIHN0YXRlcyBpc24ndCBzYWZlLiBUaGUgY3B1aWRsZQ0KPiBnb3Zlcm5v
ciBtYXkgc2VsZWN0IGEgc2hhbGxvd2VyIENQVSBpZGxlIHN0YXRlLCBiYXNlZCBvbiBpdHMgcHJl
ZGljdGVkDQo+IGlkbGUgZHVyYXRpb24uIFRoZSBnZW5wZCBnb3Zlcm5vciBpc24ndCBhd2FyZSBv
ZiB0aGF0LCBhcyBpdCBvbmx5DQo+IGNvbnNpZGVycyB0aGUgbmV4dCB0aW1lciBldmVudCwgc28g
aXQgY291bGQgc2VsZWN0IGEgZG9tYWluIGlkbGUgc3RhdGUNCj4gdGhhdCBvdmVycmlkZXMgdGhl
IHNoYWxsb3dlciBDUFUgaWRsZSBzdGF0ZSB3aXRoIGEgZGVlcGVyIGNvbXBvc2l0ZQ0KPiBzdGF0
ZS4NCg0KVGhlIGNwdWlkbGUgYW5kIGdlbnBkIGdvdmVybm9yIHNlbGVjdCBhIGRvbWFpbiBzdGF0
ZSBjb25zaWRlcmluZyB0aGUgDQpuZXh0IHRpbWVyIGV2ZW50IGFuZCBwcmVkaWN0ZWQgaWRsZSBk
dXJhdGlvbi4NClRoaXMgZG9lcyBub3QgbmVjZXNzYXJpbHkgZ3VhcmFudGVlIHRoYXQgdGhlIGNv
bXBvc2l0ZSBjbHVzdGVyIHN0YXRlIA0Kc2VsZWN0ZWQgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBD
UFUgaWRsZSBzdGF0ZQ0KcmVxdWVzdGVkIGJ5IHRoZSBwYXJ0aWNpcGF0aW5nIENQVXMuIFNob3Vs
ZCdudCB0aGUgZmlybXdhcmUgYWN0IGFzIHRoZSANCmZpbmFsIGFyYml0cmF0b3IsIHJlamVjdGlu
ZyBjb21wb3NpdGUgc3RhdGVzDQp0aGF0IGFyZSBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgb3ZlcmFs
bCBzeXN0ZW0gc3RhdGU/DQoNClRodXMgSSBiZWxpZXZlIGRvbWFpbi1hd2FyZSBjYWxsYmFja3Mg
Y291bGQgYWxzbyBiZSBlbmFibGVkIGZvciBzaGFsbG93IA0KQ1BVIHN0YXRlIGluIHRoZSByZWd1
bGFyIGlkbGUgcGF0aC4NCg0KQmVzdCwgU2NhcmlhLg0KDQo+DQo+IFN1Z2dlc3RlZC1ieTogU2Nh
cmlhIEtvY2hpZGFuYWR1IDxzLWtvY2hpZGFuYWR1QHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
S2V2aW4gSGlsbWFuIChUSSkgPGtoaWxtYW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gdjEgYXNz
aWduZWQgdGhlIGRvbWFpbi1hd2FyZSBjYWxsYmFja3MgdG8gYWxsIENQVSBpZGxlIHN0YXRlcywg
Zm9yIGJvdGgNCj4gdGhlIHJlZ3VsYXIgaWRsZSBwYXRoIGFuZCBzMmlkbGUuIEFzIHBvaW50ZWQg
b3V0IGJ5IFVsZiwgdGhhdCBicmVha3MNCj4gdGhlIGN1cnJlbnQgY29udHJhY3Qgd2l0aCBnZW5w
ZCBmb3IgdGhlIHJlZ3VsYXIgaWRsZSBwYXRoLCBzaW5jZSB0aGUNCj4gZ2VucGQgZ292ZXJub3Ig
aXNuJ3QgYXdhcmUgb2YgdGhlIENQVSBpZGxlIHN0YXRlIHNlbGVjdGVkIGJ5IHRoZQ0KPiBjcHVp
ZGxlIGdvdmVybm9yLg0KPg0KPiBBcyBkaXNjdXNzZWQgd2l0aCBVbGYgYXQgTFBDLCB0aGlzIHYy
IHRha2VzIGFuIGluaXRpYWwgc3RlcCBieSBsaW1pdGluZw0KPiB0aGUgY2hhbmdlIHRvIHMyaWRs
ZSwgd2hlcmUgYm90aCB0aGUgQ1BVIGlkbGUgc3RhdGUgYW5kIHRoZSBkb21haW4gaWRsZQ0KPiBz
dGF0ZSBhcmUgc2VsZWN0ZWQgYmFzZWQgb25seSBvbiB0aGUgQ1BVIHdha2V1cCBsYXRlbmN5IFFv
UyBsaW1pdC4NCj4NCj4gVGhpcyBwYWlycyB3ZWxsIHdpdGggTWF1bGlrJ3Mgc2VyaWVzIFsxXSBh
ZGRpbmcgc3VwcG9ydCBmb3IgZG9tYWluIGlkbGUNCj4gc3RhdGVzIHRoYXQgYXJlIG9ubHkgYWxs
b3dlZCBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgKHN5c3RlbS1zdGF0ZSkuIEFsb25nDQo+IHdpdGgg
dGhpcyBwYXRjaCwgcGxhdGZvcm1zIGNhbiBkZXNjcmliZSBzZXZlcmFsIHMyaWRsZS1vbmx5IGRv
bWFpbiBpZGxlDQo+IHN0YXRlcywgYW5kIHNlbGVjdCBiZXR3ZWVuIHRoZW0gdmlhIHRoZSBDUFUg
d2FrZXVwIGxhdGVuY3kgUW9TIGxpbWl0LA0KPiBldmVuIHdoZW4gdGhhdCBsaW1pdCBleGNsdWRl
cyB0aGUgZGVlcGVzdCBDUFUgaWRsZSBzdGF0ZS4gVGhlcmUgaXMgbm8NCj4gYnVpbGQgb3IgcnVu
dGltZSBkZXBlbmRlbmN5IGJldHdlZW4gdGhlIHR3byBzZXJpZXMgdGhvdWdoLg0KPg0KPiBbMV1o
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2
MTAwNS1zMmlkbGVfc3RhdGUtdjEtMC0zYzQwMmM2NmYzODhAb3NzLnF1YWxjb21tLmNvbV9fOyEh
RzN2SyFWbWJXZ09sVFJYWE1IbkktQVlXZndkazh0YTRjazNUT0hNTFJ5WTZpN2N0cW5FT1VKSDlt
Rks5dm5IX1RiRjV0bGJMb2I4UWE0YlJNNkZhSUdnJA0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBMaW1pdCB0aGUgY2hhbmdlIHRvIHMyaWRsZTsga2VlcCB0aGUgcmVndWxhciBpZGxlIHBh
dGggdXNpbmcgdGhlDQo+ICAgIGRvbWFpbi1hd2FyZSBjYWxsYmFjayBvbmx5IGZvciB0aGUgZGVl
cGVzdCBDUFUgaWRsZSBzdGF0ZSAoVWxmKQ0KPiAtIFJld29yZCBjb21taXQgbWVzc2FnZSwgZml4
IGluY29ycmVjdCBjbGFpbSB0aGF0IG5vIG90aGVyIENQVSBpZGxlDQo+ICAgIHN0YXRlIGhhcyAt
PmVudGVyX3MyaWRsZSgpIHNldA0KPiAtIExpbmsgdG8gdjE6aHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDgzMS10b3BpYy1scG0tcHNjaS1k
b21haW4tY2FsbGJhY2tzLXYxLTEtNGE0N2Q5NWM5Yzc5QGJheWxpYnJlLmNvbV9fOyEhRzN2SyFW
bWJXZ09sVFJYWE1IbkktQVlXZndkazh0YTRjazNUT0hNTFJ5WTZpN2N0cW5FT1VKSDltRks5dm5I
X1RiRjV0bGJMb2I4UWE0YlI0MVZKT2Z3JA0KPiAtLS0NCj4gICBkcml2ZXJzL2NwdWlkbGUvY3B1
aWRsZS1wc2NpLmMgfCAyMSArKysrKysrKysrKysrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3B1aWRsZS9jcHVpZGxlLXBzY2kuYyBiL2RyaXZlcnMvY3B1aWRsZS9jcHVpZGxlLXBz
Y2kuYw0KPiBpbmRleCAwMTg3ZDZhOTA5NmEuLjAxYTU3MTQ3OWU1YyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUtcHNjaS5jDQo+ICsrKyBiL2RyaXZlcnMvY3B1aWRsZS9j
cHVpZGxlLXBzY2kuYw0KPiBAQCAtMjUwLDYgKzI1MCw4IEBAIHN0YXRpYyBpbnQgcHNjaV9kdF9j
cHVfaW5pdF90b3BvbG9neShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwNCj4gICAJCQkJICAg
ICBzdHJ1Y3QgcHNjaV9jcHVpZGxlX2RhdGEgKmRhdGEsDQo+ICAgCQkJCSAgICAgdW5zaWduZWQg
aW50IHN0YXRlX2NvdW50LCBpbnQgY3B1KQ0KPiAgIHsNCj4gKwlpbnQgaTsNCj4gKw0KPiAgIAkv
KiBDdXJyZW50bHkgbGltaXQgdGhlIGhpZXJhcmNoaWNhbCB0b3BvbG9neSB0byBiZSB1c2VkIGlu
IE9TSSBtb2RlLiAqLw0KPiAgIAlpZiAoIXBzY2lfaGFzX29zaV9zdXBwb3J0KCkpDQo+ICAgCQly
ZXR1cm4gMDsNCj4gQEAgLTI2MSwxMiArMjYzLDIxIEBAIHN0YXRpYyBpbnQgcHNjaV9kdF9jcHVf
aW5pdF90b3BvbG9neShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwNCj4gICAJcHNjaV9jcHVp
ZGxlX3VzZV9zeXNjb3JlID0gdHJ1ZTsNCj4gICANCj4gICAJLyoNCj4gLQkgKiBVc2luZyB0aGUg
ZGVlcGVzdCBzdGF0ZSBmb3IgdGhlIENQVSB0byB0cmlnZ2VyIGEgcG90ZW50aWFsIHNlbGVjdGlv
bg0KPiAtCSAqIG9mIGEgc2hhcmVkIHN0YXRlIGZvciB0aGUgZG9tYWluLCBhc3N1bWVzIHRoZSBk
b21haW4gc3RhdGVzIGFyZSBhbGwNCj4gLQkgKiBkZWVwZXIgc3RhdGVzLiBPbiBQUkVFTVBUX1JU
IHRoZSBoaWVyYXJjaGljYWwgdG9wb2xvZ3kgaXMgbGltaXRlZCB0bw0KPiAtCSAqIHMycmFtIGFu
ZCBzMmlkbGUuDQo+ICsJICogRm9yIHMyaWRsZSwgdXNlIHRoZSBkb21haW4tYXdhcmUgY2FsbGJh
Y2sgZm9yIGFsbCBDUFUgaWRsZSBzdGF0ZXMNCj4gKwkgKiBleGNlcHQgV0ZJLiBUaGUgQ1BVIGlk
bGUgc3RhdGUgaXMgc2VsZWN0ZWQgYnkgZmluZF9kZWVwZXN0X3N0YXRlKCkNCj4gKwkgKiBhbmQg
dGhlIGRvbWFpbiBpZGxlIHN0YXRlIGJ5IHRoZSBnZW5wZCBnb3Zlcm5vciwgYm90aCBjb25zdHJh
aW5lZA0KPiArCSAqIGJ5IHRoZSBzYW1lIENQVSB3YWtldXAgbGF0ZW5jeSBRb1MgbGltaXQuIEhl
bmNlLCBpZiB0aGUgZGVlcGVzdCBDUFUNCj4gKwkgKiBpZGxlIHN0YXRlIGlzIGV4Y2x1ZGVkIGJ5
IHRoZSBRb1MgbGltaXQsIHRoZSBkb21haW4gbWF5IHN0aWxsIGVudGVyDQo+ICsJICogYSBkb21h
aW4gaWRsZSBzdGF0ZSB0aGF0IGZpdHMgdGhlIGxpbWl0Lg0KPiArCSAqDQo+ICsJICogRm9yIHRo
ZSByZWd1bGFyIGlkbGUgcGF0aCwgb25seSB1c2UgdGhlIGRlZXBlc3QgQ1BVIGlkbGUgc3RhdGUg
dG8NCj4gKwkgKiB0cmlnZ2VyIGEgcG90ZW50aWFsIHNlbGVjdGlvbiBvZiBhIHNoYXJlZCBzdGF0
ZSBmb3IgdGhlIGRvbWFpbiwgYXMNCj4gKwkgKiB0aGUgZG9tYWluIHN0YXRlcyBhcmUgYXNzdW1l
ZCB0byBiZSBkZWVwZXIgc3RhdGVzLiBPbiBQUkVFTVBUX1JUDQo+ICsJICogdGhlIGhpZXJhcmNo
aWNhbCB0b3BvbG9neSBpcyBsaW1pdGVkIHRvIHMycmFtIGFuZCBzMmlkbGUuDQo+ICAgCSAqLw0K
PiAtCWRydi0+c3RhdGVzW3N0YXRlX2NvdW50IC0gMV0uZW50ZXJfczJpZGxlID0gcHNjaV9lbnRl
cl9zMmlkbGVfZG9tYWluX2lkbGVfc3RhdGU7DQo+ICsJZm9yIChpID0gMTsgaSA8IHN0YXRlX2Nv
dW50OyBpKyspDQo+ICsJCWRydi0+c3RhdGVzW2ldLmVudGVyX3MyaWRsZSA9IHBzY2lfZW50ZXJf
czJpZGxlX2RvbWFpbl9pZGxlX3N0YXRlOw0KPiArDQo+ICAgCWlmICghSVNfRU5BQkxFRChDT05G
SUdfUFJFRU1QVF9SVCkpDQo+ICAgCQlkcnYtPnN0YXRlc1tzdGF0ZV9jb3VudCAtIDFdLmVudGVy
ID0gcHNjaV9lbnRlcl9kb21haW5faWRsZV9zdGF0ZTsNCj4gICANCj4NCj4gLS0tDQo+IGJhc2Ut
Y29tbWl0OiBiYzcxNDMxMjIxZjViYThiYjMzOTE4Mzk5NTUyNjM2ZTA1OWMyYzQ1DQo+IGNoYW5n
ZS1pZDogMjAyNjA4MzEtdG9waWMtbHBtLXBzY2ktZG9tYWluLWNhbGxiYWNrcy1hOGFmMGNkN2Rm
MzUNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBLZXZpbiBIaWxtYW4gKFRJKSA8a2hpbG1h
bkBiYXlsaWJyZS5jb20+DQo+DQoNCg==
