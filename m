From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no
 PM_RUNTIME
Date: Wed, 12 Nov 2014 09:56:38 +0100
Message-ID: <1415782598.4247.2.camel@AMDC1943>
References: <Pine.LNX.4.44L0.1411101346430.13641-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20602 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbaKLI4q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 03:56:46 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NEX007804Z5DT00@mailout4.w1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 12 Nov 2014 08:59:29 +0000 (GMT)
In-reply-to: <Pine.LNX.4.44L0.1411101346430.13641-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On pon, 2014-11-10 at 13:59 -0500, Alan Stern wrote:
> [CC: list severely trimmed]
> 
> On Mon, 10 Nov 2014, Ulf Hansson wrote:
> 
> > >> There are an important advantage of using the pm_runtime_force_suspend() here.
> > >>
> > >> For the driver to handle clock gating at system PM suspend, it first
> > >> needs to bring the device into full power, through
> > >> pm_runtime_get_sync(). Otherwise it's not safe to gate the clock,
> > >> since it may already be gated.
> > >
> > > That's fine, but it has nothing to do with pm_runtime_force_suspend().
> > >
> > > Besides, if the real question is whether or not to gate the clock (or
> > > in other words, has the clock already been gated), why not just store a
> > > "clock_is_gated" flag somewhere?
> > 
> > You could do that, but it's easier to not.
> 
> I'm not convinced.  And you haven't said how this is related to
> pm_runtime_force_suspend().
> 
> > You will need to update the runtime PM status and disable runtime PM
> > anyway, done by the API.
> 
> So what?  And what API are you referring to: the runtime PM API or 
> something else?
> 
> I get the feeling that I'm missing a lot of important points here.  
> What have you left out?
> 
> As I understand the problem, you've got a bus type where some of the
> drivers have IRQ-safe runtime PM (and therefore carry out their
> suspend/resume operations in interrupt context) and others don't.  The
> subsystem core wants to maximize the power saving by deconfiguring some
> clocks whenever a device is suspended, but this requires a process
> context and so it can't be done directly when IRQ-safe runtime PM is
> used.
> 
> Is that a good summary?  If it is, there are ways of dealing with this 
> that don't involve messing around with the runtime PM internals, or 
> using pm_runtime_force_suspend().

Thank you all for this precious feedback. I'll try the way with skipping
runtime PM stack completely during system suspend. Probably that will
add some complexity to the amba/bus and pl330 but there shouldn't be any
changes to PM core.

Best regards,
Krzysztof


