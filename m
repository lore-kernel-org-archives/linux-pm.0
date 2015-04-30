From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/2] PM / sleep: Let devices force direct_complete
Date: Thu, 30 Apr 2015 10:53:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504301048410.1791-100000@iolanthe.rowland.org>
References: <CAPDyKFpLLJaMFsf5f8A42jjVqu+BkMMAH5ksHt0aA71QMQBH6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43427 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752706AbbD3Oxh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 10:53:37 -0400
In-Reply-To: <CAPDyKFpLLJaMFsf5f8A42jjVqu+BkMMAH5ksHt0aA71QMQBH6w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Thu, 30 Apr 2015, Ulf Hansson wrote:

> I hesitated to send this reply, since it might add confusion. If
> that's the case, please ignore it.
> 
> I have a long term vision to fully enable support for a runtime PM
> centric configuration for drivers/subsystems. The idea is, that such
> driver/subsystem should get system PM for "free".
> 
> The main goal is to simplify PM implementation for these drivers/subsystems.
> 
> They should need to implement the runtime PM callbacks only and not
> the system PM ones. During system PM suspend, the requirement is that
> the corresponding devices should be guaranteed to be "runtime PM
> suspended". Somehow that then needs to be managed by the PM core.
> 
> I am not sure it's doable, but I wanted to bring it up within the
> context of $subject patch, since it proposes yet another optimization
> path for runtime PM during system PM.

I suspect it is _not_ doable.  Consider a reasonable scenario: a driver
that does pm_runtime_get_sync() in its open routine and
pm_runtime_put() in its release routine.  If a user process holds the
device file open during a system suspend, it will be impossible for the
PM core to do a runtime suspend.

On the other hand, there's nothing to prevent drivers from setting 
their ->suspend and ->runtime_suspend structure members to point at the 
same routine.  The routine would need to handle the case where it was 
called for a system suspend while the device was already runtime 
suspended, but that doesn't seem too hard.  With the "direct-suspend" 
option, even this wouldn't be necessary.

Alan Stern

