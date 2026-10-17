Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E1303A0D
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197287; cv=none; b=b2Y/MO1uYCampR8hDbN3hbCNjD5ZUkzccOL2Ke1txXe1+wgOYcasGv5Y/a+SEFuhp5iHBGAreWTAK1mef6WcABqMMRbRTSAQEH++jzb9ilOf87kr2Gjh4JGp6zQyt7scZPbCv/QvTdZ3kSE1awl1E1LzcQDYWlKMDJv6czpXLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197287; c=relaxed/simple;
	bh=Uysk2PPsTqzTyTiZaUpbdBbNf+bTXc4rWQb7gKDcOII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhQ/zpdq+pd/rDZiTtmTTabpOMdWk30YHTJowiehTxJoPIJ0r7DWG+XQLHXCZaSQunIR1tQdXu6eSIkSrbXaTzJm2UIKYAQUc50bTfNre3ndYyGiQw4DUnOP1Ball2w+KSYlwiAIZZjADejSifaTCax0of3kNF65Al4QhHTAxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BtwO4AKj; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BtwO4AKj"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso558651eec.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792197286; x=1792802086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0aepwILCIIPYy/3iG8trIfjCcCal604FcoCtw2lWda0=;
        b=BtwO4AKjWNCU7Olm6QXFGmR12/0ZFzpxy4YyOeyWcQjd7zO7nnVw5JJ9HpZ+N8vsou
         FHN5QDMYvGo68wHHAZoEZsHyJ6BJ1OSQVRkKH7sNwMde3AaRrzcvVaaM2/ObGbRq6+sc
         tOi0ySPl+1PKz4YWj8A4zIeJLrjPdfxqwNr5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792197286; x=1792802086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0aepwILCIIPYy/3iG8trIfjCcCal604FcoCtw2lWda0=;
        b=hb1Z9KmN9hBAzqF9XpjO0kWcloz8CcuHB2WWd94PSHMZwq5Z4tv2m8Sc7U0xt++iYh
         FkDbim+Y2XRxeFgYIu939Gr2JPZPA0Oi3S7JOjRLZ0R9sXWtX0xQ414NvVcHYS85rP6Q
         haZd+U+s2KX+t0T2/WXC0q7AsFmcjB8eVWul2PQOoyFaSitrv+OvZzTQTE44ONfwgadJ
         1LD/NPCbTBTiEiu3s0QNx0f0XLV0znkM3R2WyRIGt62FBkx8Jw5dyJuoTKkyXwXrwvtH
         XISb0nCF3EHJmQJh8gqsYuddSVc52jQ1meXpttkDgMFLkRpudscE3mAv/kxCdpP/JBLU
         AhXA==
X-Forwarded-Encrypted: i=1; AKwUvBxg7KrCX9jhCjzSQ0ZDxH1FqX48ZJO2k8992f7uHWjHSmt5XcleNl3gkeEsZUIG/wbaPpKZqFsASw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJuZY3OuA5b01SHZqBRdQweH6w97u9IfwMLpwAGMF7hVgPbyCCh
	n3WL0GtnMrk5pMQ6fMUl5hFwt0WGrQdAhyr6gIbbA86UdO68iLcS5Wmcti/zc5crpw==
X-Gm-Gg: AYBFou11vJVE++l2CWlLwt5Xkvg1XQfSEtFfz7iDhxcOTx4shs3EDi+nIdJ1aKx7jf/
	veg38qngAqbGQ19CgZgJ7R58M4jBlFUfj1AfCzCRWP8x8KMZfnKMVWDR/o2bHoNdh6GDaBQmlsy
	lF1TLFlQ8l4aH+1nJ4jFtwEEtGWmdfm7DUW4L7u25ZsYItppKcpb4WxBdh/lW5APLhfBIgbiT3g
	43NrBVSfQdmkKO0OeymOYA+8HG8BPsS9dd4gGBsIU3na8hLLuNiMXGztPC4kC575rCaf65cLYCv
	sGlCDRI5t2bWGmqYxa27WKUgCQiDEdnc0/3bU/WJUfih7MVqhtj+oOc2hDkSfAuCOhJxmJMhlQJ
	bhp95AVo8vf5jEHaMMAXPr44ISjGGomWUt5gn6GF98TyacpWttEhH7MKeryeDLWMB8xVK+diL/7
	wwZTBkoe0M5+F8RMUY0pYxFTT1sr+AJgblNkkU969CbJh1PYBgZ8hE/VrJZDykWeC89pkgwq4JH
	c8Nd7kMiiKmwqRim0AqGf1ip+zt/u809nn8
