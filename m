Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910068;
	b=fTn40vPcQO4QQ0k19+jO2XBRKLPOdbF5h8orDFbiv5BIDaTzJUIDZIshzCbXevgFJo/G
	 ea8rytuMmxyLeL9ttBrwq3IznZWZpv5VWKgWdA2KrunPA0JCh2aTksr20ASH5ywV7fzLi
	 55SzYE4kHj9rsgBIEJcHoy1tiFgZEOO/fmcMMSFUJvhs2HPChGy1IFXiWloURMX8K2C3O
	 i/atoix47h0pa3Z+pJNoA2LbRUMtzApYdLm8nNihF8f7IRzGODrCyuxJGAEIHmv2Zg3tB
	 OsXSCdTB2tMzCB/2oXZ1xTgTVRwdJg7F6xQ8J0lyt5a/oNQvQgL4IjGGq88qdVhnZ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=AMtCKx/5mnMTAZ9wh6V8t6oGE9S2neOjVqV5wKKM7ME=;
	b=Sr+ItWYKcVMeZcfCaA4IC7OC1+9Feq+lqeLVp/I1szV5Y34bElU6qcPlq7AlEBN1oMcH
	 ZYeRftu/crVm544Br09sPmQr08C4amYI0Z/NQAtNDPQjzzF1HkFAodHrGDwcXcy+w4mPW
	 2gMJG2P8NKBkmJzuzEz1RMF2KRClu2LdQ3YNYqhbQp0yIoxVv1py5Rcw9aZNG+H/hFwwJ
	 Wl6IrQ6b4PvA5KhRmhN2GbWERZUWLpH5uMQrLBrKIPjA4SMDTeq7vgCysCOg7wYhHqq4C
	 r4f6+KeNPrF8MoL+hkjCK8u6WpzxquK/2RkZq4r1IqL0pKzcvElQi0sSyz3U0YUIhRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gfwCS1+c;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC2606A326
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 20:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56CC2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gfwCS1+c
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so2743709c88.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 12:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793910066; x=1794514866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMtCKx/5mnMTAZ9wh6V8t6oGE9S2neOjVqV5wKKM7ME=;
        b=gfwCS1+c55KGmQAMVr6+mofYC8dCkWrjwf4dKb1UFgLS6qXk688QRvzy2CwAih9NJG
         LiFFzp3sK36XioDnYKqfDRdYjzLYllGEZpuamLS/KSo5GgayzTW86StIVz30rkY3rGr8
         zoMjCNS5aD6qht9CT56xTVlTe8VQ+Dw+ZukMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910066; x=1794514866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AMtCKx/5mnMTAZ9wh6V8t6oGE9S2neOjVqV5wKKM7ME=;
        b=Y3EUl0aH/zVHxSKRmjHbXIUhCzOFBb+6C8sCmnx5lbZdgR9F/EI/p9w2T5poF3Wwas
         zwnPFlp2xuxWuSahbKeTxbrTv+YtY20nAieXObh/nnQXqUuQRGu9WN5uOOIeYXlnFBBe
         pmPOs+P+Mw2Gr7u+cGl3WS07tNbP1OQRC6iDAN0GMlA2oqQQxfo483cArcYdYk3eMnu1
         lYQj1QOw89fY7wb1J1fYB6Bl1OtKTTPa8G22f7gWyiP1nRuUtJCL39ellNFmFxTvYGi3
         OxIilSUdoa/AJtgHjlkZ2NWkiiu7L9f1XDGg3G9lh+8Xia9emgIdBASMSB88V+VLSu0E
         kOxg==
X-Forwarded-Encrypted: i=1; AKwUvBwF1GyW1wjCrwrl65Fdr1v3Ikwq2jbZhiusbHWb9vqswZQpKXIZVR4UbFvUsncJT/c0k4Lf6HKuvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+U0mH8duBxu/uVPDAZAdLzThS1gYJ32mQB3qiszy5rJku/37qT
	UUYUxGGGN27UOs1mePLy0ahXNnQMdukNC/CRolo8M7RNrFm2nYn9KxWx8AbYqv7F7w==
