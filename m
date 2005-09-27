From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Tue, 27 Sep 2005 21:58:33 +0200
Message-ID: <20050927195833.GA2040@elf.ucw.cz>
References: <20050927122633.GA9339@openzaurus.ucw.cz>
	<Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16456239618309576=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509271455140.636-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============16456239618309576==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Later on, when the system wakes up and the image is restored, drivers are 
> > > asked to resume the devices.  The problem is that now the drivers think 
> > > the devices are in FREEZE when in fact they are really in SUSPEND.  The 
> > > difference is significant and it can cause errors in the resume procedure.
> > 
> > No; devices are in FREEZE if their driver was in kernel, and in some kind
> > of power up state when not. Drivers should just handle both.
> 
> For USB, that "some kind of power up state" will in fact be SUSPEND.
> 
> Drivers should just handle both -- how?  Do a full resume in either case?  
> Doesn't that go against the whole idea of FREEZE, that it could be 
> implemented without some of the overhead of SUSPEND?
> 
> Well, I guess the FREEZE transition could still avoid that overhead.  But
> the RESUME-from-FREEZE transition ought to be able to avoid it also, and
> you've just shown that it can't afford to.

We can add a hint to pm_message_t. But for "full resume", we really
don't know if devices are only FROZEN or if they need full reinit.

So you may get info "only frozen" and "maybe frozen, maybe it was
powered down"; if you think that helps the drivers, just add a field
to pm_message_t (flags), and add this as a first flag.

> > > Here's another, slightly more far-fetched problem.  I don't know if this 
> > > can come up in actual practice.
> > > 
> > > When a disk device is put in FREEZE, there may be pending write requests
> > > in its I/O queue.  After the image has been 
> > Can they? If so, we need to solve that somehow.
> 
> I don't know.  It depends on how the disk driver implements FREEZE.  Does 
> it drain the queue, or does it merely plug the queue?

...actually it does not matter for disk driver, because two writes
with same data are harmless. It may still matter for network (repeated
packets).
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============16456239618309576==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16456239618309576==--
