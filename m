Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA74FDE56
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029649; cv=none; b=BwMqHuADgAWVtWf2tEq3GFgnoCuiqC0H3+tkpQ/+wTrp14Igqx1ApX/2cFzbUrh8BqxCbZ9kTJ/gcvHNfsiSI0zDUA4IepNyhOtAYH2KonWbfbCgAR+N9PraICDTz3idHzrdUMoxS+yYjVxjyXKRFrfJpOxaz86EP6+/y7vZDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029649; c=relaxed/simple;
	bh=cbgeAAqW3EslueGOG7wye7FpCDLC+L1eZZycRClopqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbvQD/ciSLbAo4lJEMyh9d3hfKm4WSEURHjTEcTOv2G92yOhZGJIUz9ZTzKHu1jZ63YnHLt1H6Xx/9dM77eB7sKULkmd2XPnkEXTrdrdgg0E7PDe/EzogASOprabw3/jpuynDMttZuUN5SxeJfst0VwXH81Ws6rPUehwTXUspDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QDAwiDwV; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDAwiDwV"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86b90133ae8so2548722b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790029646; x=1790634446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJwCDo5X2HseyyntGyCNKBmdUDOcUVazsuQs9lZaLgU=;
        b=QDAwiDwVYLV/XByYzxSDFXT2BxQAU08MJIIsnFOIbRiLTmYvZW55uqfHVk4SKaGefc
         WitRXSc4MVbVoySLQn3DpMUFfNQ90ueZ4qhS2rEHrWEhy3PZevQ307W1QBPHw/OxNInD
         FNc8CNsbDj/Me2PCZSOEFZJayJXFLnKoPp5Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029646; x=1790634446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hJwCDo5X2HseyyntGyCNKBmdUDOcUVazsuQs9lZaLgU=;
        b=C9TEMHayjth0qgnghuB77TYD92DqbZY6IgWXMU6PvPVWH8r2f+14qR9imetKe0BcH2
         SlS6cHiYLW8imQ1mqpiurzuPp1it+azWDgxhMRSFhMGGIPysBELJN1Kxn4MphZWXQO79
         zZ850rIPxMD1Z7Ch9Rno53lqOlCl+HJ7DLPF44OY1x90+XkeuAjK56ii6rPoZTA6p+jp
         ItuGh34h30vg59H/XxLtmZl3WoaG0wWasVDYX4769AJXSzQv2AcZBAH+JTam0F2/LV+q
         ckJNKxC40j7DQuJ8sx19n3UQeepWrr7l/dLoJIxwkPPuikWfP4y0NOOphTqS+xpTg/qc
         i2TQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+kyrZpKiEwu9Ax/nY5QgPfGEz3eOoQkDI8idQB88nFeiXJx7s9yxBeYqwX1N6O0IHRDmrFLJO5Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mhNo7qD7mz1/OJpAnJM8BO0lJb1MLyp/UeLubkouJCKXPmHhlC
	3VU4aGQ+KFwZd/CZRbvr0igairkXNt1xZlfU+gTWah0wqA1zK3cRo3nCD2FcKM3T5w==
X-Gm-Gg: AYBFou2L7fV2XrmQIIv83fLKo7VwZD/eYHMj0GLyWttFmYzThddnHhq5MOLSEx8SsPb
	VIjWdqQAmCe0T5kfO6Hp978yozq6vSkkKjmvQZUcXeAAdcoF1z50u+/v65uuBsmxC/Vhnl31C4P
	Ex3vwAwJnSDSjnfJ2z+Ft0b3kgWJIJmKaPQsgnLpKpYmntYqCuZEjU6PcOX030TpmAVpVdHD5ci
	K5CuMg1BrLA/m99WpImffpkozxDFP0huJiM7BJ+XaL/jWTkiVEEMTFd74j6UVjz35e6SQC/jhO5
	2eb178Blf0lChFGFeFj4KVHnVjX+Or0V67BRwN9o/X8vlxrEBAc7AhSTNZnecPAHmEBCTzMZBVS
	UG7R7Ii80SwzH61e24oWRz1nNrIfbQfW4wX0XPUocpowaHm8FeqNn5hpaopBejU5zhbnLxKwXlu
	w9tgleKxX3hnejq1hWH4h8bFOxF2pHjeupdSdB1LWH68xIjFn3AzrTmV2CBicLKsGjtSGZX2C3O
	4fNNkHcZrNad1BkXrCF5bNRhVkQkjwyZtkvsA==
