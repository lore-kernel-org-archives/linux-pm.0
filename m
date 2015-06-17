From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very
 wrongthing
Date: Wed, 17 Jun 2015 14:33:33 +0200
Message-ID: <20150617123333.GA21389@amd>
References: <20150617121352.GA20553@amd>
 <tencent_191436EF7F89540B416DB7A5@qq.com>
 <7336539.OpACL0uN6J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7336539.OpACL0uN6J@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linus <linus_torvalds@foxmail.com>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> On Wednesday, June 17, 2015 08:19:37 PM linus wrote:
> > there might be something wrong with driver, can you provide serial log with no_console_suspend? or using rtctrace
> >

Who are you?

The hibernation image is stored successfully, that means drivers work
ok. Serial console... might be fun to set up, but might help, right.

> > Hi!
> > 
> > On thinkpad X60, if I hibernate in platform mode, it does not power
> > down, but I get black screen, moon icon blinking, and CPU fan running
> > (CPU probably too).
> > 
> > I can hold the power button down to force powerdown... if I notice
> > what is going on before the battery is empty.
> > 
> > Any ideas what could be wrong there?
> 
> Not right away.
> 
> Have you tried any previous 4.1-rc kernels?

Yes, and it was broken there, too. It is possible that 4.0 is broken,
too, I did not use hibernation for some time.

3.14 kernel works ok. I'm trying v3.19 now.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
