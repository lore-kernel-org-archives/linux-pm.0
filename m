Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752370;
	b=RaYwbrkh/EozvX2d7eSHBCgkiA+pJ9nOqdsvW5rVfzjjCbNPeMUY4gGAFEsY1Bqoen9q
	 ILfosqpdw/NJsWrqeYWtXC2plDATHecjGIREIMft7AvWOX8i1s/QQ0NMUASGXteZg5Wv4
	 JFAK4Zk+wMMitcFknFRvBO6ONVZGFxjrj8lcc8I/AmVOL1DRB8pflBltyUAoMsFKPTeR8
	 xyaes/0CZ2sIWCawLxK+z4tJM+oZygo4hF05GdJQVjY5CG2sz7Z2uoj5Bn9xJiv+PA5rA
	 gCbeXJDPZ2U+AJNIWjmJ5B6OQgusisrCYabbwPJoXo+DnuOjIzDmiHhEnnGYBgtHyXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ia3DNRbB3tzN83nGHEc/6FKqQVPdb5ypWXD/ZK/mfh0=;
	b=5Im7d2WnY36H7waniuWeld77hTdc9PLfnstG9c9wIbClC/WzQc4wGn4krgIEdtFuYAz7
	 9vcjEKgTPVfCwvUVh4gOY3ip+tswuR2aL/Y/39BphSYx+1Fe6i2H7rtjW1JbMnfid/fd0
	 SZ3zTRmmtMF0qzEl4eXxNq03b2yfFP4ZjZlSLjbfX9pJmU0eebBqhayvqUW+NIKyfANAU
	 WxxdiO6WqHI0oxMUw+DYDUvZUzTxh9zp3t0LuQYggCH40whQvUHtqQ30uFE36hsMyfXKH
	 uyXJc36Z8RG41aJBy4/jBnvjC9h7gktawxPWKLb0dt+mLpEgEQ528qF/8ByCIjvyhSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UP76ig4E;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DC606A326
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 00:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED3DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UP76ig4E
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso283618eec.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 16:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793752368; x=1794357168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ia3DNRbB3tzN83nGHEc/6FKqQVPdb5ypWXD/ZK/mfh0=;
        b=UP76ig4EnqFwzycYT6Ysj7CrOyM18lSpYenIwGvrudZlVBEYEVOcjL3r2Fc3IJ+6O0
         eK1EL7REDE8e1jnFX+LCIp0kQj1EQfaFFgaE07aLE6y/U1pQGGTJfXSqZ69VUVRblVK/
         s9xuSzqVqeaPedgUoM8rrEnltNuZstEvDac7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752368; x=1794357168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ia3DNRbB3tzN83nGHEc/6FKqQVPdb5ypWXD/ZK/mfh0=;
        b=0PQXD2RclemO114qotVjq7GRsLEUR9bsxAgYmCPpFl3QfDpnzuSQYBVCQj0N09F09r
         XnwwHbxCzXXD29gZtIz88/YsRZQKkpnyhu3wGw+R7FBBdwG03hqb9LKDm4rDBmaS52wc
         Pkg1zF03L3RcjJyUZ04zPjSr0FySzfcnBws4g+FytaeQKGlXLtqUZsLd/9T5wHEFDT49
         QhOMmUzFxSK0gI6J1QdbE0YJLOOPKNOX9Lk2aFFBw6VNyV+dGO7joUWQ8g70Vb2N6DXG
         RyxWL9G6BSVALCgWUzyamxJl8MxdrcXHLz3LA+8uXgo/YRlCWZ5vqmqobpIKqJN4lu+e
         Mvlw==
X-Forwarded-Encrypted: i=1; AKwUvBy5lmvXj++Sd4DHDy7iH+Rtl6HPF50NClUNZyqDqlRbqW5P8e3K2xZxEzyMdizXKLiia7SgoJ58LA==@vger.kernel.org
X-Gm-Message-State: APuU4Z90YEi8KvF0kVjCKVYKDr5t0UeOOUd22qlnIHX5+EsZilxl7Q6L
	FYsXCpnHKMhXDzVI8sK4zaJAF4DAg1/ZfNtAvLSy6mQBLIKWJpV/hLI1m3RA15ZAWA==
