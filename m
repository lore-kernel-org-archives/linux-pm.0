From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 4/7] regulator: add mxs regulator driver
Date: Mon, 23 Mar 2015 18:45:41 +0100 (CET)
Message-ID: <1459171144.549216.1427132741792.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
 <20150322161425.GC6643@sirena.org.uk>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150322161425.GC6643@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, marex@denx.de, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, dbaryshkov@gmail.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, lgirdwood@gmail.com, sre@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, galak@codeaurora.org, sebastien.szymanski@armadeus.com, shawn.guo@linaro.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

>
> > + if (ldo->get_power_source)
> > + power_source = ldo->get_power_source(reg);
> > +
> > + switch (power_source) {
> > + case HW_POWER_LINREG_DCDC_OFF:
> > + case HW_POWER_LINREG_DCDC_READY:
> > + case HW_POWER_EXTERNAL_SOURCE_5V:
> > + usleep_range(1000, 2000);
> > + return 0;
> > + }
>
> I'd expect the switch to be in the if here?

yes, that's possible too.

>
> > +
> > + usleep_range(15, 20);
> > + start = jiffies;
> > + while (1) {
> > + if (readl(ldo->status_addr) & BM_POWER_STS_DC_OK)
> > + return 0;
> > +
> > + if (time_after(jiffies, start + msecs_to_jiffies(20)))
> > + break;
> > +
> > + schedule();
> > + }
>
> So, this isn't actually quite a busy wait because we do a schedule()
> rather than a cpu_relax() but still it could devolve into that - 20ms
> seems a long time to burn doing that. If we're expecting this to finish
> very quickly can we do an initial busy wait then fall back to something
> with an actual sleep or soemthing?

We will need to keep the initial usleep_range(). So do you think of the
following:

1. usleep_range
2. busy_wait for BM_POWER_STS_DC_OK
3. msleep (for the timeout case)

Stefan
