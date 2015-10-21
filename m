From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 08:15:19 +0200
Message-ID: <20151021081519.13fa548a@OPI2>
References: <CAAObsKChQN4gg91dCWJS_Co_MrYyBrB1J7gxgGo4hsPXNZRp3g@mail.gmail.com>
	<Pine.LNX.4.44L0.1510201311260.1855-100000@iolanthe.rowland.org>
	<20151020193528.GE32054@sirena.org.uk>
	<23698237.227MziouDO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <23698237.227MziouDO@vostro.rjw.lan>
Sender: linux-pwm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Brown <broonie@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Michael Turquette <mturquette@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-clk@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexandre
List-Id: linux-pm@vger.kernel.org

Sorry to enter this thread a bit late.

About the number of probe deferred messages, I proposed a simple patch =
to
reduce them:

	https://lkml.org/lkml/2013/8/20/218

I was wondering how many messages this patch could save...

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
