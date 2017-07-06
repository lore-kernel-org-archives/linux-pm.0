From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Thu, 6 Jul 2017 05:17:50 +0200
Message-ID: <20170706031750.GA12954@xo-6d-61-c0.localdomain>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <5864280.u6UQBsuXnA@aspire.rjw.lan>
 <20170715164626.GA1373@amd>
 <1529148.KHlxNOSRLV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33561 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdGPHdg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 03:33:36 -0400
Content-Disposition: inline
In-Reply-To: <1529148.KHlxNOSRLV@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Sun 2017-07-16 01:29:57, Rafael J. Wysocki wrote:
> On Saturday, July 15, 2017 06:46:26 PM Pavel Machek wrote:
> > Hi!
> > 
> > > > > I had an idea of using an enum type encompassing all of the power states
> > > > > defined for various platforms and serving both as a registry (to ensure the
> > > > > uniqueness of the values assigned to the states) and a common ground
> > > > > between platforms and drivers.
> > > > > 
> > > > > Something like:
> > > > > 
> > > > > enum platform_target_state {
> > > > > 	PLATFORM_STATE_UNKNOWN = -1,
> > > > > 	PLATFORM_STATE_WORKING = 0,
> > > > > 	PLATFORM_STATE_ACPI_S1,
> > > > > 	PLATFORM_STATE_ACPI_S2,
> > > > > 	PLATFORM_STATE_ACPI_S3,
> > > > > 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
> > > > > 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
> > > > > 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
> > > > > 	...
> > > > > };
> > > > > 
> > > > > and define ->target_state to return a value of this type.
> > > > > 
> > > > > Then, if a driver sees one of these and recognizes that value, it should
> > > > > know exactly what to do.
> > > > 
> > > > Remind me why this is good idea?
> > > 
> > > Because there are drivers that need to do specific things during
> > > suspend on a specific board when it goes into a specific state as a
> > > whole.
> > 
> > We have seen driver that cares about voltage to his device being
> > lost. That's reasonable.
> > 
> > Inquiring what the platform target state is... is not.
> 
> So why exactly isn't it reasonable?
> 
> Please use technical arguments.  Saying that something is wrong without
> explaining the problem you see with it isn't particulatly useful in technical
> discussions.

Deep in your heart, you should know that having enum listing all the platforms linux
runs on is a very bad idea.

Anyway, there are better solutions, regulator framework already knows if given rail
will be powered off or not, and their driver already knows if they are going
suspend/standby. They just need to use existing interfaces.

										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
