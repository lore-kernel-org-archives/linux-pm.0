From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
Date: Thu, 17 Jul 2014 00:18:38 +0200
Message-ID: <2328587.KMSy5tvnCr@vostro.rjw.lan>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com> <20140713222223.GH13108@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64933 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752645AbaGPWAW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 18:00:22 -0400
In-Reply-To: <20140713222223.GH13108@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Sunday, July 13, 2014 06:22:23 PM Jason Cooper wrote:
> Rafael, Daniel,
> 
> On Wed, Jul 09, 2014 at 03:40:04PM +0200, Thomas Petazzoni wrote:
> > Hello,
> > 
> > Here comes the second version of the cpuidle support for Armada 370
> > and Armada 38x. This series has been tested on the following
> > configurations:
> > 
> >  * Armada XP, LE and BE, to verify that the existing, SMP, cpuidle and
> >    CPU hotplug functionalities are still working.
> > 
> >  * Armada 375, Z1 and A0, LE and BE, to verify that the existing SMP
> >    functionality is still working (SMP support on Armada 375 Z1 is
> >    affected by this series).
> > 
> >  * Armada 370, LE and BE, to verify that the newly introduced cpuidle
> >    functionality is working fine.
> > 
> >  * Armada 38x, LE and BE, to verify that the existing SMP
> >    functionality, and the newly introduced cpuidle functionality is
> >    working fine.
> > 
> > We are hoping to see this patch series merged for 3.17.
> > 
> > Most patches are touching only arch/arm/mach-mvebu/ code so they
> > should be handled by the mvebu maintainers. However, patches 11-14 are
> > touching the mvebu cpuidle driver, with a possible issue on patch 11,
> > which touches both the cpuidle driver and the mach-mvebu code in order
> > to rename the driver without breaking functionality (if needed, we can
> > decide to split the commits, it would break functionality temporarly,
> > but not buildability).
> 
> Would one or both of you mind Acking this series so we can keep it
> together?

While I don't see anything obviously wrong in it, I'd like Daniel to look
at them too from the ARM perspective.

Rafael

