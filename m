From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 12:58:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509161255140.1993-100000@iolanthe.rowland.org>
References: <55F970D8.1090205@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58131 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751921AbbIPQ6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 12:58:19 -0400
In-Reply-To: <55F970D8.1090205@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Sep 2015, Grygorii Strashko wrote:

> >> The core prohibits new devices from being registered.  It does not
> >> prohibit probes of existing devices, because they currently do not
> >> affect the dpm_list.
> 
> Seems I missed smth, but I can't find the place in Kernel that prohibits
> creation of new devices during suspend.
> 
> Could someone point me on, please?

In Documentation/power/devices.txt, there is a section describing the
various phases of system suspend.  The part about the "prepare" phase
says:

    1.	The prepare phase is meant to prevent races by preventing new devices
	from being registered; the PM core would never know that all the
	children of a device had been suspended if new children could be
	registered at will.  (By contrast, devices may be unregistered at any
	time.)  Unlike the other suspend-related phases, during the prepare
	phase the device tree is traversed top-down.

	After the prepare callback method returns, no new children may be
	registered below the device.  The method may also prepare the device or
	driver in some way for the upcoming system power transition, but it
	should not put the device into a low-power state.

Alan Stern

