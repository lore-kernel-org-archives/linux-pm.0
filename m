From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 19:28:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151839440.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
	<1150420537.7725.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150420537.7725.66.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> You can't save a consistent system image if your drivers aren't all
> stopped and DMA is stopped. =


Read the whole thread to an end.

You don't _need_ to save a consistent system image. There's no "single =

snapshot in time" needed.

The only thing needed is to save a _workign_ system image, and that's very =

different.

> Example is USB for example: to save a consistent state, the USB host
> controller must stop DMA processing (for both STD and kexec). But that
> means it can't process requests.

No. It means no such thing. It just means that trying to save a total =

snapshot is insane and fundamentally impossible.

Instead, you save a snapshot of the stuff you care about afterwards. All =

the while realizing that when you resume, you cannot rely on any temporary =

data structures (that did get saved off - because trying to teach the STD =

logic the meaning of all memory is obviously _also_ insane) in the =

drivers.

But you have a perfect callback for that. It's called the "resume" part. =

The driver _knows_ which parts of its data it changes on its own as part =

of normal operation, and it re-creates those parts rather than depend on =

them being saved away atomically, since doing it atomically is =

_impossible_.

Why can't people accept that simple statement? If you give up on doing the =

impossible, suddenly everything else becomes much easier. Don't work so =

hard at doing something that must not be done in the first place!

			Linus