X-Received: by 2002:a05:701b:4582:20b0:184:19ee:1fdd with SMTP id a92af1059eb24-1850d370592mr1903173c88.5.1792197285806;
        Fri, 16 Oct 2026 17:34:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:d542:736d:a85:f140])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1830f213ba7sm10311484c88.0.2026.10.16.17.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 17:34:45 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:34:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>, Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
Message-ID: <atLCo6LyUmepwg4r@google.com>
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
 <as_i5MEz3WfnDQmf@google.com>
 <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
 <atE9urIHXAJZXu6k@google.com>
 <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>

Hi Rafael,

[ trimming the rest. I appreciate the replies! Will respond later in
  this thread, but largely -- ack. ]

On Fri, Oct 16, 2026 at 07:42:47PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Oct 15, 2026 at 10:55 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Thu, Oct 15, 2026 at 10:11:04PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Wed, Oct 14, 2026 at 10:15 PM Brian Norris <briannorris@chromium.org> wrote:
> > > > Would you be OK with pm_runtime_force_suspend() as an alternative here?
> > > > It seems like some drivers have started using that in remove(), which
> > > > doesn't quite match its docs, but otherwise seems OK to me. I was
> > > > considering that already here, and I even think it might be a good idea
> > > > to do automatically in devm_*, as I noted here:
> > > >
> > > >   https://lore.kernel.org/all/arVWVA3lks7SopQH@google.com/
> > > >
> > > >   (note: there's definitely at least one typo in there; should be
> > > >   !pm_runtime_status_suspended(); and it needs some other adjustments to
> > > >   actually verify the device was suspended at time of enable(); ... so
> > > >   consider it a concept, not a patch.)
> > > >
> > > > But I kinda wanted a maintainer opinion before I went too far on that.
> > >
> > > That shouldn't be necessary as per the above.
> >
> > OK, yes, not necessary in this particular example.
> >
> > But my hope is that devm_pm_runtime_enable() can be made easier to use.
> > It would be nice if we had the property:
> >
> >   If your device was suspended (most resources powered off) when
> >   devm_pm_runtime_enable() is called, the PM helpers will suspend it
> >   (power it back off) on remove().
> 
> I'm not quite convinced that runtime PM is suitable for devm_ type of
> management.
> 
> IIRC, devm_pm_runtime_enable() was introduced to avoid some code
> duplication between drivers, but I don't think that it may be expected
> to be universally applicable.

I also don't think it will be univerally applicable, but:

1) it's reasonably widely used. (220 and growing.)
2) it's commonly used for "simple" drivers.
3) those "simple" drivers still often get it wrong.
4) I don't see a major downside in trying to improve it in the ways I'm
   thinking.

For #3: literally the first (alphabetical git grep) use that calls
devm_pm_runtime_enable() without first marking it active is
drivers/char/hw_random/mtk-rng.c, and it has a bug -- it doesn't balance
clk_prepare_enable() and clk_disable_unprepare(). In fact, it performs
no remove() action, because *normally* a simple driver that uses devm_*
for everything is automatically in good shape. Everything will tear down
in reverse order, correctly.

But runtime PM is crazy, so no, that's not true. Runtime PM allows (via
.../power/control -> on) the device to leave in an ACTIVE state, and for
that clock to be left on. I believe if the driver unbinds and binds
again, the clock may be mismanaged forever.

I think a simple driver like that should be simple, and we can make
devm_* + pm_runtime work correctly for at least the most straightforward
of cases. Is that an outlandish goal?

Brian
