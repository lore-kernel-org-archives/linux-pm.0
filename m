From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Thu, 13 Nov 2014 15:05:12 +0100
Message-ID: <20141113140512.GB18995@amd>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <2024276.CFr3nVUAlA@vostro.rjw.lan>
 <CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>
 <17707586.6KbjDf5Kep@vostro.rjw.lan>
 <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
 <545D0074.7060205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <545D0074.7060205@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Jack Dai <jack.dai@rock-chips.com>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jinkun Hong <jinkun.hong@rock-chips.com>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaron Lu <aaron.lu@intel.com>, Greg
List-Id: linux-pm@vger.kernel.org

Hi!

> 2) There are no requirements for arch/platforms/drivers to work in both cases
> CONFIG_PM_RUNTIME=y/n. But they must be built without errors/warning for both
> cases.

I don't think where you got that. They are config options, they should
work.

It is prefer not to compile than to compile but not work.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
