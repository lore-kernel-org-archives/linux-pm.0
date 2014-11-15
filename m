From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when
 genpd enabled
Date: Sat, 15 Nov 2014 21:54:45 +0100
Message-ID: <20141115205445.GA21240@amd>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
 <CAMuHMdXB-7vBqGZ_iMaZdDWDnnzpHZa4ECkDnojbDw=ds5eTWg@mail.gmail.com>
 <7ha93t8z1q.fsf@deeprootsystems.com>
 <5229811.LXthdvUIfI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36886 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbaKOUys (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Nov 2014 15:54:48 -0500
Content-Disposition: inline
In-Reply-To: <5229811.LXthdvUIfI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

On Fri 2014-11-14 23:41:15, Rafael J. Wysocki wrote:
> On Friday, November 14, 2014 09:36:17 AM Kevin Hilman wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > 
> > > Hi Kevin,
> > >
> > > On Thu, Nov 13, 2014 at 11:28 PM, Kevin Hilman <khilman@kernel.org> wrote:
> > >> It makes little sense to use generic power domains without runtime PM.
> > >
> > > Does it?
> > > It still powers down the PM domains on system suspend (at least on my
> > > boards ;-)
> > 
> > Sure, but your devices are also using runtime PM, so I'm not sure how
> > does that change my statement above?
> 
> Questions here are (1) how many users will actually want to disable PM_RUNTIME
> for systems using genpd (my sort of educated guess is "none") and

Well. Developers sometimes want to disable power management so that
they don't have to debug it just now... disabling PM_RUNTIME is a way
to do that.

OTOH making code more complex to make new board bring-up easier may
not be good idea..
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
