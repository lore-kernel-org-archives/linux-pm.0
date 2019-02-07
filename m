From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v7 00/10] support ROHM BD70528 PMIC
Date: Thu, 7 Feb 2019 07:57:38 +0200
Message-ID: <20190207055738.GA5798@localhost.localdomain>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
 <87o97ovke3.fsf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o97ovke3.fsf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Moro Kalle,

On Wed, Feb 06, 2019 at 08:31:32PM +0200, Kalle Valo wrote:
> Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> writes:
> 
> > Patch series introducing support for ROHM BD70528 PMIC
> >
> > Please note that patch 1 breaks compilation without patches 2 and 3
> > Knowing the bd718x7 driver is already in upstream, it might be good
> > if this change went through single tree, right?
> 
> That would break bisect, please avoid that. So after applying patches
> from a patchset one by one the compilation should always succeed.

Right. Thanks for the reminder. Mark did also ask about this earlier.
This split was originally done to clearly point out changes impacting
in-tree drivers on separate subsystems/trees (mfd, clk and regulators).

But you are right, these should be squashed before applying. I have now
received acks from Mark and Stephen so I guess I can squash them even
though Lee has not yet commented anything yet. I guess that 7 previous
versions do already clearly enough point out these changes =)

I will squash them in next version. Thanks for the reminder.

> 
> -- 
> Kalle Valo

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
