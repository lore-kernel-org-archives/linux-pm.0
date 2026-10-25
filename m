Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964020;
	b=2/Y6HLlJdL4RgbJCq9g3bQBPPJVcdEfKLgTd574BrFrgvyqPJgXvN9GupfSRmpY3hohK
	 9yEtLQFvJJdUe0In+Avl19l3vmapSa+BOpNg2g6QuFi+M/2g+75NkCqmaDFSpvwRUJZ6L
	 oNWK0DD6yg+FF+J6/l5LBvzLU+ppgq9TVLsLdLiA0UwZO+5iNeHKxlPA3u3BnnFaIA1F0
	 kubfk9G1IPRuMMHgG2X1QiPR1OVenveZhP9JX8jIHGFhhYgpZcIN5KPJpVhwpQRsWht7T
	 fsMNN4RxyXDgJUNXEcWbc9EbUvMs/1ebq0LRlmuePFQgOW0upCCZ3+Y6rRKZ+impSEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964020;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=bCeBiP4TEGfXDJHTUIpc3BSx1j+qo+oOhdpPxAFqvNA=;
	b=YWyHH+Fpe0coR8G9k66K85yY18auCAXwGcs4r2xkUvVuLX95dbHvkI+kNtPM2h0CDko4
	 1qYp0BPPkghu7YsC25MYdEvKvKVVPuorxvMJpAaO30NHoxyeWR/dMIM++BwZUoIf9WJ+m
	 0S3dwzmWy+HU3l0pUeOAwv8Rj1Z/h1kcYnnI7A4GzW8/40/GQEgjHeaI8a8LgeGhyq9+p
	 Kw5wOr4v0hwLLgrJf7waFMG5JK3yPn1kXfUds+4VLPUgGRCLtieUOV0bYkISgp0oSGEVi
	 HrIaAICZFuBX6pHWZPLLQpIBKQ5uzfRwZt+ayNHBK0UR92PI9mHgQJhlNDwO1CA0iXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UAahpXRU;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78515606A31B
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 21:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78515606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UAahpXRU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792964018; x=1824500018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EsE4PPoZHD1V2Pc193zgE2Sb3sShPQpeFGrEjpPRMWA=;
  b=UAahpXRUcOH+rD3CalaS2s56isFSRNVaE+4zok0Lr8GMjsXAluPaAp/X
   pr/PAiCp+YjgzIc0DD/MfFE2krpPeTBkMQZMxH6oykRz6ocVnxjMcSbsI
   ADa7tYbOsmQ/nlbyHZNM4e2vwD4e0oMyHbctzYqD2ZY9UyOXAmdFZq+0J
   eA9EANaaSGM7RMh5wQX3c9itu0EMBzFplRfU+zbhGZuq1OMaCruDyL18e
   CVtHrEcTahum0obZ428rj2wwEMIw3r6ZjOHBUQtIsfCTFheOgVFD9EJvT
   pDKEgSG1SMiAyku1OtTeG4tws+v9SN/qAYVeVRn4xo1WDmqu6wBNt4/ab
   g==;
X-CSE-ConnectionGUID: mqOc1aCsRfu2gM7pGpM3oA==
X-CSE-MsgGUID: KXsdfdL4QRubMT7js6Z+tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1656430"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1656430"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:33:38 -0700
X-CSE-ConnectionGUID: LFFAC5SKT0+pO0F0k+lf9Q==
X-CSE-MsgGUID: RJUMbY2FQSmLLf8GmSOfDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4479089"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:33:37 -0700
Date: Sun, 25 Oct 2026 23:33:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 04/18] x86_energy_perf_policy: Cleanup: Harden with
 strtol()
Message-ID: <at51rncC9c0LTqp7@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <4a9e2fb9f00e2ead8dc9af9e285c19eb21b5f9a4.1792428130.git.len.brown@intel.com>
 <atjgkFBFwBgCZJH3@ashevche-desk.local>
 <CAJvTdKnYCAAKquPZ_aa16htpQoS3BR-MAbZ8c+YXj23eZ4QLMw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvTdKnYCAAKquPZ_aa16htpQoS3BR-MAbZ8c+YXj23eZ4QLMw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 01:53:00PM -0400, Len Brown wrote:
> On Wed, Oct 21, 2026 at 11:56 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> > > void cmdline(int argc, char **argv)
> >
> > >               case 'u':
> > >                       update_hwp_use_pkg++;
> > > -                     if (atoi(optarg) == 0)
> > > +                     char *endp;
> > > +                     long val;
> >
> > Doesn't this require {} scope in the switch-case?
> 
> added. thx.
> 
> (C99 lets you get away with this, but braces clarify scope.)

Right, as well as with the definitions in the middle of the code. Maybe define
the variables on top? (I admit I haven't checked the style for this in use in
this tool, but if it's already uses the C99 approach, I'm fine. Otherwise I'm
all for consistent style.)

-- 
With Best Regards,
Andy Shevchenko


