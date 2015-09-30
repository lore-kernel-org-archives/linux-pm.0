From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM / sleep: Kick devices that might have been
 reset by firmware
Date: Wed, 30 Sep 2015 10:46:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509301039270.15216-100000@netrider.rowland.org>
References: <5732365.XVsXxYIbHS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44522 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751695AbbI3OqE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2015 10:46:04 -0400
In-Reply-To: <5732365.XVsXxYIbHS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>

On Wed, 30 Sep 2015, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the platform firmware was involved in the system resume that's
> being completed, there is a concern that some devices might have
> been reset by it and if those devices had the power.direct_complete
> flag set during the preceding suspend transition, they may stay
> in a reset-power-on state indefinitely (until they are runtime-resumed
> and then suspended again).  That may not be a big deal from the
> individual device's perspective, but if the system is an SoC, it may
> be prevented from entering deep SoC-wide low-power states on idle
> because of that.
> 
> To prevent that from happening, force a runtime resume for devices
> with power.direct_complete set if the platform firmware was involved
> in the resume transition currently in progress.
> 
> Something similar was done by the ACPI PM domain, but regardless of
> the platform firmware involvement, and the new mechanism should be
> sufficient to replace that code, so drop it.

Maybe I'm not reading patch 1/2 correctly, but it looks like an
ordinary ACPI-based desktop PC will always believe the firmware was
involved in an S3 sleep transition.  If that's so then won't this
change defeat all the work being done by people trying to prevent
unneeded runtime resumes during system resume?  direct_complete would 
be useful only on non-ACPI systems.

Alan Stern

