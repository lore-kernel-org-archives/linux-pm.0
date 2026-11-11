Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428422;
	b=XJn+0XX+5crc74yLJ/EAOouLqeKQxRL/B/K4rlXBvIz9qDmghb3CimGqkTTJglEuxAtX
	 d/U67kJf1ur6cfeVVIpqZS7XCpAxS8Xq7k32YYJkRw/J6embitUndI788vg/3esH4jKme
	 h30esGVW9ytvbFRF7qOL49dYxx23ZA74y3bUExhXSINSR3hQJsrEIKkNE4O+9rANy7Cqt
	 CI4UfY1BGiUlphqTKLK1tv0ql8YANFhiV68pMJLhj/Ot4wcKOYdVmdOWKS8fjuSA2q4yI
	 JOPMinx6j6VU5mMkyZEOdNAG09W6rWcBmpIttgGNSvGhiE2G1/wFHLLIQTZKb4Wyg5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=yjMHwJowCgljXYdOuz17suaOhns7jTmqFcuqV1/rikE=;
	b=2WlcvaZWmDMaPJEbJ/njiZJbtWfpHHIlREp2ebkI3gfx+TJZ1iqBNI31/una0hCZcNAy
	 nPY7JF8PkvOPCMlJpIFKK2RG33sMS6NPuhi4c2pUDSGvBqC1cgULer+EAY//pBR3gIOW7
	 E9ojyuiseJ8NWybFEWVe0TNw8ACPfoa5TOnY+onc6O+W6Ingi6FfrHzNNl7W3YShR+nna
	 R5GPBSu6kcwNQuwsx4RzJtmKf12B/TLL/7ZYKumFXDhOg4gdKgIsaxT7DKDQVEorLuD/w
	 NiJFIWdkQWgRaS4ZM5x5tK5qHpkzcS2jsOon6JX0MSpjTARSmtUioNicRQI53n4qtHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=R9JrZi7N;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612A606A332
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C612A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=R9JrZi7N
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53665358476so34678201cf.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794428421; x=1795033221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yjMHwJowCgljXYdOuz17suaOhns7jTmqFcuqV1/rikE=;
        b=R9JrZi7NhUwEn136m7E7v6uW/VyeO3KBnSCiP7uP8RpJdMefZ8oTNA9WKPWMkHrvQ4
         0EDwYZIYVnLJsSemT0msnGLMqFhMKuk4Dgv++96Q0v6mS0RNsDkig9WcT40aqrc5Q/ZP
         KTQvF2GHk+0SLyodeJuDNWtz6mM922L0VqSjINr19G87vX2YhdGIdpbn9w1OR0gNfrrV
         YA80STcTMFbLyLoVjqNgh4UrqwGPpahlWDVwIxHLz7GCLa78O/MLv/Djsor2liS/awpP
         RZb6uDj4L/Xc+oTtWIes+OgGGBzE+T2LYTrYfn1THeLqazb312TL3J0bA/M+WHYabnB+
         fyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794428421; x=1795033221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjMHwJowCgljXYdOuz17suaOhns7jTmqFcuqV1/rikE=;
        b=uZmDuesnkSpVQtPFk/4omkn8d/tJRsaxusTltalb3aW1ZEYmRVa5wo16+WH1rM86EK
         uONU7uwa75qNfrw9v7Lq61BZI5LohHlxGw8WRXQ6BKyHUZK9NAaC+JuPiWEf07pkBwqP
         7+1ThHjhW3dn7jDsKIYisy4m8VMqbE+tnx8ILURvGGMJA+l9Abc25odvYHIIiBSwre1c
         CabRvPbf3Xtzk3hXIo97d349e4kF1KW2F+S8ghysSEPXLjZLpZ7mQeKNYw0zA1zF6G3x
         1yXu0SljJjRzTizrJjUHEHkeYoF8r3POg/AYuJN2N3lKwa2kHtbvtOm7J86pX5fVICiV
         eW8g==
