From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 02/16] ARM: mvebu: Add a common function for the boot
 address work around
Date: Thu, 3 Jul 2014 09:16:18 +0200
Message-ID: <20140703091618.1e5408f0@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-3-git-send-email-gregory.clement@free-electrons.com>
	<20140630144054.2f71514b@free-electrons.com>
	<53B48E8E.1080808@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48185 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755376AbaGCHQc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 03:16:32 -0400
In-Reply-To: <53B48E8E.1080808@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Gregory,

On Thu, 03 Jul 2014 00:58:22 +0200, Gregory CLEMENT wrote:

> >> +#define CRYPT0_ENG_ATTR	0x1
> > 
> > For consistency, I'd prefer to see this being passed as argument to
> > mvebu_boot_addr_wa().
> 
> The attribute is the same, so why bother with it? If later we have a SoC
> where this attribute can be different then I agree to add this argument.

Simply for consistency. MBus windows are defined by their target and
attribute values, so it makes sense to always pass both these values,
even if for the existing cases the attribute is for now always 0x1.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
