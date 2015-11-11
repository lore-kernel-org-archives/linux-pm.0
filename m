From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] thermal: rockchip: fix compile error
Date: Thu, 12 Nov 2015 09:06:58 +1100
Message-ID: <20151112090658.619c3b7c@canb.auug.org.au>
References: <1446990043-8096-1-git-send-email-wxt@rock-chips.com>
	<20151109193638.GB10824@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:53523 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbbKKWHB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Nov 2015 17:07:01 -0500
In-Reply-To: <20151109193638.GB10824@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, rui.zhang@intel.com, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, lkp@intel.com

Hi Eduardo,

On Mon, 9 Nov 2015 11:36:39 -0800 Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Sun, Nov 08, 2015 at 09:40:43PM +0800, Caesar Wang wrote:
> > Missing a include file caused compile error.
> > 
> > drivers/thermal/rockchip_thermal.c:
> > In function 'rockchip_thermal_suspend':
> > drivers/thermal/rockchip_thermal.c:720:2: error: implicit
> > declaration of function 'pinctrl_pm_select_sleep_state'
> > [-Werror=implicit-function-declaration]
> > pinctrl_pm_select_sleep_state(dev);
> >                  ^
> > drivers/thermal/rockchip_thermal.c:
> > In function 'rockchip_thermal_resume':
> > drivers/thermal/rockchip_thermal.c:759:2: error: implicit
> > declaration of function 'pinctrl_pm_select_default_state'
> > [-Werror=implicit-function-declaration]
> > ^pinctrl_pm_select_default_state(dev);
> > cc1: some warnings being treated as errors
> > 
> > Fixes: 7e38a5b1daa1 ("thermal: rockchip: support the sleep pinctrl state
> > to avoid glitches")  
> 
> 
> Adding this to my tree and sending to ruis too.

This missed the merge of the thermal tree into Linus' tree and so is
now needed in Linus' tree ASAP (several builds are failing).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
