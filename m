From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 21 Dec 2009 10:01:47 +0100
Message-ID: <20091221090147.GA1405__28244.4641380154$1261386262$gmane$org@ucw.cz>
References: <200912060254.10081.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206113555.5a646713@infradead.org>
	<alpine.LFD.2.00.0912061144100.3560@localhost.localdomain>
	<20091206121803.70385c33@infradead.org>
	<7AB497C7-8495-4535-9E83-81307E008BF4@gmail.com>
	<20091206165551.2529075f@infradead.org>
	<20091207022756.GB20770@core.coreip.homeip.net>
	<20091206212600.44806308@infradead.org>
	<20091207060053.GA21451@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091207060053.GA21451@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2009-12-06 22:00:53, Dmitry Torokhov wrote:
> On Sun, Dec 06, 2009 at 09:26:00PM -0800, Arjan van de Ven wrote:
> > On Sun, 6 Dec 2009 18:27:56 -0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > > On Sun, Dec 06, 2009 at 04:55:51PM -0800, Arjan van de Ven wrote:
> > > > On Sun, 6 Dec 2009 14:54:48 -0800
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > 
> > > > > > isn't serio the PS/2 stuff?
> > > > > 
> > > > > Yes, that's your PS/2 mouse (rather touchpad) and the delay comes
> > > > > from device reset (needed by some keyboard controllers - I
> > > > > remember HP -or it and keyboard will be dead at resume).
> > > > 
> > > > and I have a HP laptop... so this makes perfect sense.
> > > > Thanks for the explenation!
> > > > 
> > > 
> > > Well, we do it for everyone, it's just a particular series of HPs
> > > forced us to add it.
> > > 
> > wonder if it should be a DMI based quirk instead...
> > 
> 
> I have not received reports where it causes harm or reduces
> functionality so I'd prefer having it by default and not try to race
> with manufacturers.

Well, it slows down everyone... and people are actually testing with
linux, so it makes this problem more common on new systems.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
