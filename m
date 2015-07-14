From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Tue, 14 Jul 2015 17:57:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507141756170.8160-100000@netrider.rowland.org>
References: <CAAObsKA3hm4GkYbgJ1APCHvO3ZYP=bT=0cQyhxhm5VrPYn99wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:52783 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752409AbbGNV5m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 17:57:42 -0400
In-Reply-To: <CAAObsKA3hm4GkYbgJ1APCHvO3ZYP=bT=0cQyhxhm5VrPYn99wQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 14 Jul 2015, Tomeu Vizoso wrote:

> > We may want to do the direct_complete_default thing in a different way.
> > For example, the PM core could automatically set the direct_complete
> > flag if a device has _none_ of the system suspend callbacks (i.e., no
> > prepare, suspend, suspend_late, suspend_noirq, resume_noirq,
> > resume_early, resume, or complete).  Although it would be a little
> > awkward to check this, it would be safer than inheriting
> > direct_complete_default from the parent and it ought to solve Tomeu's
> > problem just as well.
> 
> Yeah, I think this is an improvement. Will give it a try.

Sounds good.

> > Here's a proposed patch to illustrate what I have in mind.  Since it
> > removes the only usage of pm_runtime_suspended_if_enabled(), it also
> > removes the definition of that function.
> 
> Will this patch be picked up as-is or should I add it to my series
> with a proper changelog?

You can add it to your series with my S-O-B:

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

