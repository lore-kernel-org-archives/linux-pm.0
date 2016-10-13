From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v7 2/8] power: add power sequence library
Date: Thu, 13 Oct 2016 16:57:39 +0800
Message-ID: <20161013085739.GA19151@b29397-desktop>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
 <4691591.qnCGxrEkrZ@phil>
 <20161013012216.GA8114@b29397-desktop>
 <10186696.bBGEe05eC7@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33417 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbcJMI6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 04:58:07 -0400
Content-Disposition: inline
In-Reply-To: <10186696.bBGEe05eC7@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org

On Thu, Oct 13, 2016 at 09:04:42AM +0200, Heiko Stuebner wrote:
> > > > +static int __init pwrseq_generic_register(void)
> > > > +{
> > > > +	struct pwrseq_generic *pwrseq_gen;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < CONFIG_PWRSEQ_GENERIC_INSTANCE_NUMBER; i++) {
> > > > +		pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> > > > +		if (!pwrseq_gen)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		pwrseq_gen->pwrseq.pwrseq_of_match_table = generic_id_table;
> > > > +		pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> > > > +		pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> > > > +		pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> > > > +		pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> > > > +		pwrseq_gen->pwrseq.free = pwrseq_generic_free;
> > > > +
> > > > +		pwrseq_register(&pwrseq_gen->pwrseq);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +postcore_initcall(pwrseq_generic_register)
> > > 
> > > I see that you need to have it preallocated for the compatible matching,
> > > but wouldn't it also work to either just register the type and allocate
> > > dynamically or otherwise just allocate a new spare everytime
> > > pwrseq_generic_get() picks up the previous spare?
> > 
> > Before compatible matching, the host driver doesn't know which pwrseq type
> > for its child node, then doesn't know which pwrseq instance needs to be
> > allocated. From dts, we don't know which pwrseq type for the node.
> 
> yes, that is why I was suggesting allocating one (or two) here in 
> pwrseq_generic_register() and every time pwrseq_generic_get() grabs the last 
> free sequence instance, you allocate a new free spare one in that function.

Good idea.

-- 

Best Regards,
Peter Chen
