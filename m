Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368885;
	b=ujULvUGLEewy7gsyv8lSbbsreIkFcoq5Of3Ug/8TZwuSA+OFUU03itie1AKU+fhp3J6m
	 IDvQZ7ceSz3JvrsOPIyDRbeHyCXIdnJ6H0aUzEmymB5fGzr+nkqsL7SQEbTSj+7vdp9FF
	 QTToE8yg/kBbwqtLeIHle/t9223wC0niuj215uTmSfyBx4A2iA1VIt8UMdj8RB7oMtzB8
	 qJmcL6i3Jy6Re3ELCoEHcKcgtc7CNc/4CU49XJwJN07R/4+BO84h4d++80W/lMcikrrm9
	 yGH/57kphB4ItPNsxhaxIzUNOpxlko87c9MI5BqNFbGyCvZm1aOrETrdpM/Eg/Gz3kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=yP3MUaap2UdxY9ATROO5FfQ5a2wglkeLGxDqt0I3imo=;
	b=dQm/kSzcGxCZVBBxQF1Gg5dDXcIoCCYTTrUU0ZiMPEW5G8h1zQ7cQEnqe6Jn86/Xf1sK
	 6Vbh8/mzCgE7CiTARd7s5UxKZXf8YH9z6IQESfTjIOHEjsr5EqEkhYlozEpPPdrdjx3j2
	 j2oc70HpGjcYhnUjF8FtWoTPyiQWF+IwD/VsE+WerwiPOBqPYKRGxs05B9snapyOfz2id
	 mOVA6UrC1/2ANGSJsT7nAhkKCMZIY6lOzWgaafbeOBQkiswnAw32LSLY3v2mfE5j2COzh
	 368Y2jN7I2tjxlVnzLJdswWDrwVI2F5nqZj5A82tHFEOdk/2HVNHqenz4K4kUJDxasQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=A+KG9HOP;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28D606A31C
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 03:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB28D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=A+KG9HOP
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9440304604aso290500385a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794368884; x=1794973684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yP3MUaap2UdxY9ATROO5FfQ5a2wglkeLGxDqt0I3imo=;
        b=A+KG9HOPsyaN1vGHd8cK1KSCmV7DvTmGOKgFtUX//0kPKXc4AiIXd+gNr1ORrDq/7m
         NgR3okExOZmsrveK7rl1AxDr3Y0vyk9U8q+Qk3nGrNoIrLobOLj8ynPBybCqOzxp9so7
         LfqXhh6013kC00eQpBefjbde/5F00bDVxBupiTl49OomTqG4Q53WT2fcUHU5R+zolFPr
         96+rs611Rlndxz/XLFhnHY5hWZDFpCDc3EvO6VPyjgKycN9zA8JMKxkb7VRgDlxyyK4Z
         Z/lMgpt2FP2dQnvE4otO6bTcNNKeor7oNZid3Hm5DKD29ERn6wLXmKNr+dtAGvE0ZPAf
         BX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368884; x=1794973684;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP3MUaap2UdxY9ATROO5FfQ5a2wglkeLGxDqt0I3imo=;
        b=TiCMPfbETMZlrfiqV7MP2K2Flm6V7upQh6jiSenDcBLXhTzqRYo3DenJaxFseNgV7I
         nW3WPrrXfrdra9z0fkdcW626SFjarmOOjZiYvu9UrAgDwNtw8DrEV8J98MQFnBjHczaZ
         Va+w1KzNhaITbc7I6hxstR7Zq9SB0cHQuNUNw1iy8sXUmW3Yyy63saybqOh7xje1k5EM
         u+sM9htETieIGB7MZStWqdcWBUsHIHblaGnQjh/EVyz9qbwg0qGq/cPtdIHYOntojKoU
         K02VoMBNJbsDAVsatnQHQKgZ7lUchs73/V0BhmtJSTQGqLjTQgqyDyZNIUtqu/bZHzVG
         KetA==