X-Forwarded-Encrypted: i=1; AL+hErGybuP7ZHMBv739oNvhzJzfPll16h31mrIjV7YSs1Z1cbmRtGgUK9Bf7XLeIhdAGY78DEofrZJhfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9tqoqfRjkzkP0PaTSkwBuMzpUMeaziW605KJpmc1AG+478ltSb
	Cx5Lg012s5ilY1t8G3ATG97hLGnNj0p9OYROW/e5FgtksGHQBpydxsC4D9mWbveqFA==
X-Gm-Gg: AYBFou2s7OyRptndTRxRrWZDb/XU/fy6/9tKabET3o86YQ7wMlBcbwVcMTNkET/faga
	u7F156Q7XyuF+RduRUYeiiqAPBGFJSeThiSTjpwJDn/bXvMiCc8hkqEfxBbQyqLfgBnHrApQO+i
	FpnisppVSWeXoXX622mVbhC5UWes6/avyEvqv/eoydtpksIkc7FiAmsTv9F5K6kSKz9x0ti7W6B
	YMXWBzN8CZqQLmLH0KGhSxelxeu1DmXaPJZJzpGWOmkCZ8evKy97f0pDYWu54aKTwSpsYUHDu0y
	s8YkJUa+e8Iep57P/msQ62zAM4CUdvdj8nQAvAbjr1CASyWtTt6XRPuSaCFVAcMha22mYYQ2Sn+
	tVXD4XZRJl/xAI3kKn7FELSrSkky9E26HaxEEyBIcCet7RV2VCwTES9XvhWphZb+UUfuM4lkaeR
	kdgwcifYH0pak/etTWH9WyOi7V0CAtXL2MktMIFRp+vkbdIyfs0hlPkt9JtZio2bKvGhdDZWY21
	OclB9vH4TJljhva6W8u4E7htC4BhDoKmlHdmx7dIyfwNDufYdTg6ezE+avtvEerjkXxGTEPrB+x
	WyDj9+9/5QvwAc7j2+i1OmI3y8Ml+Xo=
X-Received: by 2002:ac8:5713:0:b0:545:c5ec:fa3f with SMTP id d75a77b69052e-556c04f0896mr55320911cf.45.1794428420597;
        Wed, 11 Nov 2026 12:20:20 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::d355])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm57646591cf.16.2026.11.11.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:20:19 -0800 (PST)
Date: Wed, 11 Nov 2026 15:20:16 -0500
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
Message-ID: <fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu>
References: <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
 <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
 <avOw_4ZkqtKFHu1B@google.com>
 <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>
 <avSa97F1Nu1LTSCA@google.com>
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
In-Reply-To: <avSa97F1Nu1LTSCA@google.com>

On Wed, Nov 11, 2026 at 08:42:31AM -0800, Brian Norris wrote:
> Hi Alan,
> 
> On Tue, Nov 10, 2026 at 10:47:59PM -0500, Alan Stern wrote:
> > So yes, in the current scheme a parent's inactivity period doesn't start 
> > until all its children are suspended (unless the ignore_children flag is 
> > set, but never mind that now).
> 
> But to be clear, that's not actually how runtime PM works today. It only
> works this way for the very small handful of drivers where the parent
> calls pm_runtime_mark_last_busy() in .runtime_idle(). I think several
> people have acknolwedged that this is a bit of a hack, or at least a
> missing feature in runtime PM, and probably should be extended more
> widely.

I have to agree; it seems like something we missed.  But then, I've 
always had something of a blind spot for pm_runtime_idle().  In fact, my 
overall impression has been that in practice, drivers relying on 
pm_runtime_idle() for anything nontrivial would be more or less mutually 
exclusive with drivers relying on autosuspend.  But of course, 
maintainers are free to do whatever they want.

