From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V1 resend] cpufreq: Raname index as data in cpufreq_frequency_table
Date: Tue, 14 May 2013 10:15:33 -0600
Message-ID: <51926325.2050805@wwwdotorg.org>
References: <7e12acada8adcba5f4eb72f6c49e38aaf00a294f.1368434974.git.viresh.kumar@linaro.org> <5191148E.7050205@wwwdotorg.org> <CAKohpo=MS6D9DGiZDUPPYA47c=tqWXUMC6bdssD5xL=7GEcDvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=MS6D9DGiZDUPPYA47c=tqWXUMC6bdssD5xL=7GEcDvw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, Sekhar Nori <nsekhar@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 05/14/2013 07:46 AM, Viresh Kumar wrote:
...
> This must address your concerns:
> @Rafael: I have attached both patches now for you to apply.
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 14 May 2013 19:08:50 +0530
> Subject: [PATCH 1/2] cpufreq: tegra: Remove irrelevant comment
> 
> Tegra cpufreq driver doesn't use .index field of cpufreq_frequency_table and so
> comment mentioning order of .index is irrelevant. Remove it.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> -/* Frequency table index must be sequential starting at 0 */
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ 0, 216000 },
>  	{ 1, 312000 },

Does the .index/.data field even need to be filled in any more?
