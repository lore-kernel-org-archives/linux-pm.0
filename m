From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / AVS: rockchip-io: make the log more consistent
Date: Mon, 14 Nov 2016 01:19:37 +0100
Message-ID: <1828121.EAG4WFMlqn@vostro.rjw.lan>
References: <1476103462-7559-1-git-send-email-shawn.lin@rock-chips.com> <1883054.D2Rm2X9N2G@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59591 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751564AbcKNAME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:12:04 -0500
In-Reply-To: <1883054.D2Rm2X9N2G@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Monday, October 10, 2016 10:15:50 PM Heiko Stuebner wrote:
> Am Montag, 10. Oktober 2016, 20:44:22 CEST schrieb Shawn Lin:
> > When testing SD hotplug automatically, I got bunch of
> > useless log like this:
> > 
> > [  588.357838] mmc0: card 0007 removed
> > [  589.492664] rockchip-iodomain ff770000.syscon:io-domains: Setting to
> > 3300000 done [  589.500698] vccio_sd: ramp_delay not set
> > [  589.504817] rockchip-iodomain ff770000.syscon:io-domains: Setting to
> > 3300000 done [  589.669705] rockchip-iodomain ff770000.syscon:io-domains:
> > Setting to 3300000 done [  589.677593] vccio_sd: ramp_delay not set
> > [  589.681581] rockchip-iodomain ff770000.syscon:io-domains: Setting to
> > 1800000 done [  590.032820] dwmmc_rockchip ff0c0000.dwmmc: Successfully
> > tuned phase to 140 [  590.039725] mmc0: new ultra high speed SDR50 SDHC
> > card at address 0007 [  590.046641] mmcblk0: mmc0:0007 SD32G 29.3 GiB
> > [  590.052163]  mmcblk0: p1
> > 
> > Moreover the code is intent to print the 'uV' for debug but
> > later print it using dev_info. It looks more like to me that
> > it should be the real intention of the code. Anyway, let's
> > mark this verbose log as debug message.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> reducing the amount of logs, especially for information not generally needed 
> looks sane
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> > ---
> > 
> >  drivers/power/avs/rockchip-io-domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/avs/rockchip-io-domain.c
> > b/drivers/power/avs/rockchip-io-domain.c index 01b6d3f..56bce19 100644
> > --- a/drivers/power/avs/rockchip-io-domain.c
> > +++ b/drivers/power/avs/rockchip-io-domain.c
> > @@ -143,7 +143,7 @@ static int rockchip_iodomain_notify(struct
> > notifier_block *nb, if (ret && event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
> >  		return NOTIFY_BAD;
> > 
> > -	dev_info(supply->iod->dev, "Setting to %d done\n", uV);
> > +	dev_dbg(supply->iod->dev, "Setting to %d done\n", uV);
> >  	return NOTIFY_OK;
> >  }
> 

Applied (for v4.10).

Thanks,
Rafael

