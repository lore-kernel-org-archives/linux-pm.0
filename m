From: Jungseok Lee <jays.lee@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: Show a list of available frequencies
Date: Mon, 14 Oct 2013 08:04:20 +0900
Message-ID: <007901cec868$8cbe9fa0$a63bdee0$%lee@samsung.com>
References: <00bd01cec641$b4dbf150$1e93d3f0$%lee@samsung.com>
 <CAKohpok6Pbq-ykeWKEfUo3=eC8bzkAUo_FTPN2zMMu44R-vuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpok6Pbq-ykeWKEfUo3=eC8bzkAUo_FTPN2zMMu44R-vuOA@mail.gmail.com>
Content-language: ko
Sender: cpufreq-owner@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, amit.daniel@samsung.com, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kgene.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

On Friday, October 11, 2013 11:27 PM Viresh Kumar wrote:
> On 11/10/2013, Jungseok Lee <jays.lee@samsung.com> wrote:
> > This patch adds freq_attr to show a list of exynos5440 scaling
> > available frequencies through sysfs. Common exynos driver already
> > supports this attribute.
> >
> > Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> > ---
> >  drivers/cpufreq/exynos5440-cpufreq.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
> > b/drivers/cpufreq/exynos5440-cpufreq.c
> > index 24df155..2cc4797 100644
> > --- a/drivers/cpufreq/exynos5440-cpufreq.c
> > +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> > @@ -345,6 +345,11 @@ static int exynos_cpufreq_cpu_exit(struct
> > cpufreq_policy *policy)
> >  	return 0;
> >  }
> >
> > +static struct freq_attr *exynos_cpufreq_attr[] = {
> > +	&cpufreq_freq_attr_scaling_available_freqs,
> > +	NULL,
> > +};
> > +
> >  static struct cpufreq_driver exynos_driver = {
> >  	.flags		= CPUFREQ_STICKY,
> >  	.verify		= exynos_verify_speed,
> > @@ -353,6 +358,7 @@ static struct cpufreq_driver exynos_driver = {
> >  	.init		= exynos_cpufreq_cpu_init,
> >  	.exit		= exynos_cpufreq_cpu_exit,
> >  	.name		= CPUFREQ_NAME,
> > +	.attr		= exynos_cpufreq_attr,
> >  };
> >
> >  static const struct of_device_id exynos_cpufreq_match[] = {
> 
> Use cpufreq_generic_attr instead from rafael's bleeding-edge
> branch

Okay. Thanks for a comment.

Best Regards
Jungseok Lee

