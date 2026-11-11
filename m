Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355462;
	b=XN0v2qdj0EC8XAnFSQO48U2USW4YscL+PQmc56L4mHkz8fiX89BhjFGkQibgnrAQmkxr
	 9O7kgRBXJJjovIyQqOXYkcc2a4v6BcmQ/aeGTYCqae6JXYiE2A9qa9iNBJJwvahcPMmAe
	 FHjf6hLdoleTsUa/OnVX+gVlcBlOgcmSJxrtb0zfd0vIow39zU++vOaHyCPsCgIytBTPQ
	 YhoLvqramE5ZEHoBQlswXBYTHTEbD3O1cdc3T+LotuGz1LavrnfVM6EVbJZ632JFeyVwN
	 bENsO5wAsVsksrX9FgVnIGZ8yxPWUePCJVVfOSH87e5klN7Xm8jujrdiCjxxlQh1U7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=C8iDH3wzEUbfzw7vLUHykfELJX0fs/fYgQ0GVi2TiVI=;
	b=ttF0s3GkVVDGtL8j4+4tCiUjCOGrUbSfunHKIbNdHsUQiuQ40oZabt9pYcL2qU6JOHWG
	 6jM+Jzh3siq6afFHWZVWmOrTKvsdVO/hnDJPvctroEXWI96+ImTlJWDBdFJvNM6gB7vVr
	 Oz8LaZXZWKidcCa2gBVKD0E4ymoAfYyVCmsG9FBtHsoDGQkIMOyYQovmopZiKxP22EtCs
	 Q+lcDQxs4tkx7//SHBINkaUBEOIAyazKmNMcm2oDWS0NA7dPtvMFaN+4drkg5dFpJWeVx
	 VLH9DHSYtgftIHY+o2Ze1G8AphcCyaPBGC2VGsvpnfWMK1RFLlwR+LhP2Ze+whbL0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Sr7uVV9P;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FC606A325
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 00:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA9FC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Sr7uVV9P
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3720addb068so4706220eec.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794355461; x=1794960261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C8iDH3wzEUbfzw7vLUHykfELJX0fs/fYgQ0GVi2TiVI=;
        b=Sr7uVV9PYAVvcz9PQOwn4Rf/67j79HNbtGJF0lIXmZhad+pnIKj3Ihp6+6nS5M4H7v
         Ys/bvWu9DSTHyjijW/hs5jJlRocG+JzxEIVk6k/gsCY2hEfk0TCP7wyJ8x6zewLdD40i
         w2dOF/TxHqBdo0gF0BIOe61TpHTnvGtNsOPII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355461; x=1794960261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C8iDH3wzEUbfzw7vLUHykfELJX0fs/fYgQ0GVi2TiVI=;
        b=JyJza7lOYQLp5Mw6YB6tiBC4aaxl2nsb6zcVkBzfSEdCnnjh7VEvSpA8RScTrHVCXi
         MvSVKVL03/95+x9mQYDmzSB0k9id9NmvTo2mW48p9cOJ3dqDeb2aBYBp2T6Uu2dkNrxm
         Vy4AuJ4/EAnlrn8qh3RHBUfPZdeBfYHHwe3gQSsmT4zeem+9tNsl/2t9KsTVIWrXuPTA
         yHqIdxEvlZCxPxFsTclJqRstH/pwPWDUrJUV//sNlJbwSY8Gl0eHA8MpkgCe/4hFVpmW
         v7XNsb5QBqeS+z4MlcGVlSSOkZK3/IDfdqiZbuF0Dbs5jq0Mc+JwRnU/Wk3O6wrHYiXT
         nDQQ==
X-Forwarded-Encrypted: i=1; AL+hErFQPRyhGcj7h99UCaGaYZRZUQH/hOsBhbyW+bzAW9PF9f9scbtMbe9Lk1g5tq4mGXUL45WrWnxYlA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+FfWoDjezatSgzWJn6BmhQ7vv9D4fBueYI1X9VNbuQzLiMrvz
	WZKX+Yd/x8Hs7W6C4d3iGYda2Db9eouGDy39pp3LZrLh+rYCXERaW52KqfevZf+f4A==
