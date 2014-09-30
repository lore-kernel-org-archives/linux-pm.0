From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Tue, 30 Sep 2014 11:07:53 -0700
Message-ID: <7hiok5yoau.fsf@deeprootsystems.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39566 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaI3SHz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 14:07:55 -0400
In-Reply-To: <1412081033-8136-2-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 30 Sep 2014 14:43:50 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> There are currently no users of this API, let's remove it.
>
> Additionally, if such feature would be needed future wise, a better
> option is likely use pm_runtime_set_active|suspended() in some form.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
