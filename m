From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Tue, 18 Nov 2014 21:51:57 +0100
Message-ID: <1714555.tu97zMrOn0@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org> <2808463.UGmrrQ79Aq@vostro.rjw.lan> <CAKohpomgci3S+PZUhm3svuxX+V+pNvHxQqX4m=QmPzd00sxPwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59753 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754508AbaKRUax (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 15:30:53 -0500
In-Reply-To: <CAKohpomgci3S+PZUhm3svuxX+V+pNvHxQqX4m=QmPzd00sxPwg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday, November 18, 2014 08:38:14 AM Viresh Kumar wrote:
> On 18 November 2014 05:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, November 17, 2014 01:38:00 PM Viresh Kumar wrote:
> >> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> >> index 89ced95..490e9db 100644
> >> --- a/drivers/base/power/opp.c
> >> +++ b/drivers/base/power/opp.c
> >> @@ -466,9 +466,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
> >>               int ret = opp->available && new_opp->u_volt == opp->u_volt ?
> >>                       0 : -EEXIST;
> >>
> >> -             dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> >> -                      __func__, opp->rate, opp->u_volt, opp->available,
> >> -                      new_opp->rate, new_opp->u_volt, new_opp->available);
> >> +             dev_dbg(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> >> +                     __func__, opp->rate, opp->u_volt, opp->available,
> >> +                     new_opp->rate, new_opp->u_volt, new_opp->available);
> >>               mutex_unlock(&dev_opp_list_lock);
> >>               kfree(new_opp);
> >>               return ret;
> >
> > Don't you think that this may hide real bugs?
> 
> What kind of bugs exactly?
> 
> We are allowing addition of duplicate OPPs as a standard thing right now
> as cpufreq drivers don't get rid of the OPPs they create with DT. So, that
> shouldn't complain, isn't it ?

Is cpufreq the only user of OPP?  I thought there were other users, so what
about them?

> For example, what Stefan was doing was absolutely normal procedure
> and that complained for him..
> 
> The only thing we don't allow is when the existing OPP isn't available
> and we are trying to add a duplicate one. In that case we do return
> -EEXIST and so we will get errors from the upper layer.
> 
> Or do we want to destroy OPPs created with help of DT while the
> driver unloads ?

I'm not sure about that.  If they aren't useful for anything after
that, what's the benefit of keeping them around?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