X-Gm-Gg: AYBFou3UR9jJT1CSFcZGfDzRwuH0xM3zrMq2TlHiXCuHEweQBp+PoDTFi58PdIcOMXt
	9cRQqFdxkCRpmTgb1KH6JRmmYPsaKr/LESd2hHlvcqJVXvoRjQsiTt2BClYuGPPOco/JjgqrJ96
	Tw1uv9tXlRvXIW+k7duFtbkqnBVLpG5j2mtCuR2CSyuR2V6vw36eJ+801qsX4c+/DkbEf2l7+tQ
	vIukAGiAyhCV2M5VR4utC22MnX/qU6/4G14ME3SAy+akA4qPkgP9JyyL8DY0lDTHCooWT5JxDR9
	3qfKy2K96hFVWVFj0TcLQCGrFhkoTK5lmwI7Sk4Wq0VGmgO2/wN3mKSePeIR7yTRbEtJg+BRumG
	SD8+t/OpnoGxO4vf0Xx4JuxDE9+om6TzN6ft+npkFq6wsNM/4D26RWJNQr7yAAc0EK01wiNoni4
	Xl4ye+qx1RF7t2GUtT+D+vfT1WLqqfbPvYraKCMTYVY8DsXdItvAU2nNHSMkUyYpw2XhcRRQYCh
	gaSttldWd4KVQ9rgpHH5Hlw/lyRQlblTPkfPxgqkHO81HmE88Eyb7RXGkuhwjgMbWfEUpMakr4w
	iv13utVSOd+j9POiE7/w4KuH8zjxNXfPt1Vx5xuLW5X36KOhGvTeancb6ig7sKoexFMP
X-Received: by 2002:a05:7300:8a19:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-376854b83d1mr1098536eec.9.1794355460437;
        Tue, 10 Nov 2026 16:04:20 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d341:6018:352a:4503])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3751d9f135asm10118860eec.2.2026.11.10.16.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 16:04:18 -0800 (PST)
Date: Tue, 10 Nov 2026 16:04:15 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <avOw_4ZkqtKFHu1B@google.com>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
 <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>

(+CC Alan, since he wrote much of the autosuspend stuff, but also
because he might(?) have better context for some of the .runtime_idle()
+ pm_runtime_mark_last_busy() questions)

Hi Rafael,

I was a bit slow to respond here, because I wanted to consider this
carefully, and not simply give a knee-jerk reaction.

Overall, I have some positive and negative thoughts. I'm still leaning
toward preferring a proposal more like my own, but I think with a few
things cleared up, I may be convinced of yours instead.

On Mon, Nov 09, 2026 at 04:24:33PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Fri, Nov 6, 2026 at 2:06 AM Brian Norris <briannorris@chromium.org> wrote:
> > So, I'd love to hear what can make the ergonomics better here, with less
> > core complexity.
> 
> Let me start with a clear problem statement to kind of refresh the context.
> 
> In some cases, there are unwanted parent suspends occurring between
> child suspend and resume that delay the latter unnecessarily and
> generally waste energy.  They mostly occur when the child suspends and
> resumes relatively often and the parent's autosuspend delay is too
> short to cover the entire period between the child suspend and resume
> along with the preceding period of the child activity following the
> most recent update of the parent's last_busy timestamp, at least
> sometimes.

Sure, that's one way to frame it.

> Of course, this also equally applies to suppliers and consumers, but
> let's focus the attention on parents and children.
> 
> The problem addressed by
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=55b2b8af704f845e01fa2f31ee259b07641ce3a9
> 
> makes the unwanted parent suppends to occur more often because it
> causes the parent to entirely miss its last_busy updates in the cases
> when pm_runtime_resume() (or equivalent) is called for it when it is
> active.  When this goes away, it should be possible to address those
> "unwanted parent suspends" at least in some cases by increasing the
> parent's autosuspend delay.

I think "in some cases" is holding a lot of weight.

For every increased parent autosuspend delay, there is always some usage
pattern that will subvert it (even post-commit-55b2b8af704f) -- the
child simply needs to stay "in use" for a bit longer. We shouldn't have
to think about how long a device is in use when determining the
autosuspend delay.

