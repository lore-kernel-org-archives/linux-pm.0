From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 6/7] ARM: mvebu: update mvebu_v7_defconfig with
 cpufreq support
Date: Wed, 16 Jul 2014 08:52:32 -0400
Message-ID: <20140716125232.GX13108@titan.lakedaemon.net>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-7-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54306 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaGPMwn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 08:52:43 -0400
Content-Disposition: inline
In-Reply-To: <1404920715-19834-7-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Wed, Jul 09, 2014 at 05:45:14PM +0200, Thomas Petazzoni wrote:
> Now that the Armada XP supports dynamic CPU frequency scaling, it
> makes sense to enable the cpufreq subsystem in mvebu_v7_defconfig, as
> well as the cpufreq-generic driver used on Armada XP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
