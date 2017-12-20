From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/3] phy: core: Move runtime PM reference counting to the
 parent device
Date: Wed, 20 Dec 2017 12:12:42 +0530
Message-ID: <ced99cd1-d52c-ea76-332d-6c0492f256a8@ti.com>
References: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
 <1513718551-28624-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513718551-28624-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Wednesday 20 December 2017 02:52 AM, Ulf Hansson wrote:
> The runtime PM deployment in the phy core is a bit unnecessary complicated
> and the main reason is because it operates on the phy device, which is
> created by the phy core and assigned as a child device of the phy provider
> device.
> 
> Let's simplify the code, by replacing the existing calls to
> phy_pm_runtime_get_sync() and phy_pm_runtime_put(), with regular calls to
> pm_runtime_get_sync() and pm_runtime_put(). While doing that, let's also
> change to give the phy provider device as the parameter to the runtime PM
> calls. This together with adding error paths, that allows the phy
> provider device to be runtime PM disabled, enables further clean up the
> code. More precisely, we can simply avoid to enable runtime PM for the phy
> device altogether, so let's do that as well.
> 
> More importantly, this change also fixes an issue for system suspend.
> Especially in those cases when the phy provider device gets put into a low
> power state via calling the pm_runtime_force_suspend() helper, as is the
> case for a Renesas SoC, which has the phy provider device attached to the
> generic PM domain.
> 
> The problem in this case, is that pm_runtime_force_suspend() expects the
> child device of the provider device to be runtime suspended, else this will
> trigger a WARN splat (correctly) when runtime PM gets re-enabled at system
> resume.
> 
> In the current case, even if phy_power_off() triggers a pm_runtime_put()
> during system suspend the phy device (child) doesn't get runtime suspended,
> because that is prevented in the system suspend phases. However, by
> avoiding to enable runtime PM, this problem goes away.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/phy/phy-core.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index b4964b0..9fa3f13 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -222,10 +222,10 @@ int phy_init(struct phy *phy)
>  	if (!phy)
>  		return 0;
>  
> -	ret = phy_pm_runtime_get_sync(phy);
> -	if (ret < 0 && ret != -ENOTSUPP)
> +	ret = pm_runtime_get_sync(phy->dev.parent);

Won't this make phy-core manage pm_runtime of phy_provider even though the
phy_provider might not intend it?

Thanks
Kishon
