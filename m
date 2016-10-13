From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v7 2/8] power: add power sequence library
Date: Thu, 13 Oct 2016 09:22:16 +0800
Message-ID: <20161013012216.GA8114@b29397-desktop>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
 <1474342607-27512-3-git-send-email-peter.chen@nxp.com>
 <4691591.qnCGxrEkrZ@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4691591.qnCGxrEkrZ@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 12, 2016 at 12:30:29PM +0200, Heiko Stuebner wrote:
> Hi,
> 
> Am Dienstag, 20. September 2016, 11:36:41 CEST schrieb Peter Chen:
> > We have an well-known problem that the device needs to do some power
> > sequence before it can be recognized by related host, the typical
> > example like hard-wired mmc devices and usb devices.
> > 
> > This power sequence is hard to be described at device tree and handled by
> > related host driver, so we have created a common power sequence
> > library to cover this requirement. The core code has supplied
> > some common helpers for host driver, and individual power sequence
> > libraries handle kinds of power sequence for devices.
> > 
> > pwrseq_generic is intended for general purpose of power sequence, which
> > handles gpios and clocks currently, and can cover regulator and pinctrl
> > in future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > if only one power sequence is needed, else call of_pwrseq_on_list
> > /of_pwrseq_off_list instead (eg, USB hub driver).
> >
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> 
> first of all, glad to see this move forward. I've only some qualms with the 
> static number of allocated power sequences below.
> 

Thanks for commenting it, the preallocate way is not a good way, but I
can't find suitable way. See below comments.

> > +static int __init pwrseq_generic_register(void)
> > +{
> > +	struct pwrseq_generic *pwrseq_gen;
> > +	int i;
> > +
> > +	for (i = 0; i < CONFIG_PWRSEQ_GENERIC_INSTANCE_NUMBER; i++) {
> > +		pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> > +		if (!pwrseq_gen)
> > +			return -ENOMEM;
> > +
> > +		pwrseq_gen->pwrseq.pwrseq_of_match_table = generic_id_table;
> > +		pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> > +		pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> > +		pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> > +		pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> > +		pwrseq_gen->pwrseq.free = pwrseq_generic_free;
> > +
> > +		pwrseq_register(&pwrseq_gen->pwrseq);
> > +	}
> > +
> > +	return 0;
> > +}
> > +postcore_initcall(pwrseq_generic_register)
> 
> I see that you need to have it preallocated for the compatible matching, but 
> wouldn't it also work to either just register the type and allocate 
> dynamically or otherwise just allocate a new spare everytime 
> pwrseq_generic_get() picks up the previous spare?

Before compatible matching, the host driver doesn't know which pwrseq type
for its child node, then doesn't know which pwrseq instance needs to be
allocated. From dts, we don't know which pwrseq type for the node.

-- 

Best Regards,
Peter Chen
