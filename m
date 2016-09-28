From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4] devfreq_cooling: let the driver supply the dynamic
 power every time we need it
Date: Wed, 28 Sep 2016 09:26:39 +0800
Message-ID: <1475025999.4284.15.camel@intel.com>
References: <20160915144425.5443-1-lukasz.luba@arm.com>
         <7767c8d3-6ee7-427d-b709-0e98279e313a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755074AbcI1B3q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 21:29:46 -0400
In-Reply-To: <7767c8d3-6ee7-427d-b709-0e98279e313a@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: javi.merino@arm.com, orjan.eide@arm.com

On 二, 2016-09-27 at 15:43 +0100, Lukasz Luba wrote:
> Hello Eduardo, Rui,
> 
> I just want to ask you about your concerns regarding this patch set.
> What do you think about it? Is there any chance to merge it?
> 
It's 4.8-rc8 now, thus it's too late for this patch set to be included
in this merge window. Will review it after merge windows closed. :)

thanks,
rui

> Regards,
> Lukasz
> 
> On 15/09/16 15:44, Lukasz Luba wrote:
> > 
> > Hello,
> > 
> > This patchset introduces a new interface for devfreq cooling in
> > thermal
> > framework. I am resending it without the RFC tag.
> > It supports direct call to driver's functions registered as
> > 'get_dynamic_power' and 'power2state'.
> > 
> > 
> > The current implementation in the thermal devfreq cooling subsystem
> > uses
> > precalculated power table for each device to make a decision about
> > allowed
> > running state. When the driver registers itself to the thermal
> > devfreq cooling
> > subsystem, the framework creates the power table. The table is then
> > used by the
> > thermal subsystem to keep the device in the thermal envelope. The
> > current
> > implementation uses a fixed assumption of the complexity of the
> > logic in the
> > cooling_device and assumes power consumption varies directly in
> > proportion to
> > the frequency/voltage
> > 
> > The proposed implementation provides the possibility to register a
> > driver to
> > thermal devfreq cooling subsystem and use the driver's code during
> > the
> > calculation of the power in runtime. You can still use
> > precalculated power
> > table when the GET_DIRECT_DYNAMIC_POWER flag is not set (the new
> > extension can
> > co-exist with the current implementation).
> > 
> > This idea meets the expectations of the devices which know better
> > the power
> > they consume (and the power is not strictly related to OPP table
> > entries
> > (frequency, voltage) (i.e. some parts/features of the device can be
> > unused)).
> > 
> > The first patch is just for fixing some compiler warnings.  The
> > second patch is
> > the same as the one sent already to the linux-pm list which adds
> > passing the
> > devfreq pointer to the driver functions
> > 'get_static|dynamic_power'.  The third
> > one implements the main change in the devfreq cooling
> > subsystem.  The last one
> > is a simple fix for an unnecessary check.
> > 
> > Best Regards,
> > Lukasz Luba
> > 
> > Javi Merino (1):
> >   devfreq_cooling: pass a pointer to devfreq in the power model
> >     callbacks
> > 
> > Lukasz Luba (3):
> >   devfreq_cooling: make the structs devfreq_cooling_xxx visible for
> > all
> >   devfreq_cooling: let the driver supply the dynamic power every
> > time we
> >     need it
> >   devfreq_cooling: fix unnecessary check of unsigned long value
> > 
> >  drivers/thermal/devfreq_cooling.c | 193
> > +++++++++++++++++++++++++++-----------
> >  include/linux/devfreq_cooling.h   |  34 +++++--
> >  2 files changed, 165 insertions(+), 62 deletions(-)
> > 
