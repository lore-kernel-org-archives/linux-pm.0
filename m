From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 13:08:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509161259480.1993-100000@iolanthe.rowland.org>
References: <1475011.GNmxQvg88W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58151 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752551AbbIPRIE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 13:08:04 -0400
In-Reply-To: <1475011.GNmxQvg88W@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Sep 2015, Rafael J. Wysocki wrote:

> > The core prohibits new devices from being registered.  It does not 
> > prohibit probes of existing devices, because they currently do not 
> > affect the dpm_list.
> 
> Which may be a mistake, because it does affect callbacks executed during
> suspend/resume (after successful probe the device potentially has a different
> set of PM callbacks than before).
> 
> > In general, we rely on subsystems not to do any probing once a device 
> > is suspended.  It's probably reasonable to ask them not to do any 
> > probing once a device has gone through the "prepare" stage.
> 
> Right.
> 
> Question is when it should be allowed to probe again.  I guess at the same
> time we allow registrations to to take place again?

That would make the most sense.  Particularly since registration 
automatically causes probing to occur.

Now, we do allow registration below a device as soon as the ->resume
callback returns, whereas devices don't get added back to the dpm_list
until after the "complete" phase is totally finished.  If a
previously-existing device gets probed in between, it would be moved 
off the dpm_prepared_list before its ->complete callback was invoked, 
which means its ->complete wouldn't get called at all.

Perhaps this would be okay; it depends on the subsystem.

Alan Stern

