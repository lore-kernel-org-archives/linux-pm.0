From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Mon, 14 Jul 2008 08:14:30 +0200
Message-ID: <20080714061429.GF20258__7045.02793164483$1216016141$gmane$org@elf.ucw.cz>
References: <200807122253.32382.rjw@sisk.pl> <48793A0E.3050803@myrealbox.com>
	<200807130133.12324.rjw@sisk.pl> <20080713091524.GA29907@elte.hu>
	<20080713120253.GA27582@srcf.ucam.org>
	<487A2431.2050103@myrealbox.com>
	<487A4CB7.1080001@firstfloor.org> <487A62B3.8010207@zytor.com>
	<487A63D2.9040006@firstfloor.org>
	<20080714012206.GA11882@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080714012206.GA11882@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andy Lutomirski <luto@myrealbox.com>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-07-13 22:22:06, Henrique de Moraes Holschuh wrote:
> On Sun, 13 Jul 2008, Andi Kleen wrote:
> > It probably switches to protected mode. I noticed this on my old
> > Fujitsu laptop when I tried to make the S3 wakeup run in the s2ram x86 emulator
> > and found it entered protected mode at some point, which x86emu
> > didn't support.
> > 
> > I guess Lenovo is doing the same.
> > 
> > And that protected mode code relies on some GDT values that have been
> > loaded earlier when the BIOS also went into protected mode.
> > 
> > It seems the BIOS programmers really don't like real mode anymore.
> > Somehow understandable.
> 
> If it were just Lenovo, it shouldn't be too difficult to get them to fix the
> BIOS.  But since other vendors have the same problem, that won't fly as a
> solution.

With all the BIOSes in field, practically impossible to update? (My
x60 has no CDrom..) No, I don't think we can expect fix from BIOS vendors.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
