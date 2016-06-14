From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Date: Tue, 14 Jun 2016 11:27:11 +0200
Message-ID: <20160614092711.GA22613@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <20160613205823.GA18747@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:58734 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcFNJXR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 05:23:17 -0400
Content-Disposition: inline
In-Reply-To: <20160613205823.GA18747@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>

Hi Bjorn,

On Mon, Jun 13, 2016 at 03:58:23PM -0500, Bjorn Helgaas wrote:
> On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> > This series powers Thunderbolt controllers on Macs down when nothing is
> > plugged in, saving 1.7 W on machines with a Light Ridge controller and
> > reportedly 4 W on Cactus Ridge 4C and Falcon Ridge 4C.
> I suppose these depend on Mika's runtime PM patches (at least, I see
> Mika's commits in your github tree).  Would you mind rebasing your
> patches so they apply on my pci/pm branch?  I couldn't import them
> directly into stg.

Right, patch [08/13] no longer applies cleanly because the context has
changed slightly ("100 ms" instead of "10 ms").

I've just sent out a rebased version of that patch in-reply-to the
original version. So if you use threading in mutt (or limit the
messages displayed to e.g. "~f lukas@wunner.de" and order by subject),
you should be able to tag the rebased version and pipe that together
with the rest to stg.

If this doesn't work out for some reason and you'd prefer me to resend
the whole series just shout.

Thanks!

Lukas
