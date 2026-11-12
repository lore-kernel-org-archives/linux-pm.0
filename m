Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443040;
	b=ALLjyel5aUglK6UxFYtZmJ1/gzj0FO4JGXpwCisYxjfjZLanSc+ZsvG7oLsike3R/U6p
	 ZKcjGHekiX2PoRg+ZIryeK3hT9jIWIseoifb5uFK5xr2x5spR7NqpJfhLxwl/MNJmUCS9
	 lXNMNcYHWCa/4ZH4OYgDvvXMI9PDK/bzEDXZyrO1PMTFzd2TF78ByxFjoUqOR6soYyNqU
	 SHrGQmIxd5GcuZB4Pxq1NdxuXQSQomzXT2XUqiI4KbdkBOFy216g/YlNGE6CR7Ujz6CYw
	 9QDihng6wlz+jzC76d6lK8GFgVjsyCCs+SdfGXaxq1X4k0GJ18hKab3PDTbVuubb7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AvOYiSMUQBE8hHq85U7RnqlX2B8KEnkOUGs6NK6p6bU=;
	b=CoSVar6KRQmWeYDIVc/Ont/pLUOspEwTY5l4xLJXklV7BY6PCDK+qncSXVNcxed32uUM
	 xXP8pfpsDKslkMmK3MnS5bcBxnAxZFdLTtSubaNfeZTNER+h/8R8O9NB6KQw/weuLkGs2
	 Lvk4Dl6jhsNEFGZVFrE90ap6BprmiLFF7B19aCUgszT4qyvGKzvvsa/c1dcNbwLsgyB/4
	 jaw0JiWexjDNhhsOU0YmNC6VRFJ3HjuAqoWAWg677v2WK03iTb6lLgRU6pVxgHpvj/MuP
	 lJfjIpzZfUAHbjcFTdCtnHCB5raaBrOt8R+wnkMbN07XGQz/SMsniadqp0/n6CKtFCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="jM/eBsyx";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A6606A326
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 00:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jM/eBsyx
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3acec6677so5571348c88.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 16:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794443039; x=1795047839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AvOYiSMUQBE8hHq85U7RnqlX2B8KEnkOUGs6NK6p6bU=;
        b=jM/eBsyxf0242IeUk/QFUPK8XD5A2U7cZB5APpSpLED0Ce/mRZUDfV/L19c/zszsQm
         xaQ5b4rlHZ5g/PUtovJIzpy0ObuWoyeT/mck5BuHSHfgQqzVE40Im6Xz7fvVqKsVkVkK
         3yEUP4JP6zTPoCgon9IoLXM6LLP3X5VjaywdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443039; x=1795047839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvOYiSMUQBE8hHq85U7RnqlX2B8KEnkOUGs6NK6p6bU=;
        b=2hf4r+Usgnq4FH1JJFfrnJXuyZmkVHRdICczP/cWupFuZkP9r9Woo9MVGfb+OAAiJd
         cEgwH4O1G+LUcZk/R5pOnR0zv/0T+QfvT8br6MLaUg9g53Lha2KMQ0MUqI9wiRhMNFaA
         iDq7JWtdAwyttaBQZdEgKMjWN1bR6qq4NjbXIr9MFheqwJnZ2uM6KP1/kSw9ZXt7W+ou
         XFkkiT06VzaRIARQVWOmUDFSF6v2J1KX3U5O4P6eh4kfZ5/grJvAPu43wCop73BC1NGm
         XsDazaYm6BBzgAtFsC1VDVstqzRiqfjp2KYU5v6QibFkRzs3HAQoGcfE6Nu+l1mj+t9Z
         mLVg==
X-Forwarded-Encrypted: i=1; AL+hErHY6NSPmQcIGS/U2gsEcXRmx5BvgGOmak9dfQTanWFKwKtqQQu9NllK8bft4JvJkGI3dw1sRRe6hg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9er29romRutkT8rdJdm3P9sQ5qjycxQcVFT5q8AhjCC6DsKAse
	2I3g4ehqBrxiHSYZEpGrZh/gHZ4FLr1q2tDZ3DEh5QH7rsK/zNlWzn9Pplz3+3lY5g==
