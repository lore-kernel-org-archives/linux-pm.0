Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021138.outbound.protection.outlook.com [52.101.100.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D723504B;
	Sun,  2 Aug 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695450; cv=fail; b=etorfCMK5HkZl6JyNNW42fSOCkAon6iW9o3Z6V8t9fjIsoDOBOCtPwxhGnhJSvB22xeXqpkI/yK6dID6c/rKLt9u+TYS3sIDesSmcu+Xt2BbOSOWzSH8kzk4AWUIoJpMfz7bS0UEOs0YDahBWKS1OCJ1z8JOUayE5c6q8NjzWZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695450; c=relaxed/simple;
	bh=wsqxuNM694/wGgOP1l6QefGOhyzON8YsY2fkD3yRw/A=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mkdzo7caLXWVsAD+ngSPFbC7uorAF2palqz9JrAn3tUPsAVzFDgli6xwJ8mnja3LO8wMEChWOOur3o5ThOiE4DaIS2D2Dn9T6B3GyMQocfwGiIs1s+QnmpyfduUFRt8zGhQGoap+o4KHhayFIQDxAsSi9x6AjElyw8mOXtw9FxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cCkzKK5C; arc=fail smtp.client-ip=52.101.100.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cCkzKK5C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRJRxgCmfkrYlLyiUZVd856znFfUMDDbkQDciXf7L8rzmYuv0rAYuQW2Ov9gjkNuvZRS3es6FcAYEkBiTm3+OpphIrcdjVSsxudyLsTKGpHH2xCW4TczXYNGKMztX4R7SpVLk1FM3XJyV6BGzBuVihdiZb0RkzH/fT78k2CEkHsOwqqGzMUHHYMgGSV0SVEtNAPnBRsoqRUqBKmb1iODbQBQMkyhs0s7Hd6NF2U9CnIBgbVkOS0r/z57ZnNDc1lYjQh75n/V6ER7VB96AGXTJWQnBV1I6ZaMmwfKNAlDips50RXeFw+jcKAQgyObIyiimZ5ppcZXq1zFqdSot898iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsqxuNM694/wGgOP1l6QefGOhyzON8YsY2fkD3yRw/A=;
 b=Uy/ylENv8obaf1YFl+cdjMxJlAbd6zZP0FAV6MaS65uLkSTcamdei612KEKZl2kP4OwWRfUIkaVS1Qr8gWBbCvhhl1WiZFhQTGBlY0BfoU6RVyjkHt5FqtJptqilkkhsqL111qvNGYqQn7MDHKDjaQySQgLCK+Ifo9x5v2mWHQLF1GIXeRSivLlGWsD4pZ63SSKQQwfOgURV3wi2Wqg53EAHB3ubEBSnN22SxUg56E8AgH4lno1MxauZaAtTX09QC+YJs7hAvDYXZDIX0veqq1P2AXnQn7TanfC7Z7pE+4mUzsSLKibDDoyvmWsq88+wtOnhTRk7vJ9cY3eCR/fvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsqxuNM694/wGgOP1l6QefGOhyzON8YsY2fkD3yRw/A=;
 b=cCkzKK5CTCFAiRgpgt2ClV1rYa97Sio0ttSXgaS+9IRohXFDd4xAAf7wTrGehlBbRwkUlJxNsb4WqX7K5qooyxijPV2qmkV+1oDJU0e5dROQLLWn6MW6UOVoCIFpuo7pm622qaz7t6EfgINBEFtSplJUYa7TzFk7JfVhcsAFuMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOAP265MB8981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 18:30:44 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 18:30:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 19:30:43 +0100
Message-Id: <DKEO7DXQ8604.1CB09QFM2EO68@garyguo.net>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Maurice" <mhi@mailbox.org>
Subject: Re: [PATCH v5 1/4] rust: clk: use the type-state pattern
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Boqun Feng"
 <boqun@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOAP265MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a848f32-b2cc-4f31-9a2f-08def0c42a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|4143699003|5023799004|3023799007|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	SiBlaTbU1KiPBcRszrcI4p287UdWfw4xtgjH0vAdcLHkMU4Irw0qPTky9IlIcNJMRhe+meAe+qWIen9BWLO6ZmPsqjK8uERFlc1DfnyQ5bDnmxZUf+Fs5RxpU1CqPr1ZpZ/GpOkAzOXSvpq7zbT4eG1NQ32PhB2f5XxnjzXCNxPMdb+sAhqmzL7gNSYLybkfXTiDdZwUFBJESp+NW3Xp41CA2G+3rQI6Ty0ZB/ImHkT9WtoDCMcfLPxfsBiF4LcwGmmx9yfBshBeh7PDZ0RXoRSB95QKC9M9Ns+OSlqFhPPNMC/COisc37dZCF0xZL0jjpUeRdwrzSclfOEM7VfaLLUF3ssj83jlJibPMTOnvFCH9neCRh18aPg9sBrPOduutar2NcwRnz/HQFNQaiONQ6Gpc9ddt1e0fPLRA2mXKLzVo221/Hay7uAjEIF8ME/9dEWL5H05svg0hP4QgFfX2i5Jctp6kiaS6KghzGWUEa+kZnkBBn4CMT0e+klH7VjYEe93yGt070rbvLBOPe0XoDznu9FMSX9O24s1OiG8dQByppIBXWCtN773pr9Hdx3cFtZpftITMYkQwU4+bG2uhNU+zumbAp0Qfl3VmgmZhY4FnjBUg9x9v9lhCPR+v9oIQ3RMxq3gYAqGQLi6OR9Y/CRXVZTlyS4wMMSlqXetcF4aW+4Y9OZQ33MLlCf8B6yYup7wRdDnlaI43HQIYK17Sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(3023799007)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1RaWXY5MnRUWks1cjdrSUxWL3o2eFJ6RWY1Q3drbm5hRGM5MkMzaEZTYWQw?=
 =?utf-8?B?MWFMcVRMc0JYNmFtdXJnc1JWbnVGS3IvVllzdGkzcUhTL2R6RGlyNFNKRlJL?=
 =?utf-8?B?MWNZK2pxMEFGeFFCaTJHUWNhK3J6Q1VsYWpRZnRzRWI1dEpJam4ycnU4Qkw3?=
 =?utf-8?B?L2QxdnhQaFpyQTczajlrak9Vcy9rZmhEVmkxVko2dlcvSkJKZStrV2szSCtr?=
 =?utf-8?B?MlRjWGhxeGd5TnMxaUFCT1pPeVE1M1ZWNUlNZUtwNm44UUhXN3BwaUhncGNk?=
 =?utf-8?B?amk2STU5ZUtnd003MFpTYlkrSCtuSUdaeGZDbmNnWEhhNkFhaU14WmxRZ3c5?=
 =?utf-8?B?RDhHc1IwTEZOUlhkelRndXhpQ2lsZkd6bmp5R1N5R0xqUlF4MGpxNlhRQTdn?=
 =?utf-8?B?MlhTSysxY0ZtbjIzQlcxNVJxQWl3c2hoUWtZKytEMmgzTURMMGx2eDFsUHNz?=
 =?utf-8?B?SjJ6amx0M3llMTVYd2JtVlJ0cUpMbCtsNVVybnB5WVRmQ1U1N3hzNm1JNm14?=
 =?utf-8?B?cFRVcVdCZHNRRVhoRjhrRWt5TVZTVGhzbm96UEVqeDE5TUJKVlljbjNwZ3d5?=
 =?utf-8?B?S2t5SThINFkvc2Q0TlA4RDl3WDFHMlB3eEVDYzZKVXhqN2ViOG5sYjdKRWZR?=
 =?utf-8?B?Nnd3dEJDUDlRem1uaGdJb1VlcEhUNTlDUkdOZ3paL3k4NnNrcEtUc2k0cG5x?=
 =?utf-8?B?RkxiM2liczYwQVdqNWFLLzVGTCtma1JGRVlYUjBwSStIOFRZWlpFRTVpdUZv?=
 =?utf-8?B?YTM3OFNMY3FMWXBGRTN1Rzg2VUpEZHlTMFdqZ0RBQ0kvY1krYU9QczQybWVt?=
 =?utf-8?B?V3ZVc1RYYTBPMEhIY2lNMS9wS2pnK0czSG5RN2NkaFpFMmk3R09oL2tXNDVF?=
 =?utf-8?B?d29EV3BBN09tcGRac3V3eDZ2d3Ryc21wWGppNVFXZ2EwaTd3SFAzMUNDTCtr?=
 =?utf-8?B?RVVIWkhtVS9CbEtyQXVhSWVjUm0yWGZSVWpWTlhJbHQ5Umx3ZWRJTmdYNlBP?=
 =?utf-8?B?aEg1YTRqN0N3UW9sbC9sUmNqQ1l2b3AwUXZtWm5ORXFYb2F3bUF1NXE4dzdO?=
 =?utf-8?B?WUpWTXdoZDU2eVVSRUNYbzkxMW1HbDNyRzNpa3FCejVQcFZ0eVF6RHI3S08w?=
 =?utf-8?B?Y0Y1ZXVVR0N3SGM2ek9sRWNKeDVrMU9HMVVRSUxCbW16VndFd1owUDFZRStz?=
 =?utf-8?B?RGMzbXdzUFArV2JYMk9TWFM4K3lsTXE2bXFzdW1OYzExMzg0dVpkWTVIWW1a?=
 =?utf-8?B?ZzVCeG41azF5LzdUdEQvRDM2bXJMWWlnNlV0OHBpR0srYVVNZXUrbXlWSmdQ?=
 =?utf-8?B?YkxIOC9wVVVTYUpwZ0Q0dThJalZHZjlYTnFyNnc1QjFXZURrUDZkWnNDOHdT?=
 =?utf-8?B?NGFFbUZiSTFsR0s2RTJ1K05QRnVvSk9nSzNvQi9YbTIxTnp5WlkvUWtXUk53?=
 =?utf-8?B?OHNHTENXVVFUY204UUczZStVd01tRW5CYTM4NDdaOGovTE1xNUhnZUIyOGNS?=
 =?utf-8?B?cVNrUEdxVEw2RFNDcUZETldkeTZVU2plditjbVdvOFh5Rkl0ZWJNd2JzRU5w?=
 =?utf-8?B?N0psbHVKTXFaYmJRSm9VZWpHVjNTZ1kxeWw3L21vOXNmRDZaZFMwcHRVdjMv?=
 =?utf-8?B?OExCOW9pVGE0ODRSdUJOemROUW42cXA2M1c5R3YzcUFZdGwvNTFMb1d3SnJG?=
 =?utf-8?B?Q0JNNVBqVFpndE52bTJVUUE0VGt1YUJKWmxnVmxZRERJRkNpRHM2a1Ayd0pv?=
 =?utf-8?B?K21raDh4VHk5czdOOHk2dlE3ZEVaeVpCSDI1NlQ1YlY5VHlCYlN5VEpUV09Z?=
 =?utf-8?B?MUVaVFFGektPR2tqZWVyUVV6b3BqL0lhWG5FUDl4VlUrclcycm03Q3FHMFkv?=
 =?utf-8?B?bzhQaE1Nb0pFdGhIUitaOWd5d3cxQTMrM1QxVHcwckh5bEZGSjUzTnMweE5W?=
 =?utf-8?B?ZGpJMDVhcVQ2aFo3Y1E3eGllY0RZemtUTlhtcHNzVHAxYi9XZlFveDFJOExa?=
 =?utf-8?B?UmNQdE0rSTAvWDRqVHd6RDRCRlNEa0ZUM0ZRakt2ZnBXOVU1L3djbEpicUpO?=
 =?utf-8?B?VEJzS1RsdUdrc2p2UTlIdkpoRURiQ3VyT0Z3Wm9hRlN0aGUzQWV3R1pmODZh?=
 =?utf-8?B?djgyelJ2dEMvMzFiMXJsVlB0dnNlV1ZKRkNOOHJBSU05V2tiRUVabkNpSHBl?=
 =?utf-8?B?TnhhY3MwU21hWXNaVGxsdlNoVjVJOWlsZ2E5RHhOcVZUR1I0V2Q2L1ZWcThF?=
 =?utf-8?B?YnY4WDE0TzhyaFVuRng5d0hjbzkwUHc0aDREekZFK3oxdDJ3ZEs3TjN1am80?=
 =?utf-8?B?UXkxUUJLM2NCNnh6K2VpNndvUEpTaHVzUmVCRC8wU1U0cVl1bXc0QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a848f32-b2cc-4f31-9a2f-08def0c42a2d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 18:30:44.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxSaeUBWXhqIdk60Ecnm93juP1VVG7+7zB/EXd5qM+siDjof9tR0Bc7ZfxUvZbJiV9XdgjYk5NUgHizY3XF0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8981

On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
> The current Clk abstraction can still be improved on the following issues=
:
>
> a) It only keeps track of a count to clk_get(), which means that users ha=
ve
> to manually call disable() and unprepare(), or a variation of those, like
> disable_unprepare().
>
> b) It allows repeated calls to prepare() or enable(), but it keeps no tra=
ck
> of how often these were called, i.e., it's currently legal to write the
> following:
>
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();
>
> And nothing gets undone on drop().
>
> c) It adds a OptionalClk type that is probably not needed. There is no
> "struct optional_clk" in C and we should probably not add one.
>
> d) It does not let a user express the state of the clk through the
> type system. For example, there is currently no way to encode that a Clk =
is
> enabled via the type system alone.
>
> In light of the Regulator abstraction that was recently merged, switch th=
is
> abstraction to use the type-state pattern instead. It solves both a) and =
b)
> by establishing a number of states and the valid ways to transition betwe=
en
> them. It also automatically undoes any call to clk_get(), clk_prepare() a=
nd
> clk_enable() as applicable on drop(), so users do not have to do anything
> special before Clk goes out of scope.
>
> It solves c) by removing the OptionalClk type, which is now simply encode=
d
> as a Clk whose inner pointer is NULL.

