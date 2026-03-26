Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8438AC7F;
	Thu, 26 Mar 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524559; cv=fail; b=M1MuS7TsJcwGoJsLEseZwAAm01V+xaUafrMKH7eed6pe00rfcJS0R+Nl16PrWtlhDfuCIv49WuOcwsDjA/FLBeH1iVhPAWSy6+3rU8G7jVdjk7oKmiTGcWsBgDi3kao6krXFwY/kXERB0lfD58W2dV+sPFPQpFGi2ooXa6jXGRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524559; c=relaxed/simple;
	bh=THHGbkUGeCrNwVfu2gX4aQWLTd5kfgTccRZV/0/l33w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yii06t8BOB3KYVA5npebUcTdcndn/WkUovc5jAuGsUIrnxSB9Pd1JWumg9BwDIPQ4fjgZ1HswPvOF77sELpwPveAMwu1ypIrL5tBB844m4YyVXnV2Zngoatv2Udk+aKY6zmoO0iIob4jmhO/XKePhlmrKltMeFyC+WnbYQGWAk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3nLTu1L; arc=fail smtp.client-ip=40.93.196.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3nLTu1L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pfyx31X8RQ0GRBcGo6tJ01nl+v8HRTXv6FXnGu+PDRxeQvTt23Fo7k4jwJEM1zEe6KrXGgl2isjT2/pj4cWZujHVGAV8JNytDn+CUeydIMOtjLzGeOGvH3sDdPePv+FHjfEe/7D0VOzKGPkvEqLPeJ98bV6MVEoKpfL1LN0CJlavIoZWM37tlq3k2o5tQshz5j7rHFdoMN1yVPgfjxoLnNS2Tf6dJfzkhPl4nNbeJVxYxtav5ghA20evTtCPqefap9BFc65813bZJRaqlsLTZN46S7gngorGsMXtEJOXv/CnLDX5TLeLQXEuJM5q1C7C6Rp9++zr/aPnXDQY59NDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91wCRxYI4R9CsTIuXN6iQuRs+eZY1wAvw8jFSJ0l8AE=;
 b=XOxC90OmEnrzkx1YaaKRn8tO93pHeACka2G+ztk2U2jkqUUB95br65BuihSiqnNOzloTLh2hoKwt/V/QfUIgLeGOZ1HNIXW4wmHKaIyd7e9RgYc7ya26zwd32sAdIXD1AbxFAqYFNtR8vnYm/QUQMYi4CLhn1kLxiEBU5nzw7XiHKUOKXq8eixk3ffAOZaE6rncTiVgquywRw8McFughb2ueT+bImxMXeDE+YQ6hYfpxzmvScsfrty1DetsQ8zVBOmomvNvA9YAn6sjf7LymS2l2ixh2/cF/Zoox28v2QKWEB/5zeYFJn/JptjRPlh76O/4kzxQ7s2dSE9pns7tr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91wCRxYI4R9CsTIuXN6iQuRs+eZY1wAvw8jFSJ0l8AE=;
 b=H3nLTu1LUHtCZ3BhJAnWXKckqLUkfBM48qT+JDhNRJVEEqegQAqCEIhAYF53+nvPmzEhGnNgieRk90NbMWnajSH3oEO/l18xBn6ss3/Cgn27DsmvmkuaPXoB/xFemUzNWCSWoX3SwKttGVPkwtLRunMzLWzg+2VuCEU8eyaYiPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:29:11 +0000
Received: from IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::a9db:8817:757f:e20e]) by IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::a9db:8817:757f:e20e%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 11:29:11 +0000
Date: Thu, 26 Mar 2026 16:59:03 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single
 testcase
Message-ID: <acUYf4pFnm2f5wfM@BLRRASHENOY1.amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-9-gautham.shenoy@amd.com>
 <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
 <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
 <554baa52-c181-4dcc-a77a-ef8f4e0be763@amd.com>
 <b69cc187-6ef3-4390-a0cb-f36a2295c6f2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69cc187-6ef3-4390-a0cb-f36a2295c6f2@kernel.org>