X-Forwarded-Encrypted: i=1; AL+hErGjGRT+wQ/55m7UlR1huiLrZZsHxA6AZ1WtMSYAUm+YF+D05Hqg+BWc/zlkagljkk90QQBoLAmntg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8jC8Jj8eVlwOYmCMIfI1aYTBQmqDYxt8c2qIEh9okOYo75K93J
	3CYWGl8juMXSafCbQ5N6V0wP+t6TZnRdzAvPIG7JkO2YdU6pfZdeJ1+MyqehkXB2Rg==
X-Gm-Gg: AYBFou03O39KHyOlHdF8qFG7CUzIjca5yF7xt2jwkJQgk9Aw506HoKbDkxJDntEhoML
	zRmlnovQPNIESzS9VC9jnSn24WMoXc6f2Nm1HzR0W0VuuXaZJsz+cJIGj8iisCWuHZS8m+vIEtz
	2yM9/zA8BTwU4T/HcrtXMsTblrvnSMQcCRK5gup4A/PXrQ3VoS6a49dwxqw+DaAh+Sw9uCj+seB
	Z48KvSHeK+OhrRPgBA1IhJYvzyxDGE/7zgMVsZg9PWoMMdtg0QE7fVuuzVqf2JIN0RMTx2AKcIX
	05IMZZl5yQmbAVPJnmCFYzhaZOkhXrAMM/p679jU4Lfamc8T6C3qgsrqKLubAk/LR49okEF5qR1
	azuyn9EovaZZHs8N/aEnUmTMOwwpcqrERhsQ24bSvvn2zKu7HHRUXizBI+a8rZsc/opfmNVB0b8
	AHU7LbFW+9hFo+QUZQ1LYo50+87UxZfdEvilcubFWdmpZTvGJR9FX1HeO4/ZEAeuTDe6EWZGsnV
	r2r8n1T6McnfoRwGuBeEQ7TFhizxMb+iB4yFzJbRr26xXRHFBQReslunvHkFMIYJb6AOdRZlTpQ
	q1iMuoRyR8PKn4bZyBf/a8btqUUgJQ==
X-Received: by 2002:a05:620a:710c:b0:93e:5677:317b with SMTP id af79cd13be357-947ae870df7mr271298485a.25.1794368883684;
        Tue, 10 Nov 2026 19:48:03 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::d355])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e9b4bsm385166085a.39.2026.11.10.19.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:48:03 -0800 (PST)
Date: Tue, 10 Nov 2026 22:47:59 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Brian Norris <briannorris@chromium.org>
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
Message-ID: <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
 <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
 <avOw_4ZkqtKFHu1B@google.com>
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
In-Reply-To: <avOw_4ZkqtKFHu1B@google.com>

On Tue, Nov 10, 2026 at 04:04:15PM -0800, Brian Norris wrote:
> (+CC Alan, since he wrote much of the autosuspend stuff, but also
> because he might(?) have better context for some of the .runtime_idle()
> + pm_runtime_mark_last_busy() questions)

I'm coming into this discussion in the middle, so I probably don't have 
a good picture of all the issues you've been talking about.  From what I 
gather, it sounds like this is mostly a question of how long a parent 
device should delay autosuspending after all its children go into 
runtime suspend.  Is that right?

The idea behind autosuspend was simple enough: Try to optimize energy 
usage by putting a device into runtime suspend only when it seems likely 
that the device will remain suspended for more than a brief period of 
time -- long enough to make the extra work of suspending and resuming 
worthwhile.  In principle the driver core could collect statistics for 
each device about how long it remains resumed and suspended, but the 
benefits of such a detailed analysis didn't seem worth the effort.  And 
given that drivers know more about how their devices will tend to behave 
than the core does, it made sense to let drivers determine the best 
autosuspend delay time for each device individually.

