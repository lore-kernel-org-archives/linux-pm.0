From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] cpuidle: add maintainer entry
Date: Wed, 24 Apr 2013 09:55:27 -0700
Message-ID: <87k3nr50n4.fsf@linaro.org>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Wed, 24 Apr 2013 15:34:23 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: andrew@lunn.ch, Daniel Lezcano <daniel.lezcano@linaro.org>, benh@kernel.crashing.org, linus.walleij@linaro.org, nicolas.ferre@atmel.com, paulus@samba.org, josephl@nvidia.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, magnus.damm@gmail.com, viresh.kumar@linaro.org, plagnioj@jcrosoft.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, arnd@arndb.de, swarren@wwwdotorg.org, nsekhar@ti.com, rob.herring@calxeda.com, horms@verge.net.au, ben-linux@fluff.org, horms+renesas@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

Rafael,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61677c3..effa0f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2206,6 +2206,13 @@ S:	Maintained
>  F:	drivers/cpufreq/
>  F:	include/linux/cpufreq.h
>  
> +CPUIDLE DRIVERS
> +M:	Rafael J. Wysocki <rjw@sisk.pl>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/cpuidle/*
> +F:	include/linux/cpuidle.h

What do you think about having Daniel listed here as a co-maintainer?

He has been driving a significant consolidation effort, and will
continue to do that, so I think he should help take care of this area
and ensure all drivers are moving in the right direction.

Kevin
