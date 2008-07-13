From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sun, 13 Jul 2008 10:56:03 +0200
Message-ID: <20080713085603.GB6890__18631.1165489771$1215939537$gmane$org@elf.ucw.cz>
References: <200807010148.02135.rjw@sisk.pl> <200807122253.32382.rjw@sisk.pl>
	<48793A0E.3050803@myrealbox.com> <200807130133.12324.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807130133.12324.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Is there an Intel graphics in your box?
> > 
> > Yes.
> > 
> > > 
> > >> -rc8 and -rc9 with the original patch 4b4f7280 resume fine no matter how 
> > >> I suspend.
> > > 
> > > That's _really_ strange.
> > > 
> > > In fact I have only one explanation, which is that the Gnome suspend button
> > > causes some user-space quirks to be applied, which are harmful and break the
> > > resume.  Also, without commit 4b4f7280 those quirks might have not been really
> > > executed.  Peter, does it sound reasonable?
> > 
> > Bingo.  It's a HAL quirk.
> > 
> > Testing from the console (not X):
> > 
> > With 4b4f7280:
> > # echo mem >/sys/power/state -- works fine
> > 
> > # echo 3 >/proc/sys/kernel/acpi_video_flags
> > # echo mem >/sys/power state -- fails to resume
> > 
> > Without 4b4f7280:
> > # echo mem >/sys/power/state -- works fine
> > 
> > # echo 3 >/proc/sys/kernel/acpi_video_flags
> > # echo mem >/sys/power state -- works fine
> > 
> > So HAL contains an apparently unnecessary quirk for my laptop, and 
> > 4b4f7280 breaks that quirk.  Of course, it's entirely possible that 
> > 4b4f7280 is 100% correct, but that the quirk only worked by accident and 
> > 4b4f7280 broke the call into video BIOS.
> 
> We've had reports from users of Intel graphics and the i915 driver that
> previously working quirks started to break their systems with 2.6.26-rc, but
> instead the plain "echo mem > /sys/power/state" started to work for them.
> Your system may be one of these, but I wonder what the effect of commit
> 4b4f7280 is.

In such case, you could verify by disabling intel framebuffer and just
using plain VGA driver (or vesafb).

Breaking video bios calls would be bad.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
