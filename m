From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/10] OPP: Add code to support operating-points-v2
 bindings
Date: Fri, 17 Jul 2015 08:06:02 +0530
Message-ID: <20150717023602.GD5828@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <CAKohpokaiCq8kq5xALyW-q1QXvUJo2uv2ZbbFYfVFMT0XAqdzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34326 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbGQCgH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2015 22:36:07 -0400
Received: by pdbbh15 with SMTP id bh15so8408763pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2015 19:36:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohpokaiCq8kq5xALyW-q1QXvUJo2uv2ZbbFYfVFMT0XAqdzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Nishanth Menon <nm@ti.com>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>

On 30-06-15, 22:14, Viresh Kumar wrote:
> On 15 June 2015 at 17:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi Guys,
> >
> > This adds code to support operating-points-v2 bindings. Not everything
> > is supported yet, but most of the basic stuff is.
> >
> > Tested with: Exynos 5250, dual cortex A15 board. With both old and new
> > bindings.
> >
> > Bindings are already frozen:
> > http://marc.info/?i=cover.1433434659.git.viresh.kumar%40linaro.org
> >
> > Pushed here as well for reference:
> > ssh://git@git.linaro.org/people/viresh.kumar/linux.git opp/v2
> 
> I am really hoping to get all basic stuff pushed in for 4.3, can we have
> some review of the code please?

@Stephen: Can you please review rest of the stuff?

@Nishanth: Can you please review the series, now that you are back :)

@Rafael: Can you please apply the patches Acked by Stephen for 4.3, so
that I don't have to resend them again ?

-- 
viresh
