Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C163BBA0D;
	Mon, 12 Oct 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835113; cv=none; b=aU/VyiR5gASDqSjsk+TVKUm1q/izBPfBjLLj9VDjCORnXssYZ6Hkff3ZKZlA8p0E2XMQ5WHDo9STgKlTJ7GfWrIvKGVs2oLtjHeoAzr7Zx8O7HBSctxn5lBTGpn5gZBoGRP5aPsQAdQ04gbfeJfxExwcO3p0jQv6p7vm/HCWtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835113; c=relaxed/simple;
	bh=svyaTnJKl2TYexbkp/vhzflZQy5dYZbMzF9dkVFPBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJEVg6BUyK9Waa759g5kFIhr5rKLJ3n0HOUM8bbRg+M7u1FjgUnP6TEO4uWUyqVmsSr1BcC9mBYyBkIT8OQ0+WWTRdfeqyH8YGKjPpK1cHFqn5TTVSpstUJKQrvmxMPml3WTx3l1PVx57lmVFPmedji6vouAx+kzzWw3BNg0Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1wktWQk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1wktWQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791835110; x=1823371110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=svyaTnJKl2TYexbkp/vhzflZQy5dYZbMzF9dkVFPBPg=;
  b=E1wktWQk423SIUVeiUw8NtWu85Up7HtqaSPjUaTSdoUsztcEir15elsh
   zeR+Tkj+7juLaLkLHyWRUgQtkmHlC84x1tVOk3id9A0DB48xAeKRxppFg
   W+Y7GVHhzDX6xqNLJp3UYrHEywkbQjDUKbsJKtk3KJmTd8406SrFS0Nz4
   4MeQzEm9oMcB9fPTCNzqgW7NdhXDSl2CBq13/7gu3IX8StUfILV58v6vu
   EJzgbzfY3WGT+McnLDz8mKuBUXNlDxyMi8aRJBXcRftoWkbVL1bv5jICT
   qec3sLjk2inBcBqwECLoGAFOTCzPsEMN4uidyFgzwRr7mdDkJ/sEYhQ6z
   A==;
X-CSE-ConnectionGUID: QCxK83cwRp6ovqYt3u1qEg==
X-CSE-MsgGUID: JsN7fqizRGy1o9yQmxXFkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="447846"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="447846"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 12:58:30 -0700
X-CSE-ConnectionGUID: Qfp4xOXGRHaLFx0Gl49dRg==
X-CSE-MsgGUID: XQRCHPb8RSGkWbPwEH2PVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="2730507"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 12:58:27 -0700
Date: Mon, 12 Oct 2026 22:58:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] PM: runtime: Propagate last_busy from dependent to
 dependency
Message-ID: <as074Em1m9d5s1yO@ashevche-desk.local>
References: <20261002230714.507921-1-briannorris@chromium.org>
 <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <asEdiIT7l49vhn7i@ashevche-desk.local>
 <asPm6HYpEIAYJ4a3@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asPm6HYpEIAYJ4a3@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 05, 2026 at 11:05:28AM -0700, Brian Norris wrote:
> On Sat, Oct 03, 2026 at 06:21:44PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 04:03:07PM -0700, Brian Norris wrote:

...

> > > Cc: Ulf Hansson <ulfh@kernel.org>
> > 
> > Can go under the '---' cutter, so it won't pollute the commit message in the
> > Git history.
> 
> This is a well-documented convention.
> 
> Documentation/process/submitting-patches.rst
> 
>   If a person has had the opportunity to comment on a patch, but has not
>   provided such comments, you may optionally add a ``Cc:`` tag to the patch.
>   This tag documents that potentially interested parties have been included in
>   the discussion.
> 
> I'm directly referencing Ulf's suggestions (Link tag), so I'm also
> making it explicit that I'm CC'ing him.

This piece of the documentation was written long time ago before we have got
the kernel.org controlled mailing archives (now it's lore.kernel.org). I argue
that this piece is outdated and we need to look at all aspects of the commit
message. Perhaps having one might not lead to the issue, but exempli gratia 20
is. I still think it should be moved to under '---' to show the good example.

> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > 
> >  Cc: ...

...

> > > +/*
> > > + * Propagate last_busy timestamp from one device to another. This can, for
> > > + * example, prevent overactive suspend when a dependency's usage is primarily
> > > + * driven by one of its dependents.
> > > + */

^^^

> > But here you already have an outdated ones, no? Why is this not a problem?
> 
> The "target" device (a supplier or parent) can't suspend before this
> point, because the dependent device still holds a reference -- so an
> "outdated" last_busy is not relevant yet. The target last_busy *might*
> become relevant after this point, so this is the point at which it needs
> updated (propagated).
> 
> That's what I mean in the commit message by:
> 
>   propagate last_busy timestamps from a dependent device to its
>   dependencies any time it may allow a dependency to suspend -- i.e.,
>   when releasing a refcount for its parent or suppliers.
> 
> Please let me know if I should add some clarification somewhere --
> perhaps also in the comments here on rpm_propagate_last_busy()? Or if
> you see some other problem in the reasoning.

Perhaps a word to the top function comment?

-- 
With Best Regards,
Andy Shevchenko


