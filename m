From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very
 wrongthing
Date: Wed, 17 Jun 2015 15:16:08 +0200
Message-ID: <20150617131608.GA24030@amd>
References: <20150617121352.GA20553@amd>
 <7336539.OpACL0uN6J@vostro.rjw.lan>
 <20150617123333.GA21389@amd>
 <2490787.R6LzZId8tR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2490787.R6LzZId8tR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linus <linus_torvalds@foxmail.com>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2015-06-17 15:14:02, Rafael J. Wysocki wrote:
> On Wednesday, June 17, 2015 02:33:33 PM Pavel Machek wrote:
> > Hi!
> > 
> > > On Wednesday, June 17, 2015 08:19:37 PM linus wrote:
> > > > there might be something wrong with driver, can you provide serial log with no_console_suspend? or using rtctrace
> > > >
> > 
> > Who are you?
> > 
> > The hibernation image is stored successfully, that means drivers work ok.
> 
> Well, not entirely necessarily.  We execute the ->poweroff callback for all
> of them in the last step, maybe one of these hangs.

shutdown mode works ok, that's why I think driver problem is not too
likely.

> > Yes, and it was broken there, too. It is possible that 4.0 is broken,
> > too, I did not use hibernation for some time.
> > 
> > 3.14 kernel works ok. I'm trying v3.19 now.
> 
> I see.
> 
> OK, it would be good to narrow down the time frame when it broke.

3.19 is broken. Some kind of strange 3.17 works ok.

(On an additional note, x60 fails to boot when "hot" halting at

"ACPI: All ACPI Tables successfully acquired"

That was happening before, but it is really annoying for debugging. As
you do two reboots, machine gets hot enough, and you have to wait to
cool it down. Any ideas what to do there?)

I tried no_console_suspend=1, but it still suspended the console.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
