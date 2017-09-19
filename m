From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: cpufreq(-dt) with two clocks but one regulator
Date: Tue, 19 Sep 2017 11:19:45 +0200
Message-ID: <2997079.BKPG7M6LVv@diego>
References: <1515316.mHJbnBRRvK@phil> <2224473.GjtbWfbYHk@phil> <CAD=FV=W+rvgJuNO0gEPN02bYkkJt6i6um=YGjUoaKmyrFhhSiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:32792 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbdISJT4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Sep 2017 05:19:56 -0400
In-Reply-To: <CAD=FV=W+rvgJuNO0gEPN02bYkkJt6i6um=YGjUoaKmyrFhhSiw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Doug,

Am Montag, 18. September 2017, 16:37:56 CEST schrieb Doug Anderson:
> On Mon, Sep 18, 2017 at 3:40 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Current submitted OPPs can be found at
> > https://patchwork.kernel.org/patch/9908519/
> > 
> > There were still issues with higher frequencies, so they don't list the
> > 1.2 or 1.5GHz yet.
> > 
> > But opp sets pretty tight constraints. I.e. OPPs have of course one
> > preferred voltage, so you end up with u_volt_min = u_volt_max for each
> > operating point, thus the regulator also gets set in this way, removing
> > any
> > intersection and thus making the regulator framework fail to set a voltage
> > for one of the clusters.
> > 
> > So for example, you have one cluster running at 600MHz@0.95V and the
> > other cluster running at 1008MHz@1.05V this results in regulator
> > constraints being
> > 
> >         0.95V-0.95V
> > 
> > and
> > 
> >         1.05V-1.05V
> > 
> > thus no intersection and whoever comes second looses.
> 
> (Untested) Can't you change the opp table and use the fancier
> operating point descriptions that give <target min max>?

funny, that I never noticed that opps are also specified for
(target, min, max) values.

Thanks for pointing me to the right direction and this seems to
actually work. Although I noticed that obviously the max value
needs to always be the global maximum (1125000 here) for both
opp tables, to make the regulator framework happy.


> In theory the above is a more proper hardware description: AKA you're
> describing that it's OK to use the higher voltage even at lower
> operating points.


Thanks
Heiko
