From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 11:15:37 +1000
Message-ID: <1150420537.7725.66.camel@localhost.localdomain>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
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
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



> There's no driver infrastructure to call down to the driver to say "save =

> your state, but don't suspend". None. Zero. Nada. Zip.

 ..../...

> The include files talk about PM_FREEZE, but that's a load of crap. The =

> whole point is to _not_ freeze things, so that you can still access the =

> device and save your disk image or your printk messages to it. It also =

> seems designed to _either_ "freeze" the machine or "suspend" the machine, =

> but not both.
> =

> In other words, it's misdesigned. And I've talked about this before. Ijus=
t =

> googled for it, and I saw myself ranting about this very same issue a yea=
r =

> ago (and back then, I also said "as I've said before").

It can't work. Unfortunately.

You can't save a consistent system image if your drivers aren't all
stopped and DMA is stopped. Save state and freeze have to be atomic to
each other or your system image is simply not consistent (and good luck
with resuming).

Of course, we don't need to actually _shut_down_ devices, we only need
to stop drivers, but in some cases, the only way to stop DMA is to
atually stop the device... thus the blurry situation between device and
driver suspending.

Also, you cannot do a full system 2 pass callback mecanism (as much as I
would have liked it) of the sort save state and then suspend because of
the above: since save state has to stop processing of requests on all
drivers in order to provide a consistent system image, by the time you
reach your shutdown/suspend() callback pass, you can't talk to your
actual hardware anymore because your parent driver is ... frozen.

Example is USB for example: to save a consistent state, the USB host
controller must stop DMA processing (for both STD and kexec). But that
means it can't process requests. Thus child drivers can't communicate
with their device. Thus the second pass "suspend/shutdown" will not be
able to communicate with the various hardware to put them in actual
suspend state.

Ben.