X-Gm-Gg: AYBFou3pCT4qn2ZZSIE46DH+/ZDedmJPZ83GYSRqIgbvHp2iTMPmIwxgs6N9dPahnpd
	i0A95qUUY82DQ5FY/H3ccofCtsRXQQnhW/pboQxUZgzrgsNTbDkf8jTi5zevqEN6VV+pNtFCZ1t
	nm/NUmMnG5w8c8dW4Wv+nULmu9VaglFy4ztS/AHtUZTYaGMeb5hIney1udmpIrhnl8cyRbog1sd
	5IWEGoP9q0Y5vcaEymWyST+1y413RJ2fMRma3gADToQCAcIG+h/GogTUP5KHSnYY06v0hUoYu4G
	k1RVeFvTc06AVoOal/YZcE4suTjNAB2jpviXiKB3pdk7MsJ6iMev8mMUeYGMSqD/xKjvB2FbwTE
	oSyHgJjzz7VBReCG8nybPl1Dp7DUSdsoZwfgKiOiJKJRmwzvB6M7C/c62UBk3MT11D4JCcj1ST0
	1XVDXd9FAtVLbHAN3NGt8t63o2r4ZY5vaU+4XYFYEc0zACq/pm+K0ge4E4Sxsxn3+/GhsjoCG2k
	sOa638UHF054jLDPnvNsjJaCzEB+SxmIoypzwdGDTBzdTWPkl2W3A7xyfqWMCVBh3OO2noYqWx1
	/WGLhwUsVatMHCsFZUiUsgmmHAz+DcwiMdmWOeofIDBSVcmC5qZvNsLOAaHBvhdKIVrmPQ==
X-Received: by 2002:a05:7022:1711:b0:1a3:65d7:efae with SMTP id a92af1059eb24-1b3c03185acmr3161801c88.21.1794443039027;
        Wed, 11 Nov 2026 16:23:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b3b5890c0esm19834613c88.1.2026.11.11.16.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 16:23:57 -0800 (PST)
Date: Wed, 11 Nov 2026 16:23:55 -0800
From: Brian Norris <briannorris@chromium.org>
To: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
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
Message-ID: <avUHG8mLuTOUMr8O@google.com>
References: <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
 <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
 <avOw_4ZkqtKFHu1B@google.com>
 <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>
 <avSa97F1Nu1LTSCA@google.com>
 <fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu>
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
In-Reply-To: <fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu>

Hi Alan,

On Wed, Nov 11, 2026 at 03:20:16PM -0500, Alan Stern wrote:
> On Wed, Nov 11, 2026 at 08:42:31AM -0800, Brian Norris wrote:
> > Hi Alan,
> > 
> > On Tue, Nov 10, 2026 at 10:47:59PM -0500, Alan Stern wrote:
> > > So yes, in the current scheme a parent's inactivity period doesn't start 
> > > until all its children are suspended (unless the ignore_children flag is 
> > > set, but never mind that now).
> > 
> > But to be clear, that's not actually how runtime PM works today. It only
> > works this way for the very small handful of drivers where the parent
> > calls pm_runtime_mark_last_busy() in .runtime_idle(). I think several
> > people have acknolwedged that this is a bit of a hack, or at least a
> > missing feature in runtime PM, and probably should be extended more
> > widely.
> 
> I have to agree; it seems like something we missed.  But then, I've 
> always had something of a blind spot for pm_runtime_idle().  In fact, my 
> overall impression has been that in practice, drivers relying on 
> pm_runtime_idle() for anything nontrivial would be more or less mutually 
> exclusive with drivers relying on autosuspend.

