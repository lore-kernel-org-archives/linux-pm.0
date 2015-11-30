From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: rcar: add .set_trip_temp support
Date: Mon, 30 Nov 2015 10:51:00 -0800
Message-ID: <20151130185058.GA5900@localhost.localdomain>
References: <87a8q28wsv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34606 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbK3SvE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 13:51:04 -0500
Content-Disposition: inline
In-Reply-To: <87a8q28wsv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, linux-kernel@vger.kernel.org, "osd2@lm.renesas.com" <osd2@lm.renesas.com>

On Wed, Nov 25, 2015 at 05:42:27AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> You can set trip temp if your kernel has CONFIG_THERMAL_WRITABLE_TRIPS
> 
> echo $temp > /sys/class/thermal/thermal_zone0/trip_point_0_temp
> 
> -45000 < $temp < 125000 is supported
> Default is 90000
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   This patch is v2 of "[PATCH] thermal: rcar: enable to set tripN-temp via DT"
>   I think it will be full-DT feature if it uses of-thermal, but this driver is used
>   from non-DT SoC too. We would like to keep non-DT support.
>   And we would like to do is only exchange trip temp.
>   .set_trip_temp is very enouth for it at this point.
>   But, it can use of-thermal feature in the future.

Kuninori,


According to discussion on your first version [1], this patch is not needed
anymore, right?

If you want to add the support for writable trip points, please, add the
support to of-thermal, as this driver supports only DT booting boards.


[1] - https://lkml.org/lkml/2015/11/25/888
> 
