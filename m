From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 09/18] thermal: exynos: clear IRQs later in
 exynos4412_tmu_initialize()
Date: Mon, 30 Apr 2018 16:47:08 +0200
Message-ID: <20180430144708.GJ11457@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115221epcas2p29faeae4b9bd5eb023e9696e2c33c01e9@epcas2p2.samsung.com>
 <1524743493-28113-10-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524743493-28113-10-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Clear IRQs after enabling thermal tripping (it should make no
> difference in driver operation). This prepares the driver code
> to moving IRQs clearing call from ->tmu_initialize method to
> exynos_tmu_initialize().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
