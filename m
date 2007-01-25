From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs
	functions in sysfs
Date: Thu, 25 Jan 2007 14:15:03 +0100
Message-ID: <20070125131503.GC23511@elf.ucw.cz>
References: <1168083306.5619.34.camel@localhost.localdomain>
	<1168256428.5754.98.camel@localhost.localdomain>
	<200701101253.28151.david-b@pacbell.net>
	<200701242317.48273.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200701242317.48273.lenb@kernel.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > There will be another ACPI patch at some point, actually kicking
> > in hooks needed to handle system wakeup, but getting the PC into
> > the RTC class framework is an important first step.
> > =

> > Once there's a proper replacement for /proc/acpi/alarm it becomes
> > a candidate for removal.  Maybe sooner rather than later, unless
> > some users for that old file turn up...
> =

> Sometimes that file's syntax is useful -- wake up at 7:00,
> but those testing suspend-resume want to wake up 1 minute in the future
> now mater what time it is...

Write a shell script then. "Calculating times in future is
conventient, lets hack it into kernel". OOps?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
