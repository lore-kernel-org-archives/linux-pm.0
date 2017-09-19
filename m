From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq(-dt) with two clocks but one regulator
Date: Tue, 19 Sep 2017 08:25:59 -0700
Message-ID: <20170919152559.GA16005@ubuntu>
References: <1515316.mHJbnBRRvK@phil>
 <2224473.GjtbWfbYHk@phil>
 <CAD=FV=W+rvgJuNO0gEPN02bYkkJt6i6um=YGjUoaKmyrFhhSiw@mail.gmail.com>
 <2997079.BKPG7M6LVv@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:53322 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdISP0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 11:26:07 -0400
Received: by mail-pf0-f171.google.com with SMTP id x78so146518pff.10
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2017 08:26:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2997079.BKPG7M6LVv@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 19-09-17, 11:19, Heiko Stübner wrote:
> Am Montag, 18. September 2017, 16:37:56 CEST schrieb Doug Anderson:
> > (Untested) Can't you change the opp table and use the fancier
> > operating point descriptions that give <target min max>?

And that's exactly what I was going to suggest :)

> funny, that I never noticed that opps are also specified for
> (target, min, max) values.
> 
> Thanks for pointing me to the right direction and this seems to
> actually work. Although I noticed that obviously the max value
> needs to always be the global maximum (1125000 here) for both
> opp tables, to make the regulator framework happy.

Great.

-- 
viresh
