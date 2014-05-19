From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: fix incorrect OPP count handling in of_init_opp_table
Date: Tue, 20 May 2014 01:26:57 +0200
Message-ID: <1589010.LoIeM7LX94@vostro.rjw.lan>
References: <1400237477-24831-1-git-send-email-chander.kashyap@linaro.org> <CAGo_u6oQiOJzp2DCCFUfwWWPLKKw=pgZPgdr9LBqfYs-GKb9zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61672 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751397AbaESXKD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 19:10:03 -0400
In-Reply-To: <CAGo_u6oQiOJzp2DCCFUfwWWPLKKw=pgZPgdr9LBqfYs-GKb9zg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel@ucw.cz, Len Brown <len.brown@intel.com>, gregkh@linuxfoundation.org, Viresh Kumar <viresh.kumar@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On Monday, May 19, 2014 08:04:30 AM Nishanth Menon wrote:
> On Fri, May 16, 2014 at 5:51 AM, Chander Kashyap
> <chander.kashyap@linaro.org> wrote:
> > In of_init_opp_table function, if a failure to add an OPP is
> > detected, the count of OPPs, yet to be added is not updated.
> > Fix this by decrementing this count on failure as well.
> >
> > Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> > Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> > ---
> >  drivers/base/power/opp.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> > index d9e376a..faae9cf 100644
> > --- a/drivers/base/power/opp.c
> > +++ b/drivers/base/power/opp.c
> > @@ -643,11 +643,9 @@ int of_init_opp_table(struct device *dev)
> >                 unsigned long freq = be32_to_cpup(val++) * 1000;
> >                 unsigned long volt = be32_to_cpup(val++);
> >
> > -               if (dev_pm_opp_add(dev, freq, volt)) {
> > +               if (dev_pm_opp_add(dev, freq, volt))
> >                         dev_warn(dev, "%s: Failed to add OPP %ld\n",
> >                                  __func__, freq);
> > -                       continue;
> > -               }
> >                 nr -= 2;
> >         }
> Good Catch. Thanks.
> 
> Acked-by: Nishanth Menon <nm@ti.com>

Since my pull request for 3.15-rc6 has been sent already, I'm going to push
this for -rc7.  Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
