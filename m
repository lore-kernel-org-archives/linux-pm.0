From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpuidle: move ARCH_NEEDS_CPU_IDLE_COUPLED Kconfig option
Date: Fri, 07 Jun 2013 12:53:13 +0200
Message-ID: <7104482.Ecl7mMk8ke@wuerfel>
References: <1460854.rT4b7LefMM@wuerfel> <51AF3424.5060200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53299 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab3FGKxl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 06:53:41 -0400
In-Reply-To: <51AF3424.5060200@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org

On Wednesday 05 June 2013 14:50:44 Daniel Lezcano wrote:
> 
> IMHO, this option depends on CPU_IDLE and thus must be kept inside the
> CPU_IDLE menuconfig.
> 
> The warning raised here is because this option is selected by the arch
> Kconfig without checking if CPU_IDLE is set or not.
> 
> I am in favor to change the OMAP / TEGRA Kconfigs instead, in this way:

Fine with me as well.

	Arnd