This change could be a commit on its own?

>
> It solves d) by directly encoding the state of the Clk into the type, e.g=
.:
> Clk<Enabled> is now known to be a Clk that is enabled.

The design conflate states with actions. Our existing type state for device=
s
don't do this: `Device<Bound>` means that the device is currently bound, no=
t
that dropping it will unbind it. Yet, a `Clk<Prepared>` doesn't mean just t=
hat
"clock is prepared" but rather "clock is prepared and needs to be unprepare=
d on
drop".

One way around this is to mimic the "Registration" pattern: have a type to
indicate that a `Clk` has been prepared and its `drop` will undo it, and th=
en
this type can `Deref` to `Clk<Prepared>` which just mean a prepared clock.

>
> The INVARIANTS section for Clk is expanded to highlight the relationship
> between the states and the respective reference counts that are owned by
> each of them.
>
> The examples are expanded to highlight how a user can transition between
> states, as well as highlight some of the shortcuts built into the API.
>
> The current implementation is also more flexible, in the sense that it
> allows for more states to be added in the future. This lets us implement
> different strategies for handling clocks, including one that mimics the
> current API, allowing for multiple calls to prepare() and enable().
>
> The users (cpufreq.rs/ rcpufreq_dt.rs) were updated by this patch (and no=
t
> a separate one) to reflect the new changes. This is needed, because
> otherwise this patch would break the build.
>
> Link: https://crates.io/crates/sealed [1]

Link that doesn't seem to be referenced?

Best,
Gary


> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

