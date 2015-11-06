From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 0/9] Better compatible for the rockchip thermal and
 support RK3368 SoCs
Date: Fri, 6 Nov 2015 10:47:40 -0800
Message-ID: <20151106184739.GA8202@localhost.localdomain>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32977 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbKFSro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 13:47:44 -0500
Content-Disposition: inline
In-Reply-To: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Caesar,

On Thu, Nov 05, 2015 at 01:17:56PM +0800, Caesar Wang wrote:
> This series patchs are working for RK3368 on Rockchip platform.
> 

Good to see the perseverance! :-)

> @Heiko,
>     The PATCH [5/6] is working based on big/littel cluster cpufreq
>     added. Anyway, the PATCH [5/6] also work for next kernel.
> 
> @Eduardo,
> This patchset are based on linus master branch.
> Note: Need add the following thermal patchs for thermal driver before apply
> this series patchs.
> 
> 1) thermal: rockchip: fix handling of invalid readings
> (https://patchwork.kernel.org/patch/6973101/)
> 
> 2) thermal: rockhip: fix setting thermal shutdown polarity
> (https://patchwork.kernel.org/patch/6973131/)
> 
> 3) dt-bindings: rockchip-thermal: Add the pinctrl states in this document
> (https://patchwork.kernel.org/patch/7472021/)
> 
> 4) thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
> (https://patchwork.kernel.org/patch/7472051/)
> 
> I'm glad these patchs have merged in thermal-soc git tree which can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git

Yeah, apologize the delay on giving you a feedback on your code. As I
mentioned before, I had a couple of other things in past weeks that
consumed my time. 

Anyways, this specific patch series looks way better now that you have
split it further. I will have a better look on it again and let you
know when it will land.

BR,

Eduardo Valentin

