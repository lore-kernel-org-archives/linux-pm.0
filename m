From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [FOR DISCUSSION 0/9] Dove PMU support
Date: Fri, 13 Mar 2015 13:47:19 +0100
Message-ID: <2953786.DBeOKcOQ8q@wuerfel>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk> <3456973.vXF9zkXSFZ@wuerfel> <20150313123211.GG8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62880 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbCMMro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 08:47:44 -0400
In-Reply-To: <20150313123211.GG8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Friday 13 March 2015 12:32:11 Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 01:26:17PM +0100, Arnd Bergmann wrote:
> > On Friday 13 March 2015 12:11:27 Russell King - ARM Linux wrote:
> > > Of course, I also have a patch which adds legacy support to
> > > arch/arm/mach-dove, but I've assumed you're not interested in that...
> > 
> > You mean legacy support in mach-mvebu?
> 
> No.
> 
> As you'll see, this uses a platform device notifier to hook the devices
> onto the appropriate PM domain, which is why the driver needs to be
> registered early.  This also gets used in DT mode with one legacy
> platform device which is dynamically registered (something which can't
> happen with DT.)

Ok, got it. I think that's fine too. If this helps you spend less
time on forward-porting your patches and in turn completing the
full dove support with DT faster, I'm all for merging this one too.

	Arnd
