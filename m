From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] PM / Domains: Keep the pd status during system PM
 phases
Date: Fri, 20 Jan 2017 09:38:46 +0100
Message-ID: <20170120083846.GB29509@kroah.com>
References: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: xf@rock-chips.com, heiko@sntech.de, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, huangtao@rock-chips.com, xxx@rock-chips.com, wxt@rock-chips.com, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 20, 2017 at 10:21:33AM +0800, Elaine Zhang wrote:
> If a PM domain is powered off before system suspend,
> we hope do nothing in system runtime suspend noirq phase
> and system runtime resume noirq phase.
> 
> This modify is to slove system resume issue for RK3399.
> RK3399 SOC pd_gpu have voltage domain vdd_gpu,
> so we must follow open vdd_gpu and power on pd_gpu,
> power off pd_gpu and disable vdd_gpu.
> Fix up in runtime resume noirq phase power on all PDs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/base/power/domain.c | 10 +++++++---
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)

What changed from v1?  You always have to list that below the --- line.

thanks,

greg k-h
