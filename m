From: Bastien Nocera <hadess@hadess.net>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Wed, 06 May 2015 14:41:38 +0200
Message-ID: <1430916098.2786.9.camel@hadess.net>
References: <1413881397.30379.7.camel@hadess.net>
	 <CAOesGMg6UBuF=OJ-JdAUx-sD5MnLL8+Ag=xeJFmr-Dxezti2YA@mail.gmail.com>
	 <CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
	 <286173531.vzKW1UoxJJ@vostro.rjw.lan>
	 <CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
	 <1430822800.7954.5.camel@hadess.net>
	 <CAJFHJrr=TMuP2fz99=tRE6ev9AZokM2Y9NQdP4JhGOyExXgwvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60714 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbEFMln (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 08:41:43 -0400
In-Reply-To: <CAJFHJrr=TMuP2fz99=tRE6ev9AZokM2Y9NQdP4JhGOyExXgwvg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, 2015-05-05 at 12:22 -0700, Chirantan Ekbote wrote:
> On Tue, May 5, 2015 at 3:46 AM, Bastien Nocera <hadess@hadess.net> 
> wrote:
> > 
> > >   The last thing the power manager does, right before
> > > writing "mem" to /sys/power/state, is write the wakeup_count 
> > > that it
> > > read earlier to /sys/power/wakeup_count.  If the write fails, the
> > > power manager considers the suspend attempt failed, reads the new
> > > wakeup_count, and starts a timer (usually 10 seconds) to retry 
> > > the
> > > suspend.  The same thing happens if the write to /sys/power/state
> > > fails.
> > 
> > Is this something that logind should do as well?
> > 
> 
> We do it to avoid a race condition where a wakeup event occurs after
> userspace has started the suspend process but before anything writes
> "mem" to /sys/power/state.  I'm guessing that this is something 
> logind
> should be doing as well since the chances of missing a wakeup event
> increase the longer any given delay inhibitor takes to delay a
> suspend.

File https://bugzilla.freedesktop.org/show_bug.cgi?id=90339

Cheers

