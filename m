From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V1 resend] cpufreq: Raname index as data in cpufreq_frequency_table
Date: Mon, 13 May 2013 10:27:58 -0600
Message-ID: <5191148E.7050205@wwwdotorg.org>
References: <7e12acada8adcba5f4eb72f6c49e38aaf00a294f.1368434974.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7e12acada8adcba5f4eb72f6c49e38aaf00a294f.1368434974.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, Sekhar Nori <nsekhar@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 05/13/2013 06:57 AM, Viresh Kumar wrote:
> "Index" field of struct cpufreq_frequency_table was never index and isn't used
> at all by cpufreq core. And is only useful for cpufreq drivers for their
> personal use.
> 
> Many people now a days blindly set it in ascending order with the assumption
> that core is using it for some work.
> 
> This patch renames it to "data" as that's what its purpose it. All users of the
> same are fixed too.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> -/* Frequency table index must be sequential starting at 0 */
> +/* Frequency table data must be sequential starting at 0 */

I assume that comment is due to the assumption you're trying to remove.
Should the comment be removed/corrected now? Perhaps the .data field
isn't even needed any more in this driver?

>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ 0, 216000 },
>  	{ 1, 312000 },

