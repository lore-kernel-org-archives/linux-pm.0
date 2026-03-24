Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A61D435F;
	Tue, 24 Mar 2026 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326559; cv=fail; b=O9GEACMluaWPS8QifEnUqIYYB4aE9exmk6UNoPdm621BAWkknsRoQsSXt5wZhPHOb1Hr0zRxSzgW8YUJV/dNg0cY1cblhlal2J0m7fsZaY1aRlCoVeS1Mzcw6Ahnh2KfNSW7x024waAvRYrMQcru5eh/oy59NFx6xoKzQLc67uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326559; c=relaxed/simple;
	bh=93gYYU2uTC8VgqdVThtwW7ow0lbBOa6vo+wvHPAzJEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4Mov/WLyQbh5JfIknmt2EFp22RFPEUKxJjja/TomIhiynW2ehtdTMdweiZa/UH8mKe4zddhn2yTXJIw7R6Lb5IpP3kuTn1WcAeg50ulXL1qHjbQr7gKfo/R9V+uhY+Vg5HVPMEmQI6NOCM63pafG1g3tsn9VrMbv6LNivM/9Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ytq+qYlX; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ytq+qYlX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lifp3xk/07Z3XiojqO+EKgy54v9BrqoqxuhDOLEBPeV4/hBnQCKLtMzE2Td1cpsqxYOv3y66WxakNeT/XT0vXkG6In0JTI/mvxbwdHzF8qflWV12A3ukVRAwXEM8eLm5eyZHZUjbiUOS384VdR7t+9tAZlwTWRTSjQk9r1lUxVQcsD+/xTnISmAi+V5k7+nm1U6paQqtOrPiWemB3YjhwfMc2Un5QdfZ2DZ2VCX057FW3oggSL7838kdW4P2qWAFMK22/UVLhbMqK0t3OXph/ZZ7VQBkTgQbaNmTM/U+oQCXAqqEmYsw+P7HEZvGmEVXJEPMuj3eM+kMgWJi0DGIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17wOI+CPGKp5Yjz2bivUD4gem7ZXPvW6vluvBQd5Tc4=;
 b=Guh2+uFcYgYRTfnYYvcQiUjrXpOcCdVaGx8YcChKWEaaFAtjhlPEbJfntTU78G90lgwXx8S8rCN++uVoQ/8Dcjex6zc2cb6+lSNkU8CjhE/55eAXcsbIUlSBEJwISjY8M+k3KoY5PxE2VT7kDUJyv+tTLYHfO1xgIjGXcJk3C82LRlho+gPG5mu9bl9G1b93o+FpYnSvApQ5fDkXA51uzOzzoF+BuqeZw/xwgLGoruHfCxwScuynvgiNRW2JNmuzruB2otAp0QKzEkmALia4cbj+PwFNOtiqikgNGxcQVMjv5N3wVPBB/rV1GzbmKlpj0Y4YGE0voXT0HwjVSnT6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17wOI+CPGKp5Yjz2bivUD4gem7ZXPvW6vluvBQd5Tc4=;
 b=Ytq+qYlXRnMDA7opPk9PZVKWpC8tkjtyCNnrRHDeW4H+lBq8vP7Gr3ligUssHLX8Uc8iigvBAV/tz8L0m8rf4tSwHLM0+hAE0X3MaOC+myU4RRfDcdx6UyHJPd0FjNVwGbJqF1YMJNIczxB2hlWI70N9DOKu7aEnQ0wkwtkEXQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 04:29:15 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 04:29:15 +0000
Date: Tue, 24 Mar 2026 09:59:08 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single
 testcase
Message-ID: <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-9-gautham.shenoy@amd.com>
 <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
