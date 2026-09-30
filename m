Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4E4B048D
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811619; cv=none; b=BsdUIWt13m7gJEZiu6GUB7qPjr5zy+tw+V3m/6fteWRQYiTOUFkiWenrEiNZcNLPH2F3eNR16OGSBsLD4wP5IErUo1jEc9LFBSK4jAppTzCdSFcD0Ria0GMzlcoGqRsDZzx4cDEzDcwyBJoedzPyEcl1H64KIy/5L/3lYfEnPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811619; c=relaxed/simple;
	bh=/wT84atEVTXgORjRobOlq0EX63PcjkCoip+DOkemHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTPlBW3vcMENLjoYdqQDcKAowwo/4UiyZV7VwA77/A14AiO3KeIgXguQ2Uj6otR5Q0wHjZBOIHaqlqaBCld+YnS47lJaKiV0Yomuz4Bqs+fP6m0D8WXLSKk+VYFDlsX6xslY5mwg1KwROCs4N8sHRGa8I01dGKq9etSP1KdNdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Inund3JY; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Inund3JY"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c2a97ec17so1275511eec.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790811615; x=1791416415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l47E9Z6dlv3zY8CaNIvzT71Tj+TWd7f9o2zVJXg7guU=;
        b=Inund3JYaJeXT7sA6Ok7nmccHTGQuc4fv03gW2i2sLk/muEu94reEQZJyOTD1nnb+d
         vCKq5HKNwAJyiAhQOoCu2eaucRSv2HfGUnoi17/GOWJ0i1BF3+HKe4DF9/0UKjtctwHs
         LYnafWBUeTD3SC26PipAzVRHmAA/gDPxM9Zyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790811615; x=1791416415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l47E9Z6dlv3zY8CaNIvzT71Tj+TWd7f9o2zVJXg7guU=;
        b=uiYtZf47CP1IB2hE8HwbG1nJbChNf2dFOa5LjIPopoTSL84MazlGVpLG8vuX/z8TTb
         kTaLg2rh2hlnDOdnzi0hgNPyTEA9H5tLLp9fEt76figlMV74cIvGLEVuRF4DF0iMSzlz
         TLiU3vR7Ss9FdImZTozLjxIfIp7vNal57PmjbgbU1ndZ2TdEpOJ4z4/zHVBDhgbn3fsV
         udkZM+Whv5o8vNDAEU31n2onUXnSdM3LSaKOBdxsAGgmur+OrPKhpAhmpGuP7/vHeEZg
         oUBtcUiirT0D8+pN+m9FYJ8ucSUbbxHSi8SaAhJJvf+vZC6cGaL2ZA+dcXD8DxXPrpPd
         N3lQ==
X-Forwarded-Encrypted: i=1; AKwUvByKtsGDurhC6bDhakOWjLGsQZggkh17bN13na9EaG1NHvOWkX1d+h+kbcbKP3KlV270kPrFBCFCeQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ka3KUc5pIQeYPEBdVEok67MARcSX9l20BGSxzWnx4vQ71DzMky
	CaesGjlN6cyQI7zZ2nIRtzyINS4h3FhX4QW0e51RMdpgJxAglcq89HKhz+zQG7DacA==
X-Gm-Gg: AYBFou3qHoJYgC5zTzt/kUCynm9pfkFM2IzMz7Fl2G1tIVEdrmiTsA8WosakL2lTA2I
	mkzi+bSXwKONwc5q+5QK9eL8TxuOx9nO01EnyIjU5ysgqRNwQ7VJS3MMty2EL9Lh9obU5be74yc
	snd6UMAJsc00rMsvqcI3SIzC88FfFaUoMJpJUVQT4djGmATEdN3zNxNJ+SwP3QcGC2cIe/lx4nM
	PWYcEgbh2XOUfRtyAHXMLQrmYMBJrSzOdTdJTLJHQZTpLtE/cRMU6LorLXrlxpViHUV1qPmVnJE
	PP1pAYcyyTa8c5Qeojh8xzA0P4GjRvZU9TuYG6Wo2cqteCXR6/rCW1cvPN9wk+j0+wzJCCYB3xW
	nij9N259lWz6+JiNw4JeKNKJH98iVU+QRqPAOd7k3rYg6Ae837KIeN3a0wNLJtLNMjjFgR/xi6S
	/9/ZhBP4JiZrmdJ2fqYMRCaA8Xipo2g8ECoOONiETMB4l6c5hWswry/P07DhLVdgzQpuIH4C/VE
	jlrtrM3DzjAyTW2YKs+/JyH+iiXOhqLqnByBg==
