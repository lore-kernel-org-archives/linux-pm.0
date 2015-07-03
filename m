From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 2/4] ARM: mvebu: Add standby support
Date: Fri, 3 Jul 2015 14:17:16 +0200
Message-ID: <20150703141716.785a27c5@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
	<1435684740-24912-3-git-send-email-gregory.clement@free-electrons.com>
	<20150701174709.2d55007d@free-electrons.com>
	<55967485.2010607@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35322 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755116AbbGCMR0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 08:17:26 -0400
In-Reply-To: <55967485.2010607@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Gregory,

On Fri, 03 Jul 2015 13:39:49 +0200, Gregory CLEMENT wrote:

> Having 2 initcall does not work because, there is a dependency between these
> 2 calls. And actually the suspend_ops is registered before the board specific
> hook. As soon as the suspend_ops is registered, mvebu_pm_valid() is called but
> at this point mvebu_board_pm_enter is NULL so PM_SUSPEND_MEM is not available.

And? It will become available soon afterwards.

> All the complexity of the original patch was to allow registering a handler
> without needed to get the resource(gpio device) that are not available when using
> arch_initcall(). However the device_initcall_sync comes latter enough to
> get all the devices registered but it still happens before the late_initcall,
> so I will use this one and I will add a comment around it.

I don't think we care about the order in which the initcalls are called.

If the SoC level init call registering the suspend_ops gets called
first, then at the beginning there is only support for standby. The
support for suspend to RAM will be enabled once the board-level init
call gets called.

If the board level init call is called first, then it will set
mvebu_board_pm_enter. It is not useful at this point. Until the SoC
level init call registers the suspend_ops.

I believe that the ->valid() method of suspend_ops gets called when the
user actually enters the suspend state by writing to /sys/power/state.
And by that time, both init calls will have been called.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
