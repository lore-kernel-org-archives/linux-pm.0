Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683F31352A;
	Tue, 31 Mar 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977064; cv=fail; b=Q981Ugu+Sy1dlf1dsjLFRxnhj0FWL/qAXSDHrc20f1n1uSBvlMd/JqehyFWI9Dk0rdDY+hlef73XEV1qipPoeV3E+Bw+lpxZcLptoAZvCqfb59qzLJpiMiD6gSit267oNhajtr6/sl18xg0T1R59XXyMXJ99Q/Vffa2JGrCoQbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977064; c=relaxed/simple;
	bh=s5rlZ+ocx52RqAYScbKzuZsm0J+QW+Sd5BW+IOZS2ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=myPsg+/jZ72z0gW7aM193PtbVh3af3Fn1LHEesMEVZETas24olVr3WJTB/rPq9zT0Vpb4Pp3qCA8XZHWyWpB4oQ0Xm9V5EsEymhUzYaFtrgilaNp8vWdBvrHJ0Tsd8znzuoDAGorbHrffEJZgAZLDDJF/3kacOGPVqH69wPst+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T2Esv2iu; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T2Esv2iu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp0U/Fp/hc4tv6gt9zAkklXe/U2W1u6bRDpIfNE8TDIX0Vh4X+drIz2N0cqBL+emjBNufpfwd1golkLgY3detHm/P2Gkphs3ioO1RsAjxkZ6Qog5nG0TxG/kTcvN7W6XzL6dWMnZVAY7VZ9EfWtOMWHt65bz9lXW+/H/SYZsZIQzG7F1J86zTVJlou9wwtPVWNF3yMCbtsj6ZCHzeSZfMLWH8IEWa7WhxBFFv35wftHCWwq/M9CJRmsWJ4W6MqXXJYV6aGE7MfyUzAqcyAS1ODus6yybfK+XESLDmYx//13kG5PGSKA50M4MPZBxCOhdlR6tTIO8xTG2WtSrazzs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UprNmBBCfV+5US1pr6IOD4I/vrcdJPu4a7Gbv/Re0NA=;
 b=dDst8rHmD1aIpK0kmIhG9CpN1PabFLHt6Zmjnr3HagUFbelGUFrK5QSoTe46OsahiUPUOkOphmXOPwG/0pOjwyjVuGHruzlhPelIAQUSrFIHp5ksvgvQYNUrzneZvzUFxTXP5inIBmGRbiF497EEoij3bVpGtnY+OVzPoXcmvwdReGxPsmpN0MgsGHZud4XrZeL14U1Sik96g7w+XKWe3VaznHjZoAaqI/+bkr5mmvfwKEHK4VkolfmBDUNLiOtwU9qebQ3IprjHyBXEgCEpbX4IpcVlfyEKOBZIPV4ym5UTfR73oRFVkiLpqFyU2gvdeI4VcxBOXJbpYFYSsHk1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UprNmBBCfV+5US1pr6IOD4I/vrcdJPu4a7Gbv/Re0NA=;
 b=T2Esv2iutQIHGqX0HlSj3EktjY8YnFKeiO2tf5sHwtSjW5SvrCOmTPcj7r/+jJMhZVvO+uLz21JVcz4gkWap5dGO91cyja+OB0UwC5AtjqM52cgh2WxcHoQh4yhhfklLsVyJSNgUUXk8QbPwn8A1RMCnJMVb+uuj+40wuTDFydc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 17:10:55 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:10:55 +0000
Date: Tue, 31 Mar 2026 22:40:48 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Message-ID: <acwAGPB/38cv2oB7@BLRRASHENOY1.amd.com>
References: <20260329203811.2590633-1-superm1@kernel.org>
 <20260329203811.2590633-5-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329203811.2590633-5-superm1@kernel.org>