X-Received: by 2002:a05:7022:fa2:b0:14a:c6cf:1449 with SMTP id a92af1059eb24-14d330b01b8mr4616808c88.32.1790811615061;
        Wed, 30 Sep 2026 16:40:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:7cf1:ee59:f140:7be9])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14df49c86b7sm1150029c88.17.2026.09.30.16.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 16:40:14 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:40:11 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Doug Anderson <dianders@chromium.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] PM: runtime: Expand introduction with core
 concepts and structure
Message-ID: <ar2d2xCi9ITd3NYH@google.com>
References: <20260930025044.104824-1-briannorris@chromium.org>
 <20260929194956.v3.7.I45a794e4452e3df22419acdd8f11e2b788b3413f@changeid>
 <CAJZ5v0ifwGx-1H-YVM63-0HUD5cs+5W4Tk8T+2LdLZpy5sLS9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ifwGx-1H-YVM63-0HUD5cs+5W4Tk8T+2LdLZpy5sLS9w@mail.gmail.com>

Hi Rafael,

On Wed, Sep 30, 2026 at 05:41:56PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Sep 30, 2026 at 4:51 AM Brian Norris <briannorris@chromium.org> wrote:
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
> > (no changes since v2)
> >
> > Changes in v2:
> > Address review feedback around descriptions of "enabled" and "active". I
> > know not every point of discussion was settled, but I hope this updated
> > version resolves many of them and provides a better basis for further
> > improvement.
> >  * Avoid calling enabled and active "orthogonal"
> >  * Describe more of their inter-relationship
> >  * Prioritize talking about "enabled" first, since that's the first
> >    concept a reader should know about
> >  * Brief mentions of parent/child and supplier/consumer, and dependency
> >    handling
> >  * Other tweaks
> >
> >  Documentation/power/runtime_pm.rst | 103 +++++++++++++++++++++++------
> >  1 file changed, 84 insertions(+), 19 deletions(-)
> >
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index 68903d93a3e7..c63fbf0ff862 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -13,31 +13,96 @@ Runtime Power Management Framework for I/O Devices
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
> 
> I would rephrase the above as follows:
> 
> "Runtime power management (or runtime PM, sometimes also referred to
> as RPM) allows individual I/O devices that are not in active use to be
> put into low-power states, in which they may not be operational or
> even accessible, and go back to the fully operational state as needed.
> Power can be reduced this way without waiting for a transition into a
> system-wide sleep state."

Sure, looks fine to me.

> > +
> > +Core Concepts
> > +-------------
> > +
> > +Understanding runtime PM requires distinguishing between several pairs of
> > +related but distinct concepts that apply to each device: **enabled** /
> > +**disabled**, **active** / **suspended**, and **allowed** / **forbidden**.
> > +
> > +* **Enabled**: To use runtime PM to manage a device's power states, it must
> > +  first be **enabled**. If RPM is never enabled for a device, it generally
> > +  stays inactive from an RPM perspective, and the PM core will ignore it.
> > +  If it is enabled, the PM core can manage the device status (see **Active**
> > +  below) according to its understanding of whether the device is in use, and
> > +  perform state transitions via the appropriate PM callbacks
> > +  (->runtime_suspend(), ->runtime_resume()).
> > +
> > +  Each device has an internal disable counter (``disable_depth``) which
> > +  determines whether runtime PM is currently enabled. Devices are initially
> > +  registered with runtime PM disabled (``disable_depth == 1``), though some bus
> > +  types (such as PCI) may enable it before driver probe.
> > +
> > +  To opt into runtime PM, a driver first ensures that the device's recorded
> > +  status matches its actual physical state (for example, by calling
> > +  pm_runtime_set_active() if the device was powered on at probe) and then calls
> > +  pm_runtime_enable(), decrementing ``disable_depth`` to zero (i.e.,
> > +  **enabled**). Runtime PM may be disabled again explicitly via
> > +  pm_runtime_disable() or temporarily during system sleep transitions.
> > +
> > +* **Active**: The PM core tracks a device's runtime status as either **active**
> > +  (the device is operational, having completed its resume callback or otherwise
> > +  marked active) or **suspended** (the device is idle or in a low-power state,
> > +  having completed its suspend callback or otherwise marked suspended), along
> > +  with transitional **suspending** and **resuming** phases. When runtime PM is
> > +  **enabled**, state transitions are primarily driven by reference counting:
> > +  drivers call pm_runtime_resume_and_get() (or related variants) before using
> > +  the hardware, to ensure the device is active; and pm_runtime_put() (or
> > +  related variants) once work completes. When a device's usage counter drops to
> > +  zero and its dependencies (children or consumers) are suspended, the PM core
> > +  can suspend the device immediately or after an autosuspend delay.
> > +
> > +  Besides driving the state of the device in question, a device's runtime
> > +  status also affects those of its dependencies — its parent (if the parent's
> > +  ``power.ignore_children`` is false) and its linked supplier device(s) (for
> > +  links with the ``DL_FLAG_PM_RUNTIME`` flag). An **active** device holds
> > +  reference counts on its dependencies, preventing them from suspending.
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
> > +described in more detail in `Section 9`_.
> 
> Regarding the above, I have reconsidered it with the conclusion that
> it would be better to describe "active" and "suspended" first and
> "enabled" and "disabled" subsequently,

