From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the need_restore flag
Date: Sat, 15 Nov 2014 00:45:45 +0100
Message-ID: <4906699.EOjK8M5WqJ@vostro.rjw.lan>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org> <2882656.Dm8xnxDtKM@vostro.rjw.lan> <7hh9y1619a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49967 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935316AbaKNXYr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 18:24:47 -0500
In-Reply-To: <7hh9y1619a.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Friday, November 14, 2014 11:16:49 AM Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

[cut]

> > Essentially, the "power up" operation will depend on the PM domain and
> > bus type, so they'll need to provide callbacks that will most likely
> > duplicate runtime PM callbacks.  And those callbacks need to be available
> > when we do the "power up" thing.
> 
> Yuck.  More callbacks.  Just what we need. ;)

Precisely.

> I think I'm still not quite getting the fundamental problem being
> addressed.  Why isn't a pm_runtime_get_sync() by the first device in a
> PM domain sufficient for powering on the domain?  
> 
> Yes, I understand there are some issues around *keeping* the domain
> powered, but I think that's a separate problem.
> 
> > How can we address that?
> >
> > We seem to be dealing with a case in which PM is needed on some systems just to
> > make them work at the basic level and not for energy saving, which was what
> > runtime PM was designed for.
> 
> I think they're the same thing.  Power is needed for devices to work at
> a basic level, and cutting power is needed for energy savings.  Runtime
> PM is designed for that.  :)

Yes, that pretty much is my conclusion.

Consequently, the best way to go in my view is to require PM_RUNTIME to be
set when we need to do runtime PM.  Which is when we need to dynamically
power up and power down things as needed, basically.

Rafael

