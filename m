From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
Date: Wed, 16 Apr 2014 19:08:54 +0200
Message-ID: <20140416190854.52e2a4bb@skate>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
	<534EA8C9.7010907@gmail.com>
	<20140416180315.5153c3f7@skate>
	<20140416160824.GA14842@lunn.ch>
	<20140416181938.6e8f8f4b@skate>
	<20140416163447.GB14842@lunn.ch>
	<20140416165548.GI28159@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50559 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbaDPRI6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 13:08:58 -0400
In-Reply-To: <20140416165548.GI28159@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

Dear Jason Cooper,

On Wed, 16 Apr 2014 12:55:48 -0400, Jason Cooper wrote:

> > Sounds like a good plan. Try to keep all the mess to support Z1 in one
> > place so that it can be easily taken out once people have A0.
> 
> Agreed.  Thomas, do you think you'll be able to get a definitive answer
> from Marvell re the number of Z1 boards in the wild?  Once they've moved
> to the A0, of course.

My understanding is that Marvell has never been interested in having
mainline support for the Z1 stepping. It just happens to be a necessary
step to make progress with the general goal of supporting 375 in
mainline, but I don't expect Marvell to be interested in supporting the
Z1 boards in the wild.

> Unless we can get a hard answer on that, I doubt we'll ever withdraw
> support for the Z1.  Not that that's a bad thing, just trying to be
> realistic.  If we add code, expect to support it.

Yes, indeed.

> And keeping it all in one place is kind of an impossibility.  Just for
> thermal Z1, there are changes to the binding docs, the thermal driver,
> and the soc code.
> 
> I'd say it's more important to keep it clean, with dts files targeting
> the A0+ SoCs, and the Z1 being the exception case(s).

That's what we've tried to do so far: the thermal driver works for the
A0+ by default, and only as an exception supports Z1.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
