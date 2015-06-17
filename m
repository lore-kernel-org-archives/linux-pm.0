From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very wrongthing
Date: Wed, 17 Jun 2015 15:14:02 +0200
Message-ID: <2490787.R6LzZId8tR@vostro.rjw.lan>
References: <20150617121352.GA20553@amd> <7336539.OpACL0uN6J@vostro.rjw.lan> <20150617123333.GA21389@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150617123333.GA21389@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linus <linus_torvalds@foxmail.com>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 17, 2015 02:33:33 PM Pavel Machek wrote:
> Hi!
> 
> > On Wednesday, June 17, 2015 08:19:37 PM linus wrote:
> > > there might be something wrong with driver, can you provide serial log with no_console_suspend? or using rtctrace
> > >
> 
> Who are you?
> 
> The hibernation image is stored successfully, that means drivers work ok.

Well, not entirely necessarily.  We execute the ->poweroff callback for all
of them in the last step, maybe one of these hangs.

You can verify that by adding a reboot trigger after the dpm_suspend_end()
invocation in hibernation_platform_enter().  If it triggers 100% of the time,
drivers are OK.

> Serial console... might be fun to set up, but might help, right.
> 
> > > Hi!
> > > 
> > > On thinkpad X60, if I hibernate in platform mode, it does not power
> > > down, but I get black screen, moon icon blinking, and CPU fan running
> > > (CPU probably too).
> > > 
> > > I can hold the power button down to force powerdown... if I notice
> > > what is going on before the battery is empty.
> > > 
> > > Any ideas what could be wrong there?
> > 
> > Not right away.
> > 
> > Have you tried any previous 4.1-rc kernels?
> 
> Yes, and it was broken there, too. It is possible that 4.0 is broken,
> too, I did not use hibernation for some time.
> 
> 3.14 kernel works ok. I'm trying v3.19 now.

I see.

OK, it would be good to narrow down the time frame when it broke.

Thanks,
Rafael

