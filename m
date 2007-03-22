From: Pavel Machek <pavel@ucw.cz>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Thu, 22 Mar 2007 15:03:05 +0100
Message-ID: <20070322140305.GC7693@elf.ucw.cz>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<acd2a5930703220641p6bd02f5dk433232093a331772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <acd2a5930703220641p6bd02f5dk433232093a331772@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-03-22 16:41:40, Vitaly Wool wrote:
> On 3/22/07, Pavel Machek <pavel@ucw.cz> wrote:
> >Hi!
> >
> >> > No, once SOFTWARE_SUSPEND is configured there's *no way* to disable =
it
> >> > after the fact via pm_ops. Read valid_state() in kernel/power/main.c.
> >>
> >> So how does a platform with only flash (and an insufficient amount of
> >> flash at that) tell the suspend code that suspend-to-disk is not
> >> supported?
> >
> >Hohum, perhaps it can suspend to SD card? Or perhaps it can suspend
> >over network?
> =

> Cool, imagine your MP3 player suspending over network... Or suspending
> to SD card and switching off in the middle of the process leaving the
> SD card filesystem broken. Congratulations, you've bought a nice
> device...

Then why did you ask it to suspend, and why did its manufacturer
enable SOFTWARE_SUSPEND?

Unix lets you shoot yourself into the foot. If you do not like that,
go use something else.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
