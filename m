From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] cpufreq: cpufreq-cpu0: do not allow transitions with regulators suspended
Date: Thu, 14 Nov 2013 23:00:21 +0100
Message-ID: <2085822.gaTNcUz76n@vostro.rjw.lan>
References: <1382638087-32054-1-git-send-email-nm@ti.com> <20131113151645.GA17828@kahuna> <52842671.40703@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52842671.40703@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 14, 2013 06:55:05 AM viresh kumar wrote:
> On Wednesday 13 November 2013 08:46 PM, Nishanth Menon wrote:
> > arrgh, my bad.. Apologies for the bad one.. I missed it :( Does the following
> > look equivalent?
> 
> yes.
> 
> > With this, I now see:
> 
> > [   43.212714] cpufreq: cpufreq_add_policy_cpu: Failed to stop governor
> > ^^^ ??
> 
> Ahh, I missed this part. I thought it will fail at some other place where there
> is no error checking :), but that's not true.
> 
> Following should fix it for you and looks to be the right way as well.
> 
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index dc67fa0..30b09d3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1530,6 +1530,14 @@ static void cpufreq_bp_resume(void)
>                 }
>         }
> 
> +       if (has_target()) {
> +               if ((ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
> +                       (ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {


I'm not going to apply anything like this.  If I have already, that's been a mistake.

Do not mix assignments with logical operators in such outrageous ways, please.
That's completely unreadable and confusing.

What about:

	ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
	if (!ret) {
		ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
		if (ret) {


> +                       pr_err("%s: Failed to start governor\n", __func__);
> +                       goto fail;
> +               }
> +       }
> +
>         schedule_work(&policy->update);
> 
>  fail:

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
