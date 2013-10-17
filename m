From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: Convert exynos-cpufreq to platform driver
Date: Thu, 17 Oct 2013 17:31:52 +0900
Message-ID: <001d01cecb13$54ccd410$fe667c30$%han@samsung.com>
References: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
 <CAK9yfHwW+ofX5f8hHF=MYQn=CUMyiHvg4iAH-cHFW7JQ5Qnscw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAK9yfHwW+ofX5f8hHF=MYQn=CUMyiHvg4iAH-cHFW7JQ5Qnscw@mail.gmail.com>
Content-language: ko
Sender: cpufreq-owner@vger.kernel.org
To: 'Tomasz Figa' <t.figa@samsung.com>
Cc: 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 17, 2013 2:00 PM, Sachin Kamat wrote:
> On 16 October 2013 21:30, Tomasz Figa <t.figa@samsung.com> wrote:
> > From: Lukasz Majewski <l.majewski@samsung.com>
> >
> > +static struct platform_driver exynos_cpufreq_platdrv = {
> > +       .driver = {
> > +               .name   = "exynos-cpufreq",
> > +               .owner  = THIS_MODULE,
> > +       },
> > +       .probe = exynos_cpufreq_init,
> 
> I think the prototype of this function should be changed to:
> static int __init exynos_cpufreq_init(struct platform_device *pdev)
> 
> to avoid compilation warnings.

Hi Tomasz Figa,

One more thing. :-)

It makes section mismatch warning. Also, module_platform_driver()
is used. Then, '__init' annotation can be removed in order to fix
the section mismatch warning.

static int exynos_cpufreq_init(struct platform_device *pdev)

Thank you.

Best regards,
Jingoo Han

