From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/8 v4] enable to use thermal-zone on r8a7790/1
Date: Thu, 10 Dec 2015 13:57:49 +0900
Message-ID: <20151210045745.GD6964@verge.net.au>
References: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:53665 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbLJE5w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 23:57:52 -0500
Content-Disposition: inline
In-Reply-To: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Dec 08, 2015 at 05:26:20AM +0000, Kuninori Morimoto wrote:
> 
> Hi
> 
> These are v4 of thermal-zone support for r8a7790/r8a7791.
> Mainly, it cares return value of get_temp()
> 
> I think 8) is needed on of-thermal (?)
> 
> Kuninori Morimoto (8):
>       1) thermal: rcar: move rcar_thermal_dt_ids to upside
>       2) thermal: rcar: check every rcar_thermal_update_temp() return value
>       3) thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
>       4) thermal: rcar: retern error rcar_thermal_get_temp() if no ctemp update
>       5) thermal: rcar: enable to use thermal-zone on DT
>       6) ARM: shmobile: r8a7790: enable to use thermal-zone
>       7) ARM: shmobile: r8a7791: enable to use thermal-zone
>       8) thermal: of-thermal: of_thermal_set_trip_temp() call thermal_zone_device_update()
> 

I have marked patches 6 and 7 as deferred pending acceptance of the driver
changes.
