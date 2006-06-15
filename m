From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 02:00:21 +0200
Message-ID: <20060615000021.GB24859@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The irq9 one is really irritating (hey, ACPI almost always is). I tho=
ught =

> > > it would be something as simple as the wrong polarity or something, b=
ut =

> > > nope..
> > =

> > BTW what is wrong with mac mini? I asked original reporter to boot
> > noacpi and nosmp, and he told me it will not boot in any of those
> > cases. At that point I basically called that machine terminally
> > broken. Is it supposed to be PC-compatible?
> =

> It's _not_ supposed to be PC-compatible. It just happens to be close =

> enough that we can ignore the differences.

Aha, okay. So it basically needs special config to work, and
complaining that it does not boot noapic is not helpful.

> And btw, the reason it didn't resume originally was because _we_ did =

> things wrong. The PCI command word mustn't be writen before the rest of =

> the config space has been restored (one of the things I used my debugging =

> patches for, until I noticed that -mm had the same fix independently, so =

> that's the one that is merged right now ;)

Yes, right, this was Linux's fault.

> The fact is, Linux suspend/resume to RAM has been broken for as long as I =

> can remember. I finally got fed up, and started debugging it. Unlike =

> laptops (which I only use when travelling), I hope to make a MacMini like =

> system my main one (well, I'm going to wait for Conroe/Merom, and the =

> current one goes to Patricia or Tove, but the point is that small is =

> beautiful, and that machine is one of the few desktops I know is supposed =

> to do STR fine, and where it makes sense to do so).

Actually s2ram used to work for quite long time... with video needing
userspace hacks. Just some compaq evos are problematic :-) [acpi
problems, and firmware has definitely some problems, too]. Thinkpads
tend to be rather good. (suspend.sf.net has video parts.)
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
