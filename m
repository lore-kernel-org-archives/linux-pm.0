From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 27 Jan 2016 10:43:10 +0100
Message-ID: <CAPDyKFqmWRY4vb=JAqwBmGqRhpq0MrdiAt4jCt5tdhYsxz0ziw@mail.gmail.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
	<8579242.omBpg1aLr2@wuerfel>
	<CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
	<11122786.kKumQ3Dhls@wuerfel>
	<5697D7E2.3030209@nvidia.com>
	<56A7A662.4090203@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33639 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbcA0JnM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 04:43:12 -0500
Received: by mail-yk0-f172.google.com with SMTP id k129so3502991yke.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2016 01:43:11 -0800 (PST)
In-Reply-To: <56A7A662.4090203@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

>
> Any more thoughts on this?
>
> I have been discussing with Thierry and we think that selecting PM for
> tegra still makes the most sense. The question is, is this ok for
> multi-configs?

Yes, this is too me the best option.

Additionally, for those tegra SoCs/platforms that needs
PM_GENERIC_DOMAINS, it can safely select that as well.

>
> The only other suggestion/thought I have is to allow
> PM_GENERIC_DOMAINS_OF to be selected independently of PM so that we can
> have minimal support for PM domains that allows you to register PM
> domains with the kernel and their current state, but does not allow you
> to control them, etc. This way tegra could always select
> PM_GENERIC_DOMAINS_OF regardless of PM, and we would be able to
> determine if we can probe a device safely.
>
> I am not sure that Rafael is too keen on this approach but that is the
> only alternative I have come up with.

I think Rafael already made his point around this approach, which is a
clear no. And I fully agree with it.

Kind regards
Uffe
