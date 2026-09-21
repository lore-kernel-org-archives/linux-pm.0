Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474033D6473
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020653; cv=none; b=PFYcOBuG27qyxYqwOkvUsjvpua9EaAEi+UB9J56QuG2L9gjydtvJpmq5+lcRGeDn5i6bjojJSblNU29ZA6ZNTvecq6LZmzJktol6HJkBIJtqEUVoi+Zk4r0bjrdHrKGV+wZ4ABdOHFdvbnXx7hExWE88bcluHpm57SWSH+rNJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020653; c=relaxed/simple;
	bh=+KxeMrnKW2mvyX6pxTaVAJDReNfPK8nKnAxCC0zY7Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO9B7HAdyPdQap773DZf4rOHsLJL96Q1j5Hm89MapWO3zqBwfCS2rUSojTATIwDo4AfFsCqaDx3sIQ+9lakrIQgcbepelrTEVoSFU+VlnAsG2mWWz7af+7IYQ++SqByZSq518+M3GlNRZM38MVFVaMuiPh0SIgeSLChfcbnuLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HD77hghD; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HD77hghD"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso2478754a12.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790020650; x=1790625450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fs0LOsNaWjwiqJ3bDBGEGSzWaClNbdWLtEkT+UqSOMY=;
        b=HD77hghD7de9YVVMPolHOck3m/AoIup0mGPWrcQzHIOQFWtAtSR8AT3cSouKoi0OqT
         TXpaFQ+ggD1dtl8agVZ9DZ/5f5lRkVq/1axz3dDklOcbkE4bbtUCo+WBYwUZy84B7Nr4
         vactXoTC1rrGPd1gfA5QPuBumi2sOREpAoNOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020650; x=1790625450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fs0LOsNaWjwiqJ3bDBGEGSzWaClNbdWLtEkT+UqSOMY=;
        b=INf44tY6JPgXMTVZK3oSjRLrH5prP1UJQlLbJ+lJTt5KH1/sEbt5zO8vUPqhV0yQBY
         OecrqJFmkqkx69rIkT1RUo2oSsl9MBjzPGTr7p2lLCbwCkCDA2iWFPG52yBNl2MPsKjq
         RuOexB0znjvrgUtAEMQCC+s3T0UpXOLe8VyZr/63Z3PGkGz+qrJb3+q//xN3VCaqwZsO
         ee6CRIl41iyUUt4pTtX05ccHX4HIiYn0V7pGxj1w21D0a7FTqg3+IXgD6H9LmvNxiW0H
         k+YQq80WzY3UwV74AI/0pQM30RVn/ta5I29FmxOeXlgSrPQ3FGrpeUEM7qeHu1VABDK7
         5UkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9Wl1tlgZbf9xeoK9fFiBQtpKkNk0y9WAP7dhgGY3qTD4zs39tJAiUDUz5Vuiu/iZ5X7wHMRZU2g==@vger.kernel.org
X-Gm-Message-State: AFuF++l4hNw5UMMFSYYppYuQBkdFIWDrGcZT1JhL6o+HEOQr+6Bp08pn
	UtzwwrOHYNFzx93LIb6Qq6dyabY2+l2aTXOKjmQXuYviOXYx1bx1lEI2v9hZQHgXvw==
X-Gm-Gg: AYBFou0jMtwBgBCGjvbNGGHFIW/UAZy7sGZ/x5Zc5Htt7sD5CHcVwWZQYpN0X8F4h64
	KFYL9LSfV2D57qgg+Qzndu2rL0czNtP3lVXyljfm38fcHpbKf8P6j/nPYIRDqZwdqsTwWumJWCt
	0XKvcWzfoB2Fp5FxsC88VzT8MWJ3qgIo3kS1hAybTSwbAokXJLWTIbHKSBs9QAchOJLaaiWf6dz
	9nxi3U2T+GLhqViEfbSy7GNpmX5rl8Z1AHYz5kpzNAUgfzNri1d0BBqDF853WdjcDcXS65F/TN/
	MXTyi3H0suIiyHXQv4jZuaa57tZm0P0am6BtWIvPlV+trD/wPo05dHIULp3hkvvsrpoNWc9GBC3
	NQ9nVTcV18wFtI3Vy97TseMKwJeRcWTtp8TJXZGkH0nw3MUpvsECu6v/toFqrv3K2fQTZCGR0SX
	HUi/p5iLshNdrfBkXbDufxSkWIhrMtSEezkWkwgzuHXUrlJieLb/MSJ4PMjWEkLKrk/4jDFUoZ7
	NbXqiQcpCHeUzqukPMga9LCoOgwHFuJRLOBE7A=
