From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Wed, 20 May 2015 10:24:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505201015440.1659-100000@iolanthe.rowland.org>
References: <CAAObsKBGPP3UFFPtkq1aj_tZS9ZpJ6W4SY1g3rx1Gf6JRva0ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55068 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751609AbbETOYI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 10:24:08 -0400
In-Reply-To: <CAAObsKBGPP3UFFPtkq1aj_tZS9ZpJ6W4SY1g3rx1Gf6JRva0ww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 20 May 2015, Tomeu Vizoso wrote:

> On 19 May 2015 at 19:49, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 19 May 2015, Tomeu Vizoso wrote:
> >
> >> This function makes less cumbersome to enable runtime PM in a device and
> >> its descendants.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >
> > I don't see the point of this.  In the scenario you have in mind, are
> > the device and all its descendants registered by the same
> > subsystem/driver?
> 
> Not quite, the scenario here is a driver (uvcvideo) that deals with a
> specific piece of hardware and knows that all the descendants of the
> device it's bound to are virtual.
> 
> The subtree is:
> 
> 1-1:1.0 (bound to uvcvideo)
>         ep_87
>         input4
>                 event4
>         media0
>         video0

Just because these sub-devices are virtual, it doesn't mean you can 
ignore the way they interact with runtime PM.

In the case of ep_87 this doesn't matter.  Endpoint devices (like all 
devices) are in the SUSPENDED state by default when they are created, 
and they never leave that state.

Does the uvcvideo interface go into runtime suspend at the right times? 
If it does then you shouldn't have anything more to worry about.

> I liked how the force_direct_complete flag played out here, but I
> agree with Rafael that it can be abused as the PM domain or the bus
> type weren't able to prevent going directly to complete.
> 
> This is my testing branch, btw:
> 
> https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=fast-resume-v5
> 
> > If they are, can't the subsystem/driver code enable
> > runtime PM for each of them when they are registered, by adding a
> > single call in the right spot?
> >
> > If they don't all belong to the same subsystem/driver, who is going to
> > call your pm_runtime_enable_recursive routine?  No single caller will
> > have the right to enable runtime PM for all these devices.
> 
> Yeah, I was thinking that uvcvideo might be able to decide that, but
> I'm not really sure about it.

A possible way around the problem is to use pm_suspend_ignore_children
on the uvcvideo interface.  But I'm not sure that would be the right 
thing to do.

Alan Stern