X-ClientProxiedBy: MA5P287CA0224.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c1b1b7-5785-44bd-4786-08de8f487816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hDWQHhpF1qgKPAF9VEW2bWhbGX6/6iSbm9LJbRzQy6NzQQJ2LCoz/gyN6Db++yVzIXRAsilo4bp7rwKM5kgjRvkh9AbAcI+lozJj/j/6sjhh1dgDA0gDr1OO/W159PLhHYbEb0CGwFyf1JR8RfSpQSeqQvkVARSf0IhSkn8uNECa5c+hjMBBFNKA8I9uzNZSQevt7gwMo+7d4UkO0Y4MxE3JmE+VQ4QeyKWESiboc+hHLXQHHJ/JTH0ji+qn9JD58lLaep2McaSDQ5by3xdGx5m55ro7LCJ5X77lTDzxp75GxUzOVXQBr423aG6f7h4oZmZaHKKQw7cJrGQKpeG34DPNmom3FusgelYcLD6ygBlJVsobVOflZIPI2c8LWUJ1ZOhYsS3zEtGSk3OfUbPbRurUSt/EWAipO55Ny50tDHqQ7QQ1/Mv8AIp2K6X24sA1a2Zc2ZTEhJc0dN4Fh7Bqr3lxcxaNLQcsrnpHoTA7BwqD8EA2SklhOupVSn+AseAycOfk8qmN+PrHlg8DtX5g71x+KzPM0TiDqoTg+o+TSSI2ahkrrajGwzUSzUvyqeN0er70Ndm0K+oplUXa5kEVX/FBs7nfnSPtxttg2MTub6rIII3jdXbmoP1lRfq8Q9JiTZcW3VKQ7sIWGCI1NEqfRuscx137U4gBskoom0bvFQn/OZbMc2SLyYTTkD/fts5fyuqAcS3sEt59oOtI2ZkPZ142hYLrsTpZZnLq62mXIfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLXnSS2Y2S5idQwyd8nKj3awZobEXRmEOxOKh5nLTvygaYl6pKoc9s0Z6XE7?=
 =?us-ascii?Q?+kPHAWb3g9ZN6KuMgn6QZ8CHwmdlIrzg2yy/UOK5RdeWcdDvxQNycbMfWLSr?=
 =?us-ascii?Q?B1HgcDMZ5HkmlDzOSQ1MyII1uGIfSdfe/l80MSi5FO+V9IywSIhTTEhfD9Xv?=
 =?us-ascii?Q?b2TPYacuS7JHdjGAuurgUmuDnEZt/ylFCoNwPqpjdEnScaoWiSet0lMbhsq4?=
 =?us-ascii?Q?LKnC5aeYyAm+yTkbEdIIeiP0eOjkYKRR0NnX0QR2MJ6FqQCzEAoGESWN9Edu?=
 =?us-ascii?Q?NRrKzA//rg2dmXsrU7nvTSAiGjnjIRzra5uCrW3BXZCeNfOevFYhyI2P+pH8?=
 =?us-ascii?Q?SeCxNztgM8fvoyXmYsOSR70kT3dQnbAgvoUwsX8h8U6YNnasrelp+yANfZ4A?=
 =?us-ascii?Q?Y6BbUnHn2adx/iyS1S4uamBoVADECNnaNWOVWIarZAHmx2EhP9jPsjFhWzRM?=
 =?us-ascii?Q?YMnH5BYwZQ3s3dBvba1V+Wx8Uj9oM0yXYRZit2sARxlcz738ao/IfP+CKNFi?=
 =?us-ascii?Q?UKEpx777xm4uFEDMr/fi0u0dQZ01kWa1k/gyCSWq+TdZKqCQDxbJm6d9QwxB?=
 =?us-ascii?Q?qht4aSXU8ImJlKHTgEAXbLANlOUJC2Gg0imIqfDjnxHyv8JVFBeFMAYJ6ss4?=
 =?us-ascii?Q?CoPd4KKi2XxEXRIjlGob4WBy8tfIcwXpKfqpyopOmnkcm6ogdpqYEID0apZm?=
 =?us-ascii?Q?H0Vb8bT9ALlVglVnXm+766UBzaHF8jtCq+HvlB/nocpE+7XBzab3ygiHDSSe?=
 =?us-ascii?Q?GazXqu0LDDO8WqkqFxoXtNg4MKdcSA9uml9R+LKjGM8fMsmU5jnbJWGRU4vv?=
 =?us-ascii?Q?NbTL5/PMHSN1RpYDq9yTa9sycRsFvyZabXiX64Gc8xSZnbtpM2Bnk81Fjufl?=
 =?us-ascii?Q?3tSqC+lhtTp3v+eNjv15wjAUsZv8SSchZ6O3zNLEd9bgzf2Pz33PcFkucbjq?=
 =?us-ascii?Q?lQ47dO5tT+SyN3pFWUUObCr6XxGM5WEYC6Hhpe+gY0+xG3BpPKO8WTwNZ3+S?=
 =?us-ascii?Q?xf8v81mYo+m/n+ca+FIDZBofQN16BZg+GVeEZ6xwjbY3SVX0jyAz4hivfFnK?=
 =?us-ascii?Q?whq8wYdWUc0NqS+w5m0gtUqb+676GhA0dX74tBXvmvi5JQBopT+yMAyuTZ10?=
 =?us-ascii?Q?6A+AoBgeSETDXSBB+kqVQU1rlQQiQ/XVGhYupCiOaFYm1cmno8CaPSQRY4lE?=
 =?us-ascii?Q?QyJIShI0s4bOdBokMC7VAqetUWm65IEJGKpT9RditI6Lg7zG3jqHGUCxaWwG?=
 =?us-ascii?Q?2FejkA4knpvgva4CAmBa7I3DONgYsZOyev4p13Ml/C3KAoZoYAUadHhyBI8J?=
 =?us-ascii?Q?NhZjOVuaoi+85rWRT8QniwGdAU1jWQJL3/nwcv063hFem0KSKFhhomoSaWR4?=
 =?us-ascii?Q?NKabiMuvLz+Wo38Sio6RSpsNS2LHa3bPyvVVu4NJy64Hd+TF8+8msWN1Grml?=
 =?us-ascii?Q?qYkRXQnUs4ExFDg7hvVwaXydCKqpjw2MnT+f/ZacyaLJC/4mtzmfT3wr5E6J?=
 =?us-ascii?Q?ObMCkjDp/P829kFBtAciJKvQjq6NZGJT2uH5thO8g7lrvsQFfKXcA9MveUIg?=
 =?us-ascii?Q?P1rvCqxNyCxnxSnu4ezBVIijuy7zHUBUQbhLn/k6N8AQKZxGglx6bGuW++ym?=
 =?us-ascii?Q?KORpruLYEpsAyGF9IfXyn99PWIkpiahBCOA91CR9Saps7D5+7r6RLhLGvZ7J?=
 =?us-ascii?Q?DdJrdafFkXIPmJdS8OAgXyaqxox358n9MPlvX2Z7dQudjeioeu42oAzuIHWt?=
 =?us-ascii?Q?7mQfso7PjA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c1b1b7-5785-44bd-4786-08de8f487816
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:10:55.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPR3ibmeHzr3QrD6NZW97i1UfOX1fkxAq9wEVlftWGzhsIbYLC0hxgwNZsSCH7j+Ze8LJCE0uAEUF1nr2tfFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

