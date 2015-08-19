From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/3] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 19 Aug 2015 11:11:20 +0530
Message-ID: <20150819054120.GA3258@linux>
References: <20150818102428.GD31148@linux>
 <1439949906-22177-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439949906-22177-1-git-send-email-pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 19-08-15, 10:05, Pi-Cheng Chen wrote:
> Mediatek MT8173 is an ARMv8 based quad-core (2*Cortex-A53 and
> 2*Cortex-A72) SoC with duall clusters. For each cluster, two voltage
> inputs, Vproc and Vsram are supplied by two regulators. For the big
> cluster, two regulators come from different PMICs. In this case, when
> scaling voltage inputs of the cluster, the voltages of two regulator
> inputs need to be controlled by software explicitly under the SoC
> specific limitation:
> 
> 	100mV < Vsram - Vproc < 200mV
> 
> which is called 'voltage tracking' mechanism. And when scaling the
> frequency of cluster clock input, the input MUX need to be parented to
> another "intermediate" stable PLL first and reparented to the original
> PLL once the original PLL is stable at the target frequency. This patch
> implements those mechanisms to enable CPU DVFS support for Mediatek
> MT8173 SoC.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> 
> Changes in v7:
> - add of_machine_is_compatible() check to be multiplatform friendly

Looks fine, thanks.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
