From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no
 PM_RUNTIME
Date: Thu, 13 Nov 2014 10:55:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411131021340.1209-100000@iolanthe.rowland.org>
References: <CAPDyKFrATXiiTCeK8A5NBB6K5TPgb9xG5CCKHTHCqdEW_i7qKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44307 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753913AbaKMPzV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 10:55:21 -0500
In-Reply-To: <CAPDyKFrATXiiTCeK8A5NBB6K5TPgb9xG5CCKHTHCqdEW_i7qKA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, 13 Nov 2014, Ulf Hansson wrote:

> The runtime PM resources depends on what AMBA device/driver is being
> used, typically clocks and pinctrls.
> 
> Simplified described, these bus/drivers PM support are designed in a
> runtime PM centric manner. It means at system PM suspend, the
> bus/driver wants to make sure the runtime PM resources are in a
> runtime PM suspend state.
> 
> Does that answer your question?

Yes, pretty much.  It sounds like pm_runtime_force_suspend does do want 
you want, provided you don't have to worry about wakeup settings.

And I guess if you're going to take this runtime-PM-centric approach,
and if you're also going to rely on some drivers being IRQ-safe and
others not, then the irq_safe flag needs to exist even when runtime PM
is not configured.

It still feels like a backward approach, not the way I would have done
it.  But never mind...

Alan Stern