X-Received: by 2002:a05:6a20:6a0e:b0:3dd:a00a:7ac7 with SMTP id adf61e73a8af0-3dda00a9e84mr12845611637.52.1790029646089;
        Mon, 21 Sep 2026 15:27:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:310c:6ebb:661a:791c])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-144f0cb830asm688854c88.12.2026.09.21.15.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 15:27:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:27:23 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 06/11] PM: runtime: Expand introduction with core
 concepts and structure
Message-ID: <arGvS29kPmBkft9t@google.com>
References: <20260904212000.4167880-1-briannorris@chromium.org>
 <20260904141215.6.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
 <CAJZ5v0ivQ25s_+fvhSaBJX+F80fjvBsrKtibMf=xEsi6n0FOAw@mail.gmail.com>
 <arGMJpS5ZU3E8ncx@google.com>
 <CAJZ5v0hpFZPpqVks=XMdaK3-s_5AkOW6fM9FLmb_zd4X4gNgcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hpFZPpqVks=XMdaK3-s_5AkOW6fM9FLmb_zd4X4gNgcg@mail.gmail.com>

Hi Rafel,

Preemptive apology if I'm being dense or misinterpreting your point. I'm
surely working through some of my own understanding at the same time as
trying to document it, so bear with me.

On Mon, Sep 21, 2026 at 10:49:17PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Mon, Sep 21, 2026 at 9:57 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Thu, Sep 17, 2026 at 09:59:36PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Fri, Sep 4, 2026 at 11:20 PM Brian Norris <briannorris@chromium.org> wrote:
> > > >
> > > > I commonly see people have difficulty learning how runtime PM works
> > > > because of the following key points [*]:
> > > >
> > > >  1) there are several boolean concepts in runtime PM, with somewhat
> > > >     similar meanings:
> > > >
> > > >      enabled / disabled
> > > >      active / suspended
> > > >      allowed / forbidden
> > > >
> > > >  2) if these concepts are documented at all, they're scattered across
> > > >     the kerneldoc or Documentation/
> > > >
> > > >  3) the runtime_pm.rst docs don't make any attempt to ease a reader into
> > > >     understanding the concepts, and instead jump straight into how it's
> > > >     implemented (queues, 'struct device' fields, helpers).
> > > >
> > > > Let's try to remedy this a bit by discussing the core concepts and
> > > > highlights at the top of the introduction, and introduce a few
> > > > sub-headings, so it's easier to navigate different aspects of the
> > > > introduction.
> > > >
> > > > While shuffling the intro around, I also see that the existing text
> > > > largely mirrors the layout of the following sections (2, 3, and 4), but
> > > > does so out of order. Reorder those, and point to section numbers.
> > > >
> > > > [*] In addition to API complexity. I count 61 pm_*() helpers, 7 of which
> > > >     are variations of put() and 8 of which are variations of get().
> > > >
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > >
> > > >  Documentation/power/runtime_pm.rst | 87 +++++++++++++++++++++++-------
> > > >  1 file changed, 68 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > > > index 39fdeeda7a1e..620b6988deca 100644
> > > > --- a/Documentation/power/runtime_pm.rst
> > > > +++ b/Documentation/power/runtime_pm.rst
> > > > @@ -11,31 +11,80 @@ Runtime Power Management Framework for I/O Devices
> > > >  1. Introduction
> > > >  ===============
> > > >
> > > > -Support for runtime power management (runtime PM) of I/O devices is provided
> > > > -at the power management core (PM core) level by means of:
> > > > -
> > > > -* The power management workqueue pm_wq in which bus types and device drivers can
> > > > -  put their PM-related work items.  It is strongly recommended that pm_wq be
> > > > -  used for queuing all work items related to runtime PM, because this allows
> > > > -  them to be synchronized with system-wide power transitions (suspend to RAM,
> > > > -  hibernation and resume from system sleep states).  pm_wq is declared in
> > > > -  include/linux/pm_runtime.h and defined in kernel/power/main.c.
> > > > -
> > > > -* A number of runtime PM fields in the 'power' member of 'struct device' (which
> > > > -  is of the type 'struct dev_pm_info', defined in include/linux/pm.h) that can
> > > > -  be used for synchronizing runtime PM operations with one another.
> > > > +Runtime power management (or runtime PM, sometimes shortened to RPM) allows
> > > > +individual I/O devices to transition between high and low-power states
> > > > +dynamically while the system is running, conserving power without waiting for a
> > > > +system-wide sleep state.
> > > > +
> > > > +Core Concepts
> > > > +-------------
> > > > +
> > > > +Understanding runtime PM requires distinguishing between several pairs of
> > > > +complementary states that operate orthogonally: **active** / **suspended**,
> > > > +**enabled** / **disabled**, and **allowed** / **forbidden**.
> > > > +
> > > > +* **Active**: The PM core tracks a device's runtime status as either **active**
> > > > +  (the device is operational, having completed its resume callback) or
> > > > +  **suspended** (the device is idle or in a low-power state, having
> > > > +  completed its suspend callback), along with transitional **suspending**
> > > > +  and **resuming** phases. State transitions are primarily driven by
> > > > +  reference counting: drivers call pm_runtime_get() (or related variants)
> > > > +  when the hardware is needed (ensuring the device is active) and
> > > > +  pm_runtime_put() when work completes, allowing the PM core to initiate
> > > > +  suspension (immediately or after an autosuspend delay) once the usage
> > > > +  counter and any active child dependencies reach zero.
> > >
> > > While the above is fine IMV, the enabled/disabled concept is more
> > > fundamental
> >
> > Sure. So perhaps "enabled" should come first in the introduction? And
> > then the (non-orthogonal, per below) relationships can be described when
> > introducing the others?
> 
> Yes, something like that.
> 
> > > because "active" and "suspended" are not really relevant
> > > when runtime PM is disabled.  Yes, they need to be set properly before
> > > enabling it and there is some complexity related to the integration
> > > with system-wide PM, but generally speaking, if runtime PM is disabled
> > > for a given device, its active/suspended status is irrelevant.
> >
> > I think you've hit on a key point here, which makes it hard to
> > understand RPM sometimes. Indeed enabled-vs-active are not fully
> > orthogonal, but then, I also think your "generally speaking" qualifier
> > is holding a lot of weight here -- there are quite a few ways in which
> > active/suspended are relevant independently of enabled/disabled.
> >
> > For one, an active disabled device *will* prevent its parent from
> > suspending, while a suspended disabled device will not. (Now, is that an
> > *important* state? An expected state? Maybe not really, but it at least
> > clouds a reader's mental model.)
> 
> So there are two things, the status and the reference counters.
> 
> The runtime suspend of a parent/supplier is prevented by the latter,
> not by the former,

That seems technically true, but only because (I think) you've started
talking about implementation details again. In this case, I think you're
talking about dev_pm_info::child_count or device_link::rpm_active (+
dev_pm_info::usage_count). Those are not really details that most
readers should consider, IMO, and thankfully, they aren't directly
modifiable by any API exposed by RPM. They are most closely associated
with APIs like pm_runtime_set_active() (or anything else that can change
device status), which may indirectly increase a parent's child_count or
a supplier's rpm_active.

To me, an "active" device prevents a parent from suspending. It does not
matter how exactly this was achieved (e.g., increased child_count). It
does not matter whether the device is also enabled or disabled. What
matters is there is no legal way for this to happen:

	dev->power.runtime_status == RPM_ACTIVE
	parent->power.runtime_status == RPM_SUSPENDED
	parent->power.ignore_children == false

> so if you never enable runtime PM for a device or
> otherwise cause the runtime PM reference counters of the parent and
> suppliers to get updated, it will never affect the parent or
> suppliers.

"Otherwise cause [...] to get updated" is a big statement :)

