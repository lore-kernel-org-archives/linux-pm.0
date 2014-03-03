From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/2] thermal: rcar-thermal: minor fixes
Date: Mon, 03 Mar 2014 22:51:30 +0800
Message-ID: <1393858290.2193.28.camel@rzhang1-mobl4>
References: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
	 <87fvn0xioy.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47255 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbaCCOvw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Mar 2014 09:51:52 -0500
In-Reply-To: <87fvn0xioy.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Patrick Titiano <ptitiano@baylibre.com>, magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org

On Sun, 2014-03-02 at 15:52 -0800, Kuninori Morimoto wrote:
> Hi
> 
> > Here are 2 minor updates to the rcar-thermal driver.
> > 
> > First patch removes an unecessary mask applied in a if statement.
> > Because the same mask was already applied in the preceding statement,
> > the second one can be removed.
> > 
> > Second patch avoids updating the thermal zone in case an IRQ was triggered but
> > the temperature didn't effectively change.
> > Note this is not a driver issue.
> > Below is a captured debug trace illustrating the purpose of this patch:
> > out of 8 thermal zone updates, only 2 are actually necessary.
> > 
> > [   41.120000] rcar_thermal_work(): cctemp=25000
> > [   41.120000] rcar_thermal_work(): new_ctemp=30000
> > [   41.120000] rcar_thermal_work(): temp is now 30000C, update thermal zone
> > [   58.990000] rcar_thermal_work(): cctemp=30000
> > [   58.990000] rcar_thermal_work(): nctemp=30000
> > [   58.990000] rcar_thermal_work(): same temp, do not update thermal zone
> > [   59.290000] rcar_thermal_work(): cctemp=30000
> > [   59.290000] rcar_thermal_work(): nctemp=30000
> > [   59.290000] rcar_thermal_work(): same temp, do not update thermal zone
> > [   59.590000] rcar_thermal_work(): cctemp=30000
> > [   59.590000] rcar_thermal_work(): nctemp=30000
> > [   59.590000] rcar_thermal_work(): same temp, do not update thermal zone
> > [   59.890000] rcar_thermal_work(): cctemp=30000
> > [   59.890000] rcar_thermal_work(): nctemp=30000
> > [   59.890000] rcar_thermal_work(): same temp, do not update thermal zone
> > [   60.190000] rcar_thermal_work(): cctemp=30000
> > [   60.190000] rcar_thermal_work(): nctemp=30000
> > [   60.190000] rcar_thermal_work(): same temp, do not update thermal zone
> > [   60.490000] rcar_thermal_work(): cctemp=30000
> > [   60.490000] rcar_thermal_work(): nctemp=30000
> > [   60.490000] rcar_thermal_work(): same temp, do not update thermal zone
> > [   60.790000] rcar_thermal_work(): cctemp=30000
> > [   60.790000] rcar_thermal_work(): nctemp=35000
> > [   60.790000] rcar_thermal_work(): temp is now 35000C, update thermal zone
> > 
> > I suspect this may be due to sensor sampling accuracy / fluctuation,
> > but no formal proof.
> > 
> > Patrick Titiano (2):
> >   thermal: rcar-thermal: fix same mask applied twice
> >   thermal: rcar-thermal: update thermal zone only when temperature
> >     changes
> > 
> >  drivers/thermal/rcar_thermal.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> For all patches
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
applied.

thanks,
rui
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


