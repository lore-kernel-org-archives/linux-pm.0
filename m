Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601152;
	b=LZOF+M4bykfI0s61D93FteRv/JHIt3Rt/z/KcK1MlW2WF84Uq0quVYAemK1TJOTcBfVS
	 WOkx2nFxYI2oLKnIhBLPegEo8U3haO8OYJ1TX/IxzBB1TsAaNEGEsqMANCmBDcvcNhpP5
	 ppWstKrEGfjGi5alyrvnJjyJ1fDg8cImbIOmY+Y4DNBlynkG/AypshC/jtT+IgAZhNnaw
	 CeuXKfKgFaPwEkHvq13i0DH4oQ93Oec0V851pM5u8ssMTYWGjZ4Kuo3R2WII/qCsuvOa9
	 skzTkjWbrIjmel8WFcfLlvL9L/dj0vjC+C7L012Q2LT3F985MtEJSyhjGXFffffc4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601152;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0qGJqUggE3YMEWQAKjmj6RkNHsJ2D87NSpa/AXIcwN0=;
	b=UYvZumx0XitwSmBg/qFA2rUE27Qiisp6ykuz+t4eciAm8dwfftP7PxbH8V+JLyYL66r4
	 lEAaHGLb1RjVjcCvMbcEzQkPxySKcp0Aw3p6pd8SGgjRFWzeF+7ZIyRIHTPFBDtSGBz2A
	 GsCgDkWEAVQRlMGtuesY2gHMyfEO3zYm/OEo4aWA1jQYhnzeN2/UN3TfpEVpcbd1Y2Xkq
	 4DZHSzlJW1Rf29sjQAF8ZKWGEwDqYFIz05ET+QxPfHyh4pJ1AcWT5ECJ8BA1N+rHEmQPh
	 IFDOsiqqu9MCgyy6ubxEJz4kboNcaUOqoLXze4w1AgVI+g4qVvfK/aYyGpY9OcKR1bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8jOap6P;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D8606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3D8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8jOap6P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792601151; x=1824137151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSXyPVvN24pCLhjDH597VsWfiOrpk1V62L34c6PTX4c=;
  b=c8jOap6PAHIdjFNb2PN+Jbp/TIJLTMwjAmqPSVcac9DHi4V/bPlPT5y2
   wGQLHEe06svC7wDX4kgurpoUsz0JhPlZnBLayoiwqJhBg5owSYJ1gk/YA
   fHLOJOp59RRKrz+CmCBar4iFykE4UdJ37QmtZYdd6A0ZJ4kxmKY4R4lMc
   cSt9SsVhT7ZGz5MofPqylg/RWeviN7vZGiM/+DJWf6A5SRj5Be+bX3baH
   SpsTwoDwz418LZhJRUr9LCXd6XgI38C4TVCWlijMgjYZ02GbxVrFaSyLb
   6E91hWiHazd+v2oY6ftPwq63tePQUy0/KOuXawcaIODPJHHK1wnieDwHk
   g==;
X-CSE-ConnectionGUID: 1wz12f9ZS4OPdryCg24MDA==
X-CSE-MsgGUID: XnCISadlTp6hRPfnWM409g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1313515"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1313515"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:45:48 -0700
X-CSE-ConnectionGUID: tlh28Z+kRf2w+mgCc6UV0A==
X-CSE-MsgGUID: DyBKu5adQvuQYUn+1EEpEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3472355"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:45:47 -0700
Date: Wed, 21 Oct 2026 19:45:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Amarjeet <amarjeet@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 17/18] x86_energy_perf_policy: Fix write_sysfs() return
 type
Message-ID: <atjsOHX5Uibb-CqK@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <777cbe6f740ab2e371df856c716ffe41117940a6.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <777cbe6f740ab2e371df856c716ffe41117940a6.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:38PM -0400, Len Brown wrote:

> write_sysfs() returns an unsigned int even though it returns -1 when
> write() fails. This converts the error to UINT_MAX and can cause callers
> that treat a nonzero return value as success to miss the failure.
> 
> Use ssize_t to match write(), update the receiving variable accordingly,
> and explicitly require a positive result in sysfs_write_string().

...

> static int sysfs_write_string(const char *path, const char *buf)

>  	len = snprintf(tmp, sizeof(tmp), "%s\n", buf);
>  	if (len < 0 || len >= (int)sizeof(tmp))
>  		return -1;
> -	return write_sysfs(path, tmp, (size_t)len + 1) ? 0 : -1;
> +	return write_sysfs(path, tmp, (size_t)len + 1) > 0 ? 0 : -1;

Wouldn't it be better (but I haven't checked callers of this) to have
other way around?

	int ret;
	...
	ret = write_sysfs(path, tmp, (size_t)len + 1);
	if (ret < 0)
		return ret;

	return 0;

>  }

-- 
With Best Regards,
Andy Shevchenko


