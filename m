From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Mon, 24 Jul 2006 10:11:14 -0700
Message-ID: <200607241011.15325.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607241128460.6638-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607241128460.6638-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 24 July 2006 8:42 am, Alan Stern wrote:
> =

> What I wrote wasn't necessarily intended to be different from what the
> methods mean today.  But it _is_ different from what people tend to think.
> =

> It's very natural for someone to imagine that suspend() means "Suspend
> your device" (i.e., put it in a low-power state) and resume() means
> "Resume your device" (i.e., change it to full-power).  But the real
> emphasis is different; people need to know that suspend() actually means
> "The _system_ is going to suspend" and resume() means "The _system_ is
> resuming".

Good point.  I'll tweak the text to make that more explicit.  We're in
agreement it seems, and that was already written up ... but not in what
I suspect is the best place for such points.



> > > These meanings may not be entirely consistent with the way the PM core
> > > works now,
> > =

> > I don't believe any semantic change is being discussed here.
> =

> There is.  Right now suspend_device() won't call the bus's suspend method
> if dev->power.power_state.event is non-zero.  But since the purpose of the
> call is to inform the driver that the _system_ is going to suspend, the
> call should be made regardless of the _device's_ state (which the core
> shouldn't be concerned with anyway).

OK, _now_ we're discussing a semantic change.  ;)

I've added dev->power.power_state to the "this is deprecated" text, along
with the sysfs power/state file.  IMO we can't realistically make that chan=
ge
(removing the "is it nonzero" test) so long as the sysfs mechanism exists.


> > Considering how few drivers use dev->power.power_state, it's easier to
> > say the problem is in the ones that use it  ... rather than the ones th=
at
> > ignore it and act as I've described above! :)
> =

> I don't know to what extent there are problems in the drivers.  Not much, =

> hopefully.  The real problem lies in the core.

Yes the core has the problem, but drivers referencing power_state is the
workaround for that problem.

Once the sysfs mechanism goes away, there won't be much need for the mechan=
ism.
Only callers to dpm_runtime_*() would trigger any of the troublesome paths.
The two callers are USB and PCMCIA, and I'm not sure they really need the e=
xtra
lock that's grabbed by the dpm_runtime_*() calls if there's no need to prot=
ect
against that sysfs mechanism.

- Dave
