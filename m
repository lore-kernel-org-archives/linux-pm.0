Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598165;
	b=n1ALUBbEGChJWTHxdTqYaqfNc1a0hC+gXbyioc5g02sdFOTS6ds8FWxEtk53uXeDJBfo
	 wvhqNSiS4UnIJnq8Ggre361ex3CeT5ePu4YaEtqPuHJlC2SN6Az6BwHgxF9t3HZL2Up2u
	 bVmUJmQaOUZNvob92MibTQtX8HCqdIX1ChfOjGz72XkfBqt4kBwqjG1KGu8tx5IdksbT2
	 jCeMxiXvDFP9kl3NO6PzlkxNFPyOSmGuGeJ+6adGjl2uxfR2CPURsRRiBX7wmnm8Ogh4M
	 qYuj3xlqbM96mqpIjrrn4TJCaeqpBh7fsVlHMZImV+13mhg5L0Ttfi7zkrddTEOKTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1ClLyP8MaR4O5Sd4eHo7wPZhAszZ9B9ySs8DyBd0lFQ=;
	b=oxcvtUmBbanbvnJqJmkdlz2vqbtHRmybarPu0XoUhyW785zKOEeGWiQP4Z6Ogag9xBSb
	 1DStQPLKs4b1G2yVPqi9buw+yISUyz2CI3sshHDT12t6W1+0YwgWPwuEarbduV8ZLbv8X
	 lfWTwHXt/6JSp74M6p2l5vH91UE4X8G0N/C9cGTFDs3YxK67L4zmVhljlBNhzmVVE+hu+
	 9wzSbOJDlSVMVzDdyKTxztS8Xrv4I4yP5OwkDMo/jIdIlk1PqARF69VFIxOWKSwg4BJXb
	 5Yrrw59f03oVfGGwzkNlB4Qq5dMF9Z7q2kyyLRAEUMvVm0roIkTnG32Wk8C+4GdTUsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="j+wxFAQ/";
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C2606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 15:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D6C2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j+wxFAQ/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598165; x=1824134165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/dmTTIa+epTwBWL/ZqTArdNnz7SMoVK9kk/Iff1q+t0=;
  b=j+wxFAQ/kqe0cylpsueLKpNsl18cXXtmShxll7FBufU2UDYp7qNLnD1m
   EsclsS2wb5xywkqxvcRjMEBkzP/rBi1MmQiJKdbfoZlQ/0EhawMQtauC3
   +rWB+O0JoaXJLuZZ22/kPJjQd4t42WhXY0xrnjeWceY05m1jL0vDGiU3A
   a3gKsHM51AhRFs3JkjwAmQ5y8fxuB5HFtvAr1CEsepJ5iMbTuLmWTlxw0
   uPREsIlOWQrQIwB0RO4ZrGxHKfuH5mGEXJJFOl1cn3YQM+jqeslEaP2QB
   Bf48wkFbK8xzOt4xgs6U4V0qsFzVRlJpY58oPtez0QtHSVmFW48eo1U+c
   g==;
X-CSE-ConnectionGUID: fyRTYUuWS/axnGmJtM/eww==
X-CSE-MsgGUID: 1SjZcXEjTdSvJY2NHxo/XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1229923"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1229923"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:56:04 -0700
X-CSE-ConnectionGUID: FEZFuILBR+ac/oSF0n9lGA==
X-CSE-MsgGUID: tTvgl8yHSGuMUZoWnza3yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3046692"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:56:02 -0700
Date: Wed, 21 Oct 2026 18:56:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 04/18] x86_energy_perf_policy: Cleanup: Harden with
 strtol()
Message-ID: <atjgkFBFwBgCZJH3@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <4a9e2fb9f00e2ead8dc9af9e285c19eb21b5f9a4.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <4a9e2fb9f00e2ead8dc9af9e285c19eb21b5f9a4.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:25PM -0400, Len Brown wrote:

> Replace atoi() with strtol() and proper error checking when parsing the
> --hwp-use-pkg command-line argument value, and other spots.
> 
> Also add explicit check that value is in valid range [0, 1].

...

> +	errno = 0;
>  	i = strtol(s, &endptr, 0);
> -	if (s == endptr) {
> -		fprintf(stderr, "no digits in \"%s\"\n", s);
> +	if (endptr == s || errno == ERANGE || i < 0 || i > 256) {

Do I read it wrongly or should it be i > 255 (as checked below)?

> +		warnx("bad value \"%s\"\n", s);
>  		usage();
>  	}
> -	if (i == LONG_MIN || i == LONG_MAX)
> -		errx(-1, "%s", s);
>  
> -	if (i > 0xFF)
> -		errx(-1, "%d (0x%x) must be < 256", i, i);
> -
> -	if (i < 0)
> -		errx(-1, "%d (0x%x) must be >= 0", i, i);
>  	return i;

...

> void cmdline(int argc, char **argv)

>  		case 'u':
>  			update_hwp_use_pkg++;
> -			if (atoi(optarg) == 0)
> +			char *endp;
> +			long val;

Doesn't this require {} scope in the switch-case?

> +			errno = 0;
> +			val = strtol(optarg, &endp, 10);
> +			if (endp == optarg || errno == ERANGE || val < 0 || val > 1)
> +				errx(1, "--hwp-use-pkg: must be 0 or 1");
> +
> +			if (val == 0)
>  				req_update.hwp_use_pkg = 0;
>  			else
>  				req_update.hwp_use_pkg = 1;

-- 
With Best Regards,
Andy Shevchenko