I also found it to be not-so-great to put "enabled" first, as it still
requires forward-references to "active" to cover it sufficiently.

> and maybe without going too
> much into details yet.

Sure. There are probably some details that could be omitted from my
version. Frankly, some of those details are there because you asked for
them though...

> Here's my version of it:

Thanks! My general thoughts are:

1) I think your version adds a few things that are nice to have. For
   example, a better clarification of what "active" and "suspended" mean
   from both physical device level, and from abstract RPM meaning. (This
   may also be where you've insisted on "meta-state" as a term.	I don't
   agree that "meta" adds any value, but I won't insist.)

   I also think the "forbidden" implication is a good addition: "the
   ability to transition a device into the suspended meta-state via
   runtime PM must not be relied on for correctness" -- that's one
   reason I wanted to put allowed/forbidden up top; that it throws a
   wrench in many people's assumptions.

   You spend more time on dependencies. That's a good thing IMO.

2) I think your version adds some things that are undesirable for an
   intro. For one, it spends quite some time to talk about the pitfalls
   of a "disabled+active" device. I think this is not something that
   goes in an introduction, and is more of an anti-pattern. If we wanted
   to document anti-patterns, we could write another few essays, I'm
   sure... It's also somewhat covered in Section 5 already.

   You've also completely omitted describing reference counting. This is
   one of the most fundamental aspects of RPM, IMO. (OTOH, omitting API
   names is a fine choice.) I think your elaboration of "dependencies"
   is a good time to just break out a section on what constitutes "in
   use" -- get()/put() references, and dependents.

3) Lack of organizational clarity -- your version looks more like a wall
   of text essay, which IMO doesn't do so well at engaging introductory
   readers, or those skimming for one concept (e.g., "forbidden"). I
   still prefer the structure that clearly highlights the main topics,
   either with bullets or sections or something.

4) autosuspend -- I think it deserves a mention in the intro, even if
   it's a pointer to the existing section. Not sure if you meant to drop
   it.

5) Wordy. Your intro has about ~%50% more words. I think the same
   content could be represented more succinctly, to make for a better
   read.

...but:

6) It's better than not having this introduction at all!

So aside from the general thoughts above, I will:

(a) add minimal direct feedback to the text below, in case you'd still
    prefer taking a variation of your content. That would be OK with me.

(b) provide my own adaptation of my writing + your writing at the end,
    in case you'd rather try that.

> "There are some device-level concepts that need to be grasped in order
> to understand runtime PM as a whole.

I think listing the concepts at the top helps, as a sort of introductory
paragraph/sentence to the following wall of text and/or bullets.

Also, super-nits: you seem to wrap at about 70 chars, while most of this
doc (and other docs, I think) wraps at around 78-80.

I also see a difference on two spaces after periods or not. I guess most
of this doc uses two, even though that's not the dominant style these
days. I'll try to stick with two spaces now that I noticed. (Fun fact:
it seems browsers automatically collapse these to one space, when
viewing the generated HTML.)

> First of all, runtime PM tracks whether or not devices are in active
> use, which generally means that they are accessible and operational,
> and may be depended on by something (for example, other devices or
> user space).  That is represented by the **active** meta-state of a
> device from the runtime PM perspective.  The other persistent device
> meta-state used by runtime PM, called **suspended**, represents a
> promise that the given device will not be accessed.  This covers
> devices in low-power states, but it also may include devices that are
> not fully operational, or are regarded as such, for other reasons.
> There are also two transient meta-states, **suspending** and
> **resuming**, that represent transitions between **active** and
> **suspended** often referred to as *runtime suspend* and *runtime
> resume*, or just *suspend* and *resume*, respectively.  Every device
> handled by runtime PM is in one of these four meta-states at any time
> and the meta-state it is in is expected to reflect its actual physical
> configuration (that is, for instance, if the device is not accessible,
> it cannot be **active**).  The term "runtime PM state" used in what

