From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Date: Thu, 24 Jan 2019 09:16:35 +0200
Message-ID: <20190124071635.GE2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190123155121.GB7503@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123155121.GB7503@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

Hello Mark,

Thanks again for looking through my changes =)

On Wed, Jan 23, 2019 at 03:51:21PM +0000, Mark Brown wrote:
> On Tue, Jan 22, 2019 at 11:43:28AM +0200, Matti Vaittinen wrote:
> > Header rohm-bd718x7.h was split to generic and component specific
> > parts. This changed the struct bd718x7. Adapt the regulator driver to
> > these changes.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> Does this need to be squashed into the earlier commit for bisection?

Yes. If we don't want to break the compilation between commits then
the patches 2, 3 and 4 should be squashed into one. I sent them as
separare changes for easier review. I can squash them and send them
squashed if they are Ok to Lee and Stephen. Please just let me know
whose tree I should use as the basis so I can do rebasing if needed.
(Or is there some better way to do changes like this?)

Br,
	Matti Vaittinen 

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
