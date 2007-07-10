From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Tue, 10 Jul 2007 09:51:03 -0700
Message-ID: <200707100951.04193.david-b__47292.9441756152$1184086543$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707090926.32826.david-b@pacbell.net>
	<200707101245.31449.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707101245.31449.nigel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Monday 09 July 2007, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 10 July 2007 02:26:32 David Brownell wrote:
> > On Monday 09 July 2007, Marcelo Tosatti wrote:
> > > On Sun, Jul 08, 2007 at 07:44:03PM -0700, David Brownell wrote:
> > 
> > > > Better a /sys/power/wakeup_event (or whatever) that's more easily
> > > > found.  It could link to the device issuing the event.
> > > 
> > > As you mentioned, there might be two wakeup sources (RTC and power
> > > button for instance) or even more at the same time.
> > 
> > Actually I though I said that there would be races.  Though come
> > to think of it, one way they'd show up on a typical embedded system
> > would be to have multiple wake IRQs pending ... you couldn't tell
> > which one came first.  (The typical case would be a single event,
> > of course.)  ACPI-ish systems would do that with GPEs and the
> > magic "rtc woke" flag.
> > 
> > And then there are shared IRQ lines serving as wake sources.  There
> > could be three wake-enabled devices on that line (plus others that
> > aren't wake-enabled); the drivers returning IRQ_HANDLED should likely
> > be reported as having been wake sources, but not the ones returning
> > IRQ_NONE ...
> > 
> > ... so yes, systems might need to present multiple wake events.
> > 
> > 
> > > Do you think its fine to simply but the device separated by spaces in
> > > the wakeup_event file?
> > > 
> > > Sounds fine by me, but what about the one-value-per-file sysfs rule?
> > 
> > Better to have that node be a directory of links then, rather than
> > a single link.
> > 
> > Note that I'm just throwing ideas out there.  I suspect that
> > in the general case it may not be easy to map from wake event
> > to device, without infrastructure that's now missing.
> 
> FWIW, I've recently added code to Suspend2 to allow it to (optionally) set the 
> RTC wake alarm when it's finished writing the image and check the lid switch 
> when waking, entering a different sleep state if the lid switch is still 
> closed. It achieves this by letting the user set the name of an rtc alarm to 
> use (the 'rtc0' in /sys/class/rtc/rtc0/*) and of a button to use (lid/LID 
> in /proc/acpi/button/lid/LID/*). It then opens the button directory's state 
> file and the rtc directory's since_epoch and wakealarm files, and uses them 
> to determine read the time since epoch and set the wakealarm and determine 
> whether the lid button is still closed.

Interesting...

> I don't really like the opening /proc and /sysfs files in this way - whatever 
> solution you come up with, could you consider exposing some way for kernel 
> code to do this more neatly?

You're supposed to be able to use /sys/... files this way!

But that's not true of /proc/... files.

- Dave
