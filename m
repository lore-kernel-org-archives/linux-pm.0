From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: mvebu: fix integer to pointer cast
Date: Wed, 15 Jun 2016 01:27:28 +0200
Message-ID: <1690024.btRpmtGi0p@vostro.rjw.lan>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk> <CAKohpon_euKo0Wu8fwU34EUxgBQBrL5TtbuYdvUdNt0ebK+rkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45401 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751332AbcFNXXU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 19:23:20 -0400
In-Reply-To: <CAKohpon_euKo0Wu8fwU34EUxgBQBrL5TtbuYdvUdNt0ebK+rkA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, June 07, 2016 07:10:17 PM Viresh Kumar wrote:
> On 7 June 2016 at 17:00, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > Fix the use of 0 instead of NULL to clk_get() call. This stops the
> > following warning:
> >
> > drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@lists.codethink.co.uk
> > ---
> >  drivers/cpufreq/mvebu-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

