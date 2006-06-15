From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 19:51:22 +0200
Message-ID: <20060615175122.GF23859@elf.ucw.cz>
References: <1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
	<20060615165909.GE23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151035320.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151035320.5498@g5.osdl.org>
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

> > To have DMAs stopped, you need to "freeze" the devices.
> =

> No you don't. =

> =

> You need to stop the high-level _queues_, but that's something totally =

> different from actually stopping the _devices_.

Well, I believe you need the low-level devices, too. Even with
high-level queues stopped, drivers may still do some DMA. (USB is the
example, as is network receiving packet).

> But that's fundamental: and it has absolutely zero to do with device =

> suspend (although you do want to tell the device about it - a number of =

> devices that do polling even in the absense of user input should probably =

> take the hint from "save your state").

Heh, yes, that's what we are doing :-). FREEZE tells devices to stop
DMA and save state. It is just... most devices tend to implement
FREEZE and SUSPEND with some code; and because SUSPEND implies
stopping DMA (plus some powersaving), it is actually okay (but slower
than it could be).

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