In theory, a driver or bus type might want to have differing delay 
values for the time after all children are suspended vs. the time after 
the device had some other work to do (not related to its children).  How 
much of an advantage would that yield?  I don't know, but I felt that it 
wasn't large enough to put support for it into the first implementation 
of autosuspend.

So yes, in the current scheme a parent's inactivity period doesn't start 
until all its children are suspended (unless the ignore_children flag is 
set, but never mind that now).  The parent's autosuspend delay therefore 
should take into account the expected time before one of the children 
may have to be resumed, as well as the expected time before the parent 
itself may be asked to do something that doesn't involve any children.
(Note that if a device has more than one child, the expected time before 
any of its children will be resumed can be different from the expected 
time before any single particular child will be resumed.)

The simplest way to carry this out is to do pm_runtime_mark_last_busy() 
whenever a child suspends.  But other approaches to the same goal are 
conceivable.

Of course it's not possible to determine an "ideal" autosuspend delay 
time.  In fact, I suspect that in most cases we aren't even close.  But 
I think doing it this way is still better than anything else that isn't 
a lot more complex.

> I don't think we should be treating current autosuspend delays for
> parent devices as meaningful at all, per the above. So I think this is a
> chance to try to improve the architecture so it makes sense, and then
> figure out if any existing delays should be tuned/reduced.
> 
> Ideally, yes, we can avoid making significant system power changes to
> the negative, but I don't think that we should prioritize that above all
> else, as long as it's *possible* to tune the autosuspend delays in a way
> that makes sense.

Of course it's possible to tune the autosuspend delays.  That's what 
/sys/.../power/autosuspend_delay_ms is for.  Whether it's possible to do 
so in a way that makes sense will depend very heavily on the type of 
device in question and the way the system is used.  One possible 
approach might be to have a userspace daemon that tracks all runtime PM 
transitions and tries to do some sort of dynamic tuning.  How well would 
that work?  I don't know, but it would be a good research project for 
somebody.

> Side note: I think .runtime_idle() should be removed. As far as I can
> tell, it's only used for working around architectural problems in
> runtime PM (like $subject), or for implementing autosuspend without
> actually using autosuspend (usually because they predated autosuspend).

I have never given much thought to runtime_idle().  When we were doing 
the initial implementation of runtime PM I didn't see any use for it, 
but Rafael was quite certain that it had its place and the issue wasn't 
important enough to argue about.  I wouldn't mind a bit if it were 
eliminated, but I also don't really mind the extra overhead of the idle 
callback pointers and support routines.

> At the same time, it makes it harder to reason about the runtime PM API
> surface -- because currently, .runtime_idle() is a primary reason that
> pm_runtime_put() and pm_runtime_put_autosuspend() are different.

I wouldn't put it that way.  My feeling is that pm_runtime_put() could 
be replaced by pm_runtime_put_autosuspend(), since they should behave 
identically for devices that don't use autosuspend.  (If there are any 
devices that _do_ use autosuspend and also use pm_runtime_put() -- well, 
I'd say that sounds like either a design error or a simple oversight.)  
The reason for having two different routines is mainly historical: 
pm_runtime_put_autosuspend() was added some time after pm_runtime_put() 
and we didn't want to mess up the existing callers.  Maybe this 
judgement was a mistake.

> "Last PM reference" can be a bit subtle; particularly, the child only
> drops a reference on its parent once it *completes* autosuspend (even if
> it was last "busy" much earlier). That means autosuspend delays become
> additive along the hierarchy. Is that desirable?

That's up to the maintainers of the device and its bus subsystem.  They 
can arrange the default autosuspend delays any way they like, taking the 
children's autosuspend delays into account if they want -- and the user 
can always override the defaults.  But one thing that does _not_ make 
sense would be to have non-additive delays where a parent's delay is 
shorter than its child's.

Your email was fairly long, and I have touched on only a few of the 
issues it brought up.  Is there anything significant you still want to 
discuss?

Alan Stern