X-ClientProxiedBy: MA5PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 896a4d2f-f5fe-4bcc-6fa1-08de895de7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZAinwUlqvFKnJP3pDXtSX8qO0V+JBhiPKY1KgO2rygSvzoYpF/FBRM6jC+7z39PDQD6iiT1mjvmuwtGoNrROhr4NPXrPSzG7iJu6RXC/REBzxCvoVPLmdzukalHsAepy/okHF1rpE8rise187Jjx+uFL3NXFs6jj9bM4CDOQW7Gy89/b3lZZA1pbg5rS21XY3xX/Vt076aJS9hDBfh7iaNQaq9Gvy+0wH2LFQbQV7U/vV4dPI+2sVUBzyWYg6gLrUsgrUZfG1TJt8S//0n5R3F4lPf2me9NTAiCL6b+OrCMuVfOEOE2h0shlu54rv4gDvo8ry+V6K3FB6mFUl0GCeeCyULFmsPmOsp7j5GvqRhlKiEgg/wkB8QZFCeS1Kc2RLNFdnBN42kLZQmfa7xL/niYD8elXPgTT6cv8VC77KW5D+0kmZPReI0RWyKSb2m52MursplHxSRaYj6ZYHVgMN2U1Eid1ER0RjmrCQGm50+PQSj0Y53E8rWCfEWZi6plWjBjm+ro3tr7HPBTd1rtXJ552LXReTJar99a1tsmmLrmcxRdV+CCZ9w4QHREb8L+DxWmHFM4DtsD9+L5f8vQTRI5AkhedvSqOp5JX/VQFigBo7ZweyDkt8m/Fvb/kTDpb1byb+vPtWiwavAIaZQwdbREadfPxFHc4M0YlzwM6LXAScFnbPBT3f+MW+a/I+TV2ZRaQiqzYdCzj9LnJeqAjO5O1GymlNO/MapdENDmT2eM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLNcPj/yZqK/h9qL0IzMKLwwW1hPKzILyIVwdZHrkIjaNKc673LRaFH0UWuE?=
 =?us-ascii?Q?ZmjBohNYw17xzNgNNC7SkH7aZciGwePmqtGxMurghzbbK4V6X7Kib+ldtxpQ?=
 =?us-ascii?Q?r+3y2uYOFQNE2hrpjciVvHK8pfIdWLeb1tf9mK2hhGvm/jKhDWeCjIXfq926?=
 =?us-ascii?Q?OvxVuhI7DarV9O0dzjrmqp73OT4o+5cvBHdBC6TK/spdUvngndU6O4j4R0us?=
 =?us-ascii?Q?oY6DmEH9tnSBjh/pBgGZBI7sJ/quCMfxwzzV/JwnqDBqYa5XRsSo4Zr/019Z?=
 =?us-ascii?Q?4CyS7mY8nIIc8KnXofcCSUqkjRyFZR9E9V/Nu48lWFosgJfGFeV20MmSKv3+?=
 =?us-ascii?Q?Z2qLd21bRznxcvLD+MichlV15xKOxD5w14zjQsjMpk/l1RXxTrHuZenCAXKM?=
 =?us-ascii?Q?frRP5wm3r/Nu1JYebRm2SVq0lrDud9/+kfn9JbVjk0lXjgFSUPvDOCgXbmvt?=
 =?us-ascii?Q?gNISgdJNyx/3TU6YTs2XTmwcN6libnfI3qmtS1D2vHqFB5X1ruPWAsjacrlb?=
 =?us-ascii?Q?Cm6AGV2YbVjaSDUnGNGPY8+dTW7aIaD6zpzb4y8Hg96W004ZWgNaoMYW2u4e?=
 =?us-ascii?Q?Wn1z8/l+M9zixAlOo0N8ZiJCyF8j+VqjTTo13jgcs4uZJRLCp7kEjTR2lMmG?=
 =?us-ascii?Q?RvwZNn6OjGxHvxYY/u8B5CBjUJv+P/ILXaN8CNDHcBTgo7ptxTlA6j/wYHwt?=
 =?us-ascii?Q?iAFeNQeIA+KxeviWVmYM2VXCT1Ab0uqWqgHZhmynsNhrARkvLV2pdCdkmol1?=
 =?us-ascii?Q?NsuqV3q7J0KhoRMSiMV6ZtYzPSrOMqlHDXfQIa3DSz9e+dZH7sytHH7NgGEy?=
 =?us-ascii?Q?RraBrQLGR8lkzLc0NpETUcgcBx0HtxLPDF/ipBX1rQsI9ByRQqWztCD4+f1q?=
 =?us-ascii?Q?o8hFUvIOaicTfZ5kSD9Dgunk4b2HroTToaNaxX1D0X3MAYHHeH3BMzTw1WXq?=
 =?us-ascii?Q?ojUXGVb9ck7nu8VGbDmM0gWeiv4aD++5Z3CLVwLxCMP4BPHSCJ1y59nCD7At?=
 =?us-ascii?Q?Uy/EIDFEe7Pft8o95Oq+O4xBfWKjQoCWOUrMw39h0I/meXAkF1KW/vlX+EXA?=
 =?us-ascii?Q?uOusMl7v6f9dVhU7JhMr65NF6EvNH5ZOfeqNiX90fwewyfBjCU/xCBEE+3Ot?=
 =?us-ascii?Q?24t13WlnCBujU8nJ1OSH2wTPLskE8at36PguRaZw+rZl+eAmCwv3R0XHxmQC?=
 =?us-ascii?Q?BLJN86VwOjI8ME4+Zy7sGolBOU/jQ7yA6bjwl4+oKSOlQ2+8B36M66O/Vu6N?=
 =?us-ascii?Q?3L8Qqe1wy35fZiagUeRvertAOxushM7gg7z1cDXgUfD/BDqF+A0mgsksR/Bs?=
 =?us-ascii?Q?wClrCyeGLIJE8f8jXVnl+Dp4hHJUvxRHcpqDCeAWg0knCEQfca7faqLiTh8+?=
 =?us-ascii?Q?UbfZL591xnKj6GipxiLNY8J/xPNFXWKO3HaAMmVl3bNxRkpe76hRLM8lb+yP?=
 =?us-ascii?Q?a13dAYHdf5UvTt0bWVat5Ezr5AbP9Jwrroc2GUUdjoHyCZZvKPleRG+ZAx8b?=
 =?us-ascii?Q?ZoBD1+F9stsUgu66yfR5s0h00zkfHDvbYQqHTy9cLi+rlZGptLgyGsXLkbwI?=
 =?us-ascii?Q?H+FCQP/gJE19ZBsFQ35ODn2fzlhKY6kthVgFiFCX77gh1P7Id7efFaFxRKGj?=
 =?us-ascii?Q?cUEiv4fghwl+QMkUdjd5UsaT6JsZvhdPl7wcM+nIF8urPE2e9//iYNatpb+8?=
 =?us-ascii?Q?4wn6O+A3FBIZ/3xOghorkhRUFKUpTX2rj294thdCVhHYmvUK3cO1VQkgKaaL?=
 =?us-ascii?Q?A9decQHBzQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896a4d2f-f5fe-4bcc-6fa1-08de895de7d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 04:29:15.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQHjwf4V4OHhh3xOl91CA3FgvXkyRhX74I81NIjY0bbrkExTCuq21pdibZupLlEHu0U/LeGpS722O1h4RA1TMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

