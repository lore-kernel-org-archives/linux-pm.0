From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 08/16] thermal: mvebu: Fix temperature output formula
 for kirkwood
Date: Thu, 21 Mar 2013 10:41:17 -0400
Message-ID: <20130321144117.GW13280@titan.lakedaemon.net>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:57310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932834Ab3CUOl0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 10:41:26 -0400
Content-Disposition: inline
In-Reply-To: <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Wed, Mar 20, 2013 at 07:36:29PM -0300, Ezequiel Garcia wrote:
> The temperature formula was taken from the Armada 510 datasheet.
> This is wrong because the Kirkwood SoC thermal sensor has
> different coefficients.
> 
> Fix it using values from 88F682/88F683 Kirkwood datasheet.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/mvebu_thermal.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)

This is also a fix which should go at the beginning of the series.

thx,

Jason.
