From: Pavel Machek <pavel@ucw.cz>
Subject: Re: waking system up using RTC (was Re: rtcwakeup.c)
Date: Sat, 26 Aug 2006 23:43:42 +0200
Message-ID: <20060826214342.GB3784@elf.ucw.cz>
References: <20060725124941.GD5034@ucw.cz> <20060826145920.GA1826@elf.ucw.cz>
	<200608261415.33353.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608261415.33353.david-b@pacbell.net>
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

> > Your new RTC driver seems to work for me (thinkpad x60), but no, I
> > can't get wakeup using RTC to work:
> =

> Does it work using /proc/acpi/alarm?  In my experience, ACPI wakeup
> doesn't work on Linux ... hence my pleasant surprise to see it work

No, I could not get it working using /proc/acpi/alarm.

> at last, albeit just with the RTC, on every system I tried.  (That's
> using swsusp; and on the system where STR works, also STR.)

Both swsusp and STR work here.

> However:
> =

> > root@amd:~# sync; /tmp/rtcwake -s $((2 * 60)) -m disk
> > rtcwake: wakeup from "disk" using rtc0 at Sun Aug 27 16:54:49 2006
> > root@amd:~#
> =

> That's what it should look like -- with "date" immediately after rtcwake
> returns showing some time after 16:54.  That is, assuming your system
> can suspend in 2 minutes ... current versions of swsusp seem to take almo=
st
> that long to write snapshots for me, on two different systems with 1GB
> of RAM, so I've taken to doing "-m disk" tests with 5 minute sleeps.
> =

> So you're sure it didn't actually suspend, right?

It *did* suspend, but I had to wake it up manually using power button.

> > Any ideas? (I tried suspending to RAM, too; no change).
> =

> An updated rtcwake.c is appended, which is a bit pickier about noticing
> when the write to /sys/power/state fails ... the original code was lazy
> and used fwrite(), which isn't as good about fault reporting.

No, machine actually suspends okay, it just does not wake up :-(.

>  (I'll just
> assume STR works properly on your system -- a pleasant rarity!)

Yes, it works for me, and if you install code from suspend.sf.net, it
will work for you, too :-) [probably, we have 90% or so success rate].

> There could also be BIOS issues; folk keep mentioning issues that are
> specific to the x60.  Make sure you didn't disable RTC wake there,
> and that the RTC reported something like
> =

>   rtc-acpi 00:06: AT compatible RTC (S4wake) (y3k), 1 year alarm

It says:

rtc-acpi 00:07: AT compatible RTC (S4wake) (y3k), 1 month alarm

> at boot time ... if it doesn't report S4 wake capability, or you're
> not actually using S4, I'd expect rtc wakeup wouldn't work except
> from "real" suspend states (S1/standby, S3/STR).


...but I'm not sure if I was using right swsusp mode (platform
vs. shutdown).

Thanks for help,
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
