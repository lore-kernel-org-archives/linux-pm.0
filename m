From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 16:03:35 +0200
Message-ID: <20060616140335.GG1666@elf.ucw.cz>
References: <1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
	<1150420537.7725.66.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151839440.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151839440.5498@g5.osdl.org>
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

> > You can't save a consistent system image if your drivers aren't all
> > stopped and DMA is stopped. =

> =

> Read the whole thread to an end.
> =

> You don't _need_ to save a consistent system image. There's no "single =

> snapshot in time" needed.

Maybe I do not _need_ consistent system image, but I _can_ get
consistent system image -- we are getting it today -- and it makes it
_way_ easier to think about.

> > Example is USB for example: to save a consistent state, the USB host
> > controller must stop DMA processing (for both STD and kexec). But that
> > means it can't process requests.
> =

> No. It means no such thing. It just means that trying to save a total =

> snapshot is insane and fundamentally impossible.

Why? I can stop USB controller, snapshot, restart USB controller,
write image to USB harddrive, stop USB controller, power down. That's
how it works. It is not insane, and it is certainly not impossible.

I do not want driver authors to think about "oh this is temporary data
structure". If you debug drivers with suspend to RAM, I can just reuse
that work for suspend to DISK -- *because* image is atomic. I'll
probably want to do some modifications (like do not unneccessarily
spin disks down), but modulo speed, suspend to RAM infrastructure
should work for swsusp.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
