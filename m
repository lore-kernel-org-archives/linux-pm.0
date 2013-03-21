From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 00/16] Marvell EBU thermal sensor consolidation
Date: Thu, 21 Mar 2013 07:45:01 +0100
Message-ID: <20130321064501.GK21478@lunn.ch>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49850 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3CUGpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 02:45:11 -0400
Content-Disposition: inline
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Wed, Mar 20, 2013 at 07:36:21PM -0300, Ezequiel Garcia wrote:
> This patchset is my first attempt at adding basic thermal sensor
> support on Armada 370 and Armada XP.
> 
> Given Armada 370/XP and the other Marvell SoC with thermal support,
> namely Kirkwood and Dove, have fairly similar thermal devices it 
> made sense to integrate all of them into a single driver: mvebu-thermal.

Hi Ezequiel

I went this way to start with, merging Dove, Kirkwood and something
which nearly worked for 370. But then i looked at the code, at how
little is actually shared, and went back to separate drivers.

Kirkwood has no control registers, so needs a special case in the probe.
The bit location of the temperate value moves around in the register.
Each SoC needs its own initialization sequence.
Each SoC needs its own is_valid() function.
Each Soc needs its own formula to convert to milli centigrad.

I've never seen the datasheets for 370/XP, just a list of registers for
370. But i get the impression it has two temperate sensors, so should
export two values?

Also, kirkwood will never be built into the same kernel as
Dove/370/XP.  So we end up with "bloat" in the driver, or at least a
collection of #ifdefs.

In the end, i decided it was simpler and cleaner to just have separate
drivers. This is something which we should think about and discuss.

	 Andrew
