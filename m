From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v1 11/13] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Date: Tue, 22 Jan 2019 18:29:31 +0200
Message-ID: <20190122162931.GB2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ebe1618710baf7cf59622c878e40052ca48cc7c3.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <390e9379-329b-02dc-13f6-763aeae703e1@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <390e9379-329b-02dc-13f6-763aeae703e1@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 06:48:21AM -0800, Guenter Roeck wrote:
> On 1/22/19 1:47 AM, Matti Vaittinen wrote:
> > +
> > +static int bd70528_set_rtc_based_timers(struct bd70528 *bd70528, int new_state,
> > +							int *old_state)
> 
> Passed parameter is an int, not int *. I'd be quite surprised if this compiles
> without warning.
> 
> > +static int bd70528_re_enable_rtc_based_timers(struct bd70528 *bd70528,
> > +							int old_state)
// snip
> > +	return bd70528_set_rtc_based_timers(bd70528, old_state, NULL);

and

> > +static int bd70528_disable_rtc_based_timers(struct bd70528 *bd70528,
> > +							int *old_state)
// snip
> > +	return bd70528_set_rtc_based_timers(bd70528, 0, old_state);

I'm not quite sure I understand what you mean by that. Second parameter is int,
third one is is int *.

> > +static int bd70528_re_enable_rtc_based_timers(struct bd70528 *bd70528,
> > +							int old_state)
> > +{
> > +	if (bd70528->rtc_timer_lock)
> > +		mutex_unlock(bd70528->rtc_timer_lock);
> > +
> Unlock before calling bd70528_set_rtc_based_timers is odd, especially since it
> is called after locking below.
> 

Yet another brainfart. Thanks for pointing this out! Will be fixed as
well.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
