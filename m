Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655572;
	b=U/VIxqqbTjp5tPe8DJi3uJa6uaplSzfnbbtXeyjJ/p3w87FSny6tg3I++3OqxfnzAnEg
	 dhDiyWJIc+ggEqLqg6OVJQ9nnsOpRBaW2HW6TK7RlJQU956mLVKLuNvAcJ6CRbV7+UZHl
	 pvTFOpBUiqISb0SqOIzsO+whpei/GnCgtbuGQ439duZm9G/BrD08iWYWPm08sUanMoM0+
	 76mrRl2MR73hpJIxPAiesaOmfMZniLdfmnCAgW8ZtbwQts5LE/kCroN/E61lec5Ygq3qP
	 YwLLCYP4HVLbWduwS2dpIcWQjCrZLaTGXPd92j0Xe2Mds7elWsiLG2ZfoH5Z4IDDPmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=2pA3VHlw07C80DtGhf3Wk+ni9onBDYYv/Wt986Zz2Ew=;
	b=KCB4UfrUn6Fr7UJS3F41387ItNnxithvePGnN2lacF7XwBT1kHF67yTif1shmGveui1h
	 B7POI8ckorsb9n6LfBxq8evb76ECfv6VlSFzBsdAiKX7w642Ton93cQbbzjB8dVCYD/OK
	 iwrpyqJHOD+7boSYn+pwykEjuIcNzEOPxdp1SOD9vHHKUXdPQrCIx7Oc04ncOTWPlDFOD
	 SNimG5WHzzoSq9QTltmuncqoXq4w6h35N6E7q0rz3TPRvKQebzXzgkfnCFriVWeUkoeFH
	 ZJirk0P+ECi2fhQh36PZ9lKTX9M9jJlpoTbH+8OJt7JhyDczsJB+9CzwgeDhs7MwwxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EO8gYqJw;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8D606A335
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 01:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD8D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EO8gYqJw
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so12689262eec.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 17:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795655571; x=1796260371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pA3VHlw07C80DtGhf3Wk+ni9onBDYYv/Wt986Zz2Ew=;
        b=EO8gYqJwSOWwgaagR05ypeUIi3kVjBLP2bBLY+xFo/Q35UuVd7UtXwLkCZHeWppAgF
         TBeU5MIvB914D+7qVvAmvwJP9In2A3daYXG7IRIb44VJOX0m+JZ5ye+Xl2VkL2a7jtvg
         6V4FBwMU2RVADclcgrlt27k68hvedp4U2p7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655571; x=1796260371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2pA3VHlw07C80DtGhf3Wk+ni9onBDYYv/Wt986Zz2Ew=;
        b=h81l00WOIcmBgOFOd6m/bKIxY5FKghK5vXw1YyGUZYnbDFXZRFWPly+tRF1xUjqpO0
         gU7mwr6bA5wtisWk+22gY9QZ/7nwJO8ldO6HTMwYuPqPEQdI/Rky1w6s2Dt0q+K0Ws/o
         1iWrNMN49Qj77+5I5V7CBJ/YkVnd6h3JVIlJqhQQjRyBbk1CQsct2G6DumnrEZMQ0oWy
         qDRz4rVO9SLeNnnhIM90sCTz7hvgzOaBAXuJjWqmLBrfHjO3qEBotVFj/EigkLmJEgsF
         A19YVmBXAzDLZHy3seePiA7lAHl3t7vLjvKBgaZXAnP6ujNi1hpp18vqOGUlTIS55hPh
         AXhw==
X-Gm-Message-State: APuU4Z95Odc0G2ylW9sI2zH9JPJeGwymxzaD3D/TM7+8mpNHQN/4LoBH
	iZWtGejpyt+Ynhi5EIwj/10fgQti4oAK53JEaMN2fl/bhLrDqE/0U2S2SF6Z55Wg0A==
