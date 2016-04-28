From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/4] thermal: bang-bang governor: act on lower trip
 boundary
Date: Thu, 28 Apr 2016 08:30:18 +0200
Message-ID: <20160428063018.GX7860@pengutronix.de>
References: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
 <1461553367-24744-5-git-send-email-wxt@rock-chips.com>
 <20160427215425.GD6438@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38872 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751513AbcD1Gac (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 02:30:32 -0400
Content-Disposition: inline
In-Reply-To: <20160427215425.GD6438@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, eddie.cai@rock-chips.com, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 27, 2016 at 02:54:26PM -0700, Eduardo Valentin wrote:
> On Mon, Apr 25, 2016 at 11:02:47AM +0800, Caesar Wang wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > With interrupt driven thermal zones we pass the lower and upper
> > temperature on which shall be acted, so in the governor we have to act on
> > the exact lower temperature to be consistent. Otherwise an interrupt maybe
> > generated on the exact lower temperature, but the bang bang governor does
> > not react.
> 
> What is the expected impact on polling driven zones that use bang bang
> after this change?

Polling driven zones may have to be one step cooler before the governor
reacts, otherwise the behaviour should be unaffected.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
