Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D853AEF58
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791847042; cv=none; b=exJtEXR41WuxuSLyut5/g07XiKEzf3py5CQfIqHR1tKH1ySdUAc9uhrYjDFnmctXbv+WBCSv6k5ZZlU3mNis9SWHiFzKMv9+ngmnZ2VErLS/RtzbHRD9EvAeoLhxjpZxmjh7v1ESk/2FLnaaIKvEyP8kDLlM62CGyp7zn5h9IdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791847042; c=relaxed/simple;
	bh=zpGJ2C9ZXKZREZPO809kC3o2ILZTcWpcszBp/d5beEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJYHN9IRYriagc7O61aL+YUo5LCMra7MflTqieyzgyfkbMJ8hS04oNbmKTgnQg45cmhw8TYgQy0+cbqRonLTV6Nd9OjRjHwqud4hX2UqoDHfgwYhKF6/uqkwMkva6FF3MhYJSMXm1aaKCSu8p1zY/U6IXYJojgtQDNvYTiZJ82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AUjxFOJH; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUjxFOJH"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so4312974eec.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791847039; x=1792451839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jULzgmU90GwExwiOegz46rYdLgOhwZJMHx733RDhwSw=;
        b=AUjxFOJHMFNqdn0qSQdV+lgeYQ7Hohkc5r1F4cSK2jsT50hlnsYWRf1N1zMTf2ShuZ
         6sIFLZ6U7ayNwu/ZKwOEi3QHWLWamBhZjiWJWKl6yQesEzy7gnbBScJhbuhG7lJqBoka
         uO9RLNxGlEjncYrlU2P//vgRmRF2FGYW7DG18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791847039; x=1792451839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jULzgmU90GwExwiOegz46rYdLgOhwZJMHx733RDhwSw=;
        b=mMigLcbOKoya14kPKK2A6DHfsr3y1YgQRnN6eCByNqsQRrqz6LxtmwHdOKEYZJWdRe
         iTj+2dLyWZPA5ACpkH7ZWMlMT3zYIQd9Dy+SHlWtJuEHkph4Wig1nftSdK57QO7PvXas
         BW0r/w1myNxKLjy+6R2HNpcPFSrCIPShoMyiql9dH/uOrTVgBBcyQkpRMMLLXnJskABl
         hDFMnoy1/iokJvLYFBKTZOsNGVRlGJFczsIhWFw2Iwoos87EYLk9D2X4Hfr0uX/iFjnm
         wnzPaVz2JFQTYFH1PDNooZfzWt96Oy4wQtGGK1/UHwwWVHydpMxF6qc0CLdOHK8Ih2YK
         9Oow==
X-Forwarded-Encrypted: i=1; AKwUvBwyBD+ltZ9VOG/0lDyOvjDsg2PQymAgNG3MQAmXineVpAc1ox3anSSs38D5OUBycEjhNLAHgh0KMw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSYu5OYg1fd8obgHfRtkOwYboI4rKHY3xliriHktsdqjT2IFpM
	eaRwaXoQnvm/5bhQcdVcsnx+i4mhqtYHngl8/iB7lfla3rP5N/rnk/caba+K4sX7nA==
X-Gm-Gg: AYBFou3mGdxZ/wOAsM34Ld+Rzx0vCqBnn2NsT+GbzBrvEMfTcm6ZfHEhmvTCmhU7Pki
	d4QTaRanGspGCXAGf4JQQOgPSWrXElXHb8eeYP+tnGxbHwd+GwVLd9FME7ZtrTLjXmDatmM9Zf5
	senwX/D3JalIHP6hP7SiNPn2NSc8df6w95Ng305WYWZkL1jBThVxW1VPoxiOWeAn8Aa+63XWAai
	jb25iaaZlxUyqSM3z9RtuO7TfluGRMvAIFUVe+IkOtygwF9H2rZUpPUmOzC2LYmEATObjbImyF1
	Kpeh4W8Ye47AgKJLKJTYgPU25lAnMc1DaIdCT2z/xxl7xG8BbuVtViYec1y0AYsi+1QhMP6ND21
	iUCzAf/KEyQZnqGRyQZ0AGL9j6bIflyAQ4YdngOJIlvvY4pXRYLYGKTXb8NI1Qq+xQaCBMEUBjM
	pG0qHz/rFhrI5pbjyqsZOIpqjiGIveUwrHytPsU688cJSCmTvzEgsVkVAmricqw4AqbxwpNGfsR
	JAOo896PvwkyRqSdPb7BkvM2coc5PWKE8PAm6RErow5erqg