X-Gm-Gg: AZFdTZdWdD8MuNUgTD4TjBU8HhjtsSJZF+coPZrSoc1ZInsMXsFfzm/Yo4QsiAPtQQw
	rWUyFmRH/UAMXbQzQ0LkmpVZjtWJOM8SvEiytgnGQEblpi4WYYlmPhAPir/lK0hNXejv0rqWCAT
	9HwyKoz2ErHgjEf3Q2wkrdON/NoJVAJNYTtx0uJxwC2v4xVjwTQZxNM0nkBLfGBBw9Fm5m2aPSv
	Bu9D+58Vo+qnvxPG34j/RAaDcngLNyKjLpCF+ZjBeoio3HvHzxg3wFxJER8HjVt9mY8ZTNnzjRv
	R2mJ/LVg2LfnxR7vQ7aVrNFABfZ/o+XHH8MsMNZnWGtjfI/hGo2P0aYtUPxz/8cVwNRA2c984IA
	ghD9eo7DKC3M2ka9hXvwq7uNOq/lsm0IjmbYoZi5T83QvUIjtX/jTntREDT22p8OucnyJAb6J9I
	MJrfuN/0oX+LwquItNJkQJx7XyfMhiYfr+gUg5ETMtlzK0NMiuGlM5l1YN2tUKjRbjk9B4PqIzI
	e64mlxVIdZmOmx4Ncwh+8o9sOZ6kcwa/MRAfFgG0gxs9p5NKXfJN0U78kbXe2obUBE5mn7rHa2m
	rTPomJvQl1m9lCR19ciXwkxYnws1Cj3Hw3c+8wpEBRZCUXUYfwEyz38wZCPjQIeuRr0z
X-Received: by 2002:a05:693c:880e:20b0:386:b54a:7f6e with SMTP id 5a478bee46e88-386b54a8032mr10146885eec.6.1795655571381;
        Wed, 25 Nov 2026 17:12:51 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:dda6:7575:bbfe:db80])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-386aaae4960sm30443084eec.18.2026.11.25.17.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:12:50 -0800 (PST)
Date: Wed, 25 Nov 2026 17:12:48 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1 3/4] PM: runtime: Let devices suspend after an
 attempted resume
Message-ID: <aweHkBnEGG5f8veE@google.com>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
 <10954171.nUPlyArG6x@rafael.j.wysocki>
 <awC1xx1Wi2BYo5rb@google.com>
 <CAJZ5v0jgBeJkeKfzaMnSx3c7HV6EpXrUoKJCyAZNHwfkvh=PZQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0jgBeJkeKfzaMnSx3c7HV6EpXrUoKJCyAZNHwfkvh=PZQ@mail.gmail.com>

On Tue, Nov 24, 2026 at 05:23:52PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Fri, Nov 20, 2026 at 10:04 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > On Thu, Nov 19, 2026 at 09:17:51PM +0100, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > On a successful runtime resume of a device, rpm_idle() is called by
> > > rpm_resume(), but only if the runtime PM status of the device was not
> > > RPM_ACTIVE when rpm_resume() was called, which is inconsistent.  For
> > > instance, if the given device uses autosuspend, an autosuspend timer
> > > will most likely be started for it after it has been actually resumed
> > > by rpm_resume(), which will not happen if it is already active when it
> > > is passed to that function.  This may lead to observable differences in
> > > behavior going forward.
> > >
> > > Address it by rearranging rpm_resume() to call rpm_idle() also if the
> > > device has been active to start with.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 5a0b4600c244..1a3b32e299d8 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -794,7 +794,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> > >   * suspending (deferred_resume) or wait for it to finish.  If the RPM_ASYNC
> > >   * flag is set then queue a resume request; otherwise run the
> > >   * ->runtime_resume() callback directly.  Queue an idle notification for the
> > > - * device if the resume succeeded.
> > > + * device if the resume succeeded or the device's runtime PM status was
> > > + * RPM_ACTIVE to start with.
> > >   *
> > >   * This function must be called under dev->power.lock with interrupts disabled.
> > >   */
> > > @@ -840,7 +841,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >                */
> > >               pm_runtime_mark_last_busy(dev);
> > >               retval = 1;
> > > -             goto out;
> > > +             goto success;
> > >       }
> > >
> > >       if (dev->power.runtime_status == RPM_RESUMING ||
> > > @@ -971,8 +972,11 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >       }
> > >       wake_up_all(&dev->power.wait_queue);
> > >
> > > -     if (retval >= 0)
> > > -             rpm_idle(dev, RPM_ASYNC);
> > > +     if (retval < 0)
> > > +             goto out;
> > > +
> > > +success:
> > > +     rpm_idle(dev, RPM_ASYNC);
> >
> > It's super common for rpm_resume() to be called with a non-zero
> > usage_count (e.g., all pm_runtime_get*(), pm_runtime_forbid()). Do we
> > really want them all to turn into rpm_idle() (and predictably fail)? For
> > one, it adds a lot more trace_event noise.
> >
> > Maybe we could check RPM_GET_PUT before doing this? Or check
> > usage_count? I wouldn't want to go too far on re-implementing all the
> > rpm_idle() pre-conditions though...
> 
> I'm not sure why this is an issue if the device is already active when
> rpm_resume() is called and not when the device is resumed by
> rpm_resume().  It doesn't look like this should be an issue only in
> one of those cases.
> 

