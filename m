From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/4] PM / Domains: Don't allow an existing generic PM domain data
Date: Wed, 29 Oct 2014 15:28:16 -0700
Message-ID: <7hegtq5x4v.fsf@deeprootsystems.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
	<1414507090-516-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47940 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbaJ2W2U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 18:28:20 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so3851772pdj.10
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2014 15:28:19 -0700 (PDT)
In-Reply-To: <1414507090-516-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 28 Oct 2014 15:38:08 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> While adding devices to the generic PM domain we allocate data for the
> struct generic_pm_domain_data.
>
> Don't allow existing generic_pm_domain_data in this case, since that
> indicates the device is already being added from another context. Let's
> instead return an error.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Similar to PATCH 1/4, it would be good to summarize/remind why this
feature was added in the first place, and why it's not longer needed.

Kevin
