Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489504;
	b=3BGKWX3FdALjoi1oDF9LdV90KxXpw6Vl4Vn2Ul00S8gY9fbpQ83rjsWud1p76KWUxtqn
	 ySftHYY3aijv7uO1ndOxw6xMABhsK9JskHW0EXiTCdd93X5k2orqNgbmwIi9h2gsnO+g0
	 XtdKeK3lFmrZvV4HF0bdIDaasbbNm9nJpx46TDlwXC/EX9JflEOKHJYNM30rPaJ7Z9nDA
	 LL1CLYn4xb4h20nsjbQdpPs75f5dqC12IDgZxk3jYrHRxVW5bzPrDdGErNmq81NWKlj9B
	 QNTX8wNecW4s08VlyKZeV17yEgFahAcJq1ciz+u8xRyC9xT3ObYz3Y7VHJ0ainf0LTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489504;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=NbzvmHQSyvDO8eulL+NTiSPwzrmC6ADG/p4/yK6pxfg=;
	b=C1fOFHcOYIUQs8hxp0JAAE5NPpNNzBdoYjzLd+woVj0vrrsB5QTci5rUu6kPOcojvACC
	 c9E0JuK7yU3WRHCmXR0gXxW26iFxcjgBmdyrUoQ4EBKHXSu+2pRqU1Y18ezx8kGkcFW3K
	 KOnSwc21BLyhqx5qVFCZAnA7DxdfS632GNWE3geoo+oJMZutAJuDXNaAaGnplLUvyUV6/
	 9Twf1sm5gL6M+RS4EnGjNFSK2DCKEEv5MWMw20JPcVxfYlbpJV9u9MZa9L43myTgz2Nhp
	 sTrPGQo/bFlDYGBlE9F15d/KafpfRgcQp9Ax4/4xXpnWPiUv57qlSCuaocxr5qhOmlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FTWoL2Q0;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FB606A319
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B64FB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FTWoL2Q0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489504; x=1824025504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TyGi4zUGy2U7YPeNV0qzxXNa3sVd+PMmXV6QN0uN3/g=;
  b=FTWoL2Q0VQ4IyTGQ6ifIYRxoo5v8l3EpsrnqN6JL+nRs7aIIHxDecY5x
   x32z3KaklgayKBHTUKDH2d2eNauo9+RxPKA5FbiWVus6ucIH3MY0r0vmU
   gmG5mGVrtXtk3HKp9rB4nr098nXRqbD5jftxzW9PjM4c3htHKVBnKq+pf
   gNg0qsmOFNe7Z/sN+u55BVeQmw/OsAo8VdTf5t+vpwxOVZfP3/bV0J0Fo
   Cop4mZX2WeDeK2UOgaNDhiF9cbC9IEj2SvSz+JcZ+UGj6A3mx0K0zvMaq
   g6oBDjPTZs59EHUc7ZEWjmHv3JNP3aSl/IcApuetVDF/9UPYulXgkVoqZ
   g==;
X-CSE-ConnectionGUID: anPTVU4tQhaI1yBgwdDsaA==
X-CSE-MsgGUID: p+4JI+TkR92YA+OQq0YqhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1071366"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1071366"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:45:03 -0700
X-CSE-ConnectionGUID: eGZvcAEGT9Kya+sxmB0Y8g==
X-CSE-MsgGUID: JLDGfyzqRHuZf3lr5cLtSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3229149"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:45:02 -0700
Date: Tue, 20 Oct 2026 12:44:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 02/18] x86_energy_perf_policy: Enhance MSR probe
Message-ID: <atc4G50td5i1xh1m@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <8a047427531a00a7ceeaa389657c2d7bd1e2dbf4.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <8a047427531a00a7ceeaa389657c2d7bd1e2dbf4.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:23PM -0400, Len Brown wrote:

> If Linux MSR driver isn't running,
> modprobe and try the Linux path again.
> If still no joy, try Android path.

Isn't it too condensed? We have more room on each line...

> Signed-off-by: Len Brown <len.brown@intel.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
(One idea below, but it's up to you.)

...

>  void probe_dev_msr(void)
>  {
> -	struct stat sb;
> +	int retval;
> +
> +	use_android_msr_path = 0;
> +	set_msr_path(base_cpu);
> +	if (check_msr_path() == 0)
> +		return;
>  
> -	probe_android_msr_path();
> +	retval = system("/sbin/modprobe msr > /dev/null 2>&1");
>  
> +	if (check_msr_path() == 0)
> +		return;
> +
> +	use_android_msr_path = 1;
>  	set_msr_path(base_cpu);
> -	if (stat(msr_path, &sb)) {
> -		if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
> -			if (use_android_msr_path)
> -				err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
> -			else
> -				err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
> -		}
> -	}
> +	if (check_msr_path() == 0)
> +		return;
> +
> +	if (WIFEXITED(retval))
> +		retval = WEXITSTATUS(retval);
> +	err(-1, "\"msr\" driver support required, modprobe msr returned %d", retval);
>  }

There is a potential in having a helper

static int try_probe_dev_msr(int android)
{
	use_android_msr_path = android;
	set_msr_path(base_cpu);
	return check_msr_path();
}

void probe_dev_msr(void)
{
	int retval;

	if (try_probe_dev_msr(0) == 0)
		return;

	retval = system("/sbin/modprobe msr > /dev/null 2>&1");

	if (check_msr_path() == 0)
		return;

	if (try_probe_dev_msr(1) == 0)
		return;

	if (WIFEXITED(retval))
		retval = WEXITSTATUS(retval);
	err(-1, "\"msr\" driver support required, modprobe msr returned %d", retval);
}

But original is shorter.

-- 
With Best Regards,
Andy Shevchenko