You're right, it's a bit spammy in existing cases too. (It's honestly
pretty hard to read rpm trace_event logs without being an expert.)

This comment was made by inspection; I think I'd have to get a feel for
how this looks on a real run to be sure. Feel free to ignore this if you
don't think it's concerning (and I don't come back with anything more
solid).

> > drivers/net/ethernet/intel/e1000e/netdev.c (no autosuspend; they use
> > .runtime_idle() to re-implement autosuspend, more or less) might see a
> > change in behavior.
> 
> Everybody may see a change in behavior, but it only applies to one of
> the two cases which are handled differently now.
> 
> > For example, see its watchdog, which does:
> >
> >         /* Cancel scheduled suspend requests. */
> >         pm_runtime_resume(netdev->dev.parent);
> >
> > For cases where the device stayed RPM_ACTIVE but usage_count == 0 (very
> > common, I think), this does indeed cancel any pending suspend timers,
> 
> No, it doesn't cancel running autosuspend timers, for example.

Well, this driver doesn't use autosuspend (yet).

> > but then it immediately queues another idle request. (That idle request
> > will end up failing anyway, so no functional issue. It just means the
> > comments are a little confusing.)
> 
> So the comment is confusing regardless of the $subject patch.

No, my point was that your patch changes that behavior from:

 "cancel scheduled [non-auto]suspend requests" (an accurate comment)

to

 "cancel scheduled [non-auto]suspend requests" and immediately run
 .runtime_idle() again (and fail)
 --> a somewhat misleading comment

Or perhaps I'm misunderstanding the before/after behavior here.

> > Do we really want that? Or maybe these drivers are just outliers, and
> > should be rewritten anyway.
> 
> Probably.
> 
> If the device is RPM_ACTIVE to start with, all of the rpm_resume()
> actions related to resuming it may be skipped, quite obviously, but
> I'm not sure why any other rpm_resume() handling of the device should
> be different in that case.  This only causes the behavior to be less
> consistent and less predictable IMV.  In particular, if the device
> uses autosuspend, an autosuspend timer should be started for it
> regardless of whether or not it is RPM_ACTIVE to start with.  Failing
> to do so may cause it to never suspend going forward in theory.

Makes sense. Really, I was only pointing out changes (not necessarily
problems) with a few quirky non-autosuspend drivers [1], and if these
are expected, perhaps it's worth following up with the drivers in
question that were describing (if not fully depending on) corner cases
of behavior that we're changing here.

But on second look, maybe there's not much to fix for these drivers.
It's not really a "bug" to perform excess .runtime_idle() checks, even
if it's wasteful, and I don't see great alternatives.

Brian

[1] drivers/net/ethernet/intel/e1000e/netdev.c
    drivers/net/ethernet/intel/igb/igb_main.c
    drivers/net/ethernet/intel/igc/igc_main.c
