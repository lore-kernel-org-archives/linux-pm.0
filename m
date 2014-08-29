From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv5 4/4] thermal: exynos: Remove duplicate code when
 reading triminfo register of Exynos5440
Date: Fri, 29 Aug 2014 15:28:20 -0400
Message-ID: <20140829192818.GB23645@developer>
References: <1409016665-3824-1-git-send-email-cw00.choi@samsung.com>
 <1409016665-3824-5-git-send-email-cw00.choi@samsung.com>
 <53FEAF2A.1080400@samsung.com>
 <20140828145310.GC18194@developer>
 <53FFC051.7040907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53FFC051.7040907@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: eduardo.valentin@ti.com, amit.daniel@samsung.com, rui.zhang@intel.com, kgene.kim@samsung.com, ch.naveen@samsung.com, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Chanwoo,

On Fri, Aug 29, 2014 at 08:50:41AM +0900, Chanwoo Choi wrote:
> Dear Eduardo,
> 
> On 08/28/2014 11:53 PM, Eduardo Valentin wrote:
> > On Thu, Aug 28, 2014 at 01:25:14PM +0900, Chanwoo Choi wrote:
> >> Dear Eduardo,
> >>
> >> This patch is wrong. It is my mistake.
> >>
> >> Please ignore only this patch because
> >> the offset calculation of 'case 0' is different from 'case 2'.
> > 
> > 
> > Do patches 1 - 3 are still correct? Patch 1, from Barlomiej, seams to be
> > a common agreement. 

> 
> Yes, patches 1 - 3 are correct.
> 

OK. I pulled patch 01 into my next branch.

Can you please update patches 02 and 03 based on my next brach? They are
conflicting with the massive cleanups done by Bartlomiej (Thanks
Bartlomiej). So, please, resend patches 02 and 03 only, refreshed onto
my next branch.

Cheers.

> Best Regards,
> Chanwoo Choi
> 
> > 
> >>
> >> Best Regards,
> >> Chanwoo Choi
> >>
> >> On 08/26/2014 10:31 AM, Chanwoo Choi wrote:
> >>> This patch remove simply duplicate code when reading triminfo register of Exynos5440.
> >>>
> >>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> >>> Cc: Zhang Rui <rui.zhang@intel.com>
> >>> Cc: Eduardo Valentin <edubezval@gmail.com>
> >>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>> ---
> >>>  drivers/thermal/samsung/exynos_tmu.c | 4 +---
> >>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> >>> index 64c702a..5888467 100644
> >>> --- a/drivers/thermal/samsung/exynos_tmu.c
> >>> +++ b/drivers/thermal/samsung/exynos_tmu.c
> >>> @@ -187,15 +187,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >>>  		 */
> >>>  		switch (data->id) {
> >>>  		case 0:
> >>> +		case 2:
> >>>  			trim_info = readl(data->base +
> >>>  			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
> >>>  			break;
> >>>  		case 1:
> >>>  			trim_info = readl(data->base + reg->triminfo_data);
> >>>  			break;
> >>> -		case 2:
> >>> -			trim_info = readl(data->base -
> >>> -			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
> >>>  		}
> >>>  	} else {
> >>>  		/* On exynos5420 the triminfo register is in the shared space */
> >>>
> >>
> > 
> 
