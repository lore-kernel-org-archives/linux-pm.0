From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 11:31:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606160704.34093.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, David Brownell wrote:
> =

> It's not so different from what Linus has been sketching, except
> for the actual turn-off-DMA step.  (Needed because you want to get
> an atomic snapshot.)  In terms of $SUBJECT the gain is that you
> actually get a debuggable suspend sequence.

Actually, if the _only_ thing STD wants to do, why not just have a

	->freeze(dev)
	->unfreeze(dev)

call-in?

In almost all cases, non-motherboard devices could just do nothing at all, =

and actual chip devices would _literally_ only just a engine stop for the =

PCI device.

The thing is, if you don't actally want to suspend, just freeze the thing =

_temporarily_, you can do that so so so much easier than actually =

suspending.

For UHCI, I think a "freeze" is basically two lines:

 - write "stop" command to command register (actually, it's "clear the run =

   bit" or something)
 - wait for a microsecond to guarantee that the engine actually stopped =

   (I think it will run to completion for whatever queue entry it's =

   working on, and poll the stop bit only in between).

ie I think it's literally an "outl()" followed by a "udelay()", and there =

is basically _zero_ room for problems. The "unfreeze" is then just =

setting the "run controller" bit again.

(Ok, so it's been about five years since I did anything with UHCI, and the =

USB stack has changed radically since, so my memory may be bad).

In other words, if you really just want to stop the devices in order to do =

a memory snapshot, doing a "suspend" + "resume" is _way_way_way_ overkill, =

and really really fragile because it is so much more complicated. A simple =

"stop" and "continue" is for a lot of PCI devices a total no-op, and for =

others it's literally a matter of setting a stop bit or similar.

IOW, USB, which usually is the "device from hell" in this kind of setting, =

can basically do both the stop and resume in one single machine =

instruction!

So if you're using "suspend/resume" to actually just copy a static image, =

you're really doing silly things.

		Linus
