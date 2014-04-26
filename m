From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v7 00/11]  CPU idle for Armada XP
Date: Fri, 25 Apr 2014 20:17:36 -0400
Message-ID: <20140426001736.GI28159@titan.lakedaemon.net>
References: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14878 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126AbaDZARw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 20:17:52 -0400
Content-Disposition: inline
In-Reply-To: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Mon, Apr 14, 2014 at 05:10:03PM +0200, Gregory CLEMENT wrote:
> This patch set adds the CPU idle support for Armada XP and prepares
> the support for Armada 370. This was based on the work of Nadav
> Haklai.
> 
> The main change in this new version is a rebasing onto the v3.15-rc1
> and the last PMSU reworked series sent by Thomas Petazzoni:
> http://www.spinics.net/lists/arm-kernel/msg322113.html
> 
> The first patch should go through ARM subsystem and should be taken by
> Russell King. It was alreadu submitted to Russell's patch system.
> 
> All the other patches can go to mvebu subsystem (and then arm-soc), as
> the PM related patches have received the acked-by from Daniel
> Lezcano. From my point of view this series is ready to be pulled.
> 
> The whole series (and the pmsu patches needed) is also available in
> the branch CPU-idle-ArmadaXP-v7 at
> https://github.com/MISL-EBU-System-SW/mainline-public.git

Whole series, except patch #1, applied to mvebu/soc-cpuidle.

I made one change as I noted in my other reply to the individual patch.
Thomas, please check that it still works for you.

It compiles cleanly, so absolutely nothing can go wrong with it. :)

thx,

Jason.