To the most basic reading, pm_runtime_set_active() is changing the
status, not a bunch of reference counters. It happens to change both
under the hood, but IMO it's best *not* to think about that. A reader
should be able to rely on the fact that status will imply the
appropriate counters.

> However, if you enable runtime PM for a device, you runtime-resume it
> and then you disable runtime PM, the reference counters will remain
> unchanged.

That's not true, is it? Resuming a device increases its parent's
child_count and its supplier link's rpm_active/usage_count. The
enable/disable dance doesn't really change that part.

> > And then, reading these 3 helpers, I constantly have to refer back to
> > their implementation:
> >
> >         pm_runtime_active()
> >         pm_runtime_suspended()
> >         pm_runtime_status_suspended()
> >
> > The existence of pm_runtime_status_suspended() (which ignores
> > disable_depth) means I can never fully apply the reasoning you suggest.
> > I need to consider both the disable_depth and the runtime_status when
> > understanding how a device will behave.
> 
> Well, as I said above, runtime_status doesn't really matter if
> disable_depth is nonzero.  Reference counters are a different matter,
> which I guess is the source of confusion here.

Honestly, I'm not quite sure if we agree on the source of confusion yet
:)

> But basically, nonzero disable_depth really only means that the
> device's runtime PM callbacks cannot run and its status will not
> change unless explicitly updated with
> pm_runtime_set_active/suspended().

