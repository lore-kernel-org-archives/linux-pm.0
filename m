From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] PM / devfreq: exynos: fix error path in exynos_bus_probe()
Date: Tue, 28 Jun 2016 21:05:06 +0900
Message-ID: <CAGTfZH2-PJazsjGCkFs7HeOc4VsFW3t7wZge2ODaD-2P1F5ixg@mail.gmail.com>
References: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
 <1467112869-30488-2-git-send-email-b.zolnierkie@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467112869-30488-2-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

2016-06-28 20:21 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> In case of exynos_bus_parse_of() failure the code shouldn't
> try to remove the OPP table and disable+unprepare bus->clk
> as it has been already handled in exynos_bus_parse_of().
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 2363d0a..e946f8f 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -407,7 +407,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>         /* Parse the device-tree to get the resource information */
>         ret = exynos_bus_parse_of(np, bus);
>         if (ret < 0)
> -               goto err;
> +               return ret;
>
>         profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
>         if (!profile) {
> --
> 1.9.1

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

And, this patch fixes the bug. It should be included in v4.7-rc version.

Thanks,
Chanwoo Choi
