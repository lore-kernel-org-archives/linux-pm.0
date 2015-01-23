From: Javi Merino <javi.merino@arm.com>
Subject: Re: [RFC PATCH v6 4/9] thermal: let governors have private data for
 each thermal zone
Date: Fri, 23 Jan 2015 14:33:13 +0000
Message-ID: <20150123143312.GA9064@e104805>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
 <1417806260-9264-5-git-send-email-javi.merino@arm.com>
 <1418011892.19126.20.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41842 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbAWOdV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 09:33:21 -0500
Content-Disposition: inline
In-Reply-To: <1418011892.19126.20.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi Rui,

On Mon, Dec 08, 2014 at 04:11:32AM +0000, Zhang Rui wrote:
> On Fri, 2014-12-05 at 19:04 +0000, Javi Merino wrote:
> > A governor may need to store its current state between calls to
> > throttle().  That state depends on the thermal zone, so store it as
> > private data in struct thermal_zone_device.
> > 
> > The governors may have two new ops: bind_to_tz() and unbind_from_tz().
> > When provided, these functions let governors do some initialization
> > and teardown when they are bound/unbound to a tz and possibly store that
> > information in the governor_data field of the struct
> > thermal_zone_device.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> 
> applied.
> 
> thanks,
> rui

Where can I find it?  Your next branch in git.kernel.org doesn't have
it.  I'm preparing an update of this series and I wanted to based it
on a branch that had this commit applied.  Cheers,
Javi
