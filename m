From: Pavel Machek <pavel@suse.cz>
Subject: Re: waking system up using RTC (was Re: rtcwakeup.c)
Date: Sun, 27 Aug 2006 12:17:25 +0200
Message-ID: <20060827101725.GB9953@elf.ucw.cz>
References: <20060725124941.GD5034@ucw.cz>
	<200608261415.33353.david-b@pacbell.net>
	<20060826214342.GB3784@elf.ucw.cz>
	<200608261704.05017.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608261704.05017.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Your new RTC driver seems to work for me (thinkpad x60), but no, I
> > > > can't get wakeup using RTC to work:
> > > =

> > > Does it work using /proc/acpi/alarm?  In my experience, ACPI wakeup
> > > doesn't work on Linux ... hence my pleasant surprise to see it work
> > =

> > No, I could not get it working using /proc/acpi/alarm.
> =

> Then I suspect that's the root cause of your problem ... ACPI code,
> in either Linux or your BIOS, is not sufficiently cooperative.  All
> that the rtc-acpi driver does is move the wakeup code, it doesn't
> actually change what the /proc/acpi/alarm stuff does.

I searched the bios; timer wakeup is enabled, but I can't set timer
wakeup from the bios.

> > rtc-acpi 00:07: AT compatible RTC (S4wake) (y3k), 1 month alarm
> =

> Seems like Intel's chips won't do one year alarms ... so sad.  :)

:-).

(BTW... if STR still does not work on your notebook, let me know, and
we can try to fix that...)
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
