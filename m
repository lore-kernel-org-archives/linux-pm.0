From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 2/2] soc: bcm: brcmstb: PM: Implement target_state callback
Date: Fri, 30 Jun 2017 01:04:35 +0200
Message-ID: <48358346.FqHa0fcY05@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net> <20170623010837.11199-1-f.fainelli@gmail.com> <20170623010837.11199-3-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170623010837.11199-3-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 22, 2017 06:08:37 PM Florian Fainelli wrote:
> Provide a target_state callback implementation which just returns the
> suspend_state_t the system is about to enter. Broadcom STB drivers can
> utilize platform_suspend_target_state() to retrieve that and take
> appropriate actions (e.g: full vs. partial re-initialization).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> index 4b7e6c297b23..7d4695734093 100644
> --- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> +++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> @@ -104,6 +104,7 @@ struct brcmstb_pm_control {
>  	u32 phy_b_standby_ctrl_offs;
>  	bool needs_ddr_pad;
>  	struct platform_device *pdev;
> +	suspend_state_t pm_state;

I wouldn't use suspend_state_t here, because the mapping between those
things and real platform power states is somewhat arbitrary and totally
platform-specific.

It's better to define symbols representing platform power states for your
platform (or use an enum) and then use those symbols in the drivers IMO.

Thanks,
Rafael