X-Gm-Gg: AYBFou1O6F3/ANjn2716TMHC0cEYVKKIFggGDER5zfBVbz2rTcEmu/fvmsKs4ds9eYi
	k1Op/VA7epU9SxucdpbnTB+nrK/djWflvHbb21CQaX8qXl88OkeFUT5aaQGusOJbkky8fstjAXd
	vTrrR0VBPJvPxlhVEpSqRlK++JYviQ08FcprekAYnY1W3P+nmj0zChV9JsCmOgJjPqGx8azU4fz
	SbmlsCmxVcQB35HimqQhQJh9xDknLb7mdcVh7aWLS83l11XHPot0XDsttsPlf8K1HsBzW91bv9E
	08wfbvkNtm7/MAPeQ48zAYYWAMfiDyALIvbjB/JkN7M+2Z5frNG07FMai8KOb7hhBwnEQnhqSm2
	LhrcPRuJll+VyXpMASncbQ3GWFIUmXI/H6QVcpxXs/XcucrPk5xmqfNdOyb0bmjkb3MY83Ptq3j
	7pSzdoElIBK9tfbRo14x6523RIvHfxZmdtuuyjVGrTcx7dJIx/T0M9B60nWZ67ePkUOS4a7vTHH
	9suU/vUkNVmAEjs3HzQvoKaoUDthf7ooqzbAQRFGq7GODGE702D0yJdIjmR6ncQNaVYtDDBpTAR
	lket3tTWxymLI9z6g+3CkYTuy5mptuzOJ/5YZRJJD4yDEta9JEYYl1akNCZhiXJI2RQ=
X-Received: by 2002:a05:7300:c39f:b0:366:6644:2839 with SMTP id 5a478bee46e88-36a42203e90mr22173192eec.3.1793752367673;
        Tue, 03 Nov 2026 16:32:47 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca38a54ccsm2074587eec.4.2026.11.03.16.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:32:46 -0800 (PST)
Date: Tue, 3 Nov 2026 16:32:44 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <aup9LKewaLr2B5cR@google.com>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <20261103231719.486a18de@jic23-hlaptop>
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
In-Reply-To: <20261103231719.486a18de@jic23-hlaptop>

Hi Jonathan,

On Tue, Nov 03, 2026 at 11:17:19PM +0000, Jonathan Cameron wrote:
> On Tue,  3 Nov 2026 14:14:41 -0800
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > When a child device suspends, it does not update the last_busy timestamp
> > for its parent. If that parent configured autosuspend and didn't
> > otherwise maintain its last_busy timestamp, it may now be immediately
> > eligible to suspend. This is probably not expected -- the parent should
> > wait for its autosuspend delay before suspending.
> 
> So reading this again - I wonder if this text is describing the
> expected behaviour.

Agreed, this might give the wrong impression, depending on the
assumptions the reader makes about autosuspend delay. (I think I had a
particular problem scenario in mind, but didn't translate that properly
here.)

> If the child is also using autosupend then, in extreme case, that time
> might be longer than the autosuspend time of the parent.
> If so it seems odd the parent still waits.

Right, that seems wrong, and indeed that's not what this patch does.

> So most expected to me
> would be if the parent were to suspend it's autosuspend time after
> the parent or child was last used for something that indicate a
> desire not to suspend (that shouldn't include actions the child
> did whilst suspending).

