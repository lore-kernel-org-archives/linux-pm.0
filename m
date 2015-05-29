From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: check for complete cb before device lock in dpm_complete
Date: Fri, 29 May 2015 17:01:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505291657370.1404-100000@iolanthe.rowland.org>
References: <1432928056-25622-1-git-send-email-todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52561 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757036AbbE2VBV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2015 17:01:21 -0400
In-Reply-To: <1432928056-25622-1-git-send-email-todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, todd.e.brandt@intel.com

On Fri, 29 May 2015, Todd Brandt wrote:

> In theory, if a device has no pm_ops complete callback it shouldn't have
> to be locked in order to skip it in the dpm_complete call. This causes
> problems when a device without a complete callback has already begun
> operation after its resume cb is called. It can end up holding up the
> system resume as the pm subsystem tries to get a device lock just to
> check for a callback that isn't there.
> 
> This fixes an issue discovered on an Ivy Bridge laptop which has an
> AlpsPS/2 GlidePoint touchpad connected to an i8042 serio bus. The resume
> path ends up wasting a full second waiting for a device_lock on the psmouse
> driver, only to then discover that it has no device_complete callback. The
> alpa driver has already begun sending and receiving data after its resume
> call was finished, which prevents the pm subsystem from getting the device
> lock.

Why not simply move the device_lock() and device_unlock() calls inside
the "if (callback) {...}" block in device_complete()?

Are you worried that the presence/absence of a callback might change 
while the device is unlocked?  But that can happen with your patch too, 
and there the window is much larger.

Alan Stern

