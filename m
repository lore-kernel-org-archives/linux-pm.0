From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 50/61] thermal: simplify getting .drvdata
Date: Wed, 2 May 2018 16:52:22 +0800
Message-ID: <20180502085221.GH3443@dragon>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 19, 2018 at 04:06:20PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/thermal/rockchip_thermal.c | 8 +++-----
>  drivers/thermal/spear_thermal.c    | 8 +++-----
>  drivers/thermal/zx2967_thermal.c   | 6 ++----
>  3 files changed, 8 insertions(+), 14 deletions(-)

For zx2967_thermal,

Acked-by: Shawn Guo <shawnguo@kernel.org>