X-Gm-Gg: AYBFou0ky7uy72Fx7Hrz4TT76TOC4AHV3qLRaBbckg5vhF/x0d/5uTcHvJktHHNxLou
	GXaDaQ7I+zRkZJc91+6Ncqa3qd/QY2Y1rfJUhKjDvfhT6XsSBJ5h+y7J7NiZXdkbWenBUTrcCEV
	neiuS2/o8RuWHw5H2OOsIYTDIIkKJ7s/JjpKOSqRAyKUS11rJClGT6pHI87ESiS09AtWSrydK2g
	ItT7RwRE5/J0qZnPhOk7tKr909lS7wUxftm7xlvetgS33DzPSRXWbLjfGUnZ/3td+dHZAw+W2YE
	olpxvd6eCllIF/XKRObcGdBI6wkbMkSNSPS7ZJSWPDE1YRgdjH0C3cOAW5z43SHgXK2KNbDBhn1
	HWBn+r69mbt1ipuocjT2YbHav/KA1EDRBr+8gCzyvqEfti2C6JNLR+K5lCHqE+3ntjh2gSIVe/9
	IMjxc79tz5l1yt/aq0o4ZJR/D5iu40dD0F7Qbxx82bHWB0rnGemYkH6cEEaO5k4Pyi15E90gd8J
	iDoyuLx/ZZnr1n1184vdjf1t91Du84zC4AAVAARJufTvdOH++rZtxt2szGshAP/28SOdEJ9d4y7
	oFxRO/4t+Do9PLMsTor1CGScwb34Mw4jLuIsVENu7ohoZScvqu9lGUci3GnEK7Y7EOY=
X-Received: by 2002:a05:701b:4588:10b0:164:4e36:f956 with SMTP id a92af1059eb24-1b25d3154a0mr121510c88.16.1793910066119;
        Thu, 05 Nov 2026 12:21:06 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bb6d:e00d:d359:7933])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c2d69asm17800921c88.11.2026.11.05.12.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 12:21:05 -0800 (PST)
Date: Thu, 5 Nov 2026 12:21:03 -0800
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <auzlLwlleGLPsLcw@google.com>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>

Hi Rafael,

On Thu, Nov 05, 2026 at 12:59:24PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Wed, Nov 4, 2026 at 8:31 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > On Wed, Nov 04, 2026 at 02:34:22PM +0100, Rafael J. Wysocki (Intel) wrote:
> > > I should have responded to the v1 of this, but didn't manage to get to
> > > it.  Sorry about that.
> >
> > Hehe, well that's what v2 is for :)
> >
> > Thanks for looking.
> >
> > > On Tue, Nov 3, 2026 at 11:23 PM Brian Norris <briannorris@chromium.org> wrote:
> > > >
> > > > When a child device suspends, it does not update the last_busy timestamp
> > > > for its parent. If that parent configured autosuspend and didn't
> > > > otherwise maintain its last_busy timestamp, it may now be immediately
> > > > eligible to suspend. This is probably not expected -- the parent should
> > > > wait for its autosuspend delay before suspending.
> > >
> > > Let's first talk about what autosuspend is for: My understanding is
> > > that it is there to avoid incurring the runtime PM suspend and resume
> > > latency (and cost in terms of energy) in the cases when the device is
> > > known or at least is expected to be needed in the near future.  IOW,
> > > we want to defer the runtime suspend of the device because if it
> > > suspended, it would be resumed shortly thereafter.
> > >
> > > I'm not sure if that is always the case when a dependent device
> > > suspends and its reference to the parent/supplier is dropped.
> >
> > To be clear: dropping a reference is not the point at which we extend
> > the timer -- it's simply the point at which we propagate the last_busy
> > timestamp.
> >
> > The naive algorithm is:
> > Every time a device updates its last_busy, sync that timestamp to all
> > its dependencies.
> >
> > My proposal modifies that naive algorithm so that it avoids additional
> > graph walks -- it defers that "sync" step until later. (Now that I'm
> > spelling this out, I feel like I should have included this in the commit
> > message...)
> 
> OK, thanks for explaining!
> 
> You seem to be arguing that the current behavior is counter-intuitive
> because people would generally expect the parent's (or supplier's)
> last_busy to be automatically advanced to the last "busy" time of its
> last active child (or consumer).

More or less. Or, I don't see why "child was recently busy and may be
busy again soon" should not translate to "everything the child uses
might be needed again soon".

> That is a bit far-fetched IMV because the child's last "busy" time
> need not be the same as the parent's last "busy" time, at least in
> principle (of course, that is debatable, but that debate can be had
> later).

I don't get this -- I'm very much asking for that debate right now,
because so far, I disagree :)

