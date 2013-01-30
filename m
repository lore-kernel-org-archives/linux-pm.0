From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Wed, 30 Jan 2013 21:49:41 +0800
Message-ID: <20130130134939.GE2757@S2101-09.ap.freescale.net>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
 <331ABD5ECB02734CA317220B2BBEABC13EAF880F@DBDE01.ent.ti.com>
 <2871120.foIQeGmlHR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:17798
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753674Ab3A3NuE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 08:50:04 -0500
Content-Disposition: inline
In-Reply-To: <2871120.foIQeGmlHR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Jan 30, 2013 at 02:40:35PM +0100, Rafael J. Wysocki wrote:
> > > Mark, AnilKumar,
> > > 
> > > I only compile-tested it on highbank and omap2.  Please give it a test
> > > no hardware to make sure cpufreq-cpu0 still works for you.  Thanks.
> > 
> > Hi Shawn,
> > 
> > I hope this is based on linux-omap/master, to test the driver I have
> > to add some patches on top of this patch, because of recent changes.
> > I will provide the test details once I am done.
> 
> Shawn, does it mean I need to wait with applying the patch or will OMAP2
> work as is?
> 
I would expect that omap2/am33xx should work as it is, but I do not
have hardware to confirm that.

Also as the patch touches a few files in arch/arm/mach-omap2, we may
need an ACK from Tony.

Actually, I prefer to move omap2 bits into a separate patch and have
it go via omap tree to avoid the possible conflict with cpufreq and
arm-soc tree.  What do you say?  If you agree, I will re-iterate the
patch to do so.

Shawn

