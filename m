From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 2/4] ARM: mvebu: Add standby support
Date: Fri, 3 Jul 2015 14:33:19 +0200
Message-ID: <20150703143319.1af14c99@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
	<1435684740-24912-3-git-send-email-gregory.clement@free-electrons.com>
	<20150701174709.2d55007d@free-electrons.com>
	<55967485.2010607@free-electrons.com>
	<20150703141716.785a27c5@free-electrons.com>
	<55967E35.8050002@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35617 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754931AbbGCMdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 08:33:22 -0400
In-Reply-To: <55967E35.8050002@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Fri, 03 Jul 2015 14:21:09 +0200, Gregory CLEMENT wrote:

> No it is called during boot and if the method is not there then it is no
> more available for the user. I made te test and with a cat on /sys/power/state
> I only got "freeze" and "standby" but not "mem".

Argh, indeed it's called by suspend_set_ops() itself.

So now, I wonder why the heck ->valid() is a function pointer in this
case, rather than just an argument passed to suspend_set_ops(). Having
a function pointer would precisely be useful to change at runtime which
states are available, and which states are not available. It is being
called again when actually entering the state, but apparently for no
useful reason.

Another option is to have ->valid() always say that suspend to RAM is
available, and just make ->enter() return -EINVAL if we're trying to
enter the PM_SUSPEND_MEM state and the mvebu_pm_board_enter pointer is
NULL. The only drawback is that the kernel will have done all its
suspend procedure (freezing processes, suspend devices) before telling
the user that it is not possible to enter suspend to RAM. But it's
probably not a big deal.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