> Still, the underlying observation seems to be that if the child
> suspends and then resumes relatively shortly, it may not make sense to
> suspend and resume the parent in the meantime, which is fair enough.
> Of course, advancing the parent's last_busy will only help here if its
> autosuspend delay is long enough though.

Right. But that's the whole point of this argument -- if all autosuspend
delays were the same, this wouldn't really matter. But the presumption
is that the parent wants delay because it's more costly -- it will be
imposing extra wakeup cost for its children if it's not accounted
properly.

> So you can argue that if the parent's autosuspend delay is long
> enough, then it should prevent the parent from suspending across
> relatively short periods of child suspension.  Again, this is fair
> enough, so why does it not happen at times?
> 
> It certainly does happen when the parent actually has to resume
> because rpm_resume() calls pm_runtime_mark_last_busy() for it then and
> (given a sufficiently long autosuspend delay) it will stay active if
> the child resumes a short enough time after suspending.  However, when
> the child resumes, the parent is still active, so rpm_resume()
> triggered by the child does not advance its last_busy timestamp, so at
> one point in the future it will suspend when the child suspends.
> 
> This arguably is inconsistent, so my approach to addressing the
> problem at hand would be the attached patch (sorry for the attachment,
> but GMail is generally not good at handling appended patches).  If I'm
> not mistaken, it should be sufficient to address the particular issue
> that triggered commit c537d3457542.

It's only sufficient if the child is not active for "too long". Suppose
the child stays active for 2s and then suspends briefly; your solution
does not work.

In commit c537d3457542, I imagine the 0.2s polling example is just an
example; what if that period was 0.1s, with some natural variance up or
down? Then I could easily see how the child remains active for longer
than 2s, and then occasionally is inactive for longer than 0.1s,
allowing both the child and parent to autosuspend.

Or in concrete terms: see the appended test diff, which attempts to
emulate:

 - 200 cycles of child get/put
 - delay in between each put -> get cycle
 - delay of approximately 100ms, with a configurable +/- variation
 - apply the shorter variation (e.g., 90ms) most of the time, with a
   longer variation approximately every 2s

So for example, that looks something like:

 cycle 0 to 22:   delay 90ms
 cycle 23:        delay 110ms
 cycle 24 to 46:  delay 90ms
 ...

