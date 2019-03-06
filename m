From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6] PM / Domains: Return for all error cases in
 _genpd_power_off
Date: Wed, 6 Mar 2019 15:17:28 +0100
Message-ID: <CAPDyKFoNMFW+b0wa9O6pQMOLFukKKLGouL3FFGq6G_B1LcZQNQ@mail.gmail.com>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
 <1551878302-8146-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878302-8146-3-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>
Cc: "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Mar 2019 at 14:25, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> It is strange to only return early for -EBUSY state and left other
> errors to be still measured execution time.
>
> As for error cases, the elapsed_ns computed actually is not quite
> accurate and meaningful for governor to use. So let's simply return
> for all error cases.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 394f9da..f012576 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -457,19 +457,19 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>
>         time_start = ktime_get();
>         ret = genpd->power_off(genpd);
> -       if (ret == -EBUSY)
> +       if (ret)
>                 return ret;
>
>         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>         if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
> -               return ret;
> +               return 0;
>
>         genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
>         genpd->max_off_time_changed = true;
>         pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>                  genpd->name, "off", elapsed_ns);
>
> -       return ret;
> +       return 0;
>  }
>
>  /**
> --
> 2.7.4
>
