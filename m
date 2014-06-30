From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH TRIVIAL] thermal: cpu_cooling: fix typo highjack ->
 hijack
Date: Mon, 30 Jun 2014 10:50:33 +0800
Message-ID: <1404096633.2289.7.camel@rzhang1-toshiba>
References: <1403716277-1351-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403716277-1351-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-06-25 at 18:11 +0100, Javi Merino wrote:
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>

applied, thanks!

-rui
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 84a75f89bf74..1ab0018271c5 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -305,7 +305,7 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
>   * @event: value showing cpufreq event for which this function invoked.
>   * @data: callback-specific data
>   *
> - * Callback to highjack the notification on cpufreq policy transition.
> + * Callback to hijack the notification on cpufreq policy transition.
>   * Every time there is a change in policy, we will intercept and
>   * update the cpufreq policy with thermal constraints.
>   *
