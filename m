Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E43659FB;
	Mon,  7 Sep 2026 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754897; cv=none; b=Hq5K+M8LXlz1exw4dm35zfReAVQkMQIqgzhrg2Lql4n/25PZQlW6KTjbSaWLIsa2nrNTqqd8kzJWhXS4OKPbgr1ksJ5wk2IfWZQm/eRuNRxnfGx+tAz3WmvBc1+v8ksX0IbF5adz2uMKif/zVTv/Tlo6uX4aPIBSxyXaQqJSsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754897; c=relaxed/simple;
	bh=L0YjNRXW5u+LOiSK0GSPT/EXE8d9hdXqOqNLLt+/bi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l15s3gr5aBB2YZg2rK1eRcVoecalw19QDXAw6wt39bFM9z15ERwNW+WHnJQ+wr7Zth7UBaWAI6A50opKeYa3nrkHFSGrlszXd+k/J1PdAI4BiLDpJmz1cUesOkeZBOlG8kMUhqejzULSW8p1Mlrsh/kHfB9QFSimz36Vh2L1gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMDVX5VX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMDVX5VX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788754895; x=1820290895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0YjNRXW5u+LOiSK0GSPT/EXE8d9hdXqOqNLLt+/bi4=;
  b=lMDVX5VXb23mUXOSBsz6tgYGW7eMQAonmQmyVmauhr/WUZ/ZXf+LjEEd
   PFqaYdCiLFHQrgaBugKLCH6IfYlnwls7kvQVetLvwS0GbzFM5sCgrb8sm
   6Rz/irumGV09iys57jRzJVpRoNapnbGwkYnYp5wLnuqA89tBZBmFZUuZg
   i0HyHIVrzPqloolpJbnWONSgaSaCZcGugGyxOlwTjpoGXenk1JpOsvoNg
   0vuAldOsfiIcNT7U8+yfWoCSsbr1oMFCydp/oSTwIJu2KZi/xkKu76YvX
   GOaBkbGAtaBArQpSOaMw4BoRyt2EOIBugxqj4DgGgx4dGfL4ZhgCxH7AT
   w==;
X-CSE-ConnectionGUID: xeEWFWvwTTOmY/RcmKOayw==
X-CSE-MsgGUID: QyFoL/oeTNmbypQ4n1Cv7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89027440"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89027440"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:21:34 -0700
X-CSE-ConnectionGUID: bWbZ6HVGS9WDb2a37thpAw==
X-CSE-MsgGUID: KMlHkFpITr2VCK9sb8wC8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="271122153"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:21:33 -0700
Date: Mon, 7 Sep 2026 07:21:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1 1/1] thermal: sysfs: switch to use scnprintf() to
 suppress truncation warning
Message-ID: <ap47yiUB6oBihXiv@ashevche-desk.local>
References: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
 <20260905105832.12192997@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905105832.12192997@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 05, 2026 at 10:58:32AM +0100, David Laight wrote:
> On Mon, 17 Aug 2026 12:33:24 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Switch the sysfs code to use scnprintf() to avoid warnings about potential
> > truncation of the names of the sysfs attributes.
> 
> It has to be a 'bug' that 'format overflow' warnings are generated for
> snprintf() but not for scnprintf().
> They really shouldn't behave differently.
> 
> I did some tests a while back and the warning goes away if you do
> 'some things' with the result (like comparing against the buffer size),
> but even explicitly ignoring it with a (void) cast isn't enough.
> 
> Using OPTIMIZER_HIDE_VAR() (or an _VAL variant) on the buffer size does
> stop the error, but I expect gcc to start checking sizeof(buf) as well.
> So both arguments might need hiding to get the warning ignored.

Yeah, but in a few subsystems (mostly visible in 'input') the technique of
using scnprintf() is used when either it's and ABI or we don't care about
possible truncation.

-- 
With Best Regards,
Andy Shevchenko


