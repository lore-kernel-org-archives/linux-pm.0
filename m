From: David Brownell <david-b@pacbell.net>
Subject: Re: waking system up using RTC (was Re: rtcwakeup.c)
Date: Sat, 26 Aug 2006 17:04:04 -0700
Message-ID: <200608261704.05017.david-b@pacbell.net>
References: <20060725124941.GD5034@ucw.cz>
	<200608261415.33353.david-b@pacbell.net>
	<20060826214342.GB3784@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060826214342.GB3784@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 26 August 2006 2:43 pm, Pavel Machek wrote:
> Hi!
> =

> > > Your new RTC driver seems to work for me (thinkpad x60), but no, I
> > > can't get wakeup using RTC to work:
> > =

> > Does it work using /proc/acpi/alarm?  In my experience, ACPI wakeup
> > doesn't work on Linux ... hence my pleasant surprise to see it work
> =

> No, I could not get it working using /proc/acpi/alarm.

Then I suspect that's the root cause of your problem ... ACPI code,
in either Linux or your BIOS, is not sufficiently cooperative.  All
that the rtc-acpi driver does is move the wakeup code, it doesn't
actually change what the /proc/acpi/alarm stuff does.


> No, machine actually suspends okay, it just does not wake up :-(.

The usual ACPI wakeup symptoms I've seen are the hardware giving the
signal, system starting to wake up, then botching somewhere early in
the resum.  So I suspect you're not actually getting the hardware
wakeup signal ... as if maybe it wasn't set up correctly.

You may be able to tell your BIOS to do the alarm by itself, and
then test to see whether Linux handles the wakeup side OK.


> rtc-acpi 00:07: AT compatible RTC (S4wake) (y3k), 1 month alarm

Seems like Intel's chips won't do one year alarms ... so sad.  :)

- Dave
