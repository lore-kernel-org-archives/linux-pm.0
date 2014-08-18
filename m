From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] cpuidle: big.LITTLE: add Exynos5800 compatible string
Date: Mon, 18 Aug 2014 11:36:16 -0500
Message-ID: <53F22B80.3050205@samsung.com>
References: <1407888665-24603-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407888665-24603-1-git-send-email-khilman@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: k.chander@samsung.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, CPUIDLE DRIVERS <linux-pm@vger.kernel.org>, t.figa@samsung.com, daniel.lezcano@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, open list <linux-kernel@vger.kernel.org>, kgene.kim@samsung.com, linaro-kernel@lists.linaro.org, "open list:CPUIDLE DRIVER -..." <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 08/12/14 19:11, Kevin Hilman wrote:
> Exynos 5800 is big.LITTLE SoC compatible with the 5420.  Add the
> compatible string so this driver works on the 5800.
>
> Tested on exynos5800-peach-pi (aka Samsung Chromebook2)
>
> Signed-off-by: Kevin Hilman<khilman@linaro.org>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> ---
>   drivers/cpuidle/cpuidle-big_little.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index 0a1f827308db..bf3ab66fdaaf 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -166,6 +166,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int match_id)
>   static const struct of_device_id compatible_machine_match[] = {
>   	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
>   	{ .compatible = "samsung,exynos5420" },
> +	{ .compatible = "samsung,exynos5800" },
>   	{},
>   };
>
