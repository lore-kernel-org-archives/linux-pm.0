From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [RFC PATCH 1/2] pm: Add PM domain notifications
Date: Thu, 11 Dec 2014 11:36:39 +0100
Message-ID: <548973B7.3050107@samsung.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <1418286387-9663-2-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33799 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbaLKKhp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 05:37:45 -0500
In-reply-to: <1418286387-9663-2-git-send-email-tfiga@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Kurtz <djkurtz@chromium.org>

Hi Tomasz,

On 11/12/14 09:26, Tomasz Figa wrote:
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> This patch adds notifiers to the runtime PM/genpd subsystem. It is now
> possible to register a notifier, which will be called before and after
> the generic power domain subsystem calls the power domain's power_on
> and power_off callbacks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> [tfiga@chromium.org: rebased]
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Not sure if you've noticed it, I posted an updated version of this patch
recently [1]. The notifiers list is moved to struct generic_pm_domain
there and it also allows to register a notifier for selected power domain
by name.

-- 
Regards,
Sylwester

[1] http://www.spinics.net/lists/linux-samsung-soc/msg38549.html
