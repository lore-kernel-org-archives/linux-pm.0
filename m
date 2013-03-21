From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal
 register
Date: Thu, 21 Mar 2013 10:35:39 -0400
Message-ID: <20130321143539.GV13280@titan.lakedaemon.net>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42329 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932834Ab3CUOfv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 10:35:51 -0400
Content-Disposition: inline
In-Reply-To: <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

Ezequiel,

On Wed, Mar 20, 2013 at 07:36:26PM -0300, Ezequiel Garcia wrote:
> The correct value is obtain by first shifting the register by the offset,
> later applying the valid mask and finally invert the result.
> This check was lacking an extra parenthesis to be strictly correct.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/mvebu_thermal.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

For the next version of this series, could you please put this fix first
in the series?  In this state, it can't be applied to v3.9-rcX, nor
-stable.

thx,

Jason.