So I think this is a non-starter line of thought, and not just because
of your system power arguments.

To me, autosuspend delay is simply broken today when looking at parent
devices. Maybe we can glean some intention from the comments and context
around any given delay used by drivers today, but they aren't reliably
meaningful.

> However, using larger autosuspend delay
> values generally causes system power to grow (on average) because it
> effectively causes devices to spend less time in suspend, so
> increasing autosuspend delay values is not a particularly attractive
> option.
> 
> Notice though that advancing the last_busy timestamp more often
> without reducing the autosuspend delay values of the affected devices
> is also likely to lead to the overall increase of system power because
> it would effectively cause the devices to spend less time in suspend
> (on average) likely increasing their power (unless the majority of
> their suspends are unwanted).

I don't think we should be treating current autosuspend delays for
parent devices as meaningful at all, per the above. So I think this is a
chance to try to improve the architecture so it makes sense, and then
figure out if any existing delays should be tuned/reduced.

Ideally, yes, we can avoid making significant system power changes to
the negative, but I don't think that we should prioritize that above all
else, as long as it's *possible* to tune the autosuspend delays in a way
that makes sense.

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

I'm genuinely interested. Because I think that you *might* be reasoning
us into a weird corner where we "hope" things can be improved
architecturally in the long run, but we don't really know, and aren't
going to actually make it happen without knowing why things are the way
that they are.

> Regardless, it is effectively
> equivalent to setting last_busy in rpm_idle(), so they use their
> .runtime_idle() callbacks for calling pm_runtime_mark_last_busy().

Side note: I think .runtime_idle() should be removed. As far as I can
tell, it's only used for working around architectural problems in
runtime PM (like $subject), or for implementing autosuspend without
actually using autosuspend (usually because they predated autosuspend).

