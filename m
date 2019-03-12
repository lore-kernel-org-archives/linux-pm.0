From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH] PM / OPP: Update performance state when freq == old_freq
Date: Tue, 12 Mar 2019 07:27:48 +0100
Message-ID: <288203c2-c822-b918-ce72-e2271125d374@linaro.org>
References: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <5a0c96bebb52c1ae34a2d0df63517b2d2938369c.1552366620.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "v5 . 0" <stable@vger.kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 3/12/19 05:57, Viresh Kumar wrote:
> At boot up, CPUfreq core performs a sanity check to see if the system is
> running at a frequency defined in the frequency table of the CPU. If so,
> we try to find a valid frequency (lowest frequency greater than the
> currently programmed frequency) from the table and set it. When the call
> reaches dev_pm_opp_set_rate(), it calls _find_freq_ceil(opp_table,
> &old_freq) to find the previously configured OPP and this call also
> updates the old_freq. This eventually sets the old_freq == freq (new
> target requested by cpufreq core) and we skip updating the performance
> state in this case.
> 
> Fix this by also updating the performance state when the old_freq ==
> freq.
> 
> Fixes: ca1b5d77b1c6 ("OPP: Configure all required OPPs")
> Cc: v5.0 <stable@vger.kernel.org> # v5.0
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index d7f97167cac3..0420f7e8ad5b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -760,7 +760,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		old_freq, freq);
>  
>  	/* Scaling up? Configure required OPPs before frequency */
> -	if (freq > old_freq) {
> +	if (freq >= old_freq) {
>  		ret = _set_required_opps(dev, opp_table, opp);
>  		if (ret)
>  			goto put_opp;
> 


[    3.048579] Loading compiled-in X.509 certificates
[    3.064282] cpufreq: cpufreq_online: CPU0: Running at unlisted freq:
1113600 KHz
[    3.064510] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency
changed to: 1248000 KHz
[    3.072072] hctosys: unable to open rtc device (rtc0)


...

and the ftrace on the registered driver handling the performance change
to state 2

     kworker/3:0-26    [003] ....     3.063824: cpr_pd_attach_dev:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.063845: cpr_corner_restore:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.063848: cpr_corner_restore: gcnt
= 0x000132ab, ctl = 0x31000428, irq = 0x00000014
     kworker/3:0-26    [003] ....     3.063851: cpr_ctl_enable.part.15:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.064352: cpr_set_performance:
cpr_set_performance: setting performance state: 2 (prev state: 0)
     kworker/3:0-26    [003] ....     3.064355: cpr_ctl_disable.part.16:
reg[0x100] = 0x00000000
     kworker/3:0-26    [003] ....     3.064410: cpr_corner_restore:
reg[0x100] = 0x00000014
     kworker/3:0-26    [003] ....     3.064413: cpr_corner_restore: gcnt
= 0x000132f5, ctl = 0x31000428, irq = 0x00000014
     kworker/3:0-26    [003] ....     3.064416: cpr_ctl_enable.part.15:
reg[0x100] = 0x00000014
      irq/29-cpr-1320  [000] ....     3.079189: cpr_irq_handler:
IRQ_STATUS = 0x5
