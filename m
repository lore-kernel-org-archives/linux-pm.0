From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mediatek: Add MT8173 cpufreq driver binding
Date: Thu, 09 Jul 2015 08:04:13 -0700
Message-ID: <20150709150413.9112.90660@quantum>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435717005-20012-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150708111900.GD1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36571 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbGIPEc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 11:04:32 -0400
Received: by pdjr16 with SMTP id r16so5562371pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 08:04:32 -0700 (PDT)
In-Reply-To: <20150708111900.GD1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

Quoting Viresh Kumar (2015-07-08 04:19:00)
> On 01-07-15, 10:16, Pi-Cheng Chen wrote:
> > This patch adds device tree binding document for MT8173 cpufreq driver.
> > 
> > Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> > Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> > ---
> >  .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 145 +++++++++++++++++++++
> >  1 file changed, 145 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
> > new file mode 100644
> > index 0000000..65701c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
> > @@ -0,0 +1,145 @@
> > +
> > +Mediatek MT8173 cpufreq driver
> > +------------------------------
> > +
> > +Mediatek MT8173 cpufreq driver for CPU frequency scaling.
> > +
> > +Required properties:
> > +- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
> > +- clock-names: Should contain the following:
> > +     "cpu"           - The multiplexer for clock input of CPU cluster.
> > +     "intermediate"  - A parent of "cpu" clock which is used as "intermediate" clock
> > +                       source (usually MAINPLL) when the original CPU PLL is under
> > +                       transition and not stable yet.
> > +     Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
> > +     generic clock consumer properties.
> 
> Don't have any intentions to halt this series anymore, I have
> irritated you enough already :)
> 
> But, what about moving these bindings in something like a clock
> driver?
> 
> @Mike: ?

Viresh,

Pi-Cheng is using the consumer portion of the clock binding, and he is
using it correctly. You can see this type of thing sprinkled all over.
For instance, many I/O controller do this exact same thing.

> 
> I am asking because these really belong to the clock driver, as I
> understood it from Mike. And clearly asked me to not take care of such
> things in cpufreq core/drivers.

The clock driver is the "provider" and it is separate. This binding is
the "consumer".

> 
> Another reason is that, later you will kill this driver one day and
> use cpufreq-dt. And then you will be required to move these bindings
> to a clock driver, as these will stay.

I'm not sure I follow. Again, the use of the consumer side of the clock
binding is absolutely correct.

Take a quick look at clock-bindings.txt and search for  the section
titled, "==Clock consumers==" for more info.

Regards,
Mike

> 
> -- 
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
