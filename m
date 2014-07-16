From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
Date: Wed, 16 Jul 2014 15:28:38 +0200
Message-ID: <20140716152838.3a469cdb@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140713222223.GH13108@titan.lakedaemon.net>
	<20140716124522.GV13108@titan.lakedaemon.net>
	<20140716145905.33105756@free-electrons.com>
	<20140716131658.GB13108@titan.lakedaemon.net>
	<20140716151955.377efc5e@free-electrons.com>
	<20140716132720.GC13108@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34935 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932622AbaGPN2l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 09:28:41 -0400
In-Reply-To: <20140716132720.GC13108@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Dear Jason Cooper,

On Wed, 16 Jul 2014 09:27:20 -0400, Jason Cooper wrote:

> > > Ok, I've tentatively applied this series to mvebu/soc-cpuidle with a dep
> > > on mvebu/soc and mvebu/fixes.  It'll be in -next tonight.
> > 
> > Great, thanks a lot!
> 
> FYI - there's a rather intricate conflict in pmsu.c between cpuidle and
> cpufreq.

Yeah, doesn't surprise me. All those power management features are very
inter-related.

>  I'm currently build-testing my merge.  Once it passes, I'll
> push it up to for-next and I'd appreciate if you could give it a once
> over.  It'll be the HEAD of for-next.

Sure, I'll have a look, I'll even try to run test for-next on the
platforms.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
