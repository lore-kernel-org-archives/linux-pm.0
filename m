Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794882357;
	b=4T97nwdbplF7TfqFaSD/lu+JuhPPp+8U4KKAFJi9pnlq3IBwWGAIdbEUi+uCrLB6pMT7
	 H7Lu8nvKv0USukgU4FwZEus8+GqEn7+sGzRmb0hE3vp/GZ50YDc5XbFsdlt7xkTprmVJM
	 B2ib2ZKj0UpRBnuMVT62k9mU9inHoy1Oz/c0f2SfnRMOB1f/Am8FLTirr5W3DE9O9Ck4M
	 OALqoNiG7msANidmGT2RTLXIbRBukTa05AzO0NwexyYaZy4XnaAvmVabL12acsCw7knh6
	 dJw5XQwpoOIUaUiR4FsbT7QO7Clo1lvPDeJ55oDZFM27Dz4E8j34w+ErFYU2ZdRSnfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882357;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r3kul3P1xiKdo7LMfDMCQNQcYEiIF3xkxq4AF4doox8=;
	b=a+R5zuz8onymc/+qmV0ZqNu0nG4XP9a8X4xeOFdGhFc4jyPkmZIV1RX4myce/7dfs0ov
	 dxN9/2Ve7cTqYHRlq+l3c7RbAd+wLfiv47Sogfmp+De8aYxymn1XZVIggomtP+pgk1OdE
	 YQ0Cr9FVtO2DMsZZyNAVS1h5WlNv5GaELs/Ma322jawrdoKxHRW/HO+p3GvoX6SqPfrA7
	 ecvplDl5npPihE+ZMHvp0CnJi9C/arN7gCz3a1R/oDq6K6L+zwkZL/1HRJkk5V7/rHAOw
	 JS/gw0hmEqeF88CNcL6GRwplrJPmb9nA+cMpgrI3MmTAPUPLbHoJQepZz2YoXwLl+Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hvh4pqFu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.37
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4324606A323;
	Tue, 17 Nov 2026 02:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4324606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hvh4pqFu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM5JNmbF0dNU5QX27B8Hbn36oboXaCkVzP5CWq0f9a49EDOr9tym1MY+ietGzNXBMgMtg/MqkIj5y4Af6KDz+G2GgFmhCaVOHS/p0G9L26vzRQZ7ZUKfSFBvpVa7BUTOH7a9o/EGw1tp/BtV+rqZjc/NLshsLWC3CcqE26o15MN2n82Zgd3WMBg3TUj2CjdBb84KiHRpbBREvHHtIpW/tx5ZXbAjUir8SKU0VQr5LQ1uro7fauOkHHb8ZlGAy3sUYI64A6QsuktNj2u1+4NZvQf6TxcseTOO3Qp7Lw0rrF9OLxGBq1aKe/vdrKTrh0TRw43jDbF9LH/HCWTv5uZyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3kul3P1xiKdo7LMfDMCQNQcYEiIF3xkxq4AF4doox8=;
 b=KE875Ds9jdSyKVlKqRZOka6fYofoc6APFyDwzka9dHxMbinJVpQsIhbtfrHAPLZylLcTcL0AosDcR2ImQeCZ5Gvd83tpld0F9TXIgj/AVRO5RXiJFkPGBm7B1bX+fUz/svQl73lkKnKgiHJFkrELL6k4OT8TlS7NjlpmT9aFB73g6lTAmvTKFct8fZ+NX5yB1SGJ3hakNbKwyTpswJcFkoUtstvn13BvQu5EXqvPm7ALd8oYLIAU7xRLDwVt2TE/N4plpP4IlU9rDRW45cD1yrofwbLNvbxzQQUVhh5XrJgdkkBaUyzcdlfWKJTBTDDioZffa3mDvBQBsoNDa6F0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3kul3P1xiKdo7LMfDMCQNQcYEiIF3xkxq4AF4doox8=;
 b=hvh4pqFurGFYmI4eFI4kYHjO+wpy+OwCM7ddXovkM192HGkKm0kFHyi3tP3mDEWFE1SOFLJwiSdFVHgWj8hVJiieUnmiDkwSiT9j120wIlU4EG+6G3e22XrltEpnYB7QyWJ1brJRWJdeSfMkLC1SpBt+fFLPt+0FXLRrgg2TI44UZValxcUBWahCD4Hs5LQ0BLwKPA416wboo97gL+gXHfryzLaMZBTuqZeHlD7MDaGpbWJpEStVLy9DiprlMBGaiyVK8Yt4ryln70Soe2Y5YJdBiIlq+MM7bw11S9EqfawURmTmo66gQhKC2sxVJAU4LpeaTeSApYQe9bt4ArR6oQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:25:51 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 02:25:51 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Wei Wang <wvw@google.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>,
	Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Fushuai Wang <fushuai.wang@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Mel Gorman <mgorman@suse.de>,
	Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC 3/3] docs: sched: describe thermal control with preferred CPUs
