From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 6/9] ARM: davinci: cpuidle: fix wrong enter function
Date: Thu, 4 Apr 2013 12:46:02 +0530
Message-ID: <515D28B2.90408@ti.com>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <1364991322-20585-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58208 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933079Ab3DDHQo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Apr 2013 03:16:44 -0400
In-Reply-To: <1364991322-20585-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, josephl@nvidia.com, deepthi@linux.vnet.ibm.com

On 4/3/2013 5:45 PM, Daniel Lezcano wrote:
> The davinci_enter_idle is called from the cpuidle with the
> cpuidle_wrap_enter function. This one does the time compution
> for entering and exiting the idle function and then we call
> again cpuidle_wrap_enter for cpu_do_idle. This is wrong, we
> are calling recursively cpuidle_wrap_enter for nothing and
> furthermore reenabling the local irq.
> 
> Remove this and replace it by the cpu_do_idle function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
