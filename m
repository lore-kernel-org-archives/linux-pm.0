From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 04/14] cpufreq: cpu0: Add Module Author
Date: Wed, 9 Jul 2014 10:42:04 -0400
Message-ID: <53BD54BC.7080608@ti.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <bc183ef08321e2699a0834d545bade9c7f7d7fcc.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc183ef08321e2699a0834d545bade9c7f7d7fcc.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, t.figa@samsung.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, thomas.ab@samsung.com, arvind.chauhan@arm.com, spk.linux@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 July 2014 12:32 PM, Viresh Kumar wrote:
> Two people are maintaining it now, Viresh and Shawn. Add Viresh's details in
> MODULE_AUTHOR() and copyright section.
> 
> Suggested-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index ee1ae30..7e191db 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c

Not related to this patch but I think its time to change
the name of this driver. I never liked this 'cpufreq-cpu0.c'
and already mentioned that during the reviews of this
driver.

Not sure if there are still sentiments about it but
considering the additional functionality coming in,
the name will definitely miss-leading.

Regards,
Santosh
