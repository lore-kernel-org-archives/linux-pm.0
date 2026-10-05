Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BC4A3841
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223533; cv=none; b=UUCRaG/4oZQqsUlakX+dHQuVAtaP4TpHdrm9wGW7t/N9XZFW/rA+tKtsZghxcGt4mExW31PE99DEjYt9mQWQWDJIDh83y5GM9MF5br66W5Y7Vforr0RI4WE+a+S3Qf2gJlLROSZovgTx8V3/9N8hWS69ghLCbRMAxnzdnXhS/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223533; c=relaxed/simple;
	bh=e89rjkDSYceXnMXC0C/pj3HLHiG63mGDReiwnzrRHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMS7PDCv0WP+YQr+WUIo/QjGO66RI+BzIeSUDlUgwALDzgEW9bbIU1ssbjyreGmWXkm2gU0m6uj2tR/A3I09iBIWPNvtieMnBe6Z0oXo/i+/VSqgUrR90Hxfa76kw1/mGGlxfXl1gp0et0YiyDYlpG/YPPpAotiXtvYheaOgYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PzB0cqvf; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzB0cqvf"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b14db40daso883079eec.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791223531; x=1791828331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWvjrH2OoD5/C+DUCVNhJk1znVlYhkyyNM+I18Y3BXk=;
        b=PzB0cqvfCbtm33fjtolg2q2KkbWvSH0598oNG9o9Tb9NjhHJoekatNsmRxMHnRp67W
         lLcjfcy60zoqNoj3l2qlLzkeNsHJOo6NKYElqpQ7OJwZjekJ8fISv9Qb6bJN9BoeSHEC
         CeIAoAAxO49fFUmpJfy9elmIBs//5Epu8wWHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791223531; x=1791828331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWvjrH2OoD5/C+DUCVNhJk1znVlYhkyyNM+I18Y3BXk=;
        b=cImmoiTA0u0zHEYGqGE/VwHF2hZVfGku+NYT5//gVpULbF9XSdv6uaY+tNn7bzwLCb
         YqCVsD6GuzUncDR/qDo0PNYTI9SfvPC2sfsQSxw66PppP9ZisqDTpdk49eF+ovydWPbp
         /xhyA8/fILZNOBlff4CgaNDQGN1UNTlWy73FT/b0/uU4++TTYRUCiYYVUN9GatO8RCRm
         FZ82l+5KDe//79XZWA4Sf6y6fERg4oQ/965lqid/76Ty9JWHtGar3zDDkoMGtt6EoiVF
         Go2FNtVECqASJvN57SN6Ti/BJpRMV2wL43x25lbWXDnfrOADNpaCuIFFe8GLAfwkGfyJ
         oMmA==
X-Forwarded-Encrypted: i=1; AKwUvByk2D+x3zOoYW4WRBmLvKUEc3f0egK48SMXr5Q5BRDCefOXuCIGfBnswasxdglz4tsa4uAbzQ+42Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kg1w8g8qhga5Drpr91AlEpCVVanaXuKtXpLRqR5lMBvWiOkMFw
	kO+c/8mW5ho+6nuUu4uJPlj8spcUAT+1G1ExTWXwHJiL2rJ4+wL+I7mA6FnJENzZDw==
X-Gm-Gg: AYBFou31cKEcEbZaqbyEvGi/Me+zIcGlzGXorJiPS1JddLDub7yt/AZ01+5wArOSV8p
	YUNDAjfClrO+4tNQqUHrJ7wU64wu7/S5QREq5Yyt0g5HnedxikfOAlupuzGLwFhiYtF73iZ60iP
	n/uqJXxuznj2Bm+t768l7olr/HEk5o5b0YCDiejtyycKScOrYawYuz6g/jinl6pee1TeExvT1Ot
	3Zj9ZDhzELXYDwPg9d9XP3b7IJyFEGWi8/MO3Pj0kYGGG52ajbxAQ4RkM40sei/BmyfEFJiTwYH
	i3Q6oJ466EEx1+07pAae2/xApB7OIb2ncLEudUfOxZbZT9PH7RHIWK2dCn3bEYCXO9N4YfKTK+R
	yQXtB/bMR3XEIzLvtzFMAWj06J96FqmEwACQAflKWa6bd3gYGmoddVGqe4nNCW78q6f7m5Dz20a
	OadJkiN9iDL5l3nfIE2j5RMEuLOQJDK6JfzWgYgiLdz5yOGZ74DodxUY6MpJEcW72yWWerCluyK
	GlZx51ZOKopmMoVe7d+ZzXoGOoKQJcsNjOW
