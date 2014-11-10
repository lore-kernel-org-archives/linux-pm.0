From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no
 PM_RUNTIME
Date: Mon, 10 Nov 2014 13:59:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411101346430.13641-100000@netrider.rowland.org>
References: <CAPDyKFp+cZa6PrAwQHbQE4xEzmRKBwN5J_uRByOdM0h8yoV2vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:51290 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751590AbaKJS7b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 13:59:31 -0500
In-Reply-To: <CAPDyKFp+cZa6PrAwQHbQE4xEzmRKBwN5J_uRByOdM0h8yoV2vg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

[CC: list severely trimmed]

On Mon, 10 Nov 2014, Ulf Hansson wrote:

> >> There are an important advantage of using the pm_runtime_force_suspend() here.
> >>
> >> For the driver to handle clock gating at system PM suspend, it first
> >> needs to bring the device into full power, through
> >> pm_runtime_get_sync(). Otherwise it's not safe to gate the clock,
> >> since it may already be gated.
> >
> > That's fine, but it has nothing to do with pm_runtime_force_suspend().
> >
> > Besides, if the real question is whether or not to gate the clock (or
> > in other words, has the clock already been gated), why not just store a
> > "clock_is_gated" flag somewhere?
> 
> You could do that, but it's easier to not.

I'm not convinced.  And you haven't said how this is related to
pm_runtime_force_suspend().

> You will need to update the runtime PM status and disable runtime PM
> anyway, done by the API.

So what?  And what API are you referring to: the runtime PM API or 
something else?

I get the feeling that I'm missing a lot of important points here.  
What have you left out?

As I understand the problem, you've got a bus type where some of the
drivers have IRQ-safe runtime PM (and therefore carry out their
suspend/resume operations in interrupt context) and others don't.  The
subsystem core wants to maximize the power saving by deconfiguring some
clocks whenever a device is suspended, but this requires a process
context and so it can't be done directly when IRQ-safe runtime PM is
used.

Is that a good summary?  If it is, there are ways of dealing with this 
that don't involve messing around with the runtime PM internals, or 
using pm_runtime_force_suspend().

Alan Stern