X-Received: by 2002:a05:6a21:9190:b0:3dd:da39:18c8 with SMTP id adf61e73a8af0-3ddda392901mr3004089637.56.1790020650387;
        Mon, 21 Sep 2026 12:57:30 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:310c:6ebb:661a:791c])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-33e5ebc658esm296219eec.12.2026.09.21.12.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 12:57:29 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:57:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 06/11] PM: runtime: Expand introduction with core
 concepts and structure
Message-ID: <arGMJpS5ZU3E8ncx@google.com>
References: <20260904212000.4167880-1-briannorris@chromium.org>
 <20260904141215.6.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
 <CAJZ5v0ivQ25s_+fvhSaBJX+F80fjvBsrKtibMf=xEsi6n0FOAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ivQ25s_+fvhSaBJX+F80fjvBsrKtibMf=xEsi6n0FOAw@mail.gmail.com>

Hi Rafael,

Thanks for the review!

On Thu, Sep 17, 2026 at 09:59:36PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 4, 2026 at 11:20 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > I commonly see people have difficulty learning how runtime PM works
> > because of the following key points [*]:
> >
> >  1) there are several boolean concepts in runtime PM, with somewhat
> >     similar meanings:
> >
> >      enabled / disabled
> >      active / suspended
> >      allowed / forbidden
> >
> >  2) if these concepts are documented at all, they're scattered across
> >     the kerneldoc or Documentation/
> >
> >  3) the runtime_pm.rst docs don't make any attempt to ease a reader into
> >     understanding the concepts, and instead jump straight into how it's
> >     implemented (queues, 'struct device' fields, helpers).
> >
> > Let's try to remedy this a bit by discussing the core concepts and
> > highlights at the top of the introduction, and introduce a few
> > sub-headings, so it's easier to navigate different aspects of the
> > introduction.
> >
> > While shuffling the intro around, I also see that the existing text
> > largely mirrors the layout of the following sections (2, 3, and 4), but
> > does so out of order. Reorder those, and point to section numbers.
> >
> > [*] In addition to API complexity. I count 61 pm_*() helpers, 7 of which
> >     are variations of put() and 8 of which are variations of get().
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  Documentation/power/runtime_pm.rst | 87 +++++++++++++++++++++++-------
> >  1 file changed, 68 insertions(+), 19 deletions(-)
> >
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index 39fdeeda7a1e..620b6988deca 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -11,31 +11,80 @@ Runtime Power Management Framework for I/O Devices
> >  1. Introduction
> >  ===============
> >
> > -Support for runtime power management (runtime PM) of I/O devices is provided
> > -at the power management core (PM core) level by means of:
> > -
> > -* The power management workqueue pm_wq in which bus types and device drivers can
> > -  put their PM-related work items.  It is strongly recommended that pm_wq be
> > -  used for queuing all work items related to runtime PM, because this allows
> > -  them to be synchronized with system-wide power transitions (suspend to RAM,
> > -  hibernation and resume from system sleep states).  pm_wq is declared in
> > -  include/linux/pm_runtime.h and defined in kernel/power/main.c.
> > -
> > -* A number of runtime PM fields in the 'power' member of 'struct device' (which
> > -  is of the type 'struct dev_pm_info', defined in include/linux/pm.h) that can
> > -  be used for synchronizing runtime PM operations with one another.
> > +Runtime power management (or runtime PM, sometimes shortened to RPM) allows
> > +individual I/O devices to transition between high and low-power states
> > +dynamically while the system is running, conserving power without waiting for a
> > +system-wide sleep state.
> > +
> > +Core Concepts
> > +-------------
> > +
> > +Understanding runtime PM requires distinguishing between several pairs of
> > +complementary states that operate orthogonally: **active** / **suspended**,
> > +**enabled** / **disabled**, and **allowed** / **forbidden**.
> > +
> > +* **Active**: The PM core tracks a device's runtime status as either **active**
> > +  (the device is operational, having completed its resume callback) or
> > +  **suspended** (the device is idle or in a low-power state, having
> > +  completed its suspend callback), along with transitional **suspending**
> > +  and **resuming** phases. State transitions are primarily driven by
> > +  reference counting: drivers call pm_runtime_get() (or related variants)
> > +  when the hardware is needed (ensuring the device is active) and
> > +  pm_runtime_put() when work completes, allowing the PM core to initiate
> > +  suspension (immediately or after an autosuspend delay) once the usage
> > +  counter and any active child dependencies reach zero.
> 
> While the above is fine IMV, the enabled/disabled concept is more
> fundamental