Date: Mon, 16 Nov 2026 21:25:41 -0500
Message-ID: <20261117022542.863028-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117022542.863028-1-ynorov@nvidia.com>
References: <20261117022542.863028-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:408:f5::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3418e1-5ce5-4730-5454-08df44521941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|18002099003|6133799003|261009223027099003|22082099003|5023799004|11063799006|56012099006|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YkyrUv8hf601CvTkXhQuUemNtN7TXS4yXksNG+MikTnC020awiYFjwFYPh0kdpm1GDzz1/IpdAolbg+W/JhjnDi7a/03NENGSMzTkJ2pPS46m810QRxSj3dFnDFDK8jBNybBI+A+OHP0d9zfcxTFZ0SCyT1NgURMKQQtH/55rCn6c3rc8i1V7Zv5+qgSfHJ4RMhHOwvfkps2jbViA2xw5uIgk0alSSOJ3fRDl279EC58tyTd/yFsvwlRzQV/9W1Gy8AYOb4oLQzImgvZuCI3rXHHH35NJgtzcTuFV1Iel282G1kiw+o1y84Ikhbea2s+VnVhzlqLd6phxggZAEsI4ZJhdt0kpUZ6wxhP/VeP8V1lDL4RR6G10zeaTCWNkYr8yYiVw/KkEm641Wh1r6V01FSN1H6Ru205J0LiZvm11fipBGK/B9/ZN36agPacD6rDhKxYPDuD/wN18LSPEOULtcs24lUSB3rrpVewv6NEEHL6hxuGe0Jw6hMaWRVPtXngh0/vBVWLCAUVwGMjpzBvORown3lGABXO75jUA6o4IyBjKlUKUJlqtuIf3sA/VXayps5KTygOHPA1bU8eTkFDsnfkDsT0+pbWlNAyow/Tu92Su2/sWWJjRJM/92nwLhSKqNxsBQUm8E06XhS+at+r7jbKijCH8c6EFj85LquA1WQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(18002099003)(6133799003)(261009223027099003)(22082099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sel8iLVc92RlYuv8LHvbjyxTbZRRoxogawP9jgR9WtwGPDiKE+A6GgGzbeaE?=
 =?us-ascii?Q?qsCXlkeKMKn1biiGMFWXdsmYzbor2Ba+07aO2R2k0ApiXeo1XZh5OL5Nki/5?=
 =?us-ascii?Q?Kk1OK1upPPxptLLqZMbfeQDw7C8lZn2+pZEiHFO9H7yOQ3yM1Y5G+4gwGSoE?=
 =?us-ascii?Q?V/xAWw9JSBEXUYlgTNB+SCmvA4f0f2Uu5tQzUzKqxuiq3ZD3a3puGKadL7ac?=
 =?us-ascii?Q?fQIE8g3uGXYpInAWbx5jd8j0tS6zavVjEKzN+8KaFcdwDSCz4YUDG/E+Z5NI?=
 =?us-ascii?Q?7CSufCBoSBN8l8husXKL6CpdUFoi+Kp5uksEoJAmOO6VBMUBlEC7yOlcy4Yt?=
 =?us-ascii?Q?mWKWq0Jn6D7pZ92la90ZYrhKdQL3rw90SsemGC9lc5rBl6D+dg/g4RbDVB5Q?=
 =?us-ascii?Q?m3bcAUyFZvVWjryDkt4ba2at9xGnbQ3jb+ImuKueqQJ5qpoDfbD31/m5nnbX?=
 =?us-ascii?Q?LXLuDDpOfEVrq7ViPt6vsia3+B78t+0LrA5ejyIo8Q2MNrsgymWLRAHp58H9?=
 =?us-ascii?Q?BtjPNMs7nrZeVA5yhWQdKV/TuiRQ7DXxEdGPTbbg/TVn9STXgDlcdy8xG+VG?=
 =?us-ascii?Q?S9btCYrpOgiQMjVf0IMP3gLhvagefAmfVWlJKQQ3V9JSTcHGSExvPIFiZ5cg?=
 =?us-ascii?Q?1zqzfYukGxQv/tpd+9jM8ZUIUZzqcfU0OQi6HoY2Iw/BUoKeI5wa+GKGfS40?=
 =?us-ascii?Q?f1hJtvgks0rLX6zFwhgb8jfYJHqM6QWREMxobTXdS9kiucKZPFjiGOWz0ZN/?=
 =?us-ascii?Q?1NVByHoCaJMwxsBcyn/ZMS+JK8T5KwK+1rmD3el08+ue429L5n0pi/2nc5go?=
 =?us-ascii?Q?OIvnjc9wB/cN7pdVWBdg/9m6xiPa6av7h8glVqn49HyvNTQg/oS6u8qrEbaH?=
 =?us-ascii?Q?wJ8LyDiS41huy9Peer3deVKEm3A27nJX0wHjBth7DqoczUnEC1+WFnybo/cQ?=
 =?us-ascii?Q?zaVlbeq6ARemfKwqM2vKpFw4vpzJj+hxaOBXAWov/mqmh3e4q9aDSsQ19xfy?=
 =?us-ascii?Q?zJrIbVHRzZQGdBFr09Ayf+3D3sfoUphuhHuQywx/hKYp8b0aPjNfZmb0z9aS?=
 =?us-ascii?Q?rlnh26myqXQ6sZ1b3chDKAkownblKUBEbeR9rfbfU4ZMbAHUkREHUOQ8ljSR?=
 =?us-ascii?Q?kxr/qMal4eigpbOXU1PVwhNArRhzTelJoOzGo7nDJKkHUQwsLAmdnF57uLad?=
 =?us-ascii?Q?D4Lx6gsXG2D+1o7eKIZ4xgT9BnC6ZR1zev8DpvT8d6KpmBox2O7o3HyJ8DJp?=
 =?us-ascii?Q?AIYbHzhHQtFdMr91JoXHK0hxc38pAICH5U80VjkDvbesJyLAR0gu1EA0Ts+Q?=
 =?us-ascii?Q?5iQgMt6sCxQmmGQJXHVdzizneuZ3Us4BI2VfVucAPX2pws6+w64DAtGbogxu?=
 =?us-ascii?Q?eIWue/bKQB9h5gphs+uQxcBB1KefYFPuVpnmLrrvh269/vvOsbf9MW5dnGmI?=
 =?us-ascii?Q?GQf1RPD6zweTnDmjgIZfG3VxPYUg/SAS23EL40z1llihn0UQ+ewBJclb5TBU?=
 =?us-ascii?Q?be/j9J8+pRiR87LB6S01dt1+IrkZDc1tFxL3hD+6C6zg1iJXkGNWzK3Mxklw?=
 =?us-ascii?Q?j4Qsd5mAwCqeYLwz9PfvGaghwdUj+3HwXU/h5GrP+Q1lpnlfJokap42o3D4R?=
 =?us-ascii?Q?y1WuSQw+MRH5+M4kWtX4Uf6MjY4mmENQtl80SPEBoXt0J6sAggPam2Vf3rh7?=
 =?us-ascii?Q?h9CroZFOfH+McOwcHJlNjj4ckCWoFRuQ8S+NcaCNEe6ePkusYmeA8qCnceHO?=
 =?us-ascii?Q?ndsWwSUUtmMosfGNa/Rnv93oKyaKT8ul6TaJKCjlpewWKaeDZjf4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3418e1-5ce5-4730-5454-08df44521941
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 02:25:51.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zcNQ6sPl9NpxqaFC3fPFq24c3KqloKf8banPJWxy3knsWJsRKJAMqR64uOM4Hea3vwayohQ5iFb8wt3Jivwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

Document a thermald policy that keeps CPU0 preferred, marks CPU1
non-preferred at 80 C, and restores its preferred status below 75 C.

Some Qualcomm-based Android devices, including the Nexus 6P, have used
temperature-driven CPU offlining. Preferred CPU selection offers a weaker
alternative that preserves task affinities and avoids CPU hotplug
transitions. If pinned tasks or tasks outside the fair scheduling class
prevent a CPU from becoming idle, a userspace thermal policy can use
stronger controls, such as CPU offlining.

Tested with thermald 2.5.11 in an eight-vCPU virtme/KVM guest on an
Intel Core Ultra 7 268V. Each vCPU is pinned to a separate host CPU.
Thermald uses the relayed host package temperature to control preferred
CPUs, with staggered trips at 46-58 C and 2 C hysteresis. CPU0 remains
preferred throughout.

No host thermal throttling occurred during the test. Guest events, with
sampled package temperatures and preferred CPU masks are logged as
follows.

Elapsed  Event                      Package temp  Preferred CPUs
     0s  Start eight busy loops             42 C  0-7
     1s  CPU1-6 non-preferred               57 C  0,7
     2s  CPU6 preferred                     52 C  0,6-7
    13s  CPU6 non-preferred                 56 C  0,7
    30s  CPU7 non-preferred                 58 C  0
    90s  Stop workload                      56 C  0
    90s  CPU4-7 preferred                   49 C  0,4-7
    93s  CPU3 preferred                     47 C  0,3-7
   102s  CPU2 preferred                     45 C  0,2-7
   106s  CPU2-3 non-preferred               50 C  0,4-7
   107s  CPU2-3 preferred                   45 C  0,2-7

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 Documentation/scheduler/index.rst             |  1 +
 .../scheduler/preferred-cpu-thermal.rst       | 94 +++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/scheduler/preferred-cpu-thermal.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 791178ac8bec..25d1590d8217 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -24,6 +24,7 @@ Scheduler
     sched-ext
     sched-debug
     sched-paravirt
+    preferred-cpu-thermal
     sched-preemption
 
     text_files
diff --git a/Documentation/scheduler/preferred-cpu-thermal.rst b/Documentation/scheduler/preferred-cpu-thermal.rst
new file mode 100644
index 000000000000..da6d019e42e4
--- /dev/null
+++ b/Documentation/scheduler/preferred-cpu-thermal.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Thermal control with preferred CPUs
+===================================
+
+Preferred CPU selection can be driven by thermal signal. A userspace thermal
+policy can reduce the preferred CPU set to concentrate fair tasks on fewer
+CPUs, allowing other CPUs to become idle. This approach may be preferred over
+offlining CPUs because it preserves task affinities and avoids CPU hotplug
+transitions.
+
+The following thermald configuration illustrates this on a system with two
+online CPUs. CPU0 stays preferred. When the package temperature reaches 80 C,
+CPU1 becomes non-preferred. Once the temperature falls below 75 C, CPU1
+becomes preferred again.
+
+Save the configuration as ``/etc/thermald/thermal-conf-preferred.xml``.
+Replace the sensor path with the package temperature sensor on the target
+system: the example assumes ``thermal_zone0/type`` is ``x86_pkg_temp``.
+Temperature and hysteresis values are in millidegrees Celsius::
+
+    <?xml version="1.0"?>
+    <ThermalConfiguration>
+      <Platform>
+        <Name>Preferred CPU thermal policy</Name>
+        <ProductName>*</ProductName>
+        <Preference>QUIET</Preference>
+        <ThermalSensors>
+          <ThermalSensor>
+            <Type>package-temperature</Type>
+            <Path>/sys/class/thermal/thermal_zone0/temp</Path>
+            <AsyncCapable>0</AsyncCapable>
+          </ThermalSensor>
+        </ThermalSensors>
+        <ThermalZones>
+          <ThermalZone>
+            <Type>preferred-cpu-zone</Type>
+            <TripPoints>
+              <TripPoint>
+                <SensorType>package-temperature</SensorType>
+                <Temperature>80000</Temperature>
+                <Hyst>5000</Hyst>
+                <type>passive</type>
+                <ControlType>PARALLEL</ControlType>
+                <CoolingDevice>
+                  <type>preferred-cpu1</type>
+                  <TargetState>0</TargetState>
+                </CoolingDevice>
+              </TripPoint>
+            </TripPoints>
+          </ThermalZone>
+        </ThermalZones>
+        <CoolingDevices>
+          <CoolingDevice>
+            <Type>preferred-cpu0</Type>
+            <Path>/sys/devices/system/cpu/cpu0/preferred</Path>
+            <MinState>1</MinState>
+            <MaxState>1</MaxState>
+            <ReadBack>1</ReadBack>
+          </CoolingDevice>
+          <CoolingDevice>
+            <Type>preferred-cpu1</Type>
+            <Path>/sys/devices/system/cpu/cpu1/preferred</Path>
+            <MinState>1</MinState>
+            <MaxState>0</MaxState>
+            <ReadBack>1</ReadBack>
+          </CoolingDevice>
+        </CoolingDevices>
+      </Platform>
+    </ThermalConfiguration>
+
+CPU0 is declared with both states set to 1 and has no associated trip.
+Start with CPU0 preferred; thermald leaves its preferred status unchanged,
+so at least one CPU remains preferred.
+
+CPU1's cooling states are deliberately reversed: ``MinState=1`` is the
+normal preferred state, and ``MaxState=0`` is the cooling state.
+``TargetState=0`` explicitly clears CPU1's preferred status when the trip
+is active. When the trip clears, thermald restores ``MinState=1``.
+
+Usage.
+
+Stop any existing thermald service, then run this example as root::
+
+    thermald --no-daemon --ignore-default-control --poll-interval=1 \
+        --config-file=/etc/thermald/thermal-conf-preferred.xml
+
+On SMT systems, control all siblings of a core together when the goal is to
+idle a whole core. CPU hotplug can change the preferred mask independently
+of thermald.
+
+See :ref:`sched-paravirt` for scheduling behavior and
+``Documentation/ABI/testing/sysfs-devices-system-cpu-preferred`` for the
+sysfs interface and hotplug rules.
-- 
2.53.0

