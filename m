Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBB347505;
	Wed, 12 Aug 2026 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528520; cv=none; b=uP0rgsjB9NQhzbfhZ9BAkNFunZTxDYlnS0LFh8Df9g4oEPLaWfh4A+LROutKyWRdDnikAr52/NOKLcemUFfjDLsBhjxWxRYTDmgK4Xq08JU78RNlW2Z++HTi9TtCKb76XKdd8Kct3KGA6rwGUIt5WpJu6IXljaalNx6WMBlc4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528520; c=relaxed/simple;
	bh=IGr9bpzx0QdRO45RYN1k9sKX7KsNsEZO7uoUjibMMwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdzieYoHufp3iZZ2QvfS5TT53s1ql39ilFN0l5IfUH4d8ewTLYun9HEzs+a8+74G1jmLP1tBcKh0kLKky3I5OK8LLZiYUGXMr5o67H74nueMlLaBFFGXHICPJ3APAT3ewt3NLseLwq3alfCTYfT5IPPvUJk3xrLuzQyih22sUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQPj87FZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQPj87FZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786528518; x=1818064518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGr9bpzx0QdRO45RYN1k9sKX7KsNsEZO7uoUjibMMwQ=;
  b=TQPj87FZldJ2U0rnaTXGyUiVWfwWHAoKDr2//Tj+bGwA4ZyE3PBTZnJZ
   YdKe2PaQopss/ams4b27h1OKyXLLLhPBZKZN4YaxqaZYY3rEh4QFtC1UK
   lXmS90wVwaPOn9eMrBSrpgFGbjWOAXltmZfb06ytxg+4sF7isrxr4t+mk
   4CPnc1PU4UEuDHDJocUAnpzsQo3apVozztbQy0sHbS9b15d7s14HISxZT
   vOYkuGBL1mIdJaHI3xWktV5yzEOa5EFenGy18/Gx0L+5S9ltCS48oHu95
   8toJdjpZlmi/fyxjqfpc/fUoPKDQA9yvQwEsKT4hUfl69GdGU6gv0sDv8
   w==;
X-CSE-ConnectionGUID: t0efgcNFRAKakLiaM8Us0g==
X-CSE-MsgGUID: kW5G8erORoqFkRlcA0DkeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="74614509"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="74614509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:55:17 -0700
X-CSE-ConnectionGUID: BfsnYl5tTZKoliTyU4cPKg==
X-CSE-MsgGUID: fscNzpGsRA6jLJb0ioZPwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="259347022"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:55:14 -0700
Date: Wed, 12 Aug 2026 12:55:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <anxDAHFnRTgaFEsZ@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
 <20260812101050.575c9bfb@kemnade.info>
 <anwsIK9ITpcDkZos@ashevche-desk.local>
 <20260812102536.63579b89@kemnade.info>
 <anw9KgvL1Yj-XdZc@ashevche-desk.local>
 <d35618a1-9806-43ec-895c-79c45218cfed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35618a1-9806-43ec-895c-79c45218cfed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 12:37:49PM +0300, Matti Vaittinen wrote:
> On 12/08/2026 12:30, Andy Shevchenko wrote:
> > On Wed, Aug 12, 2026 at 10:25:36AM +0200, Andreas Kemnade wrote:
> > > On Wed, 12 Aug 2026 11:17:36 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:
> > > > > On Mon, 10 Aug 2026 13:09:07 +0300
> > > > > Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

...

> > > > > That code is complicated. What about a generic 16bit non_2complemented sign
> > > > > to 2-complemented sign function/macro. Such would have prevented the error
> > > > > in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor
> > > > 
> > > > Do you mean existing sign_extend32() from bitops.h?
> > > > 
> > > 
> > > I don't think it does what is needed. Here we have
> > > 
> > > 0000 0000 0000 0001 -> 1
> > > Usually we have
> > > 
> > > 1111 1111 1111 1111 -> -1
> > > 
> > > but here
> > > 
> > > 1000 0000 0000 0001 -> -1
> > 
> > I see, wouldn't this be then as simple as
> > 
> > 	sign = $REGVAL & BIT(15 /* sign bit */);
> > 	if (sign)
> > 		$REGVAL = sign - $REGVAL;
> 
> I find this more confusing than the current idea, which effectively is:
> 
> if (sign)
>    val = val_without_sign * -1;
> else
>    val = val_without_sign (* 1);

If you have other use for val_wo_sign, then you can even drop multiplication.

	val = sign ? -val_wo_sing: val_wo_sign;

More comprehensive view

	sign = $REGVAL & BIT(15 /* sign bit */);
	$REGVAL &= ~sign;
	val = sign ? -$REGVAL : $REGVAL;

-- 
With Best Regards,
Andy Shevchenko


