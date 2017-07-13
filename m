From: Imre Deak <imre.deak@intel.com>
Subject: Re: ACPI target state during S4 quiesce phase
Date: Thu, 13 Jul 2017 17:48:47 +0300
Message-ID: <20170713144847.vbrsyuc54x454bbn@ideak-desk.fi.intel.com>
References: <20170712191009.pylvv4kpjmyi7lny@ideak-desk.fi.intel.com>
 <CAJZ5v0g=c3FL3X-_SuYp-=pds+r7VtaQpZESSNzNht9i0o94kw@mail.gmail.com>
 <20170713103019.7qvfkcmaoufyk4ln@ideak-desk.fi.intel.com>
 <CAJZ5v0ipt03TMn2YWn4pCJvPfXNUa0QjcD_JKFZhO=Rq==cAnw@mail.gmail.com>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10292 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752466AbdGMOst (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jul 2017 10:48:49 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipt03TMn2YWn4pCJvPfXNUa0QjcD_JKFZhO=Rq==cAnw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>

On Thu, Jul 13, 2017 at 01:54:45PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 13, 2017 at 12:30 PM, Imre Deak <imre.deak@intel.com> wrote:
> > On Wed, Jul 12, 2017 at 10:40:31PM +0200, Rafael J. Wysocki wrote:
> >> On Wed, Jul 12, 2017 at 9:10 PM, Imre Deak <imre.deak@intel.com> wrote:
> >> > Hi,
> >> >
> >> > I noticed that acpi_target_system_state() returns ACPI_STATE_S0
> >> > when called from a dev pm->freeze hook before restoring the hibernation
> >> > image (PMSG_QUIESCE). Is this on purpose?
> >>
> >> Yes, it is.
> >
> > Ok.
> >
> >> After all, the platform is not going to change the power state, is it?
> >
> > No it won't, so yes S0 is the proper target state in that sense.
> >
> >>
> >> > One could argue that it should
> >> > be ACPI_STATE_S4, matching the target state before creating the
> >> > hibernation image (PMSG_FREEZE).
> >>
> >> And what would the argument be then?
> >
> > To me it makes sense to resume a device in pm->restore from the same
> > device power state pm->freeze/PMSG_FREEZE suspended it to.
> 
> No, you can't do that.
> 
> The restore kernel may be a different kernel *version* even, let alone
> a different set of drivers.  Effectively, you can get a device in the
> very state in which the platform firmware (aka BIOS) left it.

Right. Though having arbitrary configs for the two kernels sounds
unusual and a driver could decide not to support it. For example it may
not be possible to reload a firmware once it was loaded already (and so
the firmware loaded by the loader kernel must be compatible with the
target kernel). In any case this is a different problem and I agree that
in general ->restore should handle any device state.

> > This device power state can in turn depend on the platform target state and this
> > latter state will be different in pm->freeze/PMSG_QUIESCE wrt.
> > pm->freeze/PMSG_FREEZE.
> >
> > A driver could also just use a fixed device power state in pm->freeze
> > independent of the platform target state. So I'm not saying
> > acpi_target_system_state() is incorrect, just wanted to understand the
> > logic behind it and how a driver can use it.
> 
> So really ->restore means no assumptions on the device state at all
> and the target platform state is S0 (or equivalent).
> 
> That's one of the reasons why ->restore is a special callback. :-)

Ok.

More background to my original question: ->freeze needs to choose a
device state and the logical one is the same state both for PMSG_FREEZE
and PMSG_QUIESCE, even if ->restore should be capable of handling a
different state. The handler I wrote for this in the i915 driver picks
different states atm, based on the target platform state. I want to
change that now so the same device state is selected. Based on all the
above it's clear now how to do that within the driver.

Thanks for the explanation,
Imre
