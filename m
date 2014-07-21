From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/3] cpuidle: exynos: Allow to use the driver without AFTR
Date: Mon, 21 Jul 2014 12:08:45 +0200
Message-ID: <1405937325.21645.2.camel@AMDC1943>
References: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
 <53CCE31C.90300@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <53CCE31C.90300@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sachin Kamat <sachin.kamat@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pon, 2014-07-21 at 11:53 +0200, Daniel Lezcano wrote:
> On 07/21/2014 10:36 AM, Krzysztof Kozlowski wrote:
> > Allow the driver to be used when AFTR enter function is not provided
> > (device platform data is NULL).
> >
> > This actually does not give any special energy-saving benefits but
> > allows to track the idle time of each core. Additionally it is a safe
> > way to validate supplied platform data.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> I think we already talk about this in the mailing list several times.
> It does not make sense to enable the cpuidle driver for WFI just for the 
> sake of tracking via sysfs some idle timings.
> 
> Using the cpuidle driver means using the underlying cpuidle 
> infrastructure with all the stats computation in the governor.
> 
> If there is a *real* need of a WFI cpuidle driver, then a generic WFI 
> cpuidle driver could be implemented to supersede this one.
> 
> It took a while to cleanup this driver and remove all the hacks around 
> this AFTR state... :)

Sure, I understand.

Best regards,
Krzysztof


> 
> > ---
> >   drivers/cpuidle/cpuidle-exynos.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
> > index 7c0151263828..5325a394be7e 100644
> > --- a/drivers/cpuidle/cpuidle-exynos.c
> > +++ b/drivers/cpuidle/cpuidle-exynos.c
> > @@ -77,7 +77,10 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
> >   {
> >   	int ret;
> >
> > +	/* If NULL enter only WFI */
> >   	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
> > +	if (!exynos_enter_aftr)
> > +		exynos_idle_driver.state_count = 1;
> >
> >   	ret = cpuidle_register(&exynos_idle_driver, NULL);
> >   	if (ret) {
> >
> 
> 
