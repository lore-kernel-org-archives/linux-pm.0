From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 02:07:48 +0200
Message-ID: <4548634.pC6GYZYGWm@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509161523230.1993-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45507 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752836AbbIPXjr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 19:39:47 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509161523230.1993-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 16, 2015 03:27:55 PM Alan Stern wrote:
> On Wed, 16 Sep 2015, Grygorii Strashko wrote:
> 
> > I think, It should prohibited to probe devices during suspend/hibernation.
> > And solution introduced in this patch might help to fix it -
> > in general, we could do :
> > - add sync point on suspend enter: wait_for_device_probe() and
> > - prohibit probing: move all devices which will request probing into
> > deferred_probe list
> > - one suspend exit: allow probing and do driver_deferred_probe_trigger
> 
> That could work; it's a good idea.
> 
> > I'd like to mention here that this patch will work only
> > if dmp_list will be filled according device creation order ("parent<-child" dependencies)
> > *AND* according device's probing order ("supplier<-consumer").
> > So, if there is the case when Parent device can be probed AFTER its children
> > - it will not work, because "parent<-child" dependencies will not be tracked
> > any more :( Sry, I could not even imagine that such crazy case exist :'(
> 
> If we avoid moving devices to the end of the dpm_list when they already 
> have children, then we should be okay, right?
> 
> > Are there any other subsystems with the same behavior like PCI?
> 
> I don't know.
> 
> > If not - probably, it could be fixed in PCI subsystem using device_pm_move_after() or 
> > device_move() in PCIe ports probe.
> > if yes - ... maybe we can scan/re-check and reorder dpm_list on suspend enter and
> > restore ("parent<-child" dependencies).
> 
> > Truth is that smth. need to be done 100%. Personally, I was hit by this issue also,
> >  and it cost me 3 hours of debugging and I came up with the same patch as
> > Bill Huang, then spent some time trying to understand what is wrong with PCI
> > - finally, I've just changed the order of my devices in DT :)
> > 
> > Also, I think, it will be good to have this patch in -next to collect more feedbacks.
> 
> I like the idea of forcing all probes during a sleep transition to be 
> deferred.  We could carry them out just before unfreezing the user 
> threads.  That combined with the change mentioned above ought to be 
> worth testing.

Agreed.

Thanks,
Rafael

