From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Mon, 8 Jan 2007 14:10:55 +0100
Message-ID: <20070108131055.GB25933@elf.ucw.cz>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net> <20070107055424.GA24853@srcf.ucam.org> <200701071931.20306.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701071931.20306.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun 2007-01-07 19:31:19, David Brownell wrote:
> On Saturday 06 January 2007 9:54 pm, Matthew Garrett wrote:
> > On Sat, Jan 06, 2007 at 02:21:41PM -0800, David Brownell wrote:
> > 
> > > Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> > > attribute.  And that ACPI is finally going to start working with those
> > > attributes ...
> > 
> > It's not necessarily possible to map from an ACPI object with a wakeup 
> > capability to a Linux device, 
> 
> That seems singularly useless then.  If there's no such mapping, there's
> really no point to the /proc/acpi/wakeup table... why not just always
> enable every possible device as a wakeup source, since that information
> is evidently not designed to be usable for anything?

If that's the case, please keep the interface in /proc. One useless
interface is bad... two of them ... :-).

Anyway yes it can be usefull for debugging unexpected machine
resumes. /proc/acpi/wakeup names are still _somehow_ human readable,
so it is useful for debugging.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