Somewhat nitpick: everything else seems to call it "runtime PM status"
or similar, not "runtime PM state". `enum rpm_status`, most of the
existing doc language, the 'power.runtime_status' field, etc.

> follows refers to the meta-states described above.
> 
> Second, in order to track the runtime PM state and carry out
> transitions between **active** and **suspended**, runtime PM needs to
> be **enabled** for the given device.  If it is **disabled**, it
> generally leaves the device alone.  This means in particular that the
> runtime PM state of a device and its actual physical configuration may
> get out of sync after disabling runtime PM for it.  Analogously, the

I'm not sure "analogously" is the right word here. It seems like you're
going for "additionally" or some other similar word.

> runtime PM state of a device may need to be explicitly adjusted to
> reflect its current physical configuration before enabling runtime PM
> for it.  Moreover, it is generally not recommended to leave devices in
> the **active** meta-state after disabling runtime PM for them because
> that may affect what can be done to their ancestors and suppliers
> going forward.
> 
> More specifically, in addition to tracking the runtime PM state of
> every device, runtime PM tracks dependencies between different
> devices.  In fact, that dependency tracking mechanism is the main
> reason for using runtime PM.  The idea is that in order for a device
> to become **active**, all of the devices it depends on must also be
> **active** and that is enforced by runtime PM.  Accordingly, an
> attempt to resume a device causes all of the devices it depends on to
> become **active** and remain **active** until the given device is
> suspended.  In turn, an attempt to suspend a device may allow the
> devices it depends on to also suspend unless they are additionally
> depended on by something else.  While desirable so long as runtime PM
> is **enabled**, this may become problematic when runtime PM is
> **disabled** because the tracking of dependencies does not stop
> automatically at that point and it may cause some devices to remain
> **active** unnecessarily.

Like I said above, I like that you went into more detail on
dependencies. But I think this is a pretty divergent train of thought.
In my edited version below, I chose to break it out into a new
bullet/section, kept after the first 3.

> As a rule, runtime PM is **disabled** for all devices to start with,
> but there are bus types that enable it for every device (for instance,
> the PCI bus type does so).  Generally speaking, drivers are expected
> to know which bus they belong to and so they should also know whether
> or not runtime PM has been enabled for the devices handled by them
> already.  In the cases in which runtime PM is not enabled by the bus
> type, drivers are responsible for enabling it if they want to
> participate in it.  The devices for which runtime PM has never been
> enabled are black boxes from its point of view.

I think most of this paragraph is a bit too much, and is easily derived
from just explaining that "most start disabled; some buses (like PCI)
make more initial choices for you; choose accordingly".

I'm also not sure what the "black box" mention adds on top of the
earlier, "If it is **disabled**, it generally leaves the device alone."

> Finally, runtime PM may be **forbidden** even though it has been
> enabled.  Doing so causes the given device to transition into the
> **active** meta-state (unless it has been **active** already before)
> and prevents it from being suspended.  In other words, a device with
> forbidden runtime PM remains **active** at least until runtime PM is
> **allowed** for it again.  This mechanism is not only available to
> kernel code, but it may also be used by user space through the
> ``/sys/devices/.../power/control`` *sysfs* attribute of the given
> device.  Namely, writing ``on`` to that attribute causes runtime PM to
> be forbidden for it, and writing ``auto`` to that attribute causes
> runtime PM to be allowed.  User space may use that attribute at any
> time, so the ability to transition a device into the **suspended**
> meta-state via runtime PM must not be relied on for correctness, among
> other things."

I still think autosuspend belongs in the intro, even if only to link to
the existing section. (I also think the "auto" vs "autosuspend"
disambiguation is important, but I'm also open to moving that part to
Section 9 or similar.)

> I think that it provides all of the information needed to start with
> without pulling too much stuff documented elsewhere.
> 
> If you agree with the above, I'll send my version as a separate patch.

I'm obviously biased, but I think there's room for improvement. I'm
providing my adaptation of your text below, but I'm also open to yours
however you see fit. Like I said, one of these options is better than
none.

Let me know if I should send the below in v4, or else please mail your
own for review!

