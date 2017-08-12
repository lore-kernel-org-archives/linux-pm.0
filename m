From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI / Sleep: Check low power idle constraints for debug only
Date: Sat, 12 Aug 2017 16:07:17 +0200
Message-ID: <30065803.357Xcxq4YN@aspire.rjw.lan>
References: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com> <e14a52ba9bce486c8b4dd6811a0e0138@ausx13mpc124.AMER.DELL.COM> <1502468330.20268.26.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57330 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750973AbdHLOPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 10:15:39 -0400
In-Reply-To: <1502468330.20268.26.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Mario.Limonciello@dell.com, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de

On Friday, August 11, 2017 6:18:50 PM CEST Srinivas Pandruvada wrote:
> On Fri, 2017-08-11 at 14:43 +0000, Mario.Limonciello@dell.com wrote:
> > > 
> > > -----Original Message-----
> > > From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.c
> > > om]
> > > Sent: Thursday, August 10, 2017 5:54 PM
> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>; rjw@rjwysocki.
> > > net;
> > > lenb@kernel.org
> > > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > acpi@vger.kernel.org; lukas@wunner.de
> > > Subject: Re: [PATCH v2 2/2] ACPI / Sleep: Check low power idle
> > > constraints for
> > > debug only
> > > 
> > > On Thu, 2017-08-10 at 22:07 +0000, Mario.Limonciello@dell.com
> > > wrote:
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > 
> > > [...]
> > > 
> > > > 
> > > > > 
> > > > > +
> > > > > +		ret = acpi_device_get_power(adev, &state);
> > > > > +		if (!ret)
> > > > > +			pr_debug("LPI: %s required min power
> > > > > state
> > > > > %d, current
> > > > > power state %d, real power state %d\n",
> > > > > +				 lpi_constraints_table[i].name
> > > > > ,
> > > > > +				 lpi_constraints_table[i].min_
> > > > > dsta
> > > > > te,
> > > > > +				 adev->power.state, state);
> > > > Isn't this superfluous to be showing the state returned from
> > > > acpi_device_get_power and
> > > > also probing directly at the state? You can't just rely on the
> > > > information you got
> > > > back from apci_device_get_power?
> > > They can be different as one is real power state and the other is
> > > what
> > > was set.
> > > For example on Dell 9365 it shows
> > > 
> > > [ 1924.393653] LPI: \_SB.PCI0.XHC required min power state 3,
> > > current
> > > power state 3, real power state 255
> > > 
> > Isn't 255 ACPI_STATE_UNKNOWN?  That makes it seem like it
> > is a logic problem in acpi_device_get_power (or somewhere down the
> > chain)
> > doesn't it?
> There is no _PSC for XHC device. So it will return unknown. This is an
> optional object, so I think that dumping the status is fine, but
> matching with output of acpi_device_get_power() as it relies on _PSC is
> not correct for the constraint.

Right.  Moreover, acpi_device_get_power() is basically mostly intended for
initialization, so the constraint should be matched against power.state,
as that's the current ACPI power state of the device as far as the kernel
can say.

Thanks,
Rafael
