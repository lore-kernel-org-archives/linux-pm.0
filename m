From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: sa1110: set memory type for h3600
Date: Fri, 18 Jul 2014 03:06:22 +0200
Message-ID: <2124778.Alp4aMcbnP@vostro.rjw.lan>
References: <1405158213-14679-1-git-send-email-linus.walleij@linaro.org> <CAKohpon090a+cv6ZzTz7ziZkFxw__xJ4F7PGYKWMMJEE=OHizQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59763 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750928AbaGRAsE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 20:48:04 -0400
In-Reply-To: <CAKohpon090a+cv6ZzTz7ziZkFxw__xJ4F7PGYKWMMJEE=OHizQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Saturday, July 12, 2014 08:15:21 PM Viresh Kumar wrote:
> On 12 July 2014 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> > The Compaq iPAQ h3600 also has the K4S281632b-1H memory type.
> > Verified by prying apart a broken board.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/cpufreq/sa1110-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
> > index 546376719d8f..b5befc211172 100644
> > --- a/drivers/cpufreq/sa1110-cpufreq.c
> > +++ b/drivers/cpufreq/sa1110-cpufreq.c
> > @@ -349,7 +349,7 @@ static int __init sa1110_clk_init(void)
> >                         name = "K4S641632D";
> >                 if (machine_is_h3100())
> >                         name = "KM416S4030CT";
> > -               if (machine_is_jornada720())
> > +               if (machine_is_jornada720() || machine_is_h3600())
> >                         name = "K4S281632B-1H";
> >                 if (machine_is_nanoengine())
> >                         name = "MT48LC8M16A2TG-75";
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

