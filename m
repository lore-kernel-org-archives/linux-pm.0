From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] cpufreq: db8500: set CPUFREQ_CONST_LOOPS
Date: Mon, 17 Dec 2012 10:24:15 -0800
Message-ID: <50CF634F.1040708@codeaurora.org>
References: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
 <1354615845-2758-3-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1354615845-2758-3-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, John Stultz <johnstul@us.ibm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 12/04/12 02:10, Fabio Baltieri wrote:
> As ux500 is being converted to timer based delay loops, and the timer
> used is not depending on CPUs clock frequency, set cpufreq_driver flag
> CPUFREQ_CONST_LOOPS to prevent cpufreq rescaling loops_for_jiffies.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>  drivers/cpufreq/db8500-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
> index 74b830b..e758891 100644
> --- a/drivers/cpufreq/db8500-cpufreq.c
> +++ b/drivers/cpufreq/db8500-cpufreq.c
> @@ -150,7 +150,7 @@ static int __cpuinit db8500_cpufreq_init(struct cpufreq_policy *policy)
>  }
>  
>  static struct cpufreq_driver db8500_cpufreq_driver = {
> -	.flags  = CPUFREQ_STICKY,
> +	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS,
>  	.verify = db8500_cpufreq_verify_speed,
>  	.target = db8500_cpufreq_target,
>  	.get    = db8500_cpufreq_getspeed,

Wouldn't you want to fold this into the previous patch so bisection is
not broken? Otherwise you have a place where lpj is all screwed up when
cpufreq mucks with it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