On Sun, Mar 29, 2026 at 03:38:10PM -0500, Mario Limonciello (AMD) wrote:
> The energy performance preference field of the CPPC request MSR
> supports values from 0 to 255, but the strings only offer 4 values.
> 
> The other values are useful for tuning the performance of some
> workloads.
> 
> Add support for writing the raw energy performance preference value
> to the sysfs file.  If the last value written was an integer then
> an integer will be returned.  If the last value written was a string
> then a string will be returned.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v5->v6:
>  * Move the raw EPP parsing and readback changes into this patch
>  * Use the kernel bool literal `false` for the raw EPP tracking flag
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 16 ++++++---
>  drivers/cpufreq/amd-pstate.c                | 36 +++++++++++++++------
>  drivers/cpufreq/amd-pstate.h                |  1 +
>  3 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 2d92c8072b83c..6ff2b477f0472 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -316,16 +316,22 @@ A list of all the supported EPP preferences that could be used for
>  These profiles represent different hints that are provided
>  to the low-level firmware about the user's desired energy vs efficiency
>  tradeoff.  ``default`` represents the epp value is set by platform
> -firmware. This attribute is read-only.
> +firmware. ``custom`` designates that integer values 0-255 may be written
> +as well.  This attribute is read-only.
>  
>  ``energy_performance_preference``
>  
>  The current energy performance preference can be read from this attribute.
>  and user can change current preference according to energy or performance needs
> -Please get all support profiles list from
> -``energy_performance_available_preferences`` attribute, all the profiles are
> -integer values defined between 0 to 255 when EPP feature is enabled by platform
> -firmware, but if the dynamic EPP feature is enabled, driver will block writes.
> +Coarse named profiles are available in the attribute
> +``energy_performance_available_preferences``.
> +Users can also write individual integer values between 0 to 255.
> +When EPP feature is enabled by platform firmware but if the dynamic EPP feature is
> +enabled, driver will ignore the written value.

Driver isn't ignoring the written value. In this patchset,
store_energy_performance_preference() returns an -EBUSY when the
userspace writes a value to the energy_performance_preference sysfs
file with dynamic EPP enabled.

     if (cpudata->dynamic_epp) {
     		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
		return -EBUSY;
     }

So, can the last line needs to be reworded as

"When dynamic EPP is enabled, writes to energy_performance_preference
are blocked even when EPP feature is enabled by platform firmware." ?

Otherwise the patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
