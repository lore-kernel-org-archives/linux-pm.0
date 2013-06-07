From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency warning
Date: Fri, 7 Jun 2013 21:22:12 +0200
Message-ID: <201306072122.12369.arnd@arndb.de>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60189 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab3FGTWR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 15:22:17 -0400
In-Reply-To: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Friday 07 June 2013, Daniel Lezcano wrote:
> Before the commit d6f346f2d2bf511c2c59176121a6e42ce60173a0, the
> ARCH_NEEDS_CPU_IDLE_COUPLED option was wrongly not depending on the CPU_IDLE
> and the Kconfig for OMAP / TEGRA was not checking this dependency when setting
> the option.
> 
> With this patch, the ARCH_NEEDS_CPU_IDLE_COUPLED has been moved under the
> CPU_IDLE option. The dependency has been fixed in the relevant arch's Kconfig.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
