From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v4,3/9] watchdog: at91rm9200: use the system timer syscon
Date: Mon, 9 Mar 2015 08:33:31 -0700
Message-ID: <20150309153331.GA7875@roeck-us.net>
References: <1425570594-13124-4-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425570594-13124-4-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 05, 2015 at 04:49:48PM +0100, Alexandre Belloni wrote:
> Use a syscon regmap to access the system timer registers.
> 
> Also, rename the driver atmel_st_watchdog to stop conflicting with
> at91sam9_wdt.c
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
