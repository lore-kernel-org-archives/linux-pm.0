From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 11:53:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606161144210.5754-100000@iolanthe.rowland.org>
References: <20060616140335.GG1666@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060616140335.GG1666@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 16 Jun 2006, Pavel Machek wrote:

> > You don't _need_ to save a consistent system image. There's no "single =

> > snapshot in time" needed.
> =

> Maybe I do not _need_ consistent system image, but I _can_ get
> consistent system image -- we are getting it today -- and it makes it
> _way_ easier to think about.
> =

> > > Example is USB for example: to save a consistent state, the USB host
> > > controller must stop DMA processing (for both STD and kexec). But that
> > > means it can't process requests.
> > =

> > No. It means no such thing. It just means that trying to save a total =

> > snapshot is insane and fundamentally impossible.
> =

> Why? I can stop USB controller, snapshot, restart USB controller,
> write image to USB harddrive, stop USB controller, power down. That's
> how it works. It is not insane, and it is certainly not impossible.
> =

> I do not want driver authors to think about "oh this is temporary data
> structure". If you debug drivers with suspend to RAM, I can just reuse
> that work for suspend to DISK -- *because* image is atomic. I'll
> probably want to do some modifications (like do not unneccessarily
> spin disks down), but modulo speed, suspend to RAM infrastructure
> should work for swsusp.

I agree with Pavel.  The difficulties of dealing with a non-atomic memory =

image are larger than one might first think.

Suppose that drivers are actively running while the snapshot is made.  To
take just one example, consider that there will be tasks sitting on wait
queues, expecting to be woken up by some signaller.  What happens when the
snapshot contains an image of the task's kernel stack still waiting on the
queue and also contains an image of the signaller believing the queue has
already been woken up?

Lots of events in the kernel depend on one piece of code talking to =

another.  If this communication is distorted by going through a non-atomic =

snapshot, nothing will work right.

Alan Stern
