From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 2/5] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Wed, 25 May 2016 17:47:04 +0100
Message-ID: <20160525164704.GC11807@e104805>
References: <1464148069-26254-1-git-send-email-wxt@rock-chips.com>
 <1464148069-26254-3-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36185 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbcEYQrJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 May 2016 12:47:09 -0400
Content-Disposition: inline
In-Reply-To: <1464148069-26254-3-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

Hi Caesar,

On Wed, May 25, 2016 at 11:47:46AM +0800, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> This patch implemnets .set_trips for device tree thermal zones.
             ^
             implements

> As the hardware-tracked trip points is supported by thermal core patch[0].
> 
> patch[0]
> "thermal: Add support for hardware-tracked trip points".
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>

Other than that, it looks good to me.  You can add my

Reviewed-by: Javi Merino <javi.merino@arm.com>
