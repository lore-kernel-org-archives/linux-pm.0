From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 12/13] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Wed, 19 Feb 2014 19:32:11 +0100
Message-ID: <20140219193211.10dd2f22@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-13-git-send-email-gregory.clement@free-electrons.com>
	<20140219175145.4b4fcba5@skate>
	<5304E7B7.3040206@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51691 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754395AbaBSScO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 13:32:14 -0500
In-Reply-To: <5304E7B7.3040206@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 19 Feb 2014 18:19:51 +0100, Gregory CLEMENT wrote:

> > Sorry to bring the naming issue, but it looks like the Armada 38x has a
> > PMSU that looks almost identical to the Armada XP PMSU, except that it
> > doesn't have the L2 fabric registers (probably because Armada 38x uses
> > the PL310 and not the Marvell L2 cache).
> > 
> > Therefore, should this cpuidle driver be named Armada 370/XP, or
> > ARMADA_MVEBU for example?
> 
> Well most of the code is related to the coherency and the L2 cache, so
> a different L2 cache is a significant difference. The CPU are also different
> for example the PJ4B can  use LDREX/STREX without MMU whereas the Cortex A9
> can't.

Right, ok.

> > Also, I'm a bit unsure about your choice of mixing C and assembly here.
> > This function is already calling ll_clear_cpu_coherent() and
> > ll_set_cpu_coherent() that are assembly functions implement in
> > coherency_ll.S. Shouldn't we do the same for this final bit of assembly?
> 
> I made several tries when I converted most of the code in C, so I am not
> sure but I think that using a C function didn't work here. But as Lorenzo
> pointed they were mistakes in this code, so once I will have fixed them, I
> will try again.

Having this is C would certainly be a lot better, but my comment was
merely to move this tiny bit of assembly somewhere else, but keep it as
assembly if it's really needed.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
