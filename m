Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7D4ACC74
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226778; cv=none; b=DVMUkwt8pBzKWfYFWXAhKoYq2Tmy3ngw6lr4hCTtym6CCoflPJZ5wDTkyJaw1pDqPE8EsJkcAtOTE7NkhKrodFJSr8PVe4exhPBejtWoe/mZKG6lTQyhdNavmC9Ylim4zTGk+1XZF9eLtekIM7FhvLYvCYf10L7phCQAOfM3Og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226778; c=relaxed/simple;
	bh=SRcC8ohDq6n1/1x6uEFOzKfccQ4AUSwXZvAuiYjE+d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce5hPjinm2mIfcN30BiBGZIU8TvIOPdoleLlUpc9109sel/h9F6s660FNoObBa9/cAEBXa9cxKL9DhMqT2YVt8+DsDzCOFQT15pkW1p8x0SDhiVoEUwfQN26mdNmBK3YnATnt5bxZn2NAC1cGk6YroVcQmfKkJmZrCHEUVkIK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G4cuvJ2y; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G4cuvJ2y"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so6702369eec.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791226776; x=1791831576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=34Mc2VGmFq4+SQZVPBzQPN4LtH9/hpTQPAekRG2rusc=;
        b=G4cuvJ2y3Vi3vcYL+MrUs9GsLiO7W05OgIG15dVMH4EfF3C/NPnpBneKEKrK3tJOMR
         wDcJAwXTw3M1KsQKcM65DcqzTVUFw7O//niWgSxrWHs4ZlN3AtZKaKesVLgDX3AYkpt8
         mlcDRGp9LrK1BADyxjJ8Fn6LNSvr0icuBnK5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226776; x=1791831576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=34Mc2VGmFq4+SQZVPBzQPN4LtH9/hpTQPAekRG2rusc=;
        b=IWiwt7JAmftxNQ2KyWgHuyQX6UopiA5IMS6T+QnhzVNQaee1OiW1hDifEz5+j6fZZ5
         9WOfo413Mcu1bmWo9675ummvmDOuNYNxyMsfH5F78buhIl7XYgK4HJXTeGCYxwzF6K3n
         sAVXWj1K8wrSqTWFrc03sUgAMnkYytGTvk7fT99wfEHndqQ4xsuk1o2XqPK6a2OPP3cb
         hzm3MU/qUiGLybhwUd+axPrQ8Kj9qsHRO71ulfh+z4gnF+M1o+ReLscA4fP//sFh1GFZ
         fejNZCVIqRkZms1FHc9CWbE/1O5KeECeThwfxAGqk+GwOURMl0GcE7renW1axRdBGiHm
         V1hg==
X-Forwarded-Encrypted: i=1; AKwUvBzF8/uCC6zcNpDN+78T69VsjT1DBxKEOGez1SwypJWAQwdp+xms2MzHbeWXApbeA4FwHuulODQV1A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLifkRNOKRF288Gga89NzyK7iGGU8A8PQIyBmwAQse9J3joFOwl
	HocvN9x9gXYjky1jahpYUIncSiPHLgYr+Dl3vUzJjVj1W9SU/yijoWAbEmnk2qJvrryFzV/oIf6
	ex2A=
X-Gm-Gg: AYBFou1lqDMFKYkyflqpKD9vpPgNQkdlo/WbHAohIsuyKuEMqWavbvtzV71w/Oq7EoW
	xTURM8A9gSN7Y51hnrbnU4hJQBRu8kTsHhqkxLrT3Tvht0LVctDascZASEemDBPr/sBvjkYRwMp
	RiJBihieiAB6zuiwA1vroZpf7clkN+xjWqWE6XkHctjVn0/fSwZXxrfjEGXtVaOjWGlapBJmXmV
	776+Irs4OIjBOwcKBrZWO34fD8d0+DHfJ7N4LjB4NjGeijnqlE2ubYx+utrXl6B+sEgXktvGNoU
	L3MtddtOjqw83qREKyl2oeAHdnMYMGpmVlJi8WFBAcZM6RxuATosrQeE/iQxj8osmk5wnAY6PU2
	pDUDSC5piWSSeMR84mo9OYa6rAeTkwbjjP+tW+fGU1sBl+GUzEGvWY0b+JcdBBfErFvy6RrjZu2
	K3IBkcZjq1uuCxqUsLTgi08XvVf63N4ApEirQ9/ScITycvBG2ysMq4y9DVkxaiF2POdQzfOfdTX
	VXDjux5/6cFh6dMCGdTEIbk/jHoiBXbRXX0