Sure. So perhaps "enabled" should come first in the introduction? And
then the (non-orthogonal, per below) relationships can be described when
introducing the others?

> because "active" and "suspended" are not really relevant
> when runtime PM is disabled.  Yes, they need to be set properly before
> enabling it and there is some complexity related to the integration
> with system-wide PM, but generally speaking, if runtime PM is disabled
> for a given device, its active/suspended status is irrelevant.

I think you've hit on a key point here, which makes it hard to
understand RPM sometimes. Indeed enabled-vs-active are not fully
orthogonal, but then, I also think your "generally speaking" qualifier
is holding a lot of weight here -- there are quite a few ways in which
active/suspended are relevant independently of enabled/disabled.

For one, an active disabled device *will* prevent its parent from
suspending, while a suspended disabled device will not. (Now, is that an
*important* state? An expected state? Maybe not really, but it at least
clouds a reader's mental model.)

And then, reading these 3 helpers, I constantly have to refer back to
their implementation:

	pm_runtime_active()
	pm_runtime_suspended()
	pm_runtime_status_suspended()

The existence of pm_runtime_status_suspended() (which ignores
disable_depth) means I can never fully apply the reasoning you suggest.
I need to consider both the disable_depth and the runtime_status when
understanding how a device will behave.

> > +
> > +* **Enabled**: Orthogonal to whether a device is currently active or suspended
> > +  is whether runtime PM is **enabled** or **disabled**.
> 
> So it is not orthogonal.

Perhaps "independent" is a better term? I agree they're not fully
unrelated, but they're also not fully dependent -- active/suspended has
significant meaning even when disabled.

In any case, I'll try to incorporate some more color about how they do
relate.

> > This is governed by an
> > +  internal disable counter (``disable_depth``). All devices are initialized
> > +  with runtime PM disabled (``disable_depth == 1``)
> 
> This is only partially true because the PCI bus type, for instance,
> enables runtime PM for all PCI devices and so it is enabled when
> drivers get to them.

Ack. I had this in mind at some point during the drafting, but when RPM
is so complicated, it's hard to choose where and when to document all
the exceptions.

> > and can also be disabled
> > +  during system sleep transitions or explicitly via pm_runtime_disable(). In
> > +  the disabled state, the PM core ignores idle and suspend requests and will
> > +  not execute runtime PM callbacks (->runtime_suspend(), ->runtime_resume(),
> > +  ->runtime_idle()).
> 
> Moreover, parent-child and supplied-consumer dependencies are
> generally not tracked for devices with disabled runtime PM.

Is that really true? A disabled-but-active device still prevents its
parents and suppliers from suspending, as far as I can tell.

If I can interpret *your* intended mental model: if we intend not to
RPM-manage a device, it should be left disabled and suspended, in which
case it will generally be ignored by RPM. (Or alternatively:
disabled-but-active is not generally an expected long-term "steady"
state.)

But if that's all true, I'm still not sure what to document, to balance
focus and simplicity (for an introduction) vs covering all the edge
cases and complexities. Perhaps for an intro: we start with
"enabled/disabled", and suggest that if a driver never touches RPM (and
never "enables" the device), RPM mostly stays out of the way.
But if we want to opt into RPM, then we enable() (and then start to
think about active/suspended, per the 2nd key state).

[ Side note: since you mentioned PCI... that gets into a real-world case
  of confusion: I've dealt with PCI driver authors that want to "prevent
  runtime PM" in their driver [*], since they hadn't finished validating
  all the runtime_suspend/resume behavior for a particular device. In
  that case, pm_runtime_disable() was actually an OK choice, because the
  PCI device was already active. But if they applied your quoted
  reasoning, they'd have to choose something else. (And frankly, they
  probably should.) But would that be forbid()? Or get()? That's exactly
  the sort of question I'd hope this document can help clarify.

  [*] ...yes, the PCI bus purposely holds a usage count, requiring
  drivers to opt into RPM by pm_runtime_put_noidle() or similar... But
  the question arises nonetheless, when people aren't really RPM
  experts, and they're dealing with vendor drivers with odd code
  structure. ]

