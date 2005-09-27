From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Tue, 27 Sep 2005 15:02:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
References: <20050927122633.GA9339@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74681648888681851=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050927122633.GA9339@openzaurus.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============74681648888681851==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Sep 2005, Pavel Machek wrote:

> Hi!
> 
> > A problem with the PM_FREEZE state has surfaced recently.
> > 
> > It has to do with the device state recorded in the memory image.  When the 
> > image is made, devices are in the FREEZE state, and that's what gets 
> > recorded.  But then the image is written to disk and devices are put into 
> > SUSPEND.
> > 
> > Later on, when the system wakes up and the image is restored, drivers are 
> > asked to resume the devices.  The problem is that now the drivers think 
> > the devices are in FREEZE when in fact they are really in SUSPEND.  The 
> > difference is significant and it can cause errors in the resume procedure.
> 
> No; devices are in FREEZE if their driver was in kernel, and in some kind
> of power up state when not. Drivers should just handle both.

For USB, that "some kind of power up state" will in fact be SUSPEND.

Drivers should just handle both -- how?  Do a full resume in either case?  
Doesn't that go against the whole idea of FREEZE, that it could be 
implemented without some of the overhead of SUSPEND?

Well, I guess the FREEZE transition could still avoid that overhead.  But
the RESUME-from-FREEZE transition ought to be able to avoid it also, and
you've just shown that it can't afford to.


> > Here's another, slightly more far-fetched problem.  I don't know if this 
> > can come up in actual practice.
> > 
> > When a disk device is put in FREEZE, there may be pending write requests
> > in its I/O queue.  After the image has been 
> Can they? If so, we need to solve that somehow.

I don't know.  It depends on how the disk driver implements FREEZE.  Does 
it drain the queue, or does it merely plug the queue?

> ...it might happen with network devices, too. We would send packet twice.
> We should limit queueing in drivers across FREEZE...

Exactly.  But remember that those queues _need_ to be used in order to 
write out the memory image.

Alan Stern


--===============74681648888681851==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============74681648888681851==--
