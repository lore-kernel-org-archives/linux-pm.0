Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415355;
	b=CQk7vVgiKdgFqqiTrrtdGYPVlGd8d2BhZBkhIp5lNiYqyitjtu5aRBN1RfJsOuP9x3VY
	 PrnWQ1tE8tIzK9OKTcPpzS8oJl240U69y6U6KzUQtSMFvuta8qlBbBD7FuA2s0gV+pK7s
	 rgURIHzeTN7hrw4jTrjM/lEudO1zcyeSd2OtIuaEtmPe5C2J0jQ3MF8PfaOOkW0kGUYxF
	 HwaE0HCmwCZX7V3fxG1QzhngFyoy5RZeK9JtYLpOPwD5SpBUmYGG1exPA+xgMbG09Up/x
	 /7/f0/M6B1e8OQYBmna54sM3erELZ1+66UbcF6QNFCh9y6z/6oN3lUVN/W+p1Fb8ijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=j26EAR/dzc2upvRIQcmRb74iTI2baBkwNia6YMWLcb0=;
	b=Hj32/qmaQxcEk5AEOszpJMw3m5JkokEd54wp9LUNTf+W+kk/LUSpnx+Jkui//iYgn3Xh
	 RsfE3fy8UWUfYPmcGoQD3LwX0HEEXV/gvPTuAFSGIBgGWKi9zt/4qdE/ahJmcGewtNZmH
	 kjxchE+lk/rkX9Bjp2irWEtYtC7a7Sim3lIXu/a/EFJi9sSe5t8nz5R5UAj6ZLHQT9IBm
	 TRGP1PUb2P1aK2kXxwBGib3KF0I3bjdZkxcnCKvDgmBMBVutUcdbV1/3ycupLo9kb9E9R
	 7m0MCnylCXHlCMrMg2Zh5PgM589nk5stjMWbtRHLkmfbH+9YYinyvdKtW82fdZ/qYdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WilOHMSs;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CC606A326
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 16:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094CC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WilOHMSs
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3720addb068so6054997eec.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794415354; x=1795020154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j26EAR/dzc2upvRIQcmRb74iTI2baBkwNia6YMWLcb0=;
        b=WilOHMSsQ9/jscG6ljE4lyLwA+KOIJa0Q8EIPDGseTny19jiw0ZJ+cs9NpA9Sq/n1d
         IvR7Pc/CH5BmanR4cFVF3APRepjdWrWmot/wNJB6rn7uTBD4yDk5tBh95tX2urCx+Blu
         il5ulDDVNrR46fCUZFvmzbml/fRkfasN8Lrfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415354; x=1795020154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j26EAR/dzc2upvRIQcmRb74iTI2baBkwNia6YMWLcb0=;
        b=PGxypKm68KJKHsbGAyh/uf0MB/hsoD6ebtw0YsqrSNZqG39/afiDPcqKD50y11c0fH
         rzDEtg6KcFxc18PRxXdHxLIIvji1AOnzWHTDFa//0RIV/eo0sqIypLBZq1HMzgzjDiOq
         VOLa9qg1dNTiRHLK7PgBqFFuFjE1YNnFv06oZf3CtaIBkVTRMvoK9wIxY/k4YTVwxKnd
         UByf/uIn873XM5CiRMK+Ss1y/bZ+V2gJmGVty+EAijw7cwk2xgMPg2Fx8BRWNWTmdPEr
         tfocs64luh2SJf388I6ZFHhhgJAM8swDlS5l0aeBn+/DsxthMxh6iUDQCsUFKzW9UfI2
         4UZA==
X-Forwarded-Encrypted: i=1; AL+hErGsDPgQdu121GmOI+fvi363tzp2VkRbUpQerWAVbdOYZdnSzdMu3o6ClQL90Cfj3IReEg4bS3HAEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lEG2sWf8vTawjvz//59lOcnh4qhL71bM8fUbw5PQZlXC7lWjz
	boFFubdJLHz4tMF2R9iLRHoITNYGPsQPdZGmyVMJYuRFi642UiPCP5qafzJ9eQlQoA==
