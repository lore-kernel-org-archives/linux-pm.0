From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT infrastructure
Date: Mon, 15 Jul 2013 12:12:43 +0000 (UTC)
Message-ID: <loom.20130715T124843-388@post.gmane.org>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com> <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49346 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362Ab3GOMPF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jul 2013 08:15:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1UyhgF-0001lA-A6
	for linux-pm@vger.kernel.org; Mon, 15 Jul 2013 14:15:03 +0200
Received: from lysithea.ext.pengutronix.de ([92.198.50.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 14:15:03 +0200
Received: from l.stach by lysithea.ext.pengutronix.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 14:15:03 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi Eduardo and others,

Eduardo Valentin <eduardo.valentin <at> ti.com> writes:

> 
> This patch improves the ti-soc-thermal driver by adding the
> support to build the thermal zones based on DT nodes.
> 
> The driver will have two options now to build the thermal
> zones. The first option is the zones originally coded
> in this driver. So, the driver behavior will be same
> if there is no DT node describing the zones. The second
> option, when it is found a DT node with thermal data,
> will used the common infrastructure to build the thermal
> zone and bind its cooling devices.
> 
> In either case, this driver still adds to the system
> a cpufreq cooling device.
> 

I really like the idea to configure thermal zones using devicetree, it's a
step in the right direction. We might follow suit with the i.MX6 tempmon
driver to use this infrastructure.

What I strongly dislike is the notion of the sensor drivers instantiating
the cooling devices and the resulting devicetree binding. This seems really
backward to me.
I would rather see the drivers associated with the cooling devices (like
cpufreq and the respective gpu drivers) to instantiate the cooling devices
and the thermal zone referring to them through phandles. I think it
shouldn't be too much work to go in that direction.
The current method might be enough to work with the current thermal platform
drivers, but if you want to go down the route to eventually use plain i2c
devices (likely with an existing hwmon driver) you have to get away from the
sensor devices instantiating the cooling devices.

Regards,
Lucas

