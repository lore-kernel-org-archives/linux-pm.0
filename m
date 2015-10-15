From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH v2 1/2] thermal: mediatek: Add cpu power cooling model.
Date: Thu, 15 Oct 2015 19:31:47 +0800
Message-ID: <1444908707.23970.6.camel@mtksdaap41>
References: <1444220561-26139-1-git-send-email-dawei.chien@mediatek.com>
	 <1444220561-26139-2-git-send-email-dawei.chien@mediatek.com>
	 <20151007155745.GD28981@leverpostej>
	 <9hhoag4dmlg.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:38843 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752483AbbJOLbw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 07:31:52 -0400
In-Reply-To: <9hhoag4dmlg.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On Mon, 2015-10-12 at 18:26 +0100, Punit Agrawal wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Wed, Oct 07, 2015 at 08:22:40PM +0800, Dawei Chien wrote:
> >> From: "Dawei.Chien" <dawei.chien@mediatek.com>
> >> 
> >> This power model is base on Intelligent Power Allocation (IPA) technical,
> >> requires that the operating-points of the CPUs are registered using the
> >> kernel's opp library and the `cpufreq_frequency_table` is assigned to the
> >> `struct device` of the cpu MT8173.
> >> 
> >> Signed-off-by: Dawei.Chien <dawei.chien@mediatek.com>
> >> ---
> >> This patch is base on
> >> https://patchwork.kernel.org/patch/7034601/
> >> ---
> >>  drivers/cpufreq/mt8173-cpufreq.c |   97 +++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 86 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> >> index 49caed2..9233ec5 100644
> >> --- a/drivers/cpufreq/mt8173-cpufreq.c
> >> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> >> @@ -28,7 +28,8 @@
> >>  #define MAX_VOLT_SHIFT		(200000)
> >>  #define MAX_VOLT_LIMIT		(1150000)
> >>  #define VOLT_TOL		(10000)
> >> -
> >> +#define CAPACITANCE_CA53	(263)
> >> +#define CAPACITANCE_CA57	(530)
> >>  /*
> >>   * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
> >>   * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
> >> @@ -51,6 +52,72 @@ struct mtk_cpu_dvfs_info {
> >>  	bool need_voltage_tracking;
> >>  };
> >>  
> >> +struct mtk_cpu_static_power {
> >> +	unsigned long voltage;
> >> +	unsigned int power;
> >> +};
> >> +
> >> +/* measured by WA program. */
> >> +static const struct mtk_cpu_static_power mtk_ca53_static_power[] = {
> >> +	{859000, 43},
> >> +	{908000, 52},
> >> +	{983000, 86},
> >> +	{1009000, 123},
> >> +	{1028000, 138},
> >> +	{1083000, 172},
> >> +	{1109000, 180},
> >> +	{1125000, 192},
> >> +};
> >> +
> >> +/* measured by WA program. */
> >> +static const struct mtk_cpu_static_power mtk_ca57_static_power[] = {
> >> +	{828000, 72},
> >> +	{867000, 90},
> >> +	{927000, 156},
> >> +	{968000, 181},
> >> +	{1007000, 298},
> >> +	{1049000, 435},
> >> +	{1089000, 533},
> >> +	{1125000, 533},
> >> +};
> >
> > This should be described in the DT, rather than necessitating tonnes of
> > these tables in the kernel.
> 
> The above table is a simplification that is tying the static power of a
> device to a voltage (indirectly via frequency for ease of indexing
> perhaps).
> 
> We should definitely look at describing the static power model in the
> device tree - but it is not entirely clear what is the best model to
> use as basis for the device tree bindings.
> 
> Static power consumption depends on a few different parameters (silicon
> process, voltage, temperature, etc.). The relationship between them
> maybe non-linear and not all of these maybe significant for a given
> platform. e.g., for Juno, we are using a regression based on voltage and
> temperature which was deemed close enough (very subjective tbh).
> 
> On the other hand, dynamic power consumption is somewhat simpler and I
> have patches[0][1][2] enabling it's description in device tree. Your comments
> there would be very much appreciated.
> 
> As for this patch, I hope it can be moved to using the device tree when
> the bindings for static power are agreed upon. Although sub-optimal, I
> can't see any other way forward for now.
> 
> [0] http://thread.gmane.org/gmane.linux.kernel/2011466/focus=130373
> [1] http://thread.gmane.org/gmane.linux.kernel/2011466/focus=2011465
> [2] http://article.gmane.org/gmane.linux.drivers.sensors/37859

Hi Mark/Punit,
Thank you for your nice comments. I will resend this patch with device tree for dynamic/static power model,
and refer to Punit's patches, thank you.

> >
> > Mark.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