X-Gm-Gg: AYBFou19bAwBlsx8e5cIhobQg7SYQ7xBBZz0KjZl8qciHRMVmtFDkpHq2bX5FKWj0O1
	6T9muJhm656ZnknouOWkMTAIs4Egl4ed2/MsG3XjTyQCkcCjgBv0IhXnIulwMSKePy8ejfVaNkj
	OzKRl3c2tUKFmhT+EmkPzNljheJNdsZjQjfYIfVFZali4qLfE4DKRkMABZSmxtMRMfSvcvIe+f7
	N/nQ5/w/Ijjvvh1DegnQDiDGeUx2fmHOKdyLrcNYfMCpwM/t/IE73UONqH+O+HjsszgNKVFuzyG
	epbrjt64ydlKlLh+3Wu2Z8Oe7g491hdbsMPSVB2KwLh2w42XIPguJlcP0jmtXcMaVZ0+MuE0NUs
	AkjuFxVg4UprJF8v0OvChgNKXnQSD2jl4dyuH0fc9RG11KhmD8/Cy0WOWJoDwJgUFE3CGhvkrMx
	l/L2EX0T/hqRN48NPYcPnkPRnAsQrbkoZuBGwmXSEldmWb4ldsm5tFnP2JUEVpy4BMqwzOEEKZf
	wwNIY752jP/cOm/hZ4ey/Wiraeu2MU/Bt84Q20C4PjRO0EDzo1Erp+PHTrONHWnR1ySJgzOKbiY
	zFGczcScbrQ3qoqJI1bK2i4zrAXmPY+rrRo/Z9+HxZCFPeFakmZond3wfihypA4joOI=
X-Received: by 2002:a05:693c:40c7:b0:36a:15ee:c20e with SMTP id 5a478bee46e88-37686755924mr3880718eec.33.1794415353952;
        Wed, 11 Nov 2026 08:42:33 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:1fca:3f2:2d78:dd60])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-37520cfe07dsm18544278eec.20.2026.11.11.08.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 08:42:33 -0800 (PST)
Date: Wed, 11 Nov 2026 08:42:31 -0800
From: Brian Norris <briannorris@chromium.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <avSa97F1Nu1LTSCA@google.com>
References: <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
 <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
 <avOw_4ZkqtKFHu1B@google.com>
 <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>
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
In-Reply-To: <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>

Hi Alan,

On Tue, Nov 10, 2026 at 10:47:59PM -0500, Alan Stern wrote:
> On Tue, Nov 10, 2026 at 04:04:15PM -0800, Brian Norris wrote:
> > (+CC Alan, since he wrote much of the autosuspend stuff, but also
> > because he might(?) have better context for some of the .runtime_idle()
> > + pm_runtime_mark_last_busy() questions)
> 
> I'm coming into this discussion in the middle, so I probably don't have 
> a good picture of all the issues you've been talking about.  From what I 
> gather, it sounds like this is mostly a question of how long a parent 
> device should delay autosuspending after all its children go into 
> runtime suspend.  Is that right?

How long, and when should the inactivity timer start. (The latter more
than the former, really.)

> The idea behind autosuspend was simple enough: Try to optimize energy 
> usage by putting a device into runtime suspend only when it seems likely 
> that the device will remain suspended for more than a brief period of 
> time -- long enough to make the extra work of suspending and resuming 
> worthwhile.  In principle the driver core could collect statistics for 
> each device about how long it remains resumed and suspended, but the 
> benefits of such a detailed analysis didn't seem worth the effort.  And 
> given that drivers know more about how their devices will tend to behave 
> than the core does, it made sense to let drivers determine the best 
> autosuspend delay time for each device individually.
> 
> In theory, a driver or bus type might want to have differing delay 
> values for the time after all children are suspended vs. the time after 
> the device had some other work to do (not related to its children).  How 
> much of an advantage would that yield?  I don't know, but I felt that it 
> wasn't large enough to put support for it into the first implementation 
> of autosuspend.

Right, I don't think anybody is asking for this right now. We're just
trying to clean up the corners on how the existing timer works.

> So yes, in the current scheme a parent's inactivity period doesn't start 
> until all its children are suspended (unless the ignore_children flag is 
> set, but never mind that now).

But to be clear, that's not actually how runtime PM works today. It only
works this way for the very small handful of drivers where the parent
calls pm_runtime_mark_last_busy() in .runtime_idle(). I think several
people have acknolwedged that this is a bit of a hack, or at least a
missing feature in runtime PM, and probably should be extended more
widely.

> The parent's autosuspend delay therefore 
> should take into account the expected time before one of the children 
> may have to be resumed, as well as the expected time before the parent 
> itself may be asked to do something that doesn't involve any children.
> (Note that if a device has more than one child, the expected time before 
> any of its children will be resumed can be different from the expected 
> time before any single particular child will be resumed.)

"Expected time before a child may have to resume": isn't that child
last_busy + child delay? So that expected time is already in the past by
the time the child autosuspends.

But:

> The simplest way to carry this out is to do pm_runtime_mark_last_busy() 
> whenever a child suspends.  But other approaches to the same goal are 
> conceivable.

Yes, I agree it's simple. Maybe the distinction I'm making doesn't
matter that much.