With your patch:

   0ms variation == PASS (child suspends 200 times, parent suspends 0 times)
  10ms variation == FAIL (child suspends 21 times, parent suspends 4 times)
  20ms variation == FAIL (child suspends 7 times, parent suspends 7 times)
  30ms variation == FAIL (child suspends 6 times, parent suspends 6 times)
  40ms variation == FAIL (child suspends 5 times, parent suspends 5 times)
  50ms variation == FAIL (child suspends 4 times, parent suspends 4 times)
  60ms variation == FAIL (child suspends 3 times, parent suspends 3 times)
  70ms variation == FAIL (child suspends 2 times, parent suspends 2 times)
  80ms variation == FAIL (child suspends 1 time, parent suspends 1 time)
  90ms variation == PASS (test didn't run long enough to fail)

With my patch, all cases pass. (The child suspends in the same pattern,
but the parent does not suspend in between.)

For comparison, with neither patch:

   0ms variation == FAIL (child suspends 200 times, parent suspends 10 times)
  10ms variation == FAIL (child suspends 14 times, parent suspends 8 times)
  20ms variation == FAIL (child suspends 7 times, parent suspends 7 times)
  30ms variation == FAIL (child suspends 6 times, parent suspends 6 times)
  40ms variation == FAIL (child suspends 5 times, parent suspends 5 times)
  50ms variation == FAIL (child suspends 4 times, parent suspends 4 times)
  60ms variation == FAIL (child suspends 3 times, parent suspends 3 times)
  70ms variation == FAIL (child suspends 2 times, parent suspends 2 times)
  80ms variation == FAIL (child suspends 1 time, parent suspends 1 time)
  90ms variation == PASS (test didn't run long enough to fail)

So, your patch makes an improvement, but it doesn't handle this kind of
variation very well.
 
> Note that I'm not worried about the potential raciness of this new
> last_busy update with other possible concurrent updates of last_busy
> because they all use approximations of the current time and if they
> are close enough to each other, it should not matter who wins the
> race.

Ack, that's one advantage in your style of solution, because you're only
handling timestamps "in the moment."

> > With that said:
> >
> > > The core calls pm_runtime_mark_last_busy() for resuming devices under
> > > the assumption that they are resumed for a reason and so it is likely
> > > that they will be needed in near future, but I'm not sure if that
> > > assumption can be extended to a child suspend case.
> >
> > But that's not what I'm doing: I'm not calling mark_last_busy() -- I'm
> > just making mark_last_busy() transitive to all dependencies. So any time
> > we *already* say the child is busy, I also extend that to the parent --
> > I'm not generating any new timestamps; I only reuse the timestamps we
> > already selected.
> >
> > My view on the logic (using your terms above): when a child calls
> > mark_last_busy(), it suggests that child might be needed in the near
> > future. Whenever a child device is needed, so is its parent (barring
> > ignore_children). Thus, mark_last_busy() should also refresh the
> > parent's busy timestamp.
> 
> Of course, it can be argued this way though there are
> counter-arguments (probably not worth discussing in detail at this
> point) and there is the question how much of a difference this would
> make after addressing the rpm_resume() inconsistency mentioned above
> (which IMV needs to be address regardless because it is not limited to
> the parent-child or supplier-consumer situations).

I would love to hear your counterarguments. I don't believe your
solution solves the problem, and my solution does while also handling
the inconsistency you mention.

> > Importantly (in the same topic Jonathan was already asking about): this
> > does *not* mean the parent gets a whole new autosuspend delay period --
> > but it *does* mean that if the parent has a longer delay period
> > (presumably because it has a more expensive/slow suspend/resume latency)
> > it waits a bit longer (in case the child wakes back up, for one) to
> > autosuspend.
> >
> > In concrete terms of commit c537d3457542 ("iio: adc: stm32-adc: fix
> > runtime autosuspend delay when slow polling"):
> >
> >  * child device has 100ms delay
> >  * parent devices has 2s delay
> >
> > SEQUENCE:
> >  1) child is active for longer than 2 seconds
> >  2) [timestamp N] child finishes I/O, drops reference with put_autosuspend()
> >  3) [N + 100ms] child suspends
> >
> > CURRENT BEHVIOR:
> >  4) [N + 100ms] parent suspends immediately after #3
> >
> > PROPOSAL:
> >  4) [N + 2s] parent suspends (if there was no other last_busy update)
> >
> > The only last_busy timestamp is N; we just use it in more places,
> > because the parent was, in fact, busy at timestamp N.
> >
> > > One might argue
> > > though that extending it to the child/consumer resume case would make
> > > sense.
> > >
> > > > The effect of this behavior is that a parent device may suspend sooner
> > > > than its autosuspend delay, simply because its usage was accounted by
> > > > its children, and not by direct references to the parent device.
> > >
> > > The distinction between "direct references to the parent device" and
> > > "usage accounted for by its children" is not clear to me TBH.
> >
> > "Direct reference" is to mean "pm_runtime_put_autosuspend()" or anything
> > similar that updates last_busy. We expect that when the device in
> > question is the target object for I/O or whatever is keeping the device
> > busy.
> >
> > But if the I/O is performed by a child, then it's no longer "direct
> > reference" -- it's "usage accounted by its children".
> >
> > > There are references to the parent device in both cases and it is not
> > > like drivers can always expect all runtime PM references to come from
> > > specific code paths updating last_busy.  There is at least one
> > > reference controlled by user space (the "control" attribute in sysfs)
> > > and dropping it may also cause the device to suspend immediately if
> > > last_busy has not been updated recently.  How is this situation
> > > different from the one related to child/consumer suspend?
> >
> > I think I've improperly directed you to focus on the "reference" part,
> > which IMO is a bit of a distraction. The point is: when was the device
> > "busy" (or "last used")? The 'control' attribute does not represent
> > "last used"; it just represents some unrelated policy to prevent
> > suspension.
> 
> Or not, depending on why user space flips the "control" attribute
> which is not known to the kernel.
> 
> > > > This was noticed in several cases, and some have implemented
> > > > workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
> > > > runtime autosuspend delay when slow polling"). At the same time, Ulf
> > > > suggested these problems "should be solved in the runtime PM core" [1].
> > >
> > > So I need to be explained how commit 9bdbb1139ca1 ("iio: adc:
> > > stm32-adc: add power management support") works because ATM I don't
> > > seem to understand it.  It looks to me like the .runtime_idle()
> > > callback updates last_busy for the device for which it is called, not
> > > for its parent.
> >
> > Note: stm32-adc-core (drivers/iio/adc/stm32-adc-core.c) is the parent.
> > stm32-adc (drivers/iio/adc/stm32-adc.c) is the child.
> 
> It would really have helped if that had been described properly in the
> changelog of commit c537d3457542.  Oh well.
> 
> > When the child suspends, the parent checks .runtime_idle(). This updates
> > last_busy but still falls through to autosuspend -- that means we get a
> > slightly suboptimal sequence like the following:
> >
> >  1) child is active for longer than 2 seconds
> >  2) [timestamp N] child finishes I/O, drops reference with put_autosuspend()
> >  3) [N + 100ms] child suspends
> >  4) parent runtime_idle() updates last_busy to [P = approx N + 100ms]
> >  5) [P + 2s] parent suspends
> >
> > Step 5 happens approximately 100ms later than it really should, but it's
> > good enough.
> >
> > NB: I think this is also why greybus (gb_bundle_idle(),
> > gb_interface_runtime_idle(), etc.) and USB (usb_runtime_idle(),
> > dwc3_runtime_idle()) look the way they do, with a built-in
> > mark_last_busy() in runtime_idle().
> 
> So I'm wondering how much of this will still be needed with the
> attached patch applied.
> 
> > I also think that some other areas could use some logic like this. For
> > example, drivers/pci/pcie/portdrv.c has a 100ms autosuspend delay so
> > that lspci doesn't cause repeated suspend/resume. But suppose config
> > access for a child of a port are slow ... then the port still might
> > suspend immediately, between config accesses. (Never mind that
> > pci_config_pm_runtime_put() doesn't update last_busy...)
> 
> But at the point when the first config space access takes place, it is
> unclear that the next one will happen, which is part of the problem
> here: The child resume needs to be expected to happen shortly for all
> of this to make sense.

I don't understand this argument. Sure, "it is unclear" ... but that's
still the whole point of mark_last_busy() -- the autosuspend algorithm
suggests, "if we recently used the device, we might use it again soon."
Yes, that's not guaranteed ("might"), but it's still the whole design,
because predicting the future is hard, and getting the answer wrong
occasionally (small additional suspend delay) is not too expensive.

If we didn't want to make predictions based on last-use (but instead
only "last resume"), pm_runtime_mark_last_busy() would largely be an
internal detail within the runtime PM core; and it should most certainly
not be baked into pm_runtime_put_autosuspend() and similar.

