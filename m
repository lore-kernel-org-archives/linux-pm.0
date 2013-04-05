From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq/regulator: Handle regulators that defer
 probe with device tree bindings
Date: Fri, 5 Apr 2013 14:13:25 +0800
Message-ID: <20130405061323.GB2667@S2101-09.ap.freescale.net>
References: <1365135708-23886-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365135708-23886-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 04, 2013 at 11:21:46PM -0500, Nishanth Menon wrote:
> Nishanth Menon (2):
>   regulator: core: return err value for regulator_get if there is no DT
>     binding
>   cpufreq: cpufreq-cpu0: defer probe when regulator is not ready

For both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>