At the same time, it makes it harder to reason about the runtime PM API
surface -- because currently, .runtime_idle() is a primary reason that
pm_runtime_put() and pm_runtime_put_autosuspend() are different. (A
secondary reason is the last_busy update -- which is exactly the problem
we're talking about here.)

I have some experimental patches to remove it entirely, but I wanted to
clear this obvious problem up first.

> It
> arguably would be nice to allow them to just declare that, for example
> by introducing something like pm_runtime_use_autosuspend_always() to
> be called instead of pm_runtime_use_autosuspend() if the driver wants
> rpm_idle() to always set the autosuspend timer instead of attempting
> to suspend the device directly.

Maybe. I don't really like forcing driver writers to think about and opt
into yet another quirk of RPM, especially if we can reason out whether
the existing behavior is bad/quirky/broken, and that the new behavior is
in fact better. (Frankly, I don't like making driver writers think about
rpm_idle() at all. IMO, it makes more sense as an internal
implementation detail than as a part of the client API.)

If we go this route, would you be open to making it opt *out*, so
drivers can opt back out (hopefully with clearly-documented reasons we
can treat as problem reports) if necessary? Otherwise, I think we'll
have a hard time bringing drivers along, and instead we'll simply have a
more fragmented and confusing set of runtime PM features.

> I think that using pm_runtime_use_autosuspend_always(), if it existed,
> might be attractive for a couple of reasons.  First off, which is
> rather obvious, a driver using pm_runtime_use_autosuspend_always()
> wouldn't need to worry about last_busy at all, so it would never need
> to call pm_runtime_mark_last_busy() or pm_runtime_put_autosuspend().

Yes, that would be very nice.

I also don't think drivers should ever have to think about the
difference between pm_runtime_put_autosuspend() and pm_runtime_put(),
although I think we can get there in other ways (removing
.runtime_idle(); rolling pm_runtime_mark_last_busy() into all the put()
helpers, or possibly to rpm_drop_usage_count()).

> It would just need to call pm_runtime_use_autosuspend_always() once
> and set the autosuspend delay (which may even be combined with the
> former).

> Second, the autosuspend delay of a driver using
> pm_runtime_use_autosuspend_always() would only need to cover the
> period after the last runtime PM reference to the given device had
> been dropped

I'd agree, this sounds very nice, except for one concern:

"Last PM reference" can be a bit subtle; particularly, the child only
drops a reference on its parent once it *completes* autosuspend (even if
it was last "busy" much earlier). That means autosuspend delays become
additive along the hierarchy. Is that desirable?

Personally, I don't think so, and that's why I chose propagation (my
proposal), rather than extension (what I'd call the behavior you're
describing).

I also _think_ that's what Jonathan was saying here:
https://lore.kernel.org/all/20261103231719.486a18de@jic23-hlaptop/
But I'm not quite sure, so I'll leave room for correction here.

And really, I think this is the main distinction between our proposals.
(The other is that you're proposing making this behavior conditional /
opt-in.)

To me, I think it's important to distinguish when the last real *use*
was, versus when the runtime PM framework (timers, etc.) hadn't yet
decided to suspend. Autosuspend is the trailing indicator, while
mark_last_busy() is the leading indicator.

Maybe I'm missing something though.

> while currently an autosuspend delay needs to cover that
> period along with some (usually unknown) period of device activity
> between the most recent last_busy update and the time when rpm_idle()
> gets called.
> 
> Thus, with pm_runtime_use_autosuspend_always(), the
> autosuspend delay usage would be arguably more straightforward and
> easier to reason about, and also the autosuspend delay might be
> reduced in the majority of cases.
> 
> Of course, drivers that have the "unwanted parent suspends" problem
> might switch over to using pm_runtime_use_autosuspend_always() and
> adjust their autosuspend delay values to cover full periods of their
> children's suspension.  In theory, it should be possible to reduce
> their autosuspend delay values while at it, for reasons explained
> above, so the total average system power might even remain unchanged
> at least roughly.  That overall might be a zero-overhead change.
> 
> Using pm_runtime_use_autosuspend_always() would also make autosuspend
> work consistently in all situations regardless of the reason why the
> last runtime PM reference to the given device had been dropped,
> including the "power/control" manipulations from user space, in which
> case it would be equivalent to calling pm_runtime_mark_last_busy() in
> the sysfs code path mentioned by you above.
> 
> Moreover, suppose that pm_runtime_use_autosuspend_always() turns out
> to work for everybody, regardless of whether or not they have the
> "unwanted parent suspends" problem.  In that case, it will be possible
> to simplify the whole autosuspend delay handling quite a bit.

I think many of these simplifications/improvements you talk about are
good. I also don't really think they're unique to your described
solution; I think we can get many or most of them in other ways too.

For example, I think that with my propagation solution, we also can
likely reduce autosuspend delays for many of the same cases that could
be improved with yours, if that's deemed valuable.

Or if we really want to go all-out on reducing inconsistency in
mark_last_busy() placement: we could add pm_runtime_mark_last_busy()
into rpm_drop_usage_count().

I also would like to add / repeat a few questions:

What, specifically, do you think my proposal misses?
Too complex?
Doesn't go far enough on updating last_busy (e.g., with the
pm_runtime_allow() use cases)?
Wastes power? (In what ways relative to your proposal? Simply because
yours is opt-in?)
Something else?

Or because its concept is not good? For example, I don't think you
really addressed a question from a few replies up:
https://lore.kernel.org/all/auzlLwlleGLPsLcw@google.com/
Rephrased: why shouldn't the parent's last busy time be the same (or
later) than the child's?
Your proposal seems to achieve almost the same (in fact, it's more
aggressive), with slightly different means, and with more complexity for
users -- that everyone has to opt in, and to think about what rpm_idle
is.

And a similar theme for other unanswered questions:
https://lore.kernel.org/all/auzlLwlleGLPsLcw@google.com/
Why shouldn't pci_config_pm_runtime_put() (and similar) update
last_busy?

To me, if we can't properly address the question of "when should we
update last_busy?" (and instead defer to yet another opt-in feature
within runtime PM, without making sure everyone can use it), then I
think we'll never *really* move things forward.

(And to be clear: I'm not trying to ask these questions to drive "my
solution is better; why don't you agree?!" I just want to understand the
principles in the design, and in the decisions you'd like to make here,
so I can help make sure they do indeed make the driver experience
better, and that there is a good path to convergence.)

Brian