X-Received: by 2002:a05:7022:294:20b0:155:4a09:a228 with SMTP id a92af1059eb24-15d25e09c5dmr375308c88.8.1791223530973;
        Mon, 05 Oct 2026 11:05:30 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:3452:be62:94e:a46d])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-15d819cb585sm54028c88.5.2026.10.05.11.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 11:05:30 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:05:28 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Message-ID: <asPm6HYpEIAYJ4a3@google.com>
References: <20261002230714.507921-1-briannorris@chromium.org>
 <20261002160309.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <asEdiIT7l49vhn7i@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asEdiIT7l49vhn7i@ashevche-desk.local>

Hi Andy,

On Sat, Oct 03, 2026 at 06:21:44PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2026 at 04:03:07PM -0700, Brian Norris wrote:
> > When a child device suspends, it does not update the last_busy timestamp
> > for its parent. If that parent configured autosuspend and didn't
> > otherwise maintain its last_busy timestamp, it may now be immediately
> > eligible to suspend. This is probably not expected -- the parent should
> > wait for its autosuspend delay before suspending.
> > 
> > The effect of this behavior is that a parent device may suspend sooner
> > than its autosuspend delay, simply because its usage was accounted by
> > its children, and not by direct references to the parent device.
> > 
> > This was noticed in several cases, and some have implemented
> > workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
> > runtime autosuspend delay when slow polling"). At the same time, Ulf
> > suggested these problems "should be solved in the runtime PM core".
> > 
> > Instead of working around the problem in drivers, we propagate last_busy
> > timestamps from a dependent device to its dependencies any time it may
> > allow a dependency to suspend -- i.e., when releasing a refcount for its
> > parent or suppliers. We take care to only propagate the timestamp if it
> > is larger than the existing busy timestamp.
> > 
> > Note that this works best if the dependent device is using autosuspend
> > (and therefore updates its last_busy timestamps appropriately), but even
> > for a non-autosuspend child, this is still somewhat useful --
> > non-autosuspend devices still automatically update their last_busy every
> > time they resume.
> 
> > Link: https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/
> 
> Because Linus might complain on odd Link tags, please make sure you have a
> reference to it in the text and place it in a form like
> 
> Link: $URL [1]
> 
> and respectively in the text use [1] as a reference.

OK, I'll update if/when v2 comes around.

> > Cc: Ulf Hansson <ulfh@kernel.org>
> 
> Can go under the '---' cutter, so it won't pollute the commit message in the
> Git history.

This is a well-documented convention.

Documentation/process/submitting-patches.rst

  If a person has had the opportunity to comment on a patch, but has not
  provided such comments, you may optionally add a ``Cc:`` tag to the patch.
  This tag documents that potentially interested parties have been included in
  the discussion.

I'm directly referencing Ulf's suggestions (Link tag), so I'm also
making it explicit that I'm CC'ing him.

> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> 
>  Cc: ...
> 
> ...
> 
> > +/*
> > + * Propagate last_busy timestamp from one device to another. This can, for
> > + * example, prevent overactive suspend when a dependency's usage is primarily
> > + * driven by one of its dependents.
> > + */
> > +static void rpm_propagate_last_busy(struct device *dev, struct device *target)
> > +{
> > +	s64 busy = atomic64_read(&dev->power.last_busy);
> > +	s64 target_busy = atomic64_read(&target->power.last_busy);
> > +
> > +	while (target_busy < busy)
> 
> But here you already have an outdated ones, no? Why is this not a problem?

The "target" device (a supplier or parent) can't suspend before this
point, because the dependent device still holds a reference -- so an
"outdated" last_busy is not relevant yet. The target last_busy *might*
become relevant after this point, so this is the point at which it needs
updated (propagated).

That's what I mean in the commit message by:

  propagate last_busy timestamps from a dependent device to its
  dependencies any time it may allow a dependency to suspend -- i.e.,
  when releasing a refcount for its parent or suppliers.

Please let me know if I should add some clarification somewhere --
perhaps also in the comments here on rpm_propagate_last_busy()? Or if
you see some other problem in the reasoning.

Regards,
Brian

> > +		if (atomic64_try_cmpxchg(&target->power.last_busy, &target_busy, busy))
> > +			return;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
