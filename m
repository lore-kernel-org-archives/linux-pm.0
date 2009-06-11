From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 11:22:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906111120260.3040-100000__42231.3053197742$1244733781$gmane$org@iolanthe.rowland.org>
References: <200906111706.16848.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906111706.16848.oliver@neukum.org>
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

> Am Donnerstag, 11. Juni 2009 16:52:03 schrieb Alan Stern:
> > > Under this definition all devices behind an inactive link are suspend=
ed,
> > > because they can't do any I/O. =A0Which appears to makes sense, becau=
se
> > > their drivers have to be notified before the link is suspended and the
> > > link has to be turned on for the devices to be able to communicate wi=
th
> > > the CPU and RAM.
> > >
> > > If this definition is adopted, then it's quite clear that the device =
can
> > > only be suspended if all of its children are suspended and it's always
> > > necessary to resume the parent of a device in order to resume the dev=
ice
> > > itself.
> >
> > Okay, I'll agree to that. =A0It should be made clear that a device which
> > is "suspended" according to this definition is not necessarily in a
> > low-power state. =A0For example, before powering down the link to a disk
> > drive you might want the drive's suspend method to flush the drive's
> > cache, but it wouldn't have to spin the drive down.
> =

> This precludes handling busses that have low power states that are
> left automatically. If such links are stacked the management of acceptable
> latencies cannot be left to the busses.
> An actual example are the link states of USB 3.0

I don't understand.  Can you explain more fully?

Alan Stern
