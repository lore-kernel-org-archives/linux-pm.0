From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs
 for thermal driver.
Date: Thu, 17 Dec 2015 12:09:28 -0800
Message-ID: <20151217200927.GC7999@localhost.localdomain>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35067 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbbLQUJc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 15:09:32 -0500
Content-Disposition: inline
In-Reply-To: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: huangtao@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, dmitry.torokhov@gmail.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, computersforpeace@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Kosina <trivial@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org

Hello,

On Thu, Dec 03, 2015 at 04:48:38PM +0800, Caesar Wang wrote:
> This series pacthes to support the next soc for this thermal driver.
> I don't add the dts thermal data since these SoCs have *_not_* land
> in this mainline. I believe these SoCs dts will land in this mainline
> lately,
> then I will add the thermal data for Heiko.
> 
> This series patches can apply into Eduardo branch.
> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git
> 
> Also, this series pacthes have built on github branch.
> https://github.com/rockchip-linux/kernel/commits/develop4.4
> 
> PATCH[1/5]:
> That's bit ugly typo, sorry for sending again :(.
> 
> PATCH[2/5]:
> To fix a build warning came from Dan Carpenter report smatch check,
> Thanks. :)
> 
> PATCH[3/5]:
> Add the rk3228/rk3399 SoCs compatible for dt-bindings.
> 
> PATCH[4/5]:
> Add the rk3228 SoCs for thermal driver.
> 
> PATCH[5/5]:
> Add the rk3399 SoCs for thermal driver based on PATCH[4/5].

I applied all but 2/5.