> > A driver activates runtime PM processing during
> > +  initialization or probe by calling pm_runtime_enable(), decrementing
> > +  ``disable_depth`` to zero.
> 
> Yes, and it needs to set the active/suspended status to reflect the
> current physical state of the device before calling
> pm_runtime_enable().
> 
> > +
> > +* **Allowed**: System policy and user space govern whether dynamic suspension
> > +  is permitted through the concepts of **allowed** and **forbidden**,
> > +  manipulated in-kernel via pm_runtime_allow() and pm_runtime_forbid() and
> > +  exposed to user space through the ``/sys/devices/.../power/control``
> > +  attribute. When runtime PM is forbidden (``control`` set to ``on``), the PM
> > +  core increments the device's usage counter, forcing the device to remain
> > +  active regardless of whether the driver is idle. When runtime PM is allowed
> > +  (``control`` set to ``auto``), this reference is dropped, permitting the PM
> > +  core to automatically suspend the device whenever its driver and child
> > +  devices are no longer using it.
> > +
> > +Notably, runtime PM also has a feature called "autosuspend." This is different
> > +than the ``control`` notion of "auto" (i.e., "allowed"). Autosuspend is
> > +described in more detail in Section 9.
> 
> Yup, and the changes below look good.
> 
> > +
> > +Implementation Structure
> > +------------------------
> > +
> > +Support for runtime power management is provided at the power management core
> > +(PM core) level by means of:
> >
> >  * Three device runtime PM callbacks in 'struct dev_pm_ops' (defined in
> > -  include/linux/pm.h).
> > +  include/linux/pm.h). See Section 2.
> > +
> > +* A number of runtime PM fields in the 'power' member of 'struct device' that
> > +  can be used for synchronizing runtime PM operations with one another. These
> > +  are covered in Section 3.
> >
> >  * A set of helper functions defined in drivers/base/power/runtime.c that can be
> >    used for carrying out runtime PM operations in such a way that the
> > -  synchronization between them is taken care of by the PM core.  Bus types and
> > -  device drivers are encouraged to use these functions.
> > +  synchronization between them is taken care of by the PM core. Bus types and
> > +  device drivers are encouraged to use these functions. They are covered in
> > +  Section 4.
> >
> > -The runtime PM callbacks present in 'struct dev_pm_ops', the device runtime PM
> > -fields of 'struct dev_pm_info' and the core helper functions provided for
> > -runtime PM are described below.
> > +* The power management workqueue pm_wq in which bus types and device drivers can
> > +  put their PM-related work items. It is strongly recommended that pm_wq be
> > +  used for queuing all work items related to runtime PM, because this allows
> > +  them to be synchronized with system-wide power transitions (suspend to RAM,
> > +  hibernation and resume from system sleep states). pm_wq is declared in
> > +  include/linux/pm_runtime.h and defined in kernel/power/main.c.
> >
> >  2. Device Runtime PM Callbacks
> >  ==============================
> > --
> > 2.55.0.979.g7e5102b832-goog
> 
> Do the subsequent patches in the series depend on this one?

Logically: mostly not. But patch 10 ("PM: runtime: Add "Section"
hyperlinks") touches some of the same areas and so does not apply
without conflicts.

I can try to rebase/rework/resend the patches you didn't apply, and I'll
again try to keep the likely-more-controversial parts toward the end.
(So, probably push this one a little further back.)

Regards,
Brian
