From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 15:21:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509171520020.1270-100000@iolanthe.rowland.org>
References: <CAJZ5v0gEMhJaJa6m7Sq41oottuJW+0XJRpxsWHNdUsbVmNHeDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53718 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751714AbbIQTVF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 15:21:05 -0400
In-Reply-To: <CAJZ5v0gEMhJaJa6m7Sq41oottuJW+0XJRpxsWHNdUsbVmNHeDw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 17 Sep 2015, Rafael J. Wysocki wrote:

> Hi,
> 
> On Thu, Sep 17, 2015 at 7:40 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
> > On 17 September 2015 at 02:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Wednesday, September 16, 2015 03:22:37 PM Alan Stern wrote:
> >>>
> >>> It would also help if your patch checked to see if the device has any
> >>> children, and avoided moving it to the end of the list if it does.  In
> >>> fact, that might be sufficient to avoid almost all problems.
> >>
> >> I agree.
> >>
> >> In any case if a device that already has children is about to be probed,
> >> this is sort of a corner case anyway and should be handled as such.
> >
> > Just wanted to mention that it's very common in platforms that make
> > use of DT to have some devices registered before their parents have probed.
> > If I grep for DTS with simple-bus and simple-mfd I get 802 matches.
> 
> 
> This is good to know, thanks!

Hmmm.  In view of this, maybe it's not worthwhile to try looking for 
such things.  Given that they exist all over the place, we will 
definitely need to handle them correctly.

Alan Stern