X-ClientProxiedBy: MA0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::10) To IA1PR12MB8240.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8240:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: a533ac2b-7777-4cd3-6d05-08de8b2ae6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	91h2qDqw2PsiAcMLrv56ELnkWKNjvv2D2fOKS2q2BFL4JIoR3qpv1LzCE/7poEjgev7W4lVO6/Uk/qe4U6VbtDc6QBIqAiAunwtgB8ZXCbQGb95sy/wnKFy5ATJbG3O+4hyPuKkuvwnT0Y04h4JI3PkJk9ueZY0D4qtlr4vC5uOSX8Zk5VAwLIkuLwdtqKu/0mCS0AfZbey8+Zf2zpyDC7mkleB2K+TqAvOFDhxi2D+lyataZ0LDDl3wIIHs5SYh0qhl+vbvStGIHh2kt7da5Bvv9socdqPgkNZpWUz9WKjbKdpm4lUjXO8Mz9XKpuMhXntR/fUFhFHb0Q7wths9z1J0wEHzjZNFtbiBKtjT/NIp/pqzVaRX01PAxPhsoZafsXem5pOF5AxpytBrVaF6roa1C9sZWhlvLSumbquBscRLPySFO+OyF2WDKjKL3WIdVwg9852P+g++7u/oZIGY5Ky+NWx/UZMzef8Hlq7BL7ixR6564i5mjKsduNgZiyZhJMqdajZSe7/52xbG1jo5tSQTgjv3p00gUWvDRCZ/jLN9evgDl9xJ3LNZnr6uFYGfgGhhbY9NefZuEuFUgP59aQqBOiiT/gGKWk/pLwHUqm/syb4LB0JwBAu+NOAwwSiIMlUMnc84rFWNQS0Tce4yYP82ueibIFUcQtbiasgt1xmbINGhhpjS/0P8GnvuafqkBDxNIqTA0l/e2Uv9jKQvqPiaJcNmT7YLqtRFMkVLuNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8240.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9PS9RQ3YV3uk9NIaqhAqN5GlTy5y8I58skVDxOkHqvFUdHWFrZWzeoOT/09?=
 =?us-ascii?Q?FRN6PPiCp064IV7q6Wc4JL2nsQ4NMkbobRjF8LmUnmywmy00OfMFJGRjANwD?=
 =?us-ascii?Q?Ez5cE6i9Sz6tQZXTQU7Qu0eyQePJ/sX8UKFvpFofI7vXJJv0nJupqIYPb4Ql?=
 =?us-ascii?Q?MHOnoL44+zG/39qaksmx4gZdw8lwAVeY36I2dF2JPPa3jfyKrouGKpWemRr9?=
 =?us-ascii?Q?fxjagMXVxN0fZVluuKeOOmHcZTJUJdJ/hUDaI4k1OeACbEBx13zR9K9FhTsX?=
 =?us-ascii?Q?NxQL5sMRfox0ygNsSYXIiV4IS6bb5ynpGndMIUWvM/qSMkunadysjs/Titrf?=
 =?us-ascii?Q?bLyYIP3NJXulx9fWMViWaj5SzWK7mjEo/RdD44wHbCW3ejurSijtlyOBHpSK?=
 =?us-ascii?Q?V/HasQYBE/nWWnYpr4QOHVnlob8sMfUFR+xpzQ0hiGsbJK8KhuYeR7SFs2hT?=
 =?us-ascii?Q?Nqi4B+tc8h/FoSND13j40TWLtnOICZqhkTvhUN7o5d+Rv49wFp4DzcGCEzDM?=
 =?us-ascii?Q?M0VKOTG6sEbgBcPsSkpQ8ozOzoVyNzwO+H5Remg6Jv0liSCoBoECtre1bGK4?=
 =?us-ascii?Q?7FrilbjzAxqUvjQciDiugkJKPgeaFF+sm/N8SgKO+ZeWNnsnNCBwgxl9AwOc?=
 =?us-ascii?Q?R002tSIGFAEGnX6Vj3ud1eQVPSL/laWVj6IR8XJGCrvD0DYLDVjOKqHUDS89?=
 =?us-ascii?Q?Qjyd0xwTz1+xUXL6tNn/hBiYZcE4Q6+u1nmDE3hRQrTktH5KucWxe3PQIX9T?=
 =?us-ascii?Q?7w+YZcwOIpVyh/6w+D6Oa6HY1oH5HZMlRmYYAs1J1Pcpo1CfYg0zTxNnmhBg?=
 =?us-ascii?Q?uZXdMMfrYz+AlTm+atWrXLL0Vv853pjYCYg8+T5kzrG3oJBWAdeWccx3C0BA?=
 =?us-ascii?Q?TDHqT5sowRouqxSayzM1Kg4ROW8y0pZXaF5kfE6yJ0H3lZ2t4GFStBwmJpLo?=
 =?us-ascii?Q?NKBkZ5n7NnCPG5//Ww8G/7DSkD/C3cNJuPpIQj5QlSTgEZ0+m1WdF3W3LSs4?=
 =?us-ascii?Q?jUUb8U6VMtkYrzxgKvrPRTlbxA28C1JZbhGs6jPzdeb4TdD20hzF4SzvWW3R?=
 =?us-ascii?Q?BRAqESwQ/zmC5EllnuLa/7+woya813E8ycBm0F8Sh7orRhwgXvAz0Yfq5H5J?=
 =?us-ascii?Q?dn0Xgv/rJqq7HYrQzicDSoSO6IbsLDEXphAA/MiI5pk6dp1xFnJksK+KHCg0?=
 =?us-ascii?Q?sd3jLoWlgAeN8FUNU9kQ5g5L/oCmXTs8ug/oS2r9U48KQ77xIleGIUDRPZ3q?=
 =?us-ascii?Q?qWxSpKNeruJlMkF5C+K1KwT7kTfHxUEK+vlJmhnmfSIl79ElnYKlSthLd3PW?=
 =?us-ascii?Q?E5VxW+qvilgiAMNsLLR+hlQfpE0SHJ0CBJ+c8DCIiy6mkV5AZX8mV7SjRBmW?=
 =?us-ascii?Q?GxExY3Lhnu78Aq0KxSv8yZCziK0bYKlrC1mM92e4Sr8qZySuO6IoXzzJyfy2?=
 =?us-ascii?Q?hSvYMuxTM14UG8VUNFfkxNpgHTiShDac+jjv0+OheiFeZxNtOGVeaOJHsGkW?=
 =?us-ascii?Q?O8zJ0AIXA5jWLGiOd9ZH6H79pG4iYDyXhGotQ/gNUUp/juzZNvBij7k+bP6u?=
 =?us-ascii?Q?e72V2s0WGdEQ2/fpMarusm61RKZKZ6BB/7xE3G2re4xRGt4XCJjgSGNSmeDV?=
 =?us-ascii?Q?Kjo3uO9IRoemY4XKIA+ryc0ACoRlAx6ds7FzAiXPR+zMAt1WYS6bi+2wK4nt?=
 =?us-ascii?Q?5KBa1WMQ/IC0EW9SHXQQszxhEs0YBtk+iQC5AQt6+clnVtX2MRrrZDFtIqDN?=
 =?us-ascii?Q?bd5NqtC47w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a533ac2b-7777-4cd3-6d05-08de8b2ae6af
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:29:11.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftVfNZArVIo2DsV3XYG7ztAJbr5V6dMHmdC6LyWoASXsRJkCIjkkRjAvbIKeSF2h5hUfAEsn7nmKBjuoB/I7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

On Wed, Mar 25, 2026 at 08:45:05AM -0500, Mario Limonciello wrote:
> 
> 
> On 3/24/26 23:28, K Prateek Nayak wrote:
> > Hello Gautham,
> > 
> > On 3/24/2026 9:59 AM, Gautham R. Shenoy wrote:
> > > +static bool test_in_list(const char *list, const char *name)
> > > +{
> > > +       size_t name_len = strlen(name);
> > > +       const char *p = list;
> > > +
> > > +       while (*p) {
> > > +               const char *sep = strchr(p, ';');
> > 
> > Any particular reason for using a ";" as the separator instead of ","?
> > 
> > I personally prefer "," because with ";", I need to explicitly add
> > '' around the test_list otherwise bash thinks the command ends at ";"
> > but with "," that is avoided.
> > 
> > Thoughts?
> > 
> 
> Sure, that sounds like a good reason to use a comma instead.

Sure, I wil change it to a comma-separated list in v4.

-- 
Thanks and Regards
gautham.
