From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 10:32:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906121027300.2915-100000__33754.9227093861$1244817228$gmane$org@iolanthe.rowland.org>
References: <200906121015.19504.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906121015.19504.oliver@neukum.org>
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

On Fri, 12 Jun 2009, Oliver Neukum wrote:

> Am Freitag, 12. Juni 2009 04:16:10 schrieb Alan Stern:
> > What tree constraint? =A0You mean that the PM core shouldn't allow
> > devices to suspend unless all their children are suspended? =A0Why
> > doesn't it still apply?
> =

> Because the hardware doesn't need it.

But maybe drivers need it.

> > Remember, when Rafael and I say "suspend" here, we don't mean "go to a
> > low-power state". =A0We mean "the PM core calls the runtime_suspend
> > method". =A0No matter what actions the link hardware may decide to take
> > on its own, the PM core will still want to observe the
> > all-children-suspended restriction when calling runtime_suspend
> > methods.
> =

> No. The core if it insists all children be suspended will not use
> the hardware's full capabilities.

That isn't what I said.  The core does not insist that all children be =

suspended, i.e., be in a low-power state.  It insists only that the =

children's drivers' runtime_suspend methods have been called.  Those =

methods are not obligated to put the children in a low-power state.

> If it leaves such power saving measures to the drivers, latency
> accounting will be wrong.
> =

> > > I think there are devices who can be suspended while children are act=
ive
> > > and devices which can not be. This is an attribute of the device and
> > > should be evaluated by the core.
> >
> > Clearly it should be decided by the driver. =A0Should there be a bit for
> > it in the dev_pm_info structure?
> =

> Yes.

That would resolve the issue.

Alan Stern
