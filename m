From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 05/28] cpufreq: drop owner assignment from platform_drivers
Date: Fri, 30 Jan 2015 01:12:18 +0100
Message-ID: <2246789.LNCtIhz5WK@vostro.rjw.lan>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de> <2262992.pVJSfL5P4D@vostro.rjw.lan> <20141231102326.GA1461@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65527 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753427AbbA2Xta (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 18:49:30 -0500
In-Reply-To: <20141231102326.GA1461@katana>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wednesday, December 31, 2014 11:23:26 AM Wolfram Sang wrote:
> On Mon, Dec 22, 2014 at 11:39:32PM +0100, Rafael J. Wysocki wrote:
> > On Monday, December 22, 2014 07:14:56 AM Viresh Kumar wrote:
> > > On 22 December 2014 at 02:44, Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > This platform_driver does not need to set an owner, it will be populated by the
> > > > driver core.
> > > >
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > > Generated with coccinelle. SmPL file is in the introductory msg. The big
> > > > cleanup was pulled in this merge window. This series catches the bits fallen
> > > > through. The patches shall go in via the subsystem trees.
> > > >
> > > >  drivers/cpufreq/ls1x-cpufreq.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/ls1x-cpufreq.c
> > > > index 25fbd6a1374f..f0913eee2f50 100644
> > > > --- a/drivers/cpufreq/ls1x-cpufreq.c
> > > > +++ b/drivers/cpufreq/ls1x-cpufreq.c
> > > > @@ -210,7 +210,6 @@ out:
> > > >  static struct platform_driver ls1x_cpufreq_platdrv = {
> > > >         .driver = {
> > > >                 .name   = "ls1x-cpufreq",
> > > > -               .owner  = THIS_MODULE,
> > > >         },
> > > >         .probe          = ls1x_cpufreq_probe,
> > > >         .remove         = ls1x_cpufreq_remove,
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > --
> > 
> > OK
> > 
> > Wolfram, please feel free to push this through whatever tree you think is
> > appropriate.
> 
> I'd prefer if you take it. However, I'll send all leftover ones to Greg,
> so you can decide.

I've queued it up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