Or, why did you apply commit b3db492e8335 ("PM: runtime: Mark last busy
stamp in pm_runtime_put_autosuspend()")? Or why (prior to that commit)
did the documentation say "Drivers should call
pm_runtime_mark_last_busy() to update this field after carrying out
I/O"?

And why, with all that, does PCI config access need to differ from that
advice? To me, it seems like an accident, and not intention.

> ---
>  drivers/base/power/runtime.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -819,6 +819,12 @@ static int rpm_resume(struct device *dev
>  		pm_runtime_deactivate_timer(dev);
>  
>  	if (dev->power.runtime_status == RPM_ACTIVE) {
> +		/*
> +		 * An attempt to resume the device means that it is needed for
> +		 * something, so update its last_busy timestamp in analogy with
> +		 * the case in which it actually resumes below.
> +		 */
> +		pm_runtime_mark_last_busy(dev);
>  		retval = 1;
>  		goto out;
>  	}

Brian

Test patch follows. Example use:

  ## get()/put the child 200 times, with varied delay in between:
  ##   100ms +/- 0ms
  ##   100ms +/- 10m
  ##   ...
  ## We purposely use the shorter delay most of the time, with the
  ## longer variation occurring approximately every 2000ms
  ##
  ## This test usually produces excess parent-suspend with Rafael's
  ## patch.

  $ for i in $(seq 0 10 90); do
    tools/testing/kunit/kunit.py run \
      --kconfig_add CONFIG_PM=y \
      pm_runtime_test_cases.pm_runtime_parent_periodic_use_test \
      --kernel_args runtime-test.period_variation=$i; \
    done

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 685a3504cd7b..12b8eb1d10c9 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -5,10 +5,12 @@
 
 #include <linux/cleanup.h>
 #include <linux/delay.h>
+#include <linux/moduleparam.h>
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
 #include <kunit/device.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #define DEVICE_NAME "pm_runtime_test_device"
 
@@ -386,6 +388,127 @@ static void pm_runtime_supplier_last_used_test(struct kunit *test)
 	KUNIT_EXPECT_GT(test, expiry2, expiry1);
 }
 
+struct pm_runtime_test_data {
+	struct device_driver *driver;
+};
+
+struct pm_runtime_device_data {
+	int suspend_count;
+};
+
+static int test_runtime_suspend(struct device *dev)
+{
+	struct pm_runtime_device_data *data = dev_get_drvdata(dev);
+
+	data->suspend_count++;
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(test_ops, test_runtime_suspend, NULL, NULL);
+
+static int test_runtime_probe(struct device *dev)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct pm_runtime_device_data *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, data);
+
+	dev_set_drvdata(dev, data);
+
+	return 0;
+}
+
+static int pm_runtime_test_init(struct kunit *test)
+{
+	struct pm_runtime_test_data *priv;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	priv->driver = kunit_driver_create(test, "pm_runtime_test_driver");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->driver);
+
+	priv->driver->pm = &test_ops;
+	priv->driver->probe = &test_runtime_probe;
+	test->priv = priv;
+
+	return 0;
+}
+
+static void pm_runtime_test_exit(struct kunit *test)
+{
+	struct pm_runtime_test_data *priv = test->priv;
+
+	priv->driver->pm = NULL;
+}
+
+/* Default: delay 100ms, variation +-50ms */
+static const unsigned int child_delay = 100;
+static unsigned int period_variation = 50;
+module_param(period_variation, uint, 0444);
+
+static void pm_runtime_parent_periodic_use_test(struct kunit *test)
+{
+	struct device *parent, *dev;
+	struct pm_runtime_test_data *priv = test->priv;
+	struct pm_runtime_device_data *parent_data, *child_data;
+
+	parent = kunit_device_register_with_driver(test, DEVICE_NAME "_parent", priv->driver);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	parent_data = dev_get_drvdata(parent);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_data);
+
+	dev = kunit_device_register(test, DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	child_data = dev_get_drvdata(dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, child_data);
+
+	KUNIT_ASSERT_EQ(test, 0, device_move(dev, parent, DPM_ORDER_NONE));
+
+	pm_runtime_set_active(parent);
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(parent);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_set_autosuspend_delay(dev, child_delay); /* default 100 */
+	pm_runtime_set_autosuspend_delay(parent, 2000);
+
+	KUNIT_ASSERT_GT(test, child_delay, period_variation);
+
+	pm_runtime_enable(parent);
+	pm_runtime_enable(dev);
+
+	/* Aim for 1 variation every 2000ms */
+	const unsigned int variation_interval = 2000 / (child_delay - period_variation) + 1;
+
+	for (int i = 0; i < 200; i++) {
+		KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
+
+		/* do some I/O */
+
+		pm_runtime_put_autosuspend(dev);
+
+		if ((i + 1) % variation_interval == 0)
+			msleep(child_delay + period_variation);
+		else
+			msleep(child_delay - period_variation);
+
+		flush_workqueue(pm_wq);
+	}
+
+	pm_runtime_disable(dev);
+	pm_runtime_disable(parent);
+
+	KUNIT_EXPECT_EQ(test, 0, parent_data->suspend_count);
+	kunit_info(test, "Test params: delay %u +/- %u; variation interval %u\n", child_delay, period_variation, variation_interval);
+	kunit_info(test, "Parent suspend executions: %d\n", parent_data->suspend_count);
+	kunit_info(test, "Child suspend executions: %d\n", child_data->suspend_count);
+}
+
 static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_depth_test),
 	KUNIT_CASE(pm_runtime_already_suspended_test),
@@ -396,12 +519,15 @@ static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_supplier_suspend_test),
 	KUNIT_CASE(pm_runtime_parent_last_used_test),
 	KUNIT_CASE(pm_runtime_supplier_last_used_test),
+	KUNIT_CASE_SLOW(pm_runtime_parent_periodic_use_test),
 	{}
 };
 
 static struct kunit_suite pm_runtime_test_suite = {
 	.name = "pm_runtime_test_cases",
 	.test_cases = pm_runtime_test_cases,
+	.init = pm_runtime_test_init,
+	.exit = pm_runtime_test_exit,
 };
 
 kunit_test_suite(pm_runtime_test_suite);
