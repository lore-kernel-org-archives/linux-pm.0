From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/10] OPP: Add code to support operating-points-v2 bindings
Date: Tue, 30 Jun 2015 22:14:17 +0530
Message-ID: <CAKohpokaiCq8kq5xALyW-q1QXvUJo2uv2ZbbFYfVFMT0XAqdzA@mail.gmail.com>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f41.google.com ([209.85.216.41]:37674 "EHLO
	mail-vn0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbbF3QoS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 12:44:18 -0400
Received: by vnbf129 with SMTP id f129so2468319vnb.4
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2015 09:44:17 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Nishanth Menon <nm@ti.com>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 15 June 2015 at 17:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Guys,
>
> This adds code to support operating-points-v2 bindings. Not everything
> is supported yet, but most of the basic stuff is.
>
> Tested with: Exynos 5250, dual cortex A15 board. With both old and new
> bindings.
>
> Bindings are already frozen:
> http://marc.info/?i=cover.1433434659.git.viresh.kumar%40linaro.org
>
> Pushed here as well for reference:
> ssh://git@git.linaro.org/people/viresh.kumar/linux.git opp/v2

I am really hoping to get all basic stuff pushed in for 4.3, can we have
some review of the code please?

--
viresh
