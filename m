From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH trivial] PM / Domains: Spelling s/domian/domain/
Date: Mon, 22 Sep 2014 16:04:52 +0200
Message-ID: <1514200.c92a0jFWZ0@vostro.rjw.lan>
References: <1410897579-28240-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410897579-28240-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 16, 2014 09:59:39 PM Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued up for 3.18, thanks!

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cf4651a15a5753e5..e6a11ca3ce2634ab 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1833,7 +1833,7 @@ int pm_genpd_name_detach_cpuidle(const char *name)
>  /* Default device callbacks for generic PM domains. */
>  
>  /**
> - * pm_genpd_default_save_state - Default "save device state" for PM domians.
> + * pm_genpd_default_save_state - Default "save device state" for PM domains.
>   * @dev: Device to handle.
>   */
>  static int pm_genpd_default_save_state(struct device *dev)
> @@ -1856,7 +1856,7 @@ static int pm_genpd_default_save_state(struct device *dev)
>  }
>  
>  /**
> - * pm_genpd_default_restore_state - Default PM domians "restore device state".
> + * pm_genpd_default_restore_state - Default PM domains "restore device state".
>   * @dev: Device to handle.
>   */
>  static int pm_genpd_default_restore_state(struct device *dev)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
