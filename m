Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571604;
	b=JrL+sGUtOxGwD5ef+wvMcRCJMMKBdi6gV9e1+lbxVhnL7VyLDro68eOFb2LrdABT/26Y
	 eZFJoynf60c4xNdbrdWr4uD8cqvMYD8I0lKPaSfR+PUKjqez8qQt7eYq+AznHTpVTzA+0
	 WyQ8fBmZDr58O1Z4lkL7sZW9pxv2MO2A5RepVrYmHFdvmGeWBF2P9GIpar8xrKTVltrDQ
	 6eCfNpqKQq9RZ1kKZTq2Ypzhm36FBP0dfiHHlwHV0HX0HsUstUOLONieUNWwz5c5GgUxd
	 upZSCozL4pFZxP8gfdI0diZP6QvQAKkvVKoShfSPcbttgn4v9XN7WUS30r02qMZpWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571604;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=XibVR4++0ano1k7EIcQQTi4/DKaQXvRKUIMoLRVIUuM=;
	b=mymbTAGtBEfvFLJJ47X5X7y3SRFweDqkcxhi1mWpyii4iE1Q1AYdlJzMRVDXnHqrFMyO
	 kl/jlE2LiUPTh1I2uXke8AWgzUiONCePCYySCseZFvAmFynIZ2OaNcpqTfIOy3Qgz+tnE
	 rNNIqTyuCAcA7F2aVk302G6X+JqPPLpz+y9TFVfEtufpmds26YvZUrWNd7y3DQj6POmRi
	 15+BtGm3tNxxfBin/1npQ/yzaNo3k95zUCfM3HW1BBjAbjHxgKcAHKJmol8M1tGJYyUOx
	 HR8U/LU6WMcrl2/X7FYntaE67wJu9ZW3TxkyqqsK1Pu8ACWHSn4UOYdempOz1aGgtMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LymYneI+;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760D606A8A9;
	Fri, 13 Nov 2026 12:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3760D606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LymYneI+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571604; x=1826107604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMnI9A8xhlz38ZEYNoRJ55L/QF/MRz2aXw+RPPOOULI=;
  b=LymYneI+3HC0mzrC98wOQINV9ebjaYrB1OFSK8QahZYSCDtEEQyheyuQ
   o4/hIECIOsO2TM3hMJxZo58BcfUWaB527ib8cuCyYXWqr2fXRgk9G6g1Y
   +MvKFCcEy4qcWqjIUPX7csLeN2A758G8SD314jCTS0+XeZBxYBe8bGyf7
   vZnaN9qyURLaEROvimLCGCrnYKCC6MvxM+wDyII7Ta4bPp8gfsHETlonf
   Bt5t6MdUETOYihJx1iKX7s3vS1/MCyP+u0jNsHUmvYfxWIIHN4IN4kQNV
   pXVnsb7rgv1h7b/M+lSfLv6gZyNX5yB7qOasxcgWYzr/fdcWvh5Z9rddH
   g==;
X-CSE-ConnectionGUID: PsQFpbd/TQuTsp1V3OkUFw==
X-CSE-MsgGUID: bFMNKpOnS3qvfqS369S5Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3264448"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3264448"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:06:43 -0800
X-CSE-ConnectionGUID: tNYvX78rTMult5cdsZEPXg==
X-CSE-MsgGUID: QJ9b0fGMRuykyNSa/ndn/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9325987"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:06:40 -0800
Date: Fri, 13 Nov 2026 14:06:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Safocl Stollmannovic <safocl88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, printk@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 10/10] kernel: fix duplicate extern declarations
Message-ID: <avb9Tg9_pCNjAPOV@ashevche-desk.local>
References: <20261113010631.139191-1-safocl88@gmail.com>
 <20261113010631.139191-11-safocl88@gmail.com>
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
In-Reply-To: <20261113010631.139191-11-safocl88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 05:06:15AM +0400, Safocl Stollmannovic wrote:
> Compiling a kernel module with a C++ compiler results in a "duplicate
> extern specifier" error.
> This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
> expands to `extern C` when processed by a C++ compiler.
> Since the code already contains sections that respond to a C++ compiler,
> I believe it is a perfectly valid approach to gradually move toward a state
> where kernel modules can be compiled by a C++ compiler without any issues.
> The `extern` specifier must be removed.

Do you have any use case in mind?

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257

> 

No blank line in a tag block.

> Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
> ---
>  include/linux/lockdep.h      | 2 +-
>  include/linux/printk.h       | 6 +++---
>  include/linux/sched/task.h   | 2 +-
>  include/linux/start_kernel.h | 2 +-
>  include/linux/suspend.h      | 4 ++--

This should be 5 patches I think.

-- 
With Best Regards,
Andy Shevchenko