I also had that impression. But of the approx 60 drivers that implement
runtime_idle, there are at least 4 GPU drivers: nouveau, radeon, xe_pci
and amdgpu (I'm sure they all copied each other to some extent). There's
also some greybus, drivers/misc/mei/gsc-me.c, and a handful of others.

I suppose you can determine for yourself what's "nontrivial"; and in
many cases, they re-implement many of the same idle checks inside their
runtime_suspend(), so it doesn't matter too much.

> But of course, 
> maintainers are free to do whatever they want.
> 
> > > The parent's autosuspend delay therefore 
> > > should take into account the expected time before one of the children 
> > > may have to be resumed, as well as the expected time before the parent 
> > > itself may be asked to do something that doesn't involve any children.
> > > (Note that if a device has more than one child, the expected time before 
> > > any of its children will be resumed can be different from the expected 
> > > time before any single particular child will be resumed.)
> > 
> > "Expected time before a child may have to resume": isn't that child
> > last_busy + child delay?
> 
> No; that value is the expected time before the child may be 
> autosuspended.  Not to mention that you're mixing up clock times 
> (last_busy) with time intervals (time before).
> 
> >  So that expected time is already in the past by
> > the time the child autosuspends.
> 
> You must have misunderstood what I wrote.  Think of it this way: Let's 
> say the last remaining active child goes into runtime suspend at time T.  
> Let's also say that the parent expects none of the children will need to 
> resume until time T + D.  Is D sufficiently large to make it worthwhile 
> for the parent to suspend and then resume?  If not, the parent should 
> remain active.  If yes, the parent should autosuspend -- and the length 
> of time the parent should wait before autosuspending is on the order of 
> the value of D (let's call it D*) that corresponds to this crossover 
> point.  Thus the parent's autosuspend delay should be set to D*, or 
> something close to it, in order to achieve both objectives.

OK, thanks for explaining again.

I suppose that makes sense, and so Rafael's
rpm_idle()-implies-mark_last_busy() proposal makes sense.

> > My point here was that I think Rafael was overly concerned about
> > precisely tuning parent autosuspend delays at the same time as changing
> > the runtime PM core behavior. Yes, they clearly can be tuned in user
> > space; but he was suggesting a phase-in / opt-in approach to this
> > change, because it might harm system power if it's not re-tuned.
> 
> Is anybody really trying to tune precisely parent autosuspend delays?  
> On what basis?  I'm doubtful that anyone is sufficiently serious about 
> it to be annoyed at this PM core change (i.e., setting last_busy when a 
> child suspends).

I fully agree with you, which is why I don't see why we should make
Rafael's proposal conditional. We should just make the change, IMO.

> > > > At the same time, it makes it harder to reason about the runtime PM API
> > > > surface -- because currently, .runtime_idle() is a primary reason that
> > > > pm_runtime_put() and pm_runtime_put_autosuspend() are different.
> > > 
> > > I wouldn't put it that way.  My feeling is that pm_runtime_put() could 
> > > be replaced by pm_runtime_put_autosuspend(), since they should behave 
> > > identically for devices that don't use autosuspend.
> > 
> > Ah, but that's not actually true! pm_runtime_put_autosuspend() skips
> > .runtime_idle(). It (semi)directly calls rpm_suspend().
> 
> Like I said above, a blind spot regarding pm_runtime_idle().  And/or an 
> impression that a driver might want to use pm_runtime_idle() or 
> autosuspend but not both.
> 
> Anyway, pm_runtime_put_autosuspend() could easily be modified to call 
> pm_runtime_idle() before rpm_suspend() if the device doesn't use 
> autosuspend.  That's not likely to bother anybody.

Sure.

One way or another, I'd like to eliminate the differences. And I'd
prefer doing so by removal, rather than addition, if possible. TBD how
it ends up looking, after the current topic.

> > I appreciate all the responses. One particular part I did have questions
> > on, which I'll mostly copy/paste:
> > 
> > [Rafael:]
> > > Now, let me acknowledge that some drivers evidently want rpm_idle() to
> > > always set the autosuspend timer instead of suspending the device
> > > right away.  That may be because of the "unwanted parent suspends"
> > > problem at hand or for other reasons.
> > 
> > Do we have any idea what the "other reasons" could be? For example,
> > because driver writers found it too difficult to find all the
> > appropriate places to call pm_runtime_mark_last_busy()? (Does commit
> > b3db492e8335 ("PM: runtime: Mark last busy stamp in
> > pm_runtime_put_autosuspend()") help? Or should pm_runtime_put() behave
> > similarly?)
> 
> I have no idea.  Outside the area where I mainly work, I don't know what 
> sorts of things driver writers are doing.  If you know any people who 
> are doing this, you should ask them directly.

There's so much ancient history and copy/paste that it's a bit hard for
me to find out who's doing this for what reasons, outside of nicely
documented changes like commit c537d3457542 ("iio: adc: stm32-adc: fix
runtime autosuspend delay when slow polling").

> > I see that USB is one of the subsystems where .runtime_idle() calls
> > pm_runtime_mark_last_busy(), and I thought you (Alan) might have some
> > more background on that.
> 
> I don't remember exactly why that was done, but probably it was meant to 
> carry out the behavior we've been discussing (autosuspend delay should 
> start when the device and all its children become idle).

OK, thanks for your thoughts. In any case, maybe it doesn't matter why,
if we're simply going to move that behavior into the runtime PM core
as-is.

I'll give this some time in case Rafael had any other thoughts/replies,
but unless something major changes, I'll plan to write/test/submit v3
where rpm_idle() calls pm_runtime_mark_last_busy() (part of Rafael's
proposal), and *not* make it conditional (i.e., no
pm_runtime_use_autosuspend_always()).

(Or, Rafael is free to do so, since it's his idea. Just let me know so I
don't waste my time on it. But I figure he'd rather someone else do the
work.)

Regards,
Brian
