From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 22:16:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906112210340.21931-100000__757.361905607645$1244773035$gmane$org@netrider.rowland.org>
References: <200906112305.49232.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906112305.49232.oliver@neukum.org>
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

> Am Donnerstag, 11. Juni 2009 20:36:30 schrieb Alan Stern:
> > > Or abstractly any power saving state that does autoresume in hardware.
> > > In these cases you know that you can enter a powersaving state that
> > > will add X latency.
> > >
> > > In terms of user space API we'll probably add a way for user space
> > > to specify how much latency may be added for power management's sake.
> > > If busses are stacked the "latency budget" has to be handled at core
> > > level. If furthermore states that allow IO but with additional latency
> > > are ignored, the budget will be calculated wrongly.
> >
> > Okay, fine. =A0What does this have to do with Rafael's work? =A0Why does
> > setting the status to RPM_SUSPENDED even when a device is not in a
> > low-power state preclude handling buses that automatically change their
> > power state?
> =

> For these cases the tree constraint does not apply.

What tree constraint?  You mean that the PM core shouldn't allow =

devices to suspend unless all their children are suspended?  Why =

doesn't it still apply?

Remember, when Rafael and I say "suspend" here, we don't mean "go to a =

low-power state".  We mean "the PM core calls the runtime_suspend =

method".  No matter what actions the link hardware may decide to take =

on its own, the PM core will still want to observe the =

all-children-suspended restriction when calling runtime_suspend =

methods.

> I think there are devices who can be suspended while children are active
> and devices which can not be. This is an attribute of the device and shou=
ld
> be evaluated by the core.

Clearly it should be decided by the driver.  Should there be a bit for
it in the dev_pm_info structure?

Alan Stern