X-Received: by 2002:a05:7301:fd8c:b0:34c:4af7:4da4 with SMTP id 5a478bee46e88-35111732d3dmr9225010eec.39.1791226775679;
        Mon, 05 Oct 2026 11:59:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:3452:be62:94e:a46d])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-35146abff39sm233580eec.21.2026.10.05.11.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 11:59:35 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:59:33 -0700
From: Brian Norris <briannorris@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] PM: runtime: Avoid racy clock checks for
 autosuspend-retry
Message-ID: <asPzlc60S4N3sIrk@google.com>
References: <20260929184729.2346769-1-briannorris@chromium.org>
 <20260929114714.2.Id0a3276d23d30e0b5fd4d6dca730be0f9d8fe018@changeid>
 <CAD=FV=WPohx1seYHdw0Mi=5xh8XCWvh23ie03+ePXQgTixGzOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WPohx1seYHdw0Mi=5xh8XCWvh23ie03+ePXQgTixGzOw@mail.gmail.com>

On Fri, Oct 02, 2026 at 05:27:23PM -0700, Doug Anderson wrote:
> On Tue, Sep 29, 2026 at 11:47 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > @@ -242,7 +242,12 @@ static inline bool pm_runtime_has_no_callbacks(struct device *dev)
> >   */
> >  static inline void pm_runtime_mark_last_busy(struct device *dev)
> >  {
> > -       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
> > +       u64 now = ktime_get_mono_fast_ns();
> > +
> > +       if (now == READ_ONCE(dev->power.last_busy))
> > +               now++;
> > +
> > +       WRITE_ONCE(dev->power.last_busy, now);
> 
> While we definitely want to fix the problem identified in this patch,
> the proposed logic doesn't sit right with me. Let's say that
> 'power.last_busy" starts out as a given value, let's say "1020". Now,
> while the clock hasn't ticked you call pm_runtime_mark_last_busy(). It
> detects that 1020 == 1020 so it sets the time to 1021 so it's
> different. Now you call pm_runtime_mark_last_busy() again when the
> clock hasn't ticked. Now 1020 != 1021, so it goes back to 1020. This
> could cause the whole heuristic to fail, can't it?
> 
> Maybe I'm just worrying about something that can't happen, but the
> logic still seems odd.

Thanks for pointing this all out. The above solution was trying to be
too clever for its own good, and left a different set of holes. It's
definitely odd, and I think it points toward:

1) either we somehow have to be even more clever or

2) we really need an additional state variable.

I don't think #1 is a good idea.

And #2 was what I was pointing toward below the "---" fold, mentioning a
|last_busy_counter|. I thought we could avoid it, but I believe I'm
wrong.

> It felt to me like we could just have a "bool". We set it to false
> before we call runtime_suspend() and we check it after
> runtime_suspend() returns. If the bool is set then we know they called
> pm_runtime_mark_last_busy().

Yes, I think it doesn't even need to be a counter -- just a bool is
probably fine.

> There shouldn't even be any weird
> problems with weakly ordered memory since this boolean should always
> be cleared, set, and checked in the same thread, right?

Well, it *can* be set in other threads (there's intentionally no locking
on pm_runtime_mark_last_busy()), but as long as the setters we care
about are in-thread, I think the only problem we'd invite is reading a
false "last_busy was set", and performing a spurious retry.

But potentially-spurious retry is already baked into this protocol.

I'll let this sit for a bit in case somebody else has other
thoughts/suggestions, but otherwise, I'll probably end up adding a
"last_busy_updated" field for v2.

Brian
