From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 14:36:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906111433110.4875-100000__18591.4750713438$1244745533$gmane$org@iolanthe.rowland.org>
References: <200906111805.53388.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906111805.53388.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Jun 2009, Oliver Neukum wrote:

> Am Donnerstag, 11. Juni 2009 17:22:06 schrieb Alan Stern:
> > > > Okay, I'll agree to that. =A0It should be made clear that a device =
which
> > > > is "suspended" according to this definition is not necessarily in a
> > > > low-power state. =A0For example, before powering down the link to a=
 disk
> > > > drive you might want the drive's suspend method to flush the drive's
> > > > cache, but it wouldn't have to spin the drive down.
> > >
> > > This precludes handling busses that have low power states that are
> > > left automatically. If such links are stacked the management of
> > > acceptable latencies cannot be left to the busses.
> > > An actual example are the link states of USB 3.0
> >
> > I don't understand. =A0Can you explain more fully?
> =

> I am talking about the U1 and U2 feature of USB 3.0.
> =

> Or abstractly any power saving state that does autoresume in hardware.
> In these cases you know that you can enter a powersaving state that
> will add X latency.
> =

> In terms of user space API we'll probably add a way for user space
> to specify how much latency may be added for power management's sake.
> If busses are stacked the "latency budget" has to be handled at core leve=
l.
> If furthermore states that allow IO but with additional latency are ignor=
ed,
> the budget will be calculated wrongly.

Okay, fine.  What does this have to do with Rafael's work?  Why does =

setting the status to RPM_SUSPENDED even when a device is not in a =

low-power state preclude handling buses that automatically change their =

power state?

I don't see any connection between Rafael's work and managing
latencies, beyond the obvious fact that a device will have a higher
latency when it is suspended than when it isn't.

Alan Stern