> Of course it's not possible to determine an "ideal" autosuspend delay 
> time.  In fact, I suspect that in most cases we aren't even close.  But 
> I think doing it this way is still better than anything else that isn't 
> a lot more complex.

Ack.

> > I don't think we should be treating current autosuspend delays for
> > parent devices as meaningful at all, per the above. So I think this is a
> > chance to try to improve the architecture so it makes sense, and then
> > figure out if any existing delays should be tuned/reduced.
> > 
> > Ideally, yes, we can avoid making significant system power changes to
> > the negative, but I don't think that we should prioritize that above all
> > else, as long as it's *possible* to tune the autosuspend delays in a way
> > that makes sense.
> 
> Of course it's possible to tune the autosuspend delays.  That's what 
> /sys/.../power/autosuspend_delay_ms is for.  Whether it's possible to do 
> so in a way that makes sense will depend very heavily on the type of 
> device in question and the way the system is used.  One possible 
> approach might be to have a userspace daemon that tracks all runtime PM 
> transitions and tries to do some sort of dynamic tuning.  How well would 
> that work?  I don't know, but it would be a good research project for 
> somebody.

My point here was that I think Rafael was overly concerned about
precisely tuning parent autosuspend delays at the same time as changing
the runtime PM core behavior. Yes, they clearly can be tuned in user
space; but he was suggesting a phase-in / opt-in approach to this
change, because it might harm system power if it's not re-tuned.

> > Side note: I think .runtime_idle() should be removed. As far as I can
> > tell, it's only used for working around architectural problems in
> > runtime PM (like $subject), or for implementing autosuspend without
> > actually using autosuspend (usually because they predated autosuspend).
> 
> I have never given much thought to runtime_idle().  When we were doing 
> the initial implementation of runtime PM I didn't see any use for it, 
> but Rafael was quite certain that it had its place and the issue wasn't 
> important enough to argue about.  I wouldn't mind a bit if it were 
> eliminated, but I also don't really mind the extra overhead of the idle 
> callback pointers and support routines.

The overhead isn't my concern. The mental overhead is. There are several
rough edges that would be smoother without it, IMO.

> > At the same time, it makes it harder to reason about the runtime PM API
> > surface -- because currently, .runtime_idle() is a primary reason that
> > pm_runtime_put() and pm_runtime_put_autosuspend() are different.
> 
> I wouldn't put it that way.  My feeling is that pm_runtime_put() could 
> be replaced by pm_runtime_put_autosuspend(), since they should behave 
> identically for devices that don't use autosuspend.

Ah, but that's not actually true! pm_runtime_put_autosuspend() skips
.runtime_idle(). It (semi)directly calls rpm_suspend().

> (If there are any 
> devices that _do_ use autosuspend and also use pm_runtime_put() -- well, 
> I'd say that sounds like either a design error or a simple oversight.)  
> The reason for having two different routines is mainly historical: 
> pm_runtime_put_autosuspend() was added some time after pm_runtime_put() 
> and we didn't want to mess up the existing callers.  Maybe this 
> judgement was a mistake.
> 
> > "Last PM reference" can be a bit subtle; particularly, the child only
> > drops a reference on its parent once it *completes* autosuspend (even if
> > it was last "busy" much earlier). That means autosuspend delays become
> > additive along the hierarchy. Is that desirable?
> 
> That's up to the maintainers of the device and its bus subsystem.  They 
> can arrange the default autosuspend delays any way they like, taking the 
> children's autosuspend delays into account if they want -- and the user 
> can always override the defaults.  But one thing that does _not_ make 
> sense would be to have non-additive delays where a parent's delay is 
> shorter than its child's.
> 
> Your email was fairly long, and I have touched on only a few of the 
> issues it brought up.  Is there anything significant you still want to 
> discuss?

I appreciate all the responses. One particular part I did have questions
on, which I'll mostly copy/paste:

[Rafael:]
> Now, let me acknowledge that some drivers evidently want rpm_idle() to
> always set the autosuspend timer instead of suspending the device
> right away.  That may be because of the "unwanted parent suspends"
> problem at hand or for other reasons.

Do we have any idea what the "other reasons" could be? For example,
because driver writers found it too difficult to find all the
appropriate places to call pm_runtime_mark_last_busy()? (Does commit
b3db492e8335 ("PM: runtime: Mark last busy stamp in
pm_runtime_put_autosuspend()") help? Or should pm_runtime_put() behave
similarly?)

I see that USB is one of the subsystems where .runtime_idle() calls
pm_runtime_mark_last_busy(), and I thought you (Alan) might have some
more background on that.

Thanks,
Brian
