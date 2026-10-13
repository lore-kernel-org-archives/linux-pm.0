Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E549B5DE;
	Tue, 13 Oct 2026 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871878; cv=none; b=AtU0IzGsFNiNnZXxRlFgCE6R2r24h32UzRasAWbsQZeZwrS0GYWTALQFFYqrbYFUZGoEMevGop26Nw770brknJa7KKBrINz5lKTIUQW28MZRYqwMdl+y5z8habNrHHn/RfcFFG+SW2pRq6PZOXZ1O7uDJAjF94wiMd1Jz5OCDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871878; c=relaxed/simple;
	bh=bZCryCaE81/PP/pc+Hgv31p+qdLWaTjK3f7Lg80CbBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1TfsgtG5JVca+hO1QENwFxSQaSsg5MU2laiRSB7NSYww6/xdogEVqtVn8E7KqAty9G+pjExLkj9UZ6HkYs+gHMCO9u5jcJkoerNOkbci6uxuLc1us1edO54kOocUCZTnbVVZFIo3mvMiPgM64L7kLz+BGBq8M6zUsPRCoe1I/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXoUvSjU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXoUvSjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791871876; x=1823407876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bZCryCaE81/PP/pc+Hgv31p+qdLWaTjK3f7Lg80CbBM=;
  b=GXoUvSjUDtoQi9Tuy0D1nZO6Coxpr+z6WKTk0iNlh3+sd5x0yvbqLatY
   ggHL425BDtN+aHg5S9cXkauX+joCX0d/QzKiVkPNWhSIG8xQbIEVL6qXX
   u/Qr+Dj51kh5bPDArpbSevqXPC+nKugYS4gz2IB5LVFajkfSp9bKjAIMF
   EVYF2VDHDMnT+fU730QmdR1CdBEaUkmwqUTOX93j0CI/Zu3zzFkyI++RE
   p6qUvrQb80WLggBQSzPYF4KQyUMHvlNSj5zOhokLaCPsdRMQ8FyUgdXVN
   B1BNkDNbFwHsuXGTrdQA9NaTDD70i9qRONO7jEXvyKzEMP1Udt39IG+at
   Q==;
X-CSE-ConnectionGUID: X6H3+cmnQk2/s1C65eLMUw==
X-CSE-MsgGUID: 8vvbq3/6R1K5nMXeh8ihDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="592546"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="592546"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:11:15 -0700
X-CSE-ConnectionGUID: bUS/U4RbRLOGF0ixRHSvRQ==
X-CSE-MsgGUID: P88hj0ooTWqjFlVDp4fQGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="981242"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:11:11 -0700
Date: Tue, 13 Oct 2026 09:11:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] PM: runtime: Propagate last_busy from dependent to
 dependency
Message-ID: <as3LfIU9bi5GY2cm@ashevche-desk.local>
References: <20261002230714.507921-1-briannorris@chromium.org>
 <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <asEdiIT7l49vhn7i@ashevche-desk.local>
 <asPm6HYpEIAYJ4a3@google.com>
 <as074Em1m9d5s1yO@ashevche-desk.local>
 <as1qe_J37Njol797@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as1qe_J37Njol797@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:17:15PM -0700, Brian Norris wrote:
> On Mon, Oct 12, 2026 at 10:58:24PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 05, 2026 at 11:05:28AM -0700, Brian Norris wrote:
> > > On Sat, Oct 03, 2026 at 06:21:44PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Oct 02, 2026 at 04:03:07PM -0700, Brian Norris wrote:

...

> > > > > Cc: Ulf Hansson <ulfh@kernel.org>
> > > > 
> > > > Can go under the '---' cutter, so it won't pollute the commit message in the
> > > > Git history.
> > > 
> > > This is a well-documented convention.
> > > 
> > > Documentation/process/submitting-patches.rst
> > > 
> > >   If a person has had the opportunity to comment on a patch, but has not
> > >   provided such comments, you may optionally add a ``Cc:`` tag to the patch.
> > >   This tag documents that potentially interested parties have been included in
> > >   the discussion.
> > > 
> > > I'm directly referencing Ulf's suggestions (Link tag), so I'm also
> > > making it explicit that I'm CC'ing him.
> > 
> > This piece of the documentation was written long time ago before we have got
> > the kernel.org controlled mailing archives (now it's lore.kernel.org). I argue
> > that this piece is outdated and we need to look at all aspects of the commit
> > message. Perhaps having one might not lead to the issue, but exempli gratia 20
> > is. I still think it should be moved to under '---' to show the good example.
> 
> Well, it's not 20; it's 1, with a clear reason.

Yes, I aware of that — "having one might not lead to the issue".

> So not sure what you're saying. Anyway, I've prepped that for v2.

> Do you think you could propose a documentation update, if it's really so
> out-of-date with current practice?

I posted some a few months ago, when I pointed out to that noise in the commit
messages, it was like a pushback, but since that I have convinced several
developers to follow, so it might be worth to try again (but it should not be
insisting, just a recommendation). Also note, that even in the cited piece
there is no clear point where to put that Cc tag. It's only required for
stable backporting process to be in the commit message, otherwise that tag
may well be located after the '---' line which still makes it a (email)
tag, but visible in the commit message.

> FWIW, a quick look at the v7.1..v7.2 git log shows over 10,000 Cc lines
> that aren't for stable@ or similar, with over 900 different addressees,
> across roughly 1300 different commits. (For comparison, there are 17,833
> commits in v7.1..v7.2.)

Have you checked in dynamics? (Note, most of those Cc comes from Andrew
Morton's scripts and TIP tree.)

I used this:

$ git log --no-merges --grep '^Cc:' --pretty="%(trailers:key=Cc)" v<$A>..v<$B> | grep -v '^$' | grep -v 'stable@vger.kernel.org' | grep -v stable.*@kernel.org | wc -l

where <$A> and <$B> give a range.

v6.19..v7.0: 11525
v7.0..v7.1: 11594
v7.1..v7.2: 10946
v7.2..v7.3-rc7: 8696

You see, it works!

> It seems like you'll have a hard job trying to apply your rule to
> everybody's changes, especially if it conflicts with the documentation.

As I explained above it doesn't really conflict, it rather old established
process when people want to have that Cc be recorded, now we have
lore.kernel.org for that and I successfully convinced several people to follow.

> > > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > > ---
> > > > 
> > > >  Cc: ...

-- 
With Best Regards,
Andy Shevchenko


