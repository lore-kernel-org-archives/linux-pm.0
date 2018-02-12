From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Mon, 12 Feb 2018 11:38:13 +0100
Message-ID: <1518431893.2744.1.camel@pengutronix.de>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
         <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57151 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeBLKiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 05:38:25 -0500
In-Reply-To: <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Am Freitag, den 09.02.2018, 14:58 +0100 schrieb Ulf Hansson:
> On 26 January 2018 at 09:38, Jia-Ju Bai <baijiaju1990@gmail.com>
> wrote:
> > After checking all possible call chains to genpd_dev_pm_detach()
> > and
> > genpd_dev_pm_attach() here,
> > my tool finds that these functions are never called in atomic
> > context,
> > namely never in an interrupt handler or holding a spinlock.
> > Thus mdelay can be replaced with msleep to avoid busy wait.
> > 
> > This is found by a static analysis tool named DCNS written by
> > myself.
> > 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > ---
> >  drivers/base/power/domain.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/power/domain.c
> > b/drivers/base/power/domain.c
> > index 0c80bea..f84ac72 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device
> > *dev, bool power_off)
> >                 if (ret != -EAGAIN)
> >                         break;
> > 
> > -               mdelay(i);
> > +               msleep(i);
> 
> This looks like a nice improvement, however moving to msleep() makes
> the call to cond_resched() below a bit superfluous. Perhaps remove
> that as well.

At least for small values of i, msleep also has a high chance to
overshoot the desired sleep by a lot. It would be better to convert
them to usleep_range with an acceptable slack.

Regards,
Lucas

> >                 cond_resched();
> >         }
> > 
> > @@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
> >                 if (ret != -EAGAIN)
> >                         break;
> > 
> > -               mdelay(i);
> > +               msleep(i);
> 
> Ditto.
> 
> >                 cond_resched();
> >         }
> >         mutex_unlock(&gpd_list_lock);
> > --
> > 1.7.9.5
> > 
> 
> Kind regards
> Uffe