"""
Runtime PM operates around a few device-level concepts — whether a device is
**active** or **suspended**; whether runtime PM is **enabled** or **disabled**;
whether runtime PM is **allowed** or **forbidden**; and whether a device is "in
use."

* **Active**: Runtime PM tracks whether or not devices are in active use, which
  generally means that they are accessible and operational, and may be depended
  on by something (for example, other devices or user space).  This is
  represented by the **active** meta-state.  By contrast, the **suspended**
  meta-state represents a promise that the given device will not be accessed.
  This covers devices in low-power states, but it also may include devices that
  are not fully operational.  There are also two transient meta-states,
  **suspending** and **resuming**, representing transitions between **active**
  and **suspended** often referred to as *runtime suspend* and *runtime
  resume*, or just *suspend* and *resume*, respectively.  Every device handled
  by runtime PM is in one of these four meta-states at any time, and its
  meta-state is expected to reflect its actual physical configuration (that is,
  for instance, if the device is not accessible, it must not be **active**).
  The term "runtime PM status" used in what follows refers to the meta-states
  described above.

* **Enabled**: In order to track the runtime PM status and carry out
  transitions between **active** and **suspended**, runtime PM needs to be
  **enabled** for the given device.  If it is **disabled**, runtime PM
  generally leaves the device alone.  This means in particular that the runtime
  PM status of a device and its actual physical configuration may get out of
  sync after disabling runtime PM for it.  Additionally, the runtime PM status
  of a device may need to be explicitly adjusted to reflect its current
  physical configuration before enabling runtime PM for it (e.g., during device
  probe).  Once runtime PM is **enabled**, it begins managing PM status —
  performing *runtime suspend* and *runtime resume* transitions based on its
  understanding of whether a device is in use.

  As a rule, all devices are initialized with runtime PM **disabled**, though
  some bus types (such as PCI) manage some RPM initialization automatically,
  and therefore probe devices in an **enabled** state.  For other devices,
  drivers must enable runtime PM on their own to opt in.

* **Allowed**: Runtime PM may be **forbidden** even though it has been enabled.
  Doing so causes the given device to transition into the **active** meta-state
  and prevents it from being suspended.  In other words, a device with
  forbidden runtime PM remains **active** at least until runtime PM is
  **allowed** for it again.  This mechanism can be managed by in-kernel APIs,
  but more importantly, it is also available to user space via the
  ``/sys/devices/.../power/control`` sysfs attribute of the given device.
  Namely, writing ``on`` to that attribute forbids runtime PM, and writing
  ``auto`` allows it.  User space may modify that attribute at any time, so the
  ability to transition a device into the **suspended** meta-state via runtime
  PM must not be relied on for correctness.

* **In use**: Runtime PM determines whether a device should be transitioned to
  an **active** state by its understanding of whether a device is in use.  The
  first way a device is considered **in use** is by its own usage count — a
  reference counter driven by a variety of get()/put() APIs.  Additionally, a
  device may be considered **in use** by having active dependents — either
  child devices, or device-linked consumers.  When a device is no longer in
  use, runtime PM may choose to transition it to the **suspended** state.

  Thus, when a device moves from a **suspended** to an **active** state, it may
  also cause its dependencies to resume.  Conversely, suspending a device may
  also cause its otherwise-unused dependencies to suspend.

* **Autosuspend**: Runtime PM also supports a feature called "autosuspend."
  This is different than the ``control`` notion of "auto" (i.e., **allowed**).
  Autosuspend is covered in `Section 9`_.
"""

Brian

> > +
> > +Implementation Structure
> > +------------------------
> > +
> > +Support for runtime power management is provided at the power management core
> > +(PM core) level by means of:
> >
> >  * Three device runtime PM callbacks in 'struct dev_pm_ops' (defined in
> > -  include/linux/pm.h).
> > +  include/linux/pm.h). See `Section 2`_.
> > +
> > +* A number of runtime PM fields in the 'power' member of 'struct device' that
> > +  can be used for synchronizing runtime PM operations with one another. These
> > +  are covered in `Section 3`_.
> >
> >  * A set of helper functions defined in drivers/base/power/runtime.c that can be
> >    used for carrying out runtime PM operations in such a way that the
> > -  synchronization between them is taken care of by the PM core.  Bus types and
> > -  device drivers are encouraged to use these functions.
> > +  synchronization between them is taken care of by the PM core. Bus types and
> > +  device drivers are encouraged to use these functions. They are covered in
> > +  `Section 4`_.
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
> >  .. _Section 2:
> >
> > --
> 
> The last part above looks fine to me.
> 
> Thanks!
