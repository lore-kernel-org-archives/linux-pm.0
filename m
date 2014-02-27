From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/8] PM / Sleep / Runtime: Fixup some driver's system suspend
Date: Thu, 27 Feb 2014 02:22:54 +0100
Message-ID: <12123949.qNoh3vhWUc@vostro.rjw.lan>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org> <7htxblx2eo.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50198 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752868AbaB0BHy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 20:07:54 -0500
In-Reply-To: <7htxblx2eo.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>

On Wednesday, February 26, 2014 08:30:07 AM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > Patch 1 -> 2:
> > These patches provides two new runtime PM helper functions which intend to be
> > used from system suspend/resume callbacks, to make sure devices are put into low
> > power state during system suspend and brought back to full power at system
> > resume.
> >
> > The prerequisite is to have all levels of a device's runtime PM callbacks to be
> > defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
> > for CONFIG_PM.
> >
> > By using the new runtime PM helper functions especially the two scenarios below
> > will be addressed.
> >
> > 1) The PM core prevents .runtime_suspend callbacks from being invoked during
> > system suspend. That means even for a runtime PM centric subsystem and driver,
> > the device needs to be put into low power state from a system suspend callback.
> > Otherwise it may very well be left in full power state (runtime resumed) while
> > the system is suspended. By using the new helper functions, we make sure to walk
> > the hierarchy of a device's power domain, subsystem and driver.
> 
> I thought it was the case that runtime PM was only disabled during the
> 'late' phase now.  Isn't that enough to allow runtime callbacks in the
> normal suspend/resume hooks now?   /me looks.
> 
> oh, wait.  Ee still have the _get_noresume() in device_prepare().  hmm
> 
> Either way, I'm not not a big fan of new functions.  Personally, I think
> subsystems/busses/pm_domains should be able to opt out of the PM core
> behavior that blocks runtime PM transitions during system suspend.
> Something like the (untested) hack below.  That way, we could avoid the
> need for new helper functions.

And if one of the subsystems in question is the platform bus type, then
adding the flag doesn't really make sense, because that means that on
many system it will be set for the majority of devices. :-)

That said I'm tired of this stuff already.  If you really really want to
remove the bumping up and dropping of the usage counter during system
suspend/resume by the core, please feel free to submit a patch for that
and I'll apply it.  However, if it causes any regressions to happen
anywhere, it will be dropped and we'll never talk about this again.

Deal? 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
