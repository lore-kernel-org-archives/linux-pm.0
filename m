From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [v3,2/6] power: add power sequence library
Date: Tue, 2 Aug 2016 11:32:15 +0800
Message-ID: <20160802033215.GB26831@shlinux2>
References: <1469007629-31757-3-git-send-email-peter.chen@nxp.com>
 <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, stephen.boyd@linaro.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org, festevam@gmail.com, stillcompiling@gmail.com, pawel.moll@arm.com, dbaryshkov@gmail.com, stern@rowland.harvard.edu, dwmw2@infradead.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, arnd@arndb.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 29, 2016 at 01:06:48PM -0700, Matthias Kaehlcke wrote:
> >...
> >
> >+static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	enum of_gpio_flags flags;
> >+	int reset_gpio, ret = 0;
> >+
> >+	pwrseq_gen->clk = of_clk_get_by_name(np, NULL);
> This only gets the first of potentially multiple clocks, is that intended?

Matthias, I have added multiple input clocks support at v4 patch set,
and you are at cc list.

-- 

Best Regards,
Peter Chen
