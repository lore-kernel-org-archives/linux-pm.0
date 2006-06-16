From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 11:09:06 +1000
Message-ID: <1150420147.7725.59.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
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
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-06-15 at 10:41 -0700, Linus Torvalds wrote:
> =

> On Thu, 15 Jun 2006, Pavel Machek wrote:
> > =

> > To have DMAs stopped, you need to "freeze" the devices.
> =

> No you don't. =

> =

> You need to stop the high-level _queues_, but that's something totally =

> different from actually stopping the _devices_.

Well, a bit of both in fact. USB controllers for example tend to
continuously DMA even when there is nothing to process... That must be
stopped.

But yeah, essentially, when I defined the freeze state back then, I
defined it as a driver state, not a device state. It's driver freeze.
Though it's up to the driver to make sure the device is quiescent. DMA
is deadly not only for STD but for kexec as well.

> So, for example, you want to make sure that nobody is writing to the disk =

> cache, or reading from the disk, or writing to it (apart from the thing =

> that writes the image, of course) any more.

Yup, and that's why I implemented old IDE suspend as a special reuquest
down the queue that blocks the queue processing when it reaches the
disk. By being a barrier type request, it allows proper synchronisation
with pending IOs and makes sure the queue is frozen. Resume is then
implemented as another special request that gets injected at the head of
the queue (using the same mecanism used for things like request sense on
error) and that unblocks it.

> But that's fundamental: and it has absolutely zero to do with device =

> suspend (although you do want to tell the device about it - a number of =

> devices that do polling even in the absense of user input should probably =

> take the hint from "save your state").

Well, it's not about suspending the devices, but it is also about making
sure the controller doesn't does random DMA, and as I mentioned above,
the fine line is a bit blurry with some bits of hardware.
 =

> The fact that you equate "suspend the devices" with "stop doing IO" shows =

> how you think at the wrong level.
> =

> The "stop doing IO" is at a much higher level.

Yes, though both are involved in the suspend process and can't be
separated completely due to the dependency between devices in the bus
hierarchy.

Ben.