Full ack. That may be the most succinct way of describing
enable()/disable().

> > > > +
> > > > +* **Enabled**: Orthogonal to whether a device is currently active or suspended
> > > > +  is whether runtime PM is **enabled** or **disabled**.
> > >
> > > So it is not orthogonal.
> >
> > Perhaps "independent" is a better term? I agree they're not fully
> > unrelated, but they're also not fully dependent -- active/suspended has
> > significant meaning even when disabled.
> >
> > In any case, I'll try to incorporate some more color about how they do
> > relate.
> 
> IMV, "enabled" and "disabled" are not really states, they just tell
> you what can happen to the device and what can be done to it.

Eh, sure. At some point we have to use words to describe concepts, and
hopefully not too many words. "States that limit other state
transitions"?

And if we're getting to the point of questioning whether "enabled" is a
state, I think maybe we've gone a bit off the rails. I can't imagine any
other area where "feature X is enabled/disabled" is not a description of
a state :)

> "Active" and "suspended" are (meta)states that tell you what has
> happened to the device most recently.
> 
> They aren't completely orthogonal (or independent)

OK, my takeaway: try to avoid either the words orthogonal or independent
here :)

> because "disabled"
> means that whatever has happened to the device recently is now sticky
> until something is explicitly done to it.

Ack.

> > > > This is governed by an
> > > > +  internal disable counter (``disable_depth``). All devices are initialized
> > > > +  with runtime PM disabled (``disable_depth == 1``)
> > >
> > > This is only partially true because the PCI bus type, for instance,
> > > enables runtime PM for all PCI devices and so it is enabled when
> > > drivers get to them.
> >
> > Ack. I had this in mind at some point during the drafting, but when RPM
> > is so complicated, it's hard to choose where and when to document all
> > the exceptions.
> >
> > > > and can also be disabled
> > > > +  during system sleep transitions or explicitly via pm_runtime_disable(). In
> > > > +  the disabled state, the PM core ignores idle and suspend requests and will
> > > > +  not execute runtime PM callbacks (->runtime_suspend(), ->runtime_resume(),
> > > > +  ->runtime_idle()).
> > >
> > > Moreover, parent-child and supplied-consumer dependencies are
> > > generally not tracked for devices with disabled runtime PM.
> >
> > Is that really true? A disabled-but-active device still prevents its
> > parents and suppliers from suspending, as far as I can tell.
> 
> Well, OK, but I've already covered this above.
> 
> > If I can interpret *your* intended mental model: if we intend not to
> > RPM-manage a device, it should be left disabled and suspended, in which
> > case it will generally be ignored by RPM. (Or alternatively:
> > disabled-but-active is not generally an expected long-term "steady"
> > state.)
> 
> Right.  More precisely, its references to the parent and suppliers
> need to be dropped.
> 
> > But if that's all true, I'm still not sure what to document, to balance
> > focus and simplicity (for an introduction) vs covering all the edge
> > cases and complexities. Perhaps for an intro: we start with
> > "enabled/disabled", and suggest that if a driver never touches RPM (and
> > never "enables" the device), RPM mostly stays out of the way.
> 
> I would do that.
> 
> > But if we want to opt into RPM, then we enable() (and then start to
> > think about active/suspended, per the 2nd key state).
> 
> Well, actually enable() may need to be preceded with taking references
> to the parent and suppliers.
> 
> > [ Side note: since you mentioned PCI... that gets into a real-world case
> >   of confusion: I've dealt with PCI driver authors that want to "prevent
> >   runtime PM" in their driver [*], since they hadn't finished validating
> >   all the runtime_suspend/resume behavior for a particular device. In
> >   that case, pm_runtime_disable() was actually an OK choice, because the
> >   PCI device was already active. But if they applied your quoted
> >   reasoning, they'd have to choose something else. (And frankly, they
> >   probably should.) But would that be forbid()? Or get()? That's exactly
> >   the sort of question I'd hope this document can help clarify.
> >
> >   [*] ...yes, the PCI bus purposely holds a usage count, requiring
> >   drivers to opt into RPM by pm_runtime_put_noidle() or similar... But
> >   the question arises nonetheless, when people aren't really RPM
> >   experts, and they're dealing with vendor drivers with odd code
> >   structure. ]
> 
> I can totally agree that this whole thing is not easy to use.  I'm not
> sure though if it might be made (much) easier to use TBH.

Sometimes I agree. Sometimes I don't.

For concrete steps though, I think we can try to agree on some valid way
to document enabled/active/allowed.

Brian
