Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730748;
	b=vTio4w0gque6/RFs+Dt2BHWqpmh1fgHMbhgbcbZ9ba3RAqFIx+FGdGLWRRjdlkYmF4ts
	 HWLe4KaqtMarCnhNTCJOtMhdZt4ZapTsNCu0p2+2R+MWJ0KfpBMHiXoTYvI5KLSxyCU3R
	 jODW4aWTSkiZLL1qYVRAz+Rl9KQL95wZUNUUHCMDlrn2hvlfW3p3lb8MlGHx3aZcpqZdZ
	 AcxidnH8drMut8rj4cJQ/aHNZmmuVJWcCj05vFcuDho46QMRzXPtvcLtDmnaPapCBFVz2
	 bMLs/hU6BgNMoX5csg4CtDC5W6xUf2jLKcCq5FvShzXUCaPP5cdInwf0tJVnnmMU7zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730748;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Pspx6UQNd/oTSgGq1UyOR3HL73qOWegJf7pwb3SkVe8=;
	b=yi8+3I01zKtFerUCoMIYjuT49I2tXTkSQC4ZunYYI6LIoUMxtvnWIfMXmZygKRIDpZi4
	 ueBevGP7c2amwyT3Sbp1u3lc9XBOXa1eaYHaxaTt3LRrKYgaB33DLmKfZACUXjFIXeF1k
	 v7fBXVybtjipPkXD3I6ycWs6Amhaz2qP9+HM3j6u/kNrnDR5/YstZYyA0bOMzo0TLFsH3
	 ePhoZUgrVElSj4nN/JWvbJpYZ7Ex6JbBysQEQLWsUh7SLBH0VVHDVR3CHsxErUIO+fGsc
	 Bd2sDnOYOKD60mrf3qryXO4k9kshNjNyoF7T6+jMPeFRPPRELFip6vIg2EMXETSYrlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lkptlvVJ;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CF606A33A
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 18:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956CF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lkptlvVJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793730746; x=1825266746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x3hhHXT2I4E3JNy9aGP2VSmh9c4QnlhI2i6kllQ9YUk=;
  b=lkptlvVJJzc6XNsNHM60rcm9q3sogjDypx1tl/bu252W0FGXC0PJ0p3g
   D6zth/hKkIScBCIb1NBrRbtlu5IlqVQ1DmxYaIGyDD7wGXNgsPB3RCJLn
   h/lg7vzHR3A8YfKQWYZLI1U6qXzFZR5yrQu/A+CHh9Wobj2ypupw0dmBb
   5PlyEfaGZ2ieXEHNEmdp6QXF6kkNrlQLMTEAWKuEBoOJeDtKoUoHT8pAO
   UBwy5QAeaDaLioKNzglp+feu7iPt9pgbJs6cDsRoJaulGFz75frzHPJ3E
   F971K+yyTqrGkp0ykAUZlzIbILdtjlfNVvRxfTJHrGcuCL9kbNVX6L+hc
   A==;
X-CSE-ConnectionGUID: FFmp/djMQSioQnT3TZgLQg==
X-CSE-MsgGUID: PQoR03TRQgGk0rVaBFbqng==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2477536"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2477536"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:32:26 -0800
X-CSE-ConnectionGUID: kyWrdDAFQruQlxv+E2acHA==
X-CSE-MsgGUID: d82j2FjMRgK5qcTY54OB1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6620534"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:31:51 -0800
Date: Tue, 3 Nov 2026 20:31:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 01/16] x86_energy_perf_policy: Rewrite Linux/Android MSR
 path discovery
Message-ID: <auoolFrNA_NajjRn@ashevche-desk.local>
References: <20261027191550.369122-1-lenb@kernel.org>
 <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 03:01:55PM -0400, Len Brown wrote:
> 
> First check that the Linux MSR driver path exists, modprobe if no.
> If still no, then check that the Android MSR driver path exists.
> 
> Read or Write permissions are handled at run-time
> in the get_msr()/put_msr() error paths.
> 
> Create set_msr_path() helper.
> 
> Return -1 for all fatal errors.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


