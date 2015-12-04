From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH] ARM: imx6: pm: declare pm domain latency on power_state
 struct.
Date: Fri, 4 Dec 2015 16:19:31 -0700
Message-ID: <20151204231931.GA2230@linaro.org>
References: <1447799871-56374-6-git-send-email-lina.iyer@linaro.org>
 <1447858656-62464-1-git-send-email-lina.iyer@linaro.org>
 <1448285460.3689.13.camel@pengutronix.de>
 <1448286153.3689.15.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448286153.3689.15.camel@pengutronix.de>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 23 2015 at 06:42 -0700, Lucas Stach wrote:
>Am Montag, den 23.11.2015, 14:31 +0100 schrieb Lucas Stach:
>> Am Mittwoch, den 18.11.2015, 07:57 -0700 schrieb Lina Iyer:
>> > From: Axel Haslam <ahaslam+renesas@baylibre.com>
>> >
>> > The generic_pm_domain structure uses an array of latencies to be able to
>> > declare multiple intermediate states.
>> >
>> > Declare a single "OFF" state with the default latencies So that the
>> > power_off_latency_ns and power_on_latency_ns fields of generic_pm_domain
>> > structure can be eventualy removed.
>> >
>> > Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> > [Lina: pm_genpd_init() argument change]
>> > ---
>> >  arch/arm/mach-imx/gpc.c | 14 ++++++++++++--
>> >  1 file changed, 12 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
>> > index 8e7976a..b070e06 100644
>> > --- a/arch/arm/mach-imx/gpc.c
>> > +++ b/arch/arm/mach-imx/gpc.c
>> > @@ -368,13 +368,23 @@ static struct generic_pm_domain imx6q_arm_domain = {
>> >  	.name = "ARM",
>> >  };
>> >
>> > +static struct genpd_power_state imx6q_arm_domain_states[] = {
>>
>> Those states are for the PU, not the ARM domain.
>>
>> > +	{
>> > +		.name = "OFF",
>> > +		.power_off_latency_ns = 25000,
>> > +		.power_on_latency_ns = 2000000,
>> > +	},
>> > +};
>> > +
>> >  static struct pu_domain imx6q_pu_domain = {
>> >  	.base = {
>> >  		.name = "PU",
>> >  		.power_off = imx6q_pm_pu_power_off,
>> >  		.power_on = imx6q_pm_pu_power_on,
>> > -		.power_off_latency_ns = 25000,
>> > -		.power_on_latency_ns = 2000000,
>> > +		.gov = NULL,
>> > +		.status = GPD_STATE_POWER_OFF,
>>
>> The above 2 lines should not be needed. This is a static struct, so .gov
>> will already be NULL. status is set by pm_genpd_init() and the above
>> value is actively wrong.
>>
True.

>> > +		.states = imx6q_arm_domain_states,
>> > +		.state_count = ARRAY_SIZE(imx6q_arm_domain_states),
>> >  	},
>> >  };
>> >
>>
>> How urgent is this patch? I have a series to rework the GPC driver
>> almost ready and I could fold this change in directly if it's okay for
>> this to sit through a review of the rework.
>
>And I just noticed this depends on changes that are not already in
>v4.4-rc. Why is this sent as a single patch and not as part of the
>series adding multiple state support to genpd?
>
Sorry, since this is ARM 32, I had not comple tested it when I sent out
the series. I sent this out after I realized it.

Thanks,
Lina

>Regards,
>Lucas
>
>-- 
>Pengutronix e.K.             | Lucas Stach                 |
>Industrial Linux Solutions   | http://www.pengutronix.de/  |
>
