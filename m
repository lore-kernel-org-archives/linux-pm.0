From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH V4 1/3] Thermal: initialize thermal zone device correctly
Date: Thu, 9 Apr 2015 15:44:23 +0100
Message-ID: <20150409144423.GA27702@e104805>
References: <1428373476-14257-1-git-send-email-rui.zhang@intel.com>
 <1428373476-14257-2-git-send-email-rui.zhang@intel.com>
 <20150407024709.GI4648@localhost.localdomain>
 <744357E9AAD1214791ACBA4B0B909263014CF6E2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:23390 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805AbbDIOo0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Apr 2015 10:44:26 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263014CF6E2@SHSMSX101.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Apr 08, 2015 at 02:01:08PM +0100, Zhang, Rui wrote:
> 
> 
> > -----Original Message-----
> > From: Eduardo Valentin [mailto:edubezval@gmail.com]
> > Sent: Tuesday, April 7, 2015 10:47 AM
> > To: Zhang, Rui
> > Cc: linux-pm@vger.kernel.org
> > Subject: Re: [PATCH V4 1/3] Thermal: initialize thermal zone device correctly
> > Importance: High
> > 
> > On Tue, Apr 07, 2015 at 10:24:34AM +0800, Zhang Rui wrote:
> > > After thermal zone device registered, as we have not read any
> > > temperature before, thus tz->temperature should not be 0, which
> > > actually means 0C, and thermal trend is not available.
> > > In this case, we need specially handling for the first
> > > thermal_zone_device_update().
> > >
> > > Both thermal core framework and step_wise governor is enhanced to handle
> > this.
> > >
> > > CC: <stable@vger.kernel.org> #3.18+
> > > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > > Tested-by: prash <prash.n.rao@gmail.com>
> > > Tested-by: amish <ammdispose-arch@yahoo.com>
> > > Tested-by: Matthias <morpheusxyz123@yahoo.de>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > 
> > Can you please consider the comments I made on V3?
> > 
> Sorry, I missed your previous comment.
> 
> > Summary:
> > 
> > 1. Change initialized to trend_valid
> 
> I don't think it is proper to call it "trend_valid" because in the case that cooling device
> is registered after thermal zone (the problem pointed out in patch 3/3),
> the new created thermal_instance needs to be set properly, and the trend is valid
> at this time actually.
> 
> IMO, thermal_instance->initialized just means if the thermal instance is evaluated for
> the first time or not, and if yes, we need some special handling.

I think the main source of confusion here is the fact that this is
only needed for step_wise.  Thermal governors that don't care about
trend will always have thermal instances with "initialized" being
false, which seems counter-intuitive.  The only name I can think of is
"not_yet_evaluated_by_step_wise" which is ridiculously long name for a
variable, but can we get something more descriptive than
"initialized"?

Cheers,
Javi