X-Received: by 2002:a05:7022:1703:b0:166:b307:5855 with SMTP id a92af1059eb24-16a4ee7e657mr14543536c88.0.1791847038615;
        Mon, 12 Oct 2026 16:17:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4c0f:2208:f55a:d12f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-169a1becf08sm36095925c88.5.2026.10.12.16.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 16:17:17 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:17:15 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Message-ID: <as1qe_J37Njol797@google.com>
References: <20261002230714.507921-1-briannorris@chromium.org>
 <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <asEdiIT7l49vhn7i@ashevche-desk.local>
 <asPm6HYpEIAYJ4a3@google.com>
 <as074Em1m9d5s1yO@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as074Em1m9d5s1yO@ashevche-desk.local>

(Note to self: drop linux-stm32@st-md-mailman.stormreply.com from future
postings. It's failing hard, and not (AFAICT) just because I'm not
subscribed.) 

On Mon, Oct 12, 2026 at 10:58:24PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 05, 2026 at 11:05:28AM -0700, Brian Norris wrote:
> > On Sat, Oct 03, 2026 at 06:21:44PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 02, 2026 at 04:03:07PM -0700, Brian Norris wrote:
> 
> ...
> 
> > > > Cc: Ulf Hansson <ulfh@kernel.org>
> > > 
> > > Can go under the '---' cutter, so it won't pollute the commit message in the
> > > Git history.
> > 
> > This is a well-documented convention.
> > 
> > Documentation/process/submitting-patches.rst
> > 
> >   If a person has had the opportunity to comment on a patch, but has not
> >   provided such comments, you may optionally add a ``Cc:`` tag to the patch.
> >   This tag documents that potentially interested parties have been included in
> >   the discussion.
> > 
> > I'm directly referencing Ulf's suggestions (Link tag), so I'm also
> > making it explicit that I'm CC'ing him.
> 
> This piece of the documentation was written long time ago before we have got
> the kernel.org controlled mailing archives (now it's lore.kernel.org). I argue
> that this piece is outdated and we need to look at all aspects of the commit
> message. Perhaps having one might not lead to the issue, but exempli gratia 20
> is. I still think it should be moved to under '---' to show the good example.

Well, it's not 20; it's 1, with a clear reason. So not sure what you're
saying. Anyway, I've prepped that for v2.

Do you think you could propose a documentation update, if it's really so
out-of-date with current practice?

FWIW, a quick look at the v7.1..v7.2 git log shows over 10,000 Cc lines
that aren't for stable@ or similar, with over 900 different addressees,
across roughly 1300 different commits. (For comparison, there are 17,833
commits in v7.1..v7.2.)

It seems like you'll have a hard job trying to apply your rule to
everybody's changes, especially if it conflicts with the documentation.

> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > 
> > >  Cc: ...
> 
> ...
> 
> > > > +/*
> > > > + * Propagate last_busy timestamp from one device to another. This can, for
> > > > + * example, prevent overactive suspend when a dependency's usage is primarily
> > > > + * driven by one of its dependents.
> > > > + */
> 
> ^^^
> 
> > > But here you already have an outdated ones, no? Why is this not a problem?
> > 
> > The "target" device (a supplier or parent) can't suspend before this
> > point, because the dependent device still holds a reference -- so an
> > "outdated" last_busy is not relevant yet. The target last_busy *might*
> > become relevant after this point, so this is the point at which it needs
> > updated (propagated).
> > 
> > That's what I mean in the commit message by:
> > 
> >   propagate last_busy timestamps from a dependent device to its
> >   dependencies any time it may allow a dependency to suspend -- i.e.,
> >   when releasing a refcount for its parent or suppliers.
> > 
> > Please let me know if I should add some clarification somewhere --
> > perhaps also in the comments here on rpm_propagate_last_busy()? Or if
> > you see some other problem in the reasoning.
> 
> Perhaps a word to the top function comment?

OK, I've tried to factor that into my drafts for an eventual v2.

Thanks!

Brian