> > The parent's autosuspend delay therefore 
> > should take into account the expected time before one of the children 
> > may have to be resumed, as well as the expected time before the parent 
> > itself may be asked to do something that doesn't involve any children.
> > (Note that if a device has more than one child, the expected time before 
> > any of its children will be resumed can be different from the expected 
> > time before any single particular child will be resumed.)
> 
> "Expected time before a child may have to resume": isn't that child
> last_busy + child delay?

No; that value is the expected time before the child may be 
autosuspended.  Not to mention that you're mixing up clock times 
(last_busy) with time intervals (time before).

>  So that expected time is already in the past by
> the time the child autosuspends.

You must have misunderstood what I wrote.  Think of it this way: Let's 
say the last remaining active child goes into runtime suspend at time T.  
Let's also say that the parent expects none of the children will need to 
resume until time T + D.  Is D sufficiently large to make it worthwhile 
for the parent to suspend and then resume?  If not, the parent should 
remain active.  If yes, the parent should autosuspend -- and the length 
of time the parent should wait before autosuspending is on the order of 
the value of D (let's call it D*) that corresponds to this crossover 
point.  Thus the parent's autosuspend delay should be set to D*, or 
something close to it, in order to achieve both objectives.

> My point here was that I think Rafael was overly concerned about
> precisely tuning parent autosuspend delays at the same time as changing
> the runtime PM core behavior. Yes, they clearly can be tuned in user
> space; but he was suggesting a phase-in / opt-in approach to this
> change, because it might harm system power if it's not re-tuned.

Is anybody really trying to tune precisely parent autosuspend delays?  
On what basis?  I'm doubtful that anyone is sufficiently serious about 
it to be annoyed at this PM core change (i.e., setting last_busy when a 
child suspends).

> > > At the same time, it makes it harder to reason about the runtime PM API
> > > surface -- because currently, .runtime_idle() is a primary reason that
> > > pm_runtime_put() and pm_runtime_put_autosuspend() are different.
> > 
> > I wouldn't put it that way.  My feeling is that pm_runtime_put() could 
> > be replaced by pm_runtime_put_autosuspend(), since they should behave 
> > identically for devices that don't use autosuspend.
> 
> Ah, but that's not actually true! pm_runtime_put_autosuspend() skips
> .runtime_idle(). It (semi)directly calls rpm_suspend().

Like I said above, a blind spot regarding pm_runtime_idle().  And/or an 
impression that a driver might want to use pm_runtime_idle() or 
autosuspend but not both.

Anyway, pm_runtime_put_autosuspend() could easily be modified to call 
pm_runtime_idle() before rpm_suspend() if the device doesn't use 
autosuspend.  That's not likely to bother anybody.

> I appreciate all the responses. One particular part I did have questions
> on, which I'll mostly copy/paste:
> 
> [Rafael:]
> > Now, let me acknowledge that some drivers evidently want rpm_idle() to
> > always set the autosuspend timer instead of suspending the device
> > right away.  That may be because of the "unwanted parent suspends"
> > problem at hand or for other reasons.
> 
> Do we have any idea what the "other reasons" could be? For example,
> because driver writers found it too difficult to find all the
> appropriate places to call pm_runtime_mark_last_busy()? (Does commit
> b3db492e8335 ("PM: runtime: Mark last busy stamp in
> pm_runtime_put_autosuspend()") help? Or should pm_runtime_put() behave
> similarly?)

I have no idea.  Outside the area where I mainly work, I don't know what 
sorts of things driver writers are doing.  If you know any people who 
are doing this, you should ask them directly.

> I see that USB is one of the subsystems where .runtime_idle() calls
> pm_runtime_mark_last_busy(), and I thought you (Alan) might have some
> more background on that.

I don't remember exactly why that was done, but probably it was meant to 
carry out the behavior we've been discussing (autosuspend delay should 
start when the device and all its children become idle).

Alan Stern