Hello Mario,

On Mon, Mar 23, 2026 at 03:21:17PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 3/20/2026 9:43 AM, Gautham R. Shenoy wrote:
> > Currently when amd-pstate-ut test module is loaded, it runs all the
> > tests from amd_pstate_ut_cases[] array.
> > 
> > Add a module parameter named "run_only" that allows users to run a
> > single test from the array by specifying the test name string.
> > 
> > Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > ---
> >   drivers/cpufreq/amd-pstate-ut.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> > index 447b9aa5ce40..35e453a49c0f 100644
> > --- a/drivers/cpufreq/amd-pstate-ut.c
> > +++ b/drivers/cpufreq/amd-pstate-ut.c
> > @@ -35,6 +35,10 @@
> >   #include "amd-pstate.h"
> > +static char *run_only;
> > +module_param(run_only, charp, 0444);
> > +MODULE_PARM_DESC(run_only,
> > +	"Run only the named test case (default: run all)");
> 
> This default shows the end effect; but it doesn't make sense for this
> parameter IMO.
> 
> How about instead if you had a semicolon delimitted list and then defaulted
> an empty list to mean all tests?  Something like this:
> 
> static char *test_list;
> module_param(test_list, charp, 0444)
> MODULE_PARM_DESC(test_list,
> 	"Semicolon delimitted list of tests to run (empty means run all tests)");


This makes sense.

> 
> >   struct amd_pstate_ut_struct {
> >   	const char *name;
> > @@ -275,7 +279,12 @@ static int __init amd_pstate_ut_init(void)
> >   	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
> >   	for (i = 0; i < arr_size; i++) {
> > -		int ret = amd_pstate_ut_cases[i].func(i);
> > +		int ret;
> > +
> > +		if (run_only && strcmp(run_only, amd_pstate_ut_cases[i].name))
> > +			continue;
> > +
> > +		ret = amd_pstate_ut_cases[i].func(i);
> 
> If you take my suggestion then you would split this on semicolon or end of
> string and then allow matching multiple.

How about something like the following (diff on top of this
patch. Will fold it in and post a v4 if this looks ok)

x8----------------------------------------x8---------------------------------------------x8
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 5d87fb8a26df..5ef22a77a9c5 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -37,10 +37,10 @@
 
 #include "amd-pstate.h"
 
-static char *run_only;
-module_param(run_only, charp, 0444);
-MODULE_PARM_DESC(run_only,
-       "Run only the named test case (default: run all)");
+static char *test_list;
+module_param(test_list, charp, 0444);
+MODULE_PARM_DESC(test_list,
+       "Semicolon-delimited list of tests to run (empty means run all tests)");
 
 struct amd_pstate_ut_struct {
        const char *name;
@@ -403,6 +403,26 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
        return ret;
 }
 
+static bool test_in_list(const char *list, const char *name)
+{
+       size_t name_len = strlen(name);
+       const char *p = list;
+
+       while (*p) {
+               const char *sep = strchr(p, ';');
+               size_t token_len = sep ? sep - p : strlen(p);
+
+               if (token_len == name_len && !strncmp(p, name, token_len))
+                       return true;
+
+               if (!sep)
+                       break;
+               p = sep + 1;
+       }
+
+       return false;
+}
+
 static int __init amd_pstate_ut_init(void)
 {
        u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
@@ -410,7 +430,8 @@ static int __init amd_pstate_ut_init(void)
        for (i = 0; i < arr_size; i++) {
                int ret;
 
-               if (run_only && strcmp(run_only, amd_pstate_ut_cases[i].name))
+               if (test_list && *test_list &&
+                   !test_in_list(test_list, amd_pstate_ut_cases[i].name))
                        continue;
 
                ret = amd_pstate_ut_cases[i].func(i);
x8----------------------------------------x8---------------------------------------------x8

-- 
Thanks and Regards
gautham.
