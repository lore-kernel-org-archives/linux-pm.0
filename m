From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Choose the deepest state to enter if no
 devices using it
Date: Wed, 6 Mar 2019 16:10:43 +0100
Message-ID: <CAPDyKFoWgDAvpwJdLhzVOy3MUoM8Rmf+qinw_EZY4dXd+pp68Q@mail.gmail.com>
References: <1551878926-8455-1-git-send-email-aisheng.dong@nxp.com>
 <1551878926-8455-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878926-8455-3-git-send-email-aisheng.dong@nxp.com>
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

On Wed, 6 Mar 2019 at 14:35, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> For a domain has no working devices anymore, let's choose the deepest state
> to enter to save power. e.g. driver probe failure.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/base/power/domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 847a69e..d3f57c2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -550,6 +550,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>         if (!genpd->gov)
>                 genpd->state_idx = 0;
>
> +       /* Choose the deepest state if no devices using this domain */
> +       if (!genpd->device_count)
> +               genpd->state_idx = genpd->state_count - 1;
> +

This doesn't work, sorry.

For example, there may be a sub-domain with devices in it and which
have constraints applicable also for the master (current) domain.

>         /*
>          * If sd_count > 0 at this point, one of the subdomains hasn't
>          * managed to call genpd_power_on() for the master yet after
> --
> 2.7.4
>

Kind regards
Uffe
