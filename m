From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 00/23] ARM: at91: Properly handle slow clock
Date: Fri, 31 Jul 2015 12:20:09 +0200
Message-ID: <20150731102009.GH27985@piout.net>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150731115903.4ef23e83@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150731115903.4ef23e83@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, rtc-linux@googlegroups.com, Sebastian Reichel <sre@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-pm@vger.kernel.org

Hi,

On 31/07/2015 at 11:59:03 +0200, Boris Brezillon wrote :
> I would have squashed commit 5 to 14 into a single patch, but apart
> from that it looks good to me.
> 

I wanted to clearly list were the slow clock was needed for each soc. It
actually allowed me to find one that was missing.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
