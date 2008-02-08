From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [rft] s2ram wakeup moves to .c,
	could fix few machines
Date: Fri, 8 Feb 2008 23:41:57 +0200
Message-ID: <200802082341.58107.maximlevitsky@gmail.com>
References: <20080205190600.GB11613@elf.ucw.cz>
	<200802072340.06138.rjw@sisk.pl>
	<20080208211346.GC12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080208211346.GC12923@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 8 February 2008 23:13:46 Pavel Machek wrote:
> Hi!
> 
> > > Can you post a delta against my versoin? I do not see any changes from
> > > a quick glance.
> > 
> > Appended (plus I removed two hunks, one in arch/x86/Makefile and one in
> > drivers/acpi/sleep/main.c that were unrelated to the rest of the patch).
> 
> Thanks, applied.
> 
> > > This is probably more acceptable version of beep; but there are
> > > probably even better ways to clean it...
> > > 
> > >         if (wakeup_header.realmode_flags & 4) {
> > >                 inb(97);
> > >                 outb(0, 0x80);
> > >                 outb(3, 97);
> > >                 outb(0, 0x80);
> > >                 outb(-74, 67);
> > >                 outb(0, 0x80);
> > >                 outb(-119, 66);
> > >                 outb(0, 0x80);
> > >                 outb(15, 66);
> > >         }
> > > 
> > > ...like the version that makes beep/pause/beep/pause, so that user can
> > > count them.
> > 
> > Can we move it into a separate function?
> 
> I guess we want to use HPA's morse code ;-).
> 									Pavel

Seriously, why not...
For decades BIOSes have used sound beeps to tell the user about a early problem
that happened have before video is initialized.

Maybe not a long messages using morse code, but at least
you can have several messages to tell the user about different problems in the boot code

like

two short beeps for an oops
1 short beep for normal resume (so the user will know that the video is to blame)

and so on.

I don't know morse code, but I probably would have learn it.
Once I had very nasty problem with resume, a hang, but only sometimes,
and I had to play with rtc to debug it, and still I couldn't figure out
what was wrong.

Fortunately, this problem disappeared (was somehow fixed).
For reference take a look at http://lkml.org/lkml/2007/3/17/155

I remember that I did about 1500 reboots to try to fix this.
(According to hard disk's 'smart' statistics)



Suggestion: the speaker usually is quite loud, thus it can be annoying to use
for morse code or so.
Why not to use keyboard leds for this purpose?
(USB keyboard probably isn't an option, but user can always pull an old PC keyboard
out of closet, and use it)


Best regards,
	Maxim Levitsky
