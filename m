From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Thu, 25 Jan 2007 20:37:42 +0100
Message-ID: <20070125193742.GA23774@elf.ucw.cz>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net> <200701242228.17836.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701242228.17836.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > (Yes, there are huge gaps in Linux-PM wakeup support.  Weak ACPI suppport
> > for it, especially from STR -- without swsusp -- is a big factor.  I
> > was pleased to see RTC wakeup from ACPI S4 actually work ... first time
> > I've ever seen ACPI wakeup ever work correctly.)
> 
> Try your power button, sleep button, or lid switch.

Actually, in 2.6.18-or-so, I could wake my x60 from s2ram by simply
opening the lid. New kernels do not support that. Do I need to
configure it somewhere?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