(Not sure I'm parsing this sentence quite right, but...)

The point is that last_busy should propagate (rather than, say, the
expiration time). So each device still gets its own-delay-based
autosuspend timer expiration. That may mean the parent waits longer than
the child, but it may not, if the child's delay was longer than the
parent's.

> Maybe there isn't a sensible way to deal with this and what you have here
> is the best we can do.  Note that this is just commenting on this
> statement in the commit description.  From what follows I think
> this is just a commit description thing rather than functional.

If I'm understanding what you're saying correctly: maybe it would be an
improvement here to say:

  If that parent configured an autosuspend delay longer than its child's
  and didn't otherwise maintain its last_busy timestamp, it may now be
  immediately eligible to suspend.

I think that would more accurately describe the target problem, even if
it doesn't cover all cases (such as when the parent delay is shorter).

> > The effect of this behavior is that a parent device may suspend sooner
> > than its autosuspend delay, simply because its usage was accounted by
> > its children, and not by direct references to the parent device.
> 
> Sooner is indeed bad.
> 
> > 
> > This was noticed in several cases, and some have implemented
> > workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
> > runtime autosuspend delay when slow polling"). At the same time, Ulf
> > suggested these problems "should be solved in the runtime PM core" [1].
> > 
> > Instead of working around the problem in drivers, we propagate last_busy
> > timestamps from a dependent device to its dependencies any time it may
> > allow a dependency to suspend -- i.e., when releasing a refcount for its
> > parent or suppliers. We take care to only propagate the timestamp if it
> > is larger than the existing busy timestamp.
> 
> So this sounds fine but I don't think aligns with that first paragraph.
> 
> > 
> > Note that this works best if the dependent device is using autosuspend
> > (and therefore updates its last_busy timestamps appropriately), but even
> > for a non-autosuspend child, this is still somewhat useful --
> > non-autosuspend devices still automatically update their last_busy every
> > time they resume.
> 
> Can we set the last busy on the suspend of child devices that aren't
> suspending as a result of autosuspend timeout but for other reasons?
> (may be some fiddly corners!)

Do you have concrete use cases in mind, or do you bring this up simply
because of my note?

For one, I feel like for devices with power.use_autosuspend==true, it's
reasonable to expect drivers to use the appropriate helpers to update
last_busy at the appropriate times, and so any "corner cases" are from
misuse.

But if you mean non-use_autosuspend devices: I suppose it'd be possible
but I haven't reasoned through the implementation very far yet. It
almost seems like we'd need to plumb pm_runtime_mark_last_busy() into
*all* the put() helpers, including the non-autosuspend ones
(pm_runtime_put(), pm_runtime_put_sync()). I'm not quite sure if that's
desirable. But I could try to look a bit more, if you think there are
important use cases that would need this.

Brian

> > Link: https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/ [1]
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Cc: Ulf Hansson <ulfh@kernel.org>
> > 
> > Changes in v2:
> >  * Update comments to explain when/why rpm_propagate_last_busy()
> >    performs the update
> > 
> >  drivers/base/power/runtime.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 2a117d6a776f..dd306cbabcd3 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -318,6 +318,22 @@ static int rpm_get_suppliers(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Propagate last_busy timestamp from one device to another, typically when a
> > + * device (@dev) releases a reference count on a dependency (@target) and might
> > + * allow it to (auto)suspend. This can, for example, prevent overactive suspend
> > + * when a dependency's usage is primarily driven by one of its dependents.
> > + */
> > +static void rpm_propagate_last_busy(struct device *dev, struct device *target)
> > +{
> > +	s64 busy = atomic64_read(&dev->power.last_busy);
> > +	s64 target_busy = atomic64_read(&target->power.last_busy);
> > +
> > +	while (target_busy < busy)
> > +		if (atomic64_try_cmpxchg(&target->power.last_busy, &target_busy, busy))
> > +			return;
> > +}
> > +
> >  /**
> >   * pm_runtime_release_supplier - Drop references to device link's supplier.
> >   * @link: Target device link.
> > @@ -348,6 +364,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
> >  		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
> >  			continue;
> >  
> > +		rpm_propagate_last_busy(dev, link->supplier);
> >  		pm_runtime_release_supplier(link);
> >  		if (try_to_suspend)
> >  			pm_request_idle(link->supplier);
> > @@ -710,6 +727,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >  
> >  	if (dev->parent) {
> >  		parent = dev->parent;
> > +		if (!parent->power.ignore_children)
> > +			rpm_propagate_last_busy(dev, parent);
> >  		atomic_add_unless(&parent->power.child_count, -1, 0);
> >  	}
> >  	wake_up_all(&dev->power.wait_queue);
> > @@ -1368,8 +1387,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
> >  		goto out_set;
> >  
> >  	if (status == RPM_SUSPENDED) {
> > -		atomic_add_unless(&parent->power.child_count, -1, 0);
> >  		notify_parent = !parent->power.ignore_children;
> > +		if (notify_parent)
> > +			rpm_propagate_last_busy(dev, parent);
> > +		atomic_add_unless(&parent->power.child_count, -1, 0);
> >  	} else {
> >  		spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
> >  
> 
