From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
Date: Sun, 12 Jan 2014 12:47:17 +0100
Message-ID: <20140112114717.GA31318@amd.pavel.ucw.cz>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat 2014-01-11 20:42:43, Tomasz Figa wrote:
> This patch removes name field from private s3c64xx_pm_domain struct and
> moves domain name to dedicated field of generic_pm_domain struct.
> 
> When at it, beautify the names a bit, since they are used by genpd core
> as message prefixes.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/pm.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
> index 8cdb824..5238d66 100644
> --- a/arch/arm/mach-s3c64xx/pm.c
> +++ b/arch/arm/mach-s3c64xx/pm.c
> @@ -35,7 +35,6 @@
>  #include "regs-syscon-power.h"
>  
>  struct s3c64xx_pm_domain {
> -	char *const name;
>  	u32 ena;
>  	u32 pwr_stat;
>  	struct generic_pm_domain pd;
> @@ -76,7 +75,7 @@ static int s3c64xx_pd_on(struct generic_pm_domain *domain)
>  		} while (retry--);
>  
>  		if (!retry) {
> -			pr_err("Failed to start domain %s\n", pd->name);
> +			pr_err("Failed to start domain %s\n", pd->pd.name);
>  			return -EBUSY;
>  		}


So you changed text "failed to start domain I" to "failed to start
domain domain_i". Not sure that's an improvement...?

Could we get some more descriptive names for the domains?



>  static struct s3c64xx_pm_domain s3c64xx_pm_i = {
> -	.name = "I",
>  	.ena = S3C64XX_NORMALCFG_DOMAIN_I_ON,
>  	.pwr_stat = S3C64XX_BLKPWRSTAT_I,
>  	.pd = {
> +		.name = "domain_i",
>  		.power_off = s3c64xx_pd_off,
>  		.power_on = s3c64xx_pd_on,
>  	},
>  };

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
